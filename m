Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A76C0C07E9D
	for <git@archiver.kernel.org>; Mon, 26 Sep 2022 18:48:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230047AbiIZSsO (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 26 Sep 2022 14:48:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229946AbiIZSsM (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Sep 2022 14:48:12 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96BFA81B3C
        for <git@vger.kernel.org>; Mon, 26 Sep 2022 11:48:10 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id n15so11636425wrq.5
        for <git@vger.kernel.org>; Mon, 26 Sep 2022 11:48:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date;
        bh=jTKp4RKYn+tH2YLQGwe/N+MirQNNQQfITUxeOLh2eR8=;
        b=EV7/oJGQZpLhXvyA4hM+eOu4M3bjyd/4sRRtpBitHWUZgMJOLcPgyOMDllTrjQV3dg
         2hVQpkmLL1WZJfoQQXXPPdNqGeCxD2wGACmud+2eFCNGLCyxZgK1aB+BohlcIHYXeoE8
         g9TzC7KZ1VaVXVbCcqqlPqeYqpQjtc0OU+dzdFWi+6xJQLY6k6dPOPj4hcSEZq2DighU
         QAOPaqnu7Im1qjvvht9VAV7soalln0Uqd3yFXrVPTw1ZtJJ0XRb/xu3oJTQ1QiGtaA1/
         HxNYK3qsG8zYXJC8Gkcaa+SXq5VaQzNe6lfbErdg94v5XSaszmCitYl19z7nG0hK/Lrd
         /4KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date;
        bh=jTKp4RKYn+tH2YLQGwe/N+MirQNNQQfITUxeOLh2eR8=;
        b=6v/rCugkEMvxtLjZRen4Drs+HYAFBgwGy2dRG3ia678WwjH8nCI4gruASm37ag466c
         oaNeIrwS7xd+84Rl7uEOZD7UIgLjksib6CCTk67UaCMLDgcPVQio+Y9OOULC1Ll82e51
         hi5eM85zbLD3N2m40xSwjC+9B4kYZgTalatCCpzKD6c4FroEOdsCX4X/vxLJRmie0mLv
         Y9neaKpLUJYMpxnK5CaFRyIwtKpJRq4FQvnm01YoUBisPBHtgIbWMnPDciNVIbHKzDpd
         tqMw1jN6INpeLrn3sV1D+PZYvL7xKEXnX/BmmqpVvPwn5ykodmHib5Sxq8nTExs0N74m
         ySoA==
X-Gm-Message-State: ACrzQf0InvotyefUH+wmcOB+y/m1ey77o0yQeOI7IpnNKttGe6EsZ38R
        Pqqj/8Sw8ijIitisWkTgHWQi7bN5vWg=
X-Google-Smtp-Source: AMsMyM6WyDqliqFghpA3EGRF1h2xQeIcNtTQRUGoris1UY16i7ChQx5IuWbuSjRQbFGz98jW21ELTQ==
X-Received: by 2002:a5d:5c06:0:b0:22a:7b52:cda6 with SMTP id cc6-20020a5d5c06000000b0022a7b52cda6mr14056571wrb.485.1664218088896;
        Mon, 26 Sep 2022 11:48:08 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id e4-20020a05600c4e4400b003a682354f63sm12215217wmq.11.2022.09.26.11.48.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Sep 2022 11:48:08 -0700 (PDT)
Message-Id: <8a8bffaec89e55da0c5bcac2f04331e0d4e69790.1664218087.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1358.v3.git.1664218087.gitgitgadget@gmail.com>
References: <pull.1358.v2.git.1663853837.gitgitgadget@gmail.com>
        <pull.1358.v3.git.1664218087.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 26 Sep 2022 18:48:04 +0000
Subject: [PATCH v3 1/3] maintenance: add 'unregister --force'
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
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

The 'git maintenance unregister' subcommand has a step that removes the
current repository from the multi-valued maitenance.repo config key.
This fails if the repository is not listed in that key. This makes
running 'git maintenance unregister' twice result in a failure in the
second instance.

This failure exit code is helpful, but its message is not. Add a new
die() message that explicitly calls out the failure due to the
repository not being registered.

In some cases, users may want to run 'git maintenance unregister' just
to make sure that background jobs will not start on this repository, but
they do not want to check to see if it is registered first. Add a new
'--force' option that will siltently succeed if the repository is not
already registered.

Signed-off-by: Derrick Stolee <derrickstolee@github.com>
---
 Documentation/git-maintenance.txt |  6 +++++-
 builtin/gc.c                      | 32 +++++++++++++++++++++++++------
 t/t7900-maintenance.sh            |  6 +++++-
 3 files changed, 36 insertions(+), 8 deletions(-)

diff --git a/Documentation/git-maintenance.txt b/Documentation/git-maintenance.txt
index 9c630efe19c..bb888690e4d 100644
--- a/Documentation/git-maintenance.txt
+++ b/Documentation/git-maintenance.txt
@@ -11,7 +11,7 @@ SYNOPSIS
 [verse]
 'git maintenance' run [<options>]
 'git maintenance' start [--scheduler=<scheduler>]
-'git maintenance' (stop|register|unregister)
+'git maintenance' (stop|register|unregister) [<options>]
 
 
 DESCRIPTION
@@ -79,6 +79,10 @@ unregister::
 	Remove the current repository from background maintenance. This
 	only removes the repository from the configured list. It does not
 	stop the background maintenance processes from running.
++
+The `unregister` subcommand will report an error if the current repository
+is not already registered. Use the `--force` option to return success even
+when the current repository is not registered.
 
 TASKS
 -----
diff --git a/builtin/gc.c b/builtin/gc.c
index 2753bd15a5e..8d154586272 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -1519,18 +1519,26 @@ done:
 }
 
 static char const * const builtin_maintenance_unregister_usage[] = {
-	"git maintenance unregister",
+	"git maintenance unregister [--force]",
 	NULL
 };
 
 static int maintenance_unregister(int argc, const char **argv, const char *prefix)
 {
+	int force = 0;
 	struct option options[] = {
+		OPT__FORCE(&force,
+			   N_("return success even if repository was not registered"),
+			   PARSE_OPT_NOCOMPLETE),
 		OPT_END(),
 	};
-	int rc;
+	const char *key = "maintenance.repo";
+	int rc = 0;
 	struct child_process config_unset = CHILD_PROCESS_INIT;
 	char *maintpath = get_maintpath();
+	int found = 0;
+	struct string_list_item *item;
+	const struct string_list *list = git_config_get_value_multi(key);
 
 	argc = parse_options(argc, argv, prefix, options,
 			     builtin_maintenance_unregister_usage, 0);
@@ -1538,11 +1546,23 @@ static int maintenance_unregister(int argc, const char **argv, const char *prefi
 		usage_with_options(builtin_maintenance_unregister_usage,
 				   options);
 
-	config_unset.git_cmd = 1;
-	strvec_pushl(&config_unset.args, "config", "--global", "--unset",
-		     "--fixed-value", "maintenance.repo", maintpath, NULL);
+	for_each_string_list_item(item, list) {
+		if (!strcmp(maintpath, item->string)) {
+			found = 1;
+			break;
+		}
+	}
+
+	if (found) {
+		config_unset.git_cmd = 1;
+		strvec_pushl(&config_unset.args, "config", "--global", "--unset",
+			     "--fixed-value", key, maintpath, NULL);
+
+		rc = run_command(&config_unset);
+	} else if (!force) {
+		die(_("repository '%s' is not registered"), maintpath);
+	}
 
-	rc = run_command(&config_unset);
 	free(maintpath);
 	return rc;
 }
diff --git a/t/t7900-maintenance.sh b/t/t7900-maintenance.sh
index 2724a44fe3e..cfe3236567a 100755
--- a/t/t7900-maintenance.sh
+++ b/t/t7900-maintenance.sh
@@ -493,7 +493,11 @@ test_expect_success 'register and unregister' '
 
 	git maintenance unregister &&
 	git config --global --get-all maintenance.repo >actual &&
-	test_cmp before actual
+	test_cmp before actual &&
+
+	test_must_fail git maintenance unregister 2>err &&
+	grep "is not registered" err &&
+	git maintenance unregister --force
 '
 
 test_expect_success !MINGW 'register and unregister with regex metacharacters' '
-- 
gitgitgadget

