From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: [PATCH 08/10] user-manual.txt: explain better the remote(-tracking) branch terms
Date: Tue,  2 Nov 2010 16:31:26 +0100
Message-ID: <1288711888-21528-9-git-send-email-Matthieu.Moy@imag.fr>
References: <1288711888-21528-1-git-send-email-Matthieu.Moy@imag.fr>
Cc: Matthieu Moy <Matthieu.Moy@imag.fr>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Tue Nov 02 16:36:31 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PDIuS-0005sZ-WF
	for gcvg-git-2@lo.gmane.org; Tue, 02 Nov 2010 16:36:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753906Ab0KBPgN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Nov 2010 11:36:13 -0400
Received: from imag.imag.fr ([129.88.30.1]:43306 "EHLO imag.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753866Ab0KBPgL (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Nov 2010 11:36:11 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by imag.imag.fr (8.13.8/8.13.8) with ESMTP id oA2FVo7X004466
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Tue, 2 Nov 2010 16:31:50 +0100 (CET)
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.69)
	(envelope-from <moy@imag.fr>)
	id 1PDIpy-00027U-4u; Tue, 02 Nov 2010 16:31:50 +0100
Received: from moy by bauges.imag.fr with local (Exim 4.69)
	(envelope-from <moy@imag.fr>)
	id 1PDIpy-0005cO-2s; Tue, 02 Nov 2010 16:31:50 +0100
X-Mailer: git-send-email 1.7.3.2.183.g2e7b0
In-Reply-To: <1288711888-21528-1-git-send-email-Matthieu.Moy@imag.fr>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (imag.imag.fr [129.88.30.1]); Tue, 02 Nov 2010 16:31:50 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM for more information
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160533>

Now that the documentation is mostly consistant in the use of "remote
branch" Vs "remote-tracking branch", let's make this distinction explicit
early in the user-manual.

Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
---
 Documentation/user-manual.txt |   19 ++++++++++++++++---
 1 files changed, 16 insertions(+), 3 deletions(-)

diff --git a/Documentation/user-manual.txt b/Documentation/user-manual.txt
index d70f3e0..6d6bd8d 100644
--- a/Documentation/user-manual.txt
+++ b/Documentation/user-manual.txt
@@ -344,7 +344,8 @@ Examining branches from a remote repository
 The "master" branch that was created at the time you cloned is a copy
 of the HEAD in the repository that you cloned from.  That repository
 may also have had other branches, though, and your local repository
-keeps branches which track each of those remote branches, which you
+keeps branches which track each of those remote branches, called
+remote-tracking branches, which you
 can view using the "-r" option to linkgit:git-branch[1]:
 
 ------------------------------------------------
@@ -359,6 +360,13 @@ $ git branch -r
   origin/todo
 ------------------------------------------------
 
+In this example, "origin" is called a remote repository, or "remote"
+for short. The branches of this repository are called "remote
+branches" from our point of view. The remote-tracking branches listed
+above were created based on the remote branches at clone time and will
+be updated by "git fetch" (hence "git pull) and "git push". See
+<<Updating -a-repository-With-git-fetch>> for details.
+
 You cannot check out these remote-tracking branches, but you can
 examine them on a branch of your own, just as you would a tag:
 
@@ -1716,14 +1724,19 @@ one step:
 $ git pull origin master
 -------------------------------------------------
 
-In fact, if you have "master" checked out, then by default "git pull"
-merges from the HEAD branch of the origin repository.  So often you can
+In fact, if you have "master" checked out, then this branch has been
+configured by "git clone" to get changes from the HEAD branch of the
+origin repository.  So often you can
 accomplish the above with just a simple
 
 -------------------------------------------------
 $ git pull
 -------------------------------------------------
 
+This command will fetch changes from the remote branches to your
+remote-tracking branches `origin/*`, and merge the default branch into
+the current branch.
+
 More generally, a branch that is created from a remote-tracking branch
 will pull
 by default from that branch.  See the descriptions of the
-- 
1.7.3.2.183.g2e7b0
