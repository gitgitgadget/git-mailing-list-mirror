From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH 4/4] Use tree_from_tree_or_commit() in ls-tree.
Date: Tue, 19 Apr 2005 23:11:00 -0700
Message-ID: <7v4qe2kmff.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 20 08:07:21 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DO8MW-0006WG-IS
	for gcvg-git@gmane.org; Wed, 20 Apr 2005 08:07:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261433AbVDTGLJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 20 Apr 2005 02:11:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261441AbVDTGLJ
	(ORCPT <rfc822;git-outgoing>); Wed, 20 Apr 2005 02:11:09 -0400
Received: from fed1rmmtao09.cox.net ([68.230.241.30]:33960 "EHLO
	fed1rmmtao09.cox.net") by vger.kernel.org with ESMTP
	id S261433AbVDTGLD (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Apr 2005 02:11:03 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao09.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050420061101.JLYW19936.fed1rmmtao09.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 20 Apr 2005 02:11:01 -0400
To: Linus Torvalds <torvalds@osdl.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

This patch makes ls-tree accept either tree or commit.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---

 ls-tree.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

Makefile: needs update
cache.h: needs update
sha1_file.c: needs update
--- a/ls-tree.c
+++ b/ls-tree.c
@@ -74,7 +74,7 @@ static int list(unsigned char *sha1)
 	unsigned long size;
 	char type[20];
 
-	buffer = read_sha1_file(sha1, type, &size);
+	buffer = tree_from_tree_or_commit(sha1, type, &size);
 	if (!buffer)
 		die("unable to read sha1 file");
 	list_recursive(buffer, type, size, NULL);

