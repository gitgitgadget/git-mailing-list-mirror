Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2092420467
	for <e@80x24.org>; Thu, 12 Oct 2017 16:51:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753075AbdJLQvE (ORCPT <rfc822;e@80x24.org>);
        Thu, 12 Oct 2017 12:51:04 -0400
Received: from bsmtp8.bon.at ([213.33.87.20]:37629 "EHLO bsmtp8.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752044AbdJLQvE (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Oct 2017 12:51:04 -0400
Received: from dx.site (unknown [93.83.142.38])
        by bsmtp8.bon.at (Postfix) with ESMTPSA id 3yCcKY2kwjz5tlL;
        Thu, 12 Oct 2017 18:50:25 +0200 (CEST)
Received: from [IPv6:::1] (localhost [IPv6:::1])
        by dx.site (Postfix) with ESMTP id 926AD274;
        Thu, 12 Oct 2017 18:50:24 +0200 (CEST)
Subject: Re: [PATCH v1 1/1] completion: add remaining flags to checkout
To:     Thomas Braun <thomas.braun@virtuell-zuhause.de>
Cc:     git@vger.kernel.org, gitster@pobox.com
References: <20171012122059.17242-1-thomas.braun@virtuell-zuhause.de>
From:   Johannes Sixt <j6t@kdbg.org>
Message-ID: <5bc82075-0fb2-0929-2da7-d9069222a3fe@kdbg.org>
Date:   Thu, 12 Oct 2017 18:50:24 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <20171012122059.17242-1-thomas.braun@virtuell-zuhause.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 12.10.2017 um 14:20 schrieb Thomas Braun:
> In the commits 1d0fa898 (checkout: add --ignore-other-wortrees,
> 2015-01-03), 1fc458d9 (builtin/checkout: add --recurse-submodules switch,
> 2017-03-14), 870ebdb9 (checkout: add --progress option, 2015-11-01),
> 08d595dc (checkout: add --ignore-skip-worktree-bits in sparse checkout
> mode, 2013-04-13), 1d0fa898 (checkout: add --ignore-other-wortrees,
> 2015-01-03), 32669671 (checkout: introduce --detach synonym for "git
> checkout foo^{commit}", 2011-02-08) and db941099 (checkout -f: allow
> ignoring unmerged paths when checking out of the index, 2008-08-30)
> checkout gained new flags but the completion was not updated, although
> these flags are useful completions. Add them.
> 
> Signed-off-by: Thomas Braun <thomas.braun@virtuell-zuhause.de>
> ---
>   contrib/completion/git-completion.bash | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
> index d934417475..393d4ae230 100644
> --- a/contrib/completion/git-completion.bash
> +++ b/contrib/completion/git-completion.bash
> @@ -1250,7 +1250,9 @@ _git_checkout ()
>   	--*)
>   		__gitcomp "
>   			--quiet --ours --theirs --track --no-track --merge
> -			--conflict= --orphan --patch
> +			--conflict= --orphan --patch --detach --progress --no-progress
> +			--force --ignore-skip-worktree-bits --ignore-other-worktrees

Destructive and dangerous options are typically not offered by command 
completion. You should omit all three in the line above, IMO.

Furthermore, --progress and --no-progress are not useful in daily work 
on the command line, I think. By offering them, --p<TAB> would not 
complete to --patch anymore, you would need --pa<TAB>. You should omit 
them, too.

> +			--recurse-submodules --no-recurse-submodules
>   			"
>   		;;
>   	*)
> 

-- Hannes
