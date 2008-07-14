From: Eric Wong <normalperson@yhbt.net>
Subject: [PATCH] t/lib-git-svn: fix SVN_HTTPD tests to work with "trash directory"
Date: Mon, 14 Jul 2008 02:13:56 -0700
Message-ID: <1216026836-28374-1-git-send-email-normalperson@yhbt.net>
Cc: git@vger.kernel.org, Eric Wong <normalperson@yhbt.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jul 14 11:15:02 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KIK91-0002EO-GK
	for gcvg-git-2@gmane.org; Mon, 14 Jul 2008 11:14:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756016AbYGNJN5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Jul 2008 05:13:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755939AbYGNJN5
	(ORCPT <rfc822;git-outgoing>); Mon, 14 Jul 2008 05:13:57 -0400
Received: from hand.yhbt.net ([66.150.188.102]:38615 "EHLO hand.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756004AbYGNJN4 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Jul 2008 05:13:56 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with ESMTP id 4A9052DC095;
	Mon, 14 Jul 2008 02:13:56 -0700 (PDT)
X-Mailer: git-send-email 1.5.6.3.316.g20ed6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88404>

Signed-off-by: Eric Wong <normalperson@yhbt.net>
---
 t/lib-git-svn.sh |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/t/lib-git-svn.sh b/t/lib-git-svn.sh
index 5d3bd9d..a841df2 100644
--- a/t/lib-git-svn.sh
+++ b/t/lib-git-svn.sh
@@ -98,7 +98,7 @@ LoadModule dav_module $SVN_HTTPD_MODULE_PATH/mod_dav.so
 LoadModule dav_svn_module $SVN_HTTPD_MODULE_PATH/mod_dav_svn.so
 <Location /$repo_base_path>
 	DAV svn
-	SVNPath $rawsvnrepo
+	SVNPath "$rawsvnrepo"
 </Location>
 EOF
 	"$SVN_HTTPD_PATH" -f "$GIT_DIR"/httpd.conf -k start
-- 
1.5.6.3.316.g20ed6
