Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 309941F453
	for <e@80x24.org>; Wed,  7 Nov 2018 00:58:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388411AbeKGKZ6 (ORCPT <rfc822;e@80x24.org>);
        Wed, 7 Nov 2018 05:25:58 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:39953 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388174AbeKGKZ6 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Nov 2018 05:25:58 -0500
Received: by mail-wm1-f68.google.com with SMTP id b203-v6so14179216wme.5
        for <git@vger.kernel.org>; Tue, 06 Nov 2018 16:57:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=E+1fZuQCACuQ+apD87OVT3BJK1v6cMDA5/bmpkXVXfo=;
        b=WEgX+AHS68KzXBGbG0M6IZiyMhQ8zTkIcl1fL8RCiIldG7JW2a5SYsHOg+n3t/i9+9
         bw7HqesUMWNVmwji/QCAE2f5OTkYL/V7cJLTx9XErEqBZb7oUQ9ujKpv9nAXJo77CKHW
         3YO5pzrZ6qVaorMKzsC3wr0VA536a3C1iWTR5XdF7kbYuJcaU3ctiUma2UQszxK5LPBJ
         sFTCjGcCWP32LL+Am2nm+yrADnTYSM05MDEIc10F6FL0xh9knrTUFBsLsy0L1Nb6myyE
         wKkzauuNPWH0nBewRx2grQUp3ZnLtrqZOKCXkRmrQxnxrUfPtItg2+cBzXnIifyozqfS
         qRkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=E+1fZuQCACuQ+apD87OVT3BJK1v6cMDA5/bmpkXVXfo=;
        b=fayOEfF3jJdXGfd2Xo43AbEE82M5yYbyCu1iRJ8dNDvO05C/WI2PQWmuGg6Ja6DiwA
         eSWeNnRAxyBga7lrmShgVBshwP5I5Rjc8HuKAngABqgyzjFRltAa2eVorvaYscRGJRcA
         LzD0mYZ/Jc1c6/NYiH18QPJwWpyXlS6tnGIxvifjhf6od6TKBIa0FkcehLbmwOcnGIE+
         qqtK1hFeDECa5ksOQ0YCrsEFPon/tSvIS7rdw5K8DBsoEE0QrcEcwePw/XxMBTtTMo2Y
         bbvuM0ByQvA8874exi7Tl1URCCdAPNmWaBr93zMAFXSPz/YWmba63U9ky8EVwQ1euzKv
         uGGA==
X-Gm-Message-State: AGRZ1gL6qsmCmoyz+wM9ezL9A8LWPAOGmc25AkbQewqBjk6GIldfA5lk
        3OVv2vBb0vBxL8T9TgI6WMA=
X-Google-Smtp-Source: AJdET5cHwIBT5fc0oTPsrZQ6Wo1i3Whs6eL4ufCzCuUOHQlL8S/r6vmbkbPEvV2PPBfty+P5XjHeeQ==
X-Received: by 2002:a1c:4b12:: with SMTP id y18-v6mr137202wma.122.1541552276173;
        Tue, 06 Nov 2018 16:57:56 -0800 (PST)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id w11-v6sm21337459wrr.96.2018.11.06.16.57.55
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 06 Nov 2018 16:57:55 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Lucas De Marchi <lucas.demarchi@intel.com>,
        Stefan Beller <sbeller@google.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v2] range-diff: add a --no-patch option to show a summary
References: <20181105200650.31177-1-avarab@gmail.com>
        <20181106162413.9785-1-avarab@gmail.com>
Date:   Wed, 07 Nov 2018 09:57:54 +0900
In-Reply-To: <20181106162413.9785-1-avarab@gmail.com> (=?utf-8?B?IsOGdmFy?=
 =?utf-8?B?IEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Tue, 6 Nov 2018 16:24:13 +0000")
Message-ID: <xmqqsh0dd7ql.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ævar Arnfjörð Bjarmason  <avarab@gmail.com> writes:

> diff --git a/builtin/range-diff.c b/builtin/range-diff.c
> index f01a0be851..05d1f6b6b6 100644
> --- a/builtin/range-diff.c
> +++ b/builtin/range-diff.c
> @@ -16,11 +16,14 @@ int cmd_range_diff(int argc, const char **argv, const char *prefix)
>  	int creation_factor = RANGE_DIFF_CREATION_FACTOR_DEFAULT;
>  	struct diff_options diffopt = { NULL };
>  	int simple_color = -1;
> +	int no_patch = 0;
>  	struct option options[] = {
>  		OPT_INTEGER(0, "creation-factor", &creation_factor,
>  			    N_("Percentage by which creation is weighted")),
>  		OPT_BOOL(0, "no-dual-color", &simple_color,
>  			    N_("use simple diff colors")),
> +		OPT_BOOL_F('s', "no-patch", &no_patch,
> +			 N_("show patch output"), PARSE_OPT_NONEG),

As OPT_BOOL("patch") natively takes "--no-patch" to flip the bool
off, an int variable "patch" that is initialized to 1 would make it
more readable by avoiding double negation !no_patch like the one we
see below.  I guess the reason behind the contortion you wanted to
give the synonym --silent to it?

> @@ -92,7 +95,7 @@ int cmd_range_diff(int argc, const char **argv, const char *prefix)
>  	}
>  
>  	res = show_range_diff(range1.buf, range2.buf, creation_factor,
> -			      simple_color < 1, &diffopt);
> +			      simple_color < 1, !no_patch, &diffopt);

>  	strbuf_release(&range1);
>  	strbuf_release(&range2);

> @@ -7,6 +7,7 @@
>  
>  int show_range_diff(const char *range1, const char *range2,
>  		    int creation_factor, int dual_color,
> +		    int patch,
>  		    struct diff_options *diffopt);

Other than that small "Huh?", the code looks good to me.

> diff --git a/t/t3206-range-diff.sh b/t/t3206-range-diff.sh
> index 6aae364171..27e071650b 100755
> --- a/t/t3206-range-diff.sh
> +++ b/t/t3206-range-diff.sh
> @@ -122,6 +122,26 @@ test_expect_success 'changed commit' '
>  	test_cmp expected actual
>  '
>  
> +test_expect_success 'changed commit -p & --patch' '
> +	git range-diff --no-color -p topic...changed >actual &&
> +	test_cmp expected actual &&
> +	git range-diff --no-color --patch topic...changed >actual &&
> +	test_cmp expected actual

This makes sure that -p and --patch produces the same output as the
default case?  I am not sure who in the parseopt API groks the
single letter "-p" in this case offhand.  Care to explain how?

The other side of the test to see -s/--no-patch we see below also
makes sense.

> +test_expect_success 'changed commit -s & --no-patch' '
> +...
> +	cat >expected <<-EOF &&

Quote EOF to allow readers skim the contents without looking for and
worrying about $substitutions in there, unless there are tons of
offending code in the same script already in which case we should
leave the clean-up outside this primary change.

