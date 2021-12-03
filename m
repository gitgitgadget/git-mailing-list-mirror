Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C702EC433F5
	for <git@archiver.kernel.org>; Fri,  3 Dec 2021 07:01:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378760AbhLCHFW (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 3 Dec 2021 02:05:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350984AbhLCHFT (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Dec 2021 02:05:19 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53142C061758
        for <git@vger.kernel.org>; Thu,  2 Dec 2021 23:01:55 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id d24so3806146wra.0
        for <git@vger.kernel.org>; Thu, 02 Dec 2021 23:01:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=Kla0Up95nG9fLDAaKha+D5grTsqperIJFk04R2nlff4=;
        b=YRTbch8CRzq6PeARpk/9kpanp1FkBoqTsE2lCZV2rKgNneQ9F2BEij7RwnZcnlfZSV
         te8AztZ96XBAAYVbHBiOjXBoODdCX/v1lQU1ioVQ2KBcMDRlriW5XNfbM9L3z10oF2ze
         RPLaeUNIkKDUOa1lcEt7LMV6TLgrIJkH8g8eirGIV6yb0IuGNIQ4vsCHAbUJsOOpcWWC
         ju0ZMOOQqCkJbSJjR05anoH/LWSWWZonpiIACUgrym3raUbpklhLjBytRbre96GLmd3o
         pXQXJb8h1p6aTCKaZufTn/14vWG+VryvQ1+0PAlx83y3otq1493M5mBePhBJkp0qZ+y/
         naug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:mime-version:content-transfer-encoding:fcc:to:cc;
        bh=Kla0Up95nG9fLDAaKha+D5grTsqperIJFk04R2nlff4=;
        b=4iy3kSjBp3SpmIXdHTF2fSPBGuLeOHOj8NON8qXkGhBmrlGsfKjJc2XilEDY/1z48X
         LKxcsssA8tNP1EgZZRWVhz8iwCiFOP2zhFJABvUGsn+ccdGbbm97yYC+/Sj0+6My0J1e
         DoaHkYajABlgmFAHxLFHiqXOiDvBixL3hAYL5r6izF1U5R2MLhE1BQiOjW00aXmWZfmA
         YiaVIf44CUk510jwCghSYenUOhpHULopsKJ9CuzCW5lcLeAnXoIujqdGgKXx3xclOtlW
         HyO+jkLaGED5jybUec5AnF6gSM5bAyApVqYJ3gDSrOBrOGaSabKgnXW6y3Tp6GHvV1iV
         IVuA==
X-Gm-Message-State: AOAM5336pYG0oWX7Nw5YVeEqKZh1mTsuZWrpEROy+SNFwt4s4Sf4ZALW
        jIoydGDUFiSke45dDbqBkZkmtjdlsjU=
X-Google-Smtp-Source: ABdhPJxTReErEicK1809YtT0GCqMJX8qM3MoaEml+ZpeymmGaFdpZ4Boak69YCjTCreXC36qj2qtzQ==
X-Received: by 2002:a05:6000:1a45:: with SMTP id t5mr20701111wry.306.1638514913721;
        Thu, 02 Dec 2021 23:01:53 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ay21sm4374565wmb.7.2021.12.02.23.01.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Dec 2021 23:01:53 -0800 (PST)
Message-Id: <32c7799388b876466a2380c967e6e0dd47de2d23.1638514910.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1088.git.1638514909.gitgitgadget@gmail.com>
References: <pull.1088.git.1638514909.gitgitgadget@gmail.com>
From:   "=?UTF-8?q?Jean-No=C3=ABl=20Avila?= via GitGitGadget" 
        <gitgitgadget@gmail.com>
Date:   Fri, 03 Dec 2021 07:01:41 +0000
Subject: [PATCH 02/10] i18n: refactor "%s, %s and %s are mutually exclusive"
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
To:     git@vger.kernel.org
Cc:     =?UTF-8?Q?Jean-No=C3=ABl?= Avila <jn.avila@free.fr>,
        =?UTF-8?q?Jean-No=C3=ABl=20Avila?= <jn.avila@free.fr>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: =?UTF-8?q?Jean-No=C3=ABl=20Avila?= <jn.avila@free.fr>

Use placeholders for constant tokens.

Signed-off-by: Jean-Noël Avila <jn.avila@free.fr>
---
 builtin/difftool.c | 2 +-
 builtin/log.c      | 2 +-
 builtin/worktree.c | 2 +-
 diff.c             | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/builtin/difftool.c b/builtin/difftool.c
index 4931c108451..61ebfa9c68c 100644
--- a/builtin/difftool.c
+++ b/builtin/difftool.c
@@ -739,7 +739,7 @@ int cmd_difftool(int argc, const char **argv, const char *prefix)
 		die(_("--dir-diff is incompatible with --no-index"));
 
 	if (use_gui_tool + !!difftool_cmd + !!extcmd > 1)
-		die(_("--gui, --tool and --extcmd are mutually exclusive"));
+		die(_("%s, %s and %s are mutually exclusive"), "--gui", "--tool", "--extcmd");
 
 	if (use_gui_tool)
 		setenv("GIT_MERGETOOL_GUI", "true", 1);
diff --git a/builtin/log.c b/builtin/log.c
index a2005e3c778..c39b974ea37 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -1964,7 +1964,7 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
 		load_display_notes(&rev.notes_opt);
 
 	if (use_stdout + rev.diffopt.close_file + !!output_directory > 1)
-		die(_("--stdout, --output, and --output-directory are mutually exclusive"));
+		die(_("%s, %s and %s are mutually exclusive"), "--stdout", "--output", "--output-directory");
 
 	if (use_stdout) {
 		setup_pager();
diff --git a/builtin/worktree.c b/builtin/worktree.c
index 9287c455594..73ee505234c 100644
--- a/builtin/worktree.c
+++ b/builtin/worktree.c
@@ -504,7 +504,7 @@ static int add(int ac, const char **av, const char *prefix)
 	opts.checkout = 1;
 	ac = parse_options(ac, av, prefix, options, worktree_usage, 0);
 	if (!!opts.detach + !!new_branch + !!new_branch_force > 1)
-		die(_("-b, -B, and --detach are mutually exclusive"));
+		die(_("%s, %s and %s are mutually exclusive"), "-b", "-B", "--detach");
 	if (lock_reason && !keep_locked)
 		die(_("--reason requires --lock"));
 	if (lock_reason)
diff --git a/diff.c b/diff.c
index 861282db1c3..342e53f1c1f 100644
--- a/diff.c
+++ b/diff.c
@@ -4642,7 +4642,7 @@ void diff_setup_done(struct diff_options *options)
 		die(_("--name-only, --name-status, --check and -s are mutually exclusive"));
 
 	if (HAS_MULTI_BITS(options->pickaxe_opts & DIFF_PICKAXE_KINDS_MASK))
-		die(_("-G, -S and --find-object are mutually exclusive"));
+		die(_("%s, %s and %s are mutually exclusive"), "-G", "-S", "--find-object");
 
 	if (HAS_MULTI_BITS(options->pickaxe_opts & DIFF_PICKAXE_KINDS_G_REGEX_MASK))
 		die(_("-G and --pickaxe-regex are mutually exclusive, use --pickaxe-regex with -S"));
-- 
gitgitgadget

