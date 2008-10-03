From: Johannes Sixt <j.sixt@viscovery.net>
Subject: [PATCH] git-gui: Mark-up strings in show_{other,unmerged}_diff()
 for localization
Date: Fri, 03 Oct 2008 13:13:42 +0200
Message-ID: <48E5FE66.4020704@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Fri Oct 03 13:15:08 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Klice-0007vL-7v
	for gcvg-git-2@gmane.org; Fri, 03 Oct 2008 13:15:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752467AbYJCLNq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 Oct 2008 07:13:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752240AbYJCLNq
	(ORCPT <rfc822;git-outgoing>); Fri, 3 Oct 2008 07:13:46 -0400
Received: from lilzmailso01.liwest.at ([212.33.55.23]:36931 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751837AbYJCLNp (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Oct 2008 07:13:45 -0400
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.66)
	(envelope-from <j.sixt@viscovery.net>)
	id 1KlibO-0003EA-K2; Fri, 03 Oct 2008 13:13:42 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.42])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 5DAFC69F; Fri,  3 Oct 2008 13:13:42 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
X-Enigmail-Version: 0.95.5
X-Spam-Score: 1.7 (+)
X-Spam-Report: ALL_TRUSTED=-1.8, BAYES_99=3.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Sixt <johannes.sixt@telecom.at>

Signed-off-by: Johannes Sixt <johannes.sixt@telecom.at>
---
 lib/diff.tcl |   22 +++++++++++-----------
 1 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/lib/diff.tcl b/lib/diff.tcl
index abe502d..484ebb4 100644
--- a/lib/diff.tcl
+++ b/lib/diff.tcl
@@ -117,22 +117,22 @@ proc show_unmerged_diff {cont_info} {
 	if {$merge_stages(2) eq {}} {
 		set is_conflict_diff 1
 		lappend current_diff_queue \
-			[list "LOCAL: deleted\nREMOTE:\n" d======= \
+			[list [mc "LOCAL: deleted\nREMOTE:\n"] d======= \
 			    [list ":1:$current_diff_path" ":3:$current_diff_path"]]
 	} elseif {$merge_stages(3) eq {}} {
 		set is_conflict_diff 1
 		lappend current_diff_queue \
-			[list "REMOTE: deleted\nLOCAL:\n" d======= \
+			[list [mc "REMOTE: deleted\nLOCAL:\n"] d======= \
 			    [list ":1:$current_diff_path" ":2:$current_diff_path"]]
 	} elseif {[lindex $merge_stages(1) 0] eq {120000}
 		|| [lindex $merge_stages(2) 0] eq {120000}
 		|| [lindex $merge_stages(3) 0] eq {120000}} {
 		set is_conflict_diff 1
 		lappend current_diff_queue \
-			[list "LOCAL:\n" d======= \
+			[list [mc "LOCAL:\n"] d======= \
 			    [list ":1:$current_diff_path" ":2:$current_diff_path"]]
 		lappend current_diff_queue \
-			[list "REMOTE:\n" d======= \
+			[list [mc "REMOTE:\n"] d======= \
 			    [list ":1:$current_diff_path" ":3:$current_diff_path"]]
 	} else {
 		start_show_diff $cont_info
@@ -218,17 +218,17 @@ proc show_other_diff {path w m cont_info} {
 				d_@
 		} else {
 			if {$sz > $max_sz} {
-				$ui_diff insert end \
-"* Untracked file is $sz bytes.
-* Showing only first $max_sz bytes.
-" d_@
+				$ui_diff insert end [mc \
+"* Untracked file is %d bytes.
+* Showing only first %d bytes.
+" $sz $max_sz] d_@
 			}
 			$ui_diff insert end $content
 			if {$sz > $max_sz} {
-				$ui_diff insert end "
-* Untracked file clipped here by [appname].
+				$ui_diff insert end [mc "
+* Untracked file clipped here by %s.
 * To see the entire file, use an external editor.
-" d_@
+" [appname]] d_@
 			}
 		}
 		$ui_diff conf -state disabled
-- 
1.6.0.2.319.gffa7c
