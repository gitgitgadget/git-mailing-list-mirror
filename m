Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A06BC433FE
	for <git@archiver.kernel.org>; Mon, 27 Dec 2021 23:24:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233943AbhL0XYF (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 27 Dec 2021 18:24:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233931AbhL0XYD (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Dec 2021 18:24:03 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 618AAC06173E
        for <git@vger.kernel.org>; Mon, 27 Dec 2021 15:24:02 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id e5so34903233wrc.5
        for <git@vger.kernel.org>; Mon, 27 Dec 2021 15:24:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=kLWVhsGbGtij1h9vvbHHwRdAjtezzVMqTh73NV1sLjk=;
        b=K4d2v9C1HXht2NmLjgOp0Rl73a/eem92kD6S4qfJjQSbaD0Sm7/pPZF83d6SwXM6Zs
         PHe8lpDcMgrRIFfLJYM9jYRUStp82tEdToXhF2N6YNFUYa3iKXoQ6PGAGtU7m9+kIpj0
         m64lBkNCN+p/9B2LiyxUhMZyJ71XBNddtA0hK9R0wSn0u27Om0ZjjxAfOCWPxDWUV13c
         F6guxkvtahGCz+JOcvxU11NVTOe9yRi/tezpaSFEuQbftVzi5UDSO+Fkyx7tsoHyQsRa
         bo84pTOjhLm2dlFSCyBanVbS3cBDDV90UnGXnyTrf2yCOTj/NH64JXAtm9+bvH5mOyXR
         tUWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:mime-version:content-transfer-encoding:fcc:to:cc;
        bh=kLWVhsGbGtij1h9vvbHHwRdAjtezzVMqTh73NV1sLjk=;
        b=czptXJrGwjUb3/r4hes5/jBO21bTdDXVNQBGAg1IXtokn05Or9jChhCan5GdqPpXhB
         tVRZGnaw1Oeu+vS9X7b0NJLBLDyC3UEKWDlFYWi7lD1TBpFWOjH95uRQfkjQJc+b3phD
         CgXAv11njzdnGSnOz09sA7xaXNQ3OmK65QqEkRPDy8nqcwgNO62z1dOKiqt4pz/uEy5j
         iil23K54iBXOFYv6vVWjdP4/CNmz+9rQljVB/Oe4IAhofRQOkjIbrpcR7Bz9ewyiVEOV
         r0Dz+PgHM0pa0pYXIGvgAReYvr0Od0tb6JQHEMT+QDyPG4Xt49VTec9dREuuCFsbpE23
         T1FQ==
X-Gm-Message-State: AOAM530vkpfBcvWpE47mlvR2glSm1M2XvFL0S8n9naAmv1YVtZUDQ9Aw
        Pqqc0fWCkFLP2gGyxp077fADjk9hEr4=
X-Google-Smtp-Source: ABdhPJwVcuZh/IGfk1uJ7DV5IJ6lgMDCFtrJTQqUu696WuNdUfeBti/4LLszpfwzNM8w/VNm6b0NsQ==
X-Received: by 2002:adf:dd83:: with SMTP id x3mr14356993wrl.367.1640647440867;
        Mon, 27 Dec 2021 15:24:00 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id f16sm24912233wmg.27.2021.12.27.15.24.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Dec 2021 15:24:00 -0800 (PST)
Message-Id: <be4e8757f38c9525cf70e96f746acd96ca85dcc3.1640647437.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1088.v2.git.1640647437.gitgitgadget@gmail.com>
References: <pull.1088.git.1638514909.gitgitgadget@gmail.com>
        <pull.1088.v2.git.1640647437.gitgitgadget@gmail.com>
From:   "=?UTF-8?q?Jean-No=C3=ABl=20Avila?= via GitGitGadget" 
        <gitgitgadget@gmail.com>
Date:   Mon, 27 Dec 2021 23:23:48 +0000
Subject: [PATCH v2 02/11] i18n: refactor "%s, %s and %s are mutually
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
 builtin/difftool.c | 2 +-
 builtin/log.c      | 2 +-
 builtin/worktree.c | 2 +-
 diff.c             | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

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
-- 
gitgitgadget

