From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: [PATCH 09/10] user-manual.txt: explain better the remote(-tracking) branch terms
Date: Mon, 25 Oct 2010 08:08:41 +0200
Message-ID: <1287986922-16308-10-git-send-email-Matthieu.Moy@imag.fr>
References: <1287851481-27952-1-git-send-email-Matthieu.Moy@imag.fr>
Cc: Thore Husfeldt <thore.husfeldt@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Jakub Narebski <jnareb@gmail.com>,
	Matthieu Moy <Matthieu.Moy@imag.fr>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Mon Oct 25 08:09:49 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PAGFg-0003pG-UV
	for gcvg-git-2@lo.gmane.org; Mon, 25 Oct 2010 08:09:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752217Ab0JYGJb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Oct 2010 02:09:31 -0400
Received: from mx2.imag.fr ([129.88.30.17]:53273 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752054Ab0JYGJa (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Oct 2010 02:09:30 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id o9P62PQA006491
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Mon, 25 Oct 2010 08:02:25 +0200
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.69)
	(envelope-from <moy@imag.fr>)
	id 1PAGEf-00050c-JE; Mon, 25 Oct 2010 08:08:45 +0200
Received: from moy by bauges.imag.fr with local (Exim 4.69)
	(envelope-from <moy@imag.fr>)
	id 1PAGEf-0004G9-Gp; Mon, 25 Oct 2010 08:08:45 +0200
X-Mailer: git-send-email 1.7.3.2.183.g2e7b0
In-Reply-To: <1287851481-27952-1-git-send-email-Matthieu.Moy@imag.fr>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Mon, 25 Oct 2010 08:02:25 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: o9P62PQA006491
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
MailScanner-NULL-Check: 1288591346.10239@BayervEkNsg/TCjO1bNnSw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159923>

Now that the documentation is mostly consistant in the use of "remote
branch" Vs "remote-tracking branch", let's make this distinction explicit
early in the user-manual.

Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
---
 Documentation/user-manual.txt |   17 +++++++++++++++--
 1 files changed, 15 insertions(+), 2 deletions(-)

diff --git a/Documentation/user-manual.txt b/Documentation/user-manual.txt
index d70f3e0..6684a78 100644
--- a/Documentation/user-manual.txt
+++ b/Documentation/user-manual.txt
@@ -359,6 +359,14 @@ $ git branch -r
   origin/todo
 ------------------------------------------------
 
+In this case, "origin" is called a remote repository, or "remote" for
+short. The branches of this repository are called "remote branches"
+from our point of view, and Git will keep a copy of these
+branches, called "remote-tracking branches" in the local repository.
+These remote-tracking branches are references that will be updated by
+"git fetch" (hence by "git pull"). See
+<<Updating-a-repository-With-git-fetch>> for details.
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
 
+This command will fetch the changes from the remote branches to your
+remote-tracking branches `origin/*`, and merge default branch in the
+current branch.
+
 More generally, a branch that is created from a remote-tracking branch
 will pull
 by default from that branch.  See the descriptions of the
-- 
1.7.3.2.183.g2e7b0
