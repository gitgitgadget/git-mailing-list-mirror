Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3D7FB20248
	for <e@80x24.org>; Sun, 17 Mar 2019 12:50:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727258AbfCQMus (ORCPT <rfc822;e@80x24.org>);
        Sun, 17 Mar 2019 08:50:48 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:42303 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726204AbfCQMur (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 17 Mar 2019 08:50:47 -0400
Received: by mail-pf1-f196.google.com with SMTP id r15so6647936pfn.9
        for <git@vger.kernel.org>; Sun, 17 Mar 2019 05:50:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GO4/AkaGuCpPPhJqll15dtW8EyeYH/ZGJwPW/Aec5tQ=;
        b=Ns7oc0AMRte3xw3iwMxdxD0WSXxbsEZcGB/+xwyP00U2Se8VPQbsh3GEMHheJK9V+v
         +CLhkVI1JCk4ZtWq87BoPTzfDcfqIss9PPChCLZ6VLu3r6Al37lXfuMM4nm27xypOosY
         zHOUInty0Fgg8rbrASO67+3wNyTxexnvBwyYm2ipVLaqfQwGEDfVKKLSEaC5oF42nyxm
         spi0qXE6qpEjUaHm/RdC2YBPNVlp/3m0w090qkmzGw+Vl8KRERtacRwa++gYh+HqBIoY
         3cJnK3s9j2jPOaGTHPqG6psaV02/Y+QUMEkMfXymL5oLkGIhyGtyj8fkiiaPB3W+Upv2
         C1ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GO4/AkaGuCpPPhJqll15dtW8EyeYH/ZGJwPW/Aec5tQ=;
        b=gCQSQ5o+7h6b/6vhDwz85WiuCqUw0eOE+mf3jJbYJ+b9dxsXCBHhk7K0EzcUM/31Kp
         C43zL48x2epHkyntup0hoZ4KDrI0SUDjlyMM6Gx7htL/ddVn+71qncdwnhKnyamUhwrW
         74rbg6oCfEnVEqbTcd01BePzSGdZcTVvq62lYxVJyV7UeQ6iR9PjDvuG3c0z+GCSfgba
         eXXZULpW5tTmokmGe/QQjofFN0GvcRr8jbUZIq6Ai2Vfvq7HKloJl4stny8Sp54Q4XjD
         upAn21CJbHzoG9+1QYykYF+/x6/nkoqfippF8CR1eiRXX37f4gnJ5dk2Z1AU1iY4rPgL
         h7CA==
X-Gm-Message-State: APjAAAU/yklPsbL95Z0N6cQemAYK5FOf/8ySa1OOCS8/eUe39HUNLJAU
        Fkvh17LcpOk7kBSqNIgoJLg=
X-Google-Smtp-Source: APXvYqw+4+HE3zQREhoK+s9m2mf2NmjgU7IGa616VDogpR7OyJnCVgc34O2WPWFuwNQUeZuyQkMtWg==
X-Received: by 2002:a17:902:8506:: with SMTP id bj6mr14433690plb.60.1552827046861;
        Sun, 17 Mar 2019 05:50:46 -0700 (PDT)
Received: from ash ([171.226.148.85])
        by smtp.gmail.com with ESMTPSA id h184sm13925885pfc.78.2019.03.17.05.50.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 17 Mar 2019 05:50:46 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Sun, 17 Mar 2019 19:50:41 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     git@vger.kernel.org, gitster@pobox.com, sunshine@sunshineco.com,
        szeder.dev@gmail.com, Elijah Newren <newren@gmail.com>,
        eckhard.s.maass@googlemail.com,
        =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>,
        jacob.keller@gmail.com, phillip.wood123@gmail.com,
        rybak.a.v@gmail.com
Subject: [PATCH v4 11/26] checkout: split options[] array in three pieces
Date:   Sun, 17 Mar 2019 19:49:11 +0700
Message-Id: <20190317124926.17137-12-pclouds@gmail.com>
X-Mailer: git-send-email 2.21.0.548.gd3c7d92dc2
In-Reply-To: <20190317124926.17137-1-pclouds@gmail.com>
References: <20190308095752.8574-1-pclouds@gmail.com>
 <20190317124926.17137-1-pclouds@gmail.com>
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
 parse-options.h    |  1 +
 3 files changed, 77 insertions(+), 23 deletions(-)

diff --git a/builtin/checkout.c b/builtin/checkout.c
index b6fc1fc69f..cf1d70511e 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -1342,15 +1342,31 @@ static int checkout_branch(struct checkout_opts *opts,
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
@@ -1360,34 +1376,49 @@ int cmd_checkout(int argc, const char **argv, const char *prefix)
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
@@ -1401,6 +1432,11 @@ int cmd_checkout(int argc, const char **argv, const char *prefix)
 
 	opts->track = BRANCH_TRACK_UNSPECIFIED;
 
+	options = parse_options_dup(options);
+	options = add_common_options(opts, options);
+	options = add_switch_branch_options(opts, options);
+	options = add_checkout_path_options(opts, options);
+
 	argc = parse_options(argc, argv, prefix, options, checkout_usage,
 			     PARSE_OPT_KEEP_DASHDASH);
 
diff --git a/parse-options-cb.c b/parse-options-cb.c
index 2733393546..caaeed896f 100644
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
index 7d83e2971d..9a90c332a5 100644
--- a/parse-options.h
+++ b/parse-options.h
@@ -257,6 +257,7 @@ int parse_options_step(struct parse_opt_ctx_t *ctx,
 
 int parse_options_end(struct parse_opt_ctx_t *ctx);
 
+struct option *parse_options_dup(const struct option *a);
 struct option *parse_options_concat(struct option *a, struct option *b);
 
 /*----- some often used options -----*/
-- 
2.21.0.548.gd3c7d92dc2

