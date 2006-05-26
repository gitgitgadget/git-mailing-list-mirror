From: Petr Baudis <pasky@suse.cz>
Subject: [PATCH] Call builtin ls-tree in git-cat-file -p
Date: Fri, 26 May 2006 18:59:17 +0200
Message-ID: <20060526165917.5215.39602.stgit@machine.or.cz>
Cc: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri May 26 18:59:05 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FjfeM-0002c6-OY
	for gcvg-git@gmane.org; Fri, 26 May 2006 18:58:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751156AbWEZQ64 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 26 May 2006 12:58:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751157AbWEZQ64
	(ORCPT <rfc822;git-outgoing>); Fri, 26 May 2006 12:58:56 -0400
Received: from w241.dkm.cz ([62.24.88.241]:11199 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S1751156AbWEZQ6z (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 26 May 2006 12:58:55 -0400
Received: (qmail 5231 invoked from network); 26 May 2006 18:59:17 +0200
Received: from localhost (HELO machine.or.cz) (xpasky@127.0.0.1)
  by localhost with SMTP; 26 May 2006 18:59:17 +0200
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20820>

Signed-off-by: Petr Baudis <pasky@suse.cz>
---

 builtin-cat-file.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/builtin-cat-file.c b/builtin-cat-file.c
index 8ab136e..4d36817 100644
--- a/builtin-cat-file.c
+++ b/builtin-cat-file.c
@@ -141,7 +141,7 @@ int cmd_cat_file(int argc, const char **
 
 		/* custom pretty-print here */
 		if (!strcmp(type, tree_type))
-			return execl_git_cmd("ls-tree", argv[2], NULL);
+			return cmd_ls_tree(2, argv + 1, NULL);
 
 		buf = read_sha1_file(sha1, type, &size);
 		if (!buf)
