From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: [PATCH] config.c: mark error and warnings strings for translation
Date: Thu, 31 Jul 2014 13:31:23 +0200
Message-ID: <1406806283-21571-1-git-send-email-Matthieu.Moy@imag.fr>
Cc: tanayabh@gmail.com, Matthieu Moy <Matthieu.Moy@imag.fr>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Thu Jul 31 13:32:06 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XCoab-0004FI-FK
	for gcvg-git-2@plane.gmane.org; Thu, 31 Jul 2014 13:32:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752245AbaGaLcA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 Jul 2014 07:32:00 -0400
Received: from mx1.imag.fr ([129.88.30.5]:59333 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751151AbaGaLb7 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 Jul 2014 07:31:59 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id s6VBVO5Q027818
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 31 Jul 2014 13:31:24 +0200
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id s6VBVPxg024882;
	Thu, 31 Jul 2014 13:31:25 +0200
Received: from moy by anie.imag.fr with local (Exim 4.80)
	(envelope-from <moy@imag.fr>)
	id 1XCoZw-0005hd-Tj; Thu, 31 Jul 2014 13:31:24 +0200
X-Mailer: git-send-email 2.0.2.737.gfb43bde
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Thu, 31 Jul 2014 13:31:24 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: s6VBVO5Q027818
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
MailScanner-NULL-Check: 1407411086.7726@CfiNg1hq+AF46xSsvPcmxg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254554>

Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
---
Noticed while reviewing Tanay's patches, but this one is independant
from his series, both syntactically and semantically.

 config.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/config.c b/config.c
index a191328..76eeb63 100644
--- a/config.c
+++ b/config.c
@@ -457,9 +457,9 @@ static int git_parse_source(config_fn_t fn, void *data)
 			break;
 	}
 	if (cf->die_on_error)
-		die("bad config file line %d in %s", cf->linenr, cf->name);
+		die(_("bad config file line %d in %s"), cf->linenr, cf->name);
 	else
-		return error("bad config file line %d in %s", cf->linenr, cf->name);
+		return error(_("bad config file line %d in %s"), cf->linenr, cf->name);
 }
 
 static int parse_unit_factor(const char *end, uintmax_t *val)
@@ -575,9 +575,9 @@ static void die_bad_number(const char *name, const char *value)
 		value = "";
 
 	if (cf && cf->name)
-		die("bad numeric config value '%s' for '%s' in %s: %s",
+		die(_("bad numeric config value '%s' for '%s' in %s: %s"),
 		    value, name, cf->name, reason);
-	die("bad numeric config value '%s' for '%s': %s", value, name, reason);
+	die(_("bad numeric config value '%s' for '%s': %s"), value, name, reason);
 }
 
 int git_config_int(const char *name, const char *value)
@@ -662,7 +662,7 @@ int git_config_pathname(const char **dest, const char *var, const char *value)
 		return config_error_nonbool(var);
 	*dest = expand_user_path(value);
 	if (!*dest)
-		die("Failed to expand user dir in: '%s'", value);
+		die(_("Failed to expand user dir in: '%s'"), value);
 	return 0;
 }
 
@@ -740,7 +740,7 @@ static int git_default_core_config(const char *var, const char *value)
 		if (level == -1)
 			level = Z_DEFAULT_COMPRESSION;
 		else if (level < 0 || level > Z_BEST_COMPRESSION)
-			die("bad zlib compression level %d", level);
+			die(_("bad zlib compression level %d"), level);
 		zlib_compression_level = level;
 		zlib_compression_seen = 1;
 		return 0;
@@ -751,7 +751,7 @@ static int git_default_core_config(const char *var, const char *value)
 		if (level == -1)
 			level = Z_DEFAULT_COMPRESSION;
 		else if (level < 0 || level > Z_BEST_COMPRESSION)
-			die("bad zlib compression level %d", level);
+			die(_("bad zlib compression level %d"), level);
 		core_compression_level = level;
 		core_compression_seen = 1;
 		if (!zlib_compression_seen)
@@ -873,7 +873,7 @@ static int git_default_core_config(const char *var, const char *value)
 		else if (!strcmp(value, "link"))
 			object_creation_mode = OBJECT_CREATION_USES_HARDLINKS;
 		else
-			die("Invalid mode for object creation: %s", value);
+			die(_("Invalid mode for object creation: %s"), value);
 		return 0;
 	}
 
@@ -1173,7 +1173,7 @@ int git_config_early(config_fn_t fn, void *data, const char *repo_config)
 
 	switch (git_config_from_parameters(fn, data)) {
 	case -1: /* error */
-		die("unable to parse command-line config");
+		die(_("unable to parse command-line config"));
 		break;
 	case 0: /* found nothing */
 		break;
@@ -1514,7 +1514,7 @@ static int store_aux(const char *key, const char *value, void *cb)
 	case KEY_SEEN:
 		if (matches(key, value)) {
 			if (store.seen == 1 && store.multi_replace == 0) {
-				warning("%s has multiple values", key);
+				warning(_("%s has multiple values"), key);
 			}
 
 			ALLOC_GROW(store.offset, store.seen + 1,
-- 
2.0.2.737.gfb43bde
