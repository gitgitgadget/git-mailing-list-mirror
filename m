Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIMWL_WL_MED shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8BFB41F406
	for <e@80x24.org>; Sat, 12 May 2018 05:19:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750756AbeELFTG (ORCPT <rfc822;e@80x24.org>);
        Sat, 12 May 2018 01:19:06 -0400
Received: from mail-pg0-f43.google.com ([74.125.83.43]:33601 "EHLO
        mail-pg0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750722AbeELFTF (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 12 May 2018 01:19:05 -0400
Received: by mail-pg0-f43.google.com with SMTP id v7-v6so473604pgs.0
        for <git@vger.kernel.org>; Fri, 11 May 2018 22:19:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=oYisnCVmUSUquNktJcV9rvjCShT1ReJxmSqqEIyj/KU=;
        b=kIlk4wACYUQLl5F1zKcjiZPvl1Z/9+KQU3qcoSDHMeMGooDUgKrJ9vWBExCVF5PUdA
         KpLUsfAW5jZuT4g9lLRypHffDECIKCT0JmXOdNybEmQqo1DxZMoPQAO9FLQPF5qu1rxb
         Cz25vie2AJ+/0JMjnHBR3ggCBgsLGrjq34/AbxhqMsBFIXIIHg83C3gqabNWpREhKH1L
         DdIlPZnN7gOBq+8gRf4DCGo/Is9HrF7N+nPozA3X7rVi6jSo+Ffs49oVmH0Dgx98gtgc
         vtdazrJKpn6cXLZc0CuQ2W7jpPhjUC9ThbFeQjuSdOJWLd6dqWDZNjfuXF3zur81VGR1
         uIoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=oYisnCVmUSUquNktJcV9rvjCShT1ReJxmSqqEIyj/KU=;
        b=sI5FJGCN1nfuo8lkEujgDRZZlQokf7UxiFhevbcQgLHhR+0x5tUDNNZqwfuYKFARHR
         Q+xM/AdzzLnMHTYP1OKwgTayeXOO8EqfGddvVvWqg8+nZOI1k8e2X/1wSsQGiOqdII++
         GlDxHPxrc8/L3p0qTUDbj+x3+RDSOXGEYgZPUPVeipBQTQlaUK4lk7p/xZnedzM7snIC
         VU+BfqL2fL4bYsiIMlYPB7mmVvFmZFyGVOCRYPaQPSTE4cnn87rGzms44Q1zVPZx6FBu
         G73jqs+cu2Raxy8TzJKd5Z4HOu1g2SWOIyPgX4R0UJ7LG9SkQJpoiBlhWtOsv7shqBHZ
         iOeA==
X-Gm-Message-State: ALKqPwcnHuSJSFKCOlwfQdzTpa007++W90mgcfQ9PyPs8/GsN9CPiPin
        1WbkuxUl6DTc7Fx6hB7OqBSaIA==
X-Google-Smtp-Source: AB8JxZpsWuxE3kU6v/D7EXl5EErObydjqTes9QONxWXW7TazKeajGB7c1cutyE8dCksnwSoLmHrg/w==
X-Received: by 2002:a63:6c04:: with SMTP id h4-v6mr1627285pgc.220.1526102344873;
        Fri, 11 May 2018 22:19:04 -0700 (PDT)
Received: from localhost ([2601:602:9500:1120:446:2ae4:6aee:aa5d])
        by smtp.gmail.com with ESMTPSA id v14-v6sm7933374pfn.105.2018.05.11.22.19.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 11 May 2018 22:19:03 -0700 (PDT)
From:   Taylor Blau <me@ttaylorr.com>
X-Google-Original-From: Taylor Blau <ttaylorr@github.com>
Date:   Fri, 11 May 2018 22:19:02 -0700
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Taylor Blau <me@ttaylorr.com>,
        Martin =?iso-8859-1?Q?=C5gren?= <martin.agren@gmail.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Git Mailing List <git@vger.kernel.org>,
        =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        =?iso-8859-1?Q?Ren=E9?= Scharfe <l.s.r@web.de>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Jeff King <peff@peff.net>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v5 5/7] builtin/grep.c: add '--column' option to
 'git-grep(1)'
Message-ID: <20180512051902.GA70598@syl.local>
References: <20180421034530.GB24606@syl.local>
 <cover.1525831201.git.me@ttaylorr.com>
 <9222f0ee470884a984c1174cf218dece43f77f87.1525831201.git.me@ttaylorr.com>
 <882bdfe8-6caa-dd9c-7752-ee4884f135f9@talktalk.net>
 <CAN0heSpXCajyDKwOrXuQHWRODsVnFewUWTMitOoRQueFV4eSiw@mail.gmail.com>
 <20180509235251.GC68889@syl.local>
 <xmqqefikl6jx.fsf@gitster-ct.c.googlers.com>
 <20180512032733.GA65308@syl.local>
 <xmqqbmdlfokf.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqbmdlfokf.fsf@gitster-ct.c.googlers.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, May 12, 2018 at 02:08:48PM +0900, Junio C Hamano wrote:
> Taylor Blau <me@ttaylorr.com> writes:
>
> >>     $ git grep -v second
> >>     $ git grep --not -e second
> >>
> >> may hit all lines in this message (except for the obvious two
> >> lines), but we cannot say which column we found a hit.  I am
> >> wondering if it is too grave a sin to report "the whole line is what
> >> satisfied the criteria given" and say the match lies at column #1.
> >
> > I think that is sensible. I previously was opposed to this because I
> > thought that it would be too difficult to script around the 'sometimes
> > we have columns but other times not' and 'I gave --column' but have to
> > check whether or not they are really there.
>
> I am not sure if you really got what I meant.  I am suggesting that
> "git grep -v --column second" should report that the entire line has
> hit for each and every line that does not have "second" on it, which
> is a good answer and eliminate "sometimes there is column answer (or
> answer to -o query) and sometimes not" at the same time.

I re-read your note and understand more clearly now what your suggestion
is. To ensure that we're in agreement, do you mean:

  1. '--column -v' will _never_ give a column, but will never die(),
      either

  2. '--column --[and | or | not]' will never give a column, but will
      also never die(), either.

I think that _those_ semantics are sensible, and I apologize for
misinterpreting your original note.

> > In other terms:
> >
> >   * not giving '--column' will _never_ give a column,
> >   * '--column --invert' will _always_ die(), and
> >   * '--column --[and | or | not]' will _never_ give a column.
>
> So this is completely opposite from what I would have expected. to
> somebody who said "I think that is sensible." over there.

Thanks,
Taylor
