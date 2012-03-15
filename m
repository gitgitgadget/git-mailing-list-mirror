From: Namhyung Kim <namhyung.kim@lge.com>
Subject: [PATCH 1/3] help: Fix help message for aliases
Date: Thu, 15 Mar 2012 11:52:47 +0900
Message-ID: <1331779969-8641-1-git-send-email-namhyung.kim@lge.com>
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Mar 15 03:53:09 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S80oN-0002EK-NK
	for gcvg-git-2@plane.gmane.org; Thu, 15 Mar 2012 03:53:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751937Ab2COCws (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Mar 2012 22:52:48 -0400
Received: from LGEMRELSE1Q.lge.com ([156.147.1.111]:64104 "EHLO
	LGEMRELSE1Q.lge.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751535Ab2COCwr (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Mar 2012 22:52:47 -0400
X-AuditID: 9c93016f-b7cedae00000438b-57-4f615977bd3b
Received: from MultiCore.156.147.1.1 ( [165.186.175.80])
	by LGEMRELSE1Q.lge.com (Symantec Brightmail Gateway) with SMTP id B9.29.17291.779516F4; Thu, 15 Mar 2012 11:52:41 +0900 (KST)
X-Mailer: git-send-email 1.7.9
X-Brightmail-Tracker: AAAAAA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193171>

The current "`git br' is aliased to `branch'" looks a bit
strange. Prepend 'git' to aliased output too so that the
end result will be looked like this:

 $ git help br
 `git br' is aliased to `git branch'

Signed-off-by: Namhyung Kim <namhyung.kim@lge.com>
---
 builtin/help.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/builtin/help.c b/builtin/help.c
index 61ff798..f85c870 100644
--- a/builtin/help.c
+++ b/builtin/help.c
@@ -445,7 +445,7 @@ int cmd_help(int argc, const char **argv, const char *prefix)
 
 	alias = alias_lookup(argv[0]);
 	if (alias && !is_git_command(argv[0])) {
-		printf("`git %s' is aliased to `%s'\n", argv[0], alias);
+		printf("`git %s' is aliased to `git %s'\n", argv[0], alias);
 		return 0;
 	}
 
-- 
1.7.9
