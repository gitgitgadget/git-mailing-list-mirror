Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F412E20966
	for <e@80x24.org>; Fri,  7 Apr 2017 15:25:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933071AbdDGPZj (ORCPT <rfc822;e@80x24.org>);
        Fri, 7 Apr 2017 11:25:39 -0400
Received: from mout.web.de ([212.227.15.4]:61875 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933015AbdDGPZh (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Apr 2017 11:25:37 -0400
Received: from [192.168.178.36] ([79.213.114.92]) by smtp.web.de (mrweb003
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0MeBEk-1cjvte0v1y-00Prhi; Fri, 07
 Apr 2017 17:25:28 +0200
Subject: [PATCH 2/2] use MOVE_ARRAY
To:     =?UTF-8?Q?Martin_Li=c5=a1ka?= <mliska@suse.cz>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Cc:     Johannes Sixt <j6t@kdbg.org>, Jeff King <peff@peff.net>
References: <295981e7-d2e9-d3db-e32d-8dd80ca47136@suse.cz>
 <20170406083425.7psdmrploxar3h6v@sigill.intra.peff.net>
 <998bf391-7fc5-8329-db58-ef0f24517707@suse.cz>
 <33c63fb9-281c-8fd2-66e7-b85f62f4f447@web.de>
 <8555c61f-2617-eec8-6dbe-87c79c6ca302@suse.cz>
 <587b0cb9-bd66-ddf7-5cca-023df3470883@kdbg.org>
 <e392e05c-2815-8cfa-eed0-bd990f8ce954@web.de>
 <357d045a-b1c5-1a73-2256-839efb543fe3@kdbg.org>
 <96beb4c6-0569-0c12-8151-462c20be6a2a@suse.cz>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <c4bdb724-62d5-056d-0667-09e446bb3119@web.de>
Date:   Fri, 7 Apr 2017 17:25:25 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.0
MIME-Version: 1.0
In-Reply-To: <96beb4c6-0569-0c12-8151-462c20be6a2a@suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K0:5gFax5hBC70HmTd1nCBNXscpZwRmTMnMGv93lk7fM4YZZIcJHOU
 uTvpMJQM17oUqNZ57p6zpkjIF4plnA9p3QQ4qIBkgCXYAL6BFztA9kIwGLcCOiFM+2Kj+Jx
 4peHh10UzTMbS7Qkf2f+QB037h7IHmFD3z+gReOTvx+W//QENAiQb1AQJhYLTbV8U2nnWMJ
 XcziPllfsXJeUOEAjkd3g==
X-UI-Out-Filterresults: notjunk:1;V01:K0:UehDtTy0DdA=:rNo7FX/sVClrKAPwvex/12
 6yickWEOdzdnRq2WMt40NEcY/ifv1MU9g+CuDBiemlKB9wfNVX1rgCV6E6nIdSv6pWvSIcsw5
 ucdr3nh88SIJaBcXXdnxJcmg6ZOVeE2OQ0DdIkqYi8LeplvQfPtEAT8WE4RUOEKQXr5tSk9n2
 NkNJ6Vshsj3pfDDx2r/n2F0zwFXzfNvO+RjxqDvqnRg8dVuxomBLAZzOlA4FHM49kp7HTs9be
 bhrRwUFBX+0GdGDIn2YNsWNWw3FzLJFeJ5ztQCBr6A/kQkwBuZvyfSgN+WQ3ksiU3LX2dap+d
 5Pa4WpjtMNToWEqB4InZuTkmqFHu0zLZmfmk5lE9f1WsPw0RdLGstVWBmunmnqA/ixMpHZe2z
 uFbSppGkrfrp4PlbfxR2H58PdxaHa+XOIjyvafCi3vUOptsaUOvlEuT1Wbf1cyUCrvtM0m1Q6
 6Jg5ddY5zEFpLohILb+Rc0j/ni/OSWuLsGEBj3Pux27uZkXMFyLXyDKP5lxeTDRy6B1jY+B5p
 Sn4jV2rlCQuP4Dio7uvJINybxqLW26J0gtnqD1IX/zH7wYEiABKr/QFyquEBmsr6GJ4sY2Tf3
 0mAG5zlPn50O23hNXYWXd2iHwfeYpxBePfVjkm4I8b3Am0Bf1sH/vNnuJYAHURWaFr0fEbz+N
 FJp2mA0wGF8dW1jQU5iuyMQG6+MxrYUprUhu+AjpHnLcj6NuVqiyQLae2sM/CdkiPp2ILbXVL
 8r+rX3/65btybnZjxRPunktzrhrmsblFoYNwUn6kZ/FFcUOm70AMcoBtrPbNqdtbwHp4UgUx2
 wdI0BL1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add a semantic patch for converting certain calls of memmove(3) to
MOVE_ARRAY() and apply that transformation to the code base.  The result
is shorter and safer code.

Signed-off-by: Rene Scharfe <l.s.r@web.de>
---
 apply.c                        |  7 +++----
 builtin/ls-files.c             |  3 +--
 builtin/merge.c                |  2 +-
 builtin/pack-objects.c         |  5 ++---
 cache-tree.c                   |  5 ++---
 commit.c                       | 11 ++++-------
 contrib/coccinelle/array.cocci | 37 +++++++++++++++++++++++++++++++++++++
 diffcore-rename.c              |  8 ++++----
 dir.c                          |  4 ++--
 notes-merge.c                  |  3 +--
 parse-options.c                |  2 +-
 read-cache.c                   |  5 ++---
 reflog-walk.c                  |  7 +++----
 refs/files-backend.c           |  5 ++---
 replace_object.c               |  6 ++----
 rerere.c                       |  4 ++--
 string-list.c                  |  5 ++---
 17 files changed, 71 insertions(+), 48 deletions(-)

diff --git a/apply.c b/apply.c
index e6dbab26ad..4e4d13cacc 100644
--- a/apply.c
+++ b/apply.c
@@ -2798,10 +2798,9 @@ static void update_image(struct apply_state *state,
 		img->line_allocated = img->line;
 	}
 	if (preimage_limit != postimage->nr)
-		memmove(img->line + applied_pos + postimage->nr,
-			img->line + applied_pos + preimage_limit,
-			(img->nr - (applied_pos + preimage_limit)) *
-			sizeof(*img->line));
+		MOVE_ARRAY(img->line + applied_pos + postimage->nr,
+			   img->line + applied_pos + preimage_limit,
+			   img->nr - (applied_pos + preimage_limit));
 	memcpy(img->line + applied_pos,
 	       postimage->line,
 	       postimage->nr * sizeof(*img->line));
diff --git a/builtin/ls-files.c b/builtin/ls-files.c
index d449e46db5..1627c26466 100644
--- a/builtin/ls-files.c
+++ b/builtin/ls-files.c
@@ -391,8 +391,7 @@ static void prune_cache(const char *prefix, size_t prefixlen)
 		}
 		last = next;
 	}
-	memmove(active_cache, active_cache + pos,
-		(last - pos) * sizeof(struct cache_entry *));
+	MOVE_ARRAY(active_cache, active_cache + pos, last - pos);
 	active_nr = last - pos;
 }
 
diff --git a/builtin/merge.c b/builtin/merge.c
index 95572b1810..0c0d2e4a94 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -536,7 +536,7 @@ static void parse_branch_merge_options(char *bmo)
 		die(_("Bad branch.%s.mergeoptions string: %s"), branch,
 		    split_cmdline_strerror(argc));
 	REALLOC_ARRAY(argv, argc + 2);
-	memmove(argv + 1, argv, sizeof(*argv) * (argc + 1));
+	MOVE_ARRAY(argv + 1, argv, argc + 1);
 	argc++;
 	argv[0] = "branch.*.mergeoptions";
 	parse_options(argc, argv, NULL, builtin_merge_options,
diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 84af7c2324..5fb5d7c546 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -1292,9 +1292,8 @@ static int check_pbase_path(unsigned hash)
 		   done_pbase_paths_alloc);
 	done_pbase_paths_num++;
 	if (pos < done_pbase_paths_num)
-		memmove(done_pbase_paths + pos + 1,
-			done_pbase_paths + pos,
-			(done_pbase_paths_num - pos - 1) * sizeof(unsigned));
+		MOVE_ARRAY(done_pbase_paths + pos + 1, done_pbase_paths + pos,
+			   done_pbase_paths_num - pos - 1);
 	done_pbase_paths[pos] = hash;
 	return 0;
 }
diff --git a/cache-tree.c b/cache-tree.c
index 345ea35963..071164a2ec 100644
--- a/cache-tree.c
+++ b/cache-tree.c
@@ -131,9 +131,8 @@ static int do_invalidate_path(struct cache_tree *it, const char *path)
 			 * move 4 and 5 up one place (2 entries)
 			 * 2 = 6 - 3 - 1 = subtree_nr - pos - 1
 			 */
-			memmove(it->down+pos, it->down+pos+1,
-				sizeof(struct cache_tree_sub *) *
-				(it->subtree_nr - pos - 1));
+			MOVE_ARRAY(it->down + pos, it->down + pos + 1,
+				   it->subtree_nr - pos - 1);
 			it->subtree_nr--;
 		}
 		return 1;
diff --git a/commit.c b/commit.c
index 73c78c2b80..62a71fee92 100644
--- a/commit.c
+++ b/commit.c
@@ -125,10 +125,8 @@ int register_commit_graft(struct commit_graft *graft, int ignore_dups)
 	ALLOC_GROW(commit_graft, commit_graft_nr + 1, commit_graft_alloc);
 	commit_graft_nr++;
 	if (pos < commit_graft_nr)
-		memmove(commit_graft + pos + 1,
-			commit_graft + pos,
-			(commit_graft_nr - pos - 1) *
-			sizeof(*commit_graft));
+		MOVE_ARRAY(commit_graft + pos + 1, commit_graft + pos,
+			   commit_graft_nr - pos - 1);
 	commit_graft[pos] = graft;
 	return 0;
 }
@@ -222,9 +220,8 @@ int unregister_shallow(const unsigned char *sha1)
 	if (pos < 0)
 		return -1;
 	if (pos + 1 < commit_graft_nr)
-		memmove(commit_graft + pos, commit_graft + pos + 1,
-				sizeof(struct commit_graft *)
-				* (commit_graft_nr - pos - 1));
+		MOVE_ARRAY(commit_graft + pos, commit_graft + pos + 1,
+			   commit_graft_nr - pos - 1);
 	commit_graft_nr--;
 	return 0;
 }
diff --git a/contrib/coccinelle/array.cocci b/contrib/coccinelle/array.cocci
index 4ba98b7eaf..a6e5ee927f 100644
--- a/contrib/coccinelle/array.cocci
+++ b/contrib/coccinelle/array.cocci
@@ -27,6 +27,43 @@ expression n;
 
 @@
 type T;
+T *dst;
+T *src;
+expression n;
+@@
+(
+- memmove(
++ MOVE_ARRAY(
+(
+  dst
+|
+  dst + ...
+|
+  &dst[...]
+)
+- , src, (n) * sizeof(*dst)
++ , src, n
+  );
+|
+- memmove(dst,
++ MOVE_ARRAY(dst,
+(
+  src
+|
+  src + ...
+|
+  &src[...]
+)
+- , (n) * sizeof(*src)
++ , n
+  );
+|
+- memmove(dst, src, (n) * sizeof(T));
++ MOVE_ARRAY(dst, src, n);
+)
+
+@@
+type T;
 T *ptr;
 expression n;
 @@
diff --git a/diffcore-rename.c b/diffcore-rename.c
index f7444c86bd..449d5f065f 100644
--- a/diffcore-rename.c
+++ b/diffcore-rename.c
@@ -57,8 +57,8 @@ static int add_rename_dst(struct diff_filespec *two)
 	ALLOC_GROW(rename_dst, rename_dst_nr + 1, rename_dst_alloc);
 	rename_dst_nr++;
 	if (first < rename_dst_nr)
-		memmove(rename_dst + first + 1, rename_dst + first,
-			(rename_dst_nr - first - 1) * sizeof(*rename_dst));
+		MOVE_ARRAY(rename_dst + first + 1, rename_dst + first,
+			   rename_dst_nr - first - 1);
 	rename_dst[first].two = alloc_filespec(two->path);
 	fill_filespec(rename_dst[first].two, two->oid.hash, two->oid_valid,
 		      two->mode);
@@ -98,8 +98,8 @@ static struct diff_rename_src *register_rename_src(struct diff_filepair *p)
 	ALLOC_GROW(rename_src, rename_src_nr + 1, rename_src_alloc);
 	rename_src_nr++;
 	if (first < rename_src_nr)
-		memmove(rename_src + first + 1, rename_src + first,
-			(rename_src_nr - first - 1) * sizeof(*rename_src));
+		MOVE_ARRAY(rename_src + first + 1, rename_src + first,
+			   rename_src_nr - first - 1);
 	rename_src[first].p = p;
 	rename_src[first].score = score;
 	return &(rename_src[first]);
diff --git a/dir.c b/dir.c
index f451bfa48c..f5f5658b1d 100644
--- a/dir.c
+++ b/dir.c
@@ -691,8 +691,8 @@ static struct untracked_cache_dir *lookup_untracked(struct untracked_cache *uc,
 	FLEX_ALLOC_MEM(d, name, name, len);
 
 	ALLOC_GROW(dir->dirs, dir->dirs_nr + 1, dir->dirs_alloc);
-	memmove(dir->dirs + first + 1, dir->dirs + first,
-		(dir->dirs_nr - first) * sizeof(*dir->dirs));
+	MOVE_ARRAY(dir->dirs + first + 1, dir->dirs + first,
+		   dir->dirs_nr - first);
 	dir->dirs_nr++;
 	dir->dirs[first] = d;
 	return d;
diff --git a/notes-merge.c b/notes-merge.c
index 5998605acc..36d5d2f87f 100644
--- a/notes-merge.c
+++ b/notes-merge.c
@@ -99,8 +99,7 @@ static struct notes_merge_pair *find_notes_merge_pair_pos(
 	else {
 		*occupied = 0;
 		if (insert_new && i < len) {
-			memmove(list + i + 1, list + i,
-				(len - i) * sizeof(struct notes_merge_pair));
+			MOVE_ARRAY(list + i + 1, list + i, len - i);
 			memset(list + i, 0, sizeof(struct notes_merge_pair));
 		}
 	}
diff --git a/parse-options.c b/parse-options.c
index a23a1e67f0..b8f768b0d8 100644
--- a/parse-options.c
+++ b/parse-options.c
@@ -524,7 +524,7 @@ int parse_options_step(struct parse_opt_ctx_t *ctx,
 
 int parse_options_end(struct parse_opt_ctx_t *ctx)
 {
-	memmove(ctx->out + ctx->cpidx, ctx->argv, ctx->argc * sizeof(*ctx->out));
+	MOVE_ARRAY(ctx->out + ctx->cpidx, ctx->argv, ctx->argc);
 	ctx->out[ctx->cpidx + ctx->argc] = NULL;
 	return ctx->cpidx + ctx->argc;
 }
diff --git a/read-cache.c b/read-cache.c
index e447751823..1bb5e97979 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -514,9 +514,8 @@ int remove_index_entry_at(struct index_state *istate, int pos)
 	istate->cache_nr--;
 	if (pos >= istate->cache_nr)
 		return 0;
-	memmove(istate->cache + pos,
-		istate->cache + pos + 1,
-		(istate->cache_nr - pos) * sizeof(struct cache_entry *));
+	MOVE_ARRAY(istate->cache + pos, istate->cache + pos + 1,
+		   istate->cache_nr - pos);
 	return 1;
 }
 
diff --git a/reflog-walk.c b/reflog-walk.c
index 99679f5825..25c198b9fd 100644
--- a/reflog-walk.c
+++ b/reflog-walk.c
@@ -95,10 +95,9 @@ static struct commit_info *get_commit_info(struct commit *commit,
 			struct commit_info *result = &lifo->items[i];
 			if (pop) {
 				if (i + 1 < lifo->nr)
-					memmove(lifo->items + i,
-						lifo->items + i + 1,
-						(lifo->nr - i) *
-						sizeof(struct commit_info));
+					MOVE_ARRAY(lifo->items + i,
+						   lifo->items + i + 1,
+						   lifo->nr - i);
 				lifo->nr--;
 			}
 			return result;
diff --git a/refs/files-backend.c b/refs/files-backend.c
index 50188e92f9..a851326445 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -437,9 +437,8 @@ static int remove_entry(struct ref_dir *dir, const char *refname)
 		return -1;
 	entry = dir->entries[entry_index];
 
-	memmove(&dir->entries[entry_index],
-		&dir->entries[entry_index + 1],
-		(dir->nr - entry_index - 1) * sizeof(*dir->entries)
+	MOVE_ARRAY(&dir->entries[entry_index], &dir->entries[entry_index + 1],
+		dir->nr - entry_index - 1
 		);
 	dir->nr--;
 	if (dir->sorted > entry_index)
diff --git a/replace_object.c b/replace_object.c
index f0b39f06d5..3e49965d05 100644
--- a/replace_object.c
+++ b/replace_object.c
@@ -44,10 +44,8 @@ static int register_replace_object(struct replace_object *replace,
 	ALLOC_GROW(replace_object, replace_object_nr + 1, replace_object_alloc);
 	replace_object_nr++;
 	if (pos < replace_object_nr)
-		memmove(replace_object + pos + 1,
-			replace_object + pos,
-			(replace_object_nr - pos - 1) *
-			sizeof(*replace_object));
+		MOVE_ARRAY(replace_object + pos + 1, replace_object + pos,
+			   replace_object_nr - pos - 1);
 	replace_object[pos] = replace;
 	return 0;
 }
diff --git a/rerere.c b/rerere.c
index 3bd55caf3b..7410445ba2 100644
--- a/rerere.c
+++ b/rerere.c
@@ -159,8 +159,8 @@ static struct rerere_dir *find_rerere_dir(const char *hex)
 		ALLOC_GROW(rerere_dir, rerere_dir_nr + 1, rerere_dir_alloc);
 		/* ... and add it in. */
 		rerere_dir_nr++;
-		memmove(rerere_dir + pos + 1, rerere_dir + pos,
-			(rerere_dir_nr - pos - 1) * sizeof(*rerere_dir));
+		MOVE_ARRAY(rerere_dir + pos + 1, rerere_dir + pos,
+			   rerere_dir_nr - pos - 1);
 		rerere_dir[pos] = rr_dir;
 		scan_rerere_dir(rr_dir);
 	}
diff --git a/string-list.c b/string-list.c
index 45016ad86d..df64d4c446 100644
--- a/string-list.c
+++ b/string-list.c
@@ -46,9 +46,8 @@ static int add_entry(int insert_at, struct string_list *list, const char *string
 		REALLOC_ARRAY(list->items, list->alloc);
 	}
 	if (index < list->nr)
-		memmove(list->items + index + 1, list->items + index,
-				(list->nr - index)
-				* sizeof(struct string_list_item));
+		MOVE_ARRAY(list->items + index + 1, list->items + index,
+			   list->nr - index);
 	list->items[index].string = list->strdup_strings ?
 		xstrdup(string) : (char *)string;
 	list->items[index].util = NULL;
-- 
2.12.2

