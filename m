Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A4DD01F453
	for <e@80x24.org>; Fri,  8 Feb 2019 09:05:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727553AbfBHJFD (ORCPT <rfc822;e@80x24.org>);
        Fri, 8 Feb 2019 04:05:03 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:38029 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726115AbfBHJFD (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Feb 2019 04:05:03 -0500
Received: by mail-pg1-f196.google.com with SMTP id g189so1310404pgc.5
        for <git@vger.kernel.org>; Fri, 08 Feb 2019 01:05:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=pQH3hqjxsDKVTc/CSA4hRuj+mYNkHhNGyPng4PDcIio=;
        b=Z5iOS9zqU4SRYe4XzaikqorLKgUbXzdw0tnum3zGqpjm6QdEvTxIQZQ8P+G0LbK9W0
         mz39/4mGl76Wj3u27ajC+b9Pl5S2wvZDsZAytOTtfGP2vNQOuVXPPJ1OW15TaKFVX6zP
         fUeoqsKtCZIcsW6KO4zRfqSZgdN7bfm4jukDMtw9K+rJQpwLt04qy+JTiH86bcAqAGis
         YtbCl0NHCaAiLE+bYPjV1A1ZYPWZOdCRsveNy5BTnpMkyBgjiMUu1LpzdwCYRpr+Fon/
         FipJ6fFWgg+w6JVERHl6uh9t6mvc0+N15V3vZhCsFIO3Hr/WbX4/XDXgOMfMR9To9oq2
         TA6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pQH3hqjxsDKVTc/CSA4hRuj+mYNkHhNGyPng4PDcIio=;
        b=prt1ZZkSqbCjVwdO+th/+TJixNME+B8Gs3deVF9qGfM/2QHQxb6qfzNRZVRDXm+bEp
         gAyoUWbrnJ4WgiCWBQTb/th3zbLtI+kML0ce3X8w+AIVsfm+amOJxRjWd+dSqO8BBf/V
         QdWoBnUdiQ0AjayD0DxrjgwiAloQtPDLYKkz09Lq5H+vVDHyxs5Xh2vlUlHxAQqfyDZP
         a7An+JnrfbkR5H30DVwGQ5MqNt4brOnykdxhmcDRiiAmfHu2D0SygBYhk/X5mpHZ5pPQ
         R1K6LZWaHr3BxEo4jMY62g5TzVrDrq3IHGCX4CGkl7e7zaL5lLZ2HHu61S9vkBImTc0v
         xbhA==
X-Gm-Message-State: AHQUAuaRH/unlbzyjKC/330fQRYZSgqejtB22uTqHhRyxCBNfa9PGCK5
        OFc7kLK8moSMQCt0L5kfS5Bfx9DV
X-Google-Smtp-Source: AHgI3IafAop/gilZz3s+9cWePv7dOKvvd2E1+6HeJc7HcoiMLddxeTo2omCbP10nDKy1VvyGhL7z0A==
X-Received: by 2002:a62:3305:: with SMTP id z5mr21346583pfz.112.1549616702265;
        Fri, 08 Feb 2019 01:05:02 -0800 (PST)
Received: from ash ([115.72.21.220])
        by smtp.gmail.com with ESMTPSA id e21sm5918574pfh.45.2019.02.08.01.04.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 08 Feb 2019 01:05:01 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Fri, 08 Feb 2019 16:04:57 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 07/19] checkout: split options[] array in three pieces
Date:   Fri,  8 Feb 2019 16:03:49 +0700
Message-Id: <20190208090401.14793-8-pclouds@gmail.com>
X-Mailer: git-send-email 2.20.1.682.gd5861c6d90
In-Reply-To: <20190208090401.14793-1-pclouds@gmail.com>
References: <20190130094831.10420-1-pclouds@gmail.com>
 <20190208090401.14793-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is a preparation step for introducing new commands that do parts
of what checkout does. There will be two new commands, one is about
switching branches, detaching HEAD... one about checking out
paths. These share the a subset of command line options. The rest of
command line options are separate.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 builtin/checkout.c | 82 +++++++++++++++++++++++++++++++++-------------
 parse-options-cb.c | 17 ++++++++++
 parse-options.h    |  3 +-
 3 files changed, 78 insertions(+), 24 deletions(-)

diff --git a/builtin/checkout.c b/builtin/checkout.c
index 5914dd3619..8ea1349cce 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -1327,15 +1327,31 @@ static int checkout_branch(struct checkout_opts *opts,
 	return switch_branches(opts, new_branch_info);
 }
 
-int cmd_checkout(int argc, const char **argv, const char *prefix)
+static struct option *add_common_options(struct checkout_opts *opts,
+					 struct option *prevopts)
 {
-	struct checkout_opts real_opts;
-	struct checkout_opts *opts = &real_opts;
-	struct branch_info new_branch_info;
-	int dwim_new_local_branch;
-	int dwim_remotes_matched = 0;
 	struct option options[] = {
 		OPT__QUIET(&opts->quiet, N_("suppress progress reporting")),
+		{ OPTION_CALLBACK, 0, "recurse-submodules", NULL,
+			    "checkout", "control recursive updating of submodules",
+			    PARSE_OPT_OPTARG, option_parse_recurse_submodules_worktree_updater },
+		OPT_BOOL(0, "progress", &opts->show_progress, N_("force progress reporting")),
+		OPT__FORCE(&opts->force, N_("force checkout (throw away local modifications)"),
+			   PARSE_OPT_NOCOMPLETE),
+		OPT_BOOL('m', "merge", &opts->merge, N_("perform a 3-way merge with the new branch")),
+		OPT_STRING(0, "conflict", &opts->conflict_style, N_("style"),
+			   N_("conflict style (merge or diff3)")),
+		OPT_END()
+	};
+	struct option *newopts = parse_options_concat(prevopts, options);
+	free(prevopts);
+	return newopts;
+}
+
+static struct option *add_switch_branch_options(struct checkout_opts *opts,
+						struct option *prevopts)
+{
+	struct option options[] = {
 		OPT_STRING('b', NULL, &opts->new_branch, N_("branch"),
 			   N_("create and checkout a new branch")),
 		OPT_STRING('B', NULL, &opts->new_branch_force, N_("branch"),
@@ -1345,34 +1361,49 @@ int cmd_checkout(int argc, const char **argv, const char *prefix)
 		OPT_SET_INT('t', "track",  &opts->track, N_("set upstream info for new branch"),
 			BRANCH_TRACK_EXPLICIT),
 		OPT_STRING(0, "orphan", &opts->new_orphan_branch, N_("new-branch"), N_("new unparented branch")),
+		OPT_BOOL_F(0, "overwrite-ignore", &opts->overwrite_ignore,
+			   N_("update ignored files (default)"),
+			   PARSE_OPT_NOCOMPLETE),
+		OPT_BOOL(0, "no-guess", &opts->no_dwim_new_local_branch,
+			 N_("second guess 'git checkout <no-such-branch>'")),
+		OPT_BOOL(0, "ignore-other-worktrees", &opts->ignore_other_worktrees,
+			 N_("do not check if another worktree is holding the given ref")),
+		OPT_END()
+	};
+	struct option *newopts = parse_options_concat(prevopts, options);
+	free(prevopts);
+	return newopts;
+}
+
+static struct option *add_checkout_path_options(struct checkout_opts *opts,
+						struct option *prevopts)
+{
+	struct option options[] = {
 		OPT_SET_INT_F('2', "ours", &opts->writeout_stage,
 			      N_("checkout our version for unmerged files"),
 			      2, PARSE_OPT_NONEG),
 		OPT_SET_INT_F('3', "theirs", &opts->writeout_stage,
 			      N_("checkout their version for unmerged files"),
 			      3, PARSE_OPT_NONEG),
-		OPT__FORCE(&opts->force, N_("force checkout (throw away local modifications)"),
-			   PARSE_OPT_NOCOMPLETE),
-		OPT_BOOL('m', "merge", &opts->merge, N_("perform a 3-way merge with the new branch")),
-		OPT_BOOL_F(0, "overwrite-ignore", &opts->overwrite_ignore,
-			   N_("update ignored files (default)"),
-			   PARSE_OPT_NOCOMPLETE),
-		OPT_STRING(0, "conflict", &opts->conflict_style, N_("style"),
-			   N_("conflict style (merge or diff3)")),
 		OPT_BOOL('p', "patch", &opts->patch_mode, N_("select hunks interactively")),
 		OPT_BOOL(0, "ignore-skip-worktree-bits", &opts->ignore_skipworktree,
 			 N_("do not limit pathspecs to sparse entries only")),
-		OPT_BOOL(0, "no-guess", &opts->no_dwim_new_local_branch,
-			 N_("do not second guess 'git checkout <no-such-branch>'")),
-		OPT_BOOL(0, "ignore-other-worktrees", &opts->ignore_other_worktrees,
-			 N_("do not check if another worktree is holding the given ref")),
-		{ OPTION_CALLBACK, 0, "recurse-submodules", NULL,
-			    "checkout", "control recursive updating of submodules",
-			    PARSE_OPT_OPTARG, option_parse_recurse_submodules_worktree_updater },
-		OPT_BOOL(0, "progress", &opts->show_progress, N_("force progress reporting")),
 		OPT_BOOL(0, "overlay", &opts->overlay_mode, N_("use overlay mode (default)")),
-		OPT_END(),
+		OPT_END()
 	};
+	struct option *newopts = parse_options_concat(prevopts, options);
+	free(prevopts);
+	return newopts;
+}
+
+int cmd_checkout(int argc, const char **argv, const char *prefix)
+{
+	struct checkout_opts real_opts;
+	struct checkout_opts *opts = &real_opts;
+	struct branch_info new_branch_info;
+	int dwim_remotes_matched = 0;
+	int dwim_new_local_branch;
+	struct option *options = NULL;
 
 	memset(opts, 0, sizeof(*opts));
 	memset(&new_branch_info, 0, sizeof(new_branch_info));
@@ -1386,6 +1417,11 @@ int cmd_checkout(int argc, const char **argv, const char *prefix)
 
 	opts->track = BRANCH_TRACK_UNSPECIFIED;
 
+	options = parse_options_dup(options);
+	options = add_common_options(opts, options);
+	options = add_switch_branch_options(opts, options);
+	options = add_checkout_path_options(opts, options);
+
 	argc = parse_options(argc, argv, prefix, options, checkout_usage,
 			     PARSE_OPT_KEEP_DASHDASH);
 
diff --git a/parse-options-cb.c b/parse-options-cb.c
index e2f3eaed07..76eb5c211b 100644
--- a/parse-options-cb.c
+++ b/parse-options-cb.c
@@ -122,6 +122,23 @@ int parse_opt_tertiary(const struct option *opt, const char *arg, int unset)
 	return 0;
 }
 
+struct option *parse_options_dup(const struct option *o)
+{
+	struct option *opts;
+	int nr = 0;
+
+	while (o && o->type != OPTION_END) {
+		nr++;
+		o++;
+	}
+
+	ALLOC_ARRAY(opts, nr + 1);
+	memcpy(opts, o - nr, sizeof(*o) * nr);
+	memset(opts + nr, 0, sizeof(*opts));
+	opts[nr].type = OPTION_END;
+	return opts;
+}
+
 struct option *parse_options_concat(struct option *a, struct option *b)
 {
 	struct option *ret;
diff --git a/parse-options.h b/parse-options.h
index 14fe32428e..6846a5b1e0 100644
--- a/parse-options.h
+++ b/parse-options.h
@@ -237,7 +237,8 @@ extern int parse_options_step(struct parse_opt_ctx_t *ctx,
 
 extern int parse_options_end(struct parse_opt_ctx_t *ctx);
 
-extern struct option *parse_options_concat(struct option *a, struct option *b);
+struct option *parse_options_dup(const struct option *a);
+struct option *parse_options_concat(struct option *a, struct option *b);
 
 /*----- some often used options -----*/
 extern int parse_opt_abbrev_cb(const struct option *, const char *, int);
-- 
2.20.1.682.gd5861c6d90

