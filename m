Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6648F1F62E
	for <e@80x24.org>; Wed, 16 Jan 2019 18:26:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728700AbfAPS0C (ORCPT <rfc822;e@80x24.org>);
        Wed, 16 Jan 2019 13:26:02 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:36708 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728597AbfAPS0B (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Jan 2019 13:26:01 -0500
Received: by mail-ed1-f68.google.com with SMTP id f23so6244381edb.3
        for <git@vger.kernel.org>; Wed, 16 Jan 2019 10:25:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=KVHMOF9UFxzJgwGA0sYFm8zkh6k29GoGOKzooOKI+rU=;
        b=prasNIKJ+pIY2KsgFZrNTqzAEpAuZUL5APdbHIsPc/Sy0WM+QxQfRfeyJX/pjLqcGc
         E/u5ixCZVNWrqg7h78G1r0p0mIpMBYagIJa6Wp+Z8jslj9uGvY25lOWf1rw0fNwZ/lal
         9vog5E53J0rEONTkTkvGGLYpFAJ5d1VFWjucBqUnfIYYypxUCjABgp2x5QzAhGCJN+KK
         D6wt2AHsBLfAPKg0ZByPl21uWHWLa5Noq8l66HOxnj4Z/nQCdoC+P0ykAZeztdEsgQTy
         KuPJzdIt1JhmZveOwBfX20QXIU3r2d+XQung9KBBRwAvqZdjZgUoJXsdUrkMUJ7xKT17
         kEhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=KVHMOF9UFxzJgwGA0sYFm8zkh6k29GoGOKzooOKI+rU=;
        b=Hh/Jc0EIZoZkIrnnohdb2Lku0j1+4jnOljt9tk4JQORYi0gKMiJDc3dmpY2BkOLohq
         hnPctD0rMsJZus4EgkYUG71T7+tZiEhIUOixB4Qv0wycpLNGUL+OTLu8E0oJNM5zYNMP
         P6iFwhI0HI3MNO0kcPb1H5XwXwpiVTuduFUuXvzEmnJ+sNv9Zq6gCBH7WDC0a8O/tcpg
         QGZ481yNF2ebnIVxXIpfB6J1YmZKG+JptKmqImTxuTKMd9ofZIHAjGK81g5NKj0ef1UY
         mUycgzJk2Bss9GIOIc29WoSs/ZHoAMAETreMPQRhI821zScZTrTORttyD4ugkjkcIfFh
         jXUA==
X-Gm-Message-State: AJcUukeX9weIkecV7cgqHmE9rBz3ROICxa7YWJQF33VKeTRnT7Xtw49L
        j4JBnL2878pAKuD08LsXKC2Ukn4v
X-Google-Smtp-Source: ALg8bN6JyHFoH+5c0i6c+CMLukMn/azXwU4wHDSZgLtXvymolpmzfDIHehCNb/M1KhA7osVrbdHW5w==
X-Received: by 2002:a17:906:753:: with SMTP id z19-v6mr7760079ejb.175.1547663157842;
        Wed, 16 Jan 2019 10:25:57 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id r1sm5611824eds.1.2019.01.16.10.25.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 16 Jan 2019 10:25:56 -0800 (PST)
Date:   Wed, 16 Jan 2019 10:25:56 -0800 (PST)
X-Google-Original-Date: Wed, 16 Jan 2019 18:25:50 GMT
Message-Id: <pull.89.v5.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.89.v4.git.gitgitgadget@gmail.com>
References: <pull.89.v4.git.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v5 0/5] Add a new "sparse" tree walk algorithm
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     peff@peff.net, avarab@gmail.com, jrnieder@gmail.com,
        ramsay@ramsayjones.plus.com, Junio C Hamano <gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

One of the biggest remaining pain points for users of very large
repositories is the time it takes to run 'git push'. We inspected some slow
pushes by our developers and found that the "Enumerating Objects" phase of a
push was very slow. This is unsurprising, because this is why reachability
bitmaps exist. However, reachability bitmaps are not available to us because
of the single pack-file requirement. The bitmap approach is intended for
servers anyway, and clients have a much different behavior pattern.

Specifically, clients are normally pushing a very small number of objects
compared to the entire working directory. A typical user changes only a
small cone of the working directory, so let's use that to our benefit.

Create a new "sparse" mode for 'git pack-objects' that uses the paths that
introduce new objects to direct our search into the reachable trees. By
collecting trees at each path, we can then recurse into a path only when
there are uninteresting and interesting trees at that path. This gains a
significant performance boost for small topics while presenting a
possibility of packing extra objects.

The main algorithm change is in patch 4, but is set up a little bit in
patches 1 and 2.

As demonstrated in the included test script, we see that the existing
algorithm can send extra objects due to the way we specify the "frontier".
But we can send even more objects if a user copies objects from one folder
to another. I say "copy" because a rename would (usually) change the
original folder and trigger a walk into that path, discovering the objects.

In order to benefit from this approach, the user can opt-in using the
pack.useSparse config setting. This setting can be overridden using the
'--no-sparse' option.

Update in V2: 

 * Added GIT_TEST_PACK_SPARSE test option.
 * Fixed test breakages when GIT_TEST_PACK_SPARSE is enabled by adding null
   checks.

Update in V3:

 * Change documentation around 'pack.useSparse' config setting to better
   advertise to users.
 * Mostly a ping now that v2.20.0 is out.

Updates in V4:

 * Switched to using hashmap instead of string_list for the path/oidset
   dictionary. (This is due to some fear that the string_list performance
   would degrade for a very wide tree, but I am unable to measure a
   performance difference.)
 * Some cleanup of code snippets across commits.
 * Some grammar cleanup in the commit messages.

Updates in V5:

 * Renamed the generic "set" to "trees"
 * Used a less-restrictive test condition when testing the old algorithm,
   except for the case where we want to verify that the new algorithm is
   being run.
 * Removed a global variable that was not used. Thanks, Ramsay and Junio!

Derrick Stolee (5):
  revision: add mark_tree_uninteresting_sparse
  list-objects: consume sparse tree walk
  revision: implement sparse algorithm
  pack-objects: create pack.useSparse setting
  pack-objects: create GIT_TEST_PACK_SPARSE

 Documentation/config/pack.txt      |   9 ++
 Documentation/git-pack-objects.txt |  11 ++-
 bisect.c                           |   2 +-
 builtin/pack-objects.c             |  10 +-
 builtin/rev-list.c                 |   2 +-
 http-push.c                        |   2 +-
 list-objects.c                     |  70 +++++++++++---
 list-objects.h                     |   4 +-
 revision.c                         | 143 +++++++++++++++++++++++++++++
 revision.h                         |   2 +
 t/README                           |   4 +
 t/t5322-pack-objects-sparse.sh     | 136 +++++++++++++++++++++++++++
 12 files changed, 378 insertions(+), 17 deletions(-)
 create mode 100755 t/t5322-pack-objects-sparse.sh


base-commit: a1598010f775d82b5adf12c29d0f5bc9b41434c6
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-89%2Fderrickstolee%2Fpush%2Fsparse-v5
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-89/derrickstolee/push/sparse-v5
Pull-Request: https://github.com/gitgitgadget/git/pull/89

Range-diff vs v4:

 1:  817e30a287 ! 1:  02ef702884 revision: add mark_tree_uninteresting_sparse
     @@ -9,7 +9,10 @@
      
          The current implementation uses the existing
          mark_tree_uninteresting to recursively walk the trees and blobs.
     -    This will walk the same number of trees as the old mechanism.
     +    This will walk the same number of trees as the old mechanism. To
     +    ensure that mark_tree_uninteresting walks the tree, we need to
     +    remove the UNINTERESTING flag before calling the method. This
     +    implementation will be replaced entirely in a later commit.
      
          There is one new assumption in this approach: we are also given
          the oids of the interesting trees. This implementation does not
     @@ -26,12 +29,12 @@
       }
       
      +void mark_trees_uninteresting_sparse(struct repository *r,
     -+				     struct oidset *set)
     ++				     struct oidset *trees)
      +{
      +	struct object_id *oid;
      +	struct oidset_iter iter;
      +
     -+	oidset_iter_init(set, &iter);
     ++	oidset_iter_init(trees, &iter);
      +	while ((oid = oidset_iter_next(&iter))) {
      +		struct tree *tree = lookup_tree(r, oid);
      +
     @@ -69,7 +72,7 @@
       
       void mark_parents_uninteresting(struct commit *commit);
       void mark_tree_uninteresting(struct repository *r, struct tree *tree);
     -+void mark_trees_uninteresting_sparse(struct repository *r, struct oidset *set);
     ++void mark_trees_uninteresting_sparse(struct repository *r, struct oidset *trees);
       
       void show_object_with_name(FILE *, struct object *, const char *);
       
 2:  39dc89beb9 ! 2:  0747f7494e list-objects: consume sparse tree walk
     @@ -35,18 +35,53 @@
          UNINTERSTING.
      
          Add a new 'sparse' option to the mark_edges_uninteresting() method
     -    that performs this logic in a slightly new way. As we iterate over
     -    the commits, we add all of the root trees to an oidset. Then, call
     -    mark_trees_uninteresting_sparse() on that oidset. Note that we
     +    that performs this logic in a slightly different way. As we iterate
     +    over the commits, we add all of the root trees to an oidset. Then,
     +    call mark_trees_uninteresting_sparse() on that oidset. Note that we
          include interesting trees in this process. The current implementation
          of mark_trees_unintersting_sparse() will walk the same trees as
          the old logic, but this will be replaced in a later change.
      
     -    The sparse option is not used by any callers at the moment, but
     -    will be wired to 'git pack-objects' in the next change.
     +    Add a '--sparse' flag in 'git pack-objects' to call this new logic.
     +    Add a new test script t/t5322-pack-objects-sparse.sh that tests this
     +    option. The tests currently demonstrate that the resulting object
     +    list is the same as the old algorithm. This includes a case where
     +    both algorithms pack an object that is not needed by a remote due to
     +    limits on the explored set of trees. When the sparse algorithm is
     +    changed in a later commit, we will add a test that demonstrates a
     +    change of behavior in some cases.
      
          Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
      
     + diff --git a/Documentation/git-pack-objects.txt b/Documentation/git-pack-objects.txt
     + --- a/Documentation/git-pack-objects.txt
     + +++ b/Documentation/git-pack-objects.txt
     +@@
     + 	[--local] [--incremental] [--window=<n>] [--depth=<n>]
     + 	[--revs [--unpacked | --all]] [--keep-pack=<pack-name>]
     + 	[--stdout [--filter=<filter-spec>] | base-name]
     +-	[--shallow] [--keep-true-parents] < object-list
     ++	[--shallow] [--keep-true-parents] [--sparse] < object-list
     + 
     + 
     + DESCRIPTION
     +@@
     + 	Add --no-reuse-object if you want to force a uniform compression
     + 	level on all data no matter the source.
     + 
     ++--sparse::
     ++	Use the "sparse" algorithm to determine which objects to include in
     ++	the pack, when combined with the "--revs" option. This algorithm
     ++	only walks trees that appear in paths that introduce new objects.
     ++	This can have significant performance benefits when computing
     ++	a pack to send a small change. However, it is possible that extra
     ++	objects are added to the pack-file if the included commits contain
     ++	certain types of direct renames.
     ++
     + --thin::
     + 	Create a "thin" pack by omitting the common objects between a
     + 	sender and a receiver in order to reduce network transfer. This
     +
       diff --git a/bisect.c b/bisect.c
       --- a/bisect.c
       +++ b/bisect.c
     @@ -64,14 +99,31 @@
       --- a/builtin/pack-objects.c
       +++ b/builtin/pack-objects.c
      @@
     + static int depth = 50;
     + static int delta_search_threads;
     + static int pack_to_stdout;
     ++static int sparse;
     + static int thin;
     + static int num_preferred_base;
     + static struct progress *progress_state;
     +@@
       
       	if (prepare_revision_walk(&revs))
       		die(_("revision walk setup failed"));
      -	mark_edges_uninteresting(&revs, show_edge);
     -+	mark_edges_uninteresting(&revs, show_edge, 0);
     ++	mark_edges_uninteresting(&revs, show_edge, sparse);
       
       	if (!fn_show_object)
       		fn_show_object = show_object;
     +@@
     + 		{ OPTION_CALLBACK, 0, "unpack-unreachable", NULL, N_("time"),
     + 		  N_("unpack unreachable objects newer than <time>"),
     + 		  PARSE_OPT_OPTARG, option_parse_unpack_unreachable },
     ++		OPT_BOOL(0, "sparse", &sparse,
     ++			 N_("use the sparse reachability algorithm")),
     + 		OPT_BOOL(0, "thin", &thin,
     + 			 N_("create thin packs")),
     + 		OPT_BOOL(0, "shallow", &shallow,
      
       diff --git a/builtin/rev-list.c b/builtin/rev-list.c
       --- a/builtin/rev-list.c
     @@ -202,3 +254,122 @@
       
       struct oidset;
       struct list_objects_filter_options;
     +
     + diff --git a/t/t5322-pack-objects-sparse.sh b/t/t5322-pack-objects-sparse.sh
     + new file mode 100755
     + --- /dev/null
     + +++ b/t/t5322-pack-objects-sparse.sh
     +@@
     ++#!/bin/sh
     ++
     ++test_description='pack-objects object selection using sparse algorithm'
     ++. ./test-lib.sh
     ++
     ++test_expect_success 'setup repo' '
     ++	test_commit initial &&
     ++	for i in $(test_seq 1 3)
     ++	do
     ++		mkdir f$i &&
     ++		for j in $(test_seq 1 3)
     ++		do
     ++			mkdir f$i/f$j &&
     ++			echo $j >f$i/f$j/data.txt
     ++		done
     ++	done &&
     ++	git add . &&
     ++	git commit -m "Initialized trees" &&
     ++	for i in $(test_seq 1 3)
     ++	do
     ++		git checkout -b topic$i master &&
     ++		echo change-$i >f$i/f$i/data.txt &&
     ++		git commit -a -m "Changed f$i/f$i/data.txt"
     ++	done &&
     ++	cat >packinput.txt <<-EOF &&
     ++	topic1
     ++	^topic2
     ++	^topic3
     ++	EOF
     ++	git rev-parse			\
     ++		topic1			\
     ++		topic1^{tree}		\
     ++		topic1:f1		\
     ++		topic1:f1/f1		\
     ++		topic1:f1/f1/data.txt | sort >expect_objects.txt
     ++'
     ++
     ++test_expect_success 'non-sparse pack-objects' '
     ++	git pack-objects --stdout --revs <packinput.txt >nonsparse.pack &&
     ++	git index-pack -o nonsparse.idx nonsparse.pack &&
     ++	git show-index <nonsparse.idx | awk "{print \$2}" >nonsparse_objects.txt &&
     ++	test_cmp expect_objects.txt nonsparse_objects.txt
     ++'
     ++
     ++test_expect_success 'sparse pack-objects' '
     ++	git pack-objects --stdout --revs --sparse <packinput.txt >sparse.pack &&
     ++	git index-pack -o sparse.idx sparse.pack &&
     ++	git show-index <sparse.idx | awk "{print \$2}" >sparse_objects.txt &&
     ++	test_cmp expect_objects.txt sparse_objects.txt
     ++'
     ++
     ++test_expect_success 'duplicate a folder from f3 and commit to topic1' '
     ++	git checkout topic1 &&
     ++	echo change-3 >f3/f3/data.txt &&
     ++	git commit -a -m "Changed f3/f3/data.txt" &&
     ++	git rev-parse			\
     ++		topic1~1		\
     ++		topic1~1^{tree}		\
     ++		topic1^{tree}		\
     ++		topic1			\
     ++		topic1:f1		\
     ++		topic1:f1/f1		\
     ++		topic1:f1/f1/data.txt | sort >required_objects.txt
     ++'
     ++
     ++test_expect_success 'non-sparse pack-objects' '
     ++	git pack-objects --stdout --revs <packinput.txt >nonsparse.pack &&
     ++	git index-pack -o nonsparse.idx nonsparse.pack &&
     ++	git show-index <nonsparse.idx | awk "{print \$2}" >nonsparse_objects.txt &&
     ++	comm -1 -2 required_objects.txt nonsparse_objects.txt >nonsparse_required_objects.txt &&
     ++	test_cmp required_objects.txt nonsparse_required_objects.txt
     ++'
     ++
     ++test_expect_success 'sparse pack-objects' '
     ++	git pack-objects --stdout --revs --sparse <packinput.txt >sparse.pack &&
     ++	git index-pack -o sparse.idx sparse.pack &&
     ++	git show-index <sparse.idx | awk "{print \$2}" >sparse_objects.txt &&
     ++	comm -1 -2 required_objects.txt sparse_objects.txt >sparse_required_objects.txt &&
     ++	test_cmp required_objects.txt sparse_required_objects.txt
     ++'
     ++
     ++test_expect_success 'duplicate a folder from f1 into f3' '
     ++	mkdir f3/f4 &&
     ++	cp -r f1/f1/* f3/f4 &&
     ++	git add f3/f4 &&
     ++	git commit -m "Copied f1/f1 to f3/f4" &&
     ++	cat >packinput.txt <<-EOF &&
     ++	topic1
     ++	^topic1~1
     ++	EOF
     ++	git rev-parse		\
     ++		topic1		\
     ++		topic1^{tree}   \
     ++		topic1:f3 | sort >required_objects.txt
     ++'
     ++
     ++test_expect_success 'non-sparse pack-objects' '
     ++	git pack-objects --stdout --revs <packinput.txt >nonsparse.pack &&
     ++	git index-pack -o nonsparse.idx nonsparse.pack &&
     ++	git show-index <nonsparse.idx | awk "{print \$2}" >nonsparse_objects.txt &&
     ++	comm -1 -2 required_objects.txt nonsparse_objects.txt >nonsparse_required_objects.txt &&
     ++	test_cmp required_objects.txt nonsparse_required_objects.txt
     ++'
     ++
     ++test_expect_success 'sparse pack-objects' '
     ++	git pack-objects --stdout --revs --sparse <packinput.txt >sparse.pack &&
     ++	git index-pack -o sparse.idx sparse.pack &&
     ++	git show-index <sparse.idx | awk "{print \$2}" >sparse_objects.txt &&
     ++	comm -1 -2 required_objects.txt sparse_objects.txt >sparse_required_objects.txt &&
     ++	test_cmp required_objects.txt sparse_required_objects.txt
     ++'
     ++
     ++test_done
 3:  ab733daff5 < -:  ---------- pack-objects: add --sparse option
 4:  c44172c35e ! 3:  327c102477 revision: implement sparse algorithm
     @@ -31,7 +31,7 @@
          path. We also mark trees as UNINTERESTING if the tree we are
          parsing is UNINTERESTING.
      
     -    To actually improve the peformance, we need to terminate our
     +    To actually improve the performance, we need to terminate our
          recursion. If the oidset contains only UNINTERESTING trees, then
          we do not continue the recursion. This avoids walking trees that
          are likely to not be reachable from interesting trees. If the
     @@ -46,9 +46,9 @@
          from one tree to another, the first tree will appear UNINTERESTING
          and we will not recurse to see that the subtree should also be
          UNINTERESTING. We will walk the new tree and see the subtree as
     -    a "new" object and add it to the pack. We add a test case that
     -    demonstrates this as a way to prove that the --sparse option is
     -    actually working.
     +    a "new" object and add it to the pack. A test is modified to
     +    demonstrate this behavior and to verify that the new logic is
     +    being exercised.
      
          Second, we can have extra memory pressure. If instead of being a
          single user pushing a small topic we are a server sending new
     @@ -126,7 +126,7 @@
      +struct path_and_oids_entry {
      +	struct hashmap_entry ent;
      +	char *path;
     -+	struct oidset set;
     ++	struct oidset trees;
      +};
      +
      +static int path_and_oids_cmp(const void *hashmap_cmp_fn_data,
     @@ -137,10 +137,9 @@
      +	return strcmp(e1->path, e2->path);
      +}
      +
     -+int map_flags = 0;
      +static void paths_and_oids_init(struct hashmap *map)
      +{
     -+	hashmap_init(map, (hashmap_cmp_fn) path_and_oids_cmp, &map_flags, 0);
     ++	hashmap_init(map, (hashmap_cmp_fn) path_and_oids_cmp, NULL, 0);
      +}
      +
      +static void paths_and_oids_clear(struct hashmap *map)
     @@ -150,7 +149,7 @@
      +	hashmap_iter_init(map, &iter);
      +
      +	while ((entry = (struct path_and_oids_entry *)hashmap_iter_next(&iter))) {
     -+		oidset_clear(&entry->set);
     ++		oidset_clear(&entry->trees);
      +		free(entry->path);
      +	}
      +
     @@ -166,20 +165,20 @@
      +	struct path_and_oids_entry *entry;
      +
      +	hashmap_entry_init(&key, hash);
     -+	key.path = xstrdup(path);
     -+	oidset_init(&key.set, 0);
     ++
     ++	/* use a shallow copy for the lookup */
     ++	key.path = (char *)path;
     ++	oidset_init(&key.trees, 0);
      +
      +	if (!(entry = (struct path_and_oids_entry *)hashmap_get(map, &key, NULL))) {
      +		entry = xcalloc(1, sizeof(struct path_and_oids_entry));
      +		hashmap_entry_init(entry, hash);
     -+		entry->path = key.path;
     -+		oidset_init(&entry->set, 16);
     ++		entry->path = xstrdup(key.path);
     ++		oidset_init(&entry->trees, 16);
      +		hashmap_put(map, entry);
     -+	} else {
     -+		free(key.path);
      +	}
      +
     -+	oidset_insert(&entry->set, oid);
     ++	oidset_insert(&entry->trees, oid);
      +}
      +
      +static void add_children_by_path(struct repository *r,
     @@ -224,7 +223,7 @@
      +}
      +
       void mark_trees_uninteresting_sparse(struct repository *r,
     - 				     struct oidset *set)
     + 				     struct oidset *trees)
       {
      +	unsigned has_interesting = 0, has_uninteresting = 0;
      +	struct hashmap map;
     @@ -233,7 +232,7 @@
       	struct object_id *oid;
       	struct oidset_iter iter;
       
     - 	oidset_iter_init(set, &iter);
     + 	oidset_iter_init(trees, &iter);
      -	while ((oid = oidset_iter_next(&iter))) {
      +	while ((!has_interesting || !has_uninteresting) &&
      +	       (oid = oidset_iter_next(&iter))) {
     @@ -263,7 +262,7 @@
      +
      +	paths_and_oids_init(&map);
      +
     -+	oidset_iter_init(set, &iter);
     ++	oidset_iter_init(trees, &iter);
      +	while ((oid = oidset_iter_next(&iter))) {
      +		struct tree *tree = lookup_tree(r, oid);
      +		add_children_by_path(r, tree, &map);
     @@ -271,7 +270,7 @@
      +
      +	hashmap_iter_init(&map, &map_iter);
      +	while ((entry = hashmap_iter_next(&map_iter)))
     -+		mark_trees_uninteresting_sparse(r, &entry->set);
     ++		mark_trees_uninteresting_sparse(r, &entry->trees);
      +
      +	paths_and_oids_clear(&map);
       }
     @@ -282,7 +281,7 @@
       --- a/t/t5322-pack-objects-sparse.sh
       +++ b/t/t5322-pack-objects-sparse.sh
      @@
     - 	test_cmp expect_objects.txt sparse_objects.txt
     + 	test_cmp required_objects.txt sparse_required_objects.txt
       '
       
      +# Demonstrate that the algorithms differ when we copy a tree wholesale
     @@ -291,27 +290,15 @@
       test_expect_success 'duplicate a folder from f1 into f3' '
       	mkdir f3/f4 &&
       	cp -r f1/f1/* f3/f4 &&
     - 	git add f3/f4 &&
     - 	git commit -m "Copied f1/f1 to f3/f4" &&
     --	cat >packinput.txt <<-EOF &&
     -+	cat >packinput.txt <<-EOF
     - 	topic1
     - 	^topic1~1
     - 	EOF
     --	git rev-parse		\
     --		topic1		\
     --		topic1^{tree}	\
     --		topic1:f3 | sort >expect_objects.txt
     +@@
       '
       
       test_expect_success 'non-sparse pack-objects' '
     -+	git rev-parse			\
     -+		topic1			\
     -+		topic1^{tree}		\
     -+		topic1:f3 | sort >expect_objects.txt &&
     - 	git pack-objects --stdout --revs <packinput.txt >nonsparse.pack &&
     +-	git pack-objects --stdout --revs <packinput.txt >nonsparse.pack &&
     ++	git pack-objects --stdout --revs --no-sparse <packinput.txt >nonsparse.pack &&
       	git index-pack -o nonsparse.idx nonsparse.pack &&
       	git show-index <nonsparse.idx | awk "{print \$2}" >nonsparse_objects.txt &&
     + 	comm -1 -2 required_objects.txt nonsparse_objects.txt >nonsparse_required_objects.txt &&
      @@
       '
       
     @@ -325,7 +312,8 @@
       	git pack-objects --stdout --revs --sparse <packinput.txt >sparse.pack &&
       	git index-pack -o sparse.idx sparse.pack &&
       	git show-index <sparse.idx | awk "{print \$2}" >sparse_objects.txt &&
     --	test_cmp expect_objects.txt sparse_objects.txt
     +-	comm -1 -2 required_objects.txt sparse_objects.txt >sparse_required_objects.txt &&
     +-	test_cmp required_objects.txt sparse_required_objects.txt
      +	test_cmp expect_sparse_objects.txt sparse_objects.txt
       '
       
 5:  f386f6c3c9 ! 4:  28111d70d4 pack-objects: create pack.useSparse setting
     @@ -73,7 +73,7 @@
      +	git pack-objects --stdout --revs --no-sparse <packinput.txt >sparse.pack &&
      +	git index-pack -o sparse.idx sparse.pack &&
      +	git show-index <sparse.idx | awk "{print \$2}" >sparse_objects.txt &&
     -+	test_cmp expect_objects.txt sparse_objects.txt
     ++	test_cmp required_objects.txt sparse_objects.txt
      +'
      +
       test_done
 6:  d011a9c1b1 ! 5:  ae046e8525 pack-objects: create GIT_TEST_PACK_SPARSE
     @@ -56,13 +56,4 @@
      +	git pack-objects --stdout --revs --no-sparse <packinput.txt >nonsparse.pack &&
       	git index-pack -o nonsparse.idx nonsparse.pack &&
       	git show-index <nonsparse.idx | awk "{print \$2}" >nonsparse_objects.txt &&
     - 	test_cmp expect_objects.txt nonsparse_objects.txt
     -@@
     - 		topic1			\
     - 		topic1^{tree}		\
     - 		topic1:f3 | sort >expect_objects.txt &&
     --	git pack-objects --stdout --revs <packinput.txt >nonsparse.pack &&
     -+	git pack-objects --stdout --revs --no-sparse <packinput.txt >nonsparse.pack &&
     - 	git index-pack -o nonsparse.idx nonsparse.pack &&
     - 	git show-index <nonsparse.idx | awk "{print \$2}" >nonsparse_objects.txt &&
     - 	test_cmp expect_objects.txt nonsparse_objects.txt
     + 	comm -1 -2 required_objects.txt nonsparse_objects.txt >nonsparse_required_objects.txt &&

-- 
gitgitgadget
