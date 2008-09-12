From: Christian Stimming <stimming@tuhh.de>
Subject: [PATCH] git-gui: I18n fix sentence parts into full sentences for translation again.
Date: Fri, 12 Sep 2008 11:17:38 +0200
Organization: Alumni Technische =?iso-8859-1?q?Universit=E4t?= Hamburg-Harburg
Message-ID: <200809121117.39407.stimming@tuhh.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Alexander Gavrilov <angavrilov@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Sep 12 11:18:45 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ke4nZ-0003kB-GY
	for gcvg-git-2@gmane.org; Fri, 12 Sep 2008 11:18:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751521AbYILJRd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Sep 2008 05:17:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751441AbYILJRd
	(ORCPT <rfc822;git-outgoing>); Fri, 12 Sep 2008 05:17:33 -0400
Received: from smtp3.rz.tu-harburg.de ([134.28.202.138]:46695 "EHLO
	smtp3.rz.tu-harburg.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751133AbYILJRc (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Sep 2008 05:17:32 -0400
Received: from mail2.rz.tu-harburg.de (mail2.rz.tu-harburg.de [134.28.202.179])
	by smtp3.rz.tu-harburg.de (8.13.8/8.13.8) with ESMTP id m8C9HRt2015120
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK);
	Fri, 12 Sep 2008 11:17:27 +0200
Received: from [192.168.0.101] (e176218255.adsl.alicedsl.de [85.176.218.255])
	(user=alucst mech=LOGIN bits=0)
	by mail2.rz.tu-harburg.de (8.13.8/8.13.8) with ESMTP id m8C9HPWD008266
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 12 Sep 2008 11:17:27 +0200
User-Agent: KMail/1.9.5
Content-Disposition: inline
X-Scanned-By: TUHH Rechenzentrum content checker on 134.28.202.138
X-Scanned-By: TUHH Rechenzentrum content checker on 134.28.202.179
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95694>

For translations, it is almost always impossible to correctly translate
parts of sentences in almost any other language. Hence, messages like this
must be re-organized into full sentences.

Signed-off-by: Christian Stimming <stimming@tuhh.de>
---
Patch against origin/master of git-gui.git at repo.or.cz.

 lib/mergetool.tcl |   12 ++++++------
 1 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/lib/mergetool.tcl b/lib/mergetool.tcl
index 79c58bc..d10cadd 100644
--- a/lib/mergetool.tcl
+++ b/lib/mergetool.tcl
@@ -5,18 +5,18 @@ proc merge_resolve_one {stage} {
 	global current_diff_path
 
 	switch -- $stage {
-		1 { set target [mc "the base version"] }
-		2 { set target [mc "this branch"] }
-		3 { set target [mc "the other branch"] }
+		1 { set targetquestion [mc "Force resolution to the base version?"] }
+		2 { set targetquestion [mc "Force resolution to this branch?"] }
+		3 { set targetquestion [mc "Force resolution to the other branch?"] }
 	}
 
-	set op_question [mc "Force resolution to %s?
-Note that the diff shows only conflicting changes.
+    set op_question [strcat $targetquestion "\n" \
+[mc "Note that the diff shows only conflicting changes.
 
 %s will be overwritten.
 
 This operation can be undone only by restarting the merge." \
-		$target [short_path $current_diff_path]]
+	 	$targetquestion [short_path $current_diff_path]]]
 
 	if {[ask_popup $op_question] eq {yes}} {
 		merge_load_stages $current_diff_path [list merge_force_stage $stage]
-- 
1.6.0.rc1.34.g0fe8c
