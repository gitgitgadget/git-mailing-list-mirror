From: Zach Welch <zw@superlucidity.net>
Subject: [PATCH 2/8] init-db.c: [RESEND] make init-db work with common
 objects
Date: Tue, 19 Apr 2005 02:09:39 -0700
Message-ID: <mailbox-23311-1113901779-724118@spoon>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-From: git-owner@vger.kernel.org Tue Apr 19 11:06:38 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DNogJ-0005WK-Qe
	for gcvg-git@gmane.org; Tue, 19 Apr 2005 11:06:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261191AbVDSJKA (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 19 Apr 2005 05:10:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261419AbVDSJJ6
	(ORCPT <rfc822;git-outgoing>); Tue, 19 Apr 2005 05:09:58 -0400
Received: from spoon.guft.org ([63.224.205.130]:50062 "EHLO mail.guft.org")
	by vger.kernel.org with ESMTP id S261276AbVDSJJo (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 19 Apr 2005 05:09:44 -0400
Received: (qmail 23327 invoked by uid 5006); 19 Apr 2005 02:09:43 -0700
To: git@vger.kernel.org
In-Reply-To: mailbox-23311-1113901779-711084@spoon
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

This makes init-db work for common object database.

This patch applies on top of:
        [PATCH 0/8] init-db.c cleanup, add INDEX_FILE_DIRECTORY support
        [PATCH 1/8] init-db.c: [RESEND] remove redundant getenv call
 init-db.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)
Signed-Off-By: Zach Welch <zw@superlucidity.net>

Signed-Off-By: Aaron Straus <aaron@merfinllc.com>
Author: Aaron Straus <aaron@merfinllc.com>

init-db.c: aa00fbb1b95624f6c30090a17354c9c08a6ac596
--- a/init-db.c
+++ b/init-db.c
@@ -24,7 +24,7 @@ int main(int argc, char **argv)
 	sha1_dir = getenv(DB_ENVIRONMENT);
 	if (sha1_dir) {
 		struct stat st;
-		if (!stat(sha1_dir, &st) < 0 && S_ISDIR(st.st_mode))
+		if (!stat(sha1_dir, &st) && S_ISDIR(st.st_mode))
 			return 0;
 		fprintf(stderr, "DB_ENVIRONMENT set to bad directory %s: ", sha1_dir);
 	}

