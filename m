From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH] checkout-cache: add usage string.
Date: Wed, 13 Jul 2005 20:25:07 -0700
Message-ID: <7vmzoqkr1o.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 14 05:25:21 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DsuLf-0007yi-Mn
	for gcvg-git@gmane.org; Thu, 14 Jul 2005 05:25:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262769AbVGNDZL (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 13 Jul 2005 23:25:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262873AbVGNDZL
	(ORCPT <rfc822;git-outgoing>); Wed, 13 Jul 2005 23:25:11 -0400
Received: from fed1rmmtao04.cox.net ([68.230.241.35]:9387 "EHLO
	fed1rmmtao04.cox.net") by vger.kernel.org with ESMTP
	id S262769AbVGNDZJ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Jul 2005 23:25:09 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao04.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050714032505.JZNG15197.fed1rmmtao04.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 13 Jul 2005 23:25:05 -0400
To: Linus Torvalds <torvalds@osdl.org>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

This adds the usage string to checkout-cache and you can say
"--help" to get it.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---

 checkout-cache.c |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

0d87d25f9a8ecf6ee8c4bc0c1575f3c03614c339
diff --git a/checkout-cache.c b/checkout-cache.c
--- a/checkout-cache.c
+++ b/checkout-cache.c
@@ -75,6 +75,9 @@ static int checkout_all(void)
 	return 0;
 }
 
+static const char *checkout_cache_usage =
+"git-checkout-cache [-u] [-q] [-a] [-f] [-n] [--prefix=<string>] [--] <file>...";
+
 int main(int argc, char **argv)
 {
 	int i, force_filename = 0;
@@ -123,6 +126,8 @@ int main(int argc, char **argv)
 				state.base_dir_len = strlen(state.base_dir);
 				continue;
 			}
+			if (arg[0] == '-')
+				usage(checkout_cache_usage);
 		}
 		if (state.base_dir_len) {
 			/* when --prefix is specified we do not
