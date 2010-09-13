From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: [PATCH 6/6] git-reset.txt: make modes description more consistent
Date: Mon, 13 Sep 2010 10:06:36 +0200
Message-ID: <d4a048c1cfd39a2d7ab8a86554bb48937629620c.1284365021.git.git@drmicha.warpmail.net>
References: <cover.1284365021.git.git@drmicha.warpmail.net>
Cc: Junio C Hamano <gitster@pobox.com>,
	Christian Couder <chriscool@tuxfamily.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 13 10:16:32 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ov4DG-0004Wz-HA
	for gcvg-git-2@lo.gmane.org; Mon, 13 Sep 2010 10:16:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754596Ab0IMIQY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 Sep 2010 04:16:24 -0400
Received: from out2.smtp.messagingengine.com ([66.111.4.26]:39155 "EHLO
	out2.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751582Ab0IMIQV (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 13 Sep 2010 04:16:21 -0400
Received: from compute3.internal (compute3.nyi.mail.srv.osa [10.202.2.43])
	by gateway1.messagingengine.com (Postfix) with ESMTP id A1658E2;
	Mon, 13 Sep 2010 04:06:45 -0400 (EDT)
Received: from frontend1.messagingengine.com ([10.202.2.160])
  by compute3.internal (MEProxy); Mon, 13 Sep 2010 04:06:45 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=from:to:cc:subject:date:message-id:in-reply-to:references; s=smtpout; bh=w1iVD87mTNpvUm15mll7PQtVmLI=; b=tqfvTSvN9FepL91EB/MnpbvjbqGF1G2uyE9e5x28K9F/A38ANIB9uAMcOa11OQpAL28S6TFjBmHwIOUIy2y2ttaGAujhf2P2vK0oiTlxb3E9D2jQl90NR9VgzAS7qOgyn39Mhe4ZvJWh9G7RMKfOrxJfvBFrvg/Rk7uvwWWCzcI=
X-Sasl-enc: BDDBmSpLe6ye64mFFb8t31fzz3XOtsJGsNPIn89iUFDB 1284365205
Received: from localhost (heawood.math.tu-clausthal.de [139.174.44.4])
	by mail.messagingengine.com (Postfix) with ESMTPSA id F354D4053A4;
	Mon, 13 Sep 2010 04:06:44 -0400 (EDT)
X-Mailer: git-send-email 1.7.3.rc1.215.g6997c
In-Reply-To: <cover.1284365021.git.git@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156076>

Currently, the structure of the individual mode entries is different
which makes it difficult to grasp the differences between the modes.
Also, the same items are named differently (e.g. <commit>, "the named
commit", "the given commit", "the commit being switched to").

Structure and word all mode entries consistently.

Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
---
 Documentation/git-reset.txt |   43 ++++++++++++++++++++++++++-----------------
 1 files changed, 26 insertions(+), 17 deletions(-)

diff --git a/Documentation/git-reset.txt b/Documentation/git-reset.txt
index 40e2fd8..6b60b59 100644
--- a/Documentation/git-reset.txt
+++ b/Documentation/git-reset.txt
@@ -15,13 +15,13 @@ SYNOPSIS
 DESCRIPTION
 -----------
 In the first and second form, copy entries from <commit> to the index.
-In the third form, set the current branch head to <commit>, optionally
+In the third form, set the current branch head (HEAD) to <commit>, optionally
 modifying index and working tree to match.  The <commit> defaults to HEAD
 in all forms.
 
 'git reset' [-q] [<commit>] [--] <paths>...::
 	This form resets the index entries for all <paths> to their
-	state at the <commit>.  (It does not affect the working tree, nor
+	state at <commit>.  (It does not affect the working tree, nor
 	the current branch.)
 +
 This means that `git reset <paths>` is the opposite of `git add
@@ -39,9 +39,10 @@ This means that `git reset -p` is the opposite of `git add -p` (see
 linkgit:git-add[1]).
 
 'git reset' [--<mode>] [<commit>]::
-	This form sets the current branch head to <commit> and then
-	updates index and working tree according to <mode>, which must
-	be one of the following:
+	This form sets the current branch head to <commit> and
+	possibly updates the index (resetting it to the tree of <commit>) and
+	the working tree depending on <mode>, which
+	must be one of the following:
 +
 --
 --soft::
@@ -57,22 +58,30 @@ linkgit:git-add[1]).
 	been updated. This is the default action.
 
 --hard::
-	Matches the working tree and index to that of the tree being
-	switched to. Any changes to tracked files in the working tree
-	since <commit> are lost.
+	Resets the index and working tree. Any changes to tracked files in the
+	working tree since <commit> are lost.
 
 --merge::
-	Resets the index to match the tree recorded by the named commit,
-	and updates the files that are different between the named commit
-	and the current commit in the working tree.
+	Resets the index and updates the files in the working tree that are
+	different between <commit> and HEAD, but keeps those which are
+	different between the index and working tree (i.e. which have unstaged
+	changes).
+	If a file that is different between <commit> and the index has unstaged
+	changes, reset is aborted.
++
+In other words, --merge does something like a 'git read-tree -u -m <commit>',
+but carries forward unmerged index entries.
 
 --keep::
-	Reset the index to the given commit, keeping local changes in
-	the working tree since the current commit, while updating
-	working tree files without local changes to what appears in
-	the given commit.  If a file that is different between the
-	current commit and the given commit has local changes, reset
-	is aborted.
+	Resets the index, updates files in the working tree that are
+	different between <commit> and HEAD, but keeps those
+	which are different between HEAD and the working tree (i.e.
+	which have local changes).
+	If a file that is different between <commit> and HEAD has local changes,
+	reset is aborted.
++
+In other words, --keep does a 2-way merge between <commit> and HEAD followed by
+'git reset --mixed <commit>'.
 --
 
 If you want to undo a commit other than the latest on a branch,
-- 
1.7.3.rc1.215.g6997c
