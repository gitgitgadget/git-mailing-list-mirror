From: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Subject: [PATCH] gitk: accelerators for the main menu
Date: Wed,  9 Sep 2015 15:20:53 +0200
Message-ID: <1441804853-28346-1-git-send-email-giuseppe.bilotta@gmail.com>
Cc: Paul Mackerras <paulus@samba.org>,
	Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Sep 09 15:24:57 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZZfMg-0000f9-R7
	for gcvg-git-2@plane.gmane.org; Wed, 09 Sep 2015 15:24:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753371AbbIINYd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Sep 2015 09:24:33 -0400
Received: from mail-wi0-f180.google.com ([209.85.212.180]:38092 "EHLO
	mail-wi0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752006AbbIINYV (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Sep 2015 09:24:21 -0400
Received: by wiclk2 with SMTP id lk2so21753597wic.1
        for <git@vger.kernel.org>; Wed, 09 Sep 2015 06:24:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=R5h3ot7/x6pfCuFoyf44DmKx8afnkX8/CfOmoY1cCUg=;
        b=LWXR9G3ACg6u6Fw0JavP5QABe8neTJYsHyrG6WKZDPvrahasw6FXej//eNaV6Jqiy/
         Wfi2f9xoPKAjb3l80BMzg/v31EP1YMSFMgQcX4sT+xU8tLshob4m+5Iq+El505VXWB/m
         0cFCIJ0mAj9P05vcZQ4gWbYCSsknpWHzKBBY95x7LcHjXY3e7PTWW4qvocWEd09VMiwt
         m5U9FAVN2FuiWGzgSUn6HMayMNOkF/N0kyddut5+uwUgDmrgfoJOtA0MVV4p5h2mncK5
         lpaN1HzSntJZO0NsDSUR5k70niiZz2nsIl8mAb0GpEHhRuuY3m1djv4W0gd7K8YHTYwR
         18cA==
X-Received: by 10.194.6.42 with SMTP id x10mr58361895wjx.100.1441805060015;
        Wed, 09 Sep 2015 06:24:20 -0700 (PDT)
Received: from localhost ([193.206.223.108])
        by smtp.gmail.com with ESMTPSA id bc9sm2011445wjc.8.2015.09.09.06.24.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 09 Sep 2015 06:24:18 -0700 (PDT)
X-Mailer: git-send-email 2.6.0.rc1.170.g51893f9.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277554>

This allows fast, keyboard-only usage of the menu (e.g. Alt+V, N to open a
new view).

Signed-off-by: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
---
 gitk | 46 +++++++++++++++++++++++-----------------------
 1 file changed, 23 insertions(+), 23 deletions(-)

diff --git a/gitk b/gitk
index 51520ef..4fc6267 100755
--- a/gitk
+++ b/gitk
@@ -2065,33 +2065,33 @@ proc makewindow {} {
     # The "mc" arguments here are purely so that xgettext
     # sees the following string as needing to be translated
     set file {
-	mc "File" cascade {
-	    {mc "Update" command updatecommits -accelerator F5}
-	    {mc "Reload" command reloadcommits -accelerator Shift-F5}
-	    {mc "Reread references" command rereadrefs}
-	    {mc "List references" command showrefs -accelerator F2}
+	mc "&File" cascade {
+	    {mc "&Update" command updatecommits -accelerator F5}
+	    {mc "&Reload" command reloadcommits -accelerator Shift-F5}
+	    {mc "Reread re&ferences" command rereadrefs}
+	    {mc "&List references" command showrefs -accelerator F2}
 	    {xx "" separator}
-	    {mc "Start git gui" command {exec git gui &}}
+	    {mc "Start git &gui" command {exec git gui &}}
 	    {xx "" separator}
-	    {mc "Quit" command doquit -accelerator Meta1-Q}
+	    {mc "&Quit" command doquit -accelerator Meta1-Q}
 	}}
     set edit {
-	mc "Edit" cascade {
-	    {mc "Preferences" command doprefs}
+	mc "&Edit" cascade {
+	    {mc "&Preferences" command doprefs}
 	}}
     set view {
-	mc "View" cascade {
-	    {mc "New view..." command {newview 0} -accelerator Shift-F4}
-	    {mc "Edit view..." command editview -state disabled -accelerator F4}
-	    {mc "Delete view" command delview -state disabled}
+	mc "&View" cascade {
+	    {mc "&New view..." command {newview 0} -accelerator Shift-F4}
+	    {mc "&Edit view..." command editview -state disabled -accelerator F4}
+	    {mc "&Delete view" command delview -state disabled}
 	    {xx "" separator}
-	    {mc "All files" radiobutton {selectedview 0} -command {showview 0}}
+	    {mc "&All files" radiobutton {selectedview 0} -command {showview 0}}
 	}}
     if {[tk windowingsystem] ne "aqua"} {
 	set help {
-	mc "Help" cascade {
-	    {mc "About gitk" command about}
-	    {mc "Key bindings" command keys}
+	mc "&Help" cascade {
+	    {mc "&About gitk" command about}
+	    {mc "&Key bindings" command keys}
 	}}
 	set bar [list $file $edit $view $help]
     } else {
@@ -2099,13 +2099,13 @@ proc makewindow {} {
 	proc ::tk::mac::Quit {} {doquit}
 	lset file end [lreplace [lindex $file end] end-1 end]
 	set apple {
-	xx "Apple" cascade {
-	    {mc "About gitk" command about}
+	xx "&Apple" cascade {
+	    {mc "&About gitk" command about}
 	    {xx "" separator}
 	}}
 	set help {
-	mc "Help" cascade {
-	    {mc "Key bindings" command keys}
+	mc "&Help" cascade {
+	    {mc "&Key bindings" command keys}
 	}}
 	set bar [list $apple $file $view $help]
     }
@@ -4468,8 +4468,8 @@ proc showview {n} {
 
     set curview $n
     set selectedview $n
-    .bar.view entryconf [mca "Edit view..."] -state [expr {$n == 0? "disabled": "normal"}]
-    .bar.view entryconf [mca "Delete view"] -state [expr {$n == 0? "disabled": "normal"}]
+    .bar.view entryconf [mca "&Edit view..."] -state [expr {$n == 0? "disabled": "normal"}]
+    .bar.view entryconf [mca "&Delete view"] -state [expr {$n == 0? "disabled": "normal"}]
 
     run refill_reflist
     if {![info exists viewcomplete($n)]} {
-- 
2.6.0.rc1.170.g51893f9.dirty
