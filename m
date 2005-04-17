From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH] Trivial typofix in file creation mode.
Date: Sun, 17 Apr 2005 01:04:14 -0700
Message-ID: <7vd5st25j5.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 17 10:01:13 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DN4iF-0008A4-GG
	for gcvg-git@gmane.org; Sun, 17 Apr 2005 10:01:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261278AbVDQIEn (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 17 Apr 2005 04:04:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261279AbVDQIEn
	(ORCPT <rfc822;git-outgoing>); Sun, 17 Apr 2005 04:04:43 -0400
Received: from fed1rmmtao08.cox.net ([68.230.241.31]:58252 "EHLO
	fed1rmmtao08.cox.net") by vger.kernel.org with ESMTP
	id S261278AbVDQIEl (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Apr 2005 04:04:41 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao08.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050417080414.DTQO18934.fed1rmmtao08.cox.net@assigned-by-dhcp.cox.net>;
          Sun, 17 Apr 2005 04:04:14 -0400
To: Linus Torvalds <torvalds@osdl.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

This patch fixes an obvious typo whose consequence is rather
disastrous in the file creation mode.  Relative to Linus HEAD
85dd8bdfbbc6b1431230ebadc7e0af2ca94fed9f.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---

 checkout-cache.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

checkout-cache.c: 3b4f2644861bbd74713c51ef8e612d2fc84941d3
--- checkout-cache.c
+++ checkout-cache.c	2005-04-17 00:55:34.000000000 -0700
@@ -54,7 +54,7 @@
 {
 	int fd;
 
-	mode = (mode & 0100) ? 777 : 666;
+	mode = (mode & 0100) ? 0777 : 0666;
 	fd = open(path, O_WRONLY | O_TRUNC | O_CREAT, mode);
 	if (fd < 0) {
 		if (errno == ENOENT) {

