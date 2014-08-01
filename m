From: Tanay Abhra <tanayabh@gmail.com>
Subject: [PATCH v7 1/8] config.c: mark error and warnings strings for translation
Date: Fri,  1 Aug 2014 10:05:49 -0700
Message-ID: <1406912756-15517-2-git-send-email-tanayabh@gmail.com>
References: <1406912756-15517-1-git-send-email-tanayabh@gmail.com>
Cc: Matthieu Moy <Matthieu.Moy@imag.fr>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 01 19:06:52 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XDGI6-0001fR-KC
	for gcvg-git-2@plane.gmane.org; Fri, 01 Aug 2014 19:06:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754966AbaHARGo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 Aug 2014 13:06:44 -0400
Received: from mail-pd0-f181.google.com ([209.85.192.181]:59472 "EHLO
	mail-pd0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751694AbaHARGn (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Aug 2014 13:06:43 -0400
Received: by mail-pd0-f181.google.com with SMTP id g10so5817756pdj.26
        for <git@vger.kernel.org>; Fri, 01 Aug 2014 10:06:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=kpBW6H38eD7q6+ioL13qmm6oEXAg5fQOUm42MCQnMc4=;
        b=aAmmKKj5Ik5dw6iRHlTksfNAyxBnna2hQ52QZBN2JhNu9piJL5vOQAR18eS4U3NpWB
         9fZ6ixoQUkI3LFaFKUhSLWZv0GPZMSl9U4Mzqp+0k43JaXhNViTLejWZjNUNkdxp8nG2
         qJOqicBNclTX69mDX4da24yN/0bT8y50AoLFiCKEkugTwacY6LXk5LNduw/8RsBNQVrz
         QHIKNNq31by1Cg8B4zthi+FjdB37NgctOik1lJa+UJ8elO3TKkdEXJzSt4rylKnrB/eb
         aGkTxYNI3hmkMzpaw5X9lACaL81ZXYwpaINVZ770vw9KE/JsJVlvNY6fAIDW5GSEJfUd
         OWrw==
X-Received: by 10.66.163.65 with SMTP id yg1mr7815422pab.33.1406912803301;
        Fri, 01 Aug 2014 10:06:43 -0700 (PDT)
Received: from localhost.localdomain ([110.225.111.156])
        by mx.google.com with ESMTPSA id pz10sm9241121pbb.33.2014.08.01.10.06.39
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 01 Aug 2014 10:06:42 -0700 (PDT)
X-Mailer: git-send-email 1.9.0.GIT
In-Reply-To: <1406912756-15517-1-git-send-email-tanayabh@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254634>

From: Matthieu Moy <Matthieu.Moy@imag.fr>

Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
---
 config.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/config.c b/config.c
index a191328..34940fd 100644
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
+		die(_("failed to expand user dir in: '%s'"), value);
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
+			die(_("invalid mode for object creation: %s"), value);
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
1.9.0.GIT
