Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIMWL_WL_MED shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A29301F406
	for <e@80x24.org>; Sat, 12 May 2018 03:27:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751131AbeELD1h (ORCPT <rfc822;e@80x24.org>);
        Fri, 11 May 2018 23:27:37 -0400
Received: from mail-pf0-f179.google.com ([209.85.192.179]:38335 "EHLO
        mail-pf0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750793AbeELD1g (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 May 2018 23:27:36 -0400
Received: by mail-pf0-f179.google.com with SMTP id o76-v6so3547387pfi.5
        for <git@vger.kernel.org>; Fri, 11 May 2018 20:27:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=xIOfbMjEL2FrzXj0T99/GA755d+v0MwAz9OreAa7s5c=;
        b=bVnoetV0h5fRcvG/ItXg8IlZvo3PWG2ghCfRaQOkE1QJX6H7P7gdL4JyPrhTLAEia8
         k4n03SFpg5f/hhbvMmN9xyKD5IR1/CC1rZlkkZIbc/b6UZbfbwKK+v97pt5J8jyot/v/
         HvqoNcqFIicBKjXuTi9yw/nb/iRumwetZwx+5ySvlAACXh5/7SBcipxhK8yD3rdllEXI
         NcORXhbvc5QDs13YYgABntoNUjEiLUIft9QmpqfGOp90TcXb81VT6CAEuXctS10GvgVU
         xLoaGeB003VJhtY6OW8NczBUVrB05bQO2Wrwf6SOjoSfMM3ubFO67H0tPyAXvM5H157R
         325A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=xIOfbMjEL2FrzXj0T99/GA755d+v0MwAz9OreAa7s5c=;
        b=cSb2roOCVRSvcb23oaRsUCidXNQ1lGBK4wyxJrP1Za9bt5JqGdo9tYlb+evnRSoCLr
         uEyRcwSF9kUAlHwVoNPg5gjXlKIY7NCnyBEJiOVlVWNu9uIMaqjWdo5DxE6GdPFMcg0E
         fVFXmsu63vQRlXsTGdLQb5HTbPPVx8mxkIxxBMU6oz1hRZ64g+54mv8DjtQTtQdj7uqQ
         AT+3OmKXRhOSeJtCpbXcBqMm/Ca1EZjbPab6D3gXGYxJtp//RxhnNdJ6hQGmzpqOriv4
         xumninDDYpZ+JFBnhG9eKUsNqaa2PVp5QtKORYE0ZEv6g0KizGaGvwUnsfzZzdz+Cuz6
         mB+g==
X-Gm-Message-State: ALKqPwcjHqma6SZIl2tqAAzubBhMIto3gRISUq0dwLBHKeH6Wnl3JvYF
        G2w4WMHxfgA6a4mqYEfZHLCo7w==
X-Google-Smtp-Source: AB8JxZofcn4NvwVuhfvvBZpP0jktyQ+mqntOj+kWAqRGFlQm7OdO2OU8i4cjctyBNImmCrmIaiHPlw==
X-Received: by 2002:a62:8b07:: with SMTP id j7-v6mr1449991pfe.28.1526095655839;
        Fri, 11 May 2018 20:27:35 -0700 (PDT)
Received: from localhost ([2601:602:9500:1120:81b:33bd:f4a4:78cd])
        by smtp.gmail.com with ESMTPSA id c21-v6sm9371183pfb.116.2018.05.11.20.27.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 11 May 2018 20:27:34 -0700 (PDT)
Date:   Fri, 11 May 2018 20:27:33 -0700
From:   Taylor Blau <me@ttaylorr.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Martin =?iso-8859-1?Q?=C5gren?= <martin.agren@gmail.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Git Mailing List <git@vger.kernel.org>,
        =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        =?iso-8859-1?Q?Ren=E9?= Scharfe <l.s.r@web.de>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Jeff King <peff@peff.net>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v5 5/7] builtin/grep.c: add '--column' option to
 'git-grep(1)'
Message-ID: <20180512032733.GA65308@syl.local>
References: <20180421034530.GB24606@syl.local>
 <cover.1525831201.git.me@ttaylorr.com>
 <9222f0ee470884a984c1174cf218dece43f77f87.1525831201.git.me@ttaylorr.com>
 <882bdfe8-6caa-dd9c-7752-ee4884f135f9@talktalk.net>
 <CAN0heSpXCajyDKwOrXuQHWRODsVnFewUWTMitOoRQueFV4eSiw@mail.gmail.com>
 <20180509235251.GC68889@syl.local>
 <xmqqefikl6jx.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqefikl6jx.fsf@gitster-ct.c.googlers.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, May 10, 2018 at 09:04:34AM +0900, Junio C Hamano wrote:
> Taylor Blau <me@ttaylorr.com> writes:
>
> > This check we should retain and change the wording to mention '--and',
> > '--or', and '--not' specifically.
>
> Why are these problematic in the first place?  If I said
>
>     $ git grep -e first --and -e these
>     $ git grep -e first --and --not -e those
>     $ git grep -e first --or -e those
>
> I'd expect that the first line of this paragraph will hit, and the
> first hit for these three are "these", "first" and "first",
> respectively.  Most importantly, in the last one, "--or" can be
> omitted and the whole thing stops being "extended", so rejecting
> extended as a whole does not make much sense.

Agreed that this is what I would expect, too. The trouble is that we
never do a compilation step from containing --and, --or, --not to a
POSIX regexp. So, if we're extended, we have to assume that there might
not be an answer.

Given this, I don't think we should categorically die() when we
encounter this (more below in the next hunk of this mail). I think this
thread has established that there are certainly cases where we cannot
provide a meaningful answer, (--not at the top-level, for instance) but
there are cases where we can (as you indicate above).

One day, I would like to support --column with --and, --or, or --not in
cases where there _is_ a definite answer. That said, omitting this
information for now and at least not die()-ing I think is worth taking
this patch earlier, and leaving some #leftoverbits.

>     $ git grep -v second
>     $ git grep --not -e second
>
> may hit all lines in this message (except for the obvious two
> lines), but we cannot say which column we found a hit.  I am
> wondering if it is too grave a sin to report "the whole line is what
> satisfied the criteria given" and say the match lies at column #1.

I think that is sensible. I previously was opposed to this because I
thought that it would be too difficult to script around the 'sometimes
we have columns but other times not' and 'I gave --column' but have to
check whether or not they are really there.

I no longer believe that my above argument is sound. It simplifies the
matter greatly to simply not share columns when we don't have a good
answer, and do when we do.

In other terms:

  * not giving '--column' will _never_ give a column,
  * '--column --invert' will _always_ die(), and
  * '--column --[and | or | not]' will _never_ give a column.

Thanks,
Taylor
