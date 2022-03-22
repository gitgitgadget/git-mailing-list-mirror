Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC745C433EF
	for <git@archiver.kernel.org>; Tue, 22 Mar 2022 15:05:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235592AbiCVPGo (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 22 Mar 2022 11:06:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233694AbiCVPGn (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Mar 2022 11:06:43 -0400
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com [IPv6:2607:f8b0:4864:20::72a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43B6680224
        for <git@vger.kernel.org>; Tue, 22 Mar 2022 08:05:15 -0700 (PDT)
Received: by mail-qk1-x72a.google.com with SMTP id p25so7699812qkj.10
        for <git@vger.kernel.org>; Tue, 22 Mar 2022 08:05:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=tON66raZ07KLwI70qpTsIF0AGGJsqr2NrobZZ7maxIY=;
        b=jCELsI2E5yKQtuP6n17PyRD5GXHfzG5Q2uN4omkrviKPlWgT7VdxPETlwMWw7Q1NH2
         zmbd+pbSFYlxXPQEb1v5szyGcJWqMcXZY/pLi8BbWWtMQaVdGvCOyuU1AfeeofPM0z9U
         JKddOW+sOGSeu66dr88XdSElrVHosxbMZ1RpKCgGlfcAdToOglm+WI6h3SB/zVEXf186
         37sTWr+eN1UGMqP8qvuXxQlNxJ6CkqGciV3nl1h3JUFxUFVCkruxUv+MsBLqzBvRPSqh
         TLRIwDlXbyomIio2bS3cGtpASqUgzUe6BiTjP5YCAjtD4qxmCuVrX+bUwbekkEy2lcxl
         /R2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=tON66raZ07KLwI70qpTsIF0AGGJsqr2NrobZZ7maxIY=;
        b=r5GbkWQUQJDMQERCyD5pAORLk1IPJKVHp/RZW+Ph41YKfABBuzIpdzmi0t8Jnmnvkp
         m0eb1Qh5jl9bvOmlxde+gAtbbZ7TkRIlgWSSSTsfvaHLujtTuVajC+XkS57+lJbJ5tM5
         6BWHbR2Mpef0OzBG9aalBCRThgQzxjEzUW9slP1EZmc8h0y2SSYolWNfC0LhlvCgVkQe
         d9NpDXWDXmTvujdgXVNgPVDyfl5lp7JfxQOfjw4VzYEE0kOCNwEmjli7kt2KW1/7eQQO
         Ng4jIpDDjw8safpDU8Zq3n/AYhUw7rsjKSuAAa3jDuM2zuKx/BmR+MP7VUcbqK81ynUK
         Aehg==
X-Gm-Message-State: AOAM531dvQpL8C5pQodk/f1K1eleKODaVdHopyjBi0WPgFeAzZRqQR59
        To/l94bstrCSXTXU5ctcPvII
X-Google-Smtp-Source: ABdhPJxQuBKhQ8vGRjym6EF+vcqW2VFpMeCb+rU5TqoN17ye85YSASNpj4+JUp355Jh8IBDAxRfP1A==
X-Received: by 2002:a05:620a:4723:b0:67d:7348:8c0e with SMTP id bs35-20020a05620a472300b0067d73488c0emr15952546qkb.727.1647961514130;
        Tue, 22 Mar 2022 08:05:14 -0700 (PDT)
Received: from [192.168.20.184] (GITHUB-INC.bear2.Charlotte1.Level3.net. [4.4.99.78])
        by smtp.gmail.com with ESMTPSA id 8-20020ac85948000000b002e1cd3fa142sm15175905qtz.92.2022.03.22.08.05.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Mar 2022 08:05:13 -0700 (PDT)
Message-ID: <acb2c221-8bf0-9cf8-8fee-8c6a807836cd@github.com>
Date:   Tue, 22 Mar 2022 11:05:12 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.7.0
Subject: Re: [PATCH v5 0/4] Documentation/git-sparse-checkout.txt: add an
 OPTIONS section
Content-Language: en-US
To:     Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>, gitster@pobox.com
Cc:     git@vger.kernel.org, vdye@github.com
References: <20220311132141.1817-1-shaoxuan.yuan02@gmail.com>
 <20220319061910.786850-1-shaoxuan.yuan02@gmail.com>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <20220319061910.786850-1-shaoxuan.yuan02@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 3/19/22 2:19 AM, Shaoxuan Yuan wrote:
> == Updates Log ==
> 
> Changes since v4
> 
>  * ship a multi-patch series to reflect the history
>  * base on Elijah's series [1]
>  * changes according to Junio [2]
> 
> [1] https://lore.kernel.org/git/pull.1148.v2.git.1647054681.gitgitgadget@gmail.com/
> [2] https://lore.kernel.org/git/xmqqfsnfb42c.fsf@gitster.g/
> 
> == Overview ==
> 
> Add an OPTIONS section to the manual. Also provide corresponding text changes
> for better understanding the topic.
> Shaoxuan Yuan (4):
>   Documentation/git-sparse-checkout.txt: add an OPTIONS section
>   Documentation/git-sparse-checkout.txt: move OPTIONS after COMMANDS
>   Documentation/git-sparse-checkout.txt: some reword and modifications
>   Documentation/git-sparse-checkout.txt: some reword and modifications

Hi Shaoxuan,

This commit organization seems to be one that you created naturally from
responding to feedback. Unfortunately, we expect that each patch is
expected to be created with the intent of presenting changes in an
efficient way. This helps both with review and future history
investigations. See Documentation/SubmittingPatches for more information.

In particular, patches 2-4 are of the mode "Modify the changes from patch
1 based on feedback". Instead, we expect that you update that single patch
unless there is a clear reason why two separate changes are valuable.

When submitting new versions to a series, adding a range-diff to your
cover letter helps reviewers see what changed between versions, so we
still see how you responded to our feedback in a more isolated way.

I took your changes and applied them to en/sparse-cone-becomes-default and
got the diff below end-to-end. This is much easier to read. It also makes
some things clear (like an unnecessary whitespace change).

I think that this diff would be better served as a single patch. I'll
review this diff inline below:


> diff --git a/Documentation/git-sparse-checkout.txt b/Documentation/git-sparse-checkout.txt
> index e4a29a2baa9..482ecfe28c5 100644
> --- a/Documentation/git-sparse-checkout.txt
> +++ b/Documentation/git-sparse-checkout.txt
> @@ -48,6 +48,14 @@ COMMANDS
>  	following the 'set' subcommand, and update the working directory to
>  	match.
>  +
> +By default, the arguments to the `set` command are interpreted as a
> +list of directories. The sparse-checkout patterns are set to match
> +all files within those directories, recursively, as well as any file
> +directly contained in a parent of those directories. See INTERNALS
> +-- CONE PATTERN SET below for full details. If --no-cone is specified,
> +then the arguments are interpreted as sparse-checkout patterns. See
> +INTERNALS -- FULL PATTERN SET below for more information.
> ++
>  To ensure that adjusting the sparse-checkout settings within a worktree
>  does not alter the sparse-checkout settings in other worktrees, the 'set'
>  subcommand will upgrade your repository config to use worktree-specific
> @@ -55,48 +63,10 @@ config if not already present. The sparsity defined by the arguments to
>  the 'set' subcommand are stored in the worktree-specific sparse-checkout
>  file. See linkgit:git-worktree[1] and the documentation of
>  `extensions.worktreeConfig` in linkgit:git-config[1] for more details.
> -+
> -When the `--stdin` option is provided, the directories or patterns are
> -read from standard in as a newline-delimited list instead of from the
> -arguments.
> -+
> -By default, the input list is considered a list of directories, matching
> -the output of `git ls-tree -d --name-only`.  This includes interpreting
> -pathnames that begin with a double quote (") as C-style quoted strings.
> -Note that all files under the specified directories (at any depth) will
> -be included in the sparse checkout, as well as files that are siblings
> -of either the given directory or any of its ancestors (see 'CONE PATTERN
> -SET' below for more details).  In the past, this was not the default,
> -and `--cone` needed to be specified or `core.sparseCheckoutCone` needed
> -to be enabled.
> -+
> -When `--no-cone` is passed, the input list is considered a list of
> -patterns.  This mode is harder to use, and unless you can keep the
> -number of patterns small, its design also scales poorly.  It used to be
> -the default mode, but we do not recommend using it.  It does not work
> -with the `--sparse-index` option, and will likely be incompatible with
> -other new features as they are added.  See the "Non-cone Problems"
> -section below and the "Sparse Checkout" section of
> -linkgit:git-read-tree[1] for more details.
> -+
> -Use the `--[no-]sparse-index` option to use a sparse index (the
> -default is to not use it).  A sparse index reduces the size of the
> -index to be more closely aligned with your sparse-checkout
> -definition. This can have significant performance advantages for
> -commands such as `git status` or `git add`.  This feature is still
> -experimental. Some commands might be slower with a sparse index until
> -they are properly integrated with the feature.
> -+
> -**WARNING:** Using a sparse index requires modifying the index in a way
> -that is not completely understood by external tools. If you have trouble
> -with this compatibility, then run `git sparse-checkout init --no-sparse-index`
> -to rewrite your index to not be sparse. Older versions of Git will not
> -understand the sparse directory entries index extension and may fail to
> -interact with your repository until it is disabled.
>  
>  'add'::
>  	Update the sparse-checkout file to include additional directories
> -	(in cone mode) or patterns (in non-cone mode).  By default, these
> +	(in cone mode) or patterns (in non-cone mode). By default, these

This whitespace change doesn't need to be here. I do think a single space
is more common in our docs, but it has no effect on the rendered docs, so
this is unnecessary noise for the diff.

>  	directories or patterns are read from the command-line arguments,
>  	but they can be read from stdin using the `--stdin` option.
>  
> @@ -109,11 +79,6 @@ interact with your repository until it is disabled.
>  	cases, it can make sense to run `git sparse-checkout reapply` later
>  	after cleaning up affected paths (e.g. resolving conflicts, undoing
>  	or committing changes, etc.).
> -+
> -The `reapply` command can also take `--[no-]cone` and `--[no-]sparse-index`
> -flags, with the same meaning as the flags from the `set` command, in order
> -to change which sparsity mode you are using without needing to also respecify
> -all sparsity paths.
>  
>  'disable'::
>  	Disable the `core.sparseCheckout` config setting, and restore the
> @@ -139,6 +104,41 @@ paths to pass to a subsequent 'set' or 'add' command.  However,
>  the disable command, so the easy restore of calling a plain `init`
>  decreased in utility.
>  
> +
> +OPTIONS
> +-------
> +'--[no-]cone'::
> +	Use with the `set` and `reapply` commands.
> +	Specify using cone mode or not. The default is to use cone mode.
> +
> +'--[no-]sparse-index'::
> +	Use with the `set` and `reapply` commands.
> +	Specify using a sparse index or not. The default is to not use a
> +	sparse index.
> ++
> +Use the `--[no-]sparse-index` option to use a sparse index (the

I find this a bit confusing. Maybe just "`--sparse-index`" would make
it clear that leaving out the [no-] is for enabling it.

> +default is to not use it).  A sparse index reduces the size of the
> +index to be more closely aligned with your sparse-checkout
> +definition. This can have significant performance advantages for
> +commands such as `git status` or `git add`.  This feature is still
> +experimental. Some commands might be slower with a sparse index until
> +they are properly integrated with the feature.
> ++
> +**WARNING:** Using a sparse index requires modifying the index in a way
> +that is not completely understood by external tools. If you have trouble
> +with this compatibility, then run `git sparse-checkout init --no-sparse-index`
> +to rewrite your index to not be sparse. Older versions of Git will not
> +understand the sparse directory entries index extension and may fail to
> +interact with your repository until it is disabled.
> +
> +'--stdin'::
> +	Use with the `set` and `add` commands.
> ++
> +When the `--stdin` option is provided, the directories or patterns are
> +read from standard in as a newline-delimited list instead of from the
> +arguments.
> +
> +

I find it a lot easier to see these options being moved and updated at the
same time.

Thanks,
-Stolee
