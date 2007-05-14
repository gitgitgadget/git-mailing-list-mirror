From: "J. Bruce Fields" <bfields@citi.umich.edu>
Subject: [PATCH 02/10] user-manual: revise birdseye-view chapter
Date: Mon, 14 May 2007 11:21:21 -0400
Message-ID: <30964.7168651738$1179156134@news.gmane.org>
References: <11791560893572-git-send-email->
Cc: git@vger.kernel.org, "J. Bruce Fields" <bfields@citi.umich.edu>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Mon May 14 17:22:12 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HncNG-0006P0-8M
	for gcvg-git@gmane.org; Mon, 14 May 2007 17:22:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754689AbXENPVe (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 14 May 2007 11:21:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756705AbXENPVe
	(ORCPT <rfc822;git-outgoing>); Mon, 14 May 2007 11:21:34 -0400
Received: from mail.fieldses.org ([66.93.2.214]:54957 "EHLO fieldses.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755414AbXENPVb (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 May 2007 11:21:31 -0400
Received: from bfields by fieldses.org with local (Exim 4.67)
	(envelope-from <bfields@fieldses.org>)
	id 1HncMb-0004z2-Hh; Mon, 14 May 2007 11:21:29 -0400
X-Mailer: git-send-email 1.5.1.4.19.g69e2
In-Reply-To: <11791560893572-git-send-email->
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47251>

From: J. Bruce Fields <bfields@citi.umich.edu>

Some revisions suggested by Junio along with some minor style fixes and
one compile fix (asterisks need escaping).

Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Signed-off-by: "J. Bruce Fields" <bfields@citi.umich.edu>
---
 Documentation/user-manual.txt |   43 +++++++++++++++++++---------------------
 1 files changed, 20 insertions(+), 23 deletions(-)

diff --git a/Documentation/user-manual.txt b/Documentation/user-manual.txt
index bac9660..7abdc3e 100644
--- a/Documentation/user-manual.txt
+++ b/Documentation/user-manual.txt
@@ -3161,8 +3161,12 @@ contrast, running "git prune" while somebody is actively changing the
 repository is a *BAD* idea).
 
 [[birdview-on-the-source-code]]
-A birdview on Git's source code
------------------------------
+A birds-eye view of Git's source code
+-------------------------------------
+
+It is not always easy for new developers to find their way through Git's
+source code.  This section gives you a gentle guidance to show where to
+start.
 
 While Git's source code is quite elegant, it is not always easy for
 new  developers to find their way through it.  A good idea is to look
@@ -3171,33 +3175,26 @@ _e83c5163316f89bfbde7d9ab23ca2e25604af290_ (also known as _v0.99~954_).
 
 Tip: you can see what files are in there with
 
+A good place to start is with the contents of the initial commit, with:
+
 ----------------------------------------------------
-$ git show e83c5163316f89bfbde7d9ab23ca2e25604af290:
+$ git checkout e83c5163
 ----------------------------------------------------
 
-and look at those files with something like
-
------------------------------------------------------------
-$ git show e83c5163316f89bfbde7d9ab23ca2e25604af290:cache.h
------------------------------------------------------------
-
-Be sure to read the README in that revision _after_ you are familiar with
-the terminology (<<glossary>>), since the terminology has changed a little
-since then.  For example, we call the things "commits" now, which are
-described in that README as "changesets".
+The initial revision lays the foundation for almost everything git has
+today, but is small enough to read in one sitting.
 
-Actually a lot of the structure as it is now can be explained by that
-initial commit.
+Note that terminology has changed since that revision.  For example, the
+README in that revision uses the word "changeset" to describe what we
+now call a <<def_commit_object,commit>>.
 
-For example, we do not call it "cache" any more, but "index", however, the
+Also, we do not call it "cache" any more, but "index", however, the
 file is still called `cache.h`.  Remark: Not much reason to change it now,
 especially since there is no good single name for it anyway, because it is
 basically _the_ header file which is included by _all_ of Git's C sources.
 
-If you grasp the ideas in that initial commit (it is really small and you
-can get into it really fast, and it will help you recognize things in the
-much larger code base we have now), you should go on skimming `cache.h`,
-`object.h` and `commit.h` in the current version.
+If you grasp the ideas in that initial commit, you should check out a
+more recent version and skim `cache.h`, `object.h` and `commit.h`.
 
 In the early days, Git (in the tradition of UNIX) was a bunch of programs
 which were extremely simple, and which you used in scripts, piping the
@@ -3320,11 +3317,11 @@ Two things are interesting here:
   negative numbers in case of different errors -- and 0 on success.
 
 - the variable `sha1` in the function signature of `get_sha1()` is `unsigned
-  char *`, but is actually expected to be a pointer to `unsigned
+  char \*`, but is actually expected to be a pointer to `unsigned
   char[20]`.  This variable will contain the 160-bit SHA-1 of the given
-  commit.  Note that whenever a SHA-1 is passed as "unsigned char *", it
+  commit.  Note that whenever a SHA-1 is passed as `unsigned char \*`, it
   is the binary representation, as opposed to the ASCII representation in
-  hex characters, which is passed as "char *".
+  hex characters, which is passed as `char *`.
 
 You will see both of these things throughout the code.
 
-- 
1.5.1.4.19.g69e2
