From: Christian Stimming <stimming@tuhh.de>
Subject: [PATCH 5/9] gitk i18n: More i18n markup: findtype options menu.
Date: Wed, 7 Nov 2007 18:44:35 +0100
Message-ID: <200711071844.36091.stimming@tuhh.de>
References: <200711071839.08570.stimming@tuhh.de> <200711071842.55975.stimming@tuhh.de> <200711071844.03106.stimming@tuhh.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Paul Mackerras <paulus@samba.org>
X-From: git-owner@vger.kernel.org Wed Nov 07 18:17:59 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IpoXH-0003Zp-66
	for gcvg-git-2@gmane.org; Wed, 07 Nov 2007 18:17:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755253AbXKGRQo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Nov 2007 12:16:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754765AbXKGRQo
	(ORCPT <rfc822;git-outgoing>); Wed, 7 Nov 2007 12:16:44 -0500
Received: from smtp3.rz.tu-harburg.de ([134.28.202.138]:46016 "EHLO
	smtp3.rz.tu-harburg.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754025AbXKGRQn (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Nov 2007 12:16:43 -0500
Received: from mail2.rz.tu-harburg.de (mail2.rz.tu-harburg.de [134.28.202.179])
	by smtp3.rz.tu-harburg.de (8.13.8/8.13.8) with ESMTP id lA7HFxhH018760
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK);
	Wed, 7 Nov 2007 18:15:59 +0100
Received: from [192.168.2.102] (p549012B6.dip0.t-ipconnect.de [84.144.18.182])
	(user=alucst mech=LOGIN bits=0)
	by mail2.rz.tu-harburg.de (8.13.8/8.13.8) with ESMTP id lA7HFwVE005717
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 7 Nov 2007 18:15:59 +0100
User-Agent: KMail/1.9.5
In-Reply-To: <200711071844.03106.stimming@tuhh.de>
Content-Disposition: inline
X-Scanned-By: TUHH Rechenzentrum content checker on 134.28.202.138
X-Scanned-By: TUHH Rechenzentrum content checker on 134.28.202.179
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63839>

---
 gitk |   14 +++++++-------
 1 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/gitk b/gitk
index e291577..777ee20 100755
--- a/gitk
+++ b/gitk
@@ -784,9 +784,9 @@ proc makewindow {} {
     lappend entries $fstring
     entry $fstring -width 30 -font textfont -textvariable findstring
     trace add variable findstring write find_change
-    set findtype Exact
+    set findtype [mc "Exact"]
     set findtypemenu [tk_optionMenu .tf.lbar.findtype \
-		      findtype Exact IgnCase Regexp]
+		      findtype [mc "Exact"] [mc "IgnCase"] [mc "Regexp"]]
     trace add variable findtype write findcom_change
     .tf.lbar.findtype configure -font uifont
     .tf.lbar.findtype.menu configure -font uifont
@@ -2362,7 +2362,7 @@ proc findcom_change args {
     unmarkmatches
     if {$gdttype ne "containing:" || $findstring eq {}} {
 	set findpattern {}
-    } elseif {$findtype eq "Regexp"} {
+    } elseif {$findtype eq [mc "Regexp"]} {
 	set findpattern $findstring
     } else {
 	set e [string map {"*" "\\*" "?" "\\?" "\[" "\\\[" "\\" "\\\\"} \
@@ -2469,9 +2469,9 @@ proc readfhighlight {} {
 proc doesmatch {f} {
     global findtype findpattern
 
-    if {$findtype eq "Regexp"} {
+    if {$findtype eq [mc "Regexp"]} {
 	return [regexp $findpattern $f]
-    } elseif {$findtype eq "IgnCase"} {
+    } elseif {$findtype eq [mc "IgnCase"]} {
 	return [string match -nocase $findpattern $f]
     } else {
 	return [string match $findpattern $f]
@@ -4226,11 +4226,11 @@ proc notbusy {what} {
 
 proc findmatches {f} {
     global findtype findstring
-    if {$findtype == "Regexp"} {
+    if {$findtype == [mc "Regexp"]} {
 	set matches [regexp -indices -all -inline $findstring $f]
     } else {
 	set fs $findstring
-	if {$findtype == "IgnCase"} {
+	if {$findtype == [mc "IgnCase"]} {
 	    set f [string tolower $f]
 	    set fs [string tolower $fs]
 	}
-- 
1.5.3.4.206.g58ba4
