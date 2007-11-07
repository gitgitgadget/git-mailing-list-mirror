From: Christian Stimming <stimming@tuhh.de>
Subject: [PATCH 6/9] gitk i18n: More i18n markup: highlight_related and selectedhlview options menu.
Date: Wed, 7 Nov 2007 18:45:06 +0100
Message-ID: <200711071845.06849.stimming@tuhh.de>
References: <200711071839.08570.stimming@tuhh.de> <200711071844.03106.stimming@tuhh.de> <200711071844.36091.stimming@tuhh.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Paul Mackerras <paulus@samba.org>
X-From: git-owner@vger.kernel.org Wed Nov 07 18:17:53 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IpoXI-0003Zp-Is
	for gcvg-git-2@gmane.org; Wed, 07 Nov 2007 18:17:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755032AbXKGRRg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Nov 2007 12:17:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754765AbXKGRRg
	(ORCPT <rfc822;git-outgoing>); Wed, 7 Nov 2007 12:17:36 -0500
Received: from smtp3.rz.tu-harburg.de ([134.28.202.138]:46074 "EHLO
	smtp3.rz.tu-harburg.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754996AbXKGRRf (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Nov 2007 12:17:35 -0500
Received: from mail2.rz.tu-harburg.de (mail2.rz.tu-harburg.de [134.28.202.179])
	by smtp3.rz.tu-harburg.de (8.13.8/8.13.8) with ESMTP id lA7HGV27018889
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK);
	Wed, 7 Nov 2007 18:16:31 +0100
Received: from [192.168.2.102] (p549012B6.dip0.t-ipconnect.de [84.144.18.182])
	(user=alucst mech=LOGIN bits=0)
	by mail2.rz.tu-harburg.de (8.13.8/8.13.8) with ESMTP id lA7HGTea006174
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 7 Nov 2007 18:16:31 +0100
User-Agent: KMail/1.9.5
In-Reply-To: <200711071844.36091.stimming@tuhh.de>
Content-Disposition: inline
X-Scanned-By: TUHH Rechenzentrum content checker on 134.28.202.138
X-Scanned-By: TUHH Rechenzentrum content checker on 134.28.202.179
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63838>

---
 gitk |   26 +++++++++++++-------------
 1 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/gitk b/gitk
index 777ee20..3e8d934 100755
--- a/gitk
+++ b/gitk
@@ -1998,7 +1998,7 @@ proc delview {} {
 
     if {$curview == 0} return
     if {[info exists hlview] && $hlview == $curview} {
-	set selectedhlview None
+	set selectedhlview [mc "None"]
 	unset hlview
     }
     allviewmenus $curview delete
@@ -2084,7 +2084,7 @@ proc showview {n} {
     clear_display
     if {[info exists hlview] && $hlview == $n} {
 	unset hlview
-	set selectedhlview None
+	set selectedhlview [mc "None"]
     }
     catch {unset commitinterest}
 
@@ -2540,7 +2540,7 @@ proc vrel_change {name ix op} {
     global highlight_related
 
     rhighlight_none
-    if {$highlight_related ne "None"} {
+    if {$highlight_related ne [mc "None"]} {
 	run drawvisible
     }
 }
@@ -2554,7 +2554,7 @@ proc rhighlight_sel {a} {
     set desc_todo [list $a]
     catch {unset ancestor}
     set anc_todo [list $a]
-    if {$highlight_related ne "None"} {
+    if {$highlight_related ne [mc "None"]} {
 	rhighlight_none
 	run drawvisible
     }
@@ -2637,20 +2637,20 @@ proc askrelhighlight {row id} {
 
     if {![info exists selectedline]} return
     set isbold 0
-    if {$highlight_related eq "Descendent" ||
-	$highlight_related eq "Not descendent"} {
+    if {$highlight_related eq [mc "Descendent"] ||
+	$highlight_related eq [mc "Not descendent"]} {
 	if {![info exists descendent($id)]} {
 	    is_descendent $id
 	}
-	if {$descendent($id) == ($highlight_related eq "Descendent")} {
+	if {$descendent($id) == ($highlight_related eq [mc "Descendent"])} {
 	    set isbold 1
 	}
-    } elseif {$highlight_related eq "Ancestor" ||
-	      $highlight_related eq "Not ancestor"} {
+    } elseif {$highlight_related eq [mc "Ancestor"] ||
+	      $highlight_related eq [mc "Not ancestor"]} {
 	if {![info exists ancestor($id)]} {
 	    is_ancestor $id
 	}
-	if {$ancestor($id) == ($highlight_related eq "Ancestor")} {
+	if {$ancestor($id) == ($highlight_related eq [mc "Ancestor"])} {
 	    set isbold 1
 	}
     }
@@ -3737,7 +3737,7 @@ proc drawcmitrow {row} {
     if {$findpattern ne {} && ![info exists nhighlights($row)]} {
 	askfindhighlight $row $id
     }
-    if {$highlight_related ne "None" && ![info exists rhighlights($row)]} {
+    if {$highlight_related ne [mc "None"] && ![info exists rhighlights($row)]} {
 	askrelhighlight $row $id
     }
     if {![info exists iddrawn($id)]} {
@@ -8632,8 +8632,8 @@ set firsttabstop 0
 set nextviewnum 1
 set curview 0
 set selectedview 0
-set selectedhlview None
-set highlight_related None
+set selectedhlview [mc "None"]
+set highlight_related [mc "None"]
 set highlight_files {}
 set viewfiles(0) {}
 set viewperm(0) 0
-- 
1.5.3.4.206.g58ba4
