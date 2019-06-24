Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4EC3A1F461
	for <e@80x24.org>; Mon, 24 Jun 2019 17:24:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731556AbfFXRYI (ORCPT <rfc822;e@80x24.org>);
        Mon, 24 Jun 2019 13:24:08 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:60077 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726941AbfFXRYI (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Jun 2019 13:24:08 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 4C80D7BE56;
        Mon, 24 Jun 2019 13:24:03 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=R7JUjijtNYlQjURCoczIjX1f4gc=; b=SuOewA
        mXkbd5SLtY9CDMGRgbMoBaAdxP/yGJuNiAans/t7pxD5woX/bkhdHQMyJLGaN5tf
        x2pUYNlURS5pL7ISURpGj2sXLM0mp1dLqi0UvDNsWW+g4eduAp/oZ8tUej9s7UkE
        HTw1hoASdKDpZSFibm6kiUjyMxBFamXSGPZSM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=K1BlD4oe2766ZRbuncoPjWdFkee27jvx
        5VbwTwqhJWynHOne3ak8fgTi18Ixg40B1H3BrqibrCLPkumRk0wk8qNTRdRFriPo
        qUwmPKhPbOU0+a54Qurftw99E6FiINSvbwLlvK9qbLf3eBO1SWwnGQhkMohVkrAw
        4pm31sZurbg=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 4521D7BE55;
        Mon, 24 Jun 2019 13:24:03 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 702787BE50;
        Mon, 24 Jun 2019 13:24:00 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Felipe Contreras <felipe.contreras@gmail.com>
Cc:     git@vger.kernel.org,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Subject: Re: [PATCH 14/14] completion: add default merge strategies
References: <20190621223107.8022-1-felipe.contreras@gmail.com>
        <20190621223107.8022-15-felipe.contreras@gmail.com>
Date:   Mon, 24 Jun 2019 10:23:58 -0700
In-Reply-To: <20190621223107.8022-15-felipe.contreras@gmail.com> (Felipe
        Contreras's message of "Fri, 21 Jun 2019 17:31:07 -0500")
Message-ID: <xmqq5zouj3rl.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: DB032F44-96A4-11E9-89C2-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Felipe Contreras <felipe.contreras@gmail.com> writes:

> In case the command fails.

It is unclear what you wanted to say with this.  What command?
After "git merge" fails?

>
> Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
> ---
>  contrib/completion/git-completion.bash | 4 +++-
>  t/t9902-completion.sh                  | 2 +-
>  2 files changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
> index 922ba5f925..91b87eb558 100644
> --- a/contrib/completion/git-completion.bash
> +++ b/contrib/completion/git-completion.bash
> @@ -936,6 +936,7 @@ __git_list_merge_strategies ()
>  	}'
>  }
>  
> +__git_merge_strategies_default='octopus ours recursive resolve subtree'
>  __git_merge_strategies=
>  # 'git merge -s help' (and thus detection of the merge strategy
>  # list) fails, unfortunately, if run outside of any git working
> @@ -945,7 +946,8 @@ __git_merge_strategies=
>  __git_compute_merge_strategies ()
>  {
>  	test -n "$__git_merge_strategies" ||
> -	__git_merge_strategies=$(__git_list_merge_strategies)
> +	{ __git_merge_strategies=$(__git_list_merge_strategies);
> +		__git_merge_strategies="${__git_merge_strategies:-__git_merge_strategies_default}"; }
>  }
>  
>  __git_merge_strategy_options="ours theirs subtree subtree= patience
> diff --git a/t/t9902-completion.sh b/t/t9902-completion.sh
> index 14598bfbec..f4453ce70d 100755
> --- a/t/t9902-completion.sh
> +++ b/t/t9902-completion.sh
> @@ -1722,7 +1722,7 @@ test_expect_success 'sourcing the completion script clears cached commands' '
>  	verbose test -z "$__git_all_commands"
>  '
>  
> -test_expect_failure 'sourcing the completion script clears cached merge strategies' '
> +test_expect_success 'sourcing the completion script clears cached merge strategies' '
>  	offgit &&
>  	GIT_TEST_GETTEXT_POISON= &&
>  	__git_compute_merge_strategies &&
