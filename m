Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74F5FC433EF
	for <git@archiver.kernel.org>; Wed,  6 Oct 2021 01:46:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 49E6660FC1
	for <git@archiver.kernel.org>; Wed,  6 Oct 2021 01:46:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236969AbhJFBss (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 5 Oct 2021 21:48:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229908AbhJFBss (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Oct 2021 21:48:48 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3EE7C061749
        for <git@vger.kernel.org>; Tue,  5 Oct 2021 18:46:56 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id f9so3666723edx.4
        for <git@vger.kernel.org>; Tue, 05 Oct 2021 18:46:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Y8F+/MhkD3cyQBOF8OMpKCo2jWHqoh7to6lSObFnPHE=;
        b=NzgLQqAOD3jy+G0jutJ6ZsXqowS9qyw3GTvHvWVu2dZaatLtPZG9UL+XxrkLxEB70V
         S4pUl4R7iLOenY+2XEjlMRgDyHa+/TaoH5IIByjwuJrJWPXmo7kBun68kICccyfby+Ra
         9Gl/C7sIIBAbXerjR+jwSRpcSVPDsYehIdcx6QL7IuZXu+WzpDe2LOpEzSDYl7vZqLbt
         jUmTDplwQ2btVv2KoRpTjy4e+xgZF1VGv09MjItkDWuddM4nnFay3pksF6H8ZThqmJdv
         oqUIU+g6WOFYbkkPJixNZY1byAft7a4Qj7r07GR4kdTzXSt/fzIhxYrUfp2pkaYE1nQJ
         kMow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Y8F+/MhkD3cyQBOF8OMpKCo2jWHqoh7to6lSObFnPHE=;
        b=tjge06N1AdytYuNKMNo7nzb2VW0+IOCruNz5Ki4yQzATPxTlG001bq+pwLWL/hTBD4
         lKdYY09GbKQzS4yDcmGqPt9Xwmm4l+CWX/KgJxSl3+qEufmRJf8Be4PpXglN9CPH6IBM
         8oXXnwLpIOl0kQR6x3QomtT2wTPJ0DpoLApsKFJDcKc4RaZgLWdrqBcfVq/EP8S7py4E
         U704G88u+HTKTGb2+OfOgXXZ5VCNOkyCKxk3cnpS/wGnB8JkjjR9neNp4QL4dNrTKBaj
         qMLPJrtYQ0QLeCKrq8GYejaTgnYDw+316N6hjExpOjUua6UhWqTvng2StdQooA2SeTti
         sFIg==
X-Gm-Message-State: AOAM533VUxKLflsn3QPOoWX4MrYii3/6D7XYd2gMdkvCz+CeM/rGxVmX
        yvW4VTuU2igdKECVd6JXF0xXsXoB3UwK4syFne2ZgKwrEjBtvw==
X-Google-Smtp-Source: ABdhPJwp+n8wg1iYH14cApuVAwRkoizpRcYedmPzMZkx+SWIrgwX1iUAWj7+EKnSvBE/tirAwqMz7MF94pxCpB3kuoc=
X-Received: by 2002:a17:906:8cd:: with SMTP id o13mr27934178eje.341.1633484815079;
 Tue, 05 Oct 2021 18:46:55 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1048.git.1633013461.gitgitgadget@gmail.com>
 <pull.1048.v2.git.1633440057.gitgitgadget@gmail.com> <22c69bc60308fef13acd7c3aab4e11e175c89440.1633440057.git.gitgitgadget@gmail.com>
In-Reply-To: <22c69bc60308fef13acd7c3aab4e11e175c89440.1633440057.git.gitgitgadget@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Tue, 5 Oct 2021 18:46:43 -0700
Message-ID: <CABPp-BFFG=puwpB4Gz8nWU=CNMUrLbH7XPTkpSGqWedTK2NWLg@mail.gmail.com>
Subject: Re: [PATCH v2 1/7] reset: behave correctly with sparse-checkout
To:     Kevin Willford via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Derrick Stolee <stolee@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Taylor Blau <me@ttaylorr.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Victoria Dye <vdye@github.com>,
        Kevin Willford <kewillf@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi!

It appears Junio has already commented on this patch and in more
detail, but since I already typed up some comments I'll send them
along in case they are useful.

On Tue, Oct 5, 2021 at 6:20 AM Kevin Willford via GitGitGadget
<gitgitgadget@gmail.com> wrote:
>
> From: Kevin Willford <kewillf@microsoft.com>
>
> When using the sparse checkout feature, 'git reset' will add entries to
> the index that will have the skip-worktree bit off but will leave the
> working directory empty.

Yes, that seems like a problem.

> File data is lost because the index version of
> the files has been changed but there is nothing that is in the working
> directory. This will cause the next 'git status' call to show either
> deleted for files modified or deleting or nothing for files added. The
> added files should be shown as untracked and modified files should be
> shown as modified.

Why is the solution to add the files to the working tree rather than
to make sure the files have the skip-worktree bit set?  That's not at
all what I would have expected.

> To fix this when the reset is running if there is not a file in the
> working directory and if it will be missing with the new index entry or
> was not missing in the previous version, we create the previous index
> version of the file in the working directory so that status will report
> correctly and the files will be availble for the user to deal with.

s/availble/available/

>
> This fixes a documented failure from t1092 that was created in 19a0acc
> (t1092: test interesting sparse-checkout scenarios, 2021-01-23).
>
> Signed-off-by: Kevin Willford <kewillf@microsoft.com>
> Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
> Signed-off-by: Victoria Dye <vdye@github.com>
> ---
>  builtin/reset.c                          | 24 ++++++++--
>  t/t1092-sparse-checkout-compatibility.sh |  4 +-
>  t/t7114-reset-sparse-checkout.sh         | 61 ++++++++++++++++++++++++
>  3 files changed, 83 insertions(+), 6 deletions(-)
>  create mode 100755 t/t7114-reset-sparse-checkout.sh
>
> diff --git a/builtin/reset.c b/builtin/reset.c
> index 51c9e2f43ff..3b75d3b2f20 100644
> --- a/builtin/reset.c
> +++ b/builtin/reset.c
> @@ -25,6 +25,8 @@
>  #include "cache-tree.h"
>  #include "submodule.h"
>  #include "submodule-config.h"
> +#include "dir.h"
> +#include "entry.h"
>
>  #define REFRESH_INDEX_DELAY_WARNING_IN_MS (2 * 1000)
>
> @@ -130,11 +132,27 @@ static void update_index_from_diff(struct diff_queue_struct *q,
>         int intent_to_add = *(int *)data;
>
>         for (i = 0; i < q->nr; i++) {
> +               int pos;
>                 struct diff_filespec *one = q->queue[i]->one;
> -               int is_missing = !(one->mode && !is_null_oid(&one->oid));
> +               struct diff_filespec *two = q->queue[i]->two;
> +               int is_in_reset_tree = one->mode && !is_null_oid(&one->oid);

Isn't !is_null_oid(&one->oid) redundant to checking one->mode?  When
does the diff machinery ever give you a non-zero mode with a null oid?

Also, is_in_reset_tree == !is_missing; I'll note that below.

>                 struct cache_entry *ce;
>
> +               /*
> +                * If the file being reset has `skip-worktree` enabled, we need
> +                * to check it out to prevent the file from being hard reset.

I don't understand this comment.  If the file wasn't originally in the
index (is_missing), and is being added to it, and is correctly marked
as skip_worktree, and the file isn't in the working tree, then it
sounds like everything is already in a good state.  Files outside the
sparse checkout are meant to have the skip_worktree bit set and be
missing from the working tree.

Also, I don't know what you mean by 'hard reset' here.

> +                */
> +               pos = cache_name_pos(two->path, strlen(two->path));
> +               if (pos >= 0 && ce_skip_worktree(active_cache[pos])) {
> +                       struct checkout state = CHECKOUT_INIT;
> +                       state.force = 1;
> +                       state.refresh_cache = 1;
> +                       state.istate = &the_index;
> +
> +                       checkout_entry(active_cache[pos], &state, NULL, NULL);

Does this introduce an error in the opposite direction from the one
stated in the commit message?  Namely we have two things that should
be in sync: the skip_worktree flag stating whether the file should be
present in the working directory (skip_worktree), and the question of
whether the file is actually in the working directory.  In the commit
message, you pointed out a case where the y were out of sync one way:
the skip_worktree flag was not set but the file was missing.  Here you
say the skip_worktree flag is set, but you add it to the working tree
anyway.

Or am I misunderstanding the code?

> +               }
> +

[I did some slight editing to the diff to make the next two parts
appear next to each other]

> -               if (is_missing && !intent_to_add) {
> +               if (!is_in_reset_tree && !intent_to_add) {

I thought this was some subtle bugfix or something, and spent a while
trying to figure it out, before realizing that is_in_reset_tree was
simply defined as !is_missing (for some reason I was assuming it was
dealing with two->mode while is_missing was looking at one->mode).  So
this is a simple variable renaming, which I think is probably good,
but I'd prefer if this was separated into a different patch to make it
easier to review.

>                         remove_file_from_cache(one->path);
>                         continue;
>                 }
> @@ -144,7 +162,7 @@ static void update_index_from_diff(struct diff_queue_struct *q,
>                 if (!ce)
>                         die(_("make_cache_entry failed for path '%s'"),
>                             one->path);
> -               if (is_missing) {
> +               if (!is_in_reset_tree) {

same note as above; the variable rename is good, but should be a separate patch.

>                         ce->ce_flags |= CE_INTENT_TO_ADD;
>                         set_object_name_for_intent_to_add_entry(ce);
>                 }
> diff --git a/t/t1092-sparse-checkout-compatibility.sh b/t/t1092-sparse-checkout-compatibility.sh
> index 886e78715fe..c5977152661 100755
> --- a/t/t1092-sparse-checkout-compatibility.sh
> +++ b/t/t1092-sparse-checkout-compatibility.sh
> @@ -459,9 +459,7 @@ test_expect_failure 'blame with pathspec outside sparse definition' '
>         test_all_match git blame deep/deeper2/deepest/a
>  '
>
> -# NEEDSWORK: a sparse-checkout behaves differently from a full checkout
> -# in this scenario, but it shouldn't.
> -test_expect_failure 'checkout and reset (mixed)' '
> +test_expect_success 'checkout and reset (mixed)' '
>         init_repos &&
>
>         test_all_match git checkout -b reset-test update-deep &&
> diff --git a/t/t7114-reset-sparse-checkout.sh b/t/t7114-reset-sparse-checkout.sh
> new file mode 100755
> index 00000000000..a8029707fb1
> --- /dev/null
> +++ b/t/t7114-reset-sparse-checkout.sh
> @@ -0,0 +1,61 @@
> +#!/bin/sh
> +
> +test_description='reset when using a sparse-checkout'
> +
> +. ./test-lib.sh
> +
> +test_expect_success 'setup' '
> +       test_tick &&
> +       echo "checkout file" >c &&
> +       echo "modify file" >m &&
> +       echo "delete file" >d &&
> +       git add . &&
> +       git commit -m "initial commit" &&
> +       echo "added file" >a &&
> +       echo "modification of a file" >m &&
> +       git rm d &&
> +       git add . &&
> +       git commit -m "second commit" &&
> +       git checkout -b endCommit
> +'
> +
> +test_expect_success 'reset when there is a sparse-checkout' '
> +       echo "/c" >.git/info/sparse-checkout &&
> +       test_config core.sparsecheckout true &&
> +       git checkout -B resetBranch &&
> +       test_path_is_missing m &&
> +       test_path_is_missing a &&
> +       test_path_is_missing d &&
> +       git reset HEAD~1 &&
> +       echo "checkout file" >expect &&
> +       test_cmp expect c &&
> +       echo "added file" >expect &&
> +       test_cmp expect a &&
> +       echo "modification of a file" >expect &&
> +       test_cmp expect m &&
> +       test_path_is_missing d
> +'
> +
> +test_expect_success 'reset after deleting file without skip-worktree bit' '
> +       git checkout -f endCommit &&
> +       git clean -xdf &&
> +       cat >.git/info/sparse-checkout <<-\EOF &&
> +       /c
> +       /m
> +       EOF
> +       test_config core.sparsecheckout true &&
> +       git checkout -B resetAfterDelete &&
> +       test_path_is_file m &&
> +       test_path_is_missing a &&
> +       test_path_is_missing d &&
> +       rm -f m &&
> +       git reset HEAD~1 &&
> +       echo "checkout file" >expect &&
> +       test_cmp expect c &&
> +       echo "added file" >expect &&
> +       test_cmp expect a &&
> +       test_path_is_missing m &&
> +       test_path_is_missing d
> +'
> +
> +test_done
> --
> gitgitgadget
>
