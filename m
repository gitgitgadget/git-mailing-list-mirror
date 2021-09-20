Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B598DC433EF
	for <git@archiver.kernel.org>; Mon, 20 Sep 2021 16:07:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 98BA961177
	for <git@archiver.kernel.org>; Mon, 20 Sep 2021 16:07:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238429AbhITQIu (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 20 Sep 2021 12:08:50 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:61513 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238707AbhITQIu (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Sep 2021 12:08:50 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 3A0E5146F1F;
        Mon, 20 Sep 2021 12:07:23 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=plfbVVqX3XkP4S0miuYdp09Eb7Ogeup3VePJst
        ta9sM=; b=HmvVNOXofamiHuXZ4Qs4lYpW3KbiFWI2jD5cTr6xqnky7Cyia1rTjO
        NJ6fHEjRcH95zDFfnjtIINoLskkVkerab8vzws2rLmAWBTuoMHXmDY7JF74CRbE2
        X5uGepExtI7S7L9X09zZJ1LiO7lLhsMyAOfoJ6aq0MMIS3yssLgcc=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 320AB146F1E;
        Mon, 20 Sep 2021 12:07:23 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 7AC5A146F1D;
        Mon, 20 Sep 2021 12:07:20 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     wesley@schwengle.net
Cc:     git@vger.kernel.org, me@ttaylorr.com
Subject: Re: [PATCH] Document `rebase.forkpoint` in rebase man page
References: <xmqqtuikrzca.fsf@gitster.g>
        <20210916224603.2912887-1-wesley@schwengle.net>
        <20210916224603.2912887-2-wesley@schwengle.net>
Date:   Mon, 20 Sep 2021 09:07:18 -0700
In-Reply-To: <20210916224603.2912887-2-wesley@schwengle.net>
        (wesley@schwengle.net's message of "Thu, 16 Sep 2021 18:46:03 -0400")
Message-ID: <xmqqv92vcjt5.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: D58B2CDE-1A2C-11EC-B506-F327CE9DA9D6-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

wesley@schwengle.net writes:

> From: Wesley Schwengle <wesley@opperschaap.net>
>
> The configuration option `rebase.forkpoint' is only mentioned in the man
> page of git-config(1). Since it is a configuration for rebase, mention
> it in the documentation of rebase at the --fork-point/--no-fork-point
> section. This will help users set a preferred default for their
> workflow.
>
> Signed-off-by: Wesley Schwengle <wesley@opperschaap.net>
> ---
>  Documentation/git-rebase.txt | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.txt
> index 506345cb0e..c116dbf4bb 100644
> --- a/Documentation/git-rebase.txt
> +++ b/Documentation/git-rebase.txt
> @@ -446,7 +446,8 @@ When --fork-point is active, 'fork_point' will be used instead of
>  ends up being empty, the <upstream> will be used as a fallback.
>  +
>  If <upstream> is given on the command line, then the default is
> -`--no-fork-point`, otherwise the default is `--fork-point`.
> +`--no-fork-point`, otherwise the default is `--fork-point`. See also
> +`rebase.forkpoint` in linkgit:git-config[1].
>  +
>  If your branch was based on <upstream> but <upstream> was rewound and
>  your branch contains commits which were dropped, this option can be used

I still think "the variable gives the default, otherwise the
presence of <upstream> on the command line affects which one is used
as the default" presentation order is better, but the above is a
strict improvement over the current message, so let's take it.

Thanks.
