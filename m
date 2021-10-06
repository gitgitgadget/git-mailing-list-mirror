Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79741C433EF
	for <git@archiver.kernel.org>; Wed,  6 Oct 2021 04:43:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 465FA611CA
	for <git@archiver.kernel.org>; Wed,  6 Oct 2021 04:43:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230358AbhJFEpS (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 6 Oct 2021 00:45:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229554AbhJFEpQ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Oct 2021 00:45:16 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D970CC061749
        for <git@vger.kernel.org>; Tue,  5 Oct 2021 21:43:24 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id p13so5059190edw.0
        for <git@vger.kernel.org>; Tue, 05 Oct 2021 21:43:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YIP6t9lTlqDZkt2InGAHJbR/ghRRiX/AyzBhM/vxM60=;
        b=hPgo1HmqcYjZoIv3NChuzt5eb4ScF2ypsbVJdnlTN+r3rkeKQI/RBSXDw4+0/xD4/p
         H/e41qqYjT9ULom73uVRLFvbj0x/elOXa+WNh/+Dm694XnLtdKczLqZvxrQI29kqkXYv
         GT54lp/dAl02B3HtIpEl2wqmj8GV2J07KYP0jobTfEaMQVLu3TGVxGSbfs1uBJJNgwdQ
         FrlKcayfP0DXXJlZo7jMUoO2fcCsp2E0M59kDVpshzNxU/81D96+0ECmO7RD8JMO0gAx
         5bkVYDWWdBX6PDr0okxkysytIG/bdNZOPGLuKjRvuwmIAuj8OxQ9TTVvknmAGDSfg+eY
         w/tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YIP6t9lTlqDZkt2InGAHJbR/ghRRiX/AyzBhM/vxM60=;
        b=ITg5qgNzTn3erswRwkpyvvIb6Iz9rGTcDJueQMmxIWgrWBx2X+0tP6adZbfArEhdWO
         Qm+SdcXvnZP7EvvUXbpQvW/OPFPvAjUc4e2dOc+Wmm6jmfB+VywYMLzF5FbjOltgoWK2
         6/DdTJq3nPWjYY3DXIh1EECykQ8P3v5goqmLL8k6xE5NH3QKW2vKBpuBuwioR+5tQMMd
         GZiq6i3rS6yKxbIunaY525jrm/it2L3AJ7rRNWAvqIFJms0/X7Cnabh72zz1qYDdqLFP
         lvEUrXBS3+ZENAA9FAc2MQOX48QX+6BnV7C4FIiy4S/lRqjqB13MKYFEP01x9h8ntLaV
         QH0A==
X-Gm-Message-State: AOAM532r1Tuyxa6V3SI4XQE/AkXxpBGkg0snGjNK+zNtmodtMDphivsu
        IDT9GnUeyKBHsoIgJpdcTgfw6sYf+4orpVTfofffzx3qnl0=
X-Google-Smtp-Source: ABdhPJw8DJjPGPP5B3uUWBZ07OvPG84tRM7XG3olvaHhxHljhY8/1YQXO9vRZ4GHoTQ+4MSjr5hFosnFTCOJn8rgykc=
X-Received: by 2002:a17:906:8cd:: with SMTP id o13mr28686390eje.341.1633495403369;
 Tue, 05 Oct 2021 21:43:23 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1048.git.1633013461.gitgitgadget@gmail.com>
 <pull.1048.v2.git.1633440057.gitgitgadget@gmail.com> <5eaae0825af4cee84040b784c32190bb1de2f919.1633440057.git.gitgitgadget@gmail.com>
In-Reply-To: <5eaae0825af4cee84040b784c32190bb1de2f919.1633440057.git.gitgitgadget@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Tue, 5 Oct 2021 21:43:11 -0700
Message-ID: <CABPp-BHDog6U1bFKurNq+sKbNPOnmqbhB8W2wg0UeF=jb+ZScw@mail.gmail.com>
Subject: Re: [PATCH v2 6/7] reset: make --mixed sparse-aware
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
> Sparse directory entries are "diffed" as trees in `diff_cache` (used
> internally by `reset --mixed`), following a code path separate from
> individual file handling. The use of `diff_tree_oid` there requires setting
> explicit `change` and `add_remove` functions to process the internal
> contents of a sparse directory.
>
> Additionally, the `recursive` diff option handles cases in which `reset
> --mixed` must diff/merge files that are nested multiple levels deep in a
> sparse directory.
>
> Signed-off-by: Victoria Dye <vdye@github.com>
> ---
>  builtin/reset.c                          | 30 +++++++++++++++++++++++-
>  t/t1092-sparse-checkout-compatibility.sh | 13 +++++++++-
>  2 files changed, 41 insertions(+), 2 deletions(-)
>
> diff --git a/builtin/reset.c b/builtin/reset.c
> index e1f2a2bb2c4..ceb9b122897 100644
> --- a/builtin/reset.c
> +++ b/builtin/reset.c
> @@ -175,6 +175,8 @@ static int read_from_tree(const struct pathspec *pathspec,
>                           int intent_to_add)
>  {
>         struct diff_options opt;
> +       unsigned int i;
> +       char *skip_worktree_seen = NULL;
>
>         memset(&opt, 0, sizeof(opt));
>         copy_pathspec(&opt.pathspec, pathspec);
> @@ -182,9 +184,35 @@ static int read_from_tree(const struct pathspec *pathspec,
>         opt.format_callback = update_index_from_diff;
>         opt.format_callback_data = &intent_to_add;
>         opt.flags.override_submodule_config = 1;
> +       opt.flags.recursive = 1;
>         opt.repo = the_repository;
> +       opt.change = diff_change;
> +       opt.add_remove = diff_addremove;
> +
> +       /*
> +        * When pathspec is given for resetting a cone-mode sparse checkout, it may
> +        * identify entries that are nested in sparse directories, in which case the
> +        * index should be expanded. For the sake of efficiency, this check is
> +        * overly-cautious: anything with a wildcard or a magic prefix requires
> +        * expansion, as well as literal paths that aren't in the sparse checkout
> +        * definition AND don't match any directory in the index.

s/efficiency/efficiency of checking/ ?  Being overly-cautious suggests
you'll expand to a full index more than is needed, and full indexes
are more expensive.  But perhaps the checking would be expensive too
so you have a tradeoff?

Or maybe s/efficiency/simplicity/?

> +        */
> +       if (pathspec->nr && the_index.sparse_index) {
> +               if (pathspec->magic || pathspec->has_wildcard) {
> +                       ensure_full_index(&the_index);

dir.c has the notion of matching the characters preceding the wildcard
characters; look for "no_wildcard_len".  If the pathspec doesn't match
a path up to no_wildcard_len, then the wildcard character(s) later in
the pathspec can't make the pathspec match that path.

It might at least be worth mentioning this as a possible future optimization.

> +               } else {
> +                       for (i = 0; i < pathspec->nr; i++) {
> +                               if (!path_in_cone_mode_sparse_checkout(pathspec->items[i].original, &the_index) &&
> +                                   !matches_skip_worktree(pathspec, i, &skip_worktree_seen)) {

What if the pathspec corresponds to a sparse-directory in the index,
but possibly without the trailing '/' character?  e.g.:

   git reset HEAD~1 -- sparse-directory

One should be able to reset that directory without recursing into
it...does this code handle that?  Does it handle it if we add the
trailing slash on the path for the reset command line?

> +                                       ensure_full_index(&the_index);
> +                                       break;
> +                               }
> +                       }
> +               }
> +       }
> +
> +       free(skip_worktree_seen);
>
> -       ensure_full_index(&the_index);
>         if (do_diff_cache(tree_oid, &opt))
>                 return 1;
>         diffcore_std(&opt);
> diff --git a/t/t1092-sparse-checkout-compatibility.sh b/t/t1092-sparse-checkout-compatibility.sh
> index e301ef5633a..4afcbc2d673 100755
> --- a/t/t1092-sparse-checkout-compatibility.sh
> +++ b/t/t1092-sparse-checkout-compatibility.sh
> @@ -804,11 +804,22 @@ test_expect_success 'sparse-index is not expanded' '
>                 ensure_not_expanded reset --hard $ref || return 1
>         done &&
>
> +       ensure_not_expanded reset --mixed base &&
>         ensure_not_expanded reset --hard update-deep &&
>         ensure_not_expanded reset --keep base &&
>         ensure_not_expanded reset --merge update-deep &&
> -       ensure_not_expanded reset --hard &&

This commit was only touching the --mixed case; why is it removing one
of the tests for --hard?

>
> +       ensure_not_expanded reset base -- deep/a &&
> +       ensure_not_expanded reset base -- nonexistent-file &&
> +       ensure_not_expanded reset deepest -- deep &&
> +
> +       # Although folder1 is outside the sparse definition, it exists as a
> +       # directory entry in the index, so it will be reset without needing to
> +       # expand the full index.

Ah, I think this answers one of my earlier questions.  Does it also
work with 'folder1/' as well as 'folder1'?

> +       ensure_not_expanded reset --hard update-folder1 &&

Wait...is update-folder1 a branch or a path?  And if this commit is
about --mixed, why are --hard testcases being added?

> +       ensure_not_expanded reset base -- folder1 &&
> +
> +       ensure_not_expanded reset --hard update-deep &&

another --hard testcase...was this an accidental squash by chance?



>         ensure_not_expanded checkout -f update-deep &&
>         test_config -C sparse-index pull.twohead ort &&
>         (
> --
> gitgitgadget
>
