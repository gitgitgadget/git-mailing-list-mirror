Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 11F9720248
	for <e@80x24.org>; Tue, 16 Apr 2019 09:34:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728827AbfDPJea (ORCPT <rfc822;e@80x24.org>);
        Tue, 16 Apr 2019 05:34:30 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:36610 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726739AbfDPJea (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Apr 2019 05:34:30 -0400
Received: by mail-pl1-f195.google.com with SMTP id ck15so10068699plb.3
        for <git@vger.kernel.org>; Tue, 16 Apr 2019 02:34:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ECtwYiDZAJq2pLIs3S0DoB2c52bYolJYQIgfTWD6Lu4=;
        b=Ukc4flPWdDkeptOXegDh3Eccp4ES7KlBJxjRqyKVSP4Jr/ZExTvblilRKVNkRY9MQG
         9qXSUaqLXNPjJ7i5oYhzls3h/Eet65eYbLK9KGMn7jaEio+CdWsi52L7iOcZ9GoWMHAR
         97u9Cfh7PoJUVLDD57TCzcCm6EEmRAsNLWnvvqTS4NHSiSZF6iL+hLgIx0ZOKlFGnCUh
         mLY7rdqPKTxnRTPJffa85GseRBwTzOp/CCI7NmhQDHpMqDwnjs/aYBOazDrtmTIegbyU
         vZaK9yu4AItlT9ghXEqoZF7qmDGIYKAOyMFOXcGYF4keAC8kaDz4FlBKIm0PaeK821wf
         0lzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ECtwYiDZAJq2pLIs3S0DoB2c52bYolJYQIgfTWD6Lu4=;
        b=GXLl/Enk/yY5gb27Z6eQnI2bdDj/RXXkC9UNzEwqvxSHN4gv83EBUEudVYF0rrY7I3
         Vzq+8WF3EKf8UaiNNZqShu5n+nnWoBZhqDS0AtEmJE5877jQrTRcejLvS9vFryQG1zY0
         nVWDYnunv4t38MzxEUdrEHMP/jR9SJMVMTkcl5UxaVqBlVqh9o/k6AcAlB7FjjZL4syj
         oVoMtNgRXX+US87XMv1hfRWCP4HxXQ2fpWY8XFoo+CxeANp+NJ2NlRhnxw+BfzM2hbqj
         G0SsTBO948FyWP4Ky1NyygzARnsHUOOlyQbpyhxzW0WoJwk0BHW9KYEKcW1ZC9XA817A
         qtJQ==
X-Gm-Message-State: APjAAAVHb2ye7OsmB9UHY3O5CnZAJghT0yuOQkPy7kxZ95IPeh5HCG1i
        DZF+jKm4vkBm5cQwcz/txW0=
X-Google-Smtp-Source: APXvYqwko0kHrXasAulkK3XYxPvnWK/6b082m28GQZ+qnIuQ7yZZmqhvVtlHWAww4zWXzDJaRUSj/Q==
X-Received: by 2002:a17:902:32b:: with SMTP id 40mr59104581pld.204.1555407269453;
        Tue, 16 Apr 2019 02:34:29 -0700 (PDT)
Received: from ash ([116.106.33.3])
        by smtp.gmail.com with ESMTPSA id 71sm115590285pfs.36.2019.04.16.02.34.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 16 Apr 2019 02:34:28 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Tue, 16 Apr 2019 16:34:22 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     Johannes.Schindelin@gmx.de, git@vger.kernel.org, gitster@pobox.com,
        stefanbeller@gmail.com, szeder.dev@gmail.com
Subject: [PATCH v4 00/34] nd/sha1-name-c-wo-the-repository updates
Date:   Tue, 16 Apr 2019 16:33:07 +0700
Message-Id: <20190416093341.17079-1-pclouds@gmail.com>
X-Mailer: git-send-email 2.21.0.682.g30d2204636
In-Reply-To: <20190406113453.5149-1-pclouds@gmail.com>
References: <20190406113453.5149-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

v4 is all about updating commit.c and commit.cocci 11/33. I think I have
incorporated all changes from v3 discussion. The changes are separated
to a new patch 11/34 though, the old 11/33 is now 12/34.

Diff

diff --git a/commit-graph.c b/commit-graph.c
index 47e9be0a3a..155a270457 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -343,6 +343,11 @@ static void fill_commit_graph_info(struct commit *item, struct commit_graph *g,
 	item->generation = get_be32(commit_data + g->hash_len + 8) >> 2;
 }
 
+static inline void set_commit_tree(struct commit *c, struct tree *t)
+{
+	c->maybe_tree = t;
+}
+
 static int fill_commit_in_graph(struct repository *r,
 				struct commit *item,
 				struct commit_graph *g, uint32_t pos)
@@ -356,7 +361,7 @@ static int fill_commit_in_graph(struct repository *r,
 	item->object.parsed = 1;
 	item->graph_pos = pos;
 
-	item->maybe_tree = NULL;
+	set_commit_tree(item, NULL);
 
 	date_high = get_be32(commit_data + g->hash_len + 8) & 0x3;
 	date_low = get_be32(commit_data + g->hash_len + 12);
@@ -442,7 +447,7 @@ static struct tree *load_tree_for_commit(struct repository *r,
 					   GRAPH_DATA_WIDTH * (c->graph_pos);
 
 	hashcpy(oid.hash, commit_data);
-	c->maybe_tree = lookup_tree(r, &oid);
+	set_commit_tree(c, lookup_tree(r, &oid));
 
 	return c->maybe_tree;
 }
diff --git a/commit.c b/commit.c
index f0a5506f04..a9e74647dc 100644
--- a/commit.c
+++ b/commit.c
@@ -340,6 +340,11 @@ void free_commit_buffer(struct parsed_object_pool *pool, struct commit *commit)
 	}
 }
 
+static inline void set_commit_tree(struct commit *c, struct tree *t)
+{
+	c->maybe_tree = t;
+}
+
 struct tree *repo_get_commit_tree(struct repository *r,
 				  const struct commit *commit)
 {
@@ -359,7 +364,7 @@ struct object_id *get_commit_tree_oid(const struct commit *commit)
 
 void release_commit_memory(struct parsed_object_pool *pool, struct commit *c)
 {
-	c->maybe_tree = NULL;
+	set_commit_tree(c, NULL);
 	c->index = 0;
 	free_commit_buffer(pool, c);
 	free_commit_list(c->parents);
@@ -407,7 +412,7 @@ int parse_commit_buffer(struct repository *r, struct commit *item, const void *b
 	if (get_oid_hex(bufptr + 5, &parent) < 0)
 		return error("bad tree pointer in commit %s",
 			     oid_to_hex(&item->object.oid));
-	item->maybe_tree = lookup_tree(r, &parent);
+	set_commit_tree(item, lookup_tree(r, &parent));
 	bufptr += tree_entry_len + 1; /* "tree " + "hex sha1" + "\n" */
 	pptr = &item->parents;
 
diff --git a/contrib/coccinelle/commit.cocci b/contrib/coccinelle/commit.cocci
index 57c8f71479..d03453341e 100644
--- a/contrib/coccinelle/commit.cocci
+++ b/contrib/coccinelle/commit.cocci
@@ -10,20 +10,25 @@ expression c;
 - c->maybe_tree->object.oid.hash
 + get_commit_tree_oid(c)->hash
 
+@@
+identifier f !~ "^set_commit_tree$";
+expression c;
+expression s;
+@@
+  f(...) {<...
+- c->maybe_tree = s
++ set_commit_tree(c, s)
+  ...>}
+
 // These excluded functions must access c->maybe_tree direcly.
+// Note that if c->maybe_tree is written somewhere outside of these
+// functions, then the recommended transformation will be bogus with
+// repo_get_commit_tree() on the LHS.
 @@
-identifier f !~ "^(repo_get_commit_tree|get_commit_tree_in_graph_one|load_tree_for_commit)$";
+identifier f !~ "^(repo_get_commit_tree|get_commit_tree_in_graph_one|load_tree_for_commit|set_commit_tree)$";
 expression c;
 @@
   f(...) {<...
 - c->maybe_tree
-+ repo_get_commit_tree(the_repository, c)
++ repo_get_commit_tree(specify_the_right_repo_here, c)
   ...>}
-
-@@
-expression c;
-expression r;
-expression s;
-@@
-- repo_get_commit_tree(r, c) = s
-+ c->maybe_tree = s
diff --git a/merge-recursive.c b/merge-recursive.c
index 6c40c61c47..ca4731a719 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -163,6 +163,11 @@ static struct tree *shift_tree_object(struct repository *repo,
 	return lookup_tree(repo, &shifted);
 }
 
+static inline void set_commit_tree(struct commit *c, struct tree *t)
+{
+	c->maybe_tree = t;
+}
+
 static struct commit *make_virtual_commit(struct repository *repo,
 					  struct tree *tree,
 					  const char *comment)
@@ -170,7 +175,7 @@ static struct commit *make_virtual_commit(struct repository *repo,
 	struct commit *commit = alloc_commit_node(repo);
 
 	set_merge_remote_desc(commit, comment, (struct object *)commit);
-	commit->maybe_tree = tree;
+	set_commit_tree(commit, tree);
 	commit->object.parsed = 1;
 	return commit;
 }
 

Nguyễn Thái Ngọc Duy (32):
  packfile.c: add repo_approximate_object_count()
  refs.c: add refs_ref_exists()
  refs.c: add refs_shorten_unambiguous_ref()
  refs.c: remove the_repo from substitute_branch_name()
  refs.c: remove the_repo from expand_ref()
  refs.c: add repo_dwim_ref()
  refs.c: add repo_dwim_log()
  refs.c: remove the_repo from read_ref_at()
  commit.cocci: refactor code, avoid double rewrite
  commit.c: add repo_get_commit_tree()
  sha1-name.c: remove the_repo from sort_ambiguous()
  sha1-name.c: remove the_repo from find_abbrev_len_packed()
  sha1-name.c: add repo_find_unique_abbrev_r()
  sha1-name.c: store and use repo in struct disambiguate_state
  sha1-name.c: add repo_for_each_abbrev()
  sha1-name.c: remove the_repo from get_short_oid()
  sha1-name.c: remove the_repo from interpret_nth_prior_checkout()
  sha1-name.c: remove the_repo from interpret_branch_mark()
  sha1-name.c: add repo_interpret_branch_name()
  sha1-name.c: remove the_repo from get_oid_oneline()
  sha1-name.c: remove the_repo from get_describe_name()
  sha1-name.c: remove the_repo from get_oid_basic()
  sha1-name.c: remove the_repo from get_oid_1()
  sha1-name.c: remove the_repo from handle_one_ref()
  sha1-name.c: remove the_repo from diagnose_invalid_index_path()
  sha1-name.c: remove the_repo from resolve_relative_path()
  sha1-name.c: remove the_repo from get_oid_with_context_1()
  sha1-name.c: add repo_get_oid()
  submodule-config.c: use repo_get_oid for reading .gitmodules
  sha1-name.c: remove the_repo from maybe_die_on_misspelt_object_name
  sha1-name.c: remove the_repo from other get_oid_*
  sha1-name.c: remove the_repo from get_oid_mb()

SZEDER Gábor (2):
  builtin rebase: use FREE_AND_NULL
  builtin rebase: use oideq()

 builtin/rebase.c                   |   5 +-
 builtin/show-branch.c              |   6 +-
 cache.h                            |  50 ++--
 commit-graph.c                     |   9 +-
 commit.c                           |  14 +-
 commit.h                           |   5 +-
 contrib/coccinelle/commit.cocci    |  20 +-
 dir.c                              |   8 +
 dir.h                              |   4 +-
 merge-recursive.c                  |   7 +-
 packfile.c                         |  14 +-
 packfile.h                         |   3 +-
 refs.c                             |  71 ++++--
 refs.h                             |   9 +-
 setup.c                            |   7 +-
 sha1-name.c                        | 388 ++++++++++++++++++-----------
 submodule-config.c                 |  20 +-
 t/t7814-grep-recurse-submodules.sh |   6 +-
 upload-pack.c                      |   2 +-
 19 files changed, 407 insertions(+), 241 deletions(-)

-- 
2.21.0.682.g30d2204636

