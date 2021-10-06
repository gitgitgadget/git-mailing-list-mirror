Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8094C433EF
	for <git@archiver.kernel.org>; Wed,  6 Oct 2021 02:04:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C1D2F6113A
	for <git@archiver.kernel.org>; Wed,  6 Oct 2021 02:04:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237181AbhJFCGm (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 5 Oct 2021 22:06:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233994AbhJFCGl (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Oct 2021 22:06:41 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B0BBC061749
        for <git@vger.kernel.org>; Tue,  5 Oct 2021 19:04:50 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id z20so3601531edc.13
        for <git@vger.kernel.org>; Tue, 05 Oct 2021 19:04:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ll+6k6dJT5ELu4/vgGxnGEaTMPGFZ+qXrhcmwY4iCk0=;
        b=XJPWWND06fVBEwUHEpJBJtgR8HYNmjIXaQmzMHw1xjmIQGWepj5awOL35GO7U5x2tP
         6bX/ml/wV0hsrg1anIF9FLo0rgEa2oZ3tvHKwZ9Cau1LyUgBImXdgxddV/a2M7EDh+n7
         IAxV23X9yDJsP6vzEJs5IH3TxLXcUqZkj7v6Lr8XgqW0BmfX/zK3JZEY31Re61sD2p+4
         Kb6BWmN0siEU9fo7QMhePLcJxa1BQYatg2mSI0oNuBAMa86489pYy/0TeI4sst7sZrDv
         P6wEgacEt+4AXxWXnztuWLnxNQRRQWOYVAFPFlj/KdC9psKLVjVCNJk/sPtn1CJRWpTR
         7GAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ll+6k6dJT5ELu4/vgGxnGEaTMPGFZ+qXrhcmwY4iCk0=;
        b=IvJ4/ErMm+q8Q/20ftOGpFp94j6auIBhlISXNyl/0+9rkU19sn+gSXaeg1NXNBLMTy
         BDnSk5P7VhutBKGuz1i/S50TIqZOBmYlFzWLbf4hXgz8aaG/456UA7Vhm9AyjkmBpzoT
         7bPa3rjLm1OYPqHmASfg/TKQkr5o5pjExc6jq8iyt4PnNnvdIIIXhpnFlhVkkjIUVj5D
         FBdznrJwLgP30Gkv0kMutiPhJWtwmW1+tbQJR+8/tfqD3yrHwBcMA+NsYHHfY9fZamZe
         Da5t6Rdox4XRMSGiDGwK/x86eIjghHJtoUvR+aDbPmC+3Ocko5JlsQcK/taFZFujdHJe
         LeJA==
X-Gm-Message-State: AOAM533MTIW+Z2r7BQIdkJeT5YeNveKMMQtNdSRxve3Q/xI+ouBvPxi4
        0/eBR2bBCZx6+HovUfhEYIXw/D9utH3IvMeNCnV8iCFKnM4=
X-Google-Smtp-Source: ABdhPJxtu7IO8gRfQ5dAz7D4VNcVXpW+u0zmWF4WknqC0xDmsv7vQpxUT5WpAB0V951myiW5XFjQiYSHw4k1BO0FoWU=
X-Received: by 2002:a17:906:2f10:: with SMTP id v16mr29017578eji.434.1633485888629;
 Tue, 05 Oct 2021 19:04:48 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1048.git.1633013461.gitgitgadget@gmail.com>
 <pull.1048.v2.git.1633440057.gitgitgadget@gmail.com> <c7e9d9f4e03fe0dbd8a112460f0ac0864f087c8f.1633440057.git.gitgitgadget@gmail.com>
In-Reply-To: <c7e9d9f4e03fe0dbd8a112460f0ac0864f087c8f.1633440057.git.gitgitgadget@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Tue, 5 Oct 2021 19:04:37 -0700
Message-ID: <CABPp-BFAiPsHZPjJtuuqfuxt950yo-pqpKD8TG9sNWDs-bEbEw@mail.gmail.com>
Subject: Re: [PATCH v2 3/7] reset: expand test coverage for sparse checkouts
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
> Add new tests for `--merge` and `--keep` modes, as well as mixed reset with
> pathspecs both inside and outside of the sparse checkout definition. New
> performance test cases exercise various execution paths for `reset`.
>
> Co-authored-by: Derrick Stolee <dstolee@microsoft.com>
> Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
> Signed-off-by: Victoria Dye <vdye@github.com>
> ---
>  t/perf/p2000-sparse-operations.sh        |   3 +
>  t/t1092-sparse-checkout-compatibility.sh | 107 +++++++++++++++++++++++
>  2 files changed, 110 insertions(+)
>
> diff --git a/t/perf/p2000-sparse-operations.sh b/t/perf/p2000-sparse-operations.sh
> index 597626276fb..bfd332120c8 100755
> --- a/t/perf/p2000-sparse-operations.sh
> +++ b/t/perf/p2000-sparse-operations.sh
> @@ -110,5 +110,8 @@ test_perf_on_all git add -A
>  test_perf_on_all git add .
>  test_perf_on_all git commit -a -m A
>  test_perf_on_all git checkout -f -
> +test_perf_on_all git reset
> +test_perf_on_all git reset --hard
> +test_perf_on_all git reset -- does-not-exist
>
>  test_done
> diff --git a/t/t1092-sparse-checkout-compatibility.sh b/t/t1092-sparse-checkout-compatibility.sh
> index b3c0d3b98ee..f0723a6ac97 100755
> --- a/t/t1092-sparse-checkout-compatibility.sh
> +++ b/t/t1092-sparse-checkout-compatibility.sh
> @@ -479,6 +479,113 @@ test_expect_success 'checkout and reset (mixed) [sparse]' '
>         test_sparse_match git reset update-folder2
>  '
>
> +# NEEDSWORK: with mixed reset, files with differences between HEAD and <commit>
> +# will be added to the work tree even if outside the sparse checkout
> +# definition, and even if the file is modified to a state of having no local
> +# changes. The file is "re-ignored" if a hard reset is executed. We may want to
> +# change this behavior in the future and enforce that files are not written
> +# outside of the sparse checkout definition.

Yeah, I think this comment highlights some of the reasons that writing
the file to the working directory for those files isn't the way I'd
prefer to resolve the inconsistency between the skip-worktree bit and
the presence of the file in the working directory.

> +test_expect_success 'checkout and mixed reset file tracking [sparse]' '
> +       init_repos &&
> +
> +       test_all_match git checkout -b reset-test update-deep &&
> +       test_all_match git reset update-folder1 &&
> +       test_all_match git reset update-deep &&
> +
> +       # At this point, there are no changes in the working tree. However,
> +       # folder1/a now exists locally (even though it is outside of the sparse
> +       # paths).
> +       run_on_sparse test_path_exists folder1 &&
> +
> +       run_on_all rm folder1/a &&
> +       test_all_match git status --porcelain=v2 &&
> +
> +       test_all_match git reset --hard update-deep &&
> +       run_on_sparse test_path_is_missing folder1 &&
> +       test_path_exists full-checkout/folder1
> +'
> +
> +test_expect_success 'checkout and reset (merge)' '
> +       init_repos &&
> +
> +       write_script edit-contents <<-\EOF &&
> +       echo text >>$1
> +       EOF
> +
> +       test_all_match git checkout -b reset-test update-deep &&
> +       run_on_all ../edit-contents a &&
> +       test_all_match git reset --merge deepest &&
> +       test_all_match git status --porcelain=v2 &&
> +
> +       test_all_match git reset --hard update-deep &&
> +       run_on_all ../edit-contents deep/a &&
> +       test_all_match test_must_fail git reset --merge deepest
> +'
> +
> +test_expect_success 'checkout and reset (keep)' '
> +       init_repos &&
> +
> +       write_script edit-contents <<-\EOF &&
> +       echo text >>$1
> +       EOF
> +
> +       test_all_match git checkout -b reset-test update-deep &&
> +       run_on_all ../edit-contents a &&
> +       test_all_match git reset --keep deepest &&
> +       test_all_match git status --porcelain=v2 &&
> +
> +       test_all_match git reset --hard update-deep &&
> +       run_on_all ../edit-contents deep/a &&
> +       test_all_match test_must_fail git reset --keep deepest
> +'
> +
> +test_expect_success 'reset with pathspecs inside sparse definition' '
> +       init_repos &&
> +
> +       write_script edit-contents <<-\EOF &&
> +       echo text >>$1
> +       EOF
> +
> +       test_all_match git checkout -b reset-test update-deep &&
> +       run_on_all ../edit-contents deep/a &&
> +
> +       test_all_match git reset base -- deep/a &&
> +       test_all_match git status --porcelain=v2 &&
> +
> +       test_all_match git reset base -- nonexistent-file &&
> +       test_all_match git status --porcelain=v2 &&
> +
> +       test_all_match git reset deepest -- deep &&
> +       test_all_match git status --porcelain=v2
> +'
> +
> +test_expect_success 'reset with sparse directory pathspec outside definition' '
> +       init_repos &&
> +
> +       test_all_match git checkout -b reset-test update-deep &&
> +       test_all_match git reset --hard update-folder1 &&
> +       test_all_match git reset base -- folder1 &&
> +       test_all_match git status --porcelain=v2
> +'
> +
> +test_expect_success 'reset with pathspec match in sparse directory' '
> +       init_repos &&
> +
> +       test_all_match git checkout -b reset-test update-deep &&
> +       test_all_match git reset --hard update-folder1 &&
> +       test_all_match git reset base -- folder1/a &&
> +       test_all_match git status --porcelain=v2
> +'
> +
> +test_expect_success 'reset with wildcard pathspec' '
> +       init_repos &&
> +
> +       test_all_match git checkout -b reset-test update-deep &&
> +       test_all_match git reset --hard update-folder1 &&
> +       test_all_match git reset base -- \*/a &&
> +       test_all_match git status --porcelain=v2
> +'
> +
>  test_expect_success 'merge, cherry-pick, and rebase' '
>         init_repos &&
>
> --
> gitgitgadget
>
