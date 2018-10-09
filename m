Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3C2501F97E
	for <e@80x24.org>; Tue,  9 Oct 2018 19:35:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727635AbeJJCxu (ORCPT <rfc822;e@80x24.org>);
        Tue, 9 Oct 2018 22:53:50 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:45834 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727365AbeJJCxt (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Oct 2018 22:53:49 -0400
Received: by mail-wr1-f65.google.com with SMTP id q5-v6so3078852wrw.12
        for <git@vger.kernel.org>; Tue, 09 Oct 2018 12:35:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BrYg18aC4qSavPIhHK6aGXOPkakGhmtIS5bR4onhJts=;
        b=dqAGvRNjHIB8lCm65mub7LAIgwbZFa+sbsmFsU/Ajam20oszrlvBtNutSJiE7XtQ2P
         lISU9yNHnhQx3ZHZeB0Q0Mz073xGtm4aJM5wXnKu+Nn9gGPrw0Ij0ouYbgHM0xu8avpk
         pSAA8dR+b6ZJDX72IFgafhCQEKGMaHFvIVmEVEcBfizFg756c1fSQfjDkMDhadHSQZ5E
         MnR2E9oZ66M4LJh0Jox6xeWsvycCA4yDRVepVnQP9aP5/YjDU6PzUM3l6bnsZhCm8H2b
         jT4wJDQih8LMcNBF8buofmG16LGoscsLcWD682jkEVqWbaTd+C90zV9lI+YoL41gNu1V
         vhJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BrYg18aC4qSavPIhHK6aGXOPkakGhmtIS5bR4onhJts=;
        b=hrdSlO9UqG1aB3fRnmOav8wsHTAY1dKArFMWtiNrvTi7vY//mvNWNdehkHJDNo12mo
         4JdjsVqW2bphO7ODAlgSPzPY9t9Lg1UVJ8sIDckWv9NjzmNfbnDP0Z6aweJU2IBmWHCI
         YZMyr7lE/XFk5ryMu9MHxA62vrEwyOjwdW1lzCGBsPZNgTP7fHSDANWsT230hiLcvcSh
         9ifJp/jGwqCAQTDB77EV5ao6kWay4xeXb/DBZ/XsxxCMAbTHtCb8ChU4Eqo0ViD4EhWD
         Pngw5Ob5YqGVKVzBgSp+bF2b5U+VWS1G7sR74wa239zFK5YGgKd9LvXqlbTSs65wL0/K
         QQLg==
X-Gm-Message-State: ABuFfoh4Y/pmmH21U1JvTMCPnB7UTuwY2XwGw/l1XsuzBDW35AQ001y5
        hVgl7YkSr3VR84f63TeNWN+DC96R
X-Google-Smtp-Source: ACcGV61WeCZcwkqIihlEM7zlyztelOoRUZ9e8P8VbYk9AQYpHdOUFVNUpX/QKmbKerSN9w3H2os+kA==
X-Received: by 2002:a05:6000:12c5:: with SMTP id l5mr20564619wrx.215.1539113716967;
        Tue, 09 Oct 2018 12:35:16 -0700 (PDT)
Received: from localhost.localdomain (x4dbd5132.dyn.telefonica.de. [77.189.81.50])
        by smtp.gmail.com with ESMTPSA id e6-v6sm18823117wrc.70.2018.10.09.12.35.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 09 Oct 2018 12:35:16 -0700 (PDT)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <stolee@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Stefan Beller <sbeller@google.com>,
        Duy Nguyen <pclouds@gmail.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH 3/4] revision.c: use the Bloom filter to speed up path-limited revision walks
Date:   Tue,  9 Oct 2018 21:34:44 +0200
Message-Id: <20181009193445.21908-4-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.19.1.409.g0a0ee5eb6b
In-Reply-To: <20181009193445.21908-1-szeder.dev@gmail.com>
References: <a66afe22-0523-c785-91e6-bf545683c67d@gmail.com>
 <20181009193445.21908-1-szeder.dev@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When $GIT_USE_POC_BLOOM_FILTER is set to a non-empty value, the
revision walk will use the Bloom filter to speed up a path-limited
revision walk.

Load the Bloom filter in prepare_revision_walk(); probably not the
best place for it, but it should suffice for experiementing with 'git
rev-list'.

Checking the Bloom filter is plugged into rev_compare_tree(), the
function that compares the given paths in a commit to one of its
parents.  If checking the Bloom filter returns that the interesting
paths did not change, then it won't bother with the running the
expensive diff.

Add a new field to 'struct pathspec' to hold the SHA of the path, so
that hash is computed only once and then reused when checking each
commit.
---
 pathspec.h |  1 +
 revision.c | 97 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 98 insertions(+)

diff --git a/pathspec.h b/pathspec.h
index a6525a6551..565a26d91e 100644
--- a/pathspec.h
+++ b/pathspec.h
@@ -47,6 +47,7 @@ struct pathspec {
 			} match_mode;
 		} *attr_match;
 		struct attr_check *attr_check;
+		unsigned char name_hash[GIT_MAX_RAWSZ];
 	} *items;
 };
 
diff --git a/revision.c b/revision.c
index c5d0cb6599..3565785ca6 100644
--- a/revision.c
+++ b/revision.c
@@ -27,6 +27,7 @@
 #include "commit-reach.h"
 #include "commit-graph.h"
 #include "prio-queue.h"
+#include "bloom-filter.h"
 
 volatile show_early_output_fn_t show_early_output;
 
@@ -463,6 +464,62 @@ static void file_change(struct diff_options *options,
 	options->flags.has_changes = 1;
 }
 
+/* Another static... */
+static struct bloom_filter bf;
+
+static int check_maybe_different_in_bloom_filter(struct rev_info *revs,
+						 struct commit *parent,
+						 struct commit *commit)
+{
+	unsigned char p_c_hash[GIT_MAX_RAWSZ];
+	int i;
+
+	if (!bf.bits)
+		return -1;
+	/*
+	 * If a commit is not in the 'commit-graph' file, then it's not in
+	 * the Bloom filter either, so any query into that would report
+	 * back a false negative, which is unacceptable.
+	 *
+	 * The writer of the Bloom filter must ensure that all commits that
+	 * go into the 'commit-graph' go into the Bloom filter as well.
+	 *
+	 * If we won't tie the Bloom filter to the commit-graph tightly,
+	 * then we'll have to come up with another means to prevent such
+	 * false negatives.
+	 */
+	if (!the_repository->objects->commit_graph)
+		return -1;
+	if (commit->generation == GENERATION_NUMBER_INFINITY)
+		return -1;
+
+	hashxor(parent->object.oid.hash, commit->object.oid.hash, p_c_hash);
+
+	for (i = 0; i < revs->pruning.pathspec.nr; i++) {
+		struct pathspec_item *pi = &revs->pruning.pathspec.items[i];
+		unsigned char hash[GIT_MAX_RAWSZ];
+
+		hashxor(pi->name_hash, p_c_hash, hash);
+		if (bloom_filter_check_hash(&bf, hash)) {
+			/*
+			 * At least one of the interesting pathspecs differs,
+			 * so we can return early and let the diff machinery
+			 * make sure that they indeed differ.
+			 *
+			 * Note: the diff machinery will look at all the given
+			 * paths; a possible future optimization might bring
+			 * the Bloom filter and the diff machinery closer to
+			 * each other, so the diff won't waste time looking
+			 * at those paths that the Bloom filter have found
+			 * unchanged.
+			 */
+			return 1;
+		}
+	}
+
+	return 0;
+}
+
 static int rev_compare_tree(struct rev_info *revs,
 			    struct commit *parent, struct commit *commit)
 {
@@ -492,6 +549,9 @@ static int rev_compare_tree(struct rev_info *revs,
 			return REV_TREE_SAME;
 	}
 
+	if (!check_maybe_different_in_bloom_filter(revs, parent, commit))
+		return REV_TREE_SAME;
+
 	tree_difference = REV_TREE_SAME;
 	revs->pruning.flags.has_changes = 0;
 	if (diff_tree_oid(&t1->object.oid, &t2->object.oid, "",
@@ -3106,6 +3166,40 @@ static void expand_topo_walk(struct rev_info *revs, struct commit *commit)
 	}
 }
 
+void prepare_to_use_bloom_filter(struct rev_info *revs)
+{
+	const char *env = getenv("GIT_USE_POC_BLOOM_FILTER");
+	int i;
+
+	if (!env || !*env)
+		return;
+
+	for (i = 0; i < revs->pruning.pathspec.nr; i++) {
+		struct pathspec_item *pi = &revs->pruning.pathspec.items[i];
+		const char *path = pi->match;
+		git_hash_ctx ctx;
+		size_t len = strlen(path);
+
+		/*
+		 * TODO: What about wildcards?  We'd probably just want to
+		 * ignore the Bloom filter then.
+		 */
+		the_hash_algo->init_fn(&ctx);
+		the_hash_algo->update_fn(&ctx, path,
+					 path[len - 1] == '/' ? len - 1 : len);
+		the_hash_algo->final_fn(pi->name_hash, &ctx);
+	}
+
+	if (bf.bits)
+		/* Already loaded. */
+		return;
+
+	if (bloom_filter_load(&bf) < 0) {
+		warning("you wanted to use the Bloom filter, but it couldn't be loaded");
+		return;
+	}
+}
+
 int prepare_revision_walk(struct rev_info *revs)
 {
 	int i;
@@ -3155,6 +3249,9 @@ int prepare_revision_walk(struct rev_info *revs)
 		simplify_merges(revs);
 	if (revs->children.name)
 		set_children(revs);
+
+	prepare_to_use_bloom_filter(revs);
+
 	return 0;
 }
 
-- 
2.19.1.409.g0a0ee5eb6b

