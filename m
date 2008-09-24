From: pasky@suse.cz
Subject: [PATCH 1/5] git-gui: Clarify the Remote -> Delete... action
Date: Wed, 24 Sep 2008 22:43:59 +0200
Message-ID: <20080924204614.264799440@suse.cz>
References: <20080924204358.144077183@suse.cz>
Cc: spearce@spearce.org
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 24 22:47:44 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KibGr-0002ed-1s
	for gcvg-git-2@gmane.org; Wed, 24 Sep 2008 22:47:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752506AbYIXUq2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Sep 2008 16:46:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752533AbYIXUq1
	(ORCPT <rfc822;git-outgoing>); Wed, 24 Sep 2008 16:46:27 -0400
Received: from [212.249.11.140] ([212.249.11.140]:46828 "EHLO pixie.suse.cz"
	rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752424AbYIXUqZ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Sep 2008 16:46:25 -0400
Received: by pixie.suse.cz (Postfix, from userid 2001)
	id D762E2AC8FB; Wed, 24 Sep 2008 22:46:14 +0200 (CEST)
User-Agent: quilt/0.46_cvs20080326-19.1
Content-Disposition: inline; filename=t/git-gui/delbranch.diff
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96691>

Currently, it was not really clear what all does this perform. We rename
"Delete..." to "Delete Branch..." (since this does not delete the remote
as a whole) and relabel the window from "Delete Remote Branch" to "Delete
Branch Remotely" (since the action also involves pushing the delete out).

This patch has been sponsored by Novartis.

Signed-off-by: Petr Baudis <pasky@suse.cz>

---
 git-gui/git-gui.sh                   |    2 +-
 git-gui/lib/remote_branch_delete.tcl |    4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/git-gui/git-gui.sh b/git-gui/git-gui.sh
index 10d8a44..355c782 100755
--- a/git-gui/git-gui.sh
+++ b/git-gui/git-gui.sh
@@ -2309,7 +2309,7 @@ if {[is_enabled transport]} {
 		-command do_push_anywhere \
 		-accelerator $M1T-P
 	.mbar.remote add command \
-		-label [mc "Delete..."] \
+		-label [mc "Delete Branch..."] \
 		-command remote_branch_delete::dialog
 }
 
diff --git a/git-gui/lib/remote_branch_delete.tcl b/git-gui/lib/remote_branch_delete.tcl
index c7b8148..fbcfb27 100644
--- a/git-gui/lib/remote_branch_delete.tcl
+++ b/git-gui/lib/remote_branch_delete.tcl
@@ -26,12 +26,12 @@ constructor dialog {} {
 	global all_remotes M1B
 
 	make_toplevel top w
-	wm title $top [append "[appname] ([reponame]): " [mc "Delete Remote Branch"]]
+	wm title $top [append "[appname] ([reponame]): " [mc "Delete Branch Remotely"]]
 	if {$top ne {.}} {
 		wm geometry $top "+[winfo rootx .]+[winfo rooty .]"
 	}
 
-	label $w.header -text [mc "Delete Remote Branch"] -font font_uibold
+	label $w.header -text [mc "Delete Branch Remotely"] -font font_uibold
 	pack $w.header -side top -fill x
 
 	frame $w.buttons
-- 
tg: (c427559..) t/git-gui/delbranch (depends on: vanilla/master)
