import 'dart:io';

import 'package:band_names/models/band.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class HomePage extends StatefulWidget{
  @override
  _HomePageState createState()=> _HomePageState();

}

class _HomePageState extends State<HomePage>{

  List<Band> bands = [
    Band(id:'1', name: 'Bobote', votes: 5),
    Band(id:'2', name: 'Mmg', votes: 35),
    Band(id:'3', name: 'King kong', votes: 45),
    Band(id:'4', name: 'Bebsita', votes: 15),
    Band(id:'5', name: 'Nepe', votes: 25),
  ];

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text('Bands Names', style: TextStyle(color: Colors.black87),),
        backgroundColor: Colors.white,
        elevation: 1,
      ),

      body:ListView.builder(
        itemCount: bands.length,
        itemBuilder: (BuildContext context, int index) =>_bandTitle(bands[index])
        
      ),

      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        elevation: 1,
        onPressed:addNewBand 
        ),
    );
  }

  addNewBand(){

    final textcontroller = TextEditingController();
    if(Platform.isAndroid){
      return showDialog(
        context: context, 
        builder: (context){
          return AlertDialog(
            title: const Text('New Band Name'),
            content: TextField(
              controller: textcontroller,
            ),
            actions: [
              MaterialButton(
                elevation: 5,
                child: Text('Add'),
                textColor: Colors.blue,
                onPressed: ()=>addBandToList(textcontroller.text)
              )
            ],
          );
        }
      );
    }


    showCupertinoDialog(
      context: context, 
      builder: (context){
        return CupertinoAlertDialog(
          title: Text('New Band Name'),
          content: CupertinoTextField(
            controller: textcontroller,
          ),
          actions: [
            CupertinoDialogAction(
              isDefaultAction: true,
              child: const Text('Add'),
              onPressed: ()=>addBandToList(textcontroller.text),
            ),

             CupertinoDialogAction(
              isDestructiveAction: true,
              child: const Text('Dismiss'),
              onPressed: ()=>Navigator.pop(context),
            )

          ],
        );
      }
    );
   
  }

  void addBandToList(String name){
    if(name.length > 1){
      bands.add(
        Band(id: DateTime.now().toString(), name: name, votes: 0),
      );
      setState((){});
    }

    Navigator.pop(context);
  }


  

}

class _bandTitle extends StatelessWidget {
  
  Band band;

  _bandTitle(this.band);
  
  @override
  Widget build(BuildContext context) {
    return Dismissible(
      onDismissed: (direction){
        print('${band.id}');
      },
      direction: DismissDirection.startToEnd,
      key: Key(band.id),
      background: Container(
        padding: const EdgeInsets.only(left: 8.0),
        color: Colors.red,
        child: const Align(
          alignment: Alignment.centerLeft,
          child:  Text('Delete Band', style: TextStyle(color: Colors.white),),
        ),
      ),
      child: ListTile(
        
        leading: CircleAvatar(
          child: Text(band.name.substring(0,2), style: const TextStyle(fontWeight: FontWeight.bold),),
          backgroundColor: Colors.blue[100],
        ),
    
        title: Text(band.name),
        trailing: Text('${band.votes}', style: const TextStyle(fontSize: 18),),
        onTap: (){
          print(band.name);
        },
      ),
    );
  }

}