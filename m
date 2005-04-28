From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH] diff-cache.c compilation warning fix.
Date: Wed, 27 Apr 2005 21:15:11 -0700
Message-ID: <7vekcvbkq8.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 28 06:10:22 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DR0M2-0003em-2b
	for gcvg-git@gmane.org; Thu, 28 Apr 2005 06:10:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261907AbVD1EPW (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 28 Apr 2005 00:15:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261903AbVD1EPW
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Apr 2005 00:15:22 -0400
Received: from fed1rmmtao04.cox.net ([68.230.241.35]:31728 "EHLO
	fed1rmmtao04.cox.net") by vger.kernel.org with ESMTP
	id S261907AbVD1EPQ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Apr 2005 00:15:16 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao04.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050428041512.ICYN23392.fed1rmmtao04.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 28 Apr 2005 00:15:12 -0400
To: Linus Torvalds <torvalds@osdl.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Nobody uses return value from show_new_file() function but it is
defined as returning int and falls off at the end without
returning.  Make it void.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---

diff-cache.c |    2 +-
1 files changed, 1 insertion(+), 1 deletion(-)

# - [PATCH] diff-tree -p implies diff-tree -p -r
# + working tree
--- k/diff-cache.c
+++ l/diff-cache.c
@@ -38,7 +38,7 @@ static int get_stat_data(struct cache_en
 	return 0;
 }
 
-static int show_new_file(struct cache_entry *new)
+static void show_new_file(struct cache_entry *new)
 {
 	unsigned char *sha1;
 	unsigned int mode;

