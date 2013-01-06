From: Adam Spiers <git@adamspiers.org>
Subject: [PATCH v4 05/11] add.c: remove unused argument from validate_pathspec()
Date: Sun,  6 Jan 2013 16:58:07 +0000
Message-ID: <1357491493-11619-6-git-send-email-git@adamspiers.org>
References: <20130106161758.GC2396@pacific.linksys.moosehall>
 <1357491493-11619-1-git-send-email-git@adamspiers.org>
To: git list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Jan 06 17:58:47 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TrtYa-0007mE-1a
	for gcvg-git-2@plane.gmane.org; Sun, 06 Jan 2013 17:58:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756107Ab3AFQ6W (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 Jan 2013 11:58:22 -0500
Received: from coral.adamspiers.org ([85.119.82.20]:45597 "EHLO
	coral.adamspiers.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756079Ab3AFQ6T (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Jan 2013 11:58:19 -0500
Received: from localhost (f.4.d.7.f.d.e.f.f.f.3.7.3.0.a.1.0.0.0.0.b.1.4.6.0.b.8.0.1.0.0.2.ip6.arpa [IPv6:2001:8b0:641b:0:1a03:73ff:fedf:7d4f])
	by coral.adamspiers.org (Postfix) with ESMTPSA id 457B92E5DE
	for <git@vger.kernel.org>; Sun,  6 Jan 2013 16:58:18 +0000 (GMT)
X-Mailer: git-send-email 1.7.11.7.33.gb8feba5
In-Reply-To: <1357491493-11619-1-git-send-email-git@adamspiers.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212819>

The 'argc' argument passed to validate_pathspec() was never used.

Signed-off-by: Adam Spiers <git@adamspiers.org>
---
 builtin/add.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/builtin/add.c b/builtin/add.c
index c689f37..1f62ba3 100644
--- a/builtin/add.c
+++ b/builtin/add.c
@@ -197,7 +197,7 @@ static void refresh(int verbose, const char **pathspec)
         free(seen);
 }
 
-static const char **validate_pathspec(int argc, const char **argv, const char *prefix)
+static const char **validate_pathspec(const char **argv, const char *prefix)
 {
 	const char **pathspec = get_pathspec(prefix, argv);
 
@@ -248,7 +248,7 @@ int interactive_add(int argc, const char **argv, const char *prefix, int patch)
 	const char **pathspec = NULL;
 
 	if (argc) {
-		pathspec = validate_pathspec(argc, argv, prefix);
+		pathspec = validate_pathspec(argv, prefix);
 		if (!pathspec)
 			return -1;
 	}
@@ -414,7 +414,7 @@ int cmd_add(int argc, const char **argv, const char *prefix)
 		fprintf(stderr, _("Maybe you wanted to say 'git add .'?\n"));
 		return 0;
 	}
-	pathspec = validate_pathspec(argc, argv, prefix);
+	pathspec = validate_pathspec(argv, prefix);
 
 	if (read_cache() < 0)
 		die(_("index file corrupt"));
-- 
1.7.11.7.33.gb8feba5
