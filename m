From: Zach Welch <zw@superlucidity.net>
Subject: [PATCH 1/3] init-db.c: cleanup comments
Date: Tue, 19 Apr 2005 21:28:39 -0700
Message-ID: <mailbox-1242-1113971319-969154@spoon>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: torvalds@osdl.org
X-From: git-owner@vger.kernel.org Wed Apr 20 06:24:59 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DO6lb-0007Cm-S3
	for gcvg-git@gmane.org; Wed, 20 Apr 2005 06:24:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261366AbVDTE2t (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 20 Apr 2005 00:28:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261357AbVDTE2s
	(ORCPT <rfc822;git-outgoing>); Wed, 20 Apr 2005 00:28:48 -0400
Received: from spoon.guft.org ([63.224.205.130]:20879 "EHLO mail.guft.org")
	by vger.kernel.org with ESMTP id S261348AbVDTE2m (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 20 Apr 2005 00:28:42 -0400
Received: (qmail 1251 invoked by uid 5006); 19 Apr 2005 21:28:42 -0700
To: git@vger.kernel.org
In-Reply-To: mailbox-1242-1113971319-958842@spoon
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

 init-db.c |   15 ++++++---------
 1 files changed, 6 insertions(+), 9 deletions(-)

Signed-Off-By: Zach Welch <zw@superlucidity.net>

Consolidate comments at top of main.

--- a/init-db.c
+++ b/init-db.c
@@ -5,6 +5,12 @@
  */
 #include "cache.h"
 
+/*
+ * If you want to, you can share the DB area with any number of branches.
+ * That has advantages: you can save space by sharing all the SHA1 objects.
+ * On the other hand, it might just make lookup slower and messier. You
+ * be the judge.  The default case is to have one DB per managed directory.
+ */
 int main(int argc, char **argv)
 {
 	char *sha1_dir, *path;
@@ -15,12 +21,6 @@ int main(int argc, char **argv)
 		exit(1);
 	}
 
-	/*
-	 * If you want to, you can share the DB area with any number of branches.
-	 * That has advantages: you can save space by sharing all the SHA1 objects.
-	 * On the other hand, it might just make lookup slower and messier. You
-	 * be the judge.
-	 */
 	sha1_dir = getenv(DB_ENVIRONMENT);
 	if (sha1_dir) {
 		struct stat st;
@@ -29,9 +29,6 @@ int main(int argc, char **argv)
 		fprintf(stderr, "DB_ENVIRONMENT set to bad directory %s: ", sha1_dir);
 	}
 
-	/*
-	 * The default case is to have a DB per managed directory.
-	 */
 	sha1_dir = DEFAULT_DB_ENVIRONMENT;
 	fprintf(stderr, "defaulting to private storage area\n");
 	len = strlen(sha1_dir);
