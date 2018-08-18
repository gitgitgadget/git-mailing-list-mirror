Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0110D1F954
	for <e@80x24.org>; Sat, 18 Aug 2018 06:14:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726071AbeHRJPn (ORCPT <rfc822;e@80x24.org>);
        Sat, 18 Aug 2018 05:15:43 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:39514 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725891AbeHRJPm (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 18 Aug 2018 05:15:42 -0400
Received: by mail-pf1-f194.google.com with SMTP id j8-v6so4387358pff.6
        for <git@vger.kernel.org>; Fri, 17 Aug 2018 23:09:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=C7EiSqsyiOZRGQv7Ix5eEmI0DRPR9210HLBVB5dtgdY=;
        b=b1M0HJpMKTGopgVDVeHpcCVi9vcJRa5/Mape3pKuEfeoyod4xSIZM1dNE14aA7uzT8
         x1yJyj5VN35kqBAF2iB7LWCnOd868i4qE39b1/fTQUG+TiVobq1tBWHUeuhuS+hB+FGw
         BdtHxjmRB+AQtN7OTp5Nrx3aCl1vuPilo4gCqHdewQuxMLI+myN+M2Bfjs6hUzeYXPLi
         nCc6rTibl43ZTMSivTM11r2DjS2rpWx0ibsAS0imClncDIxEWFD7xo7in1DgsqgJghOA
         zixr8eJ+pVa/C4mS7/vTFt9RuTYtwdO5q+vtLmPHn7yXGSlEjtgxLCm0jf9iNCKLzH9c
         0NCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=C7EiSqsyiOZRGQv7Ix5eEmI0DRPR9210HLBVB5dtgdY=;
        b=nfbkculBeZbPRa/ELOBz5ScpDVC77RSGIsYut3gsZAsZlRodKHlb+YMatyXbMy5M9Y
         7VPPwA+OWTYdjG3/yHA0f2a1AR475+7imipt40il1tZIzYSjAxY48RbNE0mXWNnIF/La
         yk4TXf1p53A5t5WHen4rNlX0gdtZeHRkYYEDC6Qgpj3rjb0EOzncnCHv6aeu99qdUXid
         guOUxI6mQoDlWk3hxnYmPfCC3xh4NwHNGsIpzrFxjTy6dfa20PuOwywG+Xm3BfzuHTK1
         IUTRf+1ZtMAbURlZGlUYCiVeUh7Jm2Zou/jJk0LDCMKlyRS2nRm9+tacst3ajU4OBa6t
         mOuw==
X-Gm-Message-State: AOUpUlGlefMX3cbi7P/mdsa5eM1Z7RygjxJhglrpl4veniqVFCwNy/6a
        twjmoTFWrEyw7xGkWs8iDlw=
X-Google-Smtp-Source: AA+uWPySknrMlCeggkOCWoKzDT0W9j1Qns5dtI8d8gXMUY6GfIQ2UarzEkN+4TjDD92tK9Z2n9zdsw==
X-Received: by 2002:a63:2744:: with SMTP id n65-v6mr5842953pgn.29.1534572554004;
        Fri, 17 Aug 2018 23:09:14 -0700 (PDT)
Received: from aiede.svl.corp.google.com ([2620:0:100e:422:4187:1d6c:d3d6:9ce6])
        by smtp.gmail.com with ESMTPSA id e8-v6sm4760162pgi.24.2018.08.17.23.09.13
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 17 Aug 2018 23:09:13 -0700 (PDT)
Date:   Fri, 17 Aug 2018 23:09:11 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Han-Wen Nienhuys <hanwen@google.com>, sunshine@sunshineco.com,
        git@vger.kernel.org
Subject: Re: Re* [PATCH v7 1/1] sideband: highlight keywords in remote
 sideband output
Message-ID: <20180818060911.GC241538@aiede.svl.corp.google.com>
References: <20180807125108.104293-1-hanwen@google.com>
 <20180807125108.104293-2-hanwen@google.com>
 <xmqqd0ugc07x.fsf@gitster-ct.c.googlers.com>
 <xmqq8t54bzo4.fsf_-_@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqq8t54bzo4.fsf_-_@gitster-ct.c.googlers.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

(-cc: my @google.com email)
Hi,

Junio C Hamano wrote:

> Subject: sideband: do not read beyond the end of input
>
> The caller of maybe_colorize_sideband() gives a counted buffer
> <src,n>, but the callee checked *src as if it were a NUL terminated
> buffer.  If src[] had all isspace() bytes in it, we would have made
> n negative, and then (1) called number of strncasecmp() to see if
> the remaining bytes in src[] matched keywords, reading beyond the
> end of the array, and/or (2) called strbuf_add() with negative
> count, most likely triggering the "you want to use way too much
> memory" error due to unsigned integer overflow.
>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
>  sideband.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)

This indeed avoids the "you want to use way too much memory" error
when I apply it.

> --- a/sideband.c
> +++ b/sideband.c
> @@ -75,7 +75,7 @@ static void maybe_colorize_sideband(struct strbuf *dest, const char *src, int n)

Not about this patch: should the 'n' parameter be a size_t instead of
an int?  It doesn't matter in practice (since the caller has an int,
it can never be more than INT_MAX) but it might make the intent
clearer.

Based on inspecting the caller, using an int seems fine.

>  		return;
>  	}
>  
> -	while (isspace(*src)) {
> +	while (0 < n && isspace(*src)) {

Yes, we need to check 'n && isspace(*src)' to avoid overflowing the
buffer if it consists entirely of spaces.

>  		strbuf_addch(dest, *src);
>  		src++;
>  		n--;
> @@ -84,6 +84,9 @@ static void maybe_colorize_sideband(struct strbuf *dest, const char *src, int n)
>  	for (i = 0; i < ARRAY_SIZE(keywords); i++) {
>  		struct keyword_entry *p = keywords + i;
>  		int len = strlen(p->keyword);
> +
> +		if (n <= len)
> +			continue;

Using <= instead of < since we look at the character after the word as
well.  Good.

>  		/*
>  		 * Match case insensitively, so we colorize output from existing
>  		 * servers regardless of the case that they use for their
> 		 * messages. We only highlight the word precisely, so
> 		 * "successful" stays uncolored.
> 		 */
> 		if (!strncasecmp(p->keyword, src, len) && !isalnum(src[len])) {

Not about this patch: should this check "&& src[len] == ':'" instead,
as discussed upthread?

> @@ -100,8 +103,8 @@ static void maybe_colorize_sideband(struct strbuf *dest, const char *src, int n)
>  		}
>  	}
>  
> -	strbuf_add(dest, src, n);
> +	if (0 < n)
> +		strbuf_add(dest, src, n);

This check seems unnecessary.  strbuf_add can cope fine with !n.
Should we put

	assert(n >= 0);

or even

	if (n < 0)
		BUG();

instead, since the earlier part of the fix guarantees that n >= 0?

Thanks for the careful work.  With or without such a change,
Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>

Thanks.
