From: Alangi Derick <alangiderick@gmail.com>
Subject: [PATCH] Fixed a translation error
Date: Mon, 4 May 2015 12:16:04 +0100
Message-ID: <554766e9.b30db50a.72e3.ffff8bbe@mx.google.com>
To: unlisted-recipients:; (no To-header on input)
X-From: git-owner@vger.kernel.org Mon May 04 14:32:48 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YpFYG-0000ut-1R
	for gcvg-git-2@plane.gmane.org; Mon, 04 May 2015 14:32:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752392AbbEDMco (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 May 2015 08:32:44 -0400
Received: from mail-wg0-f52.google.com ([74.125.82.52]:35607 "EHLO
	mail-wg0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752029AbbEDMcn (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 May 2015 08:32:43 -0400
Received: by wgyo15 with SMTP id o15so148490102wgy.2
        for <git@vger.kernel.org>; Mon, 04 May 2015 05:32:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:from:date:subject;
        bh=x0++o3Bomy+IubJdeu5JgQyJeMnpNYTuc8M0rVF2UUU=;
        b=drZjuUe6Pt/lpHImwMy6zpUK+LgEt8C/9sTksWyZf2VyQDvHxppYyi7oeAAvFuhxUe
         s4nYZZzgFrUQgeBAc8v/o7tG2pBR9sMMr5F5/DdazIqKZU4kGE4Is00T7vxPexKRFZm4
         n/srjYSVIaDvrjkrXRBEudQxJFGZYyWZ9WAhsfmdL+ZZBRhzCvXq6X/ZxF0OJBlwRVQD
         i8tsw7E2lQS/3/DnXuz4J+1HK0wL/2KKgiSLynKeKub6dOy/EUdeDgfHRqp2MtY4eSRp
         Xphuyhk8MJzjRgIMi//p7ap5pF7We1HaPwTRqwYqE+QzUOrV7yLRovts50Y6ZtwbrZ2w
         uiGA==
X-Received: by 10.194.57.11 with SMTP id e11mr39393983wjq.19.1430742761639;
        Mon, 04 May 2015 05:32:41 -0700 (PDT)
Received: from localhost ([195.24.220.134])
        by mx.google.com with ESMTPSA id ez19sm11005104wid.19.2015.05.04.05.32.40
        for <git@vger.kernel.org>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 04 May 2015 05:32:41 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268314>

Signed-off-by: Alangi Derick <alangiderick@gmail.com>
---
 builtin/config.c | 34 +++++++++++++++++-----------------
 1 file changed, 17 insertions(+), 17 deletions(-)

diff --git a/builtin/config.c b/builtin/config.c
index d32c532..2b6bf0a 100644
--- a/builtin/config.c
+++ b/builtin/config.c
@@ -85,7 +85,7 @@ static struct option builtin_config_options[] = {
 static void check_argc(int argc, int min, int max) {
 	if (argc >= min && argc <= max)
 		return;
-	error("wrong number of arguments");
+	error(_("wrong number of arguments"));
 	usage_with_options(builtin_config_usage, builtin_config_options);
 }
 
@@ -366,10 +366,10 @@ static int get_colorbool(const char *var, int print)
 static void check_write(void)
 {
 	if (given_config_source.use_stdin)
-		die("writing to stdin is not supported");
+		die(_("writing to stdin is not supported"));
 
 	if (given_config_source.blob)
-		die("writing config blobs is not supported");
+		die(_("writing config blobs is not supported"));
 }
 
 struct urlmatch_current_candidate_value {
@@ -412,7 +412,7 @@ static int get_urlmatch(const char *var, const char *url)
 	config.cb = &values;
 
 	if (!url_normalize(url, &config.url))
-		die("%s", config.url.err);
+		die(_("%s"), config.url.err);
 
 	config.section = xstrdup_tolower(var);
 	section_tail = strchr(config.section, '.');
@@ -477,7 +477,7 @@ int cmd_config(int argc, const char **argv, const char *prefix)
 
 	if (use_global_config + use_system_config + use_local_config +
 	    !!given_config_source.file + !!given_config_source.blob > 1) {
-		error("only one config file at a time.");
+		error(_("only one config file at a time."));
 		usage_with_options(builtin_config_usage, builtin_config_options);
 	}
 
@@ -500,7 +500,7 @@ int cmd_config(int argc, const char **argv, const char *prefix)
 			 * location; error out even if XDG_CONFIG_HOME
 			 * is set and points at a sane location.
 			 */
-			die("$HOME not set");
+			die(_("$HOME not set"));
 
 		if (access_or_warn(user_config, R_OK, 0) &&
 		    xdg_config && !access_or_warn(xdg_config, R_OK, 0))
@@ -530,17 +530,17 @@ int cmd_config(int argc, const char **argv, const char *prefix)
 	}
 
 	if (HAS_MULTI_BITS(types)) {
-		error("only one type at a time.");
+		error(_("only one type at a time."));
 		usage_with_options(builtin_config_usage, builtin_config_options);
 	}
 
 	if ((actions & (ACTION_GET_COLOR|ACTION_GET_COLORBOOL)) && types) {
-		error("--get-color and variable type are incoherent");
+		error(_("--get-color and variable type are incoherent"));
 		usage_with_options(builtin_config_usage, builtin_config_options);
 	}
 
 	if (HAS_MULTI_BITS(actions)) {
-		error("only one action at a time.");
+		error(_("only one action at a time."));
 		usage_with_options(builtin_config_usage, builtin_config_options);
 	}
 	if (actions == 0)
@@ -561,7 +561,7 @@ int cmd_config(int argc, const char **argv, const char *prefix)
 				die_errno("unable to read config file '%s'",
 					  given_config_source.file);
 			else
-				die("error processing config file(s)");
+				die(_("error processing config file(s)"));
 		}
 	}
 	else if (actions == ACTION_EDIT) {
@@ -569,11 +569,11 @@ int cmd_config(int argc, const char **argv, const char *prefix)
 
 		check_argc(argc, 0, 0);
 		if (!given_config_source.file && nongit)
-			die("not in a git directory");
+			die(_("not in a git directory"));
 		if (given_config_source.use_stdin)
-			die("editing stdin is not supported");
+			die(_("editing stdin is not supported"));
 		if (given_config_source.blob)
-			die("editing blobs is not supported");
+			die(_("editing blobs is not supported"));
 		git_config(git_default_config, NULL);
 		config_file = xstrdup(given_config_source.file ?
 				      given_config_source.file : git_path("config"));
@@ -598,8 +598,8 @@ int cmd_config(int argc, const char **argv, const char *prefix)
 		value = normalize_value(argv[0], argv[1]);
 		ret = git_config_set_in_file(given_config_source.file, argv[0], value);
 		if (ret == CONFIG_NOTHING_SET)
-			error("cannot overwrite multiple values with a single value\n"
-			"       Use a regexp, --add or --replace-all to change %s.", argv[0]);
+			error(_("cannot overwrite multiple values with a single value\n"
+			"       Use a regexp, --add or --replace-all to change %s."), argv[0]);
 		return ret;
 	}
 	else if (actions == ACTION_SET_ALL) {
@@ -669,7 +669,7 @@ int cmd_config(int argc, const char **argv, const char *prefix)
 		if (ret < 0)
 			return ret;
 		if (ret == 0)
-			die("No such section!");
+			die(_("No such section!"));
 	}
 	else if (actions == ACTION_REMOVE_SECTION) {
 		int ret;
@@ -680,7 +680,7 @@ int cmd_config(int argc, const char **argv, const char *prefix)
 		if (ret < 0)
 			return ret;
 		if (ret == 0)
-			die("No such section!");
+			die(_("No such section!"));
 	}
 	else if (actions == ACTION_GET_COLOR) {
 		check_argc(argc, 1, 2);
-- 
2.4.0.5.g7a7787e.dirty
