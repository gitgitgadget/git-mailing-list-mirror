Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 58DEA1F4C0
	for <e@80x24.org>; Tue, 29 Oct 2019 10:16:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729337AbfJ2KQZ (ORCPT <rfc822;e@80x24.org>);
        Tue, 29 Oct 2019 06:16:25 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:38398 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728868AbfJ2KQZ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 Oct 2019 06:16:25 -0400
Received: by mail-wr1-f67.google.com with SMTP id v9so12964443wrq.5
        for <git@vger.kernel.org>; Tue, 29 Oct 2019 03:16:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=pmx74ih5EXibRenDzPRMgEWrsSwYMD8OgxfG8SMZVPQ=;
        b=q3T5R9T2eq5/X+v9VYGTn2J4e2nmyRvHqghqB2r7KAT3dN65S/KZV5w7dMR6lGL5X4
         v/oz6Mt+rJ342SESfcwexxwSY+WqS/mlrgESvijt5S8/KDPsXsGOszYvfdIM7WQo8ew0
         MdM0T3I0E74rqWH3smAFTEgCUHJ7hpx15L83JLDEJJWk1Sjy6+W4hp4F+uNYCm+aaiaL
         YIBLWZHq084AJvXg1FA1nGZsrAWrYxNDL4fOTrXYhUi2U2SnVT35Rd8pRbO9pZwCxXBZ
         ikKWroYwa2b3+POo3OxHFNESFaUHdQoOuaa8jrKEmvDii4F7EY8YkZROs4z4bQpoCDlD
         +AoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=pmx74ih5EXibRenDzPRMgEWrsSwYMD8OgxfG8SMZVPQ=;
        b=raQAm8cK2PtMGkosyVmk6VtbRvEQzS1DMsLCP9Uv03JWwyZ6Vs4JIYYPqQZAzyKWAI
         P4ovMP9UIW5wqurl/hiJzwmbOheX5OfRrT6MvWrC0ungoctAEelYjXBL0ZgrrIwNX1BP
         +fdiqD4xhW3O5DXxgDdByJRjifwofIOcFdRLiUjDgw3lXcrDyAmdhEH2nf2ZZuXH2W77
         7BxdYfZRBPutGN6W7CVIlV6BpciW2QjOP+3PvSP8a+WJ5iM3Vacz8At+QGCgIC/YzdSg
         NnvOjX9cIWvgBLWABYdcGiqueVVzs57CjDNdjKw6C7U6bSmzz4cR4vYwQjDp1vgLubTj
         sUIA==
X-Gm-Message-State: APjAAAVbjopAW/Y23pMn+gnX9d9gAIDtKU7QlmkQ30olmrq5EnAPtYVv
        yGT1Fxr0ZRB75uleVF8eRfa1pmjO
X-Google-Smtp-Source: APXvYqw6gLoDtj+QR3g7UCEPuEQBZzk9WQg2zx2rSQAxzTxmPejAoc26LzDuczPu4CPVLesPe2WuQg==
X-Received: by 2002:a5d:6cc3:: with SMTP id c3mr18883851wrc.202.1572344181766;
        Tue, 29 Oct 2019 03:16:21 -0700 (PDT)
Received: from szeder.dev (x4db971f1.dyn.telefonica.de. [77.185.113.241])
        by smtp.gmail.com with ESMTPSA id y3sm20587381wro.36.2019.10.29.03.16.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 29 Oct 2019 03:16:20 -0700 (PDT)
Date:   Tue, 29 Oct 2019 11:16:15 +0100
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     "Randall S. Becker" <rsbecker@nexbridge.com>
Cc:     'Johannes Schindelin' <Johannes.Schindelin@gmx.de>,
        git@vger.kernel.org
Subject: Re: [BUG] git 2.24.0-rc1 t0500 on NonStop in Jenkins
Message-ID: <20191029101615.GA24010@szeder.dev>
References: <011f01d58ab6$91fee620$b5fcb260$@nexbridge.com>
 <nycvar.QRO.7.76.6.1910281405000.46@tvgsbejvaqbjf.bet>
 <026401d58d9a$2bbe7600$833b6200$@nexbridge.com>
 <20191028145220.GU4348@szeder.dev>
 <027301d58da3$4a4996a0$dedcc3e0$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <027301d58da3$4a4996a0$dedcc3e0$@nexbridge.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Oct 28, 2019 at 11:20:48AM -0400, Randall S. Becker wrote:
> > > + test_i18ncmp expect out
> > > --- expect	2019-10-28 14:11:40 +0000
> > > +++ out	2019-10-28 14:11:41 +0000
> > > @@ -1,4 +1,2 @@
> > > -Working hard:  33% (1/3)<CR>
> > > -Working hard:  66% (2/3)<CR>
> > > -Working hard: 100% (3/3)<CR>
> > > -Working hard: 100% (3/3), done.
> > > +Working hard:   0% (1/12884901888)<CR>
> > > +Working hard:   0% (3/12884901888), done.
> > 
> > Weird, this looks exactly like the big-endian test failure that was fixed in
> > 2b6f6ea1bd (test-progress: fix test failures on big-endian systems, 2019-10-
> > 20), but that is already in 2.24.0-rc1 (but not yet in -rc0).
> > 
> > https://public-inbox.org/git/f1ce445e-6954-8e7b-2dca-
> > 3a566ce689a5@physik.fu-berlin.de/
> > 
> > Is NonStop big or little-endian?  Does t0500 pass without 2b6f6ea1bd?
> 
> NonStop is big-endian. When t0500 is run from an interactive
> terminal, it passes. This failure seems to be a result of being in a
> disconnected terminal situation typical of Jenkins, not that the
> test result makes any sense with that being the only difference.
> t0500 did not exist in 2.23.0, our last build,

Didn't you build v2.24.0-rc0?

> so I can't easily get
> that answer. Our Jenkins is based off the master branch, so it's a
> hard to revert in our pipeline without a serious amount of work -
> that and without 2b6f6ea1bd, other things break if I remember from
> August.
> 
> Does the printf format use positional arguments (%digit$)? That has
> known issues on the platform.

The output in question is formatted in display() in progress.c:124:

        strbuf_addf(counters_sb,
                    "%3u%% (%"PRIuMAX"/%"PRIuMAX")%s", percent,
                    (uintmax_t)n, (uintmax_t)progress->total,
                    tp);

where both 'n' and 'progress->total' are uint64_t, and 'PRIuMAX' is
'llu'.  All of these are widely used throughout the code base.

> FYI: int/long are 32 bits, long long is 64 bits. 12884901888 is
> 0x300000000, surprisingly.

It's not surprising, basically that's what 2b6f6ea1bd is all about.

> > > error: last command exited with $?=1
> > > not ok 2 - progress display with total
> > > #
> > > #		cat >expect <<-\EOF &&
> > > #		Working hard:  33% (1/3)<CR>
> > > #		Working hard:  66% (2/3)<CR>
> > > #		Working hard: 100% (3/3)<CR>
> > > #		Working hard: 100% (3/3), done.
> > > #		EOF
> > > #
> > > #		cat >in <<-\EOF &&
> > > #		progress 1
> > > #		progress 2
> > > #		progress 3
> > > #		EOF
> > > #		test-tool progress --total=3 "Working hard" <in 2>stderr &&
> > > #
> > > #		show_cr <stderr >out &&
> > > #		test_i18ncmp expect out
> > > #
> > >
> 
