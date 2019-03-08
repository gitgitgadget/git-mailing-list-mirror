Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0237620248
	for <e@80x24.org>; Fri,  8 Mar 2019 10:17:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726424AbfCHKRZ (ORCPT <rfc822;e@80x24.org>);
        Fri, 8 Mar 2019 05:17:25 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:37427 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726420AbfCHKRY (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Mar 2019 05:17:24 -0500
Received: by mail-pf1-f196.google.com with SMTP id s22so13827291pfh.4
        for <git@vger.kernel.org>; Fri, 08 Mar 2019 02:17:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PjcuevpGQFeHFqWt9eaXrCheV7xUXWfAUuiWgjc2qv0=;
        b=TW42X7OHNU9Oec5fmLuBxy2ViYqG3q3nruCU7wYIJ5MtV521XZT+xikrjOjWmmnHEu
         MWXDQn2fg6v5RdMAW+hnkKLUxaKFWkGO8HyXMNkgzPrYjCs/q9lQZK6mE7lUMjY3zkCk
         Wl/As88f3WsfxIYx3xtFkvRDHmWUAaJS0eHNqMPlnWFhgqsYzlP707GlPt0WBo8MCRyV
         N3VpwsZtHrW23mvunRWAPLLvcc9H6njng0eZYzH97/Ba0pZsffY9C3vr4HkDI9oLO+vj
         /zW1KTBp1zQboyAyh/YBPtpN8ioepj0GT1nou04llFj/YwvABTdmGIOaS9CVS6qy/jvt
         mEWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PjcuevpGQFeHFqWt9eaXrCheV7xUXWfAUuiWgjc2qv0=;
        b=BljTVpgXwPZxCoFfax6xKmP6rLL3xMeFOmQjfPPMUzFeHuEZ80bS1ZdxDs8g8bD61j
         kAFcJj5m/B4svU1bhOIPs9MktcKDudtiWSdvXIMzn5741v0jx4yBkktnn987bPZYMWIT
         7HYNFxaYQF7UoVmhgoCJgreDgLvS0DqFB5MWdvoSm1WBIkbMEMkrv0JDma4zUEXdeoZP
         BOWAXhgLiFizWaIUawkYH4mzEY5WPXkS4WheNYdSE8P2nERt2Z14t5RPFrGpmsdw3j6c
         kAzWQ2n8phBgtMitA3e4YZjCZvEQLs0YxAx/t6SHxC5l+yX/axT9mNnjXMBbRKLqLH1N
         ri3g==
X-Gm-Message-State: APjAAAW+SCBWPqO+0JElfqDtpsjIMU673H9QaurRXxpaJNdAinHarsM5
        ee1t6MqdxGIEnvXAyisRK7ux7xNC
X-Google-Smtp-Source: APXvYqwCRHu/5nOtqyinLwuyFjbu2dMHyRWSTV1EgCgJQAUYVI1+EHdKNmX2ksxNSG7RK52xel6Lag==
X-Received: by 2002:a17:902:7b85:: with SMTP id w5mr18192722pll.288.1552040243366;
        Fri, 08 Mar 2019 02:17:23 -0800 (PST)
Received: from ash ([171.226.148.85])
        by smtp.gmail.com with ESMTPSA id 23sm17591454pft.187.2019.03.08.02.17.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 08 Mar 2019 02:17:22 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Fri, 08 Mar 2019 17:17:19 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH v1 04/11] restore: disable overlay mode by default
Date:   Fri,  8 Mar 2019 17:16:48 +0700
Message-Id: <20190308101655.9767-5-pclouds@gmail.com>
X-Mailer: git-send-email 2.21.0.rc1.337.gdf7f8d0522
In-Reply-To: <20190308101655.9767-1-pclouds@gmail.com>
References: <20190308101655.9767-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Overlay mode is considered confusing when the command is about
restoring files on worktree. Disable it by default. The user can still
turn it on, or use 'git checkout' which still has overlay mode on by
default.

While at there make the check in checkout_branch() stricter. Neither
--overlay or --no-overlay should be accepted in branch switching mode.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 builtin/checkout.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/builtin/checkout.c b/builtin/checkout.c
index c52ce13d2a..9e59bf792f 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -1196,9 +1196,9 @@ static int checkout_branch(struct checkout_opts *opts,
 		die(_("'%s' cannot be used with switching branches"),
 		    "--patch");
 
-	if (!opts->overlay_mode)
+	if (opts->overlay_mode != -1)
 		die(_("'%s' cannot be used with switching branches"),
-		    "--no-overlay");
+		    "--[no]-overlay");
 
 	if (opts->writeout_stage)
 		die(_("'%s' cannot be used with switching branches"),
@@ -1313,7 +1313,6 @@ static struct option *add_checkout_path_options(struct checkout_opts *opts,
 		OPT_BOOL('p', "patch", &opts->patch_mode, N_("select hunks interactively")),
 		OPT_BOOL(0, "ignore-skip-worktree-bits", &opts->ignore_skipworktree,
 			 N_("do not limit pathspecs to sparse entries only")),
-		OPT_BOOL(0, "overlay", &opts->overlay_mode, N_("use overlay mode (default)")),
 		OPT_END()
 	};
 	struct option *newopts = parse_options_concat(prevopts, options);
@@ -1333,7 +1332,6 @@ static int checkout_main(int argc, const char **argv, const char *prefix,
 	opts->overwrite_ignore = 1;
 	opts->prefix = prefix;
 	opts->show_progress = -1;
-	opts->overlay_mode = -1;
 
 	git_config(git_checkout_config, opts);
 
@@ -1505,6 +1503,7 @@ int cmd_checkout(int argc, const char **argv, const char *prefix)
 		OPT_BOOL('l', NULL, &opts.new_branch_log, N_("create reflog for new branch")),
 		OPT_BOOL(0, "guess", &opts.dwim_new_local_branch,
 			 N_("second guess 'git checkout <no-such-branch>' (default)")),
+		OPT_BOOL(0, "overlay", &opts.overlay_mode, N_("use overlay mode (default)")),
 		OPT_END()
 	};
 	int ret;
@@ -1517,6 +1516,7 @@ int cmd_checkout(int argc, const char **argv, const char *prefix)
 	opts.accept_pathspec = 1;
 	opts.implicit_detach = 1;
 	opts.empty_pathspec_ok = 1;
+	opts.overlay_mode = -1;
 
 	options = parse_options_dup(checkout_options);
 	options = add_common_options(&opts, options);
@@ -1551,6 +1551,7 @@ int cmd_switch(int argc, const char **argv, const char *prefix)
 	opts.switch_branch_doing_nothing_is_ok = 0;
 	opts.only_merge_on_switching_branches = 1;
 	opts.implicit_detach = 0;
+	opts.overlay_mode = -1;
 
 	options = parse_options_dup(switch_options);
 	options = add_common_options(&opts, options);
@@ -1569,6 +1570,7 @@ int cmd_restore(int argc, const char **argv, const char *prefix)
 	struct option restore_options[] = {
 		OPT_STRING('s', "source", &opts.from_treeish, "<tree-ish>",
 			   N_("where the checkout from")),
+		OPT_BOOL(0, "overlay", &opts.overlay_mode, N_("use overlay mode")),
 		OPT_END()
 	};
 	int ret;
@@ -1577,6 +1579,7 @@ int cmd_restore(int argc, const char **argv, const char *prefix)
 	opts.accept_ref = 0;
 	opts.accept_pathspec = 1;
 	opts.empty_pathspec_ok = 0;
+	opts.overlay_mode = 0;
 
 	options = parse_options_dup(restore_options);
 	options = add_common_options(&opts, options);
-- 
2.21.0.rc1.337.gdf7f8d0522

