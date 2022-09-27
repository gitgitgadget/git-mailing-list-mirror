Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29F60C6FA8E
	for <git@archiver.kernel.org>; Tue, 27 Sep 2022 13:57:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232160AbiI0N5I (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 27 Sep 2022 09:57:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232058AbiI0N5G (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Sep 2022 09:57:06 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 393C713F292
        for <git@vger.kernel.org>; Tue, 27 Sep 2022 06:57:05 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id s14so15225734wro.0
        for <git@vger.kernel.org>; Tue, 27 Sep 2022 06:57:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date;
        bh=cEZKmdCKUkErF4ZW3Az02OGHYG92oEAhtCIoWG4zI0s=;
        b=Lt6T/llAWR0qtjw1S0YNXYkO0rLNrSkRXLZ4MgNmMxVpwS4XlD4yte90se1vT6po0o
         0IaTzQ4phJG+EuaUBSCky0Z0X+RAoF6fC8ubrymTKn7r82lE/YcqipAy6N3cUMZPvT71
         INh/Ppna7bai/ZYOlIQUcVSlrZ8vB2xr44gyc+ceWAkJUQWcOHcBP+qgLYyQXYTtTOoS
         RSYwWfP83/aFT1FNFvKVtGLSSoJirMKyzmBcNYXKsTW+28U83XQeX/cFyXtjlVi3huu7
         QTJnikSiSjAqO6We7XBae6CH/gGeqeOSIKSE/n8HdQW4/u3odJq4FkoZLicvO9Od0g9f
         +Qug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date;
        bh=cEZKmdCKUkErF4ZW3Az02OGHYG92oEAhtCIoWG4zI0s=;
        b=LyIKu07hfp+ZjytteRlCL9QlLv1AALeQ5Bbl6eAqSzYHZ2GfOfQj4DX/SWoDf1r3BM
         nuyJtIsPuxaTlMi9/PUMOppREXn0P3alTFoguF6JPK40DXCwzp7fppCMZtQoObpG/TVd
         YuKi1a7+oeorHsb3Sj4dl412+9GkKugvjbWHx4WvHAa6+0eIUUbiOrJHRw/05VAmN4R3
         TL9a2bjOTmFT8KV8FmdNYpnZ8ROSS4I7HzejGD+R1WtzJS4Jqys+F8DpoWojVRirDTYK
         Lj5AiJ80qKX1/Flr3Em0/aF26X9vdIh0KJ9vNqmotl2Oz5g6jp/OtJPSeOSZedgyaKer
         4fwA==
X-Gm-Message-State: ACrzQf0GTAhK0Wtr2AWIpikrT6J9Dq/hmTmJ0xysX3zJMih9uJctmPGO
        0nlNpubYqz18xLHDcesdbOBRlSKH8LY=
X-Google-Smtp-Source: AMsMyM60yq9IVMk80gFJEtaQhBYkqk65JiRgs9N5gU1T25OFYNBBZPkT9oWI6bau5b4RwaFhPphIrg==
X-Received: by 2002:a05:6000:186d:b0:22a:f6ce:72d9 with SMTP id d13-20020a056000186d00b0022af6ce72d9mr16776122wri.426.1664287023415;
        Tue, 27 Sep 2022 06:57:03 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id e18-20020adffd12000000b0022878c0cc5esm1828863wrr.69.2022.09.27.06.57.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Sep 2022 06:57:03 -0700 (PDT)
Message-Id: <c3301e21109b3f730d601ea4f21a49b9e7319cdf.1664287021.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1358.v4.git.1664287021.gitgitgadget@gmail.com>
References: <pull.1358.v3.git.1664218087.gitgitgadget@gmail.com>
        <pull.1358.v4.git.1664287021.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 27 Sep 2022 13:56:58 +0000
Subject: [PATCH v4 1/4] maintenance: add 'unregister --force'
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

Also add an extra test of 'git maintenance unregister' at a point where
there are no registered repositories. This should fail without --force.

Signed-off-by: Derrick Stolee <derrickstolee@github.com>
---
 Documentation/git-maintenance.txt |  6 +++++-
 builtin/gc.c                      | 35 +++++++++++++++++++++++++------
 t/t7900-maintenance.sh            | 11 +++++++++-
 3 files changed, 44 insertions(+), 8 deletions(-)

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
index 2753bd15a5e..dc0ba9e3648 100644
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
+	const struct string_list *list;
 
 	argc = parse_options(argc, argv, prefix, options,
 			     builtin_maintenance_unregister_usage, 0);
@@ -1538,11 +1546,26 @@ static int maintenance_unregister(int argc, const char **argv, const char *prefi
 		usage_with_options(builtin_maintenance_unregister_usage,
 				   options);
 
-	config_unset.git_cmd = 1;
-	strvec_pushl(&config_unset.args, "config", "--global", "--unset",
-		     "--fixed-value", "maintenance.repo", maintpath, NULL);
+	list = git_config_get_value_multi(key);
+	if (list) {
+		for_each_string_list_item(item, list) {
+			if (!strcmp(maintpath, item->string)) {
+				found = 1;
+				break;
+			}
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
index 2724a44fe3e..96bdd420456 100755
--- a/t/t7900-maintenance.sh
+++ b/t/t7900-maintenance.sh
@@ -480,6 +480,11 @@ test_expect_success 'maintenance.strategy inheritance' '
 
 test_expect_success 'register and unregister' '
 	test_when_finished git config --global --unset-all maintenance.repo &&
+
+	test_must_fail git maintenance unregister 2>err &&
+	grep "is not registered" err &&
+	git maintenance unregister --force &&
+
 	git config --global --add maintenance.repo /existing1 &&
 	git config --global --add maintenance.repo /existing2 &&
 	git config --global --get-all maintenance.repo >before &&
@@ -493,7 +498,11 @@ test_expect_success 'register and unregister' '
 
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

