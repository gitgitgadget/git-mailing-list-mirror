Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B95D3C32771
	for <git@archiver.kernel.org>; Mon, 26 Sep 2022 18:48:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230313AbiIZSsS (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 26 Sep 2022 14:48:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230108AbiIZSsN (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Sep 2022 14:48:13 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69D6885FAE
        for <git@vger.kernel.org>; Mon, 26 Sep 2022 11:48:12 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id ay36so5168829wmb.0
        for <git@vger.kernel.org>; Mon, 26 Sep 2022 11:48:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date;
        bh=gyEFp1wpGUPKtu8GOqPCM0jE9U/VthLkFkEkyL2do9g=;
        b=hAmVppwhVg5zfzEzlwaVITo6R4vcrvzMLAZUs4tcLPRYNvIOUCsRBSuL3Gg0gflrud
         6lJVdCUbiDAq3d0qnAZw0XBOBpo5meGTCWLCFG+kZkT+WryJRwC8StGi6nqCMIMO2LZt
         K+2XiWTdKkQXRnrphs7Xvpe+QJ3HwDoJRtv3fOdIVF7a+15ei52rlR4DIWnNmFYkmALI
         llob9KOJpuck5sBw1PPA+Ik1qMHTym/0o8a/v1FBJncFlvurvgLAeeo4BHtp0MWbtbIA
         9zBzvb7oDS1H/6BAVAtA4WuO+9No5sItmmk79g6/zuwye41jCWc9aUcaK7/7VhDKCeYV
         IqJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date;
        bh=gyEFp1wpGUPKtu8GOqPCM0jE9U/VthLkFkEkyL2do9g=;
        b=QoBQF8lWJJAr26BdIQGvP2RsSFks34rdQPJI72wyPFCHEt/zBwDtA57E7PcvfMMb9Q
         Dv70kNNLYukzGXTKptLlsKKgitq+dSAai398TL1VautC/UL5AMy/tue80uoXsjpNzrTG
         dEQ31kUi0P4Gf01wUgykMnhaRq/8xR8N2XJQzriQD17pupXb5nogFUL7VDcSDWqgguTS
         d0l5joK61yd3kzijiwNyB/4AU40PCcEy/8QkgnvsWceBnZoU59NJ0TdsZNwtZccsdAag
         q6rVkmA9xy7TDDIGywh6w2Xof/CVJaOozQU97lDvzu1of/mLMGYHp7Sd52WIu7JjxeIg
         39SA==
X-Gm-Message-State: ACrzQf1RQY2pzt0BLopoysSQsEJvxiCJeSbO+vYtE4tBkspdKW+HfJdh
        cDdCqg1Str8OQMsGHsDTlQCNBLU9XO4=
X-Google-Smtp-Source: AMsMyM7vcc8OO+6YxOJ6xyiwJtUubc1w/CsaGdM4ExE5DhUwjyS4X97qhvaVc9TuYuUhU/5lz4Ddzw==
X-Received: by 2002:a05:600c:3d17:b0:3b4:adc7:976c with SMTP id bh23-20020a05600c3d1700b003b4adc7976cmr92595wmb.108.1664218090729;
        Mon, 26 Sep 2022 11:48:10 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id s6-20020adfdb06000000b0022ae4f8395dsm14925674wri.96.2022.09.26.11.48.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Sep 2022 11:48:10 -0700 (PDT)
Message-Id: <260d7bee36e1af2f6a6a8791d293402e97a502e6.1664218087.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1358.v3.git.1664218087.gitgitgadget@gmail.com>
References: <pull.1358.v2.git.1663853837.gitgitgadget@gmail.com>
        <pull.1358.v3.git.1664218087.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 26 Sep 2022 18:48:06 +0000
Subject: [PATCH v3 3/3] gc: replace config subprocesses with API calls
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, vdye@github.com,
        SZEDER =?UTF-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <derrickstolee@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <derrickstolee@github.com>

The 'git maintenance [un]register' commands set or unset the multi-
valued maintenance.repo config key with the absolute path of the current
repository. These are set in the global config file.

Instead of calling a subcommand and creating a new process, create the
proper API calls to git_config_set_multivar_in_file_gently(). It
requires loading the filename for the global config file (and erroring
out if now $HOME value is set). We also need to be careful about using
CONFIG_REGEX_NONE when adding the value and using
CONFIG_FLAGS_FIXED_VALUE when removing the value. In both cases, we
check that the value already exists (this check already existed for
'unregister').

Also, remove the transparent translation of the error code from the
config API to the exit code of 'git maintenance'. Instead, use die() to
recover from failures at that level. In the case of 'unregister
--force', allow the CONFIG_NOTHING_SET error code to be a success. This
allows a possible race where another process removes the config value.
The end result is that the config value is not set anymore, so we can
treat this as a success.

Reported-by: SZEDER Gábor <szeder.dev@gmail.com>
Signed-off-by: Derrick Stolee <derrickstolee@github.com>
---
 builtin/gc.c | 75 ++++++++++++++++++++++++++++++----------------------
 1 file changed, 44 insertions(+), 31 deletions(-)

diff --git a/builtin/gc.c b/builtin/gc.c
index 8d154586272..4c59235950d 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -1470,11 +1470,12 @@ static int maintenance_register(int argc, const char **argv, const char *prefix)
 	struct option options[] = {
 		OPT_END(),
 	};
-	int rc;
+	int found = 0;
+	const char *key = "maintenance.repo";
 	char *config_value;
-	struct child_process config_set = CHILD_PROCESS_INIT;
-	struct child_process config_get = CHILD_PROCESS_INIT;
 	char *maintpath = get_maintpath();
+	struct string_list_item *item;
+	const struct string_list *list;
 
 	argc = parse_options(argc, argv, prefix, options,
 			     builtin_maintenance_register_usage, 0);
@@ -1491,31 +1492,35 @@ static int maintenance_register(int argc, const char **argv, const char *prefix)
 	else
 		git_config_set("maintenance.strategy", "incremental");
 
-	config_get.git_cmd = 1;
-	strvec_pushl(&config_get.args, "config", "--global", "--get",
-		     "--fixed-value", "maintenance.repo", maintpath, NULL);
-	config_get.out = -1;
-
-	if (start_command(&config_get)) {
-		rc = error(_("failed to run 'git config'"));
-		goto done;
+	list = git_config_get_value_multi(key);
+	if (list) {
+		for_each_string_list_item(item, list) {
+			if (!strcmp(maintpath, item->string)) {
+				found = 1;
+				break;
+			}
+		}
 	}
 
-	/* We already have this value in our config! */
-	if (!finish_command(&config_get)) {
-		rc = 0;
-		goto done;
+	if (!found) {
+		int rc;
+		char *user_config, *xdg_config;
+		git_global_config(&user_config, &xdg_config);
+		if (!user_config)
+			die(_("$HOME not set"));
+		rc = git_config_set_multivar_in_file_gently(
+			user_config, "maintenance.repo", maintpath,
+			CONFIG_REGEX_NONE, 0);
+		free(user_config);
+		free(xdg_config);
+
+		if (rc)
+			die(_("unable to add '%s' value of '%s'"),
+			    key, maintpath);
 	}
 
-	config_set.git_cmd = 1;
-	strvec_pushl(&config_set.args, "config", "--add", "--global", "maintenance.repo",
-		     maintpath, NULL);
-
-	rc = run_command(&config_set);
-
-done:
 	free(maintpath);
-	return rc;
+	return 0;
 }
 
 static char const * const builtin_maintenance_unregister_usage[] = {
@@ -1533,8 +1538,6 @@ static int maintenance_unregister(int argc, const char **argv, const char *prefi
 		OPT_END(),
 	};
 	const char *key = "maintenance.repo";
-	int rc = 0;
-	struct child_process config_unset = CHILD_PROCESS_INIT;
 	char *maintpath = get_maintpath();
 	int found = 0;
 	struct string_list_item *item;
@@ -1554,17 +1557,27 @@ static int maintenance_unregister(int argc, const char **argv, const char *prefi
 	}
 
 	if (found) {
-		config_unset.git_cmd = 1;
-		strvec_pushl(&config_unset.args, "config", "--global", "--unset",
-			     "--fixed-value", key, maintpath, NULL);
-
-		rc = run_command(&config_unset);
+		int rc;
+		char *user_config, *xdg_config;
+		git_global_config(&user_config, &xdg_config);
+		if (!user_config)
+			die(_("$HOME not set"));
+		rc = git_config_set_multivar_in_file_gently(
+			user_config, key, NULL, maintpath,
+			CONFIG_FLAGS_MULTI_REPLACE | CONFIG_FLAGS_FIXED_VALUE);
+		free(user_config);
+		free(xdg_config);
+
+		if (rc &&
+		    (!force || rc == CONFIG_NOTHING_SET))
+			die(_("unable to unset '%s' value of '%s'"),
+			    key, maintpath);
 	} else if (!force) {
 		die(_("repository '%s' is not registered"), maintpath);
 	}
 
 	free(maintpath);
-	return rc;
+	return 0;
 }
 
 static const char *get_frequency(enum schedule_priority schedule)
-- 
gitgitgadget
