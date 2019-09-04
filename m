Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 32C341F461
	for <e@80x24.org>; Wed,  4 Sep 2019 20:26:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729727AbfIDU0H (ORCPT <rfc822;e@80x24.org>);
        Wed, 4 Sep 2019 16:26:07 -0400
Received: from mail-vs1-f66.google.com ([209.85.217.66]:37239 "EHLO
        mail-vs1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726495AbfIDU0H (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 4 Sep 2019 16:26:07 -0400
Received: by mail-vs1-f66.google.com with SMTP id q9so8617304vsl.4
        for <git@vger.kernel.org>; Wed, 04 Sep 2019 13:26:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ie054wCuQ+6+hVq5PGiTy+uzcZasJsKztZH6IRbcQz0=;
        b=aP8Z/44kJMYMxuuLJyNKhXZeJGpUBa3kjbto7/eg5TcQU6nu7avjdM+jr6BPluxoWu
         K0iaHfiSopOCeiwXqE7PQmwhCJ7OMZ38DhgaAsHhIm5zEnojOtMkZ7KJm8jnwi3U2PWC
         eSowifG7fYRpuJ7F/OKG1LaWS22MogKVHpWjJ3zaE7fTiXvb0F0Mk3yJWz26P6RmW/SF
         Zshrk01WdsCgwwgrQF0d0Tg0/KVU5+uC7hVRAWXCAOeHwZF4mmdZJUILMTjSOSsXhtw4
         b7x8grDaV6AX/0COvDrfe/UWGdNUcI49stIEKIbrR3ysfWfmwMCXM5uLH3RrLE57vvC4
         nbIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ie054wCuQ+6+hVq5PGiTy+uzcZasJsKztZH6IRbcQz0=;
        b=mioSkvPOr/Z76e41um7OOd1LZcAKgvQQgk7o4I3Kz8ey4s93J/vPLWcHJ/mxu9iMV0
         Q2f9m7S2hju+T8aVWt3TV+QSNQma1TkYDxraB0dsmBnVwzavuTCsG5uyTQl3lja7ZraQ
         PAc6Y85zUnafvpZho6QjvA3HgOjN4ztBLRWb7GXVfV5ETECV1g5AR8bomnkzxCTUHEFY
         lVIGES7tfsKOh6f4CUOTRDPlT6XNpAc3OTeetX96IsVnAs5fJlEsbINZ3dUyXVEGVObZ
         Ha9TENwBceuoV9+Z/z5kkO+w8fV7h5wuboEO8RiD1Vk1EYZHT6Y+8+dHdZ3K4ENn9Zrx
         jubw==
X-Gm-Message-State: APjAAAXvdsoT3ZW2jG323BH6yeVKDVuD5WuJ4YHyVQuAamgRR3cDAxk7
        ilJnt0t/ZU20uwMAuIQFK02qNkZDaNcaUAm+CNw=
X-Google-Smtp-Source: APXvYqxyywkSSgk7j0cxkvsuKbU5O94hMM7moGf39+ovKPpKvTTN6aR54T71hixTlec1IUvsALKjyXu0sza+3Y5yk+Y=
X-Received: by 2002:a67:c11b:: with SMTP id d27mr3894255vsj.175.1567628765286;
 Wed, 04 Sep 2019 13:26:05 -0700 (PDT)
MIME-Version: 1.0
References: <pull.329.git.gitgitgadget@gmail.com> <d9a62c76339b64325a13d5f483f673450aa90c2b.1567533893.git.gitgitgadget@gmail.com>
In-Reply-To: <d9a62c76339b64325a13d5f483f673450aa90c2b.1567533893.git.gitgitgadget@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Wed, 4 Sep 2019 13:25:54 -0700
Message-ID: <CABPp-BFsOynr0skVAgxuhjrdXoZknU86+m2ecnN3BN+fFEiDoA@mail.gmail.com>
Subject: Re: [PATCH 5/5] unpack-trees: rename 'is_excluded_from_list()'
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Sep 3, 2019 at 11:04 AM Derrick Stolee via GitGitGadget
<gitgitgadget@gmail.com> wrote:
>
> From: Derrick Stolee <dstolee@microsoft.com>
>
> The first consumer of pattern-matching filenames was the
> .gitignore feature. In that context, storing a list of patterns
> as a 'struct exclude_list'  makes sense. However, the
> sparse-checkout feature then adopted these structures and methods,
> but with the opposite meaning: these patterns match the files
> that should be included!
>
> Now that this library is renamed to use 'struct pattern_list'
> and 'struct pattern', we can now rename the method used by
> the sparse-checkout feature to determine which paths should
> appear in the working directory.
>
> The method is_excluded_from_list() is only used by the
> sparse-checkout logic in unpack-trees and list-objects-filter.
> The confusing part is that it returned 1 for "excluded" (i.e.
> it matches the list of exclusions) but that really manes that

s/manes/means/

> the path matched the list of patterns for _inclusion_ in the
> working directory.
>
> Rename the method to be path_matches_pattern_list() and have
> it return an explicit 'enum pattern_match_result'. Here, the
> values MATCHED = 1, UNMATCHED = 0, and UNDECIDED = -1 agree
> with the previous integer values. This shift allows future
> consumers to better understand what the retur values mean,

s/retur/return/

> and provides more type checking for handling those values.
>
> Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
> ---
>  dir.c                 | 25 +++++++++++++++++--------
>  dir.h                 | 21 +++++++++++++++++----
>  list-objects-filter.c | 29 +++++++++++++++--------------
>  unpack-trees.c        | 39 +++++++++++++++++++++++----------------
>  4 files changed, 72 insertions(+), 42 deletions(-)
>
> diff --git a/dir.c b/dir.c
> index b057bd3d95..34972abdaf 100644
> --- a/dir.c
> +++ b/dir.c
> @@ -1072,19 +1072,28 @@ static struct path_pattern *last_matching_pattern_from_list(const char *pathname
>  }
>
>  /*
> - * Scan the list and let the last match determine the fate.
> - * Return 1 for exclude, 0 for include and -1 for undecided.
> + * Scan the list of patterns to determine if the ordered list
> + * of patterns matches on 'pathname'.
> + *
> + * Return 1 for a match, 0 for not matched and -1 for undecided.

Maybe drop this last sentence since it's misleading, and since the
function signature already specifies that it returns an enum and the
enums have obvious meanings already?

>   */
> -int is_excluded_from_list(const char *pathname,
> -                         int pathlen, const char *basename, int *dtype,
> -                         struct pattern_list *pl, struct index_state *istate)
> +enum pattern_match_result path_matches_pattern_list(
> +                               const char *pathname, int pathlen,
> +                               const char *basename, int *dtype,
> +                               struct pattern_list *pl,
> +                               struct index_state *istate)
>  {
>         struct path_pattern *pattern;
>         pattern = last_matching_pattern_from_list(pathname, pathlen, basename,
>                                                   dtype, pl, istate);
> -       if (pattern)
> -               return pattern->flags & PATTERN_FLAG_NEGATIVE ? 0 : 1;
> -       return -1; /* undecided */
> +       if (pattern) {
> +               if (pattern->flags & PATTERN_FLAG_NEGATIVE)
> +                       return NOT_MATCHED;
> +               else
> +                       return MATCHED;
> +       }
> +
> +       return UNDECIDED;
>  }
>
>  static struct path_pattern *last_matching_pattern_from_lists(
> diff --git a/dir.h b/dir.h
> index 7babf31d88..608696c958 100644
> --- a/dir.h
> +++ b/dir.h
> @@ -230,10 +230,23 @@ int read_directory(struct dir_struct *, struct index_state *istate,
>                    const char *path, int len,
>                    const struct pathspec *pathspec);
>
> -int is_excluded_from_list(const char *pathname, int pathlen,
> -                         const char *basename, int *dtype,
> -                         struct pattern_list *pl,
> -                         struct index_state *istate);
> +enum pattern_match_result {
> +       UNDECIDED = -1,
> +       NOT_MATCHED = 0,
> +       MATCHED = 1,

Are we worried about preventing e.g. grep from using these names or
clashing with another lib (block-sha1?) that might choose to define
these?

> +};
> +
> +/*
> + * Scan the list of patterns to determine if the ordered list
> + * of patterns matches on 'pathname'.
> + *
> + * Return 1 for a match, 0 for not matched and -1 for undecided.

Again, I'd drop the last sentence.

> + */
> +enum pattern_match_result path_matches_pattern_list(const char *pathname,
> +                               int pathlen,
> +                               const char *basename, int *dtype,
> +                               struct pattern_list *pl,
> +                               struct index_state *istate);
>  struct dir_entry *dir_add_ignored(struct dir_struct *dir,
>                                   struct index_state *istate,
>                                   const char *pathname, int len);
> diff --git a/list-objects-filter.c b/list-objects-filter.c
> index ccd58e61c3..d624f1c898 100644
> --- a/list-objects-filter.c
> +++ b/list-objects-filter.c
> @@ -328,12 +328,12 @@ static void filter_blobs_limit__init(
>   */
>  struct frame {
>         /*
> -        * defval is the usual default include/exclude value that
> +        * default_match is the usual default include/exclude value that
>          * should be inherited as we recurse into directories based
>          * upon pattern matching of the directory itself or of a
>          * containing directory.
>          */
> -       int defval;
> +       enum pattern_match_result default_match;
>
>         /*
>          * 1 if the directory (recursively) contains any provisionally
> @@ -363,8 +363,9 @@ static enum list_objects_filter_result filter_sparse(
>         void *filter_data_)
>  {
>         struct filter_sparse_data *filter_data = filter_data_;
> -       int val, dtype;
> +       int dtype;
>         struct frame *frame;
> +       enum pattern_match_result match;
>
>         switch (filter_situation) {
>         default:
> @@ -373,15 +374,15 @@ static enum list_objects_filter_result filter_sparse(
>         case LOFS_BEGIN_TREE:
>                 assert(obj->type == OBJ_TREE);
>                 dtype = DT_DIR;
> -               val = is_excluded_from_list(pathname, strlen(pathname),
> -                                           filename, &dtype, &filter_data->pl,
> -                                           r->index);
> -               if (val < 0)
> -                       val = filter_data->array_frame[filter_data->nr - 1].defval;
> +               match = path_matches_pattern_list(pathname, strlen(pathname),
> +                                                 filename, &dtype, &filter_data->pl,
> +                                                 r->index);
> +               if (match == UNDECIDED)
> +                       match = filter_data->array_frame[filter_data->nr - 1].default_match;
>
>                 ALLOC_GROW(filter_data->array_frame, filter_data->nr + 1,
>                            filter_data->alloc);
> -               filter_data->array_frame[filter_data->nr].defval = val;
> +               filter_data->array_frame[filter_data->nr].default_match = match;
>                 filter_data->array_frame[filter_data->nr].child_prov_omit = 0;
>                 filter_data->nr++;
>
> @@ -435,12 +436,12 @@ static enum list_objects_filter_result filter_sparse(
>                 frame = &filter_data->array_frame[filter_data->nr - 1];
>
>                 dtype = DT_REG;
> -               val = is_excluded_from_list(pathname, strlen(pathname),
> +               match = path_matches_pattern_list(pathname, strlen(pathname),
>                                             filename, &dtype, &filter_data->pl,
>                                             r->index);
> -               if (val < 0)
> -                       val = frame->defval;
> -               if (val > 0) {
> +               if (match == UNDECIDED)
> +                       match = frame->default_match;
> +               if (match == MATCHED) {
>                         if (omits)
>                                 oidset_remove(omits, &obj->oid);
>                         return LOFR_MARK_SEEN | LOFR_DO_SHOW;
> @@ -487,7 +488,7 @@ static void filter_sparse_oid__init(
>                 die("could not load filter specification");
>
>         ALLOC_GROW(d->array_frame, d->nr + 1, d->alloc);
> -       d->array_frame[d->nr].defval = 0; /* default to include */
> +       d->array_frame[d->nr].default_match = 0; /* default to include */

s/0/MATCHED/ ?

>         d->array_frame[d->nr].child_prov_omit = 0;
>         d->nr++;
>
> diff --git a/unpack-trees.c b/unpack-trees.c
> index 902a799aeb..cd548f4fa2 100644
> --- a/unpack-trees.c
> +++ b/unpack-trees.c
> @@ -1265,7 +1265,8 @@ static int clear_ce_flags_1(struct index_state *istate,
>                             struct cache_entry **cache, int nr,
>                             struct strbuf *prefix,
>                             int select_mask, int clear_mask,
> -                           struct pattern_list *pl, int defval);
> +                           struct pattern_list *pl,
> +                           enum pattern_match_result default_match);
>
>  /* Whole directory matching */
>  static int clear_ce_flags_dir(struct index_state *istate,
> @@ -1273,19 +1274,21 @@ static int clear_ce_flags_dir(struct index_state *istate,
>                               struct strbuf *prefix,
>                               char *basename,
>                               int select_mask, int clear_mask,
> -                             struct pattern_list *pl, int defval)
> +                             struct pattern_list *pl,
> +                             enum pattern_match_result default_match)
>  {
>         struct cache_entry **cache_end;
>         int dtype = DT_DIR;
> -       int ret = is_excluded_from_list(prefix->buf, prefix->len,
> -                                       basename, &dtype, pl, istate);
>         int rc;
> +       enum pattern_match_result ret;
> +       ret = path_matches_pattern_list(prefix->buf, prefix->len,
> +                                       basename, &dtype, pl, istate);
>
>         strbuf_addch(prefix, '/');
>
>         /* If undecided, use matching result of parent dir in defval */
> -       if (ret < 0)
> -               ret = defval;
> +       if (ret == UNDECIDED)
> +               ret = default_match;
>
>         for (cache_end = cache; cache_end != cache + nr; cache_end++) {
>                 struct cache_entry *ce = *cache_end;
> @@ -1298,7 +1301,7 @@ static int clear_ce_flags_dir(struct index_state *istate,
>          * with ret (iow, we know in advance the incl/excl
>          * decision for the entire directory), clear flag here without
>          * calling clear_ce_flags_1(). That function will call
> -        * the expensive is_excluded_from_list() on every entry.
> +        * the expensive path_matches_pattern_list() on every entry.
>          */
>         rc = clear_ce_flags_1(istate, cache, cache_end - cache,
>                               prefix,
> @@ -1327,7 +1330,8 @@ static int clear_ce_flags_1(struct index_state *istate,
>                             struct cache_entry **cache, int nr,
>                             struct strbuf *prefix,
>                             int select_mask, int clear_mask,
> -                           struct pattern_list *pl, int defval)
> +                           struct pattern_list *pl,
> +                           enum pattern_match_result default_match)
>  {
>         struct cache_entry **cache_end = cache + nr;
>
> @@ -1338,7 +1342,8 @@ static int clear_ce_flags_1(struct index_state *istate,
>         while(cache != cache_end) {
>                 struct cache_entry *ce = *cache;
>                 const char *name, *slash;
> -               int len, dtype, ret;
> +               int len, dtype;
> +               enum pattern_match_result ret;
>
>                 if (select_mask && !(ce->ce_flags & select_mask)) {
>                         cache++;
> @@ -1362,7 +1367,7 @@ static int clear_ce_flags_1(struct index_state *istate,
>                                                        prefix,
>                                                        prefix->buf + prefix->len - len,
>                                                        select_mask, clear_mask,
> -                                                      pl, defval);
> +                                                      pl, default_match);
>
>                         /* clear_c_f_dir eats a whole dir already? */
>                         if (processed) {
> @@ -1374,18 +1379,20 @@ static int clear_ce_flags_1(struct index_state *istate,
>                         strbuf_addch(prefix, '/');
>                         cache += clear_ce_flags_1(istate, cache, cache_end - cache,
>                                                   prefix,
> -                                                 select_mask, clear_mask, pl, defval);
> +                                                 select_mask, clear_mask, pl,
> +                                                 default_match);
>                         strbuf_setlen(prefix, prefix->len - len - 1);
>                         continue;
>                 }
>
>                 /* Non-directory */
>                 dtype = ce_to_dtype(ce);
> -               ret = is_excluded_from_list(ce->name, ce_namelen(ce),
> -                                           name, &dtype, pl, istate);
> -               if (ret < 0)
> -                       ret = defval;
> -               if (ret > 0)
> +               ret = path_matches_pattern_list(ce->name,
> +                                               ce_namelen(ce),
> +                                               name, &dtype, pl, istate);
> +               if (ret == UNDECIDED)
> +                       ret = default_match;
> +               if (ret == MATCHED)
>                         ce->ce_flags &= ~clear_mask;
>                 cache++;
>         }
> --
> gitgitgadget

The rest looks good.
