From: Andrew Ruder <andy@aeruder.net>
Subject: [PATCH] Remove USE_PAGER from git-pickaxe
Date: Sun, 20 May 2007 22:44:18 -0500
Message-ID: <e0a4e69cdde1810d0194a91f2f4c2d753bb6c945.1179718985.git.andy@aeruder.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Mon May 21 05:47:30 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hpyro-0003IT-7W
	for gcvg-git@gmane.org; Mon, 21 May 2007 05:47:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752864AbXEUDrV (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 20 May 2007 23:47:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753191AbXEUDrV
	(ORCPT <rfc822;git-outgoing>); Sun, 20 May 2007 23:47:21 -0400
Received: from www.aeruder.net ([65.254.53.245]:4021 "EHLO aeruder.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752864AbXEUDrU (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 May 2007 23:47:20 -0400
Received: from aeruder.net (localhost [127.0.0.1])
	by aeruder.net (Postfix) with ESMTP id ABFE140BEF;
	Sun, 20 May 2007 22:47:19 -0500 (CDT)
Mail-Followup-To: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47961>

git-blame (and friends) specifically leave the pager turned
off in the case that --incremental is specified as this isn't
for human consumption.  git-pickaxe will turn it on itself
otherwise.

Signed-off-by: Andrew Ruder <andy@aeruder.net>
---
 git.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/git.c b/git.c
index eeb2c0c..2f25807 100644
--- a/git.c
+++ b/git.c
@@ -267,7 +267,7 @@ static void handle_internal_command(int argc, const char **argv, char **envp)
 		{ "mv", cmd_mv, RUN_SETUP | NOT_BARE },
 		{ "name-rev", cmd_name_rev, RUN_SETUP },
 		{ "pack-objects", cmd_pack_objects, RUN_SETUP },
-		{ "pickaxe", cmd_blame, RUN_SETUP | USE_PAGER },
+		{ "pickaxe", cmd_blame, RUN_SETUP },
 		{ "prune", cmd_prune, RUN_SETUP },
 		{ "prune-packed", cmd_prune_packed, RUN_SETUP },
 		{ "push", cmd_push, RUN_SETUP },
-- 
1.5.2.15.g56fe-dirty
