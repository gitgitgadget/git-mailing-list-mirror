From: Christian Stimming <stimming@tuhh.de>
Subject: [PATCH 8/9] gitk i18n: More i18n markup: gdttype optionmenu.
Date: Wed, 7 Nov 2007 18:46:13 +0100
Message-ID: <200711071846.14097.stimming@tuhh.de>
References: <200711071839.08570.stimming@tuhh.de> <200711071845.06849.stimming@tuhh.de> <200711071845.40236.stimming@tuhh.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Paul Mackerras <paulus@samba.org>
X-From: git-owner@vger.kernel.org Wed Nov 07 18:18:50 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IpoY6-0003tT-8y
	for gcvg-git-2@gmane.org; Wed, 07 Nov 2007 18:18:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755927AbXKGRSM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Nov 2007 12:18:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756067AbXKGRSM
	(ORCPT <rfc822;git-outgoing>); Wed, 7 Nov 2007 12:18:12 -0500
Received: from smtp3.rz.tu-harburg.de ([134.28.202.138]:46132 "EHLO
	smtp3.rz.tu-harburg.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755639AbXKGRSL (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Nov 2007 12:18:11 -0500
Received: from mail2.rz.tu-harburg.de (mail2.rz.tu-harburg.de [134.28.202.179])
	by smtp3.rz.tu-harburg.de (8.13.8/8.13.8) with ESMTP id lA7HHbRp019164
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK);
	Wed, 7 Nov 2007 18:17:37 +0100
Received: from [192.168.2.102] (p549012B6.dip0.t-ipconnect.de [84.144.18.182])
	(user=alucst mech=LOGIN bits=0)
	by mail2.rz.tu-harburg.de (8.13.8/8.13.8) with ESMTP id lA7HHakr007118
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 7 Nov 2007 18:17:37 +0100
User-Agent: KMail/1.9.5
In-Reply-To: <200711071845.40236.stimming@tuhh.de>
Content-Disposition: inline
X-Scanned-By: TUHH Rechenzentrum content checker on 134.28.202.138
X-Scanned-By: TUHH Rechenzentrum content checker on 134.28.202.179
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63841>

---
 gitk |   24 ++++++++++++------------
 1 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/gitk b/gitk
index 3acb0be..b861f8d 100755
--- a/gitk
+++ b/gitk
@@ -769,11 +769,11 @@ proc makewindow {} {
     label .tf.lbar.flab2 -text " [mc "commit"] " -font uifont
     pack .tf.lbar.flabel .tf.lbar.fnext .tf.lbar.fprev .tf.lbar.flab2 \
 	-side left -fill y
-    set gdttype "containing:"
+    set gdttype [mc "containing:"]
     set gm [tk_optionMenu .tf.lbar.gdttype gdttype \
-		"containing:" \
-		"touching paths:" \
-		"adding/removing string:"]
+		[mc "containing:"] \
+		[mc "touching paths:"] \
+		[mc "adding/removing string:"]]
     trace add variable gdttype write gdttype_change
     $gm conf -font uifont
     .tf.lbar.gdttype conf -font uifont
@@ -1743,12 +1743,12 @@ proc flist_hl {only} {
     global flist_menu_file findstring gdttype
 
     set x [shellquote $flist_menu_file]
-    if {$only || $findstring eq {} || $gdttype ne "touching paths:"} {
+    if {$only || $findstring eq {} || $gdttype ne [mc "touching paths:"]} {
 	set findstring $x
     } else {
 	append findstring " " $x
     }
-    set gdttype "touching paths:"
+    set gdttype [mc "touching paths:"]
 }
 
 # Functions for adding and removing shell-type quoting
@@ -2313,7 +2313,7 @@ proc gdttype_change {name ix op} {
 
     stopfinding
     if {$findstring ne {}} {
-	if {$gdttype eq "containing:"} {
+	if {$gdttype eq [mc "containing:"]} {
 	    if {$highlight_files ne {}} {
 		set highlight_files {}
 		hfiles_change
@@ -2336,7 +2336,7 @@ proc find_change {name ix op} {
     global gdttype findstring highlight_files
 
     stopfinding
-    if {$gdttype eq "containing:"} {
+    if {$gdttype eq [mc "containing:"]} {
 	findcom_change
     } else {
 	if {$highlight_files ne $findstring} {
@@ -2360,7 +2360,7 @@ proc findcom_change args {
     catch {unset nhighlights}
     unbolden
     unmarkmatches
-    if {$gdttype ne "containing:" || $findstring eq {}} {
+    if {$gdttype ne [mc "containing:"] || $findstring eq {}} {
 	set findpattern {}
     } elseif {$findtype eq [mc "Regexp"]} {
 	set findpattern $findstring
@@ -2388,12 +2388,12 @@ proc makepatterns {l} {
 proc do_file_hl {serial} {
     global highlight_files filehighlight highlight_paths gdttype fhl_list
 
-    if {$gdttype eq "touching paths:"} {
+    if {$gdttype eq [mc "touching paths:"]} {
 	if {[catch {set paths [shellsplit $highlight_files]}]} return
 	set highlight_paths [makepatterns $paths]
 	highlight_filelist
 	set gdtargs [concat -- $paths]
-    } elseif {$gdttype eq "adding/removing string:"} {
+    } elseif {$gdttype eq [mc "adding/removing string:"]} {
 	set gdtargs [list "-S$highlight_files"]
     } else {
 	# must be "containing:", i.e. we're searching commit info
@@ -4325,7 +4325,7 @@ proc findmore {} {
     }
     set found 0
     set domore 1
-    if {$gdttype eq "containing:"} {
+    if {$gdttype eq [mc "containing:"]} {
 	for {} {$n > 0} {incr n -1; incr l $find_dirn} {
 	    set id [lindex $displayorder $l]
 	    # shouldn't happen unless git log doesn't give all the commits...
-- 
1.5.3.4.206.g58ba4
