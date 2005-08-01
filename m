From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH] Updates for cvs-migration.txt
Date: Mon, 1 Aug 2005 16:32:58 +0200 (CEST)
Message-ID: <Pine.LNX.4.58.20050801163152.12985@wgmdd8.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-From: git-owner@vger.kernel.org Mon Aug 01 16:34:30 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DzbMQ-0000OX-0J
	for gcvg-git@gmane.org; Mon, 01 Aug 2005 16:33:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261989AbVHAOd3 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 1 Aug 2005 10:33:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261878AbVHAOd0
	(ORCPT <rfc822;git-outgoing>); Mon, 1 Aug 2005 10:33:26 -0400
Received: from wrzx28.rz.uni-wuerzburg.de ([132.187.3.28]:46268 "EHLO
	wrzx28.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S261989AbVHAOc7 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Aug 2005 10:32:59 -0400
Received: from wrzx30.rz.uni-wuerzburg.de (wrzx30.rz.uni-wuerzburg.de [132.187.1.30])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP id 8F272E23D6
	for <git@vger.kernel.org>; Mon,  1 Aug 2005 16:32:58 +0200 (CEST)
Received: from virusscan (localhost [127.0.0.1])
	by wrzx30.rz.uni-wuerzburg.de (Postfix) with ESMTP id 747F491BDA
	for <git@vger.kernel.org>; Mon,  1 Aug 2005 16:32:58 +0200 (CEST)
Received: from wrzx28.rz.uni-wuerzburg.de (wrzx28.rz.uni-wuerzburg.de [132.187.3.28])
	by wrzx30.rz.uni-wuerzburg.de (Postfix) with ESMTP id 5E0D691BB3
	for <git@vger.kernel.org>; Mon,  1 Aug 2005 16:32:58 +0200 (CEST)
Received: from wgmdd8.biozentrum.uni-wuerzburg.de (wrzx68.rz.uni-wuerzburg.de [132.187.3.68])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP id 511BCE23D6
	for <git@vger.kernel.org>; Mon,  1 Aug 2005 16:32:58 +0200 (CEST)
X-X-Sender: gene099@wgmdd8.biozentrum.uni-wuerzburg.de
To: git@vger.kernel.org
X-Virus-Scanned: by amavisd-new (Rechenzentrum Universitaet Wuerzburg)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Describe core git, not cogito.
Tell something about emulating the CVS work flow.
Fix small typos.

Signed-off-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>

---

 Documentation/cvs-migration.txt |   28 ++++++++++++++++++++++------
 1 files changed, 22 insertions(+), 6 deletions(-)

4d171682e6e6499db8563aa61e68fc4a04abf413
diff --git a/Documentation/cvs-migration.txt b/Documentation/cvs-migration.txt
--- a/Documentation/cvs-migration.txt
+++ b/Documentation/cvs-migration.txt
@@ -90,7 +90,7 @@ from CVS.
 You can merge those updates (or, in fact, a different CVS branch) into
 your main branch:

-	cg-merge <branch>
+	git resolve HEAD origin "merge with current CVS HEAD"

 The HEAD revision from CVS is named "origin", not "HEAD", because git
 already uses "HEAD". (If you don't like 'origin', use cvsimport's
@@ -101,10 +101,26 @@ Emulating CVS behaviour
 -----------------------


-FIXME! Talk about setting up several repositories, and pulling and
-pushing between them. Talk about merging, and branches. Some of this
-needs to be in the tutorial too.
+So, by now you are convinced you absolutely want to work with git, but
+at the same time you absolutely have to have a central repository.
+Step back and think again. Okay, you still need a single central
+repository? There are several ways to go about that:
+
+1. Designate a person responsible to pull all branches. Make the
+repository of this person public, and make every team member
+pull regularly from it.
+
+2. Set up a public repository with read/write access for every team
+member. Use "git pull/push" as you used "cvs update/commit". Beware!
+Linus says that "git push" does no locking, since it was not meant
+for multi-user repositories!
+
+3. Make the repository of every team member public. It is the
+responsibility of each single member to pull from every other
+team member.

+4. Read Documentation/tutorial.txt and admit that the described work
+flow is the best.


 CVS annotate
@@ -157,7 +173,7 @@ modifications that are not related to th
 interested in.  You would see many log messages and patches that
 do not have anything to do with the piece of code you are
 interested in.  As an example, assuming that you have this piece
-code that you are interested in in the HEAD version:
+of code that you are interested in in the HEAD version:

 	if (frotz) {
 		nitfol();
@@ -207,7 +223,7 @@ in the current HEAD commit, even if the
 called "o-file.c" and then renamed in an earlier commit, or if
 the file was created by copying an existing "o-file.c" in an
 earlier commit, you will not lose track.  If the "if" statement
-did not change across such rename or copy, then the commit that
+did not change across such a rename or copy, then the commit that
 does rename or copy would not show in the output, and if the
 "if" statement was modified while the file was still called
 "o-file.c", it would find the commit that changed the statement
