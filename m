Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1384C1F597
	for <e@80x24.org>; Wed, 18 Jul 2018 16:12:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731826AbeGRQvX (ORCPT <rfc822;e@80x24.org>);
        Wed, 18 Jul 2018 12:51:23 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:36524 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731587AbeGRQvW (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Jul 2018 12:51:22 -0400
Received: by mail-lj1-f193.google.com with SMTP id u7-v6so4595573lji.3
        for <git@vger.kernel.org>; Wed, 18 Jul 2018 09:12:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QU2RecFsWUJAEQfflzsd+XplUPJnjFvU+Xo3tDC0Jr0=;
        b=GptTrpG8Fj+MEPPAwGMdoFW2fk0KWOajLXG59IAjogPniycAuoEhe8CKGnsQrOTSGl
         4TMOzUCgkiW6Mx9l3+Rvwux9XarNUzzn9KAGcGF0KEFBSzpC2kWCtILWIcRey5Us67Zw
         JFSVNnMQuWj5ygxoFLmTd6yvWvOl2d4pYsvsxNxqfx+ktaHrpo8vGuQs7z6X22U1tl9a
         mTUDavE3Sj8VIV27NAIZpKtoNwg+LodTe7JI8oYZ3v32McLxLnZBb8Ba3s50lv/u0xF7
         KVrTadUxb6KiP9SKnjBox29ZNn+rI3k54tB0TWNyh+lI9qkB9MEU8ZIyNBOffBmkil8c
         aKVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QU2RecFsWUJAEQfflzsd+XplUPJnjFvU+Xo3tDC0Jr0=;
        b=nvR/3lLk/dGDJvCjDvrGOVhkOXK1J1y+YB3mMC73pPtTZwG9EPRl+JSWr4tEhK1c6z
         BqjRirIhlpd1D8ges4G4QiONVF1FyLRSko9G6CqZzdf4CIj487TwjYRI2iUUPq81PKAu
         W1jG5VZ7MLLA4K0X8Okfh7h4DCgJhazPfSvn7OojO44ENFYOH2T1HVkjxLfwub4121C3
         OQRGeOhDuqwYy0R6RuesIJ29TFmITDu9YRGZ7wAe+0G5GaLIstBT4JJ+JIW/kzIcN2/M
         ZOKErK3lK8GKXr6RNH1uHa6bSy01Ivu7r43ViJuX7Cy9JJn64Gw6a46OjLcI44ghYz7E
         oQkw==
X-Gm-Message-State: AOUpUlHjimwsdd+GNq5WXBZgRAKtJc8nS/9CzL5m2xzwcD0nl/7NgbCW
        tO+tZm9pt+JunQoKLHHBMjVvcg==
X-Google-Smtp-Source: AAOMgpe4eNagX7dXyzETnYOHRCeLdASful3ZnsF4tNcOhg29BA/UnnP9sApqhf7dHHkul2zK7t5zsQ==
X-Received: by 2002:a2e:4401:: with SMTP id r1-v6mr5329891lja.21.1531930363772;
        Wed, 18 Jul 2018 09:12:43 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id j26-v6sm689203ljc.54.2018.07.18.09.12.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 18 Jul 2018 09:12:42 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH v2 04/23] builtin/config.c: mark more strings for translation
Date:   Wed, 18 Jul 2018 18:10:42 +0200
Message-Id: <20180718161101.19765-5-pclouds@gmail.com>
X-Mailer: git-send-email 2.18.0.rc2.476.g39500d3211
In-Reply-To: <20180718161101.19765-1-pclouds@gmail.com>
References: <20180718161101.19765-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 builtin/config.c      | 48 +++++++++++++++++++++----------------------
 t/t1308-config-set.sh |  2 +-
 2 files changed, 25 insertions(+), 25 deletions(-)

diff --git a/builtin/config.c b/builtin/config.c
index abb3195fa9..3c26df6c48 100644
--- a/builtin/config.c
+++ b/builtin/config.c
@@ -110,7 +110,7 @@ static int option_parse_type(const struct option *opt, const char *arg,
 		 * --int' and '--type=bool
 		 * --type=int'.
 		 */
-		error("only one type at a time");
+		error(_("only one type at a time"));
 		usage_with_options(builtin_config_usage,
 			builtin_config_options);
 	}
@@ -161,9 +161,9 @@ static void check_argc(int argc, int min, int max) {
 	if (argc >= min && argc <= max)
 		return;
 	if (min == max)
-		error("wrong number of arguments, should be %d", min);
+		error(_("wrong number of arguments, should be %d"), min);
 	else
-		error("wrong number of arguments, should be from %d to %d",
+		error(_("wrong number of arguments, should be from %d to %d"),
 		      min, max);
 	usage_with_options(builtin_config_usage, builtin_config_options);
 }
@@ -297,7 +297,7 @@ static int get_value(const char *key_, const char *regex_)
 
 		key_regexp = (regex_t*)xmalloc(sizeof(regex_t));
 		if (regcomp(key_regexp, key, REG_EXTENDED)) {
-			error("invalid key pattern: %s", key_);
+			error(_("invalid key pattern: %s"), key_);
 			FREE_AND_NULL(key_regexp);
 			ret = CONFIG_INVALID_PATTERN;
 			goto free_strings;
@@ -317,7 +317,7 @@ static int get_value(const char *key_, const char *regex_)
 
 		regexp = (regex_t*)xmalloc(sizeof(regex_t));
 		if (regcomp(regexp, regex_, REG_EXTENDED)) {
-			error("invalid pattern: %s", regex_);
+			error(_("invalid pattern: %s"), regex_);
 			FREE_AND_NULL(regexp);
 			ret = CONFIG_INVALID_PATTERN;
 			goto free_strings;
@@ -390,7 +390,7 @@ static char *normalize_value(const char *key, const char *value)
 	if (type == TYPE_COLOR) {
 		char v[COLOR_MAXLEN];
 		if (git_config_color(v, key, value))
-			die("cannot parse color '%s'", value);
+			die(_("cannot parse color '%s'"), value);
 
 		/*
 		 * The contents of `v` now contain an ANSI escape
@@ -485,13 +485,13 @@ static int get_colorbool(const char *var, int print)
 static void check_write(void)
 {
 	if (!given_config_source.file && !startup_info->have_repository)
-		die("not in a git directory");
+		die(_("not in a git directory"));
 
 	if (given_config_source.use_stdin)
-		die("writing to stdin is not supported");
+		die(_("writing to stdin is not supported"));
 
 	if (given_config_source.blob)
-		die("writing config blobs is not supported");
+		die(_("writing config blobs is not supported"));
 }
 
 struct urlmatch_current_candidate_value {
@@ -599,7 +599,7 @@ int cmd_config(int argc, const char **argv, const char *prefix)
 
 	if (use_global_config + use_system_config + use_local_config +
 	    !!given_config_source.file + !!given_config_source.blob > 1) {
-		error("only one config file at a time");
+		error(_("only one config file at a time"));
 		usage_with_options(builtin_config_usage, builtin_config_options);
 	}
 
@@ -626,7 +626,7 @@ int cmd_config(int argc, const char **argv, const char *prefix)
 			 * location; error out even if XDG_CONFIG_HOME
 			 * is set and points at a sane location.
 			 */
-			die("$HOME is not set");
+			die(_("$HOME is not set"));
 
 		if (access_or_warn(user_config, R_OK, 0) &&
 		    xdg_config && !access_or_warn(xdg_config, R_OK, 0)) {
@@ -663,12 +663,12 @@ int cmd_config(int argc, const char **argv, const char *prefix)
 	}
 
 	if ((actions & (ACTION_GET_COLOR|ACTION_GET_COLORBOOL)) && type) {
-		error("--get-color and variable type are incoherent");
+		error(_("--get-color and variable type are incoherent"));
 		usage_with_options(builtin_config_usage, builtin_config_options);
 	}
 
 	if (HAS_MULTI_BITS(actions)) {
-		error("only one action at a time");
+		error(_("only one action at a time"));
 		usage_with_options(builtin_config_usage, builtin_config_options);
 	}
 	if (actions == 0)
@@ -681,19 +681,19 @@ int cmd_config(int argc, const char **argv, const char *prefix)
 		}
 	if (omit_values &&
 	    !(actions == ACTION_LIST || actions == ACTION_GET_REGEXP)) {
-		error("--name-only is only applicable to --list or --get-regexp");
+		error(_("--name-only is only applicable to --list or --get-regexp"));
 		usage_with_options(builtin_config_usage, builtin_config_options);
 	}
 
 	if (show_origin && !(actions &
 		(ACTION_GET|ACTION_GET_ALL|ACTION_GET_REGEXP|ACTION_LIST))) {
-		error("--show-origin is only applicable to --get, --get-all, "
-		      "--get-regexp, and --list");
+		error(_("--show-origin is only applicable to --get, --get-all, "
+			"--get-regexp, and --list"));
 		usage_with_options(builtin_config_usage, builtin_config_options);
 	}
 
 	if (default_value && !(actions & ACTION_GET)) {
-		error("--default is only applicable to --get");
+		error(_("--default is only applicable to --get"));
 		usage_with_options(builtin_config_usage,
 			builtin_config_options);
 	}
@@ -707,10 +707,10 @@ int cmd_config(int argc, const char **argv, const char *prefix)
 					&given_config_source,
 					&config_options) < 0) {
 			if (given_config_source.file)
-				die_errno("unable to read config file '%s'",
+				die_errno(_("unable to read config file '%s'"),
 					  given_config_source.file);
 			else
-				die("error processing config file(s)");
+				die(_("error processing config file(s)"));
 		}
 	}
 	else if (actions == ACTION_EDIT) {
@@ -718,11 +718,11 @@ int cmd_config(int argc, const char **argv, const char *prefix)
 
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
 		config_file = given_config_source.file ?
 				xstrdup(given_config_source.file) :
@@ -823,7 +823,7 @@ int cmd_config(int argc, const char **argv, const char *prefix)
 		if (ret < 0)
 			return ret;
 		if (ret == 0)
-			die("no such section: %s", argv[0]);
+			die(_("no such section: %s"), argv[0]);
 	}
 	else if (actions == ACTION_REMOVE_SECTION) {
 		int ret;
@@ -834,7 +834,7 @@ int cmd_config(int argc, const char **argv, const char *prefix)
 		if (ret < 0)
 			return ret;
 		if (ret == 0)
-			die("no such section: %s", argv[0]);
+			die(_("no such section: %s"), argv[0]);
 	}
 	else if (actions == ACTION_GET_COLOR) {
 		check_argc(argc, 1, 2);
diff --git a/t/t1308-config-set.sh b/t/t1308-config-set.sh
index 3e00d1af01..d0a2727b85 100755
--- a/t/t1308-config-set.sh
+++ b/t/t1308-config-set.sh
@@ -233,7 +233,7 @@ test_expect_success 'check line errors for malformed values' '
 
 test_expect_success 'error on modifying repo config without repo' '
 	nongit test_must_fail git config a.b c 2>err &&
-	grep "not in a git directory" err
+	test_i18ngrep "not in a git directory" err
 '
 
 cmdline_config="'foo.bar=from-cmdline'"
-- 
2.18.0.rc2.476.g39500d3211

