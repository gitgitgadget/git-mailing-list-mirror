From: exon@op5.se (Andreas Ericsson)
Subject: [PATCH] git-reset.txt: Small fix + clarifications.
Date: Sun, 20 Nov 2005 22:42:11 +0100 (CET)
Message-ID: <20051120214211.09A595BF78@nox.op5.se>
X-From: git-owner@vger.kernel.org Sun Nov 20 22:42:31 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Edwwz-0003OK-4z
	for gcvg-git@gmane.org; Sun, 20 Nov 2005 22:42:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932083AbVKTVmO (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 20 Nov 2005 16:42:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932082AbVKTVmN
	(ORCPT <rfc822;git-outgoing>); Sun, 20 Nov 2005 16:42:13 -0500
Received: from linux-server1.op5.se ([193.201.96.2]:45804 "EHLO
	smtp-gw1.op5.se") by vger.kernel.org with ESMTP id S932083AbVKTVmN
	(ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 Nov 2005 16:42:13 -0500
Received: from nox.op5.se (1-2-9-7a.gkp.gbg.bostream.se [82.182.116.44])
	by smtp-gw1.op5.se (Postfix) with ESMTP id 5978A6BD00
	for <git@vger.kernel.org>; Sun, 20 Nov 2005 22:42:12 +0100 (CET)
Received: by nox.op5.se (Postfix, from userid 500)
	id 09A595BF78; Sun, 20 Nov 2005 22:42:11 +0100 (CET)
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12403>


This basically translates the man-page from 'git-developerish' to plain
english, adding some almost-sample output from git-status so users can
recognize what will happen.

Also mention explicitly that --mixed updates the index, while --soft
doesn't. I understood the old text to mean "--mixed is exactly like
--soft, but verbose".

Signed-off-by: Andreas Ericsson <ae@op5.se>

---

 Documentation/git-reset.txt |   19 +++++++++++++++----
 1 files changed, 15 insertions(+), 4 deletions(-)

applies-to: 0262dd41632580ee56288ad12fce71b6d260bf38
615aa2e01117c5ec82df3a5ad2f0328c89acdde8
diff --git a/Documentation/git-reset.txt b/Documentation/git-reset.txt
index 31ec207..6af3a4f 100644
--- a/Documentation/git-reset.txt
+++ b/Documentation/git-reset.txt
@@ -14,19 +14,30 @@ DESCRIPTION
 Sets the current head to the specified commit and optionally resets the
 index and working tree to match.
 
+This command is useful if you notice some small error in a recent
+commit (or set of commits) and want to redo that part without showing
+the undo in the history.
+
+If you want to undo a commit other than the latest on a branch,
+gitlink:git-revert[1] is your friend.
+
 OPTIONS
 -------
 --mixed::
-	Like --soft but reports what has not been updated. This is the
-	default action.
+	Resets the index but not the working tree (ie, the changed files
+	are preserved but not marked for commit) and reports what has not
+	been updated. This is the default action.
 
 --soft::
 	Does not touch the index file nor the working tree at all, but
-	requires them in a good order.
+	requires them to be in a good order. This leaves all your changed
+	files "Updated but not checked in", as gitlink:git-status[1] would
+	put it.
 
 --hard::
 	Matches the working tree and index to that of the tree being
-	switched to.
+	switched to. Any changes to tracked files in the working tree
+	since <commit-ish> are lost.
 
 <commit-ish>::
 	Commit to make the current HEAD.
---
0.99.9.GIT
