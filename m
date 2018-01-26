Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DDA511F404
	for <e@80x24.org>; Fri, 26 Jan 2018 18:16:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751917AbeAZSQF (ORCPT <rfc822;e@80x24.org>);
        Fri, 26 Jan 2018 13:16:05 -0500
Received: from mail-pf0-f195.google.com ([209.85.192.195]:39070 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751434AbeAZSQE (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 Jan 2018 13:16:04 -0500
Received: by mail-pf0-f195.google.com with SMTP id e11so773675pff.6
        for <git@vger.kernel.org>; Fri, 26 Jan 2018 10:16:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=TAf1cUwZnUzJwyUVstnkdn0zpgWMXpZ/eqPe0zwTvus=;
        b=dX68eOBERB4bLhuJAxAaFb7yDDpX4s7o13pqDHEQcnM7MWQrQ4sEiZDpSR4TZXLqCS
         tOETfjsuZonkM+P9PIh/CvUz17nrChhDOFebz1xgahhplGd2/626+GlceQhwmsD+ZULX
         ThHMr0RafXeKbXtrrNX+X9YS7ZBkz4BjdndoQ7Oa06uEzFFhO0phBLlMP0FVX+0tgWBs
         ClYwKYM8ccBwGd26HqTl0Illd1evNhOcqKIukmE7Z1Osx6CZh7TGAKqQzAB9qKHND3UT
         IxlPvFwt/kpipgT0JJNX0x6I/ZsTRLeVWFqDRsfZ6GBkFPgvwSj4cmKqlumeealWu9Ze
         hm1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=TAf1cUwZnUzJwyUVstnkdn0zpgWMXpZ/eqPe0zwTvus=;
        b=gXZpn1/9HLahGoRw0FvSYQsfNb5tHhD3sjykECZqM7y9iDobNrRe0enYjQEeODOfHg
         Q8PHY9JFj32uo35yhjfKs/pj9XXEYJdV42vtbk06rgox/KyOQte/7116bsZgQO+BuXyM
         ipw3SmMeUnlNmeR3Ipb+JzpdtbJBWKi7A5yV7TNvvK35YRbfHK3bmcyTU5bn2/JdCSrM
         3yXg+k6FjSxxsiRh6Y8gruqYV6ecsmX/BviiT+55wIcWnuk+b8MYIzB9O+VPZG+GfNlz
         XdnrkiiqJaq3tnJ9RP0NEsxj0+rpr4HCIKh3of1qzHh1cBFNQ/hCD1BwqzC/REr2Yy1Z
         epog==
X-Gm-Message-State: AKwxytfyECUIG0qK9qUohTXG4zTFdr2lYsstEIEwgn4qR4UAx1JvPuOi
        P5U+h44N5h8BUd2mVbPJ7s8s1tCp
X-Google-Smtp-Source: AH8x2273jIzdhaciRWNnz7d+nhntPoRs0i1TJ9HbZpqXZZ8WvK2FnbsvLjU7fAuoD7Iz3W9oduaCYQ==
X-Received: by 2002:a17:902:3281:: with SMTP id z1-v6mr15027129plb.431.1516990563910;
        Fri, 26 Jan 2018 10:16:03 -0800 (PST)
Received: from localhost ([2620:0:1000:8622:3d49:4bb2:1738:a537])
        by smtp.gmail.com with ESMTPSA id b8sm18399428pff.31.2018.01.26.10.16.02
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 26 Jan 2018 10:16:03 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>
Subject: Re: [PATCH 05/10] t5510: consolidate 'grep' and 'test_i18ngrep' patterns
References: <20180126123708.21722-1-szeder.dev@gmail.com>
        <20180126123708.21722-6-szeder.dev@gmail.com>
Date:   Fri, 26 Jan 2018 10:16:01 -0800
In-Reply-To: <20180126123708.21722-6-szeder.dev@gmail.com> ("SZEDER
 =?utf-8?Q?G=C3=A1bor=22's?=
        message of "Fri, 26 Jan 2018 13:37:03 +0100")
Message-ID: <xmqqa7x08p0e.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

SZEDER Gábor <szeder.dev@gmail.com> writes:

> One of the tests in 't5510-fetch.sh' checks the output of 'git fetch'
> using 'test_i18ngrep', and while doing so it prefilters the output
> with 'grep' before piping the result into 'test_i18ngrep'.
>
> This prefiltering is unnecessary, with the appropriate pattern
> 'test_i18ngrep' can do it all by itself.  Furthermore, piping data
> into 'test_i18ngrep' will interfere with the linting that will be
> added in a later patch.

It is very likely that the prefiltering "grep" will not even see
what it is looking for under GETTEXT_POISON build in the first
place, so this conversion is the right thing to do from that point
of view as well.



>
> Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
> ---
>  t/t5510-fetch.sh | 9 +++------
>  1 file changed, 3 insertions(+), 6 deletions(-)
>
> diff --git a/t/t5510-fetch.sh b/t/t5510-fetch.sh
> index 668c54be4..3debc87d4 100755
> --- a/t/t5510-fetch.sh
> +++ b/t/t5510-fetch.sh
> @@ -222,12 +222,9 @@ test_expect_success 'fetch uses remote ref names to describe new refs' '
>  	(
>  		cd descriptive &&
>  		git fetch o 2>actual &&
> -		grep " -> refs/crazyheads/descriptive-branch$" actual |
> -		test_i18ngrep "new branch" &&
> -		grep " -> descriptive-tag$" actual |
> -		test_i18ngrep "new tag" &&
> -		grep " -> crazy$" actual |
> -		test_i18ngrep "new ref"
> +		test_i18ngrep "new branch.* -> refs/crazyheads/descriptive-branch$" actual &&
> +		test_i18ngrep "new tag.* -> descriptive-tag$" actual &&
> +		test_i18ngrep "new ref.* -> crazy$" actual
>  	) &&
>  	git checkout master
>  '
