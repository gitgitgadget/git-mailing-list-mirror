From: Tanay Abhra <tanayabh@gmail.com>
Subject: [PATCH v9 1/8] config.c: mark error and warnings strings for translation
Date: Thu,  7 Aug 2014 04:59:12 -0700
Message-ID: <1407412759-13833-2-git-send-email-tanayabh@gmail.com>
References: <1407412759-13833-1-git-send-email-tanayabh@gmail.com>
Cc: Matthieu Moy <Matthieu.Moy@imag.fr>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 07 14:00:25 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XFMMl-0004lL-7g
	for gcvg-git-2@plane.gmane.org; Thu, 07 Aug 2014 14:00:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757383AbaHGMAJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Aug 2014 08:00:09 -0400
Received: from mail-pd0-f178.google.com ([209.85.192.178]:48570 "EHLO
	mail-pd0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757235AbaHGMAH (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Aug 2014 08:00:07 -0400
Received: by mail-pd0-f178.google.com with SMTP id w10so5053940pde.23
        for <git@vger.kernel.org>; Thu, 07 Aug 2014 05:00:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=kpBW6H38eD7q6+ioL13qmm6oEXAg5fQOUm42MCQnMc4=;
        b=rBoToFr6Orkrlgz50dGztWVsp3RwXqavY4nPFFZdnmFq3Iai18P/+F7j5vAiifn1ji
         U+M1F42Wf6HhmAnCxnFBswmhKZLgf+M4NtNTLL2jOX3hukKjiy+chgA2qS0DAB+WHVfQ
         d9pX5uE311eiKlliyrnwGnK+V6Clbg/cu+veeCoukYmQCJADZ4559GY1cyS4KjzRz3GE
         LGAwd3iGkTF6ycxnPfD5VyhvfilbxxAZLnFLkMei7WbB/QhChzbPGS+sgRi8zfvsL/qY
         Wd5dl9SfX+wXiJuN7CYei5a+CNjrfq6pGQKsmHc73sWOEI44UYJ8C6oHQsUj9rM5S7KR
         Ngvg==
X-Received: by 10.68.229.166 with SMTP id sr6mr1643232pbc.33.1407412807442;
        Thu, 07 Aug 2014 05:00:07 -0700 (PDT)
Received: from localhost.localdomain ([223.176.226.83])
        by mx.google.com with ESMTPSA id cb8sm13997212pad.8.2014.08.07.05.00.04
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 07 Aug 2014 05:00:06 -0700 (PDT)
X-Mailer: git-send-email 1.9.0.GIT
In-Reply-To: <1407412759-13833-1-git-send-email-tanayabh@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254951>

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
