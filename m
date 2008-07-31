From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH] documentation: user-manual: update "using-bisect" section
Date: Thu, 31 Jul 2008 05:22:40 +0200
Message-ID: <20080731052240.23455ddb.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jul 31 05:20:01 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KOOhp-0005gz-88
	for gcvg-git-2@gmane.org; Thu, 31 Jul 2008 05:19:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757286AbYGaDSz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Jul 2008 23:18:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756937AbYGaDSz
	(ORCPT <rfc822;git-outgoing>); Wed, 30 Jul 2008 23:18:55 -0400
Received: from smtp5-g19.free.fr ([212.27.42.35]:52169 "EHLO smtp5-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755231AbYGaDSz (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Jul 2008 23:18:55 -0400
Received: from smtp5-g19.free.fr (localhost.localdomain [127.0.0.1])
	by smtp5-g19.free.fr (Postfix) with ESMTP id C4B8F3F6164;
	Thu, 31 Jul 2008 05:18:52 +0200 (CEST)
Received: from localhost.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp5-g19.free.fr (Postfix) with SMTP id 8B1A73F6167;
	Thu, 31 Jul 2008 05:18:52 +0200 (CEST)
X-Mailer: Sylpheed 2.5.0 (GTK+ 2.12.10; i486-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90888>

Since version 1.5.6 "git bisect" doesn't use a "bisect" branch any
more, but the user manual had not been updated to reflect this.

So this patch does that and while at it also adds a few words about
"git bisect skip" and points user to the "git bisect" man page for
more information.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 Documentation/user-manual.txt |   27 +++++++++++++++++++++------
 1 files changed, 21 insertions(+), 6 deletions(-)

diff --git a/Documentation/user-manual.txt b/Documentation/user-manual.txt
index c5641af..50bf85f 100644
--- a/Documentation/user-manual.txt
+++ b/Documentation/user-manual.txt
@@ -479,10 +479,10 @@ Bisecting: 3537 revisions left to test after this
 -------------------------------------------------
 
 If you run "git branch" at this point, you'll see that git has
-temporarily moved you to a new branch named "bisect".  This branch
-points to a commit (with commit id 65934...) that is reachable from
-"master" but not from v2.6.18.  Compile and test it, and see whether
-it crashes.  Assume it does crash.  Then:
+temporarily moved you in "(no branch)". HEAD is now detached from any
+branch and points directly to a commit (with commit id 65934...) that
+is reachable from "master" but not from v2.6.18. Compile and test it,
+and see whether it crashes. Assume it does crash. Then:
 
 -------------------------------------------------
 $ git bisect bad
@@ -504,8 +504,7 @@ report with the commit id.  Finally, run
 $ git bisect reset
 -------------------------------------------------
 
-to return you to the branch you were on before and delete the
-temporary "bisect" branch.
+to return you to the branch you were on before.
 
 Note that the version which git-bisect checks out for you at each
 point is just a suggestion, and you're free to try a different
@@ -528,6 +527,22 @@ $ git reset --hard fb47ddb2db...
 then test, run "bisect good" or "bisect bad" as appropriate, and
 continue.
 
+Instead of "git bisect visualize" and then "git reset --hard
+fb47ddb2db...", you might just want to tell git that you want to skip
+the current commit:
+
+-------------------------------------------------
+$ git bisect skip
+-------------------------------------------------
+
+In this case, though, git may not eventually be able to tell the first
+bad one between some first skipped commits and a latter bad commit.
+
+There are also ways to automate the bisecting process if you have a
+test script that can tell a good from a bad commit. See
+linkgit:git-bisect[1] for more information about this and other "git
+bisect" features.
+
 [[naming-commits]]
 Naming commits
 --------------
-- 
1.6.0.rc0.42.g186458.dirty
