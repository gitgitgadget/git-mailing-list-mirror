Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C9208211B3
	for <e@80x24.org>; Mon,  3 Dec 2018 23:23:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725962AbeLCXX5 (ORCPT <rfc822;e@80x24.org>);
        Mon, 3 Dec 2018 18:23:57 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:41612 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725858AbeLCXX5 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Dec 2018 18:23:57 -0500
Received: by mail-pl1-f193.google.com with SMTP id u6so7243531plm.8
        for <git@vger.kernel.org>; Mon, 03 Dec 2018 15:23:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=vhhnfVRxMKFI4eKxvPtYEj5oKFfsgBDRSFJCFXLYO4M=;
        b=rYG8dZ7XMRBu4bJGFKkQ/bmpbmLRv4ZOSBVtQ5/yM5a75wsJq9+be6ehk/iL3zayO2
         42NJmhRvH21RkozonjDgykwQUUmNROsK01n3ZDps+xqmnPeaWaXoge3Qr062JKqMVxgY
         aEWjsUnSenHKso8l1wG54at9QzvQRIZ0+2MnwUcpyO2RtxtoPhmyo5nuNrtMHWWGvyfY
         2AVoisPsczGt+hXCmK9j5dCGbYbbpY99pkn+63pZjDeeA5T7mufFCKRZLzMTJDIk7y6i
         Gs+tekKnWjc9ZO6QrhCBSKlLOrmATVuvOpUKt8LkRXxxjPrYxy/8fLmZrMupzSoB3khi
         gj9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=vhhnfVRxMKFI4eKxvPtYEj5oKFfsgBDRSFJCFXLYO4M=;
        b=UBOuXrkifxB7Id3yFg9t3+LUZOHbW1p941sWTzJQG9G7cH7InBKL7/Ve3mNJiRDv/P
         Q4sAzBak9Op3Q0RzJc5XoApMd8XkDHgqpQwEqLoZFpVyqkWOX04bWFRocC2DkwKnnQ0n
         aEVlIZ+Qyf2qb+l70j0vevCFBV5rEAOhF6itce0XAzEFpLa0jJDgl7gAD3VPpCV6ZzqO
         drmL+Bqh51pt3lF6FaXRdR49Rs5dAtrN3uPtodPAMm7O8aidz1VfuyX6puN8QU5Ra0Fq
         Xc8umwi4JoxArIKMwOx3xrGXNZS2JBPF/VSsAV+vMaZyNuiYzlJkHKEAp6e9obRSSwhH
         TdlQ==
X-Gm-Message-State: AA+aEWadvGmdeqQNzl9Eex0BA9t/xoiJkO0fgxFPcsNh8RyG45ghIc6u
        c6lUEXjHJffdFa/Y7C7goNA=
X-Google-Smtp-Source: AFSGD/Ve4BhZ9KRnxiv+y8hJWBhRpchu0eh89gFqppxeDpXyIHqW/Eo4wgaQkwJMEMbNpvMJnnVdow==
X-Received: by 2002:a17:902:8e8a:: with SMTP id bg10mr17942863plb.192.1543879436416;
        Mon, 03 Dec 2018 15:23:56 -0800 (PST)
Received: from google.com ([2620:0:100e:913:3fb0:1473:cdbf:42])
        by smtp.gmail.com with ESMTPSA id n7sm21088641pff.36.2018.12.03.15.23.54
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 03 Dec 2018 15:23:55 -0800 (PST)
Date:   Mon, 3 Dec 2018 15:23:53 -0800
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     gitster@pobox.com, git@vger.kernel.org,
        Han-Wen Nienhuys <hanwen@google.com>
Subject: Re: [PATCH] sideband: color lines with keyword only
Message-ID: <20181203232353.GA157301@google.com>
References: <20181203223713.158394-1-sbeller@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181203223713.158394-1-sbeller@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Stefan Beller wrote:

> When bf1a11f0a1 (sideband: highlight keywords in remote sideband output,
> 2018-08-07) was introduced, it was carefully considered which strings
> would be highlighted. However 59a255aef0 (sideband: do not read beyond
> the end of input, 2018-08-18) brought in a regression that the original
> did not test for. A line containing only the keyword and nothing else
> ("SUCCESS") should still be colored.
>
> Signed-off-by: Stefan Beller <sbeller@google.com>
> ---
>  sideband.c                          | 5 +++--
>  t/t5409-colorize-remote-messages.sh | 2 ++
>  2 files changed, 5 insertions(+), 2 deletions(-)

Thanks for writing this.

I was curious about what versions of Gerrit this is designed to
support (or in other words whether it's a bug fix or a feature).
Looking at examples like [1], it seems that Gerrit historically always
used "ERROR:" so the 59a255aef0 logic would work for it.  More
recently, [2] (ReceiveCommits: add a "SUCCESS" marker for successful
change updates, 2018-08-21) put SUCCESS on a line of its own.  That
puts this squarely in the new-feature category.

"success" on its own line is even less likely to be a false positive
than "success" followed by punctuation (for example a period marking
the end of a sentence).  So I like this change.

[1] https://gerrit-review.googlesource.com/c/gerrit/+/22361
[2] https://gerrit-review.googlesource.com/c/gerrit/+/193570

> diff --git a/sideband.c b/sideband.c
> index 368647acf8..7c3d33d3f8 100644
> --- a/sideband.c
> +++ b/sideband.c
> @@ -87,7 +87,7 @@ static void maybe_colorize_sideband(struct strbuf *dest, const char *src, int n)
>  		struct keyword_entry *p = keywords + i;
>  		int len = strlen(p->keyword);
>  
> -		if (n <= len)
> +		if (n < len)
>  			continue;

In the old code, we would escape early if 'n == len', but we didn't
need to.  If 'n == len', then

	src[len] == '\0'
	src .. &src[len-1] is a valid buffer to read from

so the strncasecmp and strbuf_add operations used in this function are
valid.  Good.

>  		/*
>  		 * Match case insensitively, so we colorize output from existing
> @@ -95,7 +95,8 @@ static void maybe_colorize_sideband(struct strbuf *dest, const char *src, int n)
>  		 * messages. We only highlight the word precisely, so
>  		 * "successful" stays uncolored.
>  		 */
> -		if (!strncasecmp(p->keyword, src, len) && !isalnum(src[len])) {
> +		if (!strncasecmp(p->keyword, src, len) &&
> +		    (len == n || !isalnum(src[len]))) {

Our custom isalnum treats '\0' as not alphanumeric (sane_ctype[0] ==
GIT_CNTRL) so this part of the patch is unnecessary.  That said, it's
good for clarity and defensive programming.

>  			strbuf_addstr(dest, p->color);
>  			strbuf_add(dest, src, len);
>  			strbuf_addstr(dest, GIT_COLOR_RESET);
> diff --git a/t/t5409-colorize-remote-messages.sh b/t/t5409-colorize-remote-messages.sh
> index f81b6813c0..2a8c449661 100755
> --- a/t/t5409-colorize-remote-messages.sh
> +++ b/t/t5409-colorize-remote-messages.sh
> @@ -17,6 +17,7 @@ test_expect_success 'setup' '
>  	echo " " "error: leading space"
>  	echo "    "
>  	echo Err
> +	echo SUCCESS
>  	exit 0
>  	EOF
>  	echo 1 >file &&
> @@ -35,6 +36,7 @@ test_expect_success 'keywords' '
>  	grep "<BOLD;RED>error<RESET>: error" decoded &&
>  	grep "<YELLOW>hint<RESET>:" decoded &&
>  	grep "<BOLD;GREEN>success<RESET>:" decoded &&
> +	grep "<BOLD;GREEN>SUCCESS<RESET>" decoded &&
>  	grep "<BOLD;YELLOW>warning<RESET>:" decoded
>  '

Nice tests.

The "hinting: not highlighted" example shows that we aren't
introducing false positives here, so the coverage seems sufficient.
It might be nice to include a line

	echo ERROR:

as well to match another idiom that Gerrit sometimes uses.

Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>

Thanks again for a pleasant read.
