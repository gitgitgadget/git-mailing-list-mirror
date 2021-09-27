Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A331C433EF
	for <git@archiver.kernel.org>; Mon, 27 Sep 2021 16:34:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 533966108E
	for <git@archiver.kernel.org>; Mon, 27 Sep 2021 16:34:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235582AbhI0QgC (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 27 Sep 2021 12:36:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235514AbhI0Qfl (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Sep 2021 12:35:41 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 248C1C061604
        for <git@vger.kernel.org>; Mon, 27 Sep 2021 09:33:55 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id v127so1028217wme.5
        for <git@vger.kernel.org>; Mon, 27 Sep 2021 09:33:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=aA0MYltKQxVCDDNWaQYZRR4lnBogMvPxAtvTgr89s84=;
        b=T1sbKpOswU2fYIKftPA0g+FzIaAi+7SBLXw2cCAwNZIcneQGdN6yGL7h3nRxiE8har
         GfmIRfOs8hRFqAVfi+095GBXGUTkcJg2DHjL65OHy8fKcBVwMp0cTyIVCm/bZKNfPUCL
         U+y6bQBcOECOWfW71zOcJ7YbBNuz8jtB3Xz1HTprBSoO1QAeT9KM5OoGGq9/B3PRyq61
         Rj9LfPLZitvbgz8TM+PldLjxHLc/1LKTvsFBzoOHu2mmgW8c2VRW09B7FlyBdMKD47Wd
         aF1uTdXNMNvCkzVsOQ57xIXnCtrXZHN+qdUjQqzASeUzPAZTbw61bQTh9yySqRPt0maa
         XcgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=aA0MYltKQxVCDDNWaQYZRR4lnBogMvPxAtvTgr89s84=;
        b=nX+f3Y7obG9yoS9GUgWtB6CiayuUb9tbQ724j09MqN7ZF70uvRSjqMuunUu1egwKnX
         Hrh8BCL8fit+lsjDcezdzaiyKPk0MZ11s9l1SK/+kI2n2w+MiDpMmzICNzCpv645epIZ
         KxVOC9VGg5sbCCVE1LJ/BWJSdGOmHrdLSEkWshUMXSYGKP6dZglCUh1pBASEHtdvHjH+
         joSrY/e+f4UwZQ1e3+HKd5SyLelUpwfJCsqFikd/LxmAJW5VvxoemeNPA2sze6G7xgC7
         Qc7oQjRkjUi2yEOTKCkeIX3Clc2O1YkSAhyrZ8xCByrbW4O2F7sjnqNOY0gi/i58Vi/Y
         mu6w==
X-Gm-Message-State: AOAM531UWRYeazBczROZE27QqRZP2m/M5i2ljKRRzMEJZxFQYA/wsm/T
        WPulG006E/DCYFp0L8WBFBNR7iyuG5c=
X-Google-Smtp-Source: ABdhPJyUkGURzGVll/TDrN9mtpQBAM1nArSJRJUsiz/H9R7ACWZ5FwFT4ecIL0KfRirOmqG7iF8bFQ==
X-Received: by 2002:a7b:c08e:: with SMTP id r14mr6974988wmh.161.1632760433579;
        Mon, 27 Sep 2021 09:33:53 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id h18sm17052447wrb.33.2021.09.27.09.33.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Sep 2021 09:33:53 -0700 (PDT)
Message-Id: <9eb20121fc3886436cef91670e32217466d03ba7.1632760428.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1036.v3.git.1632760428.gitgitgadget@gmail.com>
References: <pull.1036.v2.git.1632465429.gitgitgadget@gmail.com>
        <pull.1036.v3.git.1632760428.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 27 Sep 2021 16:33:44 +0000
Subject: [PATCH v3 07/11] Change unpack_trees' 'reset' flag into an enum
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Fedor Biryukov <fedor.birjukov@gmail.com>,
        Philip Oakley <philipoakley@iee.email>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

Traditionally, unpack_trees_options->reset was used to signal that it
was okay to delete any untracked files in the way.  This was used by
`git read-tree --reset`, but then started appearing in other places as
well.  However, many of the other uses should not be deleting untracked
files in the way.  Change this value to an enum so that a value of 1
(i.e. "true") can be split into two:
   UNPACK_RESET_PROTECT_UNTRACKED,
   UNPACK_RESET_OVERWRITE_UNTRACKED
In order to catch accidental misuses (i.e. where folks call it the way
they traditionally used to), define the special enum value of
   UNPACK_RESET_INVALID = 1
which will trigger a BUG().

Modify existing callers so that
   read-tree --reset
   reset --hard
   checkout --force
continue using the UNPACK_RESET_OVERWRITE_UNTRACKED logic, while other
callers, including
   am
   checkout without --force
   stash  (though currently dead code; reset always had a value of 0)
   numerous callers from rebase/sequencer to reset_head()
will use the new UNPACK_RESET_PROTECT_UNTRACKED value.

Also, note that it has been reported that 'git checkout <treeish>
<pathspec>' currently also allows overwriting untracked files[1].  That
case should also be fixed, but it does not use unpack_trees() and thus
is outside the scope of the current changes.

[1] https://lore.kernel.org/git/15dad590-087e-5a48-9238-5d2826950506@gmail.com/

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 builtin/am.c                     |  5 ++---
 builtin/checkout.c               |  5 +++--
 builtin/read-tree.c              |  3 +++
 builtin/reset.c                  |  9 +++++++--
 builtin/stash.c                  |  4 ++--
 reset.c                          |  2 +-
 t/t2500-untracked-overwriting.sh |  6 +++---
 unpack-trees.c                   | 10 +++++++++-
 unpack-trees.h                   | 11 +++++++++--
 9 files changed, 39 insertions(+), 16 deletions(-)

diff --git a/builtin/am.c b/builtin/am.c
index 57738eff0c5..f296226e95f 100644
--- a/builtin/am.c
+++ b/builtin/am.c
@@ -1917,9 +1917,8 @@ static int fast_forward_to(struct tree *head, struct tree *remote, int reset)
 	opts.dst_index = &the_index;
 	opts.update = 1;
 	opts.merge = 1;
-	opts.reset = reset;
-	if (!reset)
-		opts.preserve_ignored = 0; /* FIXME: !overwrite_ignore */
+	opts.reset = reset ? UNPACK_RESET_PROTECT_UNTRACKED : 0;
+	opts.preserve_ignored = 0; /* FIXME: !overwrite_ignore */
 	opts.fn = twoway_merge;
 	init_tree_desc(&t[0], head->buffer, head->size);
 	init_tree_desc(&t[1], remote->buffer, remote->size);
diff --git a/builtin/checkout.c b/builtin/checkout.c
index 5e7957dd068..cbf73b8c9f6 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -646,9 +646,10 @@ static int reset_tree(struct tree *tree, const struct checkout_opts *o,
 	opts.head_idx = -1;
 	opts.update = worktree;
 	opts.skip_unmerged = !worktree;
-	opts.reset = 1;
+	opts.reset = o->force ? UNPACK_RESET_OVERWRITE_UNTRACKED :
+				UNPACK_RESET_PROTECT_UNTRACKED;
+	opts.preserve_ignored = (!o->force && !o->overwrite_ignore);
 	opts.merge = 1;
-	opts.preserve_ignored = 0;
 	opts.fn = oneway_merge;
 	opts.verbose_update = o->show_progress;
 	opts.src_index = &the_index;
diff --git a/builtin/read-tree.c b/builtin/read-tree.c
index 443d206eca6..2109c4c9e5c 100644
--- a/builtin/read-tree.c
+++ b/builtin/read-tree.c
@@ -166,6 +166,9 @@ int cmd_read_tree(int argc, const char **argv, const char *cmd_prefix)
 	if (1 < opts.merge + opts.reset + prefix_set)
 		die("Which one? -m, --reset, or --prefix?");
 
+	if (opts.reset)
+		opts.reset = UNPACK_RESET_OVERWRITE_UNTRACKED;
+
 	/*
 	 * NEEDSWORK
 	 *
diff --git a/builtin/reset.c b/builtin/reset.c
index 5df01cc42e0..73935953494 100644
--- a/builtin/reset.c
+++ b/builtin/reset.c
@@ -71,9 +71,14 @@ static int reset_index(const char *ref, const struct object_id *oid, int reset_t
 		break;
 	case HARD:
 		opts.update = 1;
-		/* fallthrough */
+		opts.reset = UNPACK_RESET_OVERWRITE_UNTRACKED;
+		break;
+	case MIXED:
+		opts.reset = UNPACK_RESET_PROTECT_UNTRACKED;
+		/* but opts.update=0, so working tree not updated */
+		break;
 	default:
-		opts.reset = 1;
+		BUG("invalid reset_type passed to reset_index");
 	}
 
 	read_cache_unmerged();
diff --git a/builtin/stash.c b/builtin/stash.c
index d60cdaf32f5..0e3662a230c 100644
--- a/builtin/stash.c
+++ b/builtin/stash.c
@@ -256,9 +256,9 @@ static int reset_tree(struct object_id *i_tree, int update, int reset)
 	opts.src_index = &the_index;
 	opts.dst_index = &the_index;
 	opts.merge = 1;
-	opts.reset = reset;
+	opts.reset = reset ? UNPACK_RESET_PROTECT_UNTRACKED : 0;
 	opts.update = update;
-	if (update && !reset)
+	if (update)
 		opts.preserve_ignored = 0; /* FIXME: !overwrite_ignore */
 	opts.fn = oneway_merge;
 
diff --git a/reset.c b/reset.c
index f40a8ecf663..f214df3d96c 100644
--- a/reset.c
+++ b/reset.c
@@ -59,7 +59,7 @@ int reset_head(struct repository *r, struct object_id *oid, const char *action,
 	unpack_tree_opts.preserve_ignored = 0; /* FIXME: !overwrite_ignore */
 	init_checkout_metadata(&unpack_tree_opts.meta, switch_to_branch, oid, NULL);
 	if (!detach_head)
-		unpack_tree_opts.reset = 1;
+		unpack_tree_opts.reset = UNPACK_RESET_PROTECT_UNTRACKED;
 
 	if (repo_read_index_unmerged(r) < 0) {
 		ret = error(_("could not read index"));
diff --git a/t/t2500-untracked-overwriting.sh b/t/t2500-untracked-overwriting.sh
index 2412d121ea8..18604360df8 100755
--- a/t/t2500-untracked-overwriting.sh
+++ b/t/t2500-untracked-overwriting.sh
@@ -92,7 +92,7 @@ test_setup_checkout_m () {
 	)
 }
 
-test_expect_failure 'checkout -m does not nuke untracked file' '
+test_expect_success 'checkout -m does not nuke untracked file' '
 	test_setup_checkout_m &&
 	(
 		cd checkout &&
@@ -138,7 +138,7 @@ test_setup_sequencing () {
 	)
 }
 
-test_expect_failure 'git rebase --abort and untracked files' '
+test_expect_success 'git rebase --abort and untracked files' '
 	test_setup_sequencing rebase_abort_and_untracked &&
 	(
 		cd sequencing_rebase_abort_and_untracked &&
@@ -155,7 +155,7 @@ test_expect_failure 'git rebase --abort and untracked files' '
 	)
 '
 
-test_expect_failure 'git rebase fast forwarding and untracked files' '
+test_expect_success 'git rebase fast forwarding and untracked files' '
 	test_setup_sequencing rebase_fast_forward_and_untracked &&
 	(
 		cd sequencing_rebase_fast_forward_and_untracked &&
diff --git a/unpack-trees.c b/unpack-trees.c
index e067cce0fcd..812e4c66713 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -1696,6 +1696,9 @@ int unpack_trees(unsigned len, struct tree_desc *t, struct unpack_trees_options
 	int free_pattern_list = 0;
 	struct dir_struct dir = DIR_INIT;
 
+	if (o->reset == UNPACK_RESET_INVALID)
+		BUG("o->reset had a value of 1; should be UNPACK_TREES_*_UNTRACKED");
+
 	if (len > MAX_UNPACK_TREES)
 		die("unpack_trees takes at most %d trees", MAX_UNPACK_TREES);
 	if (o->dir)
@@ -1710,6 +1713,10 @@ int unpack_trees(unsigned len, struct tree_desc *t, struct unpack_trees_options
 		ensure_full_index(o->dst_index);
 	}
 
+	if (o->reset == UNPACK_RESET_OVERWRITE_UNTRACKED &&
+	    o->preserve_ignored)
+		BUG("UNPACK_RESET_OVERWRITE_UNTRACKED incompatible with preserved ignored files");
+
 	if (!o->preserve_ignored) {
 		o->dir = &dir;
 		o->dir->flags |= DIR_SHOW_IGNORED;
@@ -2233,7 +2240,8 @@ static int verify_absent_1(const struct cache_entry *ce,
 	int len;
 	struct stat st;
 
-	if (o->index_only || o->reset || !o->update)
+	if (o->index_only || !o->update ||
+	    o->reset == UNPACK_RESET_OVERWRITE_UNTRACKED)
 		return 0;
 
 	len = check_leading_path(ce->name, ce_namelen(ce), 0);
diff --git a/unpack-trees.h b/unpack-trees.h
index 61da25dafee..71ffb7eeb0c 100644
--- a/unpack-trees.h
+++ b/unpack-trees.h
@@ -45,9 +45,15 @@ void setup_unpack_trees_porcelain(struct unpack_trees_options *opts,
  */
 void clear_unpack_trees_porcelain(struct unpack_trees_options *opts);
 
+enum unpack_trees_reset_type {
+	UNPACK_RESET_NONE = 0,    /* traditional "false" value; still valid */
+	UNPACK_RESET_INVALID = 1, /* "true" no longer valid; use below values */
+	UNPACK_RESET_PROTECT_UNTRACKED,
+	UNPACK_RESET_OVERWRITE_UNTRACKED
+};
+
 struct unpack_trees_options {
-	unsigned int reset,
-		     merge,
+	unsigned int merge,
 		     update,
 		     preserve_ignored,
 		     clone,
@@ -65,6 +71,7 @@ struct unpack_trees_options {
 		     exiting_early,
 		     show_all_errors,
 		     dry_run;
+	enum unpack_trees_reset_type reset;
 	const char *prefix;
 	int cache_bottom;
 	struct pathspec *pathspec;
-- 
gitgitgadget

