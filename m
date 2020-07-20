Return-Path: <SRS0=kUNO=A7=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B347C433DF
	for <git@archiver.kernel.org>; Mon, 20 Jul 2020 23:58:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D041122BF3
	for <git@archiver.kernel.org>; Mon, 20 Jul 2020 23:58:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="U6CvuX5U"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726658AbgGTX61 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 20 Jul 2020 19:58:27 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:56405 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726390AbgGTX60 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Jul 2020 19:58:26 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 108FB65EFE;
        Mon, 20 Jul 2020 19:58:23 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=sdjc7diT1LjnAWcW/7qYnHS12QY=; b=U6CvuX
        5UDliG/i7ycM/1eC7vzOGVVQjzGTS8li+nxihs7cgZy4YdCLouWjKwhZV1EbdeGE
        f5TbmzTQO0BZGDkzmLbnEvWx2V9ESsCkyCRSNx9Q5UCM7llFalHpXJWdJ7uMlNuq
        5DZBkauoBt813EBYzQCMYhSDlZNXDl9cVkc3w=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=jgs2koXZM7ulZ1pRHuapCAxyuwkPU3Tc
        qW+7OJzDSrtL9JyMkOL8zyNjGWjSg8AmH7PZUE6EprJNHuX+e19U10dlUB3/xwGm
        7NExSeeDa8IPk3y3xMOyY0QfNNKWGDhyLTTUt1L52Bmw+TdUig+Zcdt8YYLgTrRu
        4DXp3OYrXbI=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 0883465EFC;
        Mon, 20 Jul 2020 19:58:23 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 8D74165EFB;
        Mon, 20 Jul 2020 19:58:22 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "David J. Malan via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Elijah Newren <newren@gmail.com>,
        "David J. Malan" <malan@harvard.edu>
Subject: Re: [PATCH] git-prompt: changes == to = for zsh's sake
References: <pull.679.git.1595287052428.gitgitgadget@gmail.com>
Date:   Mon, 20 Jul 2020 16:58:21 -0700
In-Reply-To: <pull.679.git.1595287052428.gitgitgadget@gmail.com> (David
        J. Malan via GitGitGadget's message of "Mon, 20 Jul 2020 23:17:32
        +0000")
Message-ID: <xmqqpn8p91sy.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: E4AAA2C8-CAE4-11EA-A1EB-2F5D23BA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"David J. Malan via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: "David J. Malan" <malan@harvard.edu>
> Subject: Re: [PATCH] git-prompt: changes == to = for zsh's sake

s/changes/change/

> When using git-prompt.sh with Zsh, __git_ps1 currently errs
> when inside a repo with:
>
> __git_ps1:96: = not found

OK.

> This commit changes `==` to `=` for both Bash and Zsh.

We prefer to see "why" instead of "what", as the latter can easily
be read from the patch text.

    Avoid using non-portable "==" that is only understood by bash
    and not zsh to "="; that way the prompt script becomes usable
    with zsh again.

or something like that.

Elijah, I think this is a minor regression in this cycle, and the
fix is obvious enough that it deserves to be in the upcoming
release.  Agreed?

Thank you, David, for a fix.


> Signed-off-by: David J. Malan <malan@harvard.edu>
> ---
>     Changes == to = for zsh's sake in git-prompt.sh
>     
>     Upon installing git-prompt.sh
>     [https://github.com/gitgitgadget/git/blob/master/contrib/completion/git-prompt.sh] 
>     on macOS Catalina, I noticed that 
>     https://github.com/gitgitgadget/git/commit/afda36dbf3b4f5a489ab44c00d5210c1fa894a40 
>     seems to have introduced an issue for Zsh whereby __git_ps1 errs with
>     
>     __git_ps1:96: = not found
>     
>     when inside a repo. Changing == to = would seem to address for both Bash
>     and Zsh.
>
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-679%2Fdmalan%2Fpatch-1-v1
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-679/dmalan/patch-1-v1
> Pull-Request: https://github.com/gitgitgadget/git/pull/679
>
>  contrib/completion/git-prompt.sh | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/contrib/completion/git-prompt.sh b/contrib/completion/git-prompt.sh
> index e6cd5464e5..16260bab73 100644
> --- a/contrib/completion/git-prompt.sh
> +++ b/contrib/completion/git-prompt.sh
> @@ -433,7 +433,7 @@ __git_ps1 ()
>  	local sparse=""
>  	if [ -z "${GIT_PS1_COMPRESSSPARSESTATE}" ] &&
>  	   [ -z "${GIT_PS1_OMITSPARSESTATE}" ] &&
> -	   [ "$(git config --bool core.sparseCheckout)" == "true" ]; then
> +	   [ "$(git config --bool core.sparseCheckout)" = "true" ]; then
>  		sparse="|SPARSE"
>  	fi
>  
> @@ -542,7 +542,7 @@ __git_ps1 ()
>  		fi
>  
>  		if [ -n "${GIT_PS1_COMPRESSSPARSESTATE}" ] &&
> -		   [ "$(git config --bool core.sparseCheckout)" == "true" ]; then
> +		   [ "$(git config --bool core.sparseCheckout)" = "true" ]; then
>  			h="?"
>  		fi
>  
>
> base-commit: ae46588be0cd730430dded4491246dfb4eac5557
