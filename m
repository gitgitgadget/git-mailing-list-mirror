From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: [PATCH 08/10] user-manual.txt: explain better the remote(-tracking) branch terms
Date: Thu, 28 Oct 2010 20:21:55 +0200
Message-ID: <1288290117-6734-9-git-send-email-Matthieu.Moy@imag.fr>
References: <1287851481-27952-1-git-send-email-Matthieu.Moy@imag.fr>
Cc: Thore Husfeldt <thore.husfeldt@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Jakub Narebski <jnareb@gmail.com>,
	Matthieu Moy <Matthieu.Moy@imag.fr>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Thu Oct 28 20:28:26 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PBXD5-00080H-7e
	for gcvg-git-2@lo.gmane.org; Thu, 28 Oct 2010 20:28:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933945Ab0J1S2S (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Oct 2010 14:28:18 -0400
Received: from imag.imag.fr ([129.88.30.1]:55597 "EHLO imag.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753685Ab0J1S2R (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Oct 2010 14:28:17 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by imag.imag.fr (8.13.8/8.13.8) with ESMTP id o9SIMoQE002428
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Thu, 28 Oct 2010 20:22:50 +0200 (CEST)
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.69)
	(envelope-from <moy@imag.fr>)
	id 1PBX7i-0003jl-Jc; Thu, 28 Oct 2010 20:22:50 +0200
Received: from moy by bauges.imag.fr with local (Exim 4.69)
	(envelope-from <moy@imag.fr>)
	id 1PBX7i-0001ly-HB; Thu, 28 Oct 2010 20:22:50 +0200
X-Mailer: git-send-email 1.7.3.2.183.g2e7b0
In-Reply-To: <1287851481-27952-1-git-send-email-Matthieu.Moy@imag.fr>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (imag.imag.fr [129.88.30.1]); Thu, 28 Oct 2010 20:22:51 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM for more information
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160201>

Now that the documentation is mostly consistant in the use of "remote
branch" Vs "remote-tracking branch", let's make this distinction explicit
early in the user-manual.

Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
---
 Documentation/user-manual.txt |   20 +++++++++++++++++---
 1 files changed, 17 insertions(+), 3 deletions(-)

diff --git a/Documentation/user-manual.txt b/Documentation/user-manual.txt
index d70f3e0..62b3788 100644
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
@@ -359,6 +360,14 @@ $ git branch -r
   origin/todo
 ------------------------------------------------
 
+In this case, "origin" is called a remote repository, or "remote" for
+short. The branches of this repository are called "remote branches"
+from our point of view. The remote-tracking branches are created in
+the local repository at clone time, as a copy of the remote branches.
+They are references that will be updated by "git fetch" (hence by "git
+pull"), and by "git push". See
+<<Updating-a-repository-With-git-fetch>> for details.
+
 You cannot check out these remote-tracking branches, but you can
 examine them on a branch of your own, just as you would a tag:
 
@@ -1716,14 +1725,19 @@ one step:
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
 
+This command will fetch the changes from the remote branches to your
+remote-tracking branches `origin/*`, and merge default branch in the
+current branch.
+
 More generally, a branch that is created from a remote-tracking branch
 will pull
 by default from that branch.  See the descriptions of the
-- 
1.7.3.2.183.g2e7b0
