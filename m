From: Maxin john <maxin@maxinbjohn.info>
Subject: [PATCH] Remove "bashism" from contrib/thunderbird-patch-inline/appp.sh
Date: Sun, 27 Mar 2011 17:37:04 +0300
Message-ID: <AANLkTin-USDnTxeKT_KOZW5kgC0vFXYbMNP9ct6fzbUC@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?ISO-8859-1?Q?Lukas_Sandstr=F6m?= <luksan@gmail.com>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Mar 27 16:37:18 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q3r5h-0008EY-PK
	for gcvg-git-2@lo.gmane.org; Sun, 27 Mar 2011 16:37:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753599Ab1C0OhG convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 27 Mar 2011 10:37:06 -0400
Received: from mail-gw0-f46.google.com ([74.125.83.46]:40020 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753545Ab1C0OhF convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 27 Mar 2011 10:37:05 -0400
Received: by gwaa18 with SMTP id a18so931471gwa.19
        for <git@vger.kernel.org>; Sun, 27 Mar 2011 07:37:04 -0700 (PDT)
Received: by 10.150.198.10 with SMTP id v10mr2840045ybf.283.1301236624225;
 Sun, 27 Mar 2011 07:37:04 -0700 (PDT)
Received: by 10.150.139.2 with HTTP; Sun, 27 Mar 2011 07:37:04 -0700 (PDT)
X-Originating-IP: [91.154.177.92]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170082>

Remove "bashism" and minor corrections for
contrib/thunderbird-patch-inline/appp.sh

Signed-off-by: Maxin B. John <maxin@maxinbjohn.info>
---
diff --git a/contrib/thunderbird-patch-inline/appp.sh
b/contrib/thunderbird-patch-inline/appp.sh
index cc518f3..1d29f4b 100755
--- a/contrib/thunderbird-patch-inline/appp.sh
+++ b/contrib/thunderbird-patch-inline/appp.sh
@@ -1,8 +1,8 @@
-#!/bin/bash
+#!/bin/sh
 # Copyright 2008 Lukas Sandstr=F6m <luksan@gmail.com>
 #
 # AppendPatch - A script to be used together with ExternalEditor
-# for Mozilla Thunderbird to properly include pathes inline i e-mails.
+# for Mozilla Thunderbird to properly include patches inline in e-mail=
s.

 # ExternalEditor can be downloaded at http://globs.org/articles.php?ln=
g=3Den&pg=3D2

@@ -16,6 +16,11 @@ else
        cd > /dev/null
 fi

+#check whether zenity is present
+if ! type zenity >/dev/null 2>&1 ; then
+       exit 1
+fi
+
 PATCH=3D$(zenity --file-selection)

 if [ "$?" !=3D "0" ] ; then
