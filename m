Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1D26A1F4C0
	for <e@80x24.org>; Fri, 18 Oct 2019 16:07:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2501965AbfJRQHo (ORCPT <rfc822;e@80x24.org>);
        Fri, 18 Oct 2019 12:07:44 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:37597 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2502254AbfJRQHn (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Oct 2019 12:07:43 -0400
Received: by mail-wr1-f66.google.com with SMTP id p14so6869129wro.4
        for <git@vger.kernel.org>; Fri, 18 Oct 2019 09:07:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=W4zHE1eZEhizLjy2PE1jL7ml74qeHWopxWgcB/9bg0Q=;
        b=jBLmHe4AZ9sQ9jzFbfHzGLH31euVzJI2tV2Yt9hlDvdM8p6BK20SQ9Bm1+YsEPe6kp
         ePvRpi2IoVgxSSI82apLTxdp0VhV5NBGEQeFtGRqI9+cpbDgW1A4brr1oQuLZhSfjKII
         LTSzCjxVBFuqQwQ/WVAj2x/NYLwgzDg9BTOuZJc2C7J6qYlGxIrc+iEN0vyTKH+FohIm
         ydmKoVRufcVT1KJhnhGhubJJ7g6BvKapIXt5R9p6d8kmnAnfY1EhV7ZA3ZSxSfLPsZYr
         S+ah+8UQHiVnAaRwZmsBKjET4D6XVKdC4UNn3OcXeMLugnKcZgYaguT9jHfzMq/XlQsz
         DMMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=W4zHE1eZEhizLjy2PE1jL7ml74qeHWopxWgcB/9bg0Q=;
        b=a9Hv9WVbCuaLucmjYu6So68lrWW+1fUcmgflKeFOZ/ETYwKR8gZhDkX8OXFXhbxgG3
         d6nEUDN1O7742/KEmU2VwcCFRWK1DOdqUxSwUXSOhOFQYIaBXyof5M3jBW19+gupRq+p
         lfib91GbcAvMCRLilWyyREqmS845BHWF93jUXdLU7xyg54uR74PRO6u1c2t6sVQkd03R
         ITyj04n93CIh9nb0miLRsF+xRldLb0HpGqllZqdFbD6ZeXGIRSIxgh8yPrc5Fi73vbR7
         vh4P0syN5SBOTJlMwNDacCIMcTibcnnY5/CRpbrZxPHNz/K9IswClbWRAymEVA6c2C2C
         phOQ==
X-Gm-Message-State: APjAAAUtFkAi9PO4W0ZBiLjbGqHxRYsSscEzqCbuEEWdgvbjz5mkHadk
        Ru15Z244HBQD7EOMmB2/m9w=
X-Google-Smtp-Source: APXvYqyFCpnnRmouMtFc7LNdRLMJqv1yH50QQEBN9jdbz5Jsf4JH36oFKMqAF+lyFzkSh/DaRmVRZQ==
X-Received: by 2002:a5d:66c6:: with SMTP id k6mr1243912wrw.152.1571414860409;
        Fri, 18 Oct 2019 09:07:40 -0700 (PDT)
Received: from szeder.dev (x4dbd7267.dyn.telefonica.de. [77.189.114.103])
        by smtp.gmail.com with ESMTPSA id 79sm9335085wmb.7.2019.10.18.09.07.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 18 Oct 2019 09:07:39 -0700 (PDT)
Date:   Fri, 18 Oct 2019 18:07:37 +0200
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, newren@gmail.com,
        Derrick Stolee <dstolee@microsoft.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4 01/17] sparse-checkout: create builtin with 'list'
 subcommand
Message-ID: <20191018160737.GG29845@szeder.dev>
References: <pull.316.v3.git.gitgitgadget@gmail.com>
 <pull.316.v4.git.1571147764.gitgitgadget@gmail.com>
 <63626e109767c268ee81b50abd21b95b1f1b5bfb.1571147765.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <63626e109767c268ee81b50abd21b95b1f1b5bfb.1571147765.git.gitgitgadget@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Oct 15, 2019 at 01:55:48PM +0000, Derrick Stolee via GitGitGadget wrote:
> From: Derrick Stolee <dstolee@microsoft.com>
> 
> The sparse-checkout feature is mostly hidden to users, as its
> only documentation is supplementary information in the docs for
> 'git read-tree'. In addition, users need to know how to edit the
> .git/info/sparse-checkout file with the right patterns, then run
> the appropriate 'git read-tree -mu HEAD' command. Keeping the
> working directory in sync with the sparse-checkout file requires
> care.
> 
> Begin an effort to make the sparse-checkout feature a porcelain
> feature by creating a new 'git sparse-checkout' builtin. This
> builtin will be the preferred mechanism for manipulating the
> sparse-checkout file and syncing the working directory.
> 
> The documentation provided is adapted from the "git read-tree"
> documentation with a few edits for clarity in the new context.
> Extra sections are added to hint toward a future change to
> a more restricted pattern set.
> 
> Helped-by: Elijah Newren <newren@gmail.com>
> Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
> ---
>  .gitignore                            |  1 +
>  Documentation/git-read-tree.txt       |  2 +-
>  Documentation/git-sparse-checkout.txt | 87 +++++++++++++++++++++++++++
>  Makefile                              |  1 +
>  builtin.h                             |  1 +
>  builtin/sparse-checkout.c             | 86 ++++++++++++++++++++++++++
>  git.c                                 |  1 +
>  t/t1091-sparse-checkout-builtin.sh    | 50 +++++++++++++++

You need to add an entry for the new command to 'command-list.txt' as
well, so it will be included in 'git help -a' and completion (since
it's intended to be a porcelain), etc.

>  8 files changed, 228 insertions(+), 1 deletion(-)
>  create mode 100644 Documentation/git-sparse-checkout.txt
>  create mode 100644 builtin/sparse-checkout.c
>  create mode 100755 t/t1091-sparse-checkout-builtin.sh


> diff --git a/Documentation/git-sparse-checkout.txt b/Documentation/git-sparse-checkout.txt
> new file mode 100644
> index 0000000000..46d3dc3cb1
> --- /dev/null
> +++ b/Documentation/git-sparse-checkout.txt
> @@ -0,0 +1,87 @@
> +git-sparse-checkout(1)
> +=======================

The ==== line is one character longer than the title; I think their
length should match.  The other day the Documentation CI job failed
because the length of these lines didn't match in one of the guides.
Strangely, it doesn't complain about this one.

> +
> +NAME
> +----
> +git-sparse-checkout - Initialize and modify the sparse-checkout
> +configuration, which reduces the checkout to a set of directories
> +given by a list of prefixes.
> +
> +
> +SYNOPSIS
> +--------
> +[verse]
> +'git sparse-checkout <subcommand> [options]'
> +
> +
> +DESCRIPTION
> +-----------
> +
> +Initialize and modify the sparse-checkout configuration, which reduces
> +the checkout to a set of directories given by a list of prefixes.
> +
> +THIS COMMAND IS EXPERIMENTAL. THE BEHAVIOR MAY CHANGE.
> +
> +
> +COMMANDS
> +--------
> +'list'::
> +	Provide a list of the contents in the sparse-checkout file.
> +
> +
> +SPARSE CHECKOUT
> +----------------

This is longer as well.

> +
> +"Sparse checkout" allows populating the working directory sparsely.
> +It uses the skip-worktree bit (see linkgit:git-update-index[1]) to tell
> +Git whether a file in the working directory is worth looking at. If
> +the skip-worktree bit is set, then the file is ignored in the working
> +directory. Git will not populate the contents of those files, which
> +makes a sparse checkout helpful when working in a repository with many
> +files, but only a few are important to the current user.
> +
> +The `$GIT_DIR/info/sparse-checkout` file is used to define the
> +skip-worktree reference bitmap. When Git updates the working
> +directory, it updates the skip-worktree bits in the index based
> +on this file. The files matching the patterns in the file will
> +appear in the working directory, and the rest will not.
> +
> +## FULL PATTERN SET
> +
> +By default, the sparse-checkout file uses the same syntax as `.gitignore`
> +files.
> +
> +While `$GIT_DIR/info/sparse-checkout` is usually used to specify what
> +files are included, you can also specify what files are _not_ included,
> +using negative patterns. For example, to remove the file `unwanted`:
> +
> +----------------
> +/*
> +!unwanted
> +----------------
> +
> +Another tricky thing is fully repopulating the working directory when you
> +no longer want sparse checkout. You cannot just disable "sparse
> +checkout" because skip-worktree bits are still in the index and your working
> +directory is still sparsely populated. You should re-populate the working
> +directory with the `$GIT_DIR/info/sparse-checkout` file content as
> +follows:
> +
> +----------------
> +/*
> +----------------
> +
> +Then you can disable sparse checkout. Sparse checkout support in 'git
> +checkout' and similar commands is disabled by default. You need to
> +set `core.sparseCheckout` to `true` in order to have sparse checkout
> +support.
> +
> +SEE ALSO
> +--------
> +
> +linkgit:git-read-tree[1]
> +linkgit:gitignore[5]
> +
> +GIT
> +---
> +Part of the linkgit:git[1] suite

> diff --git a/t/t1091-sparse-checkout-builtin.sh b/t/t1091-sparse-checkout-builtin.sh
> new file mode 100755
> index 0000000000..a9b04b1a88
> --- /dev/null
> +++ b/t/t1091-sparse-checkout-builtin.sh
> @@ -0,0 +1,50 @@
> +#!/bin/sh
> +
> +test_description='sparse checkout builtin tests'
> +
> +. ./test-lib.sh
> +
> +test_expect_success 'setup' '
> +	git init repo &&
> +	(
> +		cd repo &&
> +		echo "initial" >a &&
> +		mkdir folder1 folder2 deep &&
> +		mkdir deep/deeper1 deep/deeper2 &&
> +		mkdir deep/deeper1/deepest &&
> +		cp a folder1 &&
> +		cp a folder2 &&
> +		cp a deep &&
> +		cp a deep/deeper1 &&
> +		cp a deep/deeper2 &&
> +		cp a deep/deeper1/deepest &&

There are six 'cp' invocations here.  Curious: does this mean that
it's important that all those files are the same?

> +		git add . &&
> +		git commit -m "initial commit"
> +	)
> +'
> +
> +test_expect_success 'git sparse-checkout list (empty)' '
> +	git -C repo sparse-checkout list >list 2>err &&
> +	test_line_count = 0 list &&

Nit: test_must_be_empty might be a bit more idiomatic, dunno.

> +	test_i18ngrep "this worktree is not sparse (sparse-checkout file may not exist)" err
> +'
> +
> +test_expect_success 'git sparse-checkout list (populated)' '
> +	test_when_finished rm -f repo/.git/info/sparse-checkout &&
> +	cat >repo/.git/info/sparse-checkout <<-EOF &&
> +		/folder1/*
> +		/deep/
> +		**/a
> +		!*bin*
> +	EOF
> +	git -C repo sparse-checkout list >list &&
> +	cat >expect <<-EOF &&
> +		/folder1/*
> +		/deep/
> +		**/a
> +		!*bin*
> +	EOF

OTOH, here the content of the 'sparse-checkout' file and 'expect' must
be the same, but one has to carefully look through four lines of
patterns to realize that they are indeed the same.  I think in this
case the explicitness of 'cp' would be better.

> +	test_cmp expect list
> +'
> +
> +test_done
> -- 
> gitgitgadget
> 
