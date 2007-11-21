From: Steffen Prohaska <prohaska@zib.de>
Subject: [PATCH 2/3] builtin-init-db: use get_git_dir() instead of getenv()
Date: Wed, 21 Nov 2007 21:27:20 +0100
Message-ID: <11956768413887-git-send-email-prohaska@zib.de>
References: <11956768414090-git-send-email-prohaska@zib.de>
 <11956768412804-git-send-email-prohaska@zib.de>
Cc: Steffen Prohaska <prohaska@zib.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 21 21:28:07 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IuwB3-0008Rz-Tx
	for gcvg-git-2@gmane.org; Wed, 21 Nov 2007 21:28:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752970AbXKUU13 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Nov 2007 15:27:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752927AbXKUU12
	(ORCPT <rfc822;git-outgoing>); Wed, 21 Nov 2007 15:27:28 -0500
Received: from mailer.zib.de ([130.73.108.11]:42015 "EHLO mailer.zib.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752013AbXKUU1Y (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Nov 2007 15:27:24 -0500
Received: from mailsrv2.zib.de (sc2.zib.de [130.73.108.31])
	by mailer.zib.de (8.13.7+Sun/8.13.7) with ESMTP id lALKRMVE007522
	for <git@vger.kernel.org>; Wed, 21 Nov 2007 21:27:22 +0100 (CET)
Received: from localhost.localdomain (vss6.zib.de [130.73.69.7])
	by mailsrv2.zib.de (8.13.4/8.13.4) with ESMTP id lALKRLdH013767;
	Wed, 21 Nov 2007 21:27:21 +0100 (MET)
X-Mailer: git-send-email 1.5.2.4
In-Reply-To: <11956768412804-git-send-email-prohaska@zib.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65702>

We have a function get_git_dir().  So let's use it,
instead of querying the environment.

Signed-off-by: Steffen Prohaska <prohaska@zib.de>
---
 builtin-init-db.c |    4 +---
 1 files changed, 1 insertions(+), 3 deletions(-)

diff --git a/builtin-init-db.c b/builtin-init-db.c
index 763fa55..80d2f27 100644
--- a/builtin-init-db.c
+++ b/builtin-init-db.c
@@ -378,9 +378,7 @@ int cmd_init_db(int argc, const char **argv, const char *prefix)
 	/*
 	 * Set up the default .git directory contents
 	 */
-	git_dir = getenv(GIT_DIR_ENVIRONMENT);
-	if (!git_dir)
-		git_dir = DEFAULT_GIT_DIR_ENVIRONMENT;
+	git_dir = get_git_dir();
 	safe_create_dir(git_dir, 0);
 
 	/* Check to see if the repository version is right.
-- 
1.5.3.5.750.g8692
