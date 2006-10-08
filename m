From: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
Subject: [PATCH] git-tar-tree: don't RUN_SETUP
Date: Sun, 08 Oct 2006 15:44:50 +0200
Message-ID: <452900D2.3070707@lsrfire.ath.cx>
References: <4528F8AD.2040307@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git-list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Oct 08 15:45:46 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GWYxK-0004In-IU
	for gcvg-git@gmane.org; Sun, 08 Oct 2006 15:44:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751159AbWJHNof (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 8 Oct 2006 09:44:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751162AbWJHNoe
	(ORCPT <rfc822;git-outgoing>); Sun, 8 Oct 2006 09:44:34 -0400
Received: from static-ip-217-172-187-230.inaddr.intergenia.de ([217.172.187.230]:29580
	"EHLO neapel230.server4you.de") by vger.kernel.org with ESMTP
	id S1751159AbWJHNod (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Oct 2006 09:44:33 -0400
Received: from [10.0.1.3] (p508E73F3.dip.t-dialin.net [80.142.115.243])
	by neapel230.server4you.de (Postfix) with ESMTP id BE4A226000;
	Sun,  8 Oct 2006 15:44:32 +0200 (CEST)
User-Agent: Thunderbird 1.5.0.7 (Windows/20060909)
To: Jiri Slaby <jirislaby@gmail.com>, Junio C Hamano <junkio@cox.net>
In-Reply-To: <4528F8AD.2040307@gmail.com>
X-Enigmail-Version: 0.94.0.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28539>

Noted by Jiri Slaby, git-tar-tree --remote doesn't need to be run
from inside of a git archive.  Since git-tar-tree is now only a
wrapper for git-archive, which calls setup_git_directory() as
needed, we should drop the flag RUN_SETUP.

Signed-off-by: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
---

diff --git a/git.c b/git.c
index b8e8622..d7103a4 100644
--- a/git.c
+++ b/git.c
@@ -258,7 +258,7 @@ static void handle_internal_command(int 
 		{ "show", cmd_show, RUN_SETUP | USE_PAGER },
 		{ "stripspace", cmd_stripspace },
 		{ "symbolic-ref", cmd_symbolic_ref, RUN_SETUP },
-		{ "tar-tree", cmd_tar_tree, RUN_SETUP },
+		{ "tar-tree", cmd_tar_tree },
 		{ "unpack-objects", cmd_unpack_objects, RUN_SETUP },
 		{ "update-index", cmd_update_index, RUN_SETUP },
 		{ "update-ref", cmd_update_ref, RUN_SETUP },
