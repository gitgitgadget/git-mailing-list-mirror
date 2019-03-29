Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6AA4320248
	for <e@80x24.org>; Fri, 29 Mar 2019 10:42:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728934AbfC2KmW (ORCPT <rfc822;e@80x24.org>);
        Fri, 29 Mar 2019 06:42:22 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:46995 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728737AbfC2KmW (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 Mar 2019 06:42:22 -0400
Received: by mail-pl1-f195.google.com with SMTP id y6so840261pll.13
        for <git@vger.kernel.org>; Fri, 29 Mar 2019 03:42:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Jng9k8mPSNDwjdGIxZyGsqFgJTd/hPYf6YTwz+X3nW4=;
        b=UO9vHgYm3ro7IOfVaaX/slT+tfUPGvg7LLQzXbDvXvTdV3REIGrXmSTASM9dIlEj1D
         SqyG6o5MMoH/v93xTiCwBAP3xTUxeTGtCu71d1TbEgDhJlbpofsTbTOfV2CQT+YEm3I8
         NqJhPysV0NDRfljCV67fXa+SjQGqilyb3OrBPVM3KLQFYVaLvX0GIS2GSQ9XF3aisC4a
         Biam/prMJAZT2TUcgeQjkMtEU4SABfIux3qMwsITNSlWSizWRyq9jTGxZjQidZ8kbdKJ
         mGSmbQB3DKD+kR8wPtWM4L4mNGM2vxJrp+wphJpAuHKhGPvMcckM+8jbcea56K2OIniF
         xtjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Jng9k8mPSNDwjdGIxZyGsqFgJTd/hPYf6YTwz+X3nW4=;
        b=N2apCbW5hMO6Fg5AyIs3lt1MrCMlxqLMx3+thuJt6sQRgCPWv1iNicHCEYVooVuiQR
         i7Mz2nndlm32juaWMm4Xvd6cHfuOj8rMaOvQtcL7/27yJocCqCxsMITol0ee7yNxw4OO
         81LNnvAAJmikcQWAf1ElTJgAoUADzApXi5BkBUjqgd8/kAudyu+EIdBWPB1dvKUNNmU2
         o9vYgpznrHtuyj66zewXbUN7Gez0zv/hS+IeSHWMWkBeVADFbCvy/UJ7GGLgTcjIJFFE
         DfCFe/JTxCdBDv5+9lhtkyUk/KZkyW4qiF4ZH+p0Zq1bWOuUuir1S6exuPZzx7aJRozr
         oZZg==
X-Gm-Message-State: APjAAAUTP+waI3SauzekE8PVyBR87F6PBuIqgAm0VM4sHmItAkgxG/y9
        1/wtYS+XIUY6qhZX2X0aICI=
X-Google-Smtp-Source: APXvYqzQB7CKeRvxHsxkO9540uKisIwSXJZI1ytsSVm/nDsw37BqGibA37Fgvqf19roG+e7fxEbq2Q==
X-Received: by 2002:a17:902:bccc:: with SMTP id o12mr46135487pls.70.1553856141324;
        Fri, 29 Mar 2019 03:42:21 -0700 (PDT)
Received: from ash ([171.236.209.43])
        by smtp.gmail.com with ESMTPSA id 139sm3858756pfw.98.2019.03.29.03.42.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 29 Mar 2019 03:42:19 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Fri, 29 Mar 2019 17:42:13 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     eckhard.s.maass@googlemail.com, git@vger.kernel.org,
        gitster@pobox.com, jacob.keller@gmail.com, martin.agren@gmail.com,
        newren@gmail.com, phillip.wood123@gmail.com, rybak.a.v@gmail.com,
        sunshine@sunshineco.com, szeder.dev@gmail.com
Subject: [PATCH v6 24/27] switch: make --orphan switch to an empty tree
Date:   Fri, 29 Mar 2019 17:39:16 +0700
Message-Id: <20190329103919.15642-25-pclouds@gmail.com>
X-Mailer: git-send-email 2.21.0.479.g47ac719cd3
In-Reply-To: <20190329103919.15642-1-pclouds@gmail.com>
References: <20190321131655.15249-1-pclouds@gmail.com>
 <20190329103919.15642-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Switching and creating branches always involves knowing the
<start-point> to begin the new branch from. Sometimes, people want to
create a new branch that does not have any commits yet; --orphan is a
flag to allow that.

--orphan overrides the default of HEAD for <start-point> instead causing
us to start from an empty history with all tracked files removed from
the index and working tree. The use of --orphan is incompatible with
specifying a <start-point>.

A note on the implementation. An alternative is just create a dummy
commit in-core with empty tree and switch to it. But there's a chance
the commit's SHA-1 may end up somewhere permanent like reflog. It's best
to make sure "commit" pointer is NULL to avoid it.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 builtin/checkout.c | 39 +++++++++++++++++++++++++++++++--------
 1 file changed, 31 insertions(+), 8 deletions(-)

diff --git a/builtin/checkout.c b/builtin/checkout.c
index 5f100c1552..0351735c6e 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -58,6 +58,7 @@ struct checkout_opts {
 	int switch_branch_doing_nothing_is_ok;
 	int only_merge_on_switching_branches;
 	int can_switch_when_in_progress;
+	int orphan_from_empty_tree;
 
 	const char *new_branch;
 	const char *new_branch_force;
@@ -568,15 +569,21 @@ static int merge_working_tree(const struct checkout_opts *opts,
 {
 	int ret;
 	struct lock_file lock_file = LOCK_INIT;
+	struct tree *new_tree;
 
 	hold_locked_index(&lock_file, LOCK_DIE_ON_ERROR);
 	if (read_cache_preload(NULL) < 0)
 		return error(_("index file corrupt"));
 
 	resolve_undo_clear();
+	if (opts->new_orphan_branch && opts->orphan_from_empty_tree) {
+		if (new_branch_info->commit)
+			BUG("'switch --orphan' should never accept a commit as starting point");
+		new_tree = parse_tree_indirect(the_hash_algo->empty_tree);
+	} else
+		new_tree = get_commit_tree(new_branch_info->commit);
 	if (opts->discard_changes) {
-		ret = reset_tree(get_commit_tree(new_branch_info->commit),
-				 opts, 1, writeout_error);
+		ret = reset_tree(new_tree, opts, 1, writeout_error);
 		if (ret)
 			return ret;
 	} else {
@@ -614,7 +621,8 @@ static int merge_working_tree(const struct checkout_opts *opts,
 					   &old_branch_info->commit->object.oid :
 					   the_hash_algo->empty_tree);
 		init_tree_desc(&trees[0], tree->buffer, tree->size);
-		tree = parse_tree_indirect(&new_branch_info->commit->object.oid);
+		parse_tree(new_tree);
+		tree = new_tree;
 		init_tree_desc(&trees[1], tree->buffer, tree->size);
 
 		ret = unpack_trees(2, trees, &topts);
@@ -663,7 +671,7 @@ static int merge_working_tree(const struct checkout_opts *opts,
 			o.verbosity = 0;
 			work = write_tree_from_memory(&o);
 
-			ret = reset_tree(get_commit_tree(new_branch_info->commit),
+			ret = reset_tree(new_tree,
 					 opts, 1,
 					 writeout_error);
 			if (ret)
@@ -672,13 +680,13 @@ static int merge_working_tree(const struct checkout_opts *opts,
 			o.branch1 = new_branch_info->name;
 			o.branch2 = "local";
 			ret = merge_trees(&o,
-					  get_commit_tree(new_branch_info->commit),
+					  new_tree,
 					  work,
 					  get_commit_tree(old_branch_info->commit),
 					  &result);
 			if (ret < 0)
 				exit(128);
-			ret = reset_tree(get_commit_tree(new_branch_info->commit),
+			ret = reset_tree(new_tree,
 					 opts, 0,
 					 writeout_error);
 			strbuf_release(&o.obuf);
@@ -696,7 +704,7 @@ static int merge_working_tree(const struct checkout_opts *opts,
 	if (write_locked_index(&the_index, &lock_file, COMMIT_LOCK))
 		die(_("unable to write new index file"));
 
-	if (!opts->discard_changes && !opts->quiet)
+	if (!opts->discard_changes && !opts->quiet && new_branch_info->commit)
 		show_local_changes(&new_branch_info->commit->object, &opts->diff_options);
 
 	return 0;
@@ -897,7 +905,10 @@ static void orphaned_commit_warning(struct commit *old_commit, struct commit *ne
 	add_pending_object(&revs, object, oid_to_hex(&object->oid));
 
 	for_each_ref(add_pending_uninteresting_ref, &revs);
-	add_pending_oid(&revs, "HEAD", &new_commit->object.oid, UNINTERESTING);
+	if (new_commit)
+		add_pending_oid(&revs, "HEAD",
+				&new_commit->object.oid,
+				UNINTERESTING);
 
 	if (prepare_revision_walk(&revs))
 		die(_("internal error in revision walk"));
@@ -932,6 +943,14 @@ static int switch_branches(const struct checkout_opts *opts,
 	if (old_branch_info.path)
 		skip_prefix(old_branch_info.path, "refs/heads/", &old_branch_info.name);
 
+	if (opts->new_orphan_branch && opts->orphan_from_empty_tree) {
+		if (new_branch_info->name)
+			BUG("'switch --orphan' should never accept a commit as starting point");
+		new_branch_info->commit = NULL;
+		new_branch_info->name = "(empty)";
+		do_merge = 1;
+	}
+
 	if (!new_branch_info->name) {
 		new_branch_info->name = "HEAD";
 		new_branch_info->commit = old_branch_info.commit;
@@ -1268,6 +1287,8 @@ static int checkout_branch(struct checkout_opts *opts,
 	if (opts->new_orphan_branch) {
 		if (opts->track != BRANCH_TRACK_UNSPECIFIED)
 			die(_("'%s' cannot be used with '%s'"), "--orphan", "-t");
+		if (opts->orphan_from_empty_tree && new_branch_info->name)
+			die(_("'%s' cannot take <start-point>"), "--orphan");
 	} else if (opts->force_detach) {
 		if (opts->track != BRANCH_TRACK_UNSPECIFIED)
 			die(_("'%s' cannot be used with '%s'"), "--detach", "-t");
@@ -1553,6 +1574,7 @@ int cmd_checkout(int argc, const char **argv, const char *prefix)
 	opts.accept_pathspec = 1;
 	opts.implicit_detach = 1;
 	opts.can_switch_when_in_progress = 1;
+	opts.orphan_from_empty_tree = 0;
 
 	options = parse_options_dup(checkout_options);
 	options = add_common_options(&opts, options);
@@ -1589,6 +1611,7 @@ int cmd_switch(int argc, const char **argv, const char *prefix)
 	opts.only_merge_on_switching_branches = 1;
 	opts.implicit_detach = 0;
 	opts.can_switch_when_in_progress = 0;
+	opts.orphan_from_empty_tree = 1;
 
 	options = parse_options_dup(switch_options);
 	options = add_common_options(&opts, options);
-- 
2.21.0.479.g47ac719cd3

