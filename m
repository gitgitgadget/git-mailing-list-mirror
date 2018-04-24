Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIMWL_WL_MED shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 81B971F424
	for <e@80x24.org>; Tue, 24 Apr 2018 04:31:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752318AbeDXEbo (ORCPT <rfc822;e@80x24.org>);
        Tue, 24 Apr 2018 00:31:44 -0400
Received: from mail-pg0-f51.google.com ([74.125.83.51]:37446 "EHLO
        mail-pg0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751089AbeDXEbn (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Apr 2018 00:31:43 -0400
Received: by mail-pg0-f51.google.com with SMTP id a13so5449571pgu.4
        for <git@vger.kernel.org>; Mon, 23 Apr 2018 21:31:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=7XANq1UmvNcWXnlMyb+b033VT9gvSwsNnnOXycH6Qb8=;
        b=Jnikkiz1lm6DKy9+0TCJBlvB9diOw4sG4KRF8I2S7T25jJJXCaKRVm66RlZVcR/+Rf
         G2/tTXkpbNUpE55sgEbwSNqn1BWQ8W/6nWjCd9obkmW/Imy0IGlsvx4ZVswcyFimRHic
         JGu70X5Y1gD/qAtnJzjRyOIed45h1Y9CU0fe6kJAfrOMcGI7cjD+9qXNpVZzSsfwgck4
         +0BsGu9DBcu6ymJ+//gWNDkE+4uXxG4rI3pd9dtrk6Rj3QUC2CzqucVxAt1bne6/wCyV
         t5uw5FdvAUETv7WhxAHar89gFTYAXvnrvQ7fynE7+MEs/gEk3mERDvip1xI0a290jt5Z
         UlOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=7XANq1UmvNcWXnlMyb+b033VT9gvSwsNnnOXycH6Qb8=;
        b=NT4GzTolp5L2Ik9vwAI9rvJs7oF9TQFoKInsvx8nwDPwtFwQzXbMAsuthd9jvErT9c
         /5R2ty0PoAvta6GdrBL+ebcMFbMJYDjYL4UjUWrdkDRLdYdubM5bJCIKC3vxfALrWB4L
         h5PCVLGny3FRvYo/Bq+0sCy4BL7HEGFsT4pVa079XNfRzCHNsvCcFp/qMCFuSF5Zuw0T
         A34iohTreovhG4DjKUyx/B/p7YhjJ/AIGur1BRcczl8Bd3vaGwcRM8jvN78n/mLC0CQN
         m9eWEFJOBUhcEm/UOom0NZcz/m2paWxCvwxFRLgYKQc2frMRuQhACQ/jEdlsau+mnBiC
         yljw==
X-Gm-Message-State: ALQs6tB10a3H4pGhhlVc0XKbo8QPxRrcQsGQfLlzUIt0LHz2NgZW50RX
        Hb++g26vfw6HXyKSAUdRsG65qQ==
X-Google-Smtp-Source: AIpwx4+WUI9ymO2NIedn78Z2xAObz7ktSgDrcqRrldtbB7nQEfbBarztH2NxmY+O0p/ObGdRFloa5A==
X-Received: by 10.99.54.136 with SMTP id d130mr14631513pga.228.1524544302506;
        Mon, 23 Apr 2018 21:31:42 -0700 (PDT)
Received: from localhost ([2601:602:9500:1120:3dfa:3e1b:ab89:1ffb])
        by smtp.gmail.com with ESMTPSA id a28sm16283394pfl.86.2018.04.23.21.31.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 23 Apr 2018 21:31:41 -0700 (PDT)
From:   Taylor Blau <me@ttaylorr.com>
X-Google-Original-From: Taylor Blau <ttaylorr@github.com>
Date:   Mon, 23 Apr 2018 21:31:40 -0700
To:     =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>
Cc:     Taylor Blau <me@ttaylorr.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Git List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        =?iso-8859-1?Q?Ren=E9?= Scharfe <l.s.r@web.de>,
        Martin =?iso-8859-1?Q?=C5gren?= <martin.agren@gmail.com>,
        Jeff King <peff@peff.net>, Beat Bolli <dev+git@drbeat.li>
Subject: Re: [PATCH v2 2/6] grep.c: take column number as argument to
 show_line()
Message-ID: <20180424043140.GA82406@syl.local>
References: <20180421034530.GB24606@syl.local>
 <cover.1524429778.git.me@ttaylorr.com>
 <5aaf7bebb27d385ea090cb83e97c596983ebae47.1524429778.git.me@ttaylorr.com>
 <CAPig+cQ2+wTTXE0mhnGnp2pZug=Po0SCVwCO_2agxUDaOsFRLw@mail.gmail.com>
 <20180423011726.GD78148@syl.local>
 <874lk2e4he.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <874lk2e4he.fsf@evledraar.gmail.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Apr 23, 2018 at 10:01:17AM +0200, Ævar Arnfjörð Bjarmason wrote:
>
> On Mon, Apr 23 2018, Taylor Blau wrote:
>
> > For your consideration: https://github.com/ttaylorr/git/compare/tb/grep-colno
>
> Looks good to me aside from two minor issues I noticed:
>
>  * In "grep.c: display column number of first match" you use a comment
>    style we don't normally use, i.e. /**\n not /*\n. See "Multi-line
>    comments" in Documentation/CodingGuidelines.
>
>  * You're not updating contrib/git-jump/README to document the new
>    output format. It just refers to the old format, but now depending on
>    if you use "grep" or not it'll use this new thing. It also makes
>    sense to update the example added in 007d06aa57 ("contrib/git-jump:
>    allow to configure the grep command", 2017-11-20) which seems to have
>    added jump.grepCmd as a workaround for not having this.
>
> But also, after just looking at this the second time around; Is there a
> reason we shouldn't just call this --column, not --column-number? I
> realize the former works because of the lazyness of our getopt parsing
> (also --colu though..).
>
> I think when we add features to git-grep we should be as close to GNU
> grep as possible (e.g. not add this -m alias meaning something different
> as in your v1), but if GNU grep doesn't have something go with the trend
> of other grep tools, as noted at
> https://beyondgrep.com/feature-comparison/ (and I found another one that
> has this: https://github.com/beyondgrep/website/pull/83), so there's
> already 3 prominent grep tools that call this just --column.
>
> I think we should just go with that.

I would be happy with either, though I think that my preference is to
retain '--column-number', as introduced in v2. I think that given the
choice between (1) staying closer to our conventions (i.e.,
'--line-number' instead of '--line') and (2) staying closer to other
tools', I'd choose (1).

That said, I'll happily pick up whichever the majority prefers, so if
that's --column and not --column-number, that works OK for me. I believe
that the ultimate say should be up to Junio.

> Also, as a bonus question, since you're poking at this column code
> anyway, interested in implementing -o (--only-matching)? That would be
> super-useful (see
> https://public-inbox.org/git/87in9ucsbb.fsf@evledraar.gmail.com/) :)

Sure, thanks for pointing me in the right direction :-).


Thanks,
Taylor
