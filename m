Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3355720248
	for <e@80x24.org>; Thu, 21 Mar 2019 13:19:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728457AbfCUNTv (ORCPT <rfc822;e@80x24.org>);
        Thu, 21 Mar 2019 09:19:51 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:40222 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728289AbfCUNTu (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Mar 2019 09:19:50 -0400
Received: by mail-pf1-f195.google.com with SMTP id c207so4277772pfc.7
        for <git@vger.kernel.org>; Thu, 21 Mar 2019 06:19:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NF4T0KM1A7oFLsnsYN/Zh0AALEeT2ceVEklvLiLG86k=;
        b=SpKq4h7MbF1QVT4083HEDNRRNUL6dOUvDUCoMqdsh2D2znfLCWfAUSPLbpqZVnlhQZ
         pPHM0koXzksfg9DD4zohGe3qqEXTaJCYot/J2hbPItM/Q/F+q9L6flb/LZvMVqoBH5Jg
         gnXfhGX8wLT1MdupqnB3UtNSVFB6kwdyvBwzf4WcpyBpbYVtvAU+JAzaLQTMwKpQ2trG
         siS+45OKxJyvnf/Enb1lumqzHdlj79HtWZzJS2CcdLON3Vaanlp8O9tuIdMMg7I/DT5N
         jUDF6EWwE307apDpLPFMfAeE63UHRCOxi59uy0zpYNRPXKwfyfhTxlihBDwVHaXFY0Oz
         luUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NF4T0KM1A7oFLsnsYN/Zh0AALEeT2ceVEklvLiLG86k=;
        b=X1b9t5neIcnPrNQXTg3WA6il4KKfqp7EUPljzEerZftEnDTy8Cx8geW4EtPGGMdAGP
         WkYttaNolNX4EGQxPM10/Sl2V4J6yULzRD/YvbyZFkprZY6vnkNnbMmaKH3Bo/hwhm7N
         GF+r1OXF5mVNn9GC51GSMcBv8txZRRk0w42y2q1Sq7n5wg2rCsd2v9UNLB7tqhK3l2UD
         567hAmQPB4xYyJlqGaKgv55dTuHntLHrGgWNtI17qm5G6qtCOryEUi6NyTShiIAJ6x5Y
         2564PfzBv7EOFkiNbdEbI4LCqj9qfYny6s8HdBrI3SmnuigAzLFBhTqq/4AH4WapCkPf
         jcNg==
X-Gm-Message-State: APjAAAUm3cliE76JRrRnVqxiZ10Myr98Uk5i7nBMe3htFpXeoV4QlZLW
        hsQ55Ryku4jWoxi5cWGPTok=
X-Google-Smtp-Source: APXvYqzSwO1+NsuHo/8jIxdqMSFW2xJ3F31gvMfuba5b0pIXmGk60v4CM/rmz6PQLbGiGoPv6rNZIA==
X-Received: by 2002:a17:902:2903:: with SMTP id g3mr3501093plb.222.1553174389733;
        Thu, 21 Mar 2019 06:19:49 -0700 (PDT)
Received: from ash ([171.226.148.85])
        by smtp.gmail.com with ESMTPSA id p6sm11126769pgd.69.2019.03.21.06.19.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 Mar 2019 06:19:48 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Thu, 21 Mar 2019 20:19:43 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     eckhard.s.maass@googlemail.com, git@vger.kernel.org,
        gitster@pobox.com, jacob.keller@gmail.com, martin.agren@gmail.com,
        newren@gmail.com, phillip.wood123@gmail.com, rybak.a.v@gmail.com,
        sunshine@sunshineco.com, szeder.dev@gmail.com
Subject: [PATCH v5 23/26] switch: make --orphan switch to an empty tree
Date:   Thu, 21 Mar 2019 20:16:52 +0700
Message-Id: <20190321131655.15249-24-pclouds@gmail.com>
X-Mailer: git-send-email 2.21.0.548.gd3c7d92dc2
In-Reply-To: <20190321131655.15249-1-pclouds@gmail.com>
References: <20190317124926.17137-1-pclouds@gmail.com>
 <20190321131655.15249-1-pclouds@gmail.com>
MIME-Version: 1.0
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
---
 builtin/checkout.c | 39 +++++++++++++++++++++++++++++++--------
 1 file changed, 31 insertions(+), 8 deletions(-)

diff --git a/builtin/checkout.c b/builtin/checkout.c
index 407ed8be94..c7f4b5e3c0 100644
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
@@ -1235,6 +1254,8 @@ static int checkout_branch(struct checkout_opts *opts,
 	if (opts->new_orphan_branch) {
 		if (opts->track != BRANCH_TRACK_UNSPECIFIED)
 			die(_("'%s' cannot be used with '%s'"), "--orphan", "-t");
+		if (opts->orphan_from_empty_tree && new_branch_info->name)
+			die(_("'%s' cannot take <start-point>"), "--orphan");
 	} else if (opts->force_detach) {
 		if (opts->track != BRANCH_TRACK_UNSPECIFIED)
 			die(_("'%s' cannot be used with '%s'"), "--detach", "-t");
@@ -1539,6 +1560,7 @@ int cmd_checkout(int argc, const char **argv, const char *prefix)
 	opts.accept_pathspec = 1;
 	opts.implicit_detach = 1;
 	opts.can_switch_when_in_progress = 1;
+	opts.orphan_from_empty_tree = 0;
 
 	options = parse_options_dup(checkout_options);
 	options = add_common_options(&opts, options);
@@ -1577,6 +1599,7 @@ int cmd_switch(int argc, const char **argv, const char *prefix)
 	opts.only_merge_on_switching_branches = 1;
 	opts.implicit_detach = 0;
 	opts.can_switch_when_in_progress = 0;
+	opts.orphan_from_empty_tree = 1;
 
 	options = parse_options_dup(switch_options);
 	options = add_common_options(&opts, options);
-- 
2.21.0.548.gd3c7d92dc2

