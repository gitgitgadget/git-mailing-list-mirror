Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC9F7C433F5
	for <git@archiver.kernel.org>; Sun,  2 Jan 2022 17:15:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229821AbiABRPx (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 2 Jan 2022 12:15:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229565AbiABRPv (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 2 Jan 2022 12:15:51 -0500
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AD18C061761
        for <git@vger.kernel.org>; Sun,  2 Jan 2022 09:15:51 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id p1-20020a1c7401000000b00345c2d068bdso17518622wmc.3
        for <git@vger.kernel.org>; Sun, 02 Jan 2022 09:15:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=9fbUGnMBciC0l81rOHkutNdHhnvad7QSUfw+OlF2DM4=;
        b=X/B2Qg9xpdXNoCK2XikCx7X5zBwgvsmODzIfLmvtRpZxTi8QdO10n8HnXKEeCd4SMH
         TJAjJtQkS9gF8vOCEHmIniGC+zwOeR+Zt6a3rOINzbXPWUPZ0LCzEUYwz7LIGFuBbKAw
         dOmnVU2lHGYC64fwk2Ym9wbt+qb5f2BEp+HOp3xwQV2Is65H669cGBATo6hExQ+KyufQ
         wcTTsSyLQnhiNHf9tbpNQd+6Nv2ZXEgQJD4rooIBurIhy0CVZRhcPiYBFjfykoA/+5qk
         VxkM4w/Mc+LMj4dhJB4g/cPdH09l0UQQCEo9IL0J60kPOjMVdkvRLc8Y7mML0RSTNjmt
         HSIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:mime-version:content-transfer-encoding:fcc:to:cc;
        bh=9fbUGnMBciC0l81rOHkutNdHhnvad7QSUfw+OlF2DM4=;
        b=QepOBYXeWKn9F9T4pyFQpYfnD8VFUQNDPGSYCP3pllE6k+XG2qvSrnRFJKNtqvWa2c
         lZ6gzODb3bMONqKk50fodGgBYBcEFatKkCxI8FiDf3lGksATPyIgl0X42Ap9dDSwrzkN
         Kc9Xfb+OlwGP6k8Vl1HwyWU6DfWy01iRyohieGZ82Db8bt8IIv5Elh7nhmLUTtpyI/AB
         618q3wM3V+MYmMSt9TizNHRHE5yg59ubuvF/ec2tQzToAR1uPBs7koxoTEL/CXd+zq2G
         v7HDPH7r5eKD5rdxPG2cBsg561uMEfHxkcEEcDDmBfPlMIPP7KoQu73Se8GtR3Mih4+J
         bRGQ==
X-Gm-Message-State: AOAM5328Oz7k2yJn09JS/6KH9DRK8wCQzBMP5e5qK0aQ/xryJf+lWNBq
        AsAFwPLBeSCTT1dBbjifc+7NxewHVx4=
X-Google-Smtp-Source: ABdhPJzlVefEA0jzTFyDcM3mWDI55BbHL5meHeCzBnDnmDD5+cJOCdQFN7RwzBXfxZXqLE5ey1UbZA==
X-Received: by 2002:a1c:9acf:: with SMTP id c198mr36821224wme.117.1641143749706;
        Sun, 02 Jan 2022 09:15:49 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id m5sm29306910wml.14.2022.01.02.09.15.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Jan 2022 09:15:49 -0800 (PST)
Message-Id: <e307ea9b998f77d9b2e3c3ce37a510a9e5686949.1641143746.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1088.v4.git.1641143745.gitgitgadget@gmail.com>
References: <pull.1088.v3.git.1640804107.gitgitgadget@gmail.com>
        <pull.1088.v4.git.1641143745.gitgitgadget@gmail.com>
From:   "=?UTF-8?q?Jean-No=C3=ABl=20Avila?= via GitGitGadget" 
        <gitgitgadget@gmail.com>
Date:   Sun, 02 Jan 2022 17:15:36 +0000
Subject: [PATCH v4 02/11] i18n: refactor "%s, %s and %s are mutually
 exclusive"
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Johannes Sixt <j6t@kdbg.org>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, =?UTF-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        =?UTF-8?Q?Jean-No=C3=ABl?= Avila <jn.avila@free.fr>,
        =?UTF-8?q?Jean-No=C3=ABl=20Avila?= <jn.avila@free.fr>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: =?UTF-8?q?Jean-No=C3=ABl=20Avila?= <jn.avila@free.fr>

Use placeholders for constant tokens. The strings are turned into
"cannot be used together"

Signed-off-by: Jean-Noël Avila <jn.avila@free.fr>
---
 builtin/difftool.c     | 2 +-
 builtin/log.c          | 2 +-
 builtin/worktree.c     | 2 +-
 diff.c                 | 2 +-
 t/t4209-log-pickaxe.sh | 6 +++---
 5 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/builtin/difftool.c b/builtin/difftool.c
index 4ee40fe3a06..5beadc07ccd 100644
--- a/builtin/difftool.c
+++ b/builtin/difftool.c
@@ -733,7 +733,7 @@ int cmd_difftool(int argc, const char **argv, const char *prefix)
 		die(_("--dir-diff is incompatible with --no-index"));
 
 	if (use_gui_tool + !!difftool_cmd + !!extcmd > 1)
-		die(_("--gui, --tool and --extcmd are mutually exclusive"));
+		die(_("options '%s', '%s', and '%s' cannot be used together"), "--gui", "--tool", "--extcmd");
 
 	if (use_gui_tool)
 		setenv("GIT_MERGETOOL_GUI", "true", 1);
diff --git a/builtin/log.c b/builtin/log.c
index fad93ad2fc1..74b41db1cee 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -1979,7 +1979,7 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
 		load_display_notes(&rev.notes_opt);
 
 	if (use_stdout + rev.diffopt.close_file + !!output_directory > 1)
-		die(_("--stdout, --output, and --output-directory are mutually exclusive"));
+		die(_("options '%s', '%s', and '%s' cannot be used together"), "--stdout", "--output", "--output-directory");
 
 	if (use_stdout) {
 		setup_pager();
diff --git a/builtin/worktree.c b/builtin/worktree.c
index 9a520485769..27b60732a22 100644
--- a/builtin/worktree.c
+++ b/builtin/worktree.c
@@ -503,7 +503,7 @@ static int add(int ac, const char **av, const char *prefix)
 	opts.checkout = 1;
 	ac = parse_options(ac, av, prefix, options, worktree_usage, 0);
 	if (!!opts.detach + !!new_branch + !!new_branch_force > 1)
-		die(_("-b, -B, and --detach are mutually exclusive"));
+		die(_("options '%s', '%s', and '%s' cannot be used together"),"-b", "-B", "--detach");
 	if (lock_reason && !keep_locked)
 		die(_("--reason requires --lock"));
 	if (lock_reason)
diff --git a/diff.c b/diff.c
index 41076857428..02ce779e43a 100644
--- a/diff.c
+++ b/diff.c
@@ -4642,7 +4642,7 @@ void diff_setup_done(struct diff_options *options)
 		die(_("--name-only, --name-status, --check and -s are mutually exclusive"));
 
 	if (HAS_MULTI_BITS(options->pickaxe_opts & DIFF_PICKAXE_KINDS_MASK))
-		die(_("-G, -S and --find-object are mutually exclusive"));
+		die(_("options '%s', '%s', and '%s' cannot be used together"), "-G", "-S", "--find-object");
 
 	if (HAS_MULTI_BITS(options->pickaxe_opts & DIFF_PICKAXE_KINDS_G_REGEX_MASK))
 		die(_("-G and --pickaxe-regex are mutually exclusive, use --pickaxe-regex with -S"));
diff --git a/t/t4209-log-pickaxe.sh b/t/t4209-log-pickaxe.sh
index 75795d0b492..4f820f8597d 100755
--- a/t/t4209-log-pickaxe.sh
+++ b/t/t4209-log-pickaxe.sh
@@ -63,13 +63,13 @@ test_expect_success 'usage' '
 	test_i18ngrep "switch.*requires a value" err &&
 
 	test_expect_code 128 git log -Gregex -Sstring 2>err &&
-	grep "mutually exclusive" err &&
+	grep "cannot be used together" err &&
 
 	test_expect_code 128 git log -Gregex --find-object=HEAD 2>err &&
-	grep "mutually exclusive" err &&
+	grep "cannot be used together" err &&
 
 	test_expect_code 128 git log -Sstring --find-object=HEAD 2>err &&
-	grep "mutually exclusive" err &&
+	grep "cannot be used together" err &&
 
 	test_expect_code 128 git log --pickaxe-all --find-object=HEAD 2>err &&
 	grep "mutually exclusive" err
-- 
gitgitgadget

