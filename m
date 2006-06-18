From: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
Subject: [PATCH 2/3] git-tar-tree: documentation update
Date: Sun, 18 Jun 2006 12:57:59 +0200
Message-ID: <11506282792065-git-send-email-rene.scharfe@lsrfire.ath.cx>
Reply-To: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
Cc: git@vger.kernel.org, Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
X-From: git-owner@vger.kernel.org Sun Jun 18 12:58:30 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fruz7-0007M4-MZ
	for gcvg-git@gmane.org; Sun, 18 Jun 2006 12:58:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751140AbWFRK6B (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 18 Jun 2006 06:58:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751141AbWFRK6A
	(ORCPT <rfc822;git-outgoing>); Sun, 18 Jun 2006 06:58:00 -0400
Received: from static-ip-217-172-187-230.inaddr.intergenia.de ([217.172.187.230]:40366
	"EHLO neapel230.server4you.de") by vger.kernel.org with ESMTP
	id S1751140AbWFRK6A (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Jun 2006 06:58:00 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by neapel230.server4you.de (Postfix) with ESMTP id 76ABF27020;
	Sun, 18 Jun 2006 12:57:59 +0200 (CEST)
To: Junio C Hamano <junkio@cox.net>
X-Mailer: git-send-email 1.3.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22069>

 * add example on how to avoid adding a global extended pax header
 * don't mention linux anymore, use git itself as an example instead
 * update to v1.4.0 ;-)
 * append missing :: to the examples

Signed-off-by: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
---
 Documentation/git-tar-tree.txt |   15 ++++++++++-----
 1 files changed, 10 insertions(+), 5 deletions(-)

diff --git a/Documentation/git-tar-tree.txt b/Documentation/git-tar-tree.txt
index 831537b..f2675c4 100644
--- a/Documentation/git-tar-tree.txt
+++ b/Documentation/git-tar-tree.txt
@@ -39,19 +39,24 @@ OPTIONS
 
 Examples
 --------
-git tar-tree HEAD | (cd /var/tmp/ && mkdir junk && tar Cxf junk -)::
+git tar-tree HEAD junk | (cd /var/tmp/ && tar xf -)::
 
 	Create a tar archive that contains the contents of the
 	latest commit on the current branch, and extracts it in
 	`/var/tmp/junk` directory.
 
-git tar-tree v2.6.17 linux-2.6.17 | gzip >linux-2.6.17.tar.gz
+git tar-tree v1.4.0 git-1.4.0 | gzip >git-1.4.0.tar.gz::
 
-	Create a tarball for v2.6.17 release.
+	Create a tarball for v1.4.0 release.
 
-git tar-tree --remote=example.com:git.git v0.99 >git-0.99.tar
+git tar-tree v1.4.0{caret}\{tree\} git-1.4.0 | gzip >git-1.4.0.tar.gz::
 
-	Get a tarball v0.99 from example.com.
+	Create a tarball for v1.4.0 release, but without a
+	global extended pax header.
+
+git tar-tree --remote=example.com:git.git v1.4.0 >git-1.4.0.tar::
+
+	Get a tarball v1.4.0 from example.com.
 
 Author
 ------
-- 
1.4.0
