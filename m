Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E0FAC4332F
	for <git@archiver.kernel.org>; Wed,  5 Jan 2022 20:02:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243820AbiAEUCg (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 5 Jan 2022 15:02:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243797AbiAEUC3 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Jan 2022 15:02:29 -0500
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1078DC061212
        for <git@vger.kernel.org>; Wed,  5 Jan 2022 12:02:29 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id p1-20020a1c7401000000b00345c2d068bdso2560761wmc.3
        for <git@vger.kernel.org>; Wed, 05 Jan 2022 12:02:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=Njb5DPFe4z0b4qnqA2YtOaY2YzMWU9CqTjmFQNlOPj4=;
        b=iPji7Bpdggd57vKg8Q4/N94wUE9cW1jOV590DjtWwRTD9Z5iOFavI/23/VZbluXJ64
         SEvzNy9uIvsgABXGnKujjpLK8AiaY18vk8FeRIx5hax4tnXZryNv39IpAUPeji5L73r8
         hCJF2RsnP1eXK0A6JVTmixtOBY4+ry1z2b5RnM0Uz24YriqaHLrwACpyJ85x/ZvwtFtw
         dWnDSFfEP7ObSQzsIK/cpDSgBh6oKSVywk6B0sFtwMs34PubfhFtnYC5o+1TQdQ4BvUx
         i2OnbK1SSFPPPT05UDMhkQj4qzWAMrPGYTqUWNWD1reNPEFTPEhRyolb8ydnFX1VlDr8
         7GHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:mime-version:content-transfer-encoding:fcc:to:cc;
        bh=Njb5DPFe4z0b4qnqA2YtOaY2YzMWU9CqTjmFQNlOPj4=;
        b=4OJjoLaKSQ6Kbds2hCqZQ60K9lGU2/xqec8sBSPGvp78oiQD2Rit9YuuT4QEo0Qjot
         tdBBesGeRjEYs5oEZOwU6mqfV17ilwoRt6hrNmsSP1KvvCyIdB5K6R20T5ljG0gQd+F5
         pcUtBGO9xbqBc7bx2CAYM15WxnmxCOfvgA36b/qYLOwxBfw19ZiKrfpiPz1/NCnVXmRi
         mDKPNA6mGl70UW5MC3lL0mf8hB5QkejcHEBuqJ83lHvnU5/VerJmPCs0YxPmNrucvJRM
         SM0xvl1kLcvNkQRdbr/6Dozi6cNwGblY7GVnNz5V9sLrbjyUBe+17xP6Uo2urktQX3SM
         Sdgw==
X-Gm-Message-State: AOAM530XePX5xXh9O7GlnhYRSTt3E8oOGbrNqFV+hB8+o3HZcGVzL+cH
        QWtzJMblHso/czopPlGtznh5pciZsrA=
X-Google-Smtp-Source: ABdhPJzc6EPYCP9r0FRfWSj3Zhou4i5NH/PsUITBu2ErdEe6zv61cKLQkVZwXqSoXqa9mzghVU9HHA==
X-Received: by 2002:a7b:c00d:: with SMTP id c13mr4270304wmb.99.1641412947543;
        Wed, 05 Jan 2022 12:02:27 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id h3sm42418122wrt.94.2022.01.05.12.02.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Jan 2022 12:02:27 -0800 (PST)
Message-Id: <f6a5332d310983f6f4ed75ab3dde5e5032857e59.1641412944.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1088.v5.git.1641412944.gitgitgadget@gmail.com>
References: <pull.1088.v4.git.1641143745.gitgitgadget@gmail.com>
        <pull.1088.v5.git.1641412944.gitgitgadget@gmail.com>
From:   "=?UTF-8?q?Jean-No=C3=ABl=20Avila?= via GitGitGadget" 
        <gitgitgadget@gmail.com>
Date:   Wed, 05 Jan 2022 20:02:15 +0000
Subject: [PATCH v5 02/11] i18n: refactor "%s, %s and %s are mutually
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
index 9a520485769..ec1c59ba53c 100644
--- a/builtin/worktree.c
+++ b/builtin/worktree.c
@@ -503,7 +503,7 @@ static int add(int ac, const char **av, const char *prefix)
 	opts.checkout = 1;
 	ac = parse_options(ac, av, prefix, options, worktree_usage, 0);
 	if (!!opts.detach + !!new_branch + !!new_branch_force > 1)
-		die(_("-b, -B, and --detach are mutually exclusive"));
+		die(_("options '%s', '%s', and '%s' cannot be used together"), "-b", "-B", "--detach");
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

