From: Sandy Carter <sandy.carter@savoirfairelinux.com>
Subject: [PATCH v2 2/2] i18n: assure command not corrupted by _() process
Date: Mon,  3 Mar 2014 09:55:54 -0500
Message-ID: <1393858554-4392-2-git-send-email-sandy.carter@savoirfairelinux.com>
References: <1393620766-17582-1-git-send-email-sandy.carter@savoirfairelinux.com>
 <1393858554-4392-1-git-send-email-sandy.carter@savoirfairelinux.com>
Cc: jn.avila@free.fr, Sandy Carter <sandy.carter@savoirfairelinux.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 03 15:55:13 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WKUGu-0005U0-Gw
	for gcvg-git-2@plane.gmane.org; Mon, 03 Mar 2014 15:55:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755117AbaCCOy5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Mar 2014 09:54:57 -0500
Received: from mail.savoirfairelinux.com ([209.172.62.77]:54758 "EHLO
	mail.savoirfairelinux.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755110AbaCCOyy (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Mar 2014 09:54:54 -0500
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id 47E5E10D72B5;
	Mon,  3 Mar 2014 09:54:54 -0500 (EST)
X-Virus-Scanned: amavisd-new at mail.savoirfairelinux.com
Received: from mail.savoirfairelinux.com ([127.0.0.1])
	by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id oXY-AOFCdy6R; Mon,  3 Mar 2014 09:54:54 -0500 (EST)
Received: from scarter-X220.mtl.sfl (mtl.savoirfairelinux.net [208.88.110.46])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id 0BFFC10D72B1;
	Mon,  3 Mar 2014 09:54:54 -0500 (EST)
X-Mailer: git-send-email 1.9.0
In-Reply-To: <1393858554-4392-1-git-send-email-sandy.carter@savoirfairelinux.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243226>

Separate message from command examples to avoid translation issues
such as a dash being omitted in a translation.

Signed-off-by: Sandy Carter <sandy.carter@savoirfairelinux.com>
---
 builtin/branch.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/builtin/branch.c b/builtin/branch.c
index b4d7716..b304da8 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -1022,11 +1022,13 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
 		 */
 		if (argc == 1 && track == BRANCH_TRACK_OVERRIDE &&
 		    !branch_existed && remote_tracking) {
-			fprintf(stderr, _("\nIf you wanted to make '%s' track '%s', do this:\n\n"), head, branch->name);
-			fprintf(stderr, _("    git branch -d %s\n"), branch->name);
-			fprintf(stderr, _("    git branch --set-upstream-to %s\n"), branch->name);
+			fprintf(stderr, "\n");
+			fprintf(stderr, _("If you wanted to make '%s' track '%s', do this:"), head, branch->name);
+			fprintf(stderr, "\n\n");
+			fprintf(stderr, "    git branch -d %s\n", branch->name);
+			fprintf(stderr, "    git branch --set-upstream-to %s\n", branch->name);
+			fprintf(stderr, "\n");
 		}
-
 	} else
 		usage_with_options(builtin_branch_usage, options);
 
-- 
1.9.0
