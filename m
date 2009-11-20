From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: [PATCH 2/2] user-manual: Document that "git merge" doesn't like uncommited changes.
Date: Fri, 20 Nov 2009 16:59:27 +0100
Message-ID: <1258732767-12741-3-git-send-email-Matthieu.Moy@imag.fr>
References: <1258732767-12741-1-git-send-email-Matthieu.Moy@imag.fr>
Cc: Matthieu Moy <Matthieu.Moy@imag.fr>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Nov 20 17:03:36 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NBVxP-0000zs-G8
	for gcvg-git-2@lo.gmane.org; Fri, 20 Nov 2009 17:03:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754044AbZKTQDI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Nov 2009 11:03:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754021AbZKTQDG
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Nov 2009 11:03:06 -0500
Received: from imag.imag.fr ([129.88.30.1]:41322 "EHLO imag.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753999AbZKTQDD (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Nov 2009 11:03:03 -0500
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by imag.imag.fr (8.13.8/8.13.8) with ESMTP id nAKFxagG006341
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Fri, 20 Nov 2009 16:59:36 +0100 (CET)
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.69)
	(envelope-from <moy@imag.fr>)
	id 1NBVtX-0001Mj-LK; Fri, 20 Nov 2009 16:59:35 +0100
Received: from moy by bauges.imag.fr with local (Exim 4.69)
	(envelope-from <moy@imag.fr>)
	id 1NBVtX-0003KR-K0; Fri, 20 Nov 2009 16:59:35 +0100
X-Mailer: git-send-email 1.6.5.3.435.g5f2e3.dirty
In-Reply-To: <1258732767-12741-1-git-send-email-Matthieu.Moy@imag.fr>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (imag.imag.fr [129.88.30.1]); Fri, 20 Nov 2009 16:59:36 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM for more information
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133355>

We explain the user why uncommited changes can be problematic with merge,
and point to "commit" and "stash" for the solution.

Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
---
 Documentation/user-manual.txt |   14 +++++++++++---
 1 files changed, 11 insertions(+), 3 deletions(-)

diff --git a/Documentation/user-manual.txt b/Documentation/user-manual.txt
index 269ec47..6b4a037 100644
--- a/Documentation/user-manual.txt
+++ b/Documentation/user-manual.txt
@@ -1176,14 +1176,22 @@ How to merge
 ------------
 
 You can rejoin two diverging branches of development using
-linkgit:git-merge[1]:
+linkgit:git-merge[1].
 
 -------------------------------------------------
 $ git merge branchname
 -------------------------------------------------
 
 merges the development in the branch "branchname" into the current
-branch.  If there are conflicts--for example, if the same file is
+branch.  Note that Git merges committed changes, but not the working
+tree itself.  Therefore, if you have uncommitted changes touching the
+same files as the ones impacted by the merge, Git will refuse to
+proceed.  Most of the time, you will want to commit your changes before
+you can merge, and if you don't, then linkgit:git-stash[1] can take
+these changes away while you're doing the merge, and reapply them
+afterwards.
+
+If there are conflicts--for example, if the same file is
 modified in two different ways in the remote branch and the local
 branch--then you are warned; the output may look something like this:
 
@@ -1679,7 +1687,7 @@ Sharing development with others
 Getting updates with git pull
 -----------------------------
 
-After you clone a repository and make a few changes of your own, you
+After you clone a repository and commit a few changes of your own, you
 may wish to check the original repository for updates and merge them
 into your own work.
 
-- 
1.6.5.3.435.g5f2e3.dirty
