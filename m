From: "J. Bruce Fields" <bfields@citi.umich.edu>
Subject: [PATCH 1/6] user-manual: more discussion of detached heads, fix typos
Date: Mon,  7 May 2007 01:13:57 -0400
Message-ID: <36724.5747046129$1178514857@news.gmane.org>
References: <11785148422793-git-send-email->
Cc: git@vger.kernel.org, "J. Bruce Fields" <bfields@citi.umich.edu>,
	Nicolas Pitre <nico@cam.org>
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Mon May 07 07:14:14 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HkvY6-0008TI-7H
	for gcvg-git@gmane.org; Mon, 07 May 2007 07:14:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753979AbXEGFOI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 7 May 2007 01:14:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753990AbXEGFOH
	(ORCPT <rfc822;git-outgoing>); Mon, 7 May 2007 01:14:07 -0400
Received: from mail.fieldses.org ([66.93.2.214]:53659 "EHLO fieldses.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753979AbXEGFOF (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 May 2007 01:14:05 -0400
Received: from bfields by fieldses.org with local (Exim 4.67)
	(envelope-from <bfields@fieldses.org>)
	id 1HkvXv-0005Zf-Ms; Mon, 07 May 2007 01:14:03 -0400
X-Mailer: git-send-email 1.5.1.1.98.gedb4f
In-Reply-To: <11785148422793-git-send-email->
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46410>

From: J. Bruce Fields <bfields@citi.umich.edu>

Nicolas Pitre pointed out a couple typos and some room for improvement
in the discussion of detached heads.

Signed-off-by: "J. Bruce Fields" <bfields@citi.umich.edu>
Cc: Nicolas Pitre <nico@cam.org>
---
 Documentation/user-manual.txt |   20 +++++++++++++++-----
 1 files changed, 15 insertions(+), 5 deletions(-)

diff --git a/Documentation/user-manual.txt b/Documentation/user-manual.txt
index dff438f..54fd413 100644
--- a/Documentation/user-manual.txt
+++ b/Documentation/user-manual.txt
@@ -527,17 +527,16 @@ and git branch shows that you are no longer on a branch:
 ------------------------------------------------
 $ cat .git/HEAD
 427abfa28afedffadfca9dd8b067eb6d36bac53f
-git branch
+$ git branch
 * (no branch)
   master
 ------------------------------------------------
 
 In this case we say that the HEAD is "detached".
 
-This can be an easy way to check out a particular version without having
-to make up a name for a new branch.  However, keep in mind that when you
-switch away from the (for example, by checking out something else), you
-can lose track of what the HEAD used to point to.
+This is an easy way to check out a particular version without having to
+make up a name for the new branch.   You can still create a new branch
+(or tag) for this version later if you decide to.
 
 Examining branches from a remote repository
 -------------------------------------------
@@ -1560,8 +1559,19 @@ $ git show master@{2}		# See where the branch pointed 2,
 $ git show master@{3}		# 3, ... changes ago.
 $ gitk master@{yesterday}	# See where it pointed yesterday,
 $ gitk master@{"1 week ago"}	# ... or last week
+$ git log --walk-reflogs master	# show reflog entries for master
+-------------------------------------------------
+
+A separate reflog is kept for the HEAD, so
+
+-------------------------------------------------
+$ git show HEAD@{"1 week ago"}
 -------------------------------------------------
 
+will show what HEAD pointed to one week ago, not what the current branch
+pointed to one week ago.  This allows you to see the history of what
+you've checked out.
+
 The reflogs are kept by default for 30 days, after which they may be
 pruned.  See gitlink:git-reflog[1] and gitlink:git-gc[1] to learn
 how to control this pruning, and see the "SPECIFYING REVISIONS"
-- 
1.5.1.1.98.gedb4f
