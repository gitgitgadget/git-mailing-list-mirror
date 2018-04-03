Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F1A4C1F404
	for <e@80x24.org>; Tue,  3 Apr 2018 00:41:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754662AbeDCAlW (ORCPT <rfc822;e@80x24.org>);
        Mon, 2 Apr 2018 20:41:22 -0400
Received: from mail-pl0-f48.google.com ([209.85.160.48]:40594 "EHLO
        mail-pl0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754550AbeDCAlV (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Apr 2018 20:41:21 -0400
Received: by mail-pl0-f48.google.com with SMTP id x4-v6so6461207pln.7
        for <git@vger.kernel.org>; Mon, 02 Apr 2018 17:41:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gliO/MlQ7elqVxJ2RyTzNl31BjVHAowUR1N5FHDu7pg=;
        b=f2d2tOc9F1afmZleltGOT821eWlQUY8+3/rY2kGr2X06Z3BFyCpv7Ot14FjaH82kVp
         f9I9J4FoCgm6P60EGvaldsd185NeK00qyuc5i8F6zfjSkwnOdAO29HzrATtQgEFVkf1h
         KP3fWYi89k97jPpfNmtggtmw1sEPUdJjY4rW+XE8+yTUTfwDTnVZD5ufiC8Qqcr2LoCR
         /KkaSOiZLsM7QcA8/0FFWRFVg/S+ROL8mr2t76VOl8CHnCfGbDLmrK2iu5z6ElGbHKw1
         eUIMwYdOAoWK+T/yBkKZwAs5EgRZoLx7nzyvMca5+3v4t2Yv0nsYBYa513+0EXIpH2iB
         57UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gliO/MlQ7elqVxJ2RyTzNl31BjVHAowUR1N5FHDu7pg=;
        b=RrCWPjJHFc5qkWfl1Sc5Q7GEbxzMyC9r1ky1s5XCBfx+aMAGhcawBPw6ohseC+jwDJ
         1Z+nTG8tWRW+J8ECAsQCuXulfc04CYYrvXtDLvrIvH8i4C8xOcyKiuzrpATuAlxoGuzg
         lNn+I6SXgzU+t/xum2SjFBazq7epiX9nZOVU4YYp3tFpGc0Hl64Nt3ImWgMwwUScybz6
         5LVcIp4QQs+iKZ4pWnIS+wBdXXLl+vuZ6mp3qF3JnVKRWPMkivrlQxMY0AmT5RAWAXvQ
         qoCyZp56PHS3gIvKOxsH9Glw0ARUmRDrDpAyduebGOjv1AAkctcqaI/ZZGpcvMqPlA4e
         mY6g==
X-Gm-Message-State: AElRT7ELNahBGklLdrgIQPO8b+1nlzCUnOwZ8BHrIDqT5rGcxxAyCCVn
        7adA9cAwIa8OoxR6duI1XLfaDA==
X-Google-Smtp-Source: AIpwx48LlWtcGCrEvUtEMA7GJ6jDZdSBP6ipG+s66PoQ39lLGr6LrTntFHcUkydugbt7onsNi7WEig==
X-Received: by 10.99.112.70 with SMTP id a6mr7624664pgn.5.1522716081119;
        Mon, 02 Apr 2018 17:41:21 -0700 (PDT)
Received: from twelve3.svl.corp.google.com ([2620:0:100e:422:ffac:c1d4:4bf7:bb93])
        by smtp.gmail.com with ESMTPSA id v12sm2032894pgs.21.2018.04.02.17.41.18
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 02 Apr 2018 17:41:19 -0700 (PDT)
Date:   Mon, 2 Apr 2018 17:41:18 -0700
From:   Jonathan Tan <jonathantanmy@google.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     jacob.keller@gmail.com, simon@ruderich.org, git@vger.kernel.org
Subject: Re: [PATCH 7/7] diff.c: add --color-moved-ignore-space-delta option
Message-Id: <20180402174118.d204ec0d4b9d2fa7ebd77739@google.com>
In-Reply-To: <20180402224854.86922-8-sbeller@google.com>
References: <20180402224854.86922-1-sbeller@google.com>
        <20180402224854.86922-8-sbeller@google.com>
X-Mailer: Sylpheed 3.6.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon,  2 Apr 2018 15:48:54 -0700
Stefan Beller <sbeller@google.com> wrote:

> +struct ws_delta {
> +	int deltachars;
> +	char firstchar;
> +};

I'll just make some overall design comments.

Shouldn't this be a string of characters (or a char* and len) and
whether it was added or removed? If you're only checking the first
character, this would not work if the other characters were different.

> @@ -717,10 +752,20 @@ static int moved_entry_cmp(const void *hashmap_cmp_fn_data,
>  	const struct diff_options *diffopt = hashmap_cmp_fn_data;
>  	const struct moved_entry *a = entry;
>  	const struct moved_entry *b = entry_or_key;
> +	unsigned flags = diffopt->color_moved & XDF_WHITESPACE_FLAGS;
> +
> +	if (diffopt->color_moved & COLOR_MOVED_DELTA_WHITESPACES)
> +		/*
> +		 * As there is not specific white space config given,
> +		 * we'd need to check for a new block, so ignore all
> +		 * white space. The setup of the white space
> +		 * configuration for the next block is done else where
> +		 */
> +		flags |= XDF_IGNORE_WHITESPACE;
>  
>  	return !xdiff_compare_lines(a->es->line, a->es->len,
>  				    b->es->line, b->es->len,
> -				    diffopt->color_moved & XDF_WHITESPACE_FLAGS);
> +				    flags);
>  }

I think we should just prohibit combining this with any of the
whitespace ignoring flags except for the space-at-eol one. They seem to
contradict anyway.

> +test_expect_success 'compare whitespace delta across moved blocks' '
> +
> +	git reset --hard &&
> +	q_to_tab <<-\EOF >text.txt &&
> +	QIndented
> +	QText
> +	Qacross
> +	Qfive
> +	Qlines
> +	QBut!
> +	Qthis
> +	QQone
> +	Qline
> +	QQdid
> +	Qnot
> +	QQadjust
> +	EOF

Do we need 5 lines? I thought 2 would suffice. (It's the ALNUM_COUNT
that matters, as far as I know.) This makes it hard to see that the
"But!" line is the one that counts.

> +test_expect_success 'compare whitespace delta across moved blocks with multiple indentation levels' '
> +	# alternative: "python programmers would love the move detection, too"
> +
> +	git reset --hard &&
> +	q_to_tab <<-\EOF >test.py &&
> +	class test:
> +	Qdef f(x):
> +	QQ"""
> +	QQA simple python function
> +	QQthat returns the square of a number
> +	QQAlthough it may not be pythonic
> +	QQ"""
> +	QQdef g(x):
> +	QQQ"""
> +	QQQNested function that returns the same number
> +	QQQWe just multiply by 1.0
> +	QQQso we can write a comment about it
> +	QQQas we need longer blocks
> +	QQQ"""
> +	QQQreturn 1.0 * x
> +	QQ# Another comment for f(x)
> +	QQ# also spanning multiple lines
> +	QQ# to make a block
> +	QQreturn g(x) * g(x)
> +	Qdef h(x):
> +	QQ# Another function unrelated to the previous
> +	QQ# but building a block,
> +	QQ# long enough to call it a block
> +	QQreturn x * 1.0
> +	EOF

If the objective it just to show that the functions f and g are treated
as one unit despite their lines being of multiple indentation levels,
the test file could be much shorter.
