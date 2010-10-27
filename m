From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: [PATCH] user-manual.txt: explain better the remote(-tracking) branch terms
Date: Wed, 27 Oct 2010 02:06:05 +0200
Message-ID: <1288137965-22950-1-git-send-email-Matthieu.Moy@imag.fr>
References: <vpqocag33mn.fsf@bauges.imag.fr>
Cc: jaysoffian@gmail.com, Matthieu Moy <Matthieu.Moy@imag.fr>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Wed Oct 27 02:06:17 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PAtWz-0001sg-9C
	for gcvg-git-2@lo.gmane.org; Wed, 27 Oct 2010 02:06:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760391Ab0J0AGM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Oct 2010 20:06:12 -0400
Received: from mx1.imag.fr ([129.88.30.5]:59393 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752577Ab0J0AGL (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Oct 2010 20:06:11 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id o9QNpSES001009
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Wed, 27 Oct 2010 01:51:28 +0200
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.69)
	(envelope-from <moy@imag.fr>)
	id 1PAtWp-00045N-Fx; Wed, 27 Oct 2010 02:06:07 +0200
Received: from moy by bauges.imag.fr with local (Exim 4.69)
	(envelope-from <moy@imag.fr>)
	id 1PAtWp-0005yk-9e; Wed, 27 Oct 2010 02:06:07 +0200
X-Mailer: git-send-email 1.7.3.2.183.g2e7b0
In-Reply-To: <vpqocag33mn.fsf@bauges.imag.fr>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Wed, 27 Oct 2010 01:51:28 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: o9QNpSES001009
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
MailScanner-NULL-Check: 1288741888.47791@JbbNnD4f3EvUAHE173m3Zg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160013>

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
