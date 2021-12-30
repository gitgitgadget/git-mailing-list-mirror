Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0D14C433EF
	for <git@archiver.kernel.org>; Thu, 30 Dec 2021 13:50:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239735AbhL3Nue (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 30 Dec 2021 08:50:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235821AbhL3Nud (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Dec 2021 08:50:33 -0500
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com [IPv6:2607:f8b0:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A00EC061574
        for <git@vger.kernel.org>; Thu, 30 Dec 2021 05:50:33 -0800 (PST)
Received: by mail-ot1-x334.google.com with SMTP id 45-20020a9d0a30000000b0058f1a6df088so32420728otg.4
        for <git@vger.kernel.org>; Thu, 30 Dec 2021 05:50:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=NNgLhbjiZEwMVZJbD7GZMq/JV8gejnl+sNnJ5Oifr7I=;
        b=ct8paUVA7m4+u8PL+7Jx4OxI2e2/AFyYTtGCK3I+41xnsESDRe1wmnIOVBxUHMKuD5
         XI/i4QH5EPEkheZe5nvQYQP5du9sz2iVQzZDXH3DQjtNJ4zEpU5CeyvW5n1m0SMALi09
         sm5IH50IApoXQQFbRMW3r8wK9WUtgKBoB2/IQveP1E6wz++lJT5xqyYN18yVX05YBaCG
         L6aM2G7vi+js7pXTMCiakPOQa92s75anWyGWhpqvurg7ve0robIY2g5TYaXbflIbdNeu
         qKAqpMEQgOUT/hasFmgaBhR4AJTB/nJDPiacmAxGCw3b8JzpbxLO/pcy1y9YkyWRpf0r
         QxeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=NNgLhbjiZEwMVZJbD7GZMq/JV8gejnl+sNnJ5Oifr7I=;
        b=MysCzxB1sBaGrOE8bNSJE431Yx/D9+fr9HnS+VNRKrutJU+jcC7V9j68TcUqejpvoV
         UVWYZ8upQtHZn5s5/aizOlqVo15i4/emzZT1aIA7jd7YUzFy2EzmrerYSqvz1oUaA9JR
         lRqa6qgfZVYBwEZ4jrxOsjvfQTlT9LIEb0DkRnheiCEXyOCutr4L4AXTsoRY4E++HaKa
         zY2M/LwF5XnKemEDm62c4xf6LCXXp+ap8HDvcs0VkzOBc3h9MBD/XdT3slTbZSPSeYhP
         8b6TNtthLQmYZCfcB4qRJGNOCEVQB89vStQME+A+IfaAMS/3HnE71XMXzPqn3vH/7oO7
         tklA==
X-Gm-Message-State: AOAM533jKpGc4qpbF3svyOxn9tJRV8gkTmIl4/tyd/B6PJzWpXGHiDR5
        pMBt6aQznbAWb8Glsda6mXxmMhvrShY=
X-Google-Smtp-Source: ABdhPJzQ80MxCjMpJH7f9NwdOW1pdyj6QmuurBHBcHtWOXEfUEraKfqTpQJyPab+DPCQEPAevcFcIw==
X-Received: by 2002:a9d:350:: with SMTP id 74mr21706311otv.238.1640872232674;
        Thu, 30 Dec 2021 05:50:32 -0800 (PST)
Received: from ?IPV6:2600:1700:e72:80a0:cd5c:4260:de91:c496? ([2600:1700:e72:80a0:cd5c:4260:de91:c496])
        by smtp.gmail.com with ESMTPSA id k10sm5621030oil.36.2021.12.30.05.50.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Dec 2021 05:50:32 -0800 (PST)
Message-ID: <c79ccf4a-4da9-1c60-32eb-124d3fa94400@gmail.com>
Date:   Thu, 30 Dec 2021 08:50:31 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
Subject: Re: [PATCH 2/2] sparse-checkout: custom tab completion
Content-Language: en-US
To:     Lessley Dennington via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     gitster@pobox.com, johannes.schindelin@gmail.com,
        Lessley Dennington <lessleydennington@gmail.com>
References: <pull.1108.git.1640824351.gitgitgadget@gmail.com>
 <ab51236d18ce10ada89e8cde85f678130a0ab1fd.1640824351.git.gitgitgadget@gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
In-Reply-To: <ab51236d18ce10ada89e8cde85f678130a0ab1fd.1640824351.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 12/29/2021 7:32 PM, Lessley Dennington via GitGitGadget wrote:
> From: Lessley Dennington <lessleydennington@gmail.com>
> 
> Fix custom tab completion for sparse-checkout command. This will ensure:
> 
> 1. The full list of subcommands is provided when users enter git
> sparse-checkout <TAB>.
> 2. The --help option is tab-completable.
> 3. Subcommand options are tab-completable.
> 4. A list of directories (but not files) is provided when users enter git
> sparse-checkout add <TAB> or git sparse-checkout set <TAB>.
> 
> Failing tests that were added in the previous commit to verify these
> scenarios are now passing with these updates.
> 
> Signed-off-by: Lessley Dennington <lessleydennington@gmail.com>
> ---
>  contrib/completion/git-completion.bash | 34 +++++++++++++++++---------
>  t/t9902-completion.sh                  |  8 +++---
>  2 files changed, 26 insertions(+), 16 deletions(-)
> 
> diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
> index 377d6c5494a..b8f1caece83 100644
> --- a/contrib/completion/git-completion.bash
> +++ b/contrib/completion/git-completion.bash
> @@ -2986,24 +2986,34 @@ _git_show_branch ()
>  	__git_complete_revlist
>  }
>  
> +__git_sparse_checkout_init_opts="--cone --sparse-index --no-sparse-index"
> +
>  _git_sparse_checkout ()
>  {
> -	local subcommands="list init set disable"
> +	local subcommands="list init set disable add reapply"
>  	local subcommand="$(__git_find_on_cmdline "$subcommands")"
> +
>  	if [ -z "$subcommand" ]; then
> -		__gitcomp "$subcommands"
> -		return
> +		case "$cur" in
> +			--*)
> +				__gitcomp "--help"
> +				;;
> +			*)
> +				__gitcomp "$subcommands"
> +				;;
> +		esac

This part fixes the --<tab> completion. I suppose if someone
did "-<tab>" then nothing would show up?

>  	fi
>  
> -	case "$subcommand,$cur" in
> -	init,--*)
> -		__gitcomp "--cone"
> -		;;
> -	set,--*)
> -		__gitcomp "--stdin"
> -		;;
> -	*)
> -		;;
> +	case "$prev" in
> +		init)
> +			__gitcomp "$__git_sparse_checkout_init_opts"
> +			;;
> +		add|set)
> +			__gitcomp "--stdin"
> +			__gitcomp "$(git ls-tree -d -r HEAD --name-only)"> +			;;

With the thinking of rebasing onto en/sparse-checkout-set, this
could possibly be rearranged so the add|set) cases pass-through
into the init) and reapply) cases (skip the ;; between) to save
some duplication. Or, it is possible that doesn't work, but it
might be worth a try.

Also, since you are using 'git ls-tree' and not 'git ls-files',
the sparse index will not have an effect on the performance.
There will be some corner cases where a directory exists in one
of HEAD or the index but not the other. That's probably still
the right way to go since 'git ls-files' doesn't have a way to
only list directories. It just means that you probably don't
need to explicitly disable the sparse index in your test.

Thanks,
-Stolee
