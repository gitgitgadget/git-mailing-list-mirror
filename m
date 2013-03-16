From: Kacper Kornet <draenog@pld-linux.org>
Subject: [PATCH] rev-parse: Clarify documentation of @{upstream} syntax
Date: Sat, 16 Mar 2013 19:51:43 +0100
Message-ID: <1363459903-32358-1-git-send-email-draenog@pld-linux.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Mar 16 20:10:28 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UGwUm-0002eE-Of
	for gcvg-git-2@plane.gmane.org; Sat, 16 Mar 2013 20:10:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753311Ab3CPTJp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 16 Mar 2013 15:09:45 -0400
Received: from carme.pld-linux.org ([193.239.45.140]:59024 "EHLO
	carme.pld-linux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752154Ab3CPTJo (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 16 Mar 2013 15:09:44 -0400
X-Greylist: delayed 1079 seconds by postgrey-1.27 at vger.kernel.org; Sat, 16 Mar 2013 15:09:44 EDT
Received: from draenog by carme.pld-linux.org with local (Exim 4.80.1)
	(envelope-from <draenog@carme.pld-linux.org>)
	id 1UGwCl-0008Sh-Hv
	for git@vger.kernel.org; Sat, 16 Mar 2013 19:51:43 +0100
X-Mailer: git-send-email 1.8.1.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218314>

git-rev-parse interprets string in string@{upstream} as a name of
a branch not a ref. For example refs/heads/master@{upstream} looks
for an upstream branch that is merged by git-pull to ref
refs/heads/refs/heads/master not to refs/heads/master. However the
documentation could misled a user to believe that the string is
interpreted as ref.

Signed-off-by: Kacper Kornet <draenog@pld-linux.org>
---
 Documentation/revisions.txt | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/Documentation/revisions.txt b/Documentation/revisions.txt
index 678d175..314e25d 100644
--- a/Documentation/revisions.txt
+++ b/Documentation/revisions.txt
@@ -88,10 +88,10 @@ some output processing may assume ref names in UTF-8.
   The construct '@\{-<n>\}' means the <n>th branch checked out
   before the current one.
 
-'<refname>@\{upstream\}', e.g. 'master@\{upstream\}', '@\{u\}'::
-  The suffix '@\{upstream\}' to a ref (short form '<refname>@\{u\}') refers to
-  the branch the ref is set to build on top of.  A missing ref defaults
-  to the current branch.
+'<branchname>@\{upstream\}', e.g. 'master@\{upstream\}', '@\{u\}'::
+  The suffix '@\{upstream\}' to a branchname (short form '<branchname>@\{u\}')
+  refers to the branch that the branch specified by branchname is set to build on
+  top of.  A missing branchname defaults to the current one.
 
 '<rev>{caret}', e.g. 'HEAD{caret}, v1.5.1{caret}0'::
   A suffix '{caret}' to a revision parameter means the first parent of
-- 
1.8.2
