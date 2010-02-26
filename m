From: Larry D'Anna <larry@elder-gods.org>
Subject: [PATCH 1/4] git-push: fix an error message so it goes to stderr
Date: Fri, 26 Feb 2010 14:50:07 -0500
Message-ID: <06e8e98b7ea63061e59e74c42f7d73cb00e579f6.1267211537.git.larry@elder-gods.org>
References: <cover.1267211537.git.larry@elder-gods.org>
Cc: Larry D'Anna <larry@elder-gods.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 26 20:50:53 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nl6Ce-0006fO-Qf
	for gcvg-git-2@lo.gmane.org; Fri, 26 Feb 2010 20:50:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965923Ab0BZTuS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Feb 2010 14:50:18 -0500
Received: from cthulhu.elder-gods.org ([140.239.99.253]:37689 "EHLO
	cthulhu.elder-gods.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965906Ab0BZTuP (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Feb 2010 14:50:15 -0500
Received: by cthulhu.elder-gods.org (Postfix, from userid 1000)
	id 6C5DB822005; Fri, 26 Feb 2010 14:50:11 -0500 (EST)
X-Mailer: git-send-email 1.7.0.rc2.40.g7d8aa
In-Reply-To: <cover.1267211537.git.larry@elder-gods.org>
In-Reply-To: <cover.1267211537.git.larry@elder-gods.org>
References: <cover.1267211537.git.larry@elder-gods.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141142>

These sort of messages typically go to the standard error.

Signed-off-by: Larry D'Anna <larry@elder-gods.org>
---
 builtin-push.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/builtin-push.c b/builtin-push.c
index 5633f0a..0a27072 100644
--- a/builtin-push.c
+++ b/builtin-push.c
@@ -124,9 +124,9 @@ static int push_with_options(struct transport *transport, int flags)
 		return 0;
 
 	if (nonfastforward && advice_push_nonfastforward) {
-		printf("To prevent you from losing history, non-fast-forward updates were rejected\n"
-		       "Merge the remote changes before pushing again.  See the 'Note about\n"
-		       "fast-forwards' section of 'git push --help' for details.\n");
+		fprintf(stderr, "To prevent you from losing history, non-fast-forward updates were rejected\n"
+				"Merge the remote changes before pushing again.  See the 'Note about\n"
+				"fast-forwards' section of 'git push --help' for details.\n");
 	}
 
 	return 1;
-- 
1.7.0.rc2.40.g7d8aa
