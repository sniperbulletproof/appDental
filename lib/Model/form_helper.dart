// ignore_for_file: prefer_const_constructors, unnecessary_new

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:dentisttry/Model/data_model.dart';
import 'package:image_picker/image_picker.dart';

class FormHelper {
  //widget for appointment_set
  //designing u/i
  static Widget textInput(
    BuildContext context,
    Object initialValue,
    Function onChanged, {
    bool isTextArea = false,
    bool isNumberInput = false,
    Function onValidate,
    Widget prefixIcon,
    Widget suffixIcon,
  }) {
    return TextFormField(
      initialValue: initialValue != null ? initialValue.toString() : "",
      decoration: fieldDecoration(context, "", ""),
      maxLines: !isTextArea ? 1 : 3,
      keyboardType: isNumberInput ? TextInputType.number : TextInputType.text,
      onChanged: (String value) {
        return onChanged(value);
      },
      validator: (value) {
        return onValidate(value);
      },
    );
  }

  static InputDecoration fieldDecoration(
    BuildContext context,
    String hintText,
    String helperText, {
    Widget prefixIcon,
    Widget suffixIcon,
  }) {
    return InputDecoration(
      contentPadding: EdgeInsets.all(6),
      hintText: hintText,
      helperText: helperText,
      prefixIcon: prefixIcon,
      suffixIcon: suffixIcon,
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: Theme.of(context).primaryColor,
          width: 1,
        ),
      ),
      border: OutlineInputBorder(
        borderSide: BorderSide(
          color: Theme.of(context).primaryColor,
          width: 1,
        ),
      ),
    );
  }

  static Widget selectDropdown(
    BuildContext context,
    Object initialValue,
    dynamic data,
    Function onChanged, {
    Function onValidate,
  }) {
    return Container(
      height: 75,
      padding: EdgeInsets.only(top: 5),
      child: new DropdownButtonFormField<String>(
        hint: new Text("Select services"),
        value: initialValue != null ? initialValue.toString() : null,
        isDense: true,
        onChanged: (String newValue) {
          FocusScope.of(context).requestFocus(new FocusNode());
          onChanged(newValue);
        },
        validator: (value) {
          return onValidate(value);
        },
        decoration: fieldDecoration(context, "", ""),
        items: data.map<DropdownMenuItem<String>>(
          (CategoryModel data) {
            return DropdownMenuItem<String>(
              value: data.categoryId.toString(),
              child: new Text(
                data.categoryName,
                style: new TextStyle(color: Colors.black),
              ),
            );
          },
        ).toList(),
      ),
    );
  }

  static Widget fieldLabel(String labelName) {
    return new Padding(
      padding: EdgeInsets.fromLTRB(0, 5, 0, 10),
      child: Text(
        labelName,
        style: new TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 15.0,
        ),
      ),
    );
  }

  static void showMessage(BuildContext context, String title, String message,
      String buttonText, Function onPressed,
      {bool isConfirmationDialog = false,
      String buttonText2 = "",
      Function onPressed2}) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: new Text(title),
          content: new Text(message),
          actions: [
            new FlatButton(
              onPressed: () {
                return onPressed();
              },
              child: new Text(buttonText),
            ),
            Visibility(
              visible: isConfirmationDialog,
              child: new FlatButton(
                onPressed: () {
                  return onPressed2();
                },
                child: new Text(buttonText2),
              ),
            ),
          ],
        );
      },
    );
  }
}
