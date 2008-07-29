From: Abhijit Menon-Sen <ams@toroid.org>
Subject: [PATCH] Make it clear that push can take multiple refspecs
Date: Wed, 30 Jul 2008 01:39:19 +0530
Message-ID: <1217362159-25440-1-git-send-email-ams@toroid.org>
Cc: gitster@pobox.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 29 22:10:27 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KNvWc-0005B4-Nv
	for gcvg-git-2@gmane.org; Tue, 29 Jul 2008 22:10:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759614AbYG2UJX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Jul 2008 16:09:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759591AbYG2UJW
	(ORCPT <rfc822;git-outgoing>); Tue, 29 Jul 2008 16:09:22 -0400
Received: from fugue.toroid.org ([85.10.196.113]:55039 "EHLO fugue.toroid.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759510AbYG2UJV (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Jul 2008 16:09:21 -0400
Received: from penne.toroid.org (penne-vpn [10.8.0.6])
	by fugue.toroid.org (Postfix) with ESMTP id 5D61F5580DD;
	Tue, 29 Jul 2008 22:09:20 +0200 (CEST)
Received: by penne.toroid.org (Postfix, from userid 1000)
	id 80282ADC369; Wed, 30 Jul 2008 01:39:19 +0530 (IST)
X-Mailer: git-send-email 1.6.0.rc0.43.g2aa74
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90679>

Signed-off-by: Abhijit Menon-Sen <ams@toroid.org>
---
 Documentation/git-push.txt |   10 ++++++++--
 1 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-push.txt b/Documentation/git-push.txt
index 94d07ab..b8c55dd 100644
--- a/Documentation/git-push.txt
+++ b/Documentation/git-push.txt
@@ -10,7 +10,8 @@ SYNOPSIS
 --------
 [verse]
 'git push' [--all] [--dry-run] [--tags] [--receive-pack=<git-receive-pack>]
-           [--repo=all] [-f | --force] [-v | --verbose] [<repository> <refspec>...]
+           [--repo=all] [-f | --force] [-v | --verbose]
+           [<repository> <refspec>...]
 
 DESCRIPTION
 -----------
@@ -33,7 +34,8 @@ OPTIONS
 	The canonical format of a <refspec> parameter is
 	`+?<src>:<dst>`; that is, an optional plus `+`, followed
 	by the source ref, followed by a colon `:`, followed by
-	the destination ref.
+	the destination ref. Any number of <refspec> parameters
+	may be specified.
 +
 The <src> side represents the source branch (or arbitrary
 "SHA1 expression", such as `master~4` (four parents before the
@@ -180,6 +182,10 @@ git push origin :experimental::
 	Find a ref that matches `experimental` in the `origin` repository
 	(e.g. `refs/heads/experimental`), and delete it.
 
+git push origin master master:other::
+	Find a ref that matches `master` in the source repository and in
+	the `origin` repository update refs `master` and `other` to it.
+
 git push origin master:satellite/master::
 	Find a ref that matches `master` in the source repository
 	(most likely, it would find `refs/heads/master`), and update
-- 
1.6.0.rc0.43.g2aa74
