From: Zach Welch <zw@superlucidity.net>
Subject: [PATCH 1/8] init-db.c: [RESEND] remove redundant getenv call
Date: Tue, 19 Apr 2005 02:09:39 -0700
Message-ID: <mailbox-23311-1113901779-721411@spoon>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-From: git-owner@vger.kernel.org Tue Apr 19 11:07:10 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DNogJ-0005WK-Cx
	for gcvg-git@gmane.org; Tue, 19 Apr 2005 11:06:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261426AbVDSJKA (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 19 Apr 2005 05:10:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261404AbVDSJJx
	(ORCPT <rfc822;git-outgoing>); Tue, 19 Apr 2005 05:09:53 -0400
Received: from guft.superlucidity.net ([63.224.205.130]:49806 "EHLO
	mail.guft.org") by vger.kernel.org with ESMTP id S261255AbVDSJJn
	(ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Apr 2005 05:09:43 -0400
Received: (qmail 23324 invoked by uid 5006); 19 Apr 2005 02:09:41 -0700
To: git@vger.kernel.org
In-Reply-To: mailbox-23311-1113901779-711084@spoon
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

init-db calls getenv(DB_ENVIRONMENT) twice.  Once should be enough.

This patch applies on top of:
        [PATCH 0/8] init-db.c cleanup, add INDEX_FILE_DIRECTORY support
 init-db.c |    3 +--
 1 files changed, 1 insertion(+), 2 deletions(-)
Signed-Off-By: Zach Welch <zw@superlucidity.net>

Signed-Off-By: Tony Luck <tony.luck@intel.com>

--- a/init-db.c	2005-04-14 11:01:52.000000000 -0700
+++ b/init-db.c	2005-04-14 11:01:52.000000000 -0700
@@ -7,7 +7,7 @@
 
 int main(int argc, char **argv)
 {
-	char *sha1_dir = getenv(DB_ENVIRONMENT), *path;
+	char *sha1_dir, *path;
 	int len, i;
 
 	if (mkdir(".git", 0755) < 0) {
-

