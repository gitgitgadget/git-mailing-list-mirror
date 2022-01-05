Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31DF2C433EF
	for <git@archiver.kernel.org>; Wed,  5 Jan 2022 21:05:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244303AbiAEVE7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 5 Jan 2022 16:04:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231715AbiAEVE5 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Jan 2022 16:04:57 -0500
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA3F5C061245
        for <git@vger.kernel.org>; Wed,  5 Jan 2022 13:04:56 -0800 (PST)
Received: by mail-ed1-x534.google.com with SMTP id o6so1507452edc.4
        for <git@vger.kernel.org>; Wed, 05 Jan 2022 13:04:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ogyfgvCkG8pT6/x8DUaZ1Hd3uZlX/NPMe3XodO78DPM=;
        b=YQzBSMNR2R/KjhNBl38So+Abv64jABXuMPEhpNfgla2NgMitmSXFhbmwaU26PHVIvH
         KLjDL4XYAZocyF4NtPrYpyD2jgzv+7ktXeXWNZFyselqEOyogFS3Vu+517baTiZQbtXv
         Q0Nl275g4+5CyrrNZ8ZGo4cWM7IlbGqT6da1HHp6M+s3URk3sBCdS4GPl81+0ZunIJMm
         T7a7BKxnvLdOP6SzuK3exYeLIqIbSapAYOXSVotRzZCxyLtevI61VqvnxQCldZCvASmo
         lxwAp/8LgBJrwHGpP90B3xaA1frvytREDeC+IjG/uDS4fyrzmFaat3pjQiAD6AP3TaSB
         SPxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ogyfgvCkG8pT6/x8DUaZ1Hd3uZlX/NPMe3XodO78DPM=;
        b=2NTRi+nJvm0tv1dLi96asy8+nsE+qhL4kOXcUCbD1JWi1N9cjaXfmsntCis6nBQ1cx
         Zy3VfTwJcNWGDS0l23FnUW3vHzy1Nl4q967rcrrYV8GGqB5aCkbKrARhakPQRcrtSCLr
         McGjzeuq4vu2ZmH2RFdJ/Yn8DyE0WDG0snHzQrJdrqVPzo9plHDx4z8y5TpZn1fvYL3R
         l3EeOZLkEqdLtWTjcSfW+49amSwrv97FHWFKcDk056WLkht4OYbieZSX05u6P2PsEv83
         vBYkQmUUZpjlPW5a4/WsleugFkUfIe6sTN2hox4EnU+ilvR7mAE10rpilJB1yMyGOo1r
         0gRg==
X-Gm-Message-State: AOAM5337O1eAnu96U20Mq8TnG3l/Ueu5jk/K/RtG5s+i09S3QJYzX+oD
        GTw6UoxWs2gWGYZWmv+huKlP/yKNILumATSaKsM=
X-Google-Smtp-Source: ABdhPJypgwF00M7egRYAzjWBG+28iqugWFfKC6upksF/5nqROqV4iPmmrilmPAE05KjijtjI3U2KfN604zUU+iA7ChA=
X-Received: by 2002:a17:907:3f1e:: with SMTP id hq30mr43358096ejc.613.1641416695223;
 Wed, 05 Jan 2022 13:04:55 -0800 (PST)
MIME-Version: 1.0
References: <pull.1109.git.1641317820.gitgitgadget@gmail.com> <e6a8671f6be5afad9a495be66c0735f6b741c844.1641317820.git.gitgitgadget@gmail.com>
In-Reply-To: <e6a8671f6be5afad9a495be66c0735f6b741c844.1641317820.git.gitgitgadget@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Wed, 5 Jan 2022 13:04:43 -0800
Message-ID: <CABPp-BFqTqK3grMLv_odKGwDhUaU8p1epNzv825kTqLAgMrK9g@mail.gmail.com>
Subject: Re: [PATCH 4/9] checkout-index: expand sparse checkout compatibility tests
To:     Victoria Dye via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Derrick Stolee <stolee@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Victoria Dye <vdye@github.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jan 4, 2022 at 9:37 AM Victoria Dye via GitGitGadget
<gitgitgadget@gmail.com> wrote:
>
> From: Victoria Dye <vdye@github.com>
>
> Add tests to cover `checkout-index`, with a focus on cases interesting in a
> sparse checkout (e.g., files specified outside sparse checkout definition).
> New tests are intended to serve as a baseline for expected behavior and
> performance when integrating `checkout-index` with the sparse index.
>
> Signed-off-by: Victoria Dye <vdye@github.com>
> ---
>  t/perf/p2000-sparse-operations.sh        |  1 +
>  t/t1092-sparse-checkout-compatibility.sh | 54 ++++++++++++++++++++++++
>  2 files changed, 55 insertions(+)
>
> diff --git a/t/perf/p2000-sparse-operations.sh b/t/perf/p2000-sparse-operations.sh
> index cb777c74a24..54f8602f3c1 100755
> --- a/t/perf/p2000-sparse-operations.sh
> +++ b/t/perf/p2000-sparse-operations.sh
> @@ -117,5 +117,6 @@ test_perf_on_all git diff
>  test_perf_on_all git diff --cached
>  test_perf_on_all git blame $SPARSE_CONE/a
>  test_perf_on_all git blame $SPARSE_CONE/f3/a
> +test_perf_on_all git checkout-index -f --all
>
>  test_done
> diff --git a/t/t1092-sparse-checkout-compatibility.sh b/t/t1092-sparse-checkout-compatibility.sh
> index 05587361452..db7ad41109b 100755
> --- a/t/t1092-sparse-checkout-compatibility.sh
> +++ b/t/t1092-sparse-checkout-compatibility.sh
> @@ -755,6 +755,60 @@ test_expect_success 'cherry-pick with conflicts' '
>         test_all_match test_must_fail git cherry-pick to-cherry-pick
>  '
>
> +test_expect_success 'checkout-index inside sparse definition' '
> +       init_repos &&
> +
> +       run_on_all rm -f deep/a &&
> +       test_all_match git checkout-index -- deep/a &&
> +       test_all_match git status --porcelain=v2 &&
> +
> +       echo test >>new-a &&
> +       run_on_all cp ../new-a a &&
> +       test_all_match test_must_fail git checkout-index -- a &&
> +       test_all_match git checkout-index -f -- a &&
> +       test_all_match git status --porcelain=v2
> +'
> +
> +test_expect_success 'checkout-index outside sparse definition' '
> +       init_repos &&
> +
> +       # File does not exist on disk yet for sparse checkouts, so checkout-index
> +       # succeeds without -f
> +       test_sparse_match git checkout-index -- folder1/a &&

Whoa, um, what is `git checkout-index -- folder1/a` even supposed to
mean with the sparse-index and cone mode?  That's an individual file,
so should folder1 and everything under it have the SKIP_WORKTREE bit
cleared?  Should folder1 just stop being a sparse directory, with all
siblings of folder1/a retaining the SKIP_WORKTREE bit (so folder1/0
could become a sparse directory) while folder1/a loses the
SKIP_WORKTREE bit, kind of violating cone mode but perhaps just until
the next sparse-checkout reapply?

The test sadly doesn't look at the SKIP_WORKTREE bits at all, which
feels like an important oversight (unless you meant to test this
later?).  Especially since my manual testing shows that this test
leaves the files as SKIP_WORKTREE despite writing the files to the
working tree.  I think the present-despite-skip-worktree problem I've
discussed elsewhere is growing in importance rather than shrinking;
you don't need to address that problem with this series but I raise it
mostly so we're aware to at least test it.  I'll keep reading to see
if you mention this or fix it up in subsequent patches.

> +       test_cmp sparse-checkout/folder1/a sparse-index/folder1/a &&
> +       test_cmp sparse-checkout/folder1/a full-checkout/folder1/a &&
> +
> +       run_on_sparse rm -rf folder1 &&
> +       echo test >new-a &&
> +       run_on_sparse mkdir -p folder1 &&
> +       run_on_all cp ../new-a folder1/a &&
> +
> +       test_all_match test_must_fail git checkout-index -- folder1/a &&
> +       test_all_match git checkout-index -f -- folder1/a &&
> +       test_cmp sparse-checkout/folder1/a sparse-index/folder1/a &&
> +       test_cmp sparse-checkout/folder1/a full-checkout/folder1/a
> +'
> +
> +test_expect_success 'checkout-index with folders' '
> +       init_repos &&
> +
> +       # Inside checkout definition
> +       test_all_match test_must_fail git checkout-index -f -- deep/ &&
> +
> +       # Outside checkout definition
> +       test_all_match test_must_fail git checkout-index -f -- folder1/

Passing a directory to checkout-index?  I'm glad they all immediately
fail, but is the plan just to make sure that this continues?  I'm not
sure what could make sense otherwise.  You've piqued my curiosity;
I'll keep reading the series to see.

> +'
> +
> +# NEEDSWORK: even in sparse checkouts, checkout-index --all will create all
> +# files (even those outside the sparse definition) on disk. However, these files
> +# don't appear in the percentage of tracked files in git status.

Ah, so you _are_ noticing the present-despite-SKIP_WORKTREE files.  I
think it might be nice to test for these a bit earlier, but it's nice
to see some test here for them.

I think that present-despite-SKIP_WORKTREE files is an erroneous
condition, one we should avoid triggering, and one we should help
users clean up from.  For checkout-index, the fact that it currently
makes more of these files is buggy.  It should either (1) clear the
SKIP_WORKTREE bit when it writes the files to the working tree, or (2)
avoid writing the files to the working tree.

And if we choose (1), there's already a --no-create option we could
piggy-back on to allow folks to not write the SKIP_WORKTREE files.

> +test_expect_failure 'checkout-index --all' '
> +       init_repos &&
> +
> +       test_all_match git checkout-index --all &&
> +       test_sparse_match test_path_is_missing folder1

Ah, it looks like you're choosing (2).  That may be fine, but an
interesting anecdote:

While attempting to adopt sparse checkouts at $DAYJOB (and
particularly using cone mode), we found the code structure just didn't
quite work.  We needed some directories to be ignored for sparse
checkouts to be meaningful at all, but we had some files that were
siblings to those directories that were needed for builds to function.
We came up with a hack to "add a few files back", using "git
checkout-index -- $FILENAME".  We expected that hack to write the
listed file(s) to the working tree -- though I think we also had logic
to then run the stuff we needed and then delete these temporary files.
We used this hack starting in Feb 2020, and eventually restructured
the code to not need this hack in Feb 2021.  I'll have to mull over
whether your choice of option (2) might cause us some problems if
someone (a) uses a new git version to (b) access an old version of our
code and (c) really wants to work with a sparse checkout (since the
"checkout-index" stuff was part of the build logic checked into the
code).  I think your change here is fine (because not using sparse
checkouts is an option, we told folks it was experimental, and those
are old versions that are only getting security fixes in special
circumstances), but let me think about it for a bit...

> +'
> +
>  test_expect_success 'clean' '
>         init_repos &&
>
> --
> gitgitgadget
