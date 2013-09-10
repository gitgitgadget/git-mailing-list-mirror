From: Brad King <brad.king@kitware.com>
Subject: [PATCH v6 1/8] reset: rename update_refs to reset_refs
Date: Mon,  9 Sep 2013 20:57:39 -0400
Message-ID: <caa29a576f30be135956073ccab6534d0877a418.1378773895.git.brad.king@kitware.com>
References: <cover.1378732710.git.brad.king@kitware.com> <cover.1378773895.git.brad.king@kitware.com>
Cc: gitster@pobox.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 10 03:00:10 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VJCJL-0007JJ-Fb
	for gcvg-git-2@plane.gmane.org; Tue, 10 Sep 2013 03:00:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756450Ab3IJA75 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Sep 2013 20:59:57 -0400
Received: from tripoint.kitware.com ([66.194.253.20]:41682 "EHLO
	vesper.kitware.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1756126Ab3IJA75 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Sep 2013 20:59:57 -0400
Received: by vesper.kitware.com (Postfix, from userid 1000)
	id 8C7A39FB8B; Mon,  9 Sep 2013 20:57:46 -0400 (EDT)
X-Mailer: git-send-email 1.8.4.rc3
In-Reply-To: <cover.1378773895.git.brad.king@kitware.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234408>

The function resets refs rather than doing arbitrary updates.
Rename it to allow a future general-purpose update_refs function
to be added.

Signed-off-by: Brad King <brad.king@kitware.com>
---
 builtin/reset.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/builtin/reset.c b/builtin/reset.c
index 5e4c551..88b4fde 100644
--- a/builtin/reset.c
+++ b/builtin/reset.c
@@ -226,7 +226,7 @@ static void parse_args(struct pathspec *pathspec,
 		       prefix, argv);
 }
 
-static int update_refs(const char *rev, const unsigned char *sha1)
+static int reset_refs(const char *rev, const unsigned char *sha1)
 {
 	int update_ref_status;
 	struct strbuf msg = STRBUF_INIT;
@@ -357,7 +357,7 @@ int cmd_reset(int argc, const char **argv, const char *prefix)
 	if (!pathspec.nr && !unborn) {
 		/* Any resets without paths update HEAD to the head being
 		 * switched to, saving the previous head in ORIG_HEAD before. */
-		update_ref_status = update_refs(rev, sha1);
+		update_ref_status = reset_refs(rev, sha1);
 
 		if (reset_type == HARD && !update_ref_status && !quiet)
 			print_new_head_line(lookup_commit_reference(sha1));
-- 
1.8.4.rc3
