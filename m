Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 12C0E20248
	for <e@80x24.org>; Fri,  8 Mar 2019 10:17:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726429AbfCHKRe (ORCPT <rfc822;e@80x24.org>);
        Fri, 8 Mar 2019 05:17:34 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:47007 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726259AbfCHKRd (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Mar 2019 05:17:33 -0500
Received: by mail-pf1-f194.google.com with SMTP id g6so13821359pfh.13
        for <git@vger.kernel.org>; Fri, 08 Mar 2019 02:17:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Qy4ndlhrTDES6gb8uuvtMmu7iBx/V4HWWlc6i0gDvl0=;
        b=u76K5Tud64MisIUHA62xm/3W0JBhVeuxavzgBQbxO48XqalYK4gmKj8V1pUgO5KWWb
         qLDfYKPT1ezs24V29Vawd70GlXC5KktLHUWv8oO6fRj4SOOQF9zX2H8fxM8f6K3EgKnl
         39jl0aBx+gYxoIOsTYOlUFNb035woTN8/lrT1/A7OCT7mHZbHLmLwtNRkToE9Q2IJ0BO
         pFWQ004HXLE7LXpXXVYOotsY/dDoh/1jzoHM0OlNOo6qCoqczQA8oXDza9vCU0+S7yLe
         2VT+wpSKsZkfC3qyUEn4ptOXJHPnOipaVti+KW/7psaAJQ1FpvvpsBYQszHYyC/aqvQl
         O+mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Qy4ndlhrTDES6gb8uuvtMmu7iBx/V4HWWlc6i0gDvl0=;
        b=QZyNenetCnhM7Ky4mZQqmxuOD2wEBchV/WKG5M0jq/re8sWzhtEWYbxRALtnxLPKNJ
         6zMWFisqe7wsXLlz3cFjC07U2ElAsNmmuzZFME7YKcDJAU/2alF6aNNyZLlUZksak693
         5E/VSGEGJc0R3r9B+2QVm/btPJXLbP5B8QCqEaEBP/Veg1zyBk+Y4SBr7dFEMs4q8Lxq
         3c7feIsQ9UqEi4LkxCijjNESNpn+/3fvdmaddlXD9QeKseHmYxivP3OQoFt705bGNoVd
         hoTUawBwj6SagQ+oDkbWs4vg5ySP7767fE0tfMI756DFLaPXpjtq39ppLzsnTqTDpkOX
         eJ0Q==
X-Gm-Message-State: APjAAAWeRubC4/FBAJhNMEyAK0MPF4SYUq0RrAKJfSyafdjyYBUe1sKc
        oWXeHZSar+2jwqe9AvAj+wP1bFf8
X-Google-Smtp-Source: APXvYqyjhn+8PqcbNeaejKPMtjV8zuSsgpY0fxcYlsJzSSQBjgjnfJPBpRtQZm3+pW+NyaCwA6RPNA==
X-Received: by 2002:a63:6ecb:: with SMTP id j194mr16457934pgc.250.1552040252605;
        Fri, 08 Mar 2019 02:17:32 -0800 (PST)
Received: from ash ([171.226.148.85])
        by smtp.gmail.com with ESMTPSA id m17sm14845728pff.170.2019.03.08.02.17.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 08 Mar 2019 02:17:32 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Fri, 08 Mar 2019 17:17:28 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH v1 06/11] restore: add --worktree and --index
Date:   Fri,  8 Mar 2019 17:16:50 +0700
Message-Id: <20190308101655.9767-7-pclouds@gmail.com>
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

'git checkout <tree-ish> <pathspec>' updates both index and
worktree. But updating the index when you want to restore worktree
files is non-intuitive. The index contains the data ready for the next
commit, and there's no indication that the user will want to commit
the restored versions.

'git restore' therefore by default only touches worktree. The user has
the option to update either the index with

    git restore --source=<tree> --index <path>  (1)

or update both with

    git restore --source=<tree> --index --worktree <path> (2)

PS. Orignally I wanted to make worktree update default and form (1)
would add index update while also updating the worktree, and the user
would need to do "--index --no-worktree" to update index only. But it
looks really confusing that "--index" option alone updates both. So
now form (2) is used for both, which reads much more obvious.

PPS. Yes form (1) overlaps with "git reset <rev> <path>". I don't know
if we can ever turn "git reset" back to "_always_ reset HEAD and
optionally do something else".

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 builtin/checkout.c | 74 ++++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 68 insertions(+), 6 deletions(-)

diff --git a/builtin/checkout.c b/builtin/checkout.c
index 5fb85e7b73..07b431be51 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -62,6 +62,8 @@ struct checkout_opts {
 	int switch_branch_doing_nothing_is_ok;
 	int only_merge_on_switching_branches;
 	int empty_pathspec_ok;
+	int checkout_index;
+	int checkout_worktree;
 
 	const char *new_branch;
 	const char *new_branch_force;
@@ -393,6 +395,7 @@ static int checkout_paths(const struct checkout_opts *opts,
 	struct commit *head;
 	int errs = 0;
 	struct lock_file lock_file = LOCK_INIT;
+	int checkout_index;
 
 	trace2_cmd_mode(opts->patch_mode ? "patch" : "path");
 
@@ -418,9 +421,26 @@ static int checkout_paths(const struct checkout_opts *opts,
 		die(_("Cannot update paths and switch to branch '%s' at the same time."),
 		    opts->new_branch);
 
-	if (opts->patch_mode)
-		return run_add_interactive(revision, "--patch=checkout",
-					   &opts->pathspec);
+	if (!opts->checkout_worktree && !opts->checkout_index)
+		die(_("neither '%s' or '%s' is specified"),
+		    "--index", "--worktree");
+
+	if (!opts->source_tree && !opts->checkout_worktree)
+		die(_("'%s' must be used when '%s' is not specified"),
+		    "--worktree", "--source");
+
+	if (opts->patch_mode) {
+		const char *patch_mode;
+
+		if (opts->checkout_index && opts->checkout_worktree)
+			patch_mode = "--patch=checkout";
+		else if (opts->checkout_index && !opts->checkout_worktree)
+			patch_mode = "--patch=reset";
+		else
+			die(_("'%s' with only '%s' is not currently supported"),
+			    "--patch", "--worktree");
+		return run_add_interactive(revision, patch_mode, &opts->pathspec);
+	}
 
 	repo_hold_locked_index(the_repository, &lock_file, LOCK_DIE_ON_ERROR);
 	if (read_cache_preload(&opts->pathspec) < 0)
@@ -478,10 +498,30 @@ static int checkout_paths(const struct checkout_opts *opts,
 		return 1;
 
 	/* Now we are committed to check them out */
-	errs |= checkout_worktree(opts);
+	if (opts->checkout_worktree)
+		errs |= checkout_worktree(opts);
 
-	if (write_locked_index(&the_index, &lock_file, COMMIT_LOCK))
-		die(_("unable to write new index file"));
+	/*
+	 * Allow updating the index when checking out from the index.
+	 * This is to save new stat info.
+	 */
+	if (opts->checkout_worktree && !opts->checkout_index && !opts->source_tree)
+		checkout_index = 1;
+	else
+		checkout_index = opts->checkout_index;
+
+	if (checkout_index) {
+		if (write_locked_index(&the_index, &lock_file, COMMIT_LOCK))
+			die(_("unable to write new index file"));
+	} else {
+		/*
+		 * NEEDSWORK: if --worktree is not specified, we
+		 * should save stat info of checked out files in the
+		 * index to avoid the next (potentially costly)
+		 * refresh. But it's a bit tricker to do...
+		 */
+		rollback_lock_file(&lock_file);
+	}
 
 	read_ref_full("HEAD", 0, &rev, NULL);
 	head = lookup_commit_reference_gently(the_repository, &rev, 1);
@@ -1373,6 +1413,20 @@ static int checkout_main(int argc, const char **argv, const char *prefix,
 	if (opts->overlay_mode == 1 && opts->patch_mode)
 		die(_("-p and --overlay are mutually exclusive"));
 
+	if (opts->checkout_index >= 0 || opts->checkout_worktree >= 0) {
+		if (opts->checkout_index < 0)
+			opts->checkout_index = 0;
+		if (opts->checkout_worktree < 0)
+			opts->checkout_worktree = 0;
+	} else {
+		if (opts->checkout_index < 0)
+			opts->checkout_index = -opts->checkout_index - 1;
+		if (opts->checkout_worktree < 0)
+			opts->checkout_worktree = -opts->checkout_worktree - 1;
+	}
+	if (opts->checkout_index < 0 || opts->checkout_worktree < 0)
+		BUG("these flags should be non-negative by now");
+
 	/*
 	 * From here on, new_branch will contain the branch to be checked out,
 	 * and new_branch_force and new_orphan_branch will tell us which one of
@@ -1527,6 +1581,8 @@ int cmd_checkout(int argc, const char **argv, const char *prefix)
 	opts.implicit_detach = 1;
 	opts.empty_pathspec_ok = 1;
 	opts.overlay_mode = -1;
+	opts.checkout_index = -2;    /* default on */
+	opts.checkout_worktree = -2; /* default on */
 
 	options = parse_options_dup(checkout_options);
 	options = add_common_options(&opts, options);
@@ -1580,6 +1636,10 @@ int cmd_restore(int argc, const char **argv, const char *prefix)
 	struct option restore_options[] = {
 		OPT_STRING('s', "source", &opts.from_treeish, "<tree-ish>",
 			   N_("where the checkout from")),
+		OPT_BOOL('I', "index", &opts.checkout_index,
+			   N_("restore the index")),
+		OPT_BOOL('W', "worktree", &opts.checkout_worktree,
+			   N_("restore the working tree (default)")),
 		OPT_BOOL(0, "overlay", &opts.overlay_mode, N_("use overlay mode")),
 		OPT_END()
 	};
@@ -1590,6 +1650,8 @@ int cmd_restore(int argc, const char **argv, const char *prefix)
 	opts.accept_pathspec = 1;
 	opts.empty_pathspec_ok = 0;
 	opts.overlay_mode = 0;
+	opts.checkout_index = -1;    /* default off */
+	opts.checkout_worktree = -2; /* default on */
 
 	options = parse_options_dup(restore_options);
 	options = add_common_options(&opts, options);
-- 
2.21.0.rc1.337.gdf7f8d0522

