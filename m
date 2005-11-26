From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH 4/4] setup_git_directory(): check repository format version.
Date: Fri, 25 Nov 2005 17:15:15 -0800
Message-ID: <7v1x14gqfw.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Sat Nov 26 02:15:42 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Efof3-0004aa-4T
	for gcvg-git@gmane.org; Sat, 26 Nov 2005 02:15:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932709AbVKZBPT (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 25 Nov 2005 20:15:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932713AbVKZBPT
	(ORCPT <rfc822;git-outgoing>); Fri, 25 Nov 2005 20:15:19 -0500
Received: from fed1rmmtao01.cox.net ([68.230.241.38]:23224 "EHLO
	fed1rmmtao01.cox.net") by vger.kernel.org with ESMTP
	id S932709AbVKZBPR (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Nov 2005 20:15:17 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao01.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051126011445.YOJP15695.fed1rmmtao01.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 25 Nov 2005 20:14:45 -0500
To: git@vger.kernel.org
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12758>

After figuring out the GIT_DIR location, make sure the
repository is of the right vintage, by calling
check_repository_format(). .

Signed-off-by: Junio C Hamano <junkio@cox.net>

---

 setup.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

applies-to: 780a67370b48b5230c31092b613533a109eb57f8
f30efdb616487d90c037c6d0c4088e151b960016
diff --git a/setup.c b/setup.c
index 0e2e3c8..cc44a72 100644
--- a/setup.c
+++ b/setup.c
@@ -173,5 +173,6 @@ int check_repository_format(void)
 const char *setup_git_directory(void)
 {
 	const char *retval = setup_git_directory_1();
+	check_repository_format();
 	return retval;
 }
---
0.99.9.GIT
