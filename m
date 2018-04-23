Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 85FC11F404
	for <e@80x24.org>; Mon, 23 Apr 2018 07:34:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754184AbeDWHeY (ORCPT <rfc822;e@80x24.org>);
        Mon, 23 Apr 2018 03:34:24 -0400
Received: from mail-qt0-f169.google.com ([209.85.216.169]:42528 "EHLO
        mail-qt0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754076AbeDWHeW (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Apr 2018 03:34:22 -0400
Received: by mail-qt0-f169.google.com with SMTP id j3-v6so16599038qtn.9
        for <git@vger.kernel.org>; Mon, 23 Apr 2018 00:34:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=1MPeEkjAaDc3Ls8YAfw09VBRKt08fdoOFQSg+OL3WuU=;
        b=syKWY7pwM0iytGLx4+/1XCCXFg8mcORf/IINlYH99tkGRS0om1Romq4aJX7txEr3vU
         RtDSTokh2fff5a6iW8vDMuKKjh4GOTNXESJ8eA1me1pMq/K8uAlNOhlZlGNOxbZKjdF2
         h84WeBlzY5mjRfxEKPop99FLqRFU+SakcGMNs6eat9V583irPW2qrXet0K45NLDKniGk
         nvp1CjaS21kOrM2SOc9TNhUFliC31LdeyllldaaxLLp3KnnuzEVqz1qVePpLx6Kbvx1h
         Zw+K7scsjISIZku3OVT1gx1B1/ij3SYAVfiMF9fudqzmLtdkg3i11fk60ZCGv4JlyNhe
         e1lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc:content-transfer-encoding;
        bh=1MPeEkjAaDc3Ls8YAfw09VBRKt08fdoOFQSg+OL3WuU=;
        b=jZVsFn1TwhWKtNRjMJyhdyKYf7dIBdTSICJ6lY3+lsleL/fVo7fLlvJN4uXek9d+En
         qYs9AEZy6UOTzPpzPpjGevUhdNE5+6vtIJozdMk7cMSapXtC9bcbUt7Wzcl5Gw9HFuDo
         OYRcPZlOwb8BIsgv/TUD77plzkrkn38Wsgl5AeGf8/w1EVmWLs3f1Oro9mNkdAPkkg1m
         rx7YiuuNQ4Pl/mAtxAHwYfpP7QHS0E6Gf4YjE/PBYFzvVbekTsNjclwGNjPMcQ/Pj8tQ
         E1H/e2pU8y3GpAFPHGZOu/DQNGIasmyy3GGlJSnxiY5RbvbjKgbjZ0puVlUpsq3JonrX
         X3NQ==
X-Gm-Message-State: ALQs6tBzcil/qsoK+w8OJZGrSdFn3hprPRMqSb+b9eMI1qjwFZHueeyY
        sXjVibTkbptDe7SiyVhr0expAYF7LjGZ0+qhkHI=
X-Google-Smtp-Source: AB8JxZqstf7lmyc51Fm2f+B9u9by0/bG1ECufHjxV2aWt5M/MkoYNe86pD285IRdC+FreKbWYO+IliPHGRN/SWHsEIE=
X-Received: by 2002:ac8:42b:: with SMTP id v43-v6mr22026220qtg.69.1524468861672;
 Mon, 23 Apr 2018 00:34:21 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.12.174.202 with HTTP; Mon, 23 Apr 2018 00:34:21 -0700 (PDT)
In-Reply-To: <87604ie61h.fsf@evledraar.gmail.com>
References: <20180421034530.GB24606@syl.local> <cover.1524429778.git.me@ttaylorr.com>
 <5aaf7bebb27d385ea090cb83e97c596983ebae47.1524429778.git.me@ttaylorr.com>
 <CAPig+cQ2+wTTXE0mhnGnp2pZug=Po0SCVwCO_2agxUDaOsFRLw@mail.gmail.com>
 <20180423011726.GD78148@syl.local> <CAPig+cR0dP2Hrb4JhuqmCNFzDPoy7KdqYX3irso6mKdmh9Y4VQ@mail.gmail.com>
 <87604ie61h.fsf@evledraar.gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Mon, 23 Apr 2018 03:34:21 -0400
X-Google-Sender-Auth: TpSTzurdP8PXScws57Onc4nkJtM
Message-ID: <CAPig+cRXkSrPHPyEEhp6_ndRBNW3hE7HkspSk1atPSE5pn_sMw@mail.gmail.com>
Subject: Re: [PATCH v2 2/6] grep.c: take column number as argument to show_line()
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Taylor Blau <me@ttaylorr.com>, Git List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>,
        =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>,
        Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Apr 23, 2018 at 3:27 AM, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
> On Mon, Apr 23 2018, Eric Sunshine wrote:
>> One important issue I noticed is that patch 3/7 neglects to update
>> grep.c:init_grep_defaults() to initialize opt.color_columnno.
>
> I think this is fine for fields that are 0 by default, since the struct
>  is already zero'd out. See my e62ba43244 ("grep: remove redundant
>  double assignment to 0", 2017-06-29) for some prior art.

Indeed, I wasn't worried about opt.columnnum, which is fine being
zero'd out by the memset(). What I was concerned about was
opt.color_columnno; the corresponding opt.color_lineno is handled
explicitly in init_grep_defaults():

    color_set(opt->color_lineno, "");

I'd expect opt.color_columnno to be treated likewise.
