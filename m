From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH 2/6] git-describe: use find_unique_abbrev()
Date: Tue, 27 Dec 2005 16:42:23 -0800
Message-ID: <7vvexa2gsw.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.64.0512241339120.14098@g5.osdl.org>
	<Pine.LNX.4.64.0512241409300.14098@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Dec 28 01:43:27 2005
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ErPPX-0003w8-31
	for gcvg-git@gmane.org; Wed, 28 Dec 2005 01:43:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932426AbVL1Ama (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 27 Dec 2005 19:42:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932419AbVL1Am3
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Dec 2005 19:42:29 -0500
Received: from fed1rmmtao08.cox.net ([68.230.241.31]:43495 "EHLO
	fed1rmmtao08.cox.net") by vger.kernel.org with ESMTP
	id S932428AbVL1Am0 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Dec 2005 19:42:26 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao08.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051228004038.KDGB26964.fed1rmmtao08.cox.net@assigned-by-dhcp.cox.net>;
          Tue, 27 Dec 2005 19:40:38 -0500
To: Linus Torvalds <torvalds@osdl.org>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14087>

Just in case 8 hexadecimal digits are not enough.  We could use
shorter default if we wanted to.

Signed-off-by: Junio C Hamano <junkio@cox.net>

---

 describe.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

298f9203cf85d5de28a8380bd26f85206530b7d0
diff --git a/describe.c b/describe.c
index e1b6588..ba49d00 100644
--- a/describe.c
+++ b/describe.c
@@ -95,7 +95,8 @@ static void describe(struct commit *cmit
 		struct commit *c = pop_most_recent_commit(&list, SEEN);
 		n = match(c);
 		if (n) {
-			printf("%s-g%.8s\n", n->path, sha1_to_hex(cmit->object.sha1));
+			printf("%s-g%s\n", n->path,
+			       find_unique_abbrev(cmit->object.sha1, 8));
 			return;
 		}
 	}
-- 
1.0.5-geb9d
