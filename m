From: Pavel Roskin <proski@gnu.org>
Subject: [PATCH] qgit: patchesStillToFind not initialized
Date: Wed, 21 Dec 2005 20:19:36 -0500
Message-ID: <1135214376.2253.2.camel@dv>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Dec 22 02:20:08 2005
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EpF7f-0004y7-BA
	for gcvg-git@gmane.org; Thu, 22 Dec 2005 02:19:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965017AbVLVBTo (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 21 Dec 2005 20:19:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965023AbVLVBTo
	(ORCPT <rfc822;git-outgoing>); Wed, 21 Dec 2005 20:19:44 -0500
Received: from fencepost.gnu.org ([199.232.76.164]:49587 "EHLO
	fencepost.gnu.org") by vger.kernel.org with ESMTP id S965017AbVLVBTo
	(ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Dec 2005 20:19:44 -0500
Received: from proski by fencepost.gnu.org with local (Exim 4.34)
	id 1EpF7L-0003Wt-S0
	for git@vger.kernel.org; Wed, 21 Dec 2005 20:19:40 -0500
Received: from proski by dv.roinet.com with local (Exim 4.54)
	id 1EpF7J-00014C-1v; Wed, 21 Dec 2005 20:19:37 -0500
To: Marco Costalba <mcostalba@yahoo.it>
X-Mailer: Evolution 2.4.1 (2.4.1-5) 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13927>

Git::patchesStillToFind is not initialized on non-StGit repositories.
Found by Valgrind.

Signed-off-by: Pavel Roskin <proski@gnu.org>

diff --git a/src/git_startup.cpp b/src/git_startup.cpp
index 35dcaf7..307517f 100644
--- a/src/git_startup.cpp
+++ b/src/git_startup.cpp
@@ -473,6 +473,7 @@ bool Git::init(QString* repoDir, bool as
 	if (!startGetFileProc())
 		qDebug("ERROR: unable to start background git-diff-tree");
 
+	patchesStillToFind = 0;
 	if (isStGIT && !filteredLoading) { // updated by getRefs()
 		POST_MSG(msg1 + "StGIT patches...");
 		if (getStGITPatches()) {


-- 
Regards,
Pavel Roskin
