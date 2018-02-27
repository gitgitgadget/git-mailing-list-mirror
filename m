Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DE6E51F404
	for <e@80x24.org>; Tue, 27 Feb 2018 22:10:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751896AbeB0WKZ (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Feb 2018 17:10:25 -0500
Received: from mail-qk0-f194.google.com ([209.85.220.194]:40921 "EHLO
        mail-qk0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751574AbeB0WKL (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Feb 2018 17:10:11 -0500
Received: by mail-qk0-f194.google.com with SMTP id o25so548499qkl.7
        for <git@vger.kernel.org>; Tue, 27 Feb 2018 14:10:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=CtfjB6FTkWCxHtRd4u6flRA5gmiTACCW+6M8iq3lpno=;
        b=XlZuWiT8NosZC8EF79rcL2XPHkrt493mcZ9yvbSFj85Tn+jsYC51KIBkn7m+1fVoM8
         HCtHs37sQ3aHnb9gurP6ynvQvUklNngmIiap7u+ZvBrNbrBrxiNZ019ng4MdpdkiE8oP
         vQX7urtuFemxhFjkWAsfkriXM8zU6Z6qnSVDA4/HbgCJ+9O65Ova1bHgEr2Qe3BmWnwh
         T9QxL5VGFHuw0S9izFgtcuglVUAGHwkIFUQVkBAudmW7HlZCFUWVpEUnjInhOZh4XEed
         FMvyGZ2QV6xu79WKf6bnjgHkb/sePwNJSYm1cCyNKkTLP2EQf6AIcQvccYe3q93da6gY
         tHnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=CtfjB6FTkWCxHtRd4u6flRA5gmiTACCW+6M8iq3lpno=;
        b=IoY+DRyEuwzfe4s3cPWG+IdXZ1yfKyqcBtfsczgSTwHEzvqN7KrdmLnkSQIOciybmp
         TzlFABTbGqnpVQzDVyQRSNOM1cA1AzWStyuC7Fglc/uHxHga2dBz9sUSl1pEXNnrmz8M
         49FJidKwga7J/Dr3tFAQ8EdtX7yTrK1juZJP5Mo4pyumdIXkRSbLQgMox+d9zW3PrXaL
         wMaNXGQH3nFy5/v+JOtz7rmA7mkDmb5U0/SZi9ZPpVobHsVhwbPa8kG6RB6/qlPQGzgc
         cptrrugjK5r+LnrV2u2E+eI6C/857tPfNTshv94i0z0w6uD/r/SS0ij6cC27hmRbBnJj
         pQyQ==
X-Gm-Message-State: APf1xPBU8+qVzG1tJKJNqLDpxCmMVTOZzPfPG5u06ie4VB+r2mrzek/3
        x/sfmEjGRa3eZAwyDmKgQ0u7ipjlqokCdqIiQjCTsA==
X-Google-Smtp-Source: AG47ELsRNwqwZSERwBlUsWBBM863nS4yP8dwwp78VeGTty01uKAiTVkalVF3ycPa1fAhsIM/T2bOTAj4aMQxa2UGuRQ=
X-Received: by 10.55.132.67 with SMTP id g64mr25784474qkd.28.1519769410072;
 Tue, 27 Feb 2018 14:10:10 -0800 (PST)
MIME-Version: 1.0
Received: by 10.12.142.14 with HTTP; Tue, 27 Feb 2018 14:10:09 -0800 (PST)
In-Reply-To: <20180227220443.GB11187@sigill.intra.peff.net>
References: <20180125235838.138135-1-bmwill@google.com> <20180207011312.189834-1-bmwill@google.com>
 <20180207011312.189834-15-bmwill@google.com> <20180221145411.35b2ea84747518a499276bdd@google.com>
 <20180222181922.GD185096@google.com> <20180222182657.GE19035@sigill.intra.peff.net>
 <20180222112533.0d7c6023fb8e4098efedfe31@google.com> <20180227062128.GG65699@aiede.svl.corp.google.com>
 <xmqq8tbep02f.fsf@gitster-ct.c.googlers.com> <20180227220443.GB11187@sigill.intra.peff.net>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Tue, 27 Feb 2018 17:10:09 -0500
X-Google-Sender-Auth: _N_eoXewyNgVauOEE2v5jYdIbjY
Message-ID: <CAPig+cS+G-xC51n-Ud0Wbmcc-zeHBM3-5WQQAFm9gwm9LNk3Gg@mail.gmail.com>
Subject: Re: [PATCH v3 14/35] connect: request remote refs using v2
To:     Jeff King <peff@peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Brandon Williams <bmwill@google.com>,
        Git List <git@vger.kernel.org>,
        Stefan Beller <sbeller@google.com>,
        Derrick Stolee <stolee@gmail.com>,
        Jeff Hostetler <git@jeffhostetler.com>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Feb 27, 2018 at 5:04 PM, Jeff King <peff@peff.net> wrote:
> On Tue, Feb 27, 2018 at 01:58:00PM -0800, Junio C Hamano wrote:
>> So are we looking for a natural name to call an array of trings?  I
>> personally do not mind argv_array too much, but perhaps we can call
>> it a string_array and then everybody will be happy?
>
> That would be fine with me. Though I would love it if we could find a
> shorter name for the associated functions. For example,
> argv_array_pushf() can make lines quite long, and something like
> argv_pushf() is easier to read (in my opinion). And that might work
> because "argv" is pretty unique by itself, but "string" is not.
>
> Some one-word name like "strarray" might work, though I find that is not
> quite catchy. I guess "strv" is short if you assume that people know the
> "v" suffix means "vector".

struct strs {...};

void strs_init(struct strs *);
void strs_push(struct strs *, const char *);
void strs_pushf(struct strs *, const char *fmt, ...);
void strs_pushl(struct strs *, ...);
void strs_pushv(struct strs *, const char **);
void strs_pop(struct strs *);
void strs_clear(struct strs *);
const char **strs_detach(struct strs *);

...is short, feels pretty natural, and doesn't require understanding
"v" for "vector".
