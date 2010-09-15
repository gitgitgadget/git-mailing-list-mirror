From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: [PATCHv2 6/6] git-reset.txt: make modes description more consistent
Date: Wed, 15 Sep 2010 22:47:44 +0200
Message-ID: <f457ad06ac395e1db17e74ad3180ec42d7fafa45.1284582409.git.git@drmicha.warpmail.net>
References: <cover.1284365021.git.git@drmicha.warpmail.net>
Cc: Jay Soffian <jaysoffian@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 15 22:49:18 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ovyuq-0005JE-A2
	for gcvg-git-2@lo.gmane.org; Wed, 15 Sep 2010 22:49:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755213Ab0IOUr5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 Sep 2010 16:47:57 -0400
Received: from out2.smtp.messagingengine.com ([66.111.4.26]:34691 "EHLO
	out2.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755158Ab0IOUr4 (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 15 Sep 2010 16:47:56 -0400
Received: from compute2.internal (compute2.nyi.mail.srv.osa [10.202.2.42])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 9248F62D;
	Wed, 15 Sep 2010 16:47:55 -0400 (EDT)
Received: from frontend1.messagingengine.com ([10.202.2.160])
  by compute2.internal (MEProxy); Wed, 15 Sep 2010 16:47:55 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=from:to:cc:subject:date:message-id:in-reply-to:references:in-reply-to:references; s=smtpout; bh=wowA9gLMfVFCq5QXKoK1ryrtva4=; b=GfYatM+3E90p2aBoTBS6jMOGmhAeCIsWFz2LkjdJkNBy/Y9cmSaaXmtTJ1wckhX/89R30nFHgv1bxbsjUtBMFcERxbp2w8GrE2aUWHuRROiawYzhSMrw723sq6yF0AxSbH/J381bdMDB4J5P8VV2tSFDRdJsWA8yjLjP9t2SQTM=
X-Sasl-enc: m7wTUdLcm4krYKZFt2H+vy2q/RnwefgwyS8ODeumBMKt 1284583674
Received: from localhost (p548580A7.dip0.t-ipconnect.de [84.133.128.167])
	by mail.messagingengine.com (Postfix) with ESMTPSA id A781B400500;
	Wed, 15 Sep 2010 16:47:54 -0400 (EDT)
X-Mailer: git-send-email 1.7.3.rc1.215.g6997c
In-Reply-To: <cover.1284365021.git.git@drmicha.warpmail.net>
In-Reply-To: <cover.1284582409.git.git@drmicha.warpmail.net>
References: <cover.1284582409.git.git@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156253>

Currently, the structure of the individual mode entries is different
which makes it difficult to grasp the differences between the modes.
Also, the same items are named differently (e.g. <commit>, "the named
commit", "the given commit", "the commit being switched to").

Structure and word all mode entries consistently.

Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>

Conflicts:

	Documentation/git-reset.txt

Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
---
 Documentation/git-reset.txt |   43 ++++++++++++++++++++++++++-----------------
 1 files changed, 26 insertions(+), 17 deletions(-)

diff --git a/Documentation/git-reset.txt b/Documentation/git-reset.txt
index 78f3b74..fd72976 100644
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
@@ -43,9 +43,10 @@ This means that `git reset -p` is the opposite of `git add -p` (see
 linkgit:git-add[1]).
 
 'git reset' [--<mode>] [<commit>]::
-	This form resets the current branch head to <commit> and then
-	updates index and working tree according to <mode>, which must
-	be one of the following:
+	This form resets the current branch head to <commit> and
+	possibly updates the index (resetting it to the tree of <commit>) and
+	the working tree depending on <mode>, which
+	must be one of the following:
 +
 --
 --soft::
@@ -60,22 +61,30 @@ linkgit:git-add[1]).
 	been updated. This is the default action.
 
 --hard::
-	Matches the working tree and index to that of the tree being
-	switched to. Any changes to tracked files in the working tree
-	since <commit> are lost.
+	Resets the index and working tree. Any changes to tracked files in the
+	working tree since <commit> are discarded.
 
 --merge::
-	Resets the index to match the tree recorded by the named commit,
-	and updates the files that are different between the named commit
-	and the current commit in the working tree.
+	Resets the index and updates the files in the working tree that are
+	different between <commit> and HEAD, but keeps those which are
+	different between the index and working tree (i.e. which have changes
+	which have not been added).
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
