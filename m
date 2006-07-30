From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH 4/3] merge-recur: trivial cleanup
Date: Sun, 30 Jul 2006 20:30:09 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0607302029300.29667@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-From: git-owner@vger.kernel.org Sun Jul 30 20:30:21 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G7G3M-00037g-Di
	for gcvg-git@gmane.org; Sun, 30 Jul 2006 20:30:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932375AbWG3SaM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 30 Jul 2006 14:30:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932415AbWG3SaM
	(ORCPT <rfc822;git-outgoing>); Sun, 30 Jul 2006 14:30:12 -0400
Received: from mail.gmx.de ([213.165.64.21]:46748 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S932375AbWG3SaK (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 30 Jul 2006 14:30:10 -0400
Received: (qmail invoked by alias); 30 Jul 2006 18:30:09 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp029) with SMTP; 30 Jul 2006 20:30:09 +0200
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: git@vger.kernel.org, junkio@cox.net
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24468>


Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---

	I should learn to remember...

 merge-recursive.c |    9 ++++-----
 1 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/merge-recursive.c b/merge-recursive.c
index 3cdea81..10bce70 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -220,11 +220,10 @@ static int git_merge_trees(int index_onl
 	struct object_list *trees = NULL;
 	struct unpack_trees_options opts;
 
-	/* TODO: if (!cache_dirty) read */
-	if (cache_dirty)
-		flush_cache();
-
-	read_cache_from(getenv("GIT_INDEX_FILE"));
+	if (!cache_dirty) {
+		read_cache_from(getenv("GIT_INDEX_FILE"));
+		cache_dirty = 1;
+	}
 
 	memset(&opts, 0, sizeof(opts));
 	if (index_only)
-- 
1.4.2.rc2.g6fccc-dirty
