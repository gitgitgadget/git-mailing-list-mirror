Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AEFCC4338F
	for <git@archiver.kernel.org>; Wed,  4 Aug 2021 00:19:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EDD6961037
	for <git@archiver.kernel.org>; Wed,  4 Aug 2021 00:19:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234554AbhHDAT5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 3 Aug 2021 20:19:57 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:60253 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233759AbhHDAT5 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Aug 2021 20:19:57 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 6CC10148D29;
        Tue,  3 Aug 2021 20:19:45 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=eiUR4flsrsgWqV4JGxaIStrPzIjRDGxC2BrBob
        rkZ3M=; b=CpByEao6myTadl5SRTi7eosdlDVF9qOsrGsUp3JhXKrR5lB20II7t1
        oM9nmofJT8bh3ADvLjktMu7UM/r3JTzfMrfsT7bXPz3B/QBQ2dWjVbB2lG1wWvGT
        ZYP4O6dQ8XN+tlT1eQQQQhBOO+V6Ge+FqwXkfJkgxPCHux5XveRLc=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 651DF148D28;
        Tue,  3 Aug 2021 20:19:45 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.71.182])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id ABFFC148D27;
        Tue,  3 Aug 2021 20:19:42 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH 04/10] merge-strategies.txt: update wording for the
 resolve strategy
References: <pull.1059.git.git.1628004920.gitgitgadget@gmail.com>
        <3989f194ba91e64852285064b652979861445c03.1628004920.git.gitgitgadget@gmail.com>
Date:   Tue, 03 Aug 2021 17:19:41 -0700
In-Reply-To: <3989f194ba91e64852285064b652979861445c03.1628004920.git.gitgitgadget@gmail.com>
        (Elijah Newren via GitGitGadget's message of "Tue, 03 Aug 2021
        15:35:14 +0000")
Message-ID: <xmqqmtpyrrhe.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: AA3CECA4-F4B9-11EB-B791-FA9E2DDBB1FC-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Elijah Newren <newren@gmail.com>
>
> The resolve merge strategy was given prominent positioning in this
> document, being listed first since it was the default at the time the
> document was written.  It hasn't been the default since before Git v1.0
> was released, though.  Move it later in the document, near `octopus` and
> `ours`.

I think it was listed first because it was written first.

> Further, the wording for "resolve" claimed that it was "considered
> generally safe and fast", which implies that the other strategies are
> not.

I do not think it never implied any such thing; it is good to remove
it, or add the same to all strategies, though.

> diff --git a/Documentation/merge-strategies.txt b/Documentation/merge-strategies.txt
> index 5d707e952aa..6b6017e1cc8 100644
> --- a/Documentation/merge-strategies.txt
> +++ b/Documentation/merge-strategies.txt
> @@ -6,13 +6,6 @@ backend 'merge strategies' to be chosen with `-s` option.  Some strategies
>  can also take their own options, which can be passed by giving `-X<option>`
>  arguments to `git merge` and/or `git pull`.
>  
> -resolve::
> -	This can only resolve two heads (i.e. the current branch
> -	and another branch you pulled from) using a 3-way merge
> -	algorithm.  It tries to carefully detect criss-cross
> -	merge ambiguities and is considered generally safe and
> -	fast.
> -
>  recursive::
>  	This can only resolve two heads using a 3-way merge
>  	algorithm.  When there is more than one common
> @@ -106,6 +99,13 @@ subtree[=<path>];;
>  	is prefixed (or stripped from the beginning) to make the shape of
>  	two trees to match.
>  
> +resolve::
> +	This can only resolve two heads (i.e. the current branch
> +	and another branch you pulled from) using a 3-way merge
> +	algorithm.  It tries to carefully detect criss-cross
> +	merge ambiguities.  It cannot handle renames.  This was
> +	the default merge algorithm prior to November 2005.

"It does not handle renames"; it wasn't like we wanted to do so and
cannot---we didn't want to, didn't think it was worth doing, it was
not part of the design objective to do renames, period.

I do not think it is even worth mentioning that it was the default
in the past.  And I do not think it is worth saying what timeframe
the recursive was the default, either.

>  octopus::
>  	This resolves cases with more than two heads, but refuses to do
>  	a complex merge that needs manual resolution.  It is
