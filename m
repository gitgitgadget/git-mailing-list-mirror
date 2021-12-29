Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB23AC433EF
	for <git@archiver.kernel.org>; Wed, 29 Dec 2021 18:55:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229985AbhL2SzP (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 29 Dec 2021 13:55:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229951AbhL2SzM (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 Dec 2021 13:55:12 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85AD8C06173F
        for <git@vger.kernel.org>; Wed, 29 Dec 2021 10:55:12 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id v7so46041760wrv.12
        for <git@vger.kernel.org>; Wed, 29 Dec 2021 10:55:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=MAJYU9Y7AzglzM3icax1IabNvMpHuzzNWocCQquOie8=;
        b=ji4G+99ih1joPgF3aUgwZm5toHpPHNvlWzfuz35ZsEcinF8oRf/WjAXg4K9g7WQarP
         /5tNmik25x4QHzwbPO5A82vwMnp0HRHmcsukQzN7ELyLpNj7xoH+WP/+TUzDr3HTkIKi
         lBlwv3IFX2wgWsWbr3rNEhb/gwRiH70fAePUAOfA3QNPJt5i0BtzdIYgRsyM1EErhj34
         b3RXm0GP9tq4uOBAbvAHK+dx/9UE4XHrKx4PGHyVxAYyC4ggEPOmYSmpnOKv52w8UC2s
         J+xCUCZzI9liCukejeSU3ugnhi5qP08mnBuZghL51aaY4lDbTF9VSOo7EW1Ib2d0Gjd7
         68iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:mime-version:content-transfer-encoding:fcc:to:cc;
        bh=MAJYU9Y7AzglzM3icax1IabNvMpHuzzNWocCQquOie8=;
        b=oLN5lLmjPpfzfw9dOpgbnGZedYNitUVSuDfaHoMHa5IIdbkDXe4SsDK4jHIdBABwjt
         5bEBtUBEe9bECI85fiwSOHx8WaYX5+eydSA/iR5t/TmWO9mmy5jgJAnBwwEsG2dUpmfI
         +6RW4GYMyoEeteS0sjsq3smFEq8TXLcBc1wnEPlBea4aVCwFCeKTy242YkoqMK0r5H3C
         fxJn5tLJWPJVxdh9KZRMZ5xT8I/pENGZKcagJpMv06bjIURbPCJ/ypW8zWFef+1Av7VZ
         UPwE0UHr8QkNi7YH5DpmQ4Zu0j/+89jmZtI2p8fOESYGXU1I3SuHDhmCIUXpwp80s113
         /1Xw==
X-Gm-Message-State: AOAM533mQFNXfbMPL6QLw3DAAoDVebtcP8GDdGseT69Z3ngHDhwiXQDZ
        1JmX4uSFOidUrZ4Exl6/0y4PWJdG0sc=
X-Google-Smtp-Source: ABdhPJwmIAzZey3310vqZNdUlIVEHswec033CK0Ts4PjwJbR/WuZ8X/ym5NCu7PJOfeZpowQjnSLJw==
X-Received: by 2002:a05:6000:154a:: with SMTP id 10mr21644330wry.9.1640804110960;
        Wed, 29 Dec 2021 10:55:10 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id p15sm21051713wmj.46.2021.12.29.10.55.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Dec 2021 10:55:10 -0800 (PST)
Message-Id: <4accf1629e55ae621053f27994ebc4eb59d6f0ff.1640804107.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1088.v3.git.1640804107.gitgitgadget@gmail.com>
References: <pull.1088.v2.git.1640647437.gitgitgadget@gmail.com>
        <pull.1088.v3.git.1640804107.gitgitgadget@gmail.com>
From:   "=?UTF-8?q?Jean-No=C3=ABl=20Avila?= via GitGitGadget" 
        <gitgitgadget@gmail.com>
Date:   Wed, 29 Dec 2021 18:54:58 +0000
Subject: [PATCH v3 02/11] i18n: refactor "%s, %s and %s are mutually
 exclusive"
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Johannes Sixt <j6t@kdbg.org>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>,
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
index 4ee40fe3a06..c2b049aafc9 100644
--- a/builtin/difftool.c
+++ b/builtin/difftool.c
@@ -733,7 +733,7 @@ int cmd_difftool(int argc, const char **argv, const char *prefix)
 		die(_("--dir-diff is incompatible with --no-index"));
 
 	if (use_gui_tool + !!difftool_cmd + !!extcmd > 1)
-		die(_("--gui, --tool and --extcmd are mutually exclusive"));
+		die(_("options '%s', '%s' and '%s' cannot be used together"), "--gui", "--tool", "--extcmd");
 
 	if (use_gui_tool)
 		setenv("GIT_MERGETOOL_GUI", "true", 1);
diff --git a/builtin/log.c b/builtin/log.c
index fad93ad2fc1..705d58110b0 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -1979,7 +1979,7 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
 		load_display_notes(&rev.notes_opt);
 
 	if (use_stdout + rev.diffopt.close_file + !!output_directory > 1)
-		die(_("--stdout, --output, and --output-directory are mutually exclusive"));
+		die(_("options '%s', '%s' and '%s' cannot be used together"), "--stdout", "--output", "--output-directory");
 
 	if (use_stdout) {
 		setup_pager();
diff --git a/builtin/worktree.c b/builtin/worktree.c
index 9a520485769..b5ef19b2dda 100644
--- a/builtin/worktree.c
+++ b/builtin/worktree.c
@@ -503,7 +503,7 @@ static int add(int ac, const char **av, const char *prefix)
 	opts.checkout = 1;
 	ac = parse_options(ac, av, prefix, options, worktree_usage, 0);
 	if (!!opts.detach + !!new_branch + !!new_branch_force > 1)
-		die(_("-b, -B, and --detach are mutually exclusive"));
+		die(_("options '%s', '%s' and '%s' cannot be used together"), "-b", "-B", "--detach");
 	if (lock_reason && !keep_locked)
 		die(_("--reason requires --lock"));
 	if (lock_reason)
diff --git a/diff.c b/diff.c
index 41076857428..8de1c49763c 100644
--- a/diff.c
+++ b/diff.c
@@ -4642,7 +4642,7 @@ void diff_setup_done(struct diff_options *options)
 		die(_("--name-only, --name-status, --check and -s are mutually exclusive"));
 
 	if (HAS_MULTI_BITS(options->pickaxe_opts & DIFF_PICKAXE_KINDS_MASK))
-		die(_("-G, -S and --find-object are mutually exclusive"));
+		die(_("options '%s', '%s' and '%s' cannot be used together"), "-G", "-S", "--find-object");
 
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

