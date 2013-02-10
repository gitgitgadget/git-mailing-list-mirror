From: "W. Trevor King" <wking@tremily.us>
Subject: [PATCH v2 05/15] user-manual: Add a few references to 'git rebase -i'
Date: Sun, 10 Feb 2013 10:10:31 -0500
Message-ID: <4931d9fc83155b29787a3d33a7ac87dbfaa04795.1360508415.git.wking@tremily.us>
References: <7vzjzexv8l.fsf@alter.siamese.dyndns.org>
 <cover.1360508415.git.wking@tremily.us>
Cc: Junio C Hamano <gitster@pobox.com>,
	"W. Trevor King" <wking@tremily.us>
To: Git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Feb 10 16:12:37 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U4Ya4-00015X-Ip
	for gcvg-git-2@plane.gmane.org; Sun, 10 Feb 2013 16:12:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760549Ab3BJPLo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 Feb 2013 10:11:44 -0500
Received: from vms173021pub.verizon.net ([206.46.173.21]:60120 "EHLO
	vms173021pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755976Ab3BJPLm (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Feb 2013 10:11:42 -0500
Received: from odin.tremily.us ([unknown] [72.68.84.219])
 by vms173021.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0MI000MHOFIC0080@vms173021.mailsrvcs.net> for
 git@vger.kernel.org; Sun, 10 Feb 2013 09:11:32 -0600 (CST)
Received: by odin.tremily.us (Postfix, from userid 1000)	id 2B8CD87927C; Sun,
 10 Feb 2013 10:11:00 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tremily.us; s=odin;
	t=1360509060; bh=YUMn6zdVC/4XexJWiy7mk8ddkcJlrTAMoPvAcc+rvTQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:In-Reply-To:	 References;
	b=BGeNSZiqW7wtZenaXkiGhOeJ9aaAtCMxxct+8iPQKKCSUGNWzUBqd0HMe003jl2AE
 pqc+fV50WKByCP0KiA3qZpdirmtEofsF5BHiNC9RFBFVFCCZ/uUJKsRyXKZlvuCtNO
 QE3BSafALbHuufn86yDHXrZziSe12pEgfCCnCVPY=
X-Mailer: git-send-email 1.7.12.4
In-reply-to: <cover.1360508415.git.wking@tremily.us>
In-reply-to: <cover.1360508415.git.wking@tremily.us>
References: <cover.1360508415.git.wking@tremily.us>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215917>

From: "W. Trevor King" <wking@tremily.us>

I think this interface is much more convenient than extended cherry
picking or using 'git format-patch'.  Inserting a number of references
should raise awareness among new users.  The previously discussed
methods (cherry picking and format-patch-ing) are still useful,
because all of these approaches have the same effect, which may help
demystify the process for newbies.

Signed-off-by: W. Trevor King <wking@tremily.us>
---
 Documentation/user-manual.txt | 21 +++++++++++++++++----
 1 file changed, 17 insertions(+), 4 deletions(-)

diff --git a/Documentation/user-manual.txt b/Documentation/user-manual.txt
index a8f792d..5d80b40 100644
--- a/Documentation/user-manual.txt
+++ b/Documentation/user-manual.txt
@@ -2532,6 +2532,13 @@ return mywork to the state it had before you started the rebase:
 $ git rebase --abort
 -------------------------------------------------
 
+If you need to reorder or edit a number of commits in a branch, it may
+be easier to use `git rebase -i`, which allows you to reorder and
+squash commits, as well as marking them for individual editing during
+the rebase.  See linkgit:git-rebase[1] for details, and
+<<reordering-patch-series>> for alternatives.
+
+
 [[rewriting-one-commit]]
 Rewriting a single commit
 -------------------------
@@ -2546,10 +2553,10 @@ $ git commit --amend
 which will replace the old commit by a new commit incorporating your
 changes, giving you a chance to edit the old commit message first.
 
-You can also use a combination of this and linkgit:git-rebase[1] to
-replace a commit further back in your history and recreate the
-intervening changes on top of it.  First, tag the problematic commit
-with
+You can also use a combination of `commit --amend` and
+linkgit:git-rebase[1] (see <<using-git-rebase>>) to replace a commit
+further back in your history and recreate the intervening changes on
+top of it.  First, tag the problematic commit with
 
 -------------------------------------------------
 $ git tag bad mywork~5
@@ -2584,6 +2591,12 @@ new commits having new object names.
 Reordering or selecting from a patch series
 -------------------------------------------
 
+There are a number of ways you can go about editing an existing patch
+series.  The easiest way is probably by using `git rebase -i`,
+mentioned in <<using-git-rebase>>, but whether you use
+linkgit:git-rebase[1] or one of the methods discussed below, the
+effect is the same.  Pick whichever approach you like best.
+
 Given one existing commit, the linkgit:git-cherry-pick[1] command
 allows you to apply the change introduced by that commit and create a
 new commit that records it.  So, for example, if "mywork" points to a
-- 
1.8.1.336.g94702dd
