From: Larry D'Anna <larry@elder-gods.org>
Subject: [PATCH 1/4] git-push: fix an error message so it goes to stderr
Date: Tue,  9 Feb 2010 00:53:59 -0500
Message-ID: <1d1ce7e0ad28fd0cad8d9d7bfeda04ba58be36d4.1265694627.git.larry@elder-gods.org>
References: <20100209054820.GA30907@cthulhu>
Cc: Larry D'Anna <larry@elder-gods.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 09 06:54:28 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nej3M-0006T5-9i
	for gcvg-git-2@lo.gmane.org; Tue, 09 Feb 2010 06:54:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752439Ab0BIFyH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Feb 2010 00:54:07 -0500
Received: from cthulhu.elder-gods.org ([140.239.99.253]:36724 "EHLO
	cthulhu.elder-gods.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751413Ab0BIFyF (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Feb 2010 00:54:05 -0500
Received: by cthulhu.elder-gods.org (Postfix, from userid 1000)
	id D962F82200E; Tue,  9 Feb 2010 00:54:02 -0500 (EST)
X-Mailer: git-send-email 1.7.0.rc1.33.g07cf0f.dirty
In-Reply-To: <20100209054820.GA30907@cthulhu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139368>

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
1.7.0.rc1.33.g07cf0f.dirty
