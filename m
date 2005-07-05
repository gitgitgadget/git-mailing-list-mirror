From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH] Fixlet for argument parsing in rev-list.
Date: Tue, 05 Jul 2005 00:54:05 -0700
Message-ID: <7vpstxg02q.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: jon.seymour@gmail.com, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 05 09:55:12 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DpiGP-00040Y-IM
	for gcvg-git@gmane.org; Tue, 05 Jul 2005 09:54:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261593AbVGEHyT (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 5 Jul 2005 03:54:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261752AbVGEHyT
	(ORCPT <rfc822;git-outgoing>); Tue, 5 Jul 2005 03:54:19 -0400
Received: from fed1rmmtao07.cox.net ([68.230.241.32]:27123 "EHLO
	fed1rmmtao07.cox.net") by vger.kernel.org with ESMTP
	id S261593AbVGEHyM (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Jul 2005 03:54:12 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao07.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050705075406.YLWH1367.fed1rmmtao07.cox.net@assigned-by-dhcp.cox.net>;
          Tue, 5 Jul 2005 03:54:06 -0400
To: torvalds@osdl.org
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

The --merge-order flag does not take parameter so there is no
point doing strncmp with the length.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---

 rev-list.c |    2 +-
 1 file changed, 1 insertions(+), 1 deletions(-)

diff --git a/rev-list.c b/rev-list.c
--- a/rev-list.c
+++ b/rev-list.c
@@ -462,7 +462,7 @@ int main(int argc, char **argv)
 			limited = 1;
 			continue;
 		}
-		if (!strncmp(arg, "--merge-order", 13)) {
+		if (!strcmp(arg, "--merge-order")) {
 		        merge_order = 1;
 			continue;
 		}
------------------------------------------------
