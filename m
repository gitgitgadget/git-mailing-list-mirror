Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EEE2C433F5
	for <git@archiver.kernel.org>; Wed,  6 Oct 2021 03:43:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1E91261248
	for <git@archiver.kernel.org>; Wed,  6 Oct 2021 03:43:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237173AbhJFDpT (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 5 Oct 2021 23:45:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230261AbhJFDpR (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Oct 2021 23:45:17 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D473C061749
        for <git@vger.kernel.org>; Tue,  5 Oct 2021 20:43:26 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id b8so4491804edk.2
        for <git@vger.kernel.org>; Tue, 05 Oct 2021 20:43:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=g1Uytodl8uKayARWo5HwNr5AQ6IHxOdH6WE3XLVo6Ao=;
        b=KFHrK0lB7BUtlOLrthMP9nivT4St3X7uvzJQrXdP+pqsv9XBj/qKU9p5nTKVXlrlr8
         Ooz8LC/pb2tuivWScerWI2GrsnWeDv193UBRtUemIrCVavdXZNJ/+GKs3BZ9tQO4jism
         AMVoNB9d/LXQfZJqdYLTYVd6xrfiGjF5F2dIfW78Pj7mI+SJXKd8lykTH04XJoZsCzGl
         vXeQRoIZoX4kRr6zymgO+zfc8eDwEtCp8EMqbxdK9moyCSKIXTztJ/piC2K41BEk0VKn
         iTDzeMxytEi/97G4JDUZbqv+AlG3mmUA4I27aZCQixJ2wADyn5RechoeWy8EPB3EHqpL
         wKAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=g1Uytodl8uKayARWo5HwNr5AQ6IHxOdH6WE3XLVo6Ao=;
        b=fIaoAAaAuSo5/S9yP3ExQqmv1uO9edwAmFaB1jbLYa7Y2hJdvIE7N2GSLZmL5rOrnS
         bL6BOvIGYXv5nquTtxD5HYLCfAmB2n68glRVijGlpAZ9Rm0ikTcPMtyz7OVuiU4B99KB
         xoio3WlsaER/nzkQNu1TQJnDSaW9Mjsc3GX7exePEArZlz+HHbc7jFgN+/+y75PoDLF0
         ENy5lQofLyW9lkaw21bf3+F5YJZ4x6ya9W+qqkctw7XnaFx73hxe369ga6QJ4f+A6y+r
         j5cr+lAhlFo7lwnWHezjFVEnbrdnvbGxbNoqHQTaoohWLC6O3pP2Bgj0GcS4xYzUFB7P
         JTqA==
X-Gm-Message-State: AOAM530OykAJwGWtaFnlYzgr/Hkue+HKn2svw+jN63nVrrZ/qCd0KzfJ
        eOI0RUx+pwZP+Aogp+9IEyuFoOZXloCrSuza0qpTsMiKW20=
X-Google-Smtp-Source: ABdhPJxO08uizJ82SOwasYTjVJdA54FiVLQRf1dHjgPfbdoWhIicMout9ESmf6VcJ2h56AWpqHwd7f5jyOYI7itLmCY=
X-Received: by 2002:aa7:cfc4:: with SMTP id r4mr31215124edy.244.1633491804589;
 Tue, 05 Oct 2021 20:43:24 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1048.git.1633013461.gitgitgadget@gmail.com>
 <pull.1048.v2.git.1633440057.gitgitgadget@gmail.com> <78cd85d8dcc790251ce8235e649902cf6adf091a.1633440057.git.gitgitgadget@gmail.com>
In-Reply-To: <78cd85d8dcc790251ce8235e649902cf6adf091a.1633440057.git.gitgitgadget@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Tue, 5 Oct 2021 20:43:13 -0700
Message-ID: <CABPp-BFHNOMTerrV2Bhufb5d9d6JuM+CWW_t1jYg1Uu7F1dhhA@mail.gmail.com>
Subject: Re: [PATCH v2 5/7] reset: make sparse-aware (except --mixed)
To:     Victoria Dye via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Derrick Stolee <stolee@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Taylor Blau <me@ttaylorr.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Victoria Dye <vdye@github.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Oct 5, 2021 at 6:21 AM Victoria Dye via GitGitGadget
<gitgitgadget@gmail.com> wrote:
>
> From: Victoria Dye <vdye@github.com>
>
> In order to accurately reconstruct the cache tree in `prime_cache_tree_rec`,
> the function must determine whether the currently-processing directory in
> the tree is sparse or not. If it is not sparse, the tree is parsed and
> subtree recursively constructed. If it is sparse, no subtrees are added to
> the tree and the entry count is set to 1 (representing the sparse directory
> itself).
>
> Signed-off-by: Victoria Dye <vdye@github.com>
> ---
>  cache-tree.c                             | 44 +++++++++++++++++++++---
>  cache.h                                  | 10 ++++++
>  read-cache.c                             | 22 ++++++++----
>  t/t1092-sparse-checkout-compatibility.sh | 15 ++++++--
>  4 files changed, 78 insertions(+), 13 deletions(-)
>
> diff --git a/cache-tree.c b/cache-tree.c
> index 9be19c85b66..9021669d682 100644
> --- a/cache-tree.c
> +++ b/cache-tree.c
> @@ -740,15 +740,29 @@ out:
>         return ret;
>  }
>
> +static void prime_cache_tree_sparse_dir(struct repository *r,
> +                                       struct cache_tree *it,
> +                                       struct tree *tree,
> +                                       struct strbuf *tree_path)
> +{
> +
> +       oidcpy(&it->oid, &tree->object.oid);
> +       it->entry_count = 1;
> +       return;

Why are 'r' and 'tree_path' passed to this function?

> +}
> +
>  static void prime_cache_tree_rec(struct repository *r,
>                                  struct cache_tree *it,
> -                                struct tree *tree)
> +                                struct tree *tree,
> +                                struct strbuf *tree_path)
>  {
> +       struct strbuf subtree_path = STRBUF_INIT;
>         struct tree_desc desc;
>         struct name_entry entry;
>         int cnt;
>
>         oidcpy(&it->oid, &tree->object.oid);
> +

Why the blank line addition here?

>         init_tree_desc(&desc, tree->buffer, tree->size);
>         cnt = 0;
>         while (tree_entry(&desc, &entry)) {
> @@ -757,27 +771,49 @@ static void prime_cache_tree_rec(struct repository *r,
>                 else {
>                         struct cache_tree_sub *sub;
>                         struct tree *subtree = lookup_tree(r, &entry.oid);
> +
>                         if (!subtree->object.parsed)
>                                 parse_tree(subtree);
>                         sub = cache_tree_sub(it, entry.path);
>                         sub->cache_tree = cache_tree();
> -                       prime_cache_tree_rec(r, sub->cache_tree, subtree);

> +                       strbuf_reset(&subtree_path);
> +                       strbuf_grow(&subtree_path, tree_path->len + entry.pathlen + 1);
> +                       strbuf_addbuf(&subtree_path, tree_path);
> +                       strbuf_add(&subtree_path, entry.path, entry.pathlen);
> +                       strbuf_addch(&subtree_path, '/');

Reconstructing the full path each time?  And despite only being useful
for the sparse-index case?

Would it be better to drop subtree_path from this function, then
append entry.path + '/' here to tree_path, and then after the if-block
below, call strbuf_setlen to remove the part that this function call
added?  That way, we don't need subtree_path, and don't have to copy
the leading path every time.

Also, maybe it'd be better to only do this strbuf manipulation if
r->index->sparse_index, since it's not ever used otherwise?

> +
> +                       /*
> +                        * If a sparse index is in use, the directory being processed may be
> +                        * sparse. To confirm that, we can check whether an entry with that
> +                        * exact name exists in the index. If it does, the created subtree
> +                        * should be sparse. Otherwise, cache tree expansion should continue
> +                        * as normal.
> +                        */
> +                       if (r->index->sparse_index &&
> +                           index_entry_exists(r->index, subtree_path.buf, subtree_path.len))
> +                               prime_cache_tree_sparse_dir(r, sub->cache_tree, subtree, &subtree_path);
> +                       else
> +                               prime_cache_tree_rec(r, sub->cache_tree, subtree, &subtree_path);
>                         cnt += sub->cache_tree->entry_count;
>                 }
>         }
>         it->entry_count = cnt;
> +
> +       strbuf_release(&subtree_path);
>  }
>
>  void prime_cache_tree(struct repository *r,
>                       struct index_state *istate,
>                       struct tree *tree)
>  {
> +       struct strbuf tree_path = STRBUF_INIT;
> +
>         trace2_region_enter("cache-tree", "prime_cache_tree", the_repository);
>         cache_tree_free(&istate->cache_tree);
>         istate->cache_tree = cache_tree();
>
> -       ensure_full_index(istate);
> -       prime_cache_tree_rec(r, istate->cache_tree, tree);
> +       prime_cache_tree_rec(r, istate->cache_tree, tree, &tree_path);
> +       strbuf_release(&tree_path);
>         istate->cache_changed |= CACHE_TREE_CHANGED;
>         trace2_region_leave("cache-tree", "prime_cache_tree", the_repository);
>  }
> diff --git a/cache.h b/cache.h
> index f6295f3b048..1d3e4665562 100644
> --- a/cache.h
> +++ b/cache.h
> @@ -816,6 +816,16 @@ struct cache_entry *index_file_exists(struct index_state *istate, const char *na
>   */
>  int index_name_pos(struct index_state *, const char *name, int namelen);
>
> +/*
> + * Determines whether an entry with the given name exists within the
> + * given index. The return value is 1 if an exact match is found, otherwise
> + * it is 0. Note that, unlike index_name_pos, this function does not expand
> + * the index if it is sparse. If an item exists within the full index but it
> + * is contained within a sparse directory (and not in the sparse index), 0 is
> + * returned.
> + */
> +int index_entry_exists(struct index_state *, const char *name, int namelen);
> +
>  /*
>   * Some functions return the negative complement of an insert position when a
>   * precise match was not found but a position was found where the entry would
> diff --git a/read-cache.c b/read-cache.c
> index f5d4385c408..ea1166895f8 100644
> --- a/read-cache.c
> +++ b/read-cache.c
> @@ -551,7 +551,10 @@ int cache_name_stage_compare(const char *name1, int len1, int stage1, const char
>         return 0;
>  }
>
> -static int index_name_stage_pos(struct index_state *istate, const char *name, int namelen, int stage)
> +static int index_name_stage_pos(struct index_state *istate,
> +                               const char *name, int namelen,
> +                               int stage,
> +                               int search_sparse)

It'd be nicer to make search_sparse an enum defined within this file, so that...

>  {
>         int first, last;
>
> @@ -570,7 +573,7 @@ static int index_name_stage_pos(struct index_state *istate, const char *name, in
>                 first = next+1;
>         }
>
> -       if (istate->sparse_index &&
> +       if (search_sparse && istate->sparse_index &&
>             first > 0) {
>                 /* Note: first <= istate->cache_nr */
>                 struct cache_entry *ce = istate->cache[first - 1];
> @@ -586,7 +589,7 @@ static int index_name_stage_pos(struct index_state *istate, const char *name, in
>                     ce_namelen(ce) < namelen &&
>                     !strncmp(name, ce->name, ce_namelen(ce))) {
>                         ensure_full_index(istate);
> -                       return index_name_stage_pos(istate, name, namelen, stage);
> +                       return index_name_stage_pos(istate, name, namelen, stage, search_sparse);
>                 }
>         }
>
> @@ -595,7 +598,12 @@ static int index_name_stage_pos(struct index_state *istate, const char *name, in
>
>  int index_name_pos(struct index_state *istate, const char *name, int namelen)
>  {
> -       return index_name_stage_pos(istate, name, namelen, 0);
> +       return index_name_stage_pos(istate, name, namelen, 0, 1);

...this could use SEARCH_SPARSE or some name like that which is more
meaningful than "1" here.

> +}
> +
> +int index_entry_exists(struct index_state *istate, const char *name, int namelen)
> +{
> +       return index_name_stage_pos(istate, name, namelen, 0, 0) >= 0;

...and likewise this spot could use SEARCH_FULL or some name like
that, which is more meaningful than the second "0".

Similarly for multiple call sites below...


>  }
>
>  int remove_index_entry_at(struct index_state *istate, int pos)
> @@ -1222,7 +1230,7 @@ static int has_dir_name(struct index_state *istate,
>                          */
>                 }
>
> -               pos = index_name_stage_pos(istate, name, len, stage);
> +               pos = index_name_stage_pos(istate, name, len, stage, 1);
>                 if (pos >= 0) {
>                         /*
>                          * Found one, but not so fast.  This could
> @@ -1322,7 +1330,7 @@ static int add_index_entry_with_check(struct index_state *istate, struct cache_e
>                 strcmp(ce->name, istate->cache[istate->cache_nr - 1]->name) > 0)
>                 pos = index_pos_to_insert_pos(istate->cache_nr);
>         else
> -               pos = index_name_stage_pos(istate, ce->name, ce_namelen(ce), ce_stage(ce));
> +               pos = index_name_stage_pos(istate, ce->name, ce_namelen(ce), ce_stage(ce), 1);
>
>         /* existing match? Just replace it. */
>         if (pos >= 0) {
> @@ -1357,7 +1365,7 @@ static int add_index_entry_with_check(struct index_state *istate, struct cache_e
>                 if (!ok_to_replace)
>                         return error(_("'%s' appears as both a file and as a directory"),
>                                      ce->name);
> -               pos = index_name_stage_pos(istate, ce->name, ce_namelen(ce), ce_stage(ce));
> +               pos = index_name_stage_pos(istate, ce->name, ce_namelen(ce), ce_stage(ce), 1);
>                 pos = -pos-1;
>         }
>         return pos + 1;
> diff --git a/t/t1092-sparse-checkout-compatibility.sh b/t/t1092-sparse-checkout-compatibility.sh
> index f0723a6ac97..e301ef5633a 100755
> --- a/t/t1092-sparse-checkout-compatibility.sh
> +++ b/t/t1092-sparse-checkout-compatibility.sh
> @@ -786,9 +786,9 @@ test_expect_success 'sparse-index is not expanded' '
>         ensure_not_expanded checkout - &&
>         ensure_not_expanded switch rename-out-to-out &&
>         ensure_not_expanded switch - &&
> -       git -C sparse-index reset --hard &&
> +       ensure_not_expanded reset --hard &&
>         ensure_not_expanded checkout rename-out-to-out -- deep/deeper1 &&
> -       git -C sparse-index reset --hard &&
> +       ensure_not_expanded reset --hard &&
>         ensure_not_expanded restore -s rename-out-to-out -- deep/deeper1 &&
>
>         echo >>sparse-index/README.md &&
> @@ -798,6 +798,17 @@ test_expect_success 'sparse-index is not expanded' '
>         echo >>sparse-index/untracked.txt &&
>         ensure_not_expanded add . &&
>
> +       for ref in update-deep update-folder1 update-folder2 update-deep
> +       do
> +               echo >>sparse-index/README.md &&
> +               ensure_not_expanded reset --hard $ref || return 1
> +       done &&
> +
> +       ensure_not_expanded reset --hard update-deep &&
> +       ensure_not_expanded reset --keep base &&
> +       ensure_not_expanded reset --merge update-deep &&
> +       ensure_not_expanded reset --hard &&
> +
>         ensure_not_expanded checkout -f update-deep &&
>         test_config -C sparse-index pull.twohead ort &&
>         (
> --
> gitgitgadget
