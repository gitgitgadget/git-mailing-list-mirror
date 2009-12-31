From: public_vi@tut.by
Subject: [PATCH] git-gui: Add hotkeys for "Unstage from commit" and "Revert changes"
Date: Thu, 31 Dec 2009 15:32:53 +0200
Message-ID: <1262266373-7314-1-git-send-email-public_vi@tut.by>
Cc: public_vi@tut.by
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Dec 31 14:33:54 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NQLA1-0006up-TK
	for gcvg-git-2@lo.gmane.org; Thu, 31 Dec 2009 14:33:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751951AbZLaNdt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 Dec 2009 08:33:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751944AbZLaNdt
	(ORCPT <rfc822;git-outgoing>); Thu, 31 Dec 2009 08:33:49 -0500
Received: from mail-fx0-f225.google.com ([209.85.220.225]:54577 "EHLO
	mail-fx0-f225.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750898AbZLaNds (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 Dec 2009 08:33:48 -0500
Received: by fxm25 with SMTP id 25so6676579fxm.21
        for <git@vger.kernel.org>; Thu, 31 Dec 2009 05:33:46 -0800 (PST)
Received: by 10.223.103.25 with SMTP id i25mr13440466fao.64.1262266426436;
        Thu, 31 Dec 2009 05:33:46 -0800 (PST)
Received: from localhost.localdomain ([93.125.23.47])
        by mx.google.com with ESMTPS id 16sm4910353fxm.12.2009.12.31.05.33.44
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 31 Dec 2009 05:33:45 -0800 (PST)
X-Mailer: git-send-email 1.6.5.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135948>

From: Vitaly _Vi Shukela <public_vi@tut.by>

Signed-off-by: Vitaly _Vi Shukela <public_vi@tut.by>
---
 git-gui/git-gui.sh |   10 ++++++++--
 1 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/git-gui/git-gui.sh b/git-gui/git-gui.sh
index 14b92ba..28270ad 100755
--- a/git-gui/git-gui.sh
+++ b/git-gui/git-gui.sh
@@ -2509,12 +2509,14 @@ if {[is_enabled multicommit] || [is_enabled singlecommit]} {
 		[list .mbar.commit entryconf [.mbar.commit index last] -state]
 
 	.mbar.commit add command -label [mc "Unstage From Commit"] \
-		-command do_unstage_selection
+		-command do_unstage_selection \
+		-accelerator $M1T-U
 	lappend disable_on_lock \
 		[list .mbar.commit entryconf [.mbar.commit index last] -state]
 
 	.mbar.commit add command -label [mc "Revert Changes"] \
-		-command do_revert_selection
+		-command do_revert_selection \
+		-accelerator $M1T-J
 	lappend disable_on_lock \
 		[list .mbar.commit entryconf [.mbar.commit index last] -state]
 
@@ -3254,6 +3256,10 @@ unset gm
 bind $ui_comm <$M1B-Key-Return> {do_commit;break}
 bind $ui_comm <$M1B-Key-t> {do_add_selection;break}
 bind $ui_comm <$M1B-Key-T> {do_add_selection;break}
+bind $ui_comm <$M1B-Key-u> {do_unstage_selection;break}
+bind $ui_comm <$M1B-Key-U> {do_unstage_selection;break}
+bind $ui_comm <$M1B-Key-j> {do_revert_selection;break}
+bind $ui_comm <$M1B-Key-J> {do_revert_selection;break}
 bind $ui_comm <$M1B-Key-i> {do_add_all;break}
 bind $ui_comm <$M1B-Key-I> {do_add_all;break}
 bind $ui_comm <$M1B-Key-x> {tk_textCut %W;break}
-- 
1.6.5.6
