Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE195C433F5
	for <git@archiver.kernel.org>; Tue,  7 Dec 2021 20:42:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241413AbhLGUpy (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Dec 2021 15:45:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241412AbhLGUpx (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Dec 2021 15:45:53 -0500
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com [IPv6:2607:f8b0:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5AA1C061574
        for <git@vger.kernel.org>; Tue,  7 Dec 2021 12:42:22 -0800 (PST)
Received: by mail-oi1-x235.google.com with SMTP id bj13so896689oib.4
        for <git@vger.kernel.org>; Tue, 07 Dec 2021 12:42:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=t9VnGiGqin/pIMSDsxq1hnzxQXrO/blvb53tTQaZdVg=;
        b=h3IzTfKQireYL95bvv3OoPwOnfHNMZEiKvpsB5cvpfn1JDjn0VU2WleSxjhh8qbjys
         SwZEGJKA5O1+v8VDXugiQ3M3+krlrqnw+dzSx3UKyoHc9DW0EIR3yKb0FeKy+X9Pv7sW
         kJMxua5noZ2PQFPBXiP1+7tZO6uI1IdCf7bbizXN6QxEeuJJGPOUgqWu4AenU73usWQd
         3DqlnibYObXHEjuNq+GfS0xgueoaGqvQluhPUzbVMIRvsV8t3zxCoYJXPaTxuMDGxOK5
         PznlCO9aKOEkVMs3JX0mQZVJGMk4o4frDeg4Pd0a2MkLIvX8dDqoLNkXxBulIAIf6Aba
         1WUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=t9VnGiGqin/pIMSDsxq1hnzxQXrO/blvb53tTQaZdVg=;
        b=JSeIlO3+8wYXwmIj2ig1RfPa0kpLK9ZQkPGqTrYEOOdxpBAZQQB1qgHHnUK2jRZpa1
         rgFow7lbO6gtTVgq02rM/rhl1boKfHkOb/OphCrqSP0gUp1RvGrwQOBK+iJ/pL4E+bh+
         muok2sZss0IxBy5FVxKpH1yiAZPy0jDJGdXkOGza83O7pO9iogCD7YLoSicP4YYRin5+
         6WUY61tF3E0LgSeucnEtQBWwy9ezpQmLuUG6WSrsp4xo/fTLHik+cwTcgWUwVetR5qJq
         eYcHaMeFjGkRAS4N2bRY+ISqtX4QmWOKSJDQrClNXbcFITmG4+U/JI0Mh5gmuupnEl0L
         6C4A==
X-Gm-Message-State: AOAM531v+MDqza/7JKqruUo8dY3t5CIKZKIlYL/ySysHKG1U13i+guuo
        rm5Skp+ujj+jqFXh6DWZkqc=
X-Google-Smtp-Source: ABdhPJzKgIUVFSrodNQBR1fAGjL0gWsLz/EbudeW3XITQmyfoneSle3B0+E297QKJxoClSQdCHIF7g==
X-Received: by 2002:a05:6808:643:: with SMTP id z3mr7427601oih.110.1638909742032;
        Tue, 07 Dec 2021 12:42:22 -0800 (PST)
Received: from [192.168.86.121] (097-087-102-211.res.spectrum.com. [97.87.102.211])
        by smtp.gmail.com with ESMTPSA id w5sm121119otk.70.2021.12.07.12.42.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Dec 2021 12:42:21 -0800 (PST)
Message-ID: <7c2a8b0e-a387-1166-ea02-e5792537aefa@gmail.com>
Date:   Tue, 7 Dec 2021 14:42:20 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.3.2
Subject: Re: [PATCH 4/6] git-sparse-checkout.txt: update to document that set
 handles init
Content-Language: en-US
To:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Derrick Stolee <stolee@gmail.com>, Victoria Dye <vdye@github.com>,
        Elijah Newren <newren@gmail.com>
References: <pull.1151.git.git.1638648020.gitgitgadget@gmail.com>
 <95d3df78b2ffe2e0d6234f326f8f7acbd2b67301.1638648020.git.gitgitgadget@gmail.com>
From:   Lessley Dennington <lessleydennington@gmail.com>
In-Reply-To: <95d3df78b2ffe2e0d6234f326f8f7acbd2b67301.1638648020.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 12/4/21 12:00 PM, Elijah Newren via GitGitGadget wrote:
> From: Elijah Newren <newren@gmail.com>
> 
> As noted in the previous commit, using separate `init` and `set` steps
> with sparse-checkout result in a number of issues.  The previous commit
> made `set` able to handle the work of both commands.  Update the
> documentation to reflect this, and mark `init` as deprecated.
> 
> Signed-off-by: Elijah Newren <newren@gmail.com>
> ---
>   Documentation/git-sparse-checkout.txt | 92 ++++++++++++++-------------
>   1 file changed, 49 insertions(+), 43 deletions(-)
> 
> diff --git a/Documentation/git-sparse-checkout.txt b/Documentation/git-sparse-checkout.txt
> index 42056ee9ff9..d22c925ecf8 100644
> --- a/Documentation/git-sparse-checkout.txt
> +++ b/Documentation/git-sparse-checkout.txt
> @@ -30,28 +30,35 @@ COMMANDS
>   'list'::
>   	Describe the patterns in the sparse-checkout file.
>   
> -'init'::
> -	Enable the `core.sparseCheckout` setting. If the
> -	sparse-checkout file does not exist, then populate it with
> -	patterns that match every file in the root directory and
> -	no other directories, then will remove all directories tracked
> -	by Git. Add patterns to the sparse-checkout file to
> -	repopulate the working directory.
> +'set'::
> +	Enable the necessary config settings
> +	(extensions.worktreeConfig, core.sparseCheckout,
> +	core.sparseCheckoutCone) if they are not already enabled, and
> +	write a set of patterns to the sparse-checkout file from the
> +	list of arguments following the 'set' subcommand. Update the
> +	working directory to match the new patterns.
>   +
> -To avoid interfering with other worktrees, it first enables the
> -`extensions.worktreeConfig` setting and makes sure to set the
> -`core.sparseCheckout` setting in the worktree-specific config file.
> +When the `--stdin` option is provided, the patterns are read from
> +standard in as a newline-delimited list instead of from the arguments.
>   +
> -When `--cone` is provided, the `core.sparseCheckoutCone` setting is
> -also set, allowing for better performance with a limited set of
> -patterns (see 'CONE PATTERN SET' below).
> +When `--cone` is passed or `core.sparseCheckoutCone` is enabled, the
> +input list is considered a list of directories instead of
> +sparse-checkout patterns.  This allows for better performance with a
> +limited set of patterns (see 'CONE PATTERN SET' below).  Note that the
> +set command will write patterns to the sparse-checkout file to include
> +all files contained in those directories (recursively) as well as
> +files that are siblings of ancestor directories. The input format
> +matches the output of `git ls-tree --name-only`.  This includes
> +interpreting pathnames that begin with a double quote (") as C-style
> +quoted strings.
>   +
> -Use the `--[no-]sparse-index` option to toggle the use of the sparse
> -index format. This reduces the size of the index to be more closely
> -aligned with your sparse-checkout definition. This can have significant
> -performance advantages for commands such as `git status` or `git add`.
> -This feature is still experimental. Some commands might be slower with
> -a sparse index until they are properly integrated with the feature.
> +Use the `--[no-]sparse-index` option to use a sparse index (the
> +default is to not use it).  A sparse index reduces the size of the
> +index to be more closely aligned with your sparse-checkout
> +definition. This can have significant performance advantages for
> +commands such as `git status` or `git add`.  This feature is still
> +experimental. Some commands might be slower with a sparse index until
> +they are properly integrated with the feature.
>   +
>   **WARNING:** Using a sparse index requires modifying the index in a way
>   that is not completely understood by external tools. If you have trouble
> @@ -60,23 +67,6 @@ to rewrite your index to not be sparse. Older versions of Git will not
>   understand the sparse directory entries index extension and may fail to
>   interact with your repository until it is disabled.
>   
> -'set'::
> -	Write a set of patterns to the sparse-checkout file, as given as
> -	a list of arguments following the 'set' subcommand. Update the
> -	working directory to match the new patterns. Enable the
> -	core.sparseCheckout config setting if it is not already enabled.
> -+
> -When the `--stdin` option is provided, the patterns are read from
> -standard in as a newline-delimited list instead of from the arguments.
> -+
> -When `core.sparseCheckoutCone` is enabled, the input list is considered a
> -list of directories instead of sparse-checkout patterns. The command writes
> -patterns to the sparse-checkout file to include all files contained in those
> -directories (recursively) as well as files that are siblings of ancestor
> -directories. The input format matches the output of `git ls-tree --name-only`.
> -This includes interpreting pathnames that begin with a double quote (") as
> -C-style quoted strings.
> -
>   'add'::
>   	Update the sparse-checkout file to include additional patterns.
>   	By default, these patterns are read from the command-line arguments,
> @@ -96,9 +86,27 @@ C-style quoted strings.
>   
>   'disable'::
>   	Disable the `core.sparseCheckout` config setting, and restore the
> -	working directory to include all files. Leaves the sparse-checkout
> -	file intact so a later 'git sparse-checkout init' command may
> -	return the working directory to the same state.
> +	working directory to include all files.
> +
> +'init'::
> +	Deprecated command that behaves like `set` with no specified paths.
> +	May be removed in the future.
> ++
> +Historically, `set` did not used to handle all the necessary config
> +settings, which meant that both `init` and `set` had to be called.
> +Invoking both meant the `init` step would first remove nearly all
> +tracked files (and in cone mode, ignored files too), then the `set`
> +step would add many of the tracked files (but not ignored files) back.
> +In addition to the lost files, the performance and UI of this
> +combination was poor.
> ++
Super nit: Perhaps update '`set` did not used to handle' to '`set` did not
handle'.
> +Also, historically, `init` would not actually initialize the
> +sparse-checkout file if it already existed.  This meant it was
> +possible to return to a sparse-checkout without remembering which
> +paths to pass to a subsequent 'set' or 'add' command.  However,
> +`--cone` and `--sparse-index` options would not be remembered across
> +the disable command, so the easy restore of calling a plain `init`
> +decreased in utility.
>   
>   SPARSE CHECKOUT
>   ---------------
> @@ -117,10 +125,8 @@ directory, it updates the skip-worktree bits in the index based
>   on this file. The files matching the patterns in the file will
>   appear in the working directory, and the rest will not.
>   
> -To enable the sparse-checkout feature, run `git sparse-checkout init` to
> -initialize a simple sparse-checkout file and enable the `core.sparseCheckout`
> -config setting. Then, run `git sparse-checkout set` to modify the patterns in
> -the sparse-checkout file.
> +To enable the sparse-checkout feature, run `git sparse-checkout set` to
> +set the patterns you want to use.
>   
>   To repopulate the working directory with all files, use the
>   `git sparse-checkout disable` command.
> 
