From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH] sha1_name: do not accept .git/refs/snap/.
Date: Sun, 21 Aug 2005 02:43:08 -0700
Message-ID: <7vr7cniq1f.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Sun Aug 21 11:43:29 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E6mMD-0004jh-SR
	for gcvg-git@gmane.org; Sun, 21 Aug 2005 11:43:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750908AbVHUJnL (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 21 Aug 2005 05:43:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750913AbVHUJnL
	(ORCPT <rfc822;git-outgoing>); Sun, 21 Aug 2005 05:43:11 -0400
Received: from fed1rmmtao08.cox.net ([68.230.241.31]:14818 "EHLO
	fed1rmmtao08.cox.net") by vger.kernel.org with ESMTP
	id S1750908AbVHUJnK (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Aug 2005 05:43:10 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao08.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050821094309.GPAJ16890.fed1rmmtao08.cox.net@assigned-by-dhcp.cox.net>;
          Sun, 21 Aug 2005 05:43:09 -0400
To: git@vger.kernel.org
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

I think Linus did a cut & paste from an early JIT code while
developing the current extended SHA1 notation, and left it there as a
courtesy, but the directory does not deserve to be treated any more
specially than, say, .git/refs/bisect.

If the subdirectories under .git/refs proliferate, we may want to
switch to scanning that hierarchy at runtime, instead of the current
hard-coded set, although I think that would be overkill.

Signed-off-by: Junio C Hamano <junkio@cox.net>

---

 sha1_name.c |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

19b3a5f94a98d523272c5c19fc166e879ce517e0
diff --git a/sha1_name.c b/sha1_name.c
--- a/sha1_name.c
+++ b/sha1_name.c
@@ -143,7 +143,6 @@ static int get_sha1_basic(const char *st
 		"refs",
 		"refs/tags",
 		"refs/heads",
-		"refs/snap",
 		NULL
 	};
 	const char **p;
