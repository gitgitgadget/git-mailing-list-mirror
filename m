From: Tanay Abhra <tanayabh@gmail.com>
Subject: [PATCH v2 1/2] config.c: mark error and warnings strings for translation
Date: Thu, 31 Jul 2014 06:42:05 -0700
Message-ID: <1406814126-10457-1-git-send-email-tanayabh@gmail.com>
Cc: Matthieu Moy <Matthieu.Moy@imag.fr>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 31 15:44:37 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XCqer-0005Ml-Cm
	for gcvg-git-2@plane.gmane.org; Thu, 31 Jul 2014 15:44:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751362AbaGaNo2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 Jul 2014 09:44:28 -0400
Received: from mail-pd0-f173.google.com ([209.85.192.173]:49795 "EHLO
	mail-pd0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750859AbaGaNo1 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 Jul 2014 09:44:27 -0400
Received: by mail-pd0-f173.google.com with SMTP id w10so3497878pde.18
        for <git@vger.kernel.org>; Thu, 31 Jul 2014 06:44:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=yMvSWej5Wf1NUeOhD5PE8UFBRM1PEPR/N0W6M5i7imY=;
        b=oVwwjIYo/xqKmE+pGx2Lia6pSefTJJQNwAUICfIfYFojsUZKEpXEifcwYBA6ANS0oH
         nk2UkO/Iuuw+jlPNKN8foMKQo3ryBvNAp83vnoCPmuqUBdwzEkZLbCf6nY0wYwebilB9
         68hVUxDrdTcnkGRq7MyTJcPVs8lLoywHe1L02k0WluzyLIRW3zvNLZtXA9e6xksecIsd
         MMDl8/gw8u+2ucsbx+lUvSiasd/SxwS6xtPSSP6PHvCtioJX0pdy2uKGN4rj/9J9D/cQ
         D6h0E8W0ot2SOkEu2PxFpR1JqQabRgutOWjZEk51Bwy2brKv7qE+UKbPxGkOjR7SOveT
         71Cg==
X-Received: by 10.68.200.101 with SMTP id jr5mr4444638pbc.36.1406814267048;
        Thu, 31 Jul 2014 06:44:27 -0700 (PDT)
Received: from localhost.localdomain ([223.229.21.143])
        by mx.google.com with ESMTPSA id i10sm19346556pat.36.2014.07.31.06.44.24
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 31 Jul 2014 06:44:26 -0700 (PDT)
X-Mailer: git-send-email 1.9.0.GIT
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254574>

From: Matthieu Moy <Matthieu.Moy@imag.fr>

Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
---
v2: error messages now start with a small letter.

 config.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/config.c b/config.c
index 058505c..7330789 100644
--- a/config.c
+++ b/config.c
@@ -442,9 +442,9 @@ static int git_parse_source(config_fn_t fn, void *data)
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
@@ -560,9 +560,9 @@ static void die_bad_number(const char *name, const char *value)
 		value = "";
 
 	if (cf && cf->name)
-		die("bad numeric config value '%s' for '%s' in %s: %s",
+		die(_("bad numeric config value '%s' for '%s' in %s: %s"),
 		    value, name, cf->name, reason);
-	die("bad numeric config value '%s' for '%s': %s", value, name, reason);
+	die(_("bad numeric config value '%s' for '%s': %s"), value, name, reason);
 }
 
 int git_config_int(const char *name, const char *value)
@@ -647,7 +647,7 @@ int git_config_pathname(const char **dest, const char *var, const char *value)
 		return config_error_nonbool(var);
 	*dest = expand_user_path(value);
 	if (!*dest)
-		die("Failed to expand user dir in: '%s'", value);
+		die(_("failed to expand user dir in: '%s'"), value);
 	return 0;
 }
 
@@ -725,7 +725,7 @@ static int git_default_core_config(const char *var, const char *value)
 		if (level == -1)
 			level = Z_DEFAULT_COMPRESSION;
 		else if (level < 0 || level > Z_BEST_COMPRESSION)
-			die("bad zlib compression level %d", level);
+			die(_("bad zlib compression level %d"), level);
 		zlib_compression_level = level;
 		zlib_compression_seen = 1;
 		return 0;
@@ -736,7 +736,7 @@ static int git_default_core_config(const char *var, const char *value)
 		if (level == -1)
 			level = Z_DEFAULT_COMPRESSION;
 		else if (level < 0 || level > Z_BEST_COMPRESSION)
-			die("bad zlib compression level %d", level);
+			die(_("bad zlib compression level %d"), level);
 		core_compression_level = level;
 		core_compression_seen = 1;
 		if (!zlib_compression_seen)
@@ -858,7 +858,7 @@ static int git_default_core_config(const char *var, const char *value)
 		else if (!strcmp(value, "link"))
 			object_creation_mode = OBJECT_CREATION_USES_HARDLINKS;
 		else
-			die("Invalid mode for object creation: %s", value);
+			die(_("invalid mode for object creation: %s"), value);
 		return 0;
 	}
 
@@ -1158,7 +1158,7 @@ int git_config_early(config_fn_t fn, void *data, const char *repo_config)
 
 	switch (git_config_from_parameters(fn, data)) {
 	case -1: /* error */
-		die("unable to parse command-line config");
+		die(_("unable to parse command-line config"));
 		break;
 	case 0: /* found nothing */
 		break;
@@ -1243,7 +1243,7 @@ static int store_aux(const char *key, const char *value, void *cb)
 	case KEY_SEEN:
 		if (matches(key, value)) {
 			if (store.seen == 1 && store.multi_replace == 0) {
-				warning("%s has multiple values", key);
+				warning(_("%s has multiple values"), key);
 			}
 
 			ALLOC_GROW(store.offset, store.seen + 1,
-- 
1.9.0.GIT
