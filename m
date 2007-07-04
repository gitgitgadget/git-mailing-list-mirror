From: Andrew Ruder <andy@aeruder.net>
Subject: [PATCH] Remove USE_PAGER from git-pickaxe and git-annotate
Date: Wed, 4 Jul 2007 17:21:49 -0500
Message-ID: <20070704222148.GB13317@bowser.ruder>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Thu Jul 05 00:22:11 2007
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I6DEg-00044H-Gv
	for gcvg-git@gmane.org; Thu, 05 Jul 2007 00:22:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758663AbXGDWVy (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 4 Jul 2007 18:21:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758600AbXGDWVy
	(ORCPT <rfc822;git-outgoing>); Wed, 4 Jul 2007 18:21:54 -0400
Received: from aeruder.net ([208.78.97.67]:47422 "EHLO aeruder.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755531AbXGDWVu (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Jul 2007 18:21:50 -0400
Received: from aeruder (localhost [127.0.0.1])
	by aeruder.net (Postfix) with ESMTP id BAA7A22055C;
	Wed,  4 Jul 2007 22:21:50 +0000 (UTC)
Mail-Followup-To: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51646>

git-blame (and friends) specifically leave the pager turned off
in the case that --incremental is specified as this isn't for
human consumption.  git-pickaxe and git-annotate will turn it on
themselves otherwise.

Signed-off-by: Andrew Ruder <andy@aeruder.net>
---
 git.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/git.c b/git.c
index 727aabc..a647f9c 100644
--- a/git.c
+++ b/git.c
@@ -303,7 +303,7 @@ static void handle_internal_command(int argc, const char **argv)
 	const char *cmd = argv[0];
 	static struct cmd_struct commands[] = {
 		{ "add", cmd_add, RUN_SETUP | NEED_WORK_TREE },
-		{ "annotate", cmd_annotate, RUN_SETUP | USE_PAGER },
+		{ "annotate", cmd_annotate, RUN_SETUP },
 		{ "apply", cmd_apply },
 		{ "archive", cmd_archive },
 		{ "blame", cmd_blame, RUN_SETUP },
@@ -345,7 +345,7 @@ static void handle_internal_command(int argc, const char **argv)
 		{ "mv", cmd_mv, RUN_SETUP | NEED_WORK_TREE },
 		{ "name-rev", cmd_name_rev, RUN_SETUP },
 		{ "pack-objects", cmd_pack_objects, RUN_SETUP },
-		{ "pickaxe", cmd_blame, RUN_SETUP | USE_PAGER },
+		{ "pickaxe", cmd_blame, RUN_SETUP },
 		{ "prune", cmd_prune, RUN_SETUP },
 		{ "prune-packed", cmd_prune_packed, RUN_SETUP },
 		{ "push", cmd_push, RUN_SETUP },
-- 
1.5.3.rc0.13.gc37c
