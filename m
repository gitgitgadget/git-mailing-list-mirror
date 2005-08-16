From: Pavel Roskin <proski@gnu.org>
Subject: [PATCH] cg-admin-cat ignoring -r
Date: Tue, 16 Aug 2005 17:22:59 -0400
Message-ID: <1124227379.26240.4.camel@dv>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Tue Aug 16 23:25:02 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E58tx-0005Iy-7R
	for gcvg-git@gmane.org; Tue, 16 Aug 2005 23:23:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932726AbVHPVXO (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 16 Aug 2005 17:23:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932727AbVHPVXO
	(ORCPT <rfc822;git-outgoing>); Tue, 16 Aug 2005 17:23:14 -0400
Received: from fencepost.gnu.org ([199.232.76.164]:388 "EHLO fencepost.gnu.org")
	by vger.kernel.org with ESMTP id S932726AbVHPVXN (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 16 Aug 2005 17:23:13 -0400
Received: from proski by fencepost.gnu.org with local (Exim 4.34)
	id 1E58qz-0005V3-Uv
	for git@vger.kernel.org; Tue, 16 Aug 2005 17:20:16 -0400
Received: from localhost.localdomain ([127.0.0.1] helo=dv.roinet.com)
	by dv.roinet.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.52)
	id 1E58tf-0006qO-Vv; Tue, 16 Aug 2005 17:23:00 -0400
Received: (from proski@localhost)
	by dv.roinet.com (8.13.4/8.13.4/Submit) id j7GLMx0A026309;
	Tue, 16 Aug 2005 17:22:59 -0400
X-Authentication-Warning: dv.roinet.com: proski set sender to proski@gnu.org using -f
To: Petr Baudis <pasky@ucw.cz>, git <git@vger.kernel.org>
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Hello!

cg-admin-cat ignores the argument for the "-r" option because it uses
optparse incorrectly.  For OPTARG to be set, "-r=" should be used
instead of "-r".

Signed-off-by: Pavel Roskin <proski@gnu.org>

diff --git a/cg-admin-cat b/cg-admin-cat
--- a/cg-admin-cat
+++ b/cg-admin-cat
@@ -27,7 +27,7 @@ USAGE="cg-admin-cat [-r TREE_ID] FILE...
 
 rev=HEAD
 while optparse; do
-	if optparse -r; then
+	if optparse -r=; then
 		rev="$OPTARG"
 	else
 		optfail


-- 
Regards,
Pavel Roskin
