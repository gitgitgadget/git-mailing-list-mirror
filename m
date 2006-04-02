From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH] revision: --max-age alone does not need limit_list() anymore.
Date: Sat, 01 Apr 2006 19:17:28 -0800
Message-ID: <7vhd5cmzsn.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.64.0603301648530.27203@g5.osdl.org>
	<Pine.LNX.4.64.0603301652531.27203@g5.osdl.org>
	<7vr74jxhp3.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0603302225160.27203@g5.osdl.org>
	<7vr74jw0zj.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0604011628500.3684@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 02 05:17:39 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FPt5s-0007rX-D8
	for gcvg-git@gmane.org; Sun, 02 Apr 2006 05:17:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751662AbWDBDRa (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 1 Apr 2006 22:17:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751663AbWDBDRa
	(ORCPT <rfc822;git-outgoing>); Sat, 1 Apr 2006 22:17:30 -0500
Received: from fed1rmmtao07.cox.net ([68.230.241.32]:47573 "EHLO
	fed1rmmtao07.cox.net") by vger.kernel.org with ESMTP
	id S1751659AbWDBDR3 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 1 Apr 2006 22:17:29 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao07.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060402031729.WCJB3131.fed1rmmtao07.cox.net@assigned-by-dhcp.cox.net>;
          Sat, 1 Apr 2006 22:17:29 -0500
To: Linus Torvalds <torvalds@osdl.org>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18257>

This makes git log --since=7.days to be streamable.

Signed-off-by: Junio C Hamano <junkio@cox.net>

---

 revision.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

bbbc8c3a8d455e1f5d15c3764eba70250b5479e9
diff --git a/revision.c b/revision.c
index cdd29c5..728b6d1 100644
--- a/revision.c
+++ b/revision.c
@@ -699,7 +699,7 @@ int setup_revisions(int argc, const char
 		add_one_commit(commit, revs);
 	}
 
-	if ((revs->max_age != -1) || revs->topo_order || revs->unpacked)
+	if (revs->topo_order || revs->unpacked)
 		revs->limited = 1;
 
 	if (revs->prune_data) {
-- 
1.3.0.rc1.gf385
