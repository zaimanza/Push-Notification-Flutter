import 'package:flutter/material.dart';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class LocalNotificationService{
  static final FlutterLocalNotificationsPlugin _notificationsPlugin = FlutterLocalNotificationsPlugin();

  static void initialize(BuildContext context){

    final InitializationSettings initializationSettings = InitializationSettings(
      android: AndroidInitializationSettings("@mipmap/ic_launcher"),
      iOS: IOSInitializationSettings(),
    );

    _notificationsPlugin.initialize(
      initializationSettings,
      onSelectNotification: (String? route) async {

        if(route != null){
          Navigator.of(context).pushNamed(route);
        }

      },
    );

  }

  static void display(RemoteMessage message) async {

   try{

     final id = DateTime.now().millisecondsSinceEpoch ~/1000;

     final NotificationDetails notificationDetails = NotificationDetails(
       android: AndroidNotificationDetails(
         "pushnotificationtutorial",
         "pushnotificationtutorial channel",
         "this is our channel",
         importance: Importance.max,
         priority: Priority.high,
       ),
       iOS: IOSNotificationDetails(),
     );

     await _notificationsPlugin.show(
       id,
       message.notification!.title,
       message.notification!.body,
       notificationDetails,
       payload: message.data["pageRoute"],
     );

   } on Exception catch (e) {
     print(e);
   }

  }

}