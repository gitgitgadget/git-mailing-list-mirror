From: Brad King <brad.king@kitware.com>
Subject: [PATCH/RFC 1/7] reset: rename update_refs to reset_refs
Date: Thu, 29 Aug 2013 10:11:49 -0400
Message-ID: <e2d48324726825844c209e4ca544b5c20ffeb11b.1377784597.git.brad.king@kitware.com>
References: <cover.1377784597.git.brad.king@kitware.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 29 16:22:34 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VF37K-0000xR-CS
	for gcvg-git-2@plane.gmane.org; Thu, 29 Aug 2013 16:22:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755130Ab3H2OWS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Aug 2013 10:22:18 -0400
Received: from tripoint.kitware.com ([66.194.253.20]:48744 "EHLO
	vesper.kitware.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754993Ab3H2OWQ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Aug 2013 10:22:16 -0400
Received: by vesper.kitware.com (Postfix, from userid 1000)
	id 6A3809FB86; Thu, 29 Aug 2013 10:11:55 -0400 (EDT)
X-Mailer: git-send-email 1.7.10.4
In-Reply-To: <cover.1377784597.git.brad.king@kitware.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233261>

Get it out of the way for a future refs.h function.

Signed-off-by: Brad King <brad.king@kitware.com>
---
 builtin/reset.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/builtin/reset.c b/builtin/reset.c
index afa6e02..789ee48 100644
--- a/builtin/reset.c
+++ b/builtin/reset.c
@@ -219,7 +219,7 @@ static const char **parse_args(const char **argv, const char *prefix, const char
 	return argv[0] ? get_pathspec(prefix, argv) : NULL;
 }
 
-static int update_refs(const char *rev, const unsigned char *sha1)
+static int reset_refs(const char *rev, const unsigned char *sha1)
 {
 	int update_ref_status;
 	struct strbuf msg = STRBUF_INIT;
@@ -350,7 +350,7 @@ int cmd_reset(int argc, const char **argv, const char *prefix)
 	if (!pathspec && !unborn) {
 		/* Any resets without paths update HEAD to the head being
 		 * switched to, saving the previous head in ORIG_HEAD before. */
-		update_ref_status = update_refs(rev, sha1);
+		update_ref_status = reset_refs(rev, sha1);
 
 		if (reset_type == HARD && !update_ref_status && !quiet)
 			print_new_head_line(lookup_commit_reference(sha1));
-- 
1.7.10.4
