From: Larry D'Anna <larry@elder-gods.org>
Subject: [PATCH 1/4] git-push: fix an advice message so it goes to stderr
Date: Fri, 26 Feb 2010 22:59:48 -0500
Message-ID: <68fd39ac6602471919939a84168be62f1fe464f7.1267243044.git.larry@elder-gods.org>
References: <cover.1267242789.git.larry@elder-gods.org>
Cc: Larry D'Anna <larry@elder-gods.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 27 05:00:01 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NlDqS-0003UZ-3L
	for gcvg-git-2@lo.gmane.org; Sat, 27 Feb 2010 05:00:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S967787Ab0B0D74 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Feb 2010 22:59:56 -0500
Received: from cthulhu.elder-gods.org ([140.239.99.253]:59105 "EHLO
	cthulhu.elder-gods.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S967767Ab0B0D7y (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Feb 2010 22:59:54 -0500
Received: by cthulhu.elder-gods.org (Postfix, from userid 1000)
	id 0B848822005; Fri, 26 Feb 2010 22:59:53 -0500 (EST)
X-Mailer: git-send-email 1.7.0.rc2.40.g7d8aa
In-Reply-To: <cover.1267242789.git.larry@elder-gods.org>
In-Reply-To: <cover.1267243044.git.larry@elder-gods.org>
References: <cover.1267243044.git.larry@elder-gods.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141172>

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
