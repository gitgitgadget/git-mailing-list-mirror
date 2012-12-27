From: Adam Spiers <git@adamspiers.org>
Subject: [PATCH v3 15/19] add.c: remove unused argument from validate_pathspec()
Date: Thu, 27 Dec 2012 02:32:34 +0000
Message-ID: <1356575558-2674-16-git-send-email-git@adamspiers.org>
References: <1356575558-2674-1-git-send-email-git@adamspiers.org>
To: git list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Dec 27 03:34:01 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1To3IF-0006l1-69
	for gcvg-git-2@plane.gmane.org; Thu, 27 Dec 2012 03:33:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752397Ab2L0CdQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 Dec 2012 21:33:16 -0500
Received: from coral.adamspiers.org ([85.119.82.20]:53767 "EHLO
	coral.adamspiers.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752371Ab2L0Ccw (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Dec 2012 21:32:52 -0500
Received: from localhost (host-2-103-56-128.as13285.net [2.103.56.128])
	by coral.adamspiers.org (Postfix) with ESMTPSA id CD1352E5E4
	for <git@vger.kernel.org>; Thu, 27 Dec 2012 02:32:51 +0000 (GMT)
X-Mailer: git-send-email 1.7.11.2.249.g31c7954
In-Reply-To: <1356575558-2674-1-git-send-email-git@adamspiers.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212183>

The 'argc' argument passed to validate_pathspec() was never used.

Signed-off-by: Adam Spiers <git@adamspiers.org>
---
 builtin/add.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/builtin/add.c b/builtin/add.c
index 856d232..1ba2a86 100644
--- a/builtin/add.c
+++ b/builtin/add.c
@@ -211,7 +211,7 @@ static void refresh(int verbose, const char **pathspec)
         free(seen);
 }
 
-static const char **validate_pathspec(int argc, const char **argv, const char *prefix)
+static const char **validate_pathspec(const char **argv, const char *prefix)
 {
 	const char **pathspec = get_pathspec(prefix, argv);
 
@@ -262,7 +262,7 @@ int interactive_add(int argc, const char **argv, const char *prefix, int patch)
 	const char **pathspec = NULL;
 
 	if (argc) {
-		pathspec = validate_pathspec(argc, argv, prefix);
+		pathspec = validate_pathspec(argv, prefix);
 		if (!pathspec)
 			return -1;
 	}
@@ -428,7 +428,7 @@ int cmd_add(int argc, const char **argv, const char *prefix)
 		fprintf(stderr, _("Maybe you wanted to say 'git add .'?\n"));
 		return 0;
 	}
-	pathspec = validate_pathspec(argc, argv, prefix);
+	pathspec = validate_pathspec(argv, prefix);
 
 	if (read_cache() < 0)
 		die(_("index file corrupt"));
-- 
1.7.11.2.249.g31c7954
