Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E0E6820248
	for <e@80x24.org>; Thu, 11 Apr 2019 13:13:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726720AbfDKNNN (ORCPT <rfc822;e@80x24.org>);
        Thu, 11 Apr 2019 09:13:13 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:36347 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726712AbfDKNNM (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 Apr 2019 09:13:12 -0400
Received: by mail-pl1-f193.google.com with SMTP id ck15so3411571plb.3
        for <git@vger.kernel.org>; Thu, 11 Apr 2019 06:13:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=G628sN+0owUKw9+Ztrgr1eUvTlZBmLBFDTWnLWezPdE=;
        b=twDE5/fp7zFaZ9aRuyEoJdAs+A6SEBIUudH4NmMuxQ0nQ5RoawTMpw8gPx4K9ewjZU
         zMqAzt4kChRSIPfpUsoTYmgP5xQIjcqyDFKQtpJIj/02lFWRriL9uNSh2kcpV8jh5Vp8
         72FiGpSeuaZXVUYhK7pbpK3W71fxgF27eETebH09lkAmV5+tTdGaA/Tg1bSieKGmcJ0J
         wCsNjzfCRWSUYXxt/o97dq9Er5nyqV7eouOv/zJuux2TfbDkSQqCBnQDwR95Ml1r9GWc
         g6vt+WpweTlC7SSVneCqUZF4lOIGyCiWbuhWiOegGRKx8SbigC+7wY1yoo+mKi3zTMZ9
         EipQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=G628sN+0owUKw9+Ztrgr1eUvTlZBmLBFDTWnLWezPdE=;
        b=dVY59tzLIxB+7orqYcYTVmFv8Uw4+rSx1RvLUy2+yjvlPk4PgU32RCcuZPoigBMGwl
         7qLKAMXnN+DCjmWYD2hFUlJGVfsWK87Ts4M0l1efzcKvyZ8k5BjiWfLNxL1TsU3qaGvT
         qyY5QGaYYYSWyYx8x3mmtdmf91YqIyVghRUOqnIjqfynmZ3HwX4rJOnTn1xvIBw3UFzv
         sqT4a/EYdw20gRs1IUimSpwEjwrljB9UF+yPDxBEaVC4s0wGqRM+SYdSgyM+tClQkpQl
         ejPR8C9w+3PnSsrI3F8mLs6BLd3x58to8Whx+gRmyIczm8EkyBZPk+bdm+miYKYaC0Q3
         blgA==
X-Gm-Message-State: APjAAAV46AWSBuBx5IX1arQ35PaI31nF0mBohJYyNRBxOsAsHMOpzV8i
        Qj1fnv+NE34ZV7x4OvMxQf4=
X-Google-Smtp-Source: APXvYqyos+GUoztGw9Kle0AD1HgDacDX5NCqwIQpSwbnSBYTHTZeC+gh2pq7GpxssCnod7Yuj4Y7Zg==
X-Received: by 2002:a17:902:4681:: with SMTP id p1mr49877596pld.42.1554988391925;
        Thu, 11 Apr 2019 06:13:11 -0700 (PDT)
Received: from ash ([116.102.217.71])
        by smtp.gmail.com with ESMTPSA id b2sm48005015pfo.150.2019.04.11.06.13.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 11 Apr 2019 06:13:11 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Thu, 11 Apr 2019 20:13:06 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     git@vger.kernel.org, gitster@pobox.com, newren@gmail.com,
        Eric Sunshine <sunshine@sunshineco.com>, rybak.a.v@gmail.com,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        jacob.keller@gmail.com
Subject: [PATCH v2 06/16] restore: add --worktree and --staged
Date:   Thu, 11 Apr 2019 20:12:08 +0700
Message-Id: <20190411131218.19195-7-pclouds@gmail.com>
X-Mailer: git-send-email 2.21.0.682.g30d2204636
In-Reply-To: <20190411131218.19195-1-pclouds@gmail.com>
References: <20190308101655.9767-1-pclouds@gmail.com>
 <20190411131218.19195-1-pclouds@gmail.com>
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

    git restore --staged --source=<tree> <path>  (1)

or update both with

    git restore --staged --worktree --source=<tree> <path> (2)

PS. Orignally I wanted to make worktree update default and form (1)
would add index update while also updating the worktree, and the user
would need to do "--staged --no-worktree" to update index only. But it
looks really confusing that "--staged" option alone updates both. So
now form (2) is used for both, which reads much more obvious.

PPS. Yes form (1) overlaps with "git reset <rev> <path>". I don't know
if we can ever turn "git reset" back to "_always_ reset HEAD and
optionally do something else".

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 builtin/checkout.c | 74 ++++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 68 insertions(+), 6 deletions(-)

diff --git a/builtin/checkout.c b/builtin/checkout.c
index 1753c8c5ed..e855c64cfe 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -66,6 +66,8 @@ struct checkout_opts {
 	int can_switch_when_in_progress;
 	int orphan_from_empty_tree;
 	int empty_pathspec_ok;
+	int checkout_index;
+	int checkout_worktree;
 
 	const char *new_branch;
 	const char *new_branch_force;
@@ -397,6 +399,7 @@ static int checkout_paths(const struct checkout_opts *opts,
 	struct commit *head;
 	int errs = 0;
 	struct lock_file lock_file = LOCK_INIT;
+	int checkout_index;
 
 	trace2_cmd_mode(opts->patch_mode ? "patch" : "path");
 
@@ -422,9 +425,26 @@ static int checkout_paths(const struct checkout_opts *opts,
 		die(_("Cannot update paths and switch to branch '%s' at the same time."),
 		    opts->new_branch);
 
-	if (opts->patch_mode)
-		return run_add_interactive(revision, "--patch=checkout",
-					   &opts->pathspec);
+	if (!opts->checkout_worktree && !opts->checkout_index)
+		die(_("neither '%s' or '%s' is specified"),
+		    "--staged", "--worktree");
+
+	if (!opts->checkout_worktree && !opts->from_treeish)
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
@@ -482,10 +502,30 @@ static int checkout_paths(const struct checkout_opts *opts,
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
@@ -1461,6 +1501,20 @@ static int checkout_main(int argc, const char **argv, const char *prefix,
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
@@ -1617,6 +1671,8 @@ int cmd_checkout(int argc, const char **argv, const char *prefix)
 	opts.orphan_from_empty_tree = 0;
 	opts.empty_pathspec_ok = 1;
 	opts.overlay_mode = -1;
+	opts.checkout_index = -2;    /* default on */
+	opts.checkout_worktree = -2; /* default on */
 
 	options = parse_options_dup(checkout_options);
 	options = add_common_options(&opts, options);
@@ -1674,6 +1730,10 @@ int cmd_restore(int argc, const char **argv, const char *prefix)
 	struct option restore_options[] = {
 		OPT_STRING('s', "source", &opts.from_treeish, "<tree-ish>",
 			   N_("where the checkout from")),
+		OPT_BOOL('S', "staged", &opts.checkout_index,
+			   N_("restore the index")),
+		OPT_BOOL('W', "worktree", &opts.checkout_worktree,
+			   N_("restore the working tree (default)")),
 		OPT_BOOL(0, "overlay", &opts.overlay_mode, N_("use overlay mode")),
 		OPT_END()
 	};
@@ -1684,6 +1744,8 @@ int cmd_restore(int argc, const char **argv, const char *prefix)
 	opts.accept_pathspec = 1;
 	opts.empty_pathspec_ok = 0;
 	opts.overlay_mode = 0;
+	opts.checkout_index = -1;    /* default off */
+	opts.checkout_worktree = -2; /* default on */
 
 	options = parse_options_dup(restore_options);
 	options = add_common_options(&opts, options);
-- 
2.21.0.682.g30d2204636

