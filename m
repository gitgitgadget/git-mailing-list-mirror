Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A801DC433F5
	for <git@archiver.kernel.org>; Fri, 31 Dec 2021 20:03:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231663AbhLaUDT (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 31 Dec 2021 15:03:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229649AbhLaUDS (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 31 Dec 2021 15:03:18 -0500
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24055C061574
        for <git@vger.kernel.org>; Fri, 31 Dec 2021 12:03:18 -0800 (PST)
Received: by mail-ed1-x52a.google.com with SMTP id f5so111776245edq.6
        for <git@vger.kernel.org>; Fri, 31 Dec 2021 12:03:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gcjazRJCOQYhislgsnSNlxa0qhFexf0x3z5cnNUrycM=;
        b=Ou9BonG4wPw85ZktEwljtcnNWvLWHRuI3X+CEw4QHI0ZaJdGwhYZ0Aqz78Lc3vx63j
         HQyVWWeQpoNYFzHJezTz28xjssPHKLrau0bq4U57xX0v1e7mQmUbDJRA+a94+6uZY+hT
         DitDN5f6tMBeLwjYatbcX5sC+PYcJzm71Ufan5MvVr/pTRyQM31DukukVqujpum8Pq1S
         XFgGjCSF7rl74o2e3NSdrluLz/VavY4bZ6tJsPxFM63BnXKenyJc3BiSmzu3MJtpeVu+
         kYWGndQYBJ38yQS0v12XL2/b0ns5r0Y7hEvCeo2dw4q3Q2TnAw7/hbjdMxPK8KdyQa0q
         hdGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gcjazRJCOQYhislgsnSNlxa0qhFexf0x3z5cnNUrycM=;
        b=1vPlhgxFp1laxdYAPsbxMtj1/EmjaBckwp3D4I8wiw1j1dKvgz73EdJ6Hjx5xjcvt7
         p7nDFPZEVF3c6Rm6kUFYGFK4E+ChFcJLJE9PzXJtOD7DUVXIONiCoenkJK2TWWToP0dE
         HadcuukMVaDc/YyTBpbqUyx/CgNswbAGmyjZOR+XmpIdZQ8liGZIUal6UCZNt+DM5leo
         t16IzdU1pNpbHbR4wWBys6rRj6VckVmX3S6Rkd8FefSzoBcTBpSZVUwCc4vMxwU2qWpM
         dvkNXzz1N2dquX4INokInh+HYpH5PI7k4E03JQDL60o+ktPZ0hODKddwzKWnDS3kfda2
         8pkQ==
X-Gm-Message-State: AOAM531GjWoXWAV11LQbjnSG4+9zoT38RFRHDwtt2yptzVOiQfqCGwEF
        1QUtLH3ImmdYUm8ZhTYVNW5D63c3lmeL5YyG6JXI0aWlQlrUaA==
X-Google-Smtp-Source: ABdhPJwMouzOHKokwk5sGWMSNWpnE1e4MvtEazCzsHpsTdHAkdUO9GasEaUIjh+IMkUxuXiYtK2ed2XAkSVpUunYHKE=
X-Received: by 2002:a05:6402:350b:: with SMTP id b11mr35882211edd.228.1640980996522;
 Fri, 31 Dec 2021 12:03:16 -0800 (PST)
MIME-Version: 1.0
References: <pull.1108.git.1640824351.gitgitgadget@gmail.com>
 <pull.1108.v2.git.1640892413.gitgitgadget@gmail.com> <955fcab00528464b5450bd22b45c89ffc2283e39.1640892413.git.gitgitgadget@gmail.com>
In-Reply-To: <955fcab00528464b5450bd22b45c89ffc2283e39.1640892413.git.gitgitgadget@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Fri, 31 Dec 2021 12:03:04 -0800
Message-ID: <CABPp-BGdr54XgCXw8k1xRCgkwBtDonyODS3O+_nS_QY3SOEFGQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] sparse-checkout: custom tab completion tests
To:     Lessley Dennington via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Derrick Stolee <stolee@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        johannes.schindelin@gmail.com,
        Lessley Dennington <lessleydennington@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Dec 31, 2021 at 2:32 AM Lessley Dennington via GitGitGadget
<gitgitgadget@gmail.com> wrote:
>
> From: Lessley Dennington <lessleydennington@gmail.com>
>
> Add tests for missing/incorrect components of custom tab completion for the
> sparse-checkout command. These tests specifically highlight the following:
>
> 1. git sparse-checkout <TAB> results in an incomplete list of subcommands
> (it is missing reapply and add).
> 2. git sparse-checkout --<TAB> does not complete the help option.
> 3. Options for subcommands are not tab-completable.
> 4. git sparse-checkout set <TAB> and git sparse-checkout add <TAB> show
> both file names and directory names.

Two thoughts on this last item:

I completely agree that only directories should be completed in cone
mode, but completing on both might technically be considered correct
behavior for non-cone mode.  However, even in non-cone mode, I kind of
like the idea of encouraging people to sparsify only on directories so
I'm totally fine with us only tab-completing directories.  (I have a
bit of a disdain for non-cone mode, though, so my desire to deprecate
it might be showing through.  At the very least, I'm still thinking we
should make cone mode the default in each of `sparse-checkout init`,
`sparse-checkout set`, and `clone --sparse`[1])

[1] https://lore.kernel.org/git/6e09ab19-7ffb-e58e-7b08-6e560b421c06@gmail.com/


Second, and this item is unrelated to your series but your comment
made me realize it....sparse-checkout unfortunately ignores prefix and
creates a bad .git/info/sparse-checkout file.  For example:

$ git init -b main tmp
$ cd tmp
$ mkdir -p a/b/c
$ touch a/b/c/d a/b/c/e
$ git add a/
$ git commit -m "initial"
$ cd a/  # Not at the toplevel anymore
$ git sparse-checkout set --cone b/c  # So we expect that a/b/c will
be the specified sparsity path
$ git -C .. sparse-checkout list
b/c
$ cat ../.git/info/sparse-checkout
/*
!/*/
/b/
!/b/*/
/b/c/
$ pwd -P
pwd: error retrieving current directory: getcwd: cannot access parent
directories: No such file or directory

I think the loss of the current working directory will be fixed by the
en/keep-cwd directory (currently in next and marked for merging to
master), but the fact that the wrong paths end up in the
sparse-checkout file is unfortunate.  It basically means that the
`set` and `add` subcommands of `sparse-checkout` can only be safely
run from the toplevel directory.

> Although these tests currently fail, they will succeed with the
> sparse-checkout modifications in git-completion.bash in the next commit in
> this series.
>
> Signed-off-by: Lessley Dennington <lessleydennington@gmail.com>
> ---
>  t/t9902-completion.sh | 85 +++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 85 insertions(+)
>
> diff --git a/t/t9902-completion.sh b/t/t9902-completion.sh
> index 518203fbe07..51d0f2d93a1 100755
> --- a/t/t9902-completion.sh
> +++ b/t/t9902-completion.sh
> @@ -1447,6 +1447,91 @@ test_expect_success 'git checkout - with --detach, complete only references' '
>         EOF
>  '
>
> +test_expect_failure 'sparse-checkout completes subcommands' '
> +       test_completion "git sparse-checkout " <<-\EOF
> +       list Z
> +       init Z
> +       set Z
> +       add Z
> +       reapply Z
> +       disable Z
> +       EOF
> +'
> +
> +test_expect_failure 'sparse-checkout completes options' '
> +       test_completion "git sparse-checkout --" <<-\EOF
> +       --help Z
> +       EOF
> +'
> +
> +test_expect_failure 'sparse-checkout completes subcommand options' '
> +       test_completion "git sparse-checkout init --" <<-\EOF &&
> +       --cone Z
> +       --no-cone Z
> +       --sparse-index Z
> +       --no-sparse-index Z
> +       EOF
> +
> +       test_completion "git sparse-checkout set --" <<-\EOF &&
> +       --cone Z
> +       --no-cone Z
> +       --sparse-index Z
> +       --no-sparse-index Z
> +       --stdin Z
> +       EOF
> +
> +       test_completion "git sparse-checkout reapply --" <<-\EOF &&
> +       --cone Z
> +       --no-cone Z
> +       --sparse-index Z
> +       --no-sparse-index Z
> +       EOF
> +
> +       test_completion "git sparse-checkout add --" <<-\EOF
> +       --stdin Z
> +       EOF
> +'
> +
> +test_expect_failure 'sparse-checkout completes directory names' '
> +       # set up sparse-checkout repo
> +       git init sparse-checkout &&
> +       (
> +               cd sparse-checkout &&
> +               mkdir -p folder1/0/1 folder2/0 folder3 &&
> +               touch folder1/0/1/t.txt &&
> +               touch folder2/0/t.txt &&
> +               touch folder3/t.txt &&
> +               git add . &&
> +               git commit -am "Initial commit"
> +       ) &&
> +
> +       # initialize sparse-checkout definitions
> +       git -C sparse-checkout sparse-checkout init --cone &&
> +       git -C sparse-checkout sparse-checkout set folder1/0 folder3 &&
> +
> +       # test tab completion
> +       (
> +               cd sparse-checkout &&
> +               test_completion "git sparse-checkout set f" <<-\EOF
> +               folder1 Z
> +               folder1/0 Z
> +               folder1/0/1 Z
> +               folder2 Z
> +               folder2/0 Z
> +               folder3 Z
> +               EOF
> +       ) &&
> +
> +       (
> +               cd sparse-checkout/folder1 &&
> +               test_completion "git sparse-checkout add " <<-\EOF
> +               ./ Z
> +               0 Z
> +               0/1 Z
> +               EOF
> +       )
> +'
> +
>  test_expect_success 'git switch - with -d, complete all references' '
>         test_completion "git switch -d " <<-\EOF
>         HEAD Z
> --
> gitgitgadget

Patch looks okay to me, but we might want to add some kind of wording
around the directories-only decision and cone vs. non-cone mode to the
commit message.
