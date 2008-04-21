From: Sam Vilain <sam.vilain@catalyst.net.nz>
Subject: [PATCH] Amend git-push refspec documentation
Date: Mon, 21 Apr 2008 15:31:24 +1200
Message-ID: <1208748684-28253-1-git-send-email-sam.vilain@catalyst.net.nz>
Cc: guillaume@catalyst.net.nz, git@vger.kernel.org,
	Sam Vilain <sam.vilain@catalyst.net.nz>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Mon Apr 21 05:56:34 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jnn8s-0001Ov-AO
	for gcvg-git-2@gmane.org; Mon, 21 Apr 2008 05:56:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754317AbYDUDze (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 20 Apr 2008 23:55:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754377AbYDUDze
	(ORCPT <rfc822;git-outgoing>); Sun, 20 Apr 2008 23:55:34 -0400
Received: from godel.catalyst.net.nz ([202.78.240.40]:56804 "EHLO
	mail1.catalyst.net.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753624AbYDUDzd (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 Apr 2008 23:55:33 -0400
X-Greylist: delayed 1431 seconds by postgrey-1.27 at vger.kernel.org; Sun, 20 Apr 2008 23:55:33 EDT
Received: from leibniz.catalyst.net.nz ([202.78.240.7] helo=wilber.wgtn.cat-it.co.nz)
	by mail1.catalyst.net.nz with esmtp (Exim 4.63)
	(envelope-from <samv@wilber.wgtn.cat-it.co.nz>)
	id 1JnmkX-0006TD-7L; Mon, 21 Apr 2008 15:31:25 +1200
Received: by wilber.wgtn.cat-it.co.nz (Postfix, from userid 1000)
	id 15ED3200F5; Mon, 21 Apr 2008 15:31:25 +1200 (NZST)
X-Mailer: git-send-email 1.5.5.1.50.g1d36.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80012>

These paragraphs are a little confusing.  Also, make it clearer when
you have to specify the full name for <dst>

Signed-off-by: Sam Vilain <sam.vilain@catalyst.net.nz>
---
 Documentation/git-push.txt |   22 ++++++++++++----------
 1 files changed, 12 insertions(+), 10 deletions(-)

diff --git a/Documentation/git-push.txt b/Documentation/git-push.txt
index 3128170..b3d164e 100644
--- a/Documentation/git-push.txt
+++ b/Documentation/git-push.txt
@@ -35,14 +35,14 @@ OPTIONS
 	by the source ref, followed by a colon `:`, followed by
 	the destination ref.
 +
-The <src> side can be an
-arbitrary "SHA1 expression" that can be used as an
-argument to `git-cat-file -t`.  E.g. `master~4` (push
-four parents before the current master head).
+The <src> side represents the source branch (or arbitrary
+"SHA1 expression"; see linkgit:git-rev-parse[1]) that you want to
+push.  The <dst> side represents the destination location.
 +
 The local ref that matches <src> is used
-to fast forward the remote ref that matches <dst>.  If
-the optional plus `+` is used, the remote ref is updated
+to fast forward the remote ref that matches <dst> (or, if no <dst> was
+specified, the same ref that <src> referred to locally).  If
+the optional leading plus `+` is used, the remote ref is updated
 even if it does not result in a fast forward update.
 +
 Note: If no explicit refspec is found, (that is neither
@@ -165,7 +165,8 @@ git push origin master::
 	Find a ref that matches `master` in the source repository
 	(most likely, it would find `refs/heads/master`), and update
 	the same ref (e.g. `refs/heads/master`) in `origin` repository
-	with it.
+	with it.  If `master` did not exist remotely, it would be
+	created.
 
 git push origin :experimental::
 	Find a ref that matches `experimental` in the `origin` repository
@@ -179,9 +180,10 @@ git push origin master:satellite/master::
 
 git push origin master:refs/heads/experimental::
 	Create the branch `experimental` in the `origin` repository
-	by copying the current `master` branch.  This form is usually
-	needed to create a new branch in the remote repository as
-	there is no `experimental` branch to match.
+	by copying the current `master` branch.  This form is only
+	needed to create a new branch in the remote repository when
+	the local name and the remote name are different; otherwise,
+	the branch name on its own will work.
 
 Author
 ------
-- 
1.5.5.1.50.g1d36.dirty
