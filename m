Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1FE8E1F45F
	for <e@80x24.org>; Tue,  7 May 2019 10:21:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726547AbfEGKVJ (ORCPT <rfc822;e@80x24.org>);
        Tue, 7 May 2019 06:21:09 -0400
Received: from mail-it1-f195.google.com ([209.85.166.195]:51142 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726340AbfEGKVI (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 May 2019 06:21:08 -0400
Received: by mail-it1-f195.google.com with SMTP id q14so25510855itk.0
        for <git@vger.kernel.org>; Tue, 07 May 2019 03:21:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5GwdxsHxqaF8UtFSQGyFbBLZRxdWihinMX/U1wymkug=;
        b=ZJlYmWbU/q0D5aILapOdQYPaPKYnjFWJ9W0Bdhu2BJ7GI4IVkzYpBpTtg4XYHdWQWG
         EsEBfLrL8KQE2XSJhmShNDiDla0TbXcC8lHPs4J9V6VdgiHieuULrtcRcuSbvjVCM0UY
         FzFPdMjq4b82MdPKpyZuYkM/F3OiVZOvPFPS17+38zpRWufymezFrPzzSrq9lfZ+ViXo
         3ZAPpjNOEih0t79OeMcH1pB0obogf/K6bOgbGErI6kVhfb2w+8LSUAnD/AVKhsb0wItU
         g3M45/UNK2bwtDZDqfZGYRDxfPLcp19VF+Mz6UOQVVRFVEchYrQ321A6dRAvcp2zfqrv
         lNMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5GwdxsHxqaF8UtFSQGyFbBLZRxdWihinMX/U1wymkug=;
        b=DawGkp4q808cX2hRh7NM56Epntll7Ggu52Cq8gfyecnWm8l7PhYaKu8KZjLMXLoLfY
         OEOKbl3Dk19OlNLzW7AVACy1nfIQS9aY9NqBuEBwtA0jLngzs/HsXBkclLy5wjD+pQ6T
         zhzOn6+Nt6nSHN8qCQ/LTeUrKBn+jzWsu4WpwZVKuLYkrUAz0lqd8GgEXX55+AWLdnO6
         KJ9hiaJ1XO7gO4sho7OQvj9SwLUeIDDg9IslyyJ7yZMZaIsnewTuW0cqPqw8DwCNluJE
         FOXD5xrElaPMVtBKgAer2poh5QJZvsVkBzCnuYdtvEdQHgqUPQWFiaLbkeC7O08A74We
         11Gw==
X-Gm-Message-State: APjAAAUiRP7lC0EWlzo6vidEoNHQg6y+Cw6Sqng+WZssb4MZqQn5yGY7
        C3fOarM0HAUADbSzYEojx/GayQxtTqTPqv6/QmQ=
X-Google-Smtp-Source: APXvYqwbrbvI8XGG6jaDO+LFmfiD1n7avDpoOhI3o22J7dISIwMKi7U0onG3Hdsxh31a5/9VnBYah9dnvQ8oiqib+t0=
X-Received: by 2002:a24:478a:: with SMTP id t132mr21575466itb.123.1557224467699;
 Tue, 07 May 2019 03:21:07 -0700 (PDT)
MIME-Version: 1.0
References: <20190425120758.GD8695@szeder.dev> <nycvar.QRO.7.76.6.1904301919580.45@tvgsbejvaqbjf.bet>
 <20190501100108.GA8954@archbookpro.localdomain> <20190502000422.GF14763@szeder.dev>
 <nycvar.QRO.7.76.6.1905031127170.45@tvgsbejvaqbjf.bet> <20190503144211.GH14763@szeder.dev>
 <20190503174503.GA8242@sigill.intra.peff.net> <CA+P7+xoRGVAP4nHE=neUZGkn9RX_hxN9xVzfWexR79ZWT0ejSQ@mail.gmail.com>
 <20190506051148.GB30003@sigill.intra.peff.net> <CACsJy8CLjUdHCro8QJfTozMB0xVWppHuFRSLCvFSaeKO_PxAog@mail.gmail.com>
 <20190506234334.GA13296@sigill.intra.peff.net>
In-Reply-To: <20190506234334.GA13296@sigill.intra.peff.net>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Tue, 7 May 2019 17:20:41 +0700
Message-ID: <CACsJy8BFxN9oL-ag2DH+mhySkOAXOzP1Q0wnb4bEHWTwgyGtfg@mail.gmail.com>
Subject: Re: [PATCH] coccicheck: optionally batch spatch invocations
To:     Jeff King <peff@peff.net>
Cc:     Jacob Keller <jacob.keller@gmail.com>,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Denton Liu <liu.denton@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Thomas Gummerer <t.gummerer@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, May 7, 2019 at 6:43 AM Jeff King <peff@peff.net> wrote:
>
> On Mon, May 06, 2019 at 04:34:09PM +0700, Duy Nguyen wrote:
>
> > > However, it comes at a cost. The RSS of each spatch process goes from
> > > ~50MB to ~1500MB (and peak memory usage may be even higher if make runs
> >
> > 1.5G should be fine. Trying...
> >
> > Even with no -j, my htop's RES column goes up 6GB and put my laptop in
> > "swap every bit of memory out, including the bits handling the screen"
> > mode :( I don't think it was even the peak.
>
> Interesting if you have a different version of spatch. I'm using 1.0.4
> from Debian unstable.

I'm using 1.0.6

> Ideally we'd just invoke a single instance of spatch per rule-file and
> feed it all source files. But spatch can be rather memory hungry when
> run in this way. I measured the peak RSS going from ~90MB for a single
> file to ~1900MB for all files. Multiplied by multiple rule files being
> processed at the same time (for "make -j"), this can make things slower
> or even cause them to fail (e.g., this is reported to happen on our
> Travis builds).
>
> Instead, let's provide a tunable knob. We'll leave the default at "1",
> but it can be cranked up to "999" for maximum CPU/memory tradeoff, or
> people can find points in between that serve their particular machines.
>
> Here are a few numbers running a single rule via:
>
>   SIZES='1 4 16 999'
>   RULE=contrib/coccinelle/object_id.cocci
>   for i in $SIZES; do
>     make clean
>     /usr/bin/time -o $i.out --format='%e | %U | %S | %M' \
>       make $RULE.patch SPATCH_BATCH_SIZE=$i
>   done
>   for i in $SIZES; do
>     printf '%4d | %s\n' $i "$(cat $i.out)"
>   done
>
> which yields:
>
>      1 | 97.73 | 93.38 | 4.33 | 100128
>      4 | 52.80 | 51.14 | 1.69 | 135204
>     16 | 35.82 | 35.09 | 0.76 | 284124
>    999 | 23.30 | 23.13 | 0.20 | 1903852

I think I'm going to settle around 32 which has peak at 2GB for me and
I can still make use of 4 hyperthread cores.

It's weird for me though that no SIZES=1 is actually the fastest. The
larger SPATCH_BATCH_SIZE is, the slower:

> ~/w/git/temp $ rm contrib/coccinelle/commit.cocci.patch
> ~/w/git/temp $ time make contrib/coccinelle/commit.cocci.patch
     SPATCH contrib/coccinelle/commit.cocci

real    1m20,242s
user    1m15,863s
sys     0m4,376s

> ~/w/git/temp $ rm contrib/coccinelle/commit.cocci.patch
> ~/w/git/temp $ time make contrib/coccinelle/commit.cocci.patch SPATCH_BATCH_SIZE=16
     SPATCH contrib/coccinelle/commit.cocci

real    3m3,131s
user    2m59,345s
sys     0m3,819s

> ~/w/git/temp $ rm contrib/coccinelle/commit.cocci.patch
> ~/w/git/temp $ time make contrib/coccinelle/commit.cocci.patch SPATCH_BATCH_SIZE=32
     SPATCH contrib/coccinelle/commit.cocci

real    5m10,966s
user    5m5,434s
sys     0m5,500s

But that might be just cocci or environmental problem. Since you and
Jacob both see good speedup, this patch is good.
-- 
Duy
