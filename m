From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: [PATCH 10/11] user-manual: remote-tracking can be checked out, with detached HEAD
Date: Sat, 30 Oct 2010 06:10:18 +0200
Message-ID: <1288411819-24462-11-git-send-email-Matthieu.Moy@imag.fr>
References: <1287851481-27952-1-git-send-email-Matthieu.Moy@imag.fr>
Cc: Thore Husfeldt <thore.husfeldt@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Jakub Narebski <jnareb@gmail.com>,
	Matthieu Moy <Matthieu.Moy@imag.fr>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Sat Oct 30 06:14:22 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PC2ph-0002yM-TH
	for gcvg-git-2@lo.gmane.org; Sat, 30 Oct 2010 06:14:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750731Ab0J3EOS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 30 Oct 2010 00:14:18 -0400
Received: from imag.imag.fr ([129.88.30.1]:46759 "EHLO imag.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750766Ab0J3EOQ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 30 Oct 2010 00:14:16 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by imag.imag.fr (8.13.8/8.13.8) with ESMTP id o9U4B32l014368
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Sat, 30 Oct 2010 06:11:03 +0200 (CEST)
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.69)
	(envelope-from <moy@imag.fr>)
	id 1PC2mV-0007uG-4n; Sat, 30 Oct 2010 06:11:03 +0200
Received: from moy by bauges.imag.fr with local (Exim 4.69)
	(envelope-from <moy@imag.fr>)
	id 1PC2mV-0006P3-2d; Sat, 30 Oct 2010 06:11:03 +0200
X-Mailer: git-send-email 1.7.3.2.183.g2e7b0
In-Reply-To: <1287851481-27952-1-git-send-email-Matthieu.Moy@imag.fr>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (imag.imag.fr [129.88.30.1]); Sat, 30 Oct 2010 06:11:03 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM for more information
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160383>

From: Jonathan Nieder <jrnieder@gmail.com>

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
---
 Documentation/user-manual.txt |   26 ++++++++++++++------------
 1 files changed, 14 insertions(+), 12 deletions(-)

diff --git a/Documentation/user-manual.txt b/Documentation/user-manual.txt
index 62b3788..3108b38 100644
--- a/Documentation/user-manual.txt
+++ b/Documentation/user-manual.txt
@@ -360,21 +360,23 @@ $ git branch -r
   origin/todo
 ------------------------------------------------
 
-In this case, "origin" is called a remote repository, or "remote" for
-short. The branches of this repository are called "remote branches"
-from our point of view. The remote-tracking branches are created in
-the local repository at clone time, as a copy of the remote branches.
-They are references that will be updated by "git fetch" (hence by "git
-pull"), and by "git push". See
-<<Updating-a-repository-With-git-fetch>> for details.
+In this example, "origin" is called a remote repository, or "remote"
+for short. The branches of this repository are called "remote
+branches" from our point of view. The remote-tracking branches listed
+above were created based on the remote branches at clone time and will
+be updated by "git fetch" (hence "git pull) and "git push". See
+<<Updating -a-repository-With-git-fetch>> for details.
 
-You cannot check out these remote-tracking branches, but you can
-examine them on a branch of your own, just as you would a tag:
+You might want to build on one of these remote-tracking branches
+on a branch of your own, just as you would for a tag:
 
 ------------------------------------------------
 $ git checkout -b my-todo-copy origin/todo
 ------------------------------------------------
 
+You can also check out "origin/todo" directly to examine it or
+write a one-off patch.  See <<detached-head,detached head>>.
+
 Note that the name "origin" is just the name that git uses by default
 to refer to the repository that you cloned from.
 
@@ -1734,9 +1736,9 @@ accomplish the above with just a simple
 $ git pull
 -------------------------------------------------
 
-This command will fetch the changes from the remote branches to your
-remote-tracking branches `origin/*`, and merge default branch in the
-current branch.
+This command will fetch changes from the remote branches to your
+remote-tracking branches `origin/*`, and merge the default branch into
+the current branch.
 
 More generally, a branch that is created from a remote-tracking branch
 will pull
-- 
1.7.3.2.183.g2e7b0
