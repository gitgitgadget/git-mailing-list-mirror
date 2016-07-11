Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.6 required=3.0 tests=BAYES_20,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3976B1FE4E
	for <e@80x24.org>; Mon, 11 Jul 2016 11:50:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030645AbcGKLu1 (ORCPT <rfc822;e@80x24.org>);
	Mon, 11 Jul 2016 07:50:27 -0400
Received: from forward10p.cmail.yandex.net ([87.250.241.195]:57332 "EHLO
	forward10p.cmail.yandex.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932166AbcGKLu0 (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 11 Jul 2016 07:50:26 -0400
X-Greylist: delayed 473 seconds by postgrey-1.27 at vger.kernel.org; Mon, 11 Jul 2016 07:50:25 EDT
Received: from mxback6g.mail.yandex.net (mxback6g.mail.yandex.net [77.88.29.167])
	by forward10p.cmail.yandex.net (Yandex) with ESMTP id 99670210C2
	for <git@vger.kernel.org>; Mon, 11 Jul 2016 14:42:30 +0300 (MSK)
Received: from web16g.yandex.ru (web16g.yandex.ru [95.108.252.116])
	by mxback6g.mail.yandex.net (nwsmtp/Yandex) with ESMTP id 2U77Qy0oJk-gU9KNIDd;
	Mon, 11 Jul 2016 14:42:30 +0300
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail; t=1468237350;
	bh=ynhlW9qPRLKpbga5Hm05nxCvEWqWMKdd4X+Mi05EzC8=;
	h=From:To:Subject:Message-Id:Date;
	b=Xpn4qLmaP3nA0WxF6in58mqcuiODKDwEXCqulDSdC0gcHQ9jjv3u2AFompWSLKIbB
	 5QTr5MZ65xbNV8964nDY18e68Rh9+fc0p5bK7wM8ZPc8EBF5HfWAqKaOhbwWj1wI5g
	 C8cTNnB13EA3mENE0P+YGK8veiPsy8UrHwp20Atk=
Authentication-Results:	mxback6g.mail.yandex.net; dkim=pass header.i=@yandex.ru
Received: by web16g.yandex.ru with HTTP;
	Mon, 11 Jul 2016 14:42:30 +0300
From:	KES <kes-kes@yandex.ru>
Envelope-From: kes-kes@yandex.ua
To:	git <git@vger.kernel.org>
Subject: Unexpected diff is shown with -w -b options in effect
MIME-Version: 1.0
Message-Id: <275091468237350@web16g.yandex.ru>
X-Mailer: Yamail [ http://yandex.ru ] 5.0
Date:	Mon, 11 Jul 2016 14:42:30 +0300
Content-Transfer-Encoding: 7bit
Content-Type: text/plain
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Hi

For this diff
diff --git a/app/public/v2/index.html b/app/public/v2/index.html
index f73ba73..3af0c64 100644
--- a/app/public/v2/index.html
+++ b/app/public/v2/index.html
@@ -21,11 +21,15 @@
 </head>
 <body>
 <div id="media-width-detection-element"></div>
-<div id="rowTools" class="eRowTools btn-group btn-group-sm">
-	<div    type="button"              class="eBtnMov btn btn-default">MOV</div>
-	<button type="button" class="eBtnAdd btn btn-default" onclick="rowTools_add_click( this )">ADD</button>
-	<button type="button" class="eBtnDel btn btn-default" onclick="rowTools_del_click( this )">DEL</button>
-	<img src="img/add.png"/>
+<div id="rowTools" class="eRowTools">
+	<div class="eRow_Separator btn-group btn-group-sm">
+		<div    type="button" class="eBtnMov btn btn-default">MOV</div>
+		<button type="button" class="eBtnAdd btn btn-default" onclick="rowTools_add_click( this )">ADD</button>
+		<button type="button" class="eBtnDel btn btn-default" onclick="rowTools_del_click( this )">DEL</button>
+	</div>
+	<div class="eRow_ColAdd">
+		<img src="img/add.png"/>
+	</div>
 </div>
 <div id="colTools" class="eColTools"></div>
 <div class="container-fluid">

I see next:
diff --git a/app/public/v2/index.html b/app/public/v2/index.html
index f73ba73..d415c2d 100644
--- a/app/public/v2/index.html
+++ b/app/public/v2/index.html
@@ -21,12 +21,16 @@
 </head>
 <body>
 <div id="media-width-detection-element"></div>
-<div id="rowTools" class="eRowTools btn-group btn-group-sm">
+<div id="rowTools" class="eRowTools">
+    <div class="eRow_Separator btn-group btn-group-sm">
         <div    type="button" class="eBtnMov btn btn-default">MOV</div>
         <button type="button" class="eBtnAdd btn btn-default" onclick="rowTools_add_click( this )">
         <button type="button" class="eBtnDel btn btn-default" onclick="rowTools_del_click( this )">
+    </div>
+    <div class="eRow_ColAdd">
         <img src="img/add.png"/>
     </div>
+</div>                         <<<<<<<<<<<<<<<<<<<<<<<< IS NOT EXPECTED
 <div id="colTools" class="eColTools"></div>
 <div class="container-fluid">
 <div class="row">

But I expect to see:
diff --git a/app/public/v2/index.html b/app/public/v2/index.html
index f73ba73..d415c2d 100644
--- a/app/public/v2/index.html
+++ b/app/public/v2/index.html
@@ -21,12 +21,16 @@
 </head>
 <body>
 <div id="media-width-detection-element"></div>
-<div id="rowTools" class="eRowTools btn-group btn-group-sm">
+<div id="rowTools" class="eRowTools">
+    <div class="eRow_Separator btn-group btn-group-sm">
         <div    type="button" class="eBtnMov btn btn-default">MOV</div>
         <button type="button" class="eBtnAdd btn btn-default" onclick="rowTools_add_click( this )">
         <button type="button" class="eBtnDel btn btn-default" onclick="rowTools_del_click( this )">
+    </div>
+    <div class="eRow_ColAdd">
         <img src="img/add.png"/>
+     </div>                         <<<<<<<<<<<<<<<<<<<<<< EXPECT THIS
</div>
 <div id="colTools" class="eColTools"></div>
 <div class="container-fluid">
 <div class="row">


This seems to me a bug or should I apply some extra options to get expected behaviour?

PS$ git --version
git version 2.8.1
