Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9E1601F406
	for <e@80x24.org>; Wed,  3 Jan 2018 21:49:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751196AbeACVt4 (ORCPT <rfc822;e@80x24.org>);
        Wed, 3 Jan 2018 16:49:56 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:50323 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750945AbeACVt4 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 Jan 2018 16:49:56 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 54E3BCCEEA;
        Wed,  3 Jan 2018 16:49:55 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=6PfLXXpKtO3YWAa699aejC1J9JY=; b=YXtgIc
        E3da1kNm+VMCfc/k0ToD/nauv8JPPWfjXm94duczSO2fbMTRhjyFWJIhyp7pY6Lg
        4nWIcr5Ro+rUfgoGrSXIi0JYMmh9hVkxeHvlitWGkJIwW0N1o9PlPr245sVpnNiz
        sCvvGGBbRkwSOAiyeqCcSnvvn+nhX5r37W5mU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=lfZmuIIWrfZRud8b2UDQXtuSoCpW/u0K
        MrFGWNVc8qvSqypZdY5vA4rJIkXv3iwgQgQb7SukXSekrkctwQJmWE3Fv4six5UP
        aEGCNUxxKzsb8JUZ4fhYpFG/NtGCbN0Q93dXQzfH2MionP4LiF9y+CirEOfrXLAF
        9QtMO4QLtzc=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 4C036CCEE9;
        Wed,  3 Jan 2018 16:49:55 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id C7A9ECCEDF;
        Wed,  3 Jan 2018 16:49:54 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 1/5] diff.h: Make pickaxe_opts an unsigned bit field
References: <20180103004624.222528-1-sbeller@google.com>
        <20180103004624.222528-2-sbeller@google.com>
Date:   Wed, 03 Jan 2018 13:49:53 -0800
In-Reply-To: <20180103004624.222528-2-sbeller@google.com> (Stefan Beller's
        message of "Tue, 2 Jan 2018 16:46:20 -0800")
Message-ID: <xmqqfu7mhata.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 08B9B86C-F0D0-11E7-A899-575F0C78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

> This variable is used as a bit field[1], and as we are about to add more
> fields, indicate its usage as a bit field by making it unsigned.
>
> [1] containing the bits
>
>     #define DIFF_PICKAXE_ALL	1
>     #define DIFF_PICKAXE_REGEX	2
>     #define DIFF_PICKAXE_KIND_S	4
>     #define DIFF_PICKAXE_KIND_G	8
>
> Signed-off-by: Stefan Beller <sbeller@google.com>
> ---
>  diff.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Makes perfect sense.

>
> diff --git a/diff.h b/diff.h
> index 0fb18dd735..ea310f76fd 100644
> --- a/diff.h
> +++ b/diff.h
> @@ -146,7 +146,7 @@ struct diff_options {
>  	int skip_stat_unmatch;
>  	int line_termination;
>  	int output_format;
> -	int pickaxe_opts;
> +	unsigned pickaxe_opts;
>  	int rename_score;
>  	int rename_limit;
>  	int needed_rename_limit;
