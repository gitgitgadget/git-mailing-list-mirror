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
	by dcvr.yhbt.net (Postfix) with ESMTP id 1A9041F4C0
	for <e@80x24.org>; Mon, 21 Oct 2019 11:42:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728460AbfJULmy (ORCPT <rfc822;e@80x24.org>);
        Mon, 21 Oct 2019 07:42:54 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:37195 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727889AbfJULmy (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Oct 2019 07:42:54 -0400
Received: by mail-qt1-f193.google.com with SMTP id g50so6330820qtb.4
        for <git@vger.kernel.org>; Mon, 21 Oct 2019 04:42:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=KABjwKDFJlBiGhDABpxL31wGByJ+rRpjzaTCBR/LPoA=;
        b=YYf0A/nVJE9dMluqBfAJE0+0G1oxQxsNbBqkzUz9GGN8TMmd89yhSJ81RQFz/NxKoP
         CHXUIPAduAQD2+HTbg5SmP08HNGLa38HXF96t7L8aLXe+u1V6vebMQHJk09Pwbd5GZWM
         QuG1l96t13TiIyjZ6FnMU28J0WWgF8yxGpQIfpa5Bc0ywf2DnEYbhWCyK55+vw3Ljh5u
         cS4KvNNDyWSlP8wgA3uqYMCnP7uDQIl1SWAMeCJXETEBDm5slvPHnvWBcacBDVteKAXv
         dyJT5iYWLqdO/D7nRoASJNTYv7mqLdygKvXS2pgDbKcycEszr04xiEsFImWk8sY0k7Gw
         T1sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=KABjwKDFJlBiGhDABpxL31wGByJ+rRpjzaTCBR/LPoA=;
        b=OI4v6LIbTOHPbYZ7JFANNo3NTKIGICJhubJINNznztiqeAc9metFeisMta8DuXxg37
         dyG8CcquoI06ELeR1HQbn6vW4Zza2ZQqByfuc2znZpAFUxsHlceIiV4Fd/HY5EXHTsJA
         1MtyeFWGoMMmXVUpYbhtpwGB6P+1TRGZgEQjemXbi6QubC+VEP2suB6ZlfeUzh7laDRh
         MGeEyOgrA1b1m1Oqs6ZjvfHpG+bxu1xsb2TwlxszAEGCEd22tkonBBTABbzkEailTsDm
         AhxgmDi+XG8on1Se/d62BaQwaB/dWGI1akm0ULjWaCQZOd0vbSzeRr1UTauY7xTnHW2K
         dgcg==
X-Gm-Message-State: APjAAAV8juQrWtEOxhzLXL6cqvyw/aTwguSkNpVFXKDz4iqY7ACLF6lo
        sOOWNg5DA6J4eVvIxQPkLNE=
X-Google-Smtp-Source: APXvYqzGZyScj/1uOVWu0QQtSAM5vvXIGGYI2AoUAHkgS/wjnz3kVFyjA7Z8TGIMoVZWTQSksQq6yA==
X-Received: by 2002:a05:6214:803:: with SMTP id df3mr2549722qvb.215.1571658173090;
        Mon, 21 Oct 2019 04:42:53 -0700 (PDT)
Received: from ?IPv6:2001:4898:6808:13e:6d2d:aeab:9f95:a7f6? ([2001:4898:a800:1012:1e61:aeab:9f95:a7f6])
        by smtp.gmail.com with ESMTPSA id b185sm4470891qkg.45.2019.10.21.04.42.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Oct 2019 04:42:52 -0700 (PDT)
Subject: Re: [PATCH v4 01/17] sparse-checkout: create builtin with 'list'
 subcommand
To:     =?UTF-8?Q?SZEDER_G=c3=a1bor?= <szeder.dev@gmail.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, newren@gmail.com,
        Derrick Stolee <dstolee@microsoft.com>,
        Junio C Hamano <gitster@pobox.com>
References: <pull.316.v3.git.gitgitgadget@gmail.com>
 <pull.316.v4.git.1571147764.gitgitgadget@gmail.com>
 <63626e109767c268ee81b50abd21b95b1f1b5bfb.1571147765.git.gitgitgadget@gmail.com>
 <20191018160737.GG29845@szeder.dev>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <6d12eb61-1dce-7d58-46c9-63cd75ca17bb@gmail.com>
Date:   Mon, 21 Oct 2019 07:42:51 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:70.0) Gecko/20100101
 Thunderbird/70.0
MIME-Version: 1.0
In-Reply-To: <20191018160737.GG29845@szeder.dev>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 10/18/2019 12:07 PM, SZEDER Gábor wrote:
> On Tue, Oct 15, 2019 at 01:55:48PM +0000, Derrick Stolee via GitGitGadget wrote:
>> From: Derrick Stolee <dstolee@microsoft.com>
>>
>> The sparse-checkout feature is mostly hidden to users, as its
>> only documentation is supplementary information in the docs for
>> 'git read-tree'. In addition, users need to know how to edit the
>> .git/info/sparse-checkout file with the right patterns, then run
>> the appropriate 'git read-tree -mu HEAD' command. Keeping the
>> working directory in sync with the sparse-checkout file requires
>> care.
>>
>> Begin an effort to make the sparse-checkout feature a porcelain
>> feature by creating a new 'git sparse-checkout' builtin. This
>> builtin will be the preferred mechanism for manipulating the
>> sparse-checkout file and syncing the working directory.
>>
>> The documentation provided is adapted from the "git read-tree"
>> documentation with a few edits for clarity in the new context.
>> Extra sections are added to hint toward a future change to
>> a more restricted pattern set.
>>
>> Helped-by: Elijah Newren <newren@gmail.com>
>> Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
>> ---
>>  .gitignore                            |  1 +
>>  Documentation/git-read-tree.txt       |  2 +-
>>  Documentation/git-sparse-checkout.txt | 87 +++++++++++++++++++++++++++
>>  Makefile                              |  1 +
>>  builtin.h                             |  1 +
>>  builtin/sparse-checkout.c             | 86 ++++++++++++++++++++++++++
>>  git.c                                 |  1 +
>>  t/t1091-sparse-checkout-builtin.sh    | 50 +++++++++++++++
> 
> You need to add an entry for the new command to 'command-list.txt' as
> well, so it will be included in 'git help -a' and completion (since
> it's intended to be a porcelain), etc.
> 
>>  8 files changed, 228 insertions(+), 1 deletion(-)
>>  create mode 100644 Documentation/git-sparse-checkout.txt
>>  create mode 100644 builtin/sparse-checkout.c
>>  create mode 100755 t/t1091-sparse-checkout-builtin.sh
> 
> 
>> diff --git a/Documentation/git-sparse-checkout.txt b/Documentation/git-sparse-checkout.txt
>> new file mode 100644
>> index 0000000000..46d3dc3cb1
>> --- /dev/null
>> +++ b/Documentation/git-sparse-checkout.txt
>> @@ -0,0 +1,87 @@
>> +git-sparse-checkout(1)
>> +=======================
> 
> The ==== line is one character longer than the title; I think their
> length should match.  The other day the Documentation CI job failed
> because the length of these lines didn't match in one of the guides.
> Strangely, it doesn't complain about this one.

Interesting. GitGitGadget runs a documentation build, and it has never
failed for me. Will fix.

>> +
>> +NAME
>> +----
>> +git-sparse-checkout - Initialize and modify the sparse-checkout
>> +configuration, which reduces the checkout to a set of directories
>> +given by a list of prefixes.
>> +
>> +
>> +SYNOPSIS
>> +--------
>> +[verse]
>> +'git sparse-checkout <subcommand> [options]'
>> +
>> +
>> +DESCRIPTION
>> +-----------
>> +
>> +Initialize and modify the sparse-checkout configuration, which reduces
>> +the checkout to a set of directories given by a list of prefixes.
>> +
>> +THIS COMMAND IS EXPERIMENTAL. THE BEHAVIOR MAY CHANGE.
>> +
>> +
>> +COMMANDS
>> +--------
>> +'list'::
>> +	Provide a list of the contents in the sparse-checkout file.
>> +
>> +
>> +SPARSE CHECKOUT
>> +----------------
> 
> This is longer as well.
> 
>> +
>> +"Sparse checkout" allows populating the working directory sparsely.
>> +It uses the skip-worktree bit (see linkgit:git-update-index[1]) to tell
>> +Git whether a file in the working directory is worth looking at. If
>> +the skip-worktree bit is set, then the file is ignored in the working
>> +directory. Git will not populate the contents of those files, which
>> +makes a sparse checkout helpful when working in a repository with many
>> +files, but only a few are important to the current user.
>> +
>> +The `$GIT_DIR/info/sparse-checkout` file is used to define the
>> +skip-worktree reference bitmap. When Git updates the working
>> +directory, it updates the skip-worktree bits in the index based
>> +on this file. The files matching the patterns in the file will
>> +appear in the working directory, and the rest will not.
>> +
>> +## FULL PATTERN SET
>> +
>> +By default, the sparse-checkout file uses the same syntax as `.gitignore`
>> +files.
>> +
>> +While `$GIT_DIR/info/sparse-checkout` is usually used to specify what
>> +files are included, you can also specify what files are _not_ included,
>> +using negative patterns. For example, to remove the file `unwanted`:
>> +
>> +----------------
>> +/*
>> +!unwanted
>> +----------------
>> +
>> +Another tricky thing is fully repopulating the working directory when you
>> +no longer want sparse checkout. You cannot just disable "sparse
>> +checkout" because skip-worktree bits are still in the index and your working
>> +directory is still sparsely populated. You should re-populate the working
>> +directory with the `$GIT_DIR/info/sparse-checkout` file content as
>> +follows:
>> +
>> +----------------
>> +/*
>> +----------------
>> +
>> +Then you can disable sparse checkout. Sparse checkout support in 'git
>> +checkout' and similar commands is disabled by default. You need to
>> +set `core.sparseCheckout` to `true` in order to have sparse checkout
>> +support.
>> +
>> +SEE ALSO
>> +--------
>> +
>> +linkgit:git-read-tree[1]
>> +linkgit:gitignore[5]
>> +
>> +GIT
>> +---
>> +Part of the linkgit:git[1] suite
> 
>> diff --git a/t/t1091-sparse-checkout-builtin.sh b/t/t1091-sparse-checkout-builtin.sh
>> new file mode 100755
>> index 0000000000..a9b04b1a88
>> --- /dev/null
>> +++ b/t/t1091-sparse-checkout-builtin.sh
>> @@ -0,0 +1,50 @@
>> +#!/bin/sh
>> +
>> +test_description='sparse checkout builtin tests'
>> +
>> +. ./test-lib.sh
>> +
>> +test_expect_success 'setup' '
>> +	git init repo &&
>> +	(
>> +		cd repo &&
>> +		echo "initial" >a &&
>> +		mkdir folder1 folder2 deep &&
>> +		mkdir deep/deeper1 deep/deeper2 &&
>> +		mkdir deep/deeper1/deepest &&
>> +		cp a folder1 &&
>> +		cp a folder2 &&
>> +		cp a deep &&
>> +		cp a deep/deeper1 &&
>> +		cp a deep/deeper2 &&
>> +		cp a deep/deeper1/deepest &&
> 
> There are six 'cp' invocations here.  Curious: does this mean that
> it's important that all those files are the same?

The content of the "a" file is not important at all to the
tests. It only matters that there is a blob in each of these
trees.

> 
>> +		git add . &&
>> +		git commit -m "initial commit"
>> +	)
>> +'
>> +
>> +test_expect_success 'git sparse-checkout list (empty)' '
>> +	git -C repo sparse-checkout list >list 2>err &&
>> +	test_line_count = 0 list &&
> 
> Nit: test_must_be_empty might be a bit more idiomatic, dunno.
> 
>> +	test_i18ngrep "this worktree is not sparse (sparse-checkout file may not exist)" err
>> +'
>> +
>> +test_expect_success 'git sparse-checkout list (populated)' '
>> +	test_when_finished rm -f repo/.git/info/sparse-checkout &&
>> +	cat >repo/.git/info/sparse-checkout <<-EOF &&
>> +		/folder1/*
>> +		/deep/
>> +		**/a
>> +		!*bin*
>> +	EOF
>> +	git -C repo sparse-checkout list >list &&
>> +	cat >expect <<-EOF &&
>> +		/folder1/*
>> +		/deep/
>> +		**/a
>> +		!*bin*
>> +	EOF
> 
> OTOH, here the content of the 'sparse-checkout' file and 'expect' must
> be the same, but one has to carefully look through four lines of
> patterns to realize that they are indeed the same.  I think in this
> case the explicitness of 'cp' would be better.

That's fine. We explicitly set the contents in the line above.

>> +	test_cmp expect list
>> +'
>> +
>> +test_done
>> -- 
>> gitgitgadget
>>

