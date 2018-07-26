Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5F6461F597
	for <e@80x24.org>; Thu, 26 Jul 2018 16:30:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731291AbeGZRsb (ORCPT <rfc822;e@80x24.org>);
        Thu, 26 Jul 2018 13:48:31 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:41801 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730030AbeGZRsa (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Jul 2018 13:48:30 -0400
Received: by mail-lf1-f68.google.com with SMTP id v22-v6so1625837lfe.8
        for <git@vger.kernel.org>; Thu, 26 Jul 2018 09:30:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=+KsT0yuhcawaFQzx7tnwpUTaNUkWSxxziWA4LVWE+HQ=;
        b=BvmnJ3hO1NwHVn9aXQl/ZVbiRqZnDjGdtS0bOfsaTadm0JTa2kttYjPUbOsJ99rSSr
         Mnh5U1nrY3kTSBuouiP0Hjko+uVCrXbR/NOYHwpLl1SlBaqCQCGioTt4+heI1tF5TssC
         QQMee37M8cAQ0rZJ8sjBVGEHZGzM4JdDvETGxmBpEqzR7msXeUQCFyPysbK5AjyCgjhL
         6ePvE0ww99OXH4EvwI/Wgv9JGH+YS/FopHPP2ELN0C4C5+tCZw32W9r1aAImbudkL8ic
         /6nW0nTQ78+mlmGdR+RF3B3j7kfzjnZCg3OY1uGdkbs7plaHCWSObLT2nQ1eIim/gOgS
         /qaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=+KsT0yuhcawaFQzx7tnwpUTaNUkWSxxziWA4LVWE+HQ=;
        b=bVB99ttkGKYEdD3Z1qcIZ3jya369qmuRtMHJlZyfr3af42YdV8+0HXVY3MDSRkdXTy
         yTEoQciy3MifjB2l1ITArN7mhofN1Wl7bHZBENCyUo2/0Lt4VnkKY/OozwfeBl3QLEB0
         BSi8BVhuEtwgr55Cn2mnjCrIW7b3SSFRJUMH/deo5OwdMtoei+9TXmigy9PzckqgIM4Z
         erckXqNSKsfqPf1JytovPtsmJKl50gyE6sRYqTq+Vy/VXSObVy3H8FRLOEQuXWHMJU7Q
         NFqmXKbadPmI7U4Q2vJN75SQJ5ngefpyk3rUZsYC9cyAjP4BlkOXTQi3lBld5FIZatwR
         XXWg==
X-Gm-Message-State: AOUpUlEf8wVvJhya9Hx/946iCTNon6jGlgKn8Mnb92FA+oHs8t/zAEcv
        IAciJimFNak5+kKhXqvRZpI=
X-Google-Smtp-Source: AAOMgpcD+RFmmS/L/uWp7RxgeNU7iuX7pBV1zGdUU15+6q3s844ZBzgeYJ8fYd7ZhQt6+Mem8HaVEA==
X-Received: by 2002:a19:1863:: with SMTP id o96-v6mr1949793lfi.134.1532622653825;
        Thu, 26 Jul 2018 09:30:53 -0700 (PDT)
Received: from duynguyen.home (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id r63-v6sm283257lja.18.2018.07.26.09.30.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 26 Jul 2018 09:30:52 -0700 (PDT)
Date:   Thu, 26 Jul 2018 18:30:49 +0200
From:   Duy Nguyen <pclouds@gmail.com>
To:     Ben Peart <peartben@gmail.com>
Cc:     Jeff King <peff@peff.net>, Ben Peart <Ben.Peart@microsoft.com>,
        Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v1 0/3] [RFC] Speeding up checkout (and merge, rebase,
 etc)
Message-ID: <20180726163049.GA15572@duynguyen.home>
References: <20180718204458.20936-1-benpeart@microsoft.com>
 <20180718213420.GA17291@sigill.intra.peff.net>
 <a2ad0044-f317-69f7-f2bb-488111c626fb@gmail.com>
 <CACsJy8D-3sSnoyQZKxeLK-2RmpJSGkziAp5Gf4QpUnxwnhchSQ@mail.gmail.com>
 <6ff6fbdc-d9cf-019f-317c-7fdba31105c6@gmail.com>
 <20180724042017.GA13248@sigill.intra.peff.net>
 <CACsJy8Du28jMyfdyhxpVxyw5+Xh+9eX==3x8YJSnmw6GAoRhTA@mail.gmail.com>
 <0102d204-8be7-618a-69f4-9f924c4e6731@gmail.com>
 <CACsJy8AWcHVYNBZGRUTdcg8FmwOGz3MSUHH+3uVSGrg6MMZMng@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACsJy8AWcHVYNBZGRUTdcg8FmwOGz3MSUHH+3uVSGrg6MMZMng@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jul 26, 2018 at 07:30:20AM +0200, Duy Nguyen wrote:
> Let's get back to two-way merge. I suggest you read the two-way merge
> in git-read-tree.txt. That table could give you a pretty good idea
> what's going on. twoway_merge() will be given a tuple of three entries
> (I, H, M) of the same path name, for every path. I think what we need
> is determine the condition where the outcome is known in advance, so
> that we can just skip walking the index for one directory. One of the
> checks we could do quickly is I==M or I==H (using cache-tree) and H==M
> (using tree hash).
> 
> The first obvious cases that we can optimize are
> 
> clean (H==M)
>        ------
>      14 yes                 exists   exists   keep index
>      15 no                  exists   exists   keep index
> 
> In other words if we know H==M, there's no much we need to do since
> we're keeping the index the same. But you don't really know how many
> entries are in this directory where H==M. You would need cache-tree
> for that, so in reality it's I==H==M.
> 
> The "clean" column is what fsmonitor comes in, though I'm not sure if
> it's actually needed. I haven't checked how '-u' flag works.
> 
> There's two other cases that we can also optimize, though I think it's
> less likely to happen:
> 
>         clean I==H  I==M (H!=M)
>        ------------------
>      18 yes   no    yes     exists   exists   keep index
>      19 no    no    yes     exists   exists   keep index
> 
> Some other cases where I==H can benefit from the generic tree walk
> optimization above since we can skip parsing H.

I'm excited so I decided to try out anyway. This is what I've come up
with. Switching trees on git.git shows it could skip plenty entries,
so promising. It's ugly and it fails at t6020 though, there's still
work ahead. But I think it'll stop here.

A few notes after getting my hands dirty

- one big difference between diff --cached and checkout is, diff is a
  read-only operation while checkout actually creates new index.  One
  of the side effect is that cache-tree may be destroyed while we're
  walking the trees, i'm not so sure.

- I don't think we even need to a special twoway_merge_same()
  here. That function could just call twoway_merge() with the right
  "src" parameter and the outcome should still be the same. Which
  means it'll work for threeway merge too.

- i'm still scared of that cache_bottom switching to death. no idea
  how it works or if i broke anything by changing the condition there.

-- 8< --
diff --git a/builtin/checkout.c b/builtin/checkout.c
index 28627650cd..276712af64 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -515,6 +515,7 @@ static int merge_working_tree(const struct checkout_opts *opts,
 		topts.gently = opts->merge && old_branch_info->commit;
 		topts.verbose_update = opts->show_progress;
 		topts.fn = twoway_merge;
+		topts.fn_same = twoway_merge_same;
 		if (opts->overwrite_ignore) {
 			topts.dir = xcalloc(1, sizeof(*topts.dir));
 			topts.dir->flags |= DIR_SHOW_IGNORED;
diff --git a/diff-lib.c b/diff-lib.c
index a9f38eb5a3..48e6c4ab0d 100644
--- a/diff-lib.c
+++ b/diff-lib.c
@@ -485,6 +485,15 @@ static int oneway_diff(const struct cache_entry * const *src,
 	return 0;
 }
 
+static int oneway_diff_cached(int pos, int nr, struct unpack_trees_options *options)
+{
+	/*
+	 * Nothing to do. Unpack-trees can safely skip the whole
+	 * nr_matches cache entries.
+	 */
+	return 0;
+}
+
 static int diff_cache(struct rev_info *revs,
 		      const struct object_id *tree_oid,
 		      const char *tree_name,
@@ -501,8 +510,8 @@ static int diff_cache(struct rev_info *revs,
 	memset(&opts, 0, sizeof(opts));
 	opts.head_idx = 1;
 	opts.index_only = cached;
-	opts.diff_index_cached = (cached &&
-				  !revs->diffopt.flags.find_copies_harder);
+	if (cached && !revs->diffopt.flags.find_copies_harder)
+		opts.fn_same = oneway_diff_cached;
 	opts.merge = 1;
 	opts.fn = oneway_diff;
 	opts.unpack_data = revs;
diff --git a/unpack-trees.c b/unpack-trees.c
index 66741130ae..01e3f38807 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -615,7 +615,7 @@ static void restore_cache_bottom(struct traverse_info *info, int bottom)
 {
 	struct unpack_trees_options *o = info->data;
 
-	if (o->diff_index_cached)
+	if (o->fn_same)
 		return;
 	o->cache_bottom = bottom;
 }
@@ -625,7 +625,7 @@ static int switch_cache_bottom(struct traverse_info *info)
 	struct unpack_trees_options *o = info->data;
 	int ret, pos;
 
-	if (o->diff_index_cached)
+	if (o->fn_same)
 		return 0;
 	ret = o->cache_bottom;
 	pos = find_cache_pos(info->prev, &info->name);
@@ -996,6 +996,43 @@ static void debug_unpack_callback(int n,
 		debug_name_entry(i, names + i);
 }
 
+static int skip_dir(int n, unsigned long mask, unsigned long dirmask, struct name_entry *names, struct traverse_info *info)
+{
+	struct unpack_trees_options *o = info->data;
+	int i, matches;
+	int len;
+	char *name;
+	int pos;
+
+	if (dirmask != ((1 << n) - 1) || !S_ISDIR(names->mode))
+		return 0;
+
+	for (i = 1; i < n; i++)
+		if (oidcmp(names[0].oid, names[i].oid))
+			return 0;
+
+	matches = cache_tree_matches_traversal(o->src_index->cache_tree, names, info);
+	if (!matches)
+		return 0;
+
+	/*
+	 * Everything under the name matches; skip the entire
+	 * hierarchy. fn_same must special cases D/F conflicts in such
+	 * a way that it does not do any look-ahead, so this is safe.
+	 */
+	len = traverse_path_len(info, names);
+	name = xmalloc(len + 1);
+
+	make_traverse_path(name, info, names);
+	pos = index_name_pos(o->src_index, name, len);
+	if (pos >= 0)
+		die("NOOO");
+	trace_printf("dirmask = %lx, path = %s\n", dirmask, name);
+	if (o->fn_same(-pos-1, matches, o))
+		matches = 0;
+	free(name);
+	return matches;
+}
 static int unpack_callback(int n, unsigned long mask, unsigned long dirmask, struct name_entry *names, struct traverse_info *info)
 {
 	struct cache_entry *src[MAX_UNPACK_TREES + 1] = { NULL, };
@@ -1015,7 +1052,7 @@ static int unpack_callback(int n, unsigned long mask, unsigned long dirmask, str
 			int cmp;
 			struct cache_entry *ce;
 
-			if (o->diff_index_cached)
+			if (o->fn_same)
 				ce = next_cache_entry(o);
 			else
 				ce = find_cache_entry(info, p);
@@ -1059,18 +1096,8 @@ static int unpack_callback(int n, unsigned long mask, unsigned long dirmask, str
 
 	/* Now handle any directories.. */
 	if (dirmask) {
-		/* special case: "diff-index --cached" looking at a tree */
-		if (o->diff_index_cached &&
-		    n == 1 && dirmask == 1 && S_ISDIR(names->mode)) {
-			int matches;
-			matches = cache_tree_matches_traversal(o->src_index->cache_tree,
-							       names, info);
-			/*
-			 * Everything under the name matches; skip the
-			 * entire hierarchy.  diff_index_cached codepath
-			 * special cases D/F conflicts in such a way that
-			 * it does not do any look-ahead, so this is safe.
-			 */
+		if (o->fn_same) {
+			int matches = skip_dir(n, mask, dirmask, names, info);
 			if (matches) {
 				o->cache_bottom += matches;
 				return mask;
@@ -1881,6 +1908,7 @@ static int deleted_entry(const struct cache_entry *ce,
 static int keep_entry(const struct cache_entry *ce,
 		      struct unpack_trees_options *o)
 {
+	trace_printf("keep_entry(%s)\n", ce->name);
 	add_entry(o, ce, 0, 0);
 	return 1;
 }
@@ -2132,6 +2160,25 @@ int twoway_merge(const struct cache_entry * const *src,
 	return deleted_entry(oldtree, current, o);
 }
 
+int twoway_merge_same(int pos, int nr, struct unpack_trees_options *o)
+{
+	int i;
+
+	/*
+	 * Since cache-tree at "src" exists, it means there's no
+	 * staged entries here (they would have invalidated cache-tree
+	 * otherwise). So no CE_CONFLICTED.
+	 *
+	 * And because I==H==M, we can't run into d/f conflicts
+	 * either: for every path name, we will always find a _file_
+	 * in the index as well as the two other trees.
+	 */
+	trace_printf("Skipping %d entries\n", nr);
+	for (i = 0; i < nr; i++)
+		keep_entry(o->src_index->cache[pos + i], o);
+	return 0;
+}
+
 /*
  * Bind merge.
  *
diff --git a/unpack-trees.h b/unpack-trees.h
index c2b434c606..45c69e2ed0 100644
--- a/unpack-trees.h
+++ b/unpack-trees.h
@@ -12,6 +12,9 @@ struct exclude_list;
 typedef int (*merge_fn_t)(const struct cache_entry * const *src,
 		struct unpack_trees_options *options);
 
+typedef int (*merge_same_fn_t)(int pos, int nr,
+			       struct unpack_trees_options *options);
+
 enum unpack_trees_error_types {
 	ERROR_WOULD_OVERWRITE = 0,
 	ERROR_NOT_UPTODATE_FILE,
@@ -49,7 +52,6 @@ struct unpack_trees_options {
 		     aggressive,
 		     skip_unmerged,
 		     initial_checkout,
-		     diff_index_cached,
 		     debug_unpack,
 		     skip_sparse_checkout,
 		     gently,
@@ -61,6 +63,7 @@ struct unpack_trees_options {
 	struct dir_struct *dir;
 	struct pathspec *pathspec;
 	merge_fn_t fn;
+	merge_same_fn_t fn_same;
 	const char *msgs[NB_UNPACK_TREES_ERROR_TYPES];
 	struct argv_array msgs_to_free;
 	/*
@@ -92,6 +95,8 @@ int threeway_merge(const struct cache_entry * const *stages,
 		   struct unpack_trees_options *o);
 int twoway_merge(const struct cache_entry * const *src,
 		 struct unpack_trees_options *o);
+int twoway_merge_same(int pos, int nr,
+		      struct unpack_trees_options *o);
 int bind_merge(const struct cache_entry * const *src,
 	       struct unpack_trees_options *o);
 int oneway_merge(const struct cache_entry * const *src,
-- 8< --
