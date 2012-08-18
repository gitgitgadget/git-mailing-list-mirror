From: Beat Bolli <bbolli@ewanet.ch>
Subject: [PATCH 2/2] git-gui: remove .git/CHERRY_PICK_HEAD after committing
Date: Sat, 18 Aug 2012 11:07:31 +0200
Message-ID: <1345280851-6626-2-git-send-email-bbolli@ewanet.ch>
References: <1345280851-6626-1-git-send-email-bbolli@ewanet.ch>
Cc: Beat Bolli <bbolli@ewanet.ch>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Aug 18 11:17:30 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T2f9s-0006ZR-Fy
	for gcvg-git-2@plane.gmane.org; Sat, 18 Aug 2012 11:17:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753265Ab2HRJQk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 18 Aug 2012 05:16:40 -0400
Received: from smtp2.mail.fcom.ch ([212.60.46.171]:42211 "EHLO
	smtp2.mail.fcom.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752451Ab2HRJQi (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 18 Aug 2012 05:16:38 -0400
X-Greylist: delayed 527 seconds by postgrey-1.27 at vger.kernel.org; Sat, 18 Aug 2012 05:16:38 EDT
Received: from smtp2.mail.fcom.ch (localhost [127.0.0.1])
	by smtp2 (Postfix) with ESMTP id B6AC52D4C1;
	Sat, 18 Aug 2012 11:07:59 +0200 (CEST)
X-Spam-Checker-Version: SpamAssassin 3.2.5 (2008-06-10) on smtp2.mail.fcom.ch
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=5.0 tests=BAYES_00,RCVD_IN_PBL,
	RCVD_IN_SORBS_DUL,RDNS_DYNAMIC autolearn=no version=3.2.5
Received: from drbeat.li (143-45-60-212-pool.cable.fcom.ch [212.60.45.143])
	by smtp2 (Postfix) with ESMTPS id 8DB1A2D4B5;
	Sat, 18 Aug 2012 11:07:59 +0200 (CEST)
Received: by drbeat.li (Postfix, from userid 1000)
	id 49EBF17F17; Sat, 18 Aug 2012 11:07:58 +0200 (CEST)
X-Mailer: git-send-email 1.7.10.4
In-Reply-To: <1345280851-6626-1-git-send-email-bbolli@ewanet.ch>
X-AV-Checked: ClamAV using ClamSMTP
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203672>

Adding __git_ps1() to one's bash prompt displays various repo status
info after each command. After committing a git cherry-pick -n using
git-gui, the prompt still contains the "|CHERRY-PICKING" flag.

Delete the file causing this flag when cleaning up.

Signed-off-by: Beat Bolli <bbolli@ewanet.ch>
---
 git-gui/lib/commit.tcl |    1 +
 1 file changed, 1 insertion(+)

diff --git a/git-gui/lib/commit.tcl b/git-gui/lib/commit.tcl
index 78c5eeb..864b687 100644
--- a/git-gui/lib/commit.tcl
+++ b/git-gui/lib/commit.tcl
@@ -409,6 +409,7 @@ A rescan will be automatically started now.
 	catch {file delete [gitdir MERGE_MSG]}
 	catch {file delete [gitdir SQUASH_MSG]}
 	catch {file delete [gitdir GITGUI_MSG]}
+	catch {file delete [gitdir CHERRY_PICK_HEAD]}
 
 	# -- Let rerere do its thing.
 	#
-- 
1.7.10.4
