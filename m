Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7CBAD20248
	for <e@80x24.org>; Sun, 17 Mar 2019 12:52:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727335AbfCQMwB (ORCPT <rfc822;e@80x24.org>);
        Sun, 17 Mar 2019 08:52:01 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:41174 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726204AbfCQMwB (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 17 Mar 2019 08:52:01 -0400
Received: by mail-pg1-f196.google.com with SMTP id k11so9492893pgb.8
        for <git@vger.kernel.org>; Sun, 17 Mar 2019 05:52:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rTv1lAnUM4dZ7BGgNNiEZzjUzWLUvViqr8DVMI2hwWk=;
        b=OZQ/uCO/u5nPTgvSKR9pqnTeG7hH2BKET+w4eD4SoawIjlBMvZWILmQeIQumQwD6Qk
         zqsoubhbCtLmJazAeE7H+VBEh+prYYKp9UApdjK8j9j1v2YEJE/gGe81voYinEGstk9m
         71Nq0nUsjn6dNHCch62lun2+rlnAD4Wxx90X9ahS0umtSoufJ97ivZf+RGmhsOxumb2/
         OHMTforcwhEzkfyXkJEj9rfXrqIWYmRr34BxtCYawYcyBBRnqZS4Cgx5nvRAu7StCBwj
         c0BHPYqbiz0g4qaDnjXKmpRcc3hio2N7MwjYGFdaxINayR+vwZvDBsw5YpPtlgb6njl6
         jlYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rTv1lAnUM4dZ7BGgNNiEZzjUzWLUvViqr8DVMI2hwWk=;
        b=f4gNfNc2vhW50UjOsVDIcRi6KDFrnuAx5Nj7F47+5IM2xTzrvsyUX/t1ljZCWWN3y6
         baTrzbVuUm1y3ASs1F6sZLJLdPzNvTP/Pf839B73G9e+se17thjWWNRkZYCG0LpEKhVV
         vuWCfOQXzTtMXibiinK903zdPx4Mf15bu8UrltX7Q3/lCu+GyjeUNsVKOZrtT7W8DS2d
         REA9RuPzQoU1KNDXo/YtP6vGULB2LY+0CV5lNmKs/PPH4RIyXD9/lBlUJL33OqQLTCIE
         oCRy/MpmyM15Reen0vFkHJ1g2YtRe1QoL0dbcjExOJd+msKCMhq3qvzQa5Cv7QuAJhv+
         Xx0w==
X-Gm-Message-State: APjAAAWl2qfQWXlkbO9Z8BKiH9N+XoSRoVgFuLv0X92ysQYhybF/nFWB
        WQ78uzzj2j7R/m91GDZY4ds=
X-Google-Smtp-Source: APXvYqwM45Abpp5R5l+UiP+e2cRvL+yyYe26B/SpacLhyQeOjTDe3RVCm9331b+Kzg8Zi3+8XroVkQ==
X-Received: by 2002:a63:c042:: with SMTP id z2mr12859924pgi.307.1552827120205;
        Sun, 17 Mar 2019 05:52:00 -0700 (PDT)
Received: from ash ([171.226.148.85])
        by smtp.gmail.com with ESMTPSA id b138sm12551740pfb.48.2019.03.17.05.51.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 17 Mar 2019 05:51:59 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Sun, 17 Mar 2019 19:51:54 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     git@vger.kernel.org, gitster@pobox.com, sunshine@sunshineco.com,
        szeder.dev@gmail.com, Elijah Newren <newren@gmail.com>,
        eckhard.s.maass@googlemail.com,
        =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>,
        jacob.keller@gmail.com, phillip.wood123@gmail.com,
        rybak.a.v@gmail.com
Subject: [PATCH v4 23/26] switch: --orphan defaults to empty tree as HEAD
Date:   Sun, 17 Mar 2019 19:49:23 +0700
Message-Id: <20190317124926.17137-24-pclouds@gmail.com>
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

Switching and creating branches always involves knowing the
<start-point> to begin the new branch from. Sometimes, people want to
create a new branch that does not have any commits yet; --orphan is a
flag to allow that.

If <start-point> is not specified, instead of leaving index/worktree
unchanged, default to "empty tree" starting point, allowing a clean
start.

A note on the implementation. An alternative is just create a dummy
commit in-core with empty tree and switch to it. But there's a chance
the commit's SHA-1 may end up somewhere permanent like reflog. It's best
to make sure "commit" pointer is NULL to avoid it.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 builtin/checkout.c | 33 +++++++++++++++++++++++++--------
 1 file changed, 25 insertions(+), 8 deletions(-)

diff --git a/builtin/checkout.c b/builtin/checkout.c
index 21a585eaa9..f0d6207236 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -58,6 +58,7 @@ struct checkout_opts {
 	int switch_branch_doing_nothing_is_ok;
 	int only_merge_on_switching_branches;
 	int can_switch_when_in_progress;
+	int orphan_default_empty_tree;
 
 	const char *new_branch;
 	const char *new_branch_force;
@@ -568,15 +569,19 @@ static int merge_working_tree(const struct checkout_opts *opts,
 {
 	int ret;
 	struct lock_file lock_file = LOCK_INIT;
+	struct tree *new_tree;
 
 	hold_locked_index(&lock_file, LOCK_DIE_ON_ERROR);
 	if (read_cache_preload(NULL) < 0)
 		return error(_("index file corrupt"));
 
 	resolve_undo_clear();
+	if (opts->orphan_default_empty_tree && !new_branch_info->commit)
+		new_tree = parse_tree_indirect(the_hash_algo->empty_tree);
+	else
+		new_tree = get_commit_tree(new_branch_info->commit);
 	if (opts->discard_changes) {
-		ret = reset_tree(get_commit_tree(new_branch_info->commit),
-				 opts, 1, writeout_error);
+		ret = reset_tree(new_tree, opts, 1, writeout_error);
 		if (ret)
 			return ret;
 	} else {
@@ -614,7 +619,8 @@ static int merge_working_tree(const struct checkout_opts *opts,
 					   &old_branch_info->commit->object.oid :
 					   the_hash_algo->empty_tree);
 		init_tree_desc(&trees[0], tree->buffer, tree->size);
-		tree = parse_tree_indirect(&new_branch_info->commit->object.oid);
+		parse_tree(new_tree);
+		tree = new_tree;
 		init_tree_desc(&trees[1], tree->buffer, tree->size);
 
 		ret = unpack_trees(2, trees, &topts);
@@ -663,7 +669,7 @@ static int merge_working_tree(const struct checkout_opts *opts,
 			o.verbosity = 0;
 			work = write_tree_from_memory(&o);
 
-			ret = reset_tree(get_commit_tree(new_branch_info->commit),
+			ret = reset_tree(new_tree,
 					 opts, 1,
 					 writeout_error);
 			if (ret)
@@ -672,13 +678,13 @@ static int merge_working_tree(const struct checkout_opts *opts,
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
@@ -696,7 +702,7 @@ static int merge_working_tree(const struct checkout_opts *opts,
 	if (write_locked_index(&the_index, &lock_file, COMMIT_LOCK))
 		die(_("unable to write new index file"));
 
-	if (!opts->discard_changes && !opts->quiet)
+	if (!opts->discard_changes && !opts->quiet && new_branch_info->commit)
 		show_local_changes(&new_branch_info->commit->object, &opts->diff_options);
 
 	return 0;
@@ -897,7 +903,10 @@ static void orphaned_commit_warning(struct commit *old_commit, struct commit *ne
 	add_pending_object(&revs, object, oid_to_hex(&object->oid));
 
 	for_each_ref(add_pending_uninteresting_ref, &revs);
-	add_pending_oid(&revs, "HEAD", &new_commit->object.oid, UNINTERESTING);
+	if (new_commit)
+		add_pending_oid(&revs, "HEAD",
+				&new_commit->object.oid,
+				UNINTERESTING);
 
 	if (prepare_revision_walk(&revs))
 		die(_("internal error in revision walk"));
@@ -941,6 +950,12 @@ static int switch_branches(const struct checkout_opts *opts,
 
 		if (opts->only_merge_on_switching_branches)
 			do_merge = 0;
+
+		if (opts->new_orphan_branch && opts->orphan_default_empty_tree) {
+			new_branch_info->commit = NULL;
+			new_branch_info->name = "(empty)";
+			do_merge = 1;
+		}
 	}
 
 	if (do_merge) {
@@ -1537,6 +1552,7 @@ int cmd_checkout(int argc, const char **argv, const char *prefix)
 	opts.accept_pathspec = 1;
 	opts.implicit_detach = 1;
 	opts.can_switch_when_in_progress = 1;
+	opts.orphan_default_empty_tree = 0;
 
 	options = parse_options_dup(checkout_options);
 	options = add_common_options(&opts, options);
@@ -1575,6 +1591,7 @@ int cmd_switch(int argc, const char **argv, const char *prefix)
 	opts.only_merge_on_switching_branches = 1;
 	opts.implicit_detach = 0;
 	opts.can_switch_when_in_progress = 0;
+	opts.orphan_default_empty_tree = 1;
 
 	options = parse_options_dup(switch_options);
 	options = add_common_options(&opts, options);
-- 
2.21.0.548.gd3c7d92dc2

