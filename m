Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D58ED20248
	for <e@80x24.org>; Tue, 19 Mar 2019 11:24:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726743AbfCSLY6 (ORCPT <rfc822;e@80x24.org>);
        Tue, 19 Mar 2019 07:24:58 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:53854 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726573AbfCSLY6 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Mar 2019 07:24:58 -0400
Received: by mail-wm1-f66.google.com with SMTP id e74so16185983wmg.3
        for <git@vger.kernel.org>; Tue, 19 Mar 2019 04:24:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=reply-to:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=j2xePvKOGmlQ0n3Zi1fEN5HJ3lOE1ak0NrMj+R4xkAY=;
        b=HCJf/RKL5YeFnH28HV+QNIoJ2SQaJtLDw9xCNNkbBvZnKJMpg+smZ9aow1dTiz7h1F
         IdBIA7DwWtzR11l8frD04IK3t6Xx0tHeqWbib0TEf1vMybgQubP0q6M6uK19NZNGuFyZ
         yaEyaRsse2z+5ei1VL6D1ee3rzJGCTyEQMtdqfKEKnkZzSVbxX1d3E7XfqWpiugo15W9
         3469gqXF5QHpNHunrAuthRgB1j89/xzrZeUQuAlLvt9I4TVEPTAPXoTbUm6+H+ObNfdT
         7ZdDO9SyOt/sIRHgmhjKM5au4+qGpK1vCe3HFFgKm2e2ExRVT1HNU139dmMwZ+8Y0keO
         5e4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:subject:to:cc:references:from
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=j2xePvKOGmlQ0n3Zi1fEN5HJ3lOE1ak0NrMj+R4xkAY=;
        b=hXF+b7gM5JPAsXyIboHVbW8L22fh3oVP7OA+tQhgxf4VXPDfmUbVRYNYvTKi99sZdx
         UcymCq3VnfWw/czX/ux3qS3RYhqsCNV8Co+HMgv4H+sRP6Twv7aU3Uh3WMJgUF/zZRGV
         JBz6UNCRlBWCqaZYFwtmkylHmnknM+xGc/K1Bptj5N2R1ARxcVrvcAClrl1cpC3u279Z
         G2A0uQpiuxiFgKPZEx8QmdASqE2ByvCk7SYaD6a16JJFFNo8zXMAMIqvbZExSiJEzIK+
         xJzaWg0ETE140GeoVjM6McRolhuVpW/JEqDWdB8gmBjPpxU+BMEiDlL+PmgAQ9bSIyrk
         8dNw==
X-Gm-Message-State: APjAAAUZwS9AyLKh8h7WC6oLSdePHolasoPCy34ciXW0V/9+RiRNYDMq
        MG8JUKa823rHvshPvlom7TIrBaVlaq4=
X-Google-Smtp-Source: APXvYqz7jcbWcHXJCPX9BCR+cOkMnTPLYdusMw4dU4pWf9WNGgf6QcrUPJ1PT+d7FbFKD+976LtTtA==
X-Received: by 2002:a1c:4105:: with SMTP id o5mr1771244wma.35.1552994696033;
        Tue, 19 Mar 2019 04:24:56 -0700 (PDT)
Received: from [192.168.2.240] (host-89-242-184-133.as13285.net. [89.242.184.133])
        by smtp.gmail.com with ESMTPSA id y7sm2707965wmi.34.2019.03.19.04.24.54
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Tue, 19 Mar 2019 04:24:55 -0700 (PDT)
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH] checkout.txt: note about losing staged changes with
 --merge
To:     =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, newren@gmail.com,
        phillip.wood@dunelm.org.uk, sunshine@sunshineco.com,
        szeder.dev@gmail.com
References: <78628256-79dc-3036-c57b-a96797ceb120@gmail.com>
 <20190319093910.20229-1-pclouds@gmail.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
Message-ID: <f9e3bd68-935c-3bca-6d06-66f51ba15451@gmail.com>
Date:   Tue, 19 Mar 2019 11:24:53 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.3
MIME-Version: 1.0
In-Reply-To: <20190319093910.20229-1-pclouds@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB-large
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Duy

On 19/03/2019 09:39, Nguyễn Thái Ngọc Duy wrote:
> If you have staged changes in path A and perform 'checkout
> --merge' (which could result in conflicts in a totally unrelated path
> B), changes in A will be gone. Which is unexpected. We are supposed
> to keep all changes, or kick and scream otherwise.
> 
> This is the result of how --merge is implemented, from the very first
> day in 1be0659efc (checkout: merge local modifications while switching
> branches., 2006-01-12):
> 
> 1. a merge is done, unmerged entries are collected
> 2. a hard switch to a new branch is done, then unmerged entries added
>     back
> 
> There is no trivial fix for this. Going with 3-way merge one file at a
> time loses rename detection. Going with 3-way merge by trees requires
> teaching the algorithm to pick up staged changes. And even if we detect
> staged changes with --merge and abort for safety, an option to continue
> --merge is very weird. Such an option would keep worktree changes, but
> drop staged changes.
> 
> Because the problem has been with us since the introduction of --merge
> and everybody has been pretty happy (except Phillip, who found this
> problem), I'll just take a note here to acknowledge it and wait for
> merge wizards to come in and work their magic. There may be a way
> forward [1].
> 
> [1] CABPp-BFoL_U=bzON4SEMaQSKU2TKwnOgNqjt5MUaOejTKGUJxw@mail.gmail.com
> 
> Reported-by: Phillip Wood <phillip.wood123@gmail.com>

I try to use phillip.wood@dunelm.org.uk for git stuff as it shouldn't 
change in the future.

> Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
> ---
>   This is my "fix" for Phillip's second problem. I chose to reply here
>   because this is where an actual fix was discussed. The test script to
>   demonstate it is here
> 
>   https://public-inbox.org/git/7d3742d6-73e4-2750-6ecb-9edf761d96dd@gmail.com/
> 
>   Documentation/git-checkout.txt | 2 ++
>   builtin/checkout.c             | 9 +++++++++
>   2 files changed, 11 insertions(+)
> 
> diff --git a/Documentation/git-checkout.txt b/Documentation/git-checkout.txt
> index f179b43732..877e5f503a 100644
> --- a/Documentation/git-checkout.txt
> +++ b/Documentation/git-checkout.txt
> @@ -242,6 +242,8 @@ should result in deletion of the path).
>   +
>   When checking out paths from the index, this option lets you recreate
>   the conflicted merge in the specified paths.
> ++
> +When switching branches with `--merge`, staged changes may be lost.
>   
>   --conflict=<style>::
>   	The same as --merge option above, but changes the way the
> diff --git a/builtin/checkout.c b/builtin/checkout.c
> index 0e6037b296..f95e7975f7 100644
> --- a/builtin/checkout.c
> +++ b/builtin/checkout.c
> @@ -726,6 +726,8 @@ static int merge_working_tree(const struct checkout_opts *opts,
>   			struct tree *result;
>   			struct tree *work;
>   			struct merge_options o;
> +			struct strbuf sb = STRBUF_INIT;
> +
>   			if (!opts->merge)
>   				return 1;
>   
> @@ -736,6 +738,13 @@ static int merge_working_tree(const struct checkout_opts *opts,
>   			if (!old_branch_info->commit)
>   				return 1;
>   
> +			if (repo_index_has_changes(the_repository,
> +						   get_commit_tree(old_branch_info->commit),
> +						   &sb))
> +				warning(_("staged changes in the following files may be lost: %s"),
> +					sb.buf);
> +			strbuf_release(&sb);

Thanks for doing this, I think having some sort of warning is a good 
idea, I wonder if this could be quite noisy though. I guess it depends 
on how many staged changes people have that don't match the new index. 
If we diff against the new tree and only print names that are in both 
lists does that give a definitive list of what will be lost? If it does 
then if there are a lot of files affected then it will still be noisy 
(using columns may help) but at least it will not contain false 
positives. It is more work though, maybe we should just say "staged 
changes may be lost" and leave it at that.

Best Wishes

Phillip

> +
>   			/* Do more real merge */
>   
>   			/*
> 
