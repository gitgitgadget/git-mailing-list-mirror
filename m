From: Ferry Huberts <ferry.huberts@pelagic.nl>
Subject: [PATCH v3 1/2] Ensure consistent usage of mergetool.keepBackup in git-gui
Date: Fri, 10 Apr 2009 21:33:56 +0200
Message-ID: <f3d401fbaec1556ffbf8c13b83e58849af973a71.1239376248.git.ferry.huberts@pelagic.nl>
Cc: Junio C Hamano <gitster@pobox.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	David Aguilar <davvid@gmail.com>,
	Markus Heidelberg <markus.heidelberg@web.de>,
	Charles Bailey <charles@hashpling.org>,
	Ferry Huberts <ferry.huberts@pelagic.nl>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 10 21:35:45 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LsMVs-0007T4-0F
	for gcvg-git-2@gmane.org; Fri, 10 Apr 2009 21:35:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932405AbZDJTeM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 10 Apr 2009 15:34:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1763431AbZDJTeJ
	(ORCPT <rfc822;git-outgoing>); Fri, 10 Apr 2009 15:34:09 -0400
Received: from hupie.xs4all.nl ([82.95.241.251]:44564 "EHLO
	Lighthouse.internal.Hupie.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1762777AbZDJTeH (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 10 Apr 2009 15:34:07 -0400
Received: from localhost.localdomain (unknown [192.168.0.51])
	by Lighthouse.internal.Hupie.com (Postfix) with ESMTP id 384B558BDA0;
	Fri, 10 Apr 2009 21:33:58 +0200 (CEST)
X-Mailer: git-send-email 1.6.0.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116278>

In several places merge.keepBackup is used i.s.o.
mergetool.keepBackup. This patch makes it all
consistent for git-gui

Signed-off-by: Ferry Huberts <ferry.huberts@pelagic.nl>
---
Based on pu

Shawn, I think you said you already applied this, I'm still resending to keep
the series complete.

 git-gui/git-gui.sh        |    2 +-
 git-gui/lib/mergetool.tcl |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/git-gui/git-gui.sh b/git-gui/git-gui.sh
index e018e07..e4e643a 100755
--- a/git-gui/git-gui.sh
+++ b/git-gui/git-gui.sh
@@ -699,7 +699,7 @@ proc apply_config {} {
 
 set default_config(branch.autosetupmerge) true
 set default_config(merge.tool) {}
-set default_config(merge.keepbackup) true
+set default_config(mergetool.keepbackup) true
 set default_config(merge.diffstat) true
 set default_config(merge.summary) false
 set default_config(merge.verbosity) 2
diff --git a/git-gui/lib/mergetool.tcl b/git-gui/lib/mergetool.tcl
index eb2b4b5..b7263b3 100644
--- a/git-gui/lib/mergetool.tcl
+++ b/git-gui/lib/mergetool.tcl
@@ -382,7 +382,7 @@ proc merge_tool_finish {fd} {
 		delete_temp_files $mtool_tmpfiles
 		ui_status [mc "Merge tool failed."]
 	} else {
-		if {[is_config_true merge.keepbackup]} {
+		if {[is_config_true mergetool.keepbackup]} {
 			file rename -force -- $backup "$mtool_target.orig"
 		}
 
-- 
1.6.0.6
