From: Christian Stimming <stimming@tuhh.de>
Subject: [PATCH 7/9] gitk i18n: More i18n markup: findloc optionmenu.
Date: Wed, 7 Nov 2007 18:45:40 +0100
Message-ID: <200711071845.40236.stimming@tuhh.de>
References: <200711071839.08570.stimming@tuhh.de> <200711071844.36091.stimming@tuhh.de> <200711071845.06849.stimming@tuhh.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Paul Mackerras <paulus@samba.org>
X-From: git-owner@vger.kernel.org Wed Nov 07 18:18:42 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IpoY5-0003tT-KU
	for gcvg-git-2@gmane.org; Wed, 07 Nov 2007 18:18:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755910AbXKGRR7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Nov 2007 12:17:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755639AbXKGRR6
	(ORCPT <rfc822;git-outgoing>); Wed, 7 Nov 2007 12:17:58 -0500
Received: from smtp3.rz.tu-harburg.de ([134.28.202.138]:46110 "EHLO
	smtp3.rz.tu-harburg.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754765AbXKGRR6 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Nov 2007 12:17:58 -0500
Received: from mail2.rz.tu-harburg.de (mail2.rz.tu-harburg.de [134.28.202.179])
	by smtp3.rz.tu-harburg.de (8.13.8/8.13.8) with ESMTP id lA7HH4m5019023
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK);
	Wed, 7 Nov 2007 18:17:04 +0100
Received: from [192.168.2.102] (p549012B6.dip0.t-ipconnect.de [84.144.18.182])
	(user=alucst mech=LOGIN bits=0)
	by mail2.rz.tu-harburg.de (8.13.8/8.13.8) with ESMTP id lA7HH2gA006707
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 7 Nov 2007 18:17:04 +0100
User-Agent: KMail/1.9.5
In-Reply-To: <200711071845.06849.stimming@tuhh.de>
Content-Disposition: inline
X-Scanned-By: TUHH Rechenzentrum content checker on 134.28.202.138
X-Scanned-By: TUHH Rechenzentrum content checker on 134.28.202.179
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63840>

---
 gitk |   28 ++++++++++++++--------------
 1 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/gitk b/gitk
index 3e8d934..3acb0be 100755
--- a/gitk
+++ b/gitk
@@ -790,9 +790,9 @@ proc makewindow {} {
     trace add variable findtype write findcom_change
     .tf.lbar.findtype configure -font uifont
     .tf.lbar.findtype.menu configure -font uifont
-    set findloc "All fields"
-    tk_optionMenu .tf.lbar.findloc findloc "All fields" Headline \
-	Comments Author Committer
+    set findloc [mc "All fields"]
+    tk_optionMenu .tf.lbar.findloc findloc [mc "All fields"] [mc "Headline"] \
+	[mc "Comments"] [mc "Author"] [mc "Committer"]
     trace add variable findloc write find_change
     .tf.lbar.findloc configure -font uifont
     .tf.lbar.findloc.menu configure -font uifont
@@ -2488,11 +2488,11 @@ proc askfindhighlight {row id} {
     }
     set info $commitinfo($id)
     set isbold 0
-    set fldtypes {Headline Author Date Committer CDate Comments}
+    set fldtypes [list [mc Headline] [mc Author] [mc Date] [mc Committer] [mc CDate] [mc Comments]]
     foreach f $info ty $fldtypes {
-	if {($findloc eq "All fields" || $findloc eq $ty) &&
+	if {($findloc eq [mc "All fields"] || $findloc eq $ty) &&
 	    [doesmatch $f]} {
-	    if {$ty eq "Author"} {
+	    if {$ty eq [mc "Author"]} {
 		set isbold 2
 		break
 	    }
@@ -2520,14 +2520,14 @@ proc markrowmatches {row id} {
     set author [lindex $commitinfo($id) 1]
     $canv delete match$row
     $canv2 delete match$row
-    if {$findloc eq "All fields" || $findloc eq "Headline"} {
+    if {$findloc eq [mc "All fields"] || $findloc eq [mc "Headline"]} {
 	set m [findmatches $headline]
 	if {$m ne {}} {
 	    markmatches $canv $row $headline $linehtag($row) $m \
 		[$canv itemcget $linehtag($row) -font] $row
 	}
     }
-    if {$findloc eq "All fields" || $findloc eq "Author"} {
+    if {$findloc eq [mc "All fields"] || $findloc eq [mc "Author"]} {
 	set m [findmatches $author]
 	if {$m ne {}} {
 	    markmatches $canv2 $row $author $linentag($row) $m \
@@ -4261,8 +4261,8 @@ proc dofind {{dirn 1} {wrap 1}} {
 	set findstartline $selectedline
     }
     set findcurline $findstartline
-    nowbusy finding "Searching"
-    if {$gdttype ne "containing:" && ![info exists filehighlight]} {
+    nowbusy finding [mc "Searching"]
+    if {$gdttype ne [mc "containing:"] && ![info exists filehighlight]} {
 	after cancel do_file_hl $fh_serial
 	do_file_hl $fh_serial
     }
@@ -4292,7 +4292,7 @@ proc findmore {} {
     if {![info exists find_dirn]} {
 	return 0
     }
-    set fldtypes {Headline Author Date Committer CDate Comments}
+    set fldtypes [list [mc "Headline"] [mc "Author"] [mc "Date"] [mc "Committer"] [mc "CDate"] [mc "Comments"]]
     set l $findcurline
     set moretodo 0
     if {$find_dirn > 0} {
@@ -4336,7 +4336,7 @@ proc findmore {} {
 	    }
 	    set info $commitinfo($id)
 	    foreach f $info ty $fldtypes {
-		if {($findloc eq "All fields" || $findloc eq $ty) &&
+		if {($findloc eq [mc "All fields"] || $findloc eq $ty) &&
 		    [doesmatch $f]} {
 		    set found 1
 		    break
@@ -4392,7 +4392,7 @@ proc findselectline {l} {
     set markingmatches 1
     set findcurline $l
     selectline $l 1
-    if {$findloc == "All fields" || $findloc == "Comments"} {
+    if {$findloc == [mc "All fields"] || $findloc == [mc "Comments"]} {
 	# highlight the matches in the comments
 	set f [$ctext get 1.0 $commentend]
 	set matches [findmatches $f]
@@ -4780,7 +4780,7 @@ proc selectline {l isnew} {
     $ctext conf -state disabled
     set commentend [$ctext index "end - 1c"]
 
-    init_flist "Comments"
+    init_flist [mc "Comments"]
     if {$cmitmode eq "tree"} {
 	gettree $id
     } elseif {[llength $olds] <= 1} {
-- 
1.5.3.4.206.g58ba4
