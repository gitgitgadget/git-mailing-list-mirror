From: Markus Heidelberg <markus.heidelberg@web.de>
Subject: [PATCH] Documentation: sync example output with git output
Date: Fri, 19 Dec 2008 13:14:52 +0100
Message-ID: <200812191314.52544.markus.heidelberg@web.de>
Reply-To: markus.heidelberg@web.de
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Fri Dec 19 13:16:11 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LDeH1-0007WE-Ia
	for gcvg-git-2@gmane.org; Fri, 19 Dec 2008 13:16:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752731AbYLSMOj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Dec 2008 07:14:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752721AbYLSMOj
	(ORCPT <rfc822;git-outgoing>); Fri, 19 Dec 2008 07:14:39 -0500
Received: from fmmailgate03.web.de ([217.72.192.234]:46524 "EHLO
	fmmailgate03.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752560AbYLSMOh (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Dec 2008 07:14:37 -0500
Received: from smtp05.web.de (fmsmtp05.dlan.cinetic.de [172.20.4.166])
	by fmmailgate03.web.de (Postfix) with ESMTP id 0C89BF5963B4;
	Fri, 19 Dec 2008 13:14:27 +0100 (CET)
Received: from [91.19.63.31] (helo=pluto)
	by smtp05.web.de with asmtp (TLSv1:AES256-SHA:256)
	(WEB.DE 4.109 #226)
	id 1LDeFN-0003M1-00; Fri, 19 Dec 2008 13:14:25 +0100
User-Agent: KMail/1.9.9
Jabber-ID: markus.heidelberg@web.de
Content-Disposition: inline
X-Sender: markus.heidelberg@web.de
X-Provags-ID: V01U2FsdGVkX1/F9VGk6lEqDEcV/llqsbhtewbB09VZWdXC18Xa
	a5R+l+uwvxQv70zMSny9FoZXpwLtKIJQtP829iEl6jP91y8JsC
	mEUDdQqjamsQy9JYhsOQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103561>

Don't confuse the user with old git messages.

Signed-off-by: Markus Heidelberg <markus.heidelberg@web.de>
---
 Documentation/git-checkout.txt     |    1 -
 Documentation/git-reset.txt        |    2 +-
 Documentation/gitcore-tutorial.txt |   11 +++++------
 Documentation/pretty-formats.txt   |    6 +++---
 4 files changed, 9 insertions(+), 11 deletions(-)

diff --git a/Documentation/git-checkout.txt b/Documentation/git-checkout.txt
index 79824f4..9cd5151 100644
--- a/Documentation/git-checkout.txt
+++ b/Documentation/git-checkout.txt
@@ -232,7 +232,6 @@ the `-m` option, you would see something like this:
 ------------
 $ git checkout -m mytopic
 Auto-merging frotz
-merge: warning: conflicts during merge
 ERROR: Merge conflict in frotz
 fatal: merge program failed
 ------------
diff --git a/Documentation/git-reset.txt b/Documentation/git-reset.txt
index 29156f6..2049f3d 100644
--- a/Documentation/git-reset.txt
+++ b/Documentation/git-reset.txt
@@ -130,7 +130,7 @@ Undo a merge or pull::
 $ git pull                         <1>
 Auto-merging nitfol
 CONFLICT (content): Merge conflict in nitfol
-Automatic merge failed/prevented; fix up by hand
+Automatic merge failed; fix conflicts and then commit the result.
 $ git reset --hard                 <2>
 $ git pull . topic/branch          <3>
 Updating from 41223... to 13134...
diff --git a/Documentation/gitcore-tutorial.txt b/Documentation/gitcore-tutorial.txt
index 96bf353..df48045 100644
--- a/Documentation/gitcore-tutorial.txt
+++ b/Documentation/gitcore-tutorial.txt
@@ -899,7 +899,7 @@ file, which had no differences in the `mybranch` branch), and say:
 ----------------
 	Auto-merging hello
 	CONFLICT (content): Merge conflict in hello
-	Automatic merge failed; fix up by hand
+	Automatic merge failed; fix conflicts and then commit the result.
 ----------------
 
 It tells you that it did an "Automatic merge", which
@@ -993,7 +993,7 @@ would be different)
 
 ----------------
 Updating from ae3a2da... to a80b4aa....
-Fast forward
+Fast forward (no commit created; -m option ignored)
  example |    1 +
  hello   |    1 +
  2 files changed, 2 insertions(+), 0 deletions(-)
@@ -1265,9 +1265,8 @@ file, using 3-way merge.  This is done by giving
 
 ------------
 $ git merge-index git-merge-one-file hello
-Auto-merging hello.
-merge: warning: conflicts during merge
-ERROR: Merge conflict in hello.
+Auto-merging hello
+ERROR: Merge conflict in hello
 fatal: merge program failed
 ------------
 
@@ -1447,7 +1446,7 @@ public repository you might want to repack & prune often, or
 never.
 
 If you run `git repack` again at this point, it will say
-"Nothing to pack". Once you continue your development and
+"Nothing new to pack.". Once you continue your development and
 accumulate the changes, running `git repack` again will create a
 new pack, that contains objects created since you packed your
 repository the last time. We recommend that you pack your project
diff --git a/Documentation/pretty-formats.txt b/Documentation/pretty-formats.txt
index f18d33e..0a8a948 100644
--- a/Documentation/pretty-formats.txt
+++ b/Documentation/pretty-formats.txt
@@ -30,7 +30,7 @@ This is designed to be as compact as possible.
 
 	  commit <sha1>
 	  Author: <author>
-	  Date: <author date>
+	  Date:   <author date>
 
 	      <title line>
 
@@ -49,9 +49,9 @@ This is designed to be as compact as possible.
 * 'fuller'
 
 	  commit <sha1>
-	  Author: <author>
+	  Author:     <author>
 	  AuthorDate: <author date>
-	  Commit: <committer>
+	  Commit:     <committer>
 	  CommitDate: <committer date>
 
 	       <title line>
-- 
1.6.1.rc3.27.gf650d1
