From: Scott R Parish <srp@srparish.net>
Subject: [PATCH] "git help" and "git help -a" shouldn't exit(1) unless they
	error
Date: Sun, 21 Oct 2007 14:47:45 -0700
Message-ID: <20071021214744.GH16291@srparish.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Oct 21 23:48:07 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IjieS-0007rM-J0
	for gcvg-git-2@gmane.org; Sun, 21 Oct 2007 23:48:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750838AbXJUVrt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 21 Oct 2007 17:47:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750827AbXJUVrt
	(ORCPT <rfc822;git-outgoing>); Sun, 21 Oct 2007 17:47:49 -0400
Received: from smtp-gw7.mailanyone.net ([208.70.128.55]:42842 "EHLO
	smtp-gw7.mailanyone.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750810AbXJUVrs (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Oct 2007 17:47:48 -0400
Received: from mailanyone.net
	by smtp-gw7.mailanyone.net with esmtps (TLSv1:AES256-SHA:256)
	(MailAnyone extSMTP srp)
	id 1IjieB-0000AU-17
	for git@vger.kernel.org; Sun, 21 Oct 2007 16:47:47 -0500
Received: by srparish.net (nbSMTP-1.00) for uid 502
	(using TLSv1/SSLv3 with cipher AES256-SHA (256/256 bits))
	srp@srparish.net; Sun, 21 Oct 2007 14:47:46 -0700 (PDT)
Content-Disposition: inline
User-Agent: Mutt/1.5.15 (2007-04-06)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61910>

Signed-off-by: Scott R Parish <srp@srparish.net>
---
 help.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/help.c b/help.c
index 1cd33ec..b0d2dd4 100644
--- a/help.c
+++ b/help.c
@@ -204,14 +204,14 @@ int cmd_help(int argc, const char **argv, const char *prefix)
 	if (!help_cmd) {
 		printf("usage: %s\n\n", git_usage_string);
 		list_common_cmds_help();
-		exit(1);
+		exit(0);
 	}
 
 	else if (!strcmp(help_cmd, "--all") || !strcmp(help_cmd, "-a")) {
 		printf("usage: %s\n\n", git_usage_string);
 		if(exec_path)
 			list_commands(exec_path, "git-*");
-		exit(1);
+		exit(0);
 	}
 
 	else
-- 
1.5.3.4.209.g5d1ce-dirty
