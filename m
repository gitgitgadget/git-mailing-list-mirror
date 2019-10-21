Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 10EE01F4C0
	for <e@80x24.org>; Mon, 21 Oct 2019 03:04:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726847AbfJUDEX (ORCPT <rfc822;e@80x24.org>);
        Sun, 20 Oct 2019 23:04:23 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:53785 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726768AbfJUDEW (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 20 Oct 2019 23:04:22 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id C270E9A5AA;
        Sun, 20 Oct 2019 23:04:20 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Sa95ijIwfuBMiWWoqK7aDpreQGc=; b=vA8wYk
        ZaraGKn9RmeP3auRdcocyg3zEIbnEB8p7b4/5SCoOmbqrugql2vGsZsg/BT5zEj0
        UwDe5e2NJ9EecKLedcOeymkwLbFATSYQ/h5/rR5ApQK2vRQecgNpGYikxUd1Dj5+
        hXPoHaU6R+rMwc6oSs5TeCXLiGiIxz0+zu32g=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=YnL3A8Bbvb5vqrVPkDtbarPHZUlGKw4X
        q5//Ga3uUon9hKOnsX7D5n2f3dzhnZX5FDMXvON5yugvFb5zEElBXape0XvLCHE2
        sJktuJ+8yKzDQMEcAMrAxx59e97Np6hEKPR9OIc6F/CNihlU2MHKZ80GrWEiSvYV
        cVz2Q1UM4nY=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id BC45C9A5A9;
        Sun, 20 Oct 2019 23:04:20 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 98CE39A5A7;
        Sun, 20 Oct 2019 23:04:16 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Denton Liu <liu.denton@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] rebase: hide --preserve-merges option
References: <47bc4470e22c349082ae45b1e4b5c2547d30d4d2.1571442786.git.liu.denton@gmail.com>
Date:   Mon, 21 Oct 2019 12:04:14 +0900
In-Reply-To: <47bc4470e22c349082ae45b1e4b5c2547d30d4d2.1571442786.git.liu.denton@gmail.com>
        (Denton Liu's message of "Fri, 18 Oct 2019 16:55:56 -0700")
Message-ID: <xmqq36fmn6j5.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 77CF6074-F3AF-11E9-861B-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Denton Liu <liu.denton@gmail.com> writes:

> Since --preserve-merges has been deprecated in favour of
> --rebase-merges, mark this option as hidden so it no longer shows up in
> the usage and completions.
>
> Signed-off-by: Denton Liu <liu.denton@gmail.com>
> ---
> This patch continues the deprecation effort and can be based on top of
> `js/rebase-deprecate-preserve-merges`.

Sounds good.  Let's keep it and have it part of the first batch
after the release.

>
>  builtin/rebase.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
>
> diff --git a/builtin/rebase.c b/builtin/rebase.c
> index 21ac10f739..0d63651d95 100644
> --- a/builtin/rebase.c
> +++ b/builtin/rebase.c
> @@ -1099,9 +1099,10 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
>  			N_("let the user edit the list of commits to rebase"),
>  			PARSE_OPT_NOARG | PARSE_OPT_NONEG,
>  			parse_opt_interactive },
> -		OPT_SET_INT('p', "preserve-merges", &options.type,
> -			    N_("(DEPRECATED) try to recreate merges instead of "
> -			       "ignoring them"), REBASE_PRESERVE_MERGES),
> +		OPT_SET_INT_F('p', "preserve-merges", &options.type,
> +			      N_("(DEPRECATED) try to recreate merges instead of "
> +				 "ignoring them"),
> +			      REBASE_PRESERVE_MERGES, PARSE_OPT_HIDDEN),
>  		OPT_BOOL(0, "rerere-autoupdate",
>  			 &options.allow_rerere_autoupdate,
>  			 N_("allow rerere to update index with resolved "
