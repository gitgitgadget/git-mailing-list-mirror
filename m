Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-8.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 515B81F51C
	for <e@80x24.org>; Mon, 21 May 2018 21:41:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932198AbeEUVlZ (ORCPT <rfc822;e@80x24.org>);
        Mon, 21 May 2018 17:41:25 -0400
Received: from mail-pg0-f65.google.com ([74.125.83.65]:39599 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932342AbeEUVlB (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 May 2018 17:41:01 -0400
Received: by mail-pg0-f65.google.com with SMTP id e1-v6so6905482pga.6
        for <git@vger.kernel.org>; Mon, 21 May 2018 14:41:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=5RKwjZPoPSmoleFp44ZDpRle1SsxCUGMhwvuNOKNE4M=;
        b=hS7vCugyEwP2rmnWyPeg/w1Mz35R6sqLVArr+0wjrH8rZUEd6wYQencnR2MyRmtyUS
         nglZ0nIQ+EIf44VSa9zQsX+v7VMtGhYLRzBC2wSk9qkiQB4++F8g84dZGeI7OQdCRh5Q
         quwC1tb6nH4KFVX2aSIFD7LBMDNyTq9gcxOaxT76ktmvLfX/QCsPGpQo24if3A0DCz1e
         r1JmAl9k6xSXN2bEJBBil38kmfrZUgUvvyf3CsW5txNC9ckJUbj+zTriipQZMP5QbNzC
         hS6taQpIcav5/JiEWOVtJ52uG5JU8leVrDIhOA3ABy5SgfnvQJR7RLRIZBRTEwQ+yUUS
         ZVMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=5RKwjZPoPSmoleFp44ZDpRle1SsxCUGMhwvuNOKNE4M=;
        b=MEQ2N6BcGss7T9PJc+pXhKeBTsG+C7ss4vUTJZXVhrv8ar9MlbObln5kpl2ovdYs2H
         qL8KS1d1tACqBtxqprB5isXA6Mq2kyJcsQ/HR6KmchjuMzfQ2QUz0lon2VBDWuvd2HvV
         awrq2GZWcfG69587w4xBcjkbBmhyyjXSq0PQsVcDBr/e+FT7YlI/r0dmcOR0eyMVQ3j5
         7ppIPSZPzNVIxgGLuevIqt+ce3jeqRWca9R5deMZ9P/h/eKsrGC3LU+c87yAGVX3JQ44
         Vf2txfokNoPKVsythkvCAYtptwIMDjO/B68W0MkDI+WZkSafLjUwEGSku6AdZ0R3qjq0
         7mBQ==
X-Gm-Message-State: ALKqPwfesoh1j1o/Qd3lh2OY2zbgRCv6Pq8ZWVybfu4F5rkZJTY/dvhx
        OBHRly4eKz8h5he6tnUiK2Ju9A==
X-Google-Smtp-Source: AB8JxZoc1B7dJ6BzBE0SBqiCjnUXl9Ga6DDMBuNeKZKX87hN4B5djInqbQVM9aHje0HoLM/Yf4D6/g==
X-Received: by 2002:a65:63cf:: with SMTP id n15-v6mr11234010pgv.371.1526938860333;
        Mon, 21 May 2018 14:41:00 -0700 (PDT)
Received: from google.com ([2620:0:100e:422:ff43:9291:7eda:b712])
        by smtp.gmail.com with ESMTPSA id i1-v6sm30133619pfi.133.2018.05.21.14.40.58
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 21 May 2018 14:40:58 -0700 (PDT)
Date:   Mon, 21 May 2018 14:40:57 -0700
From:   Brandon Williams <bmwill@google.com>
To:     Jeff King <peff@peff.net>
Cc:     Stefan Beller <sbeller@google.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Igor Djordjevic <igor.d.djordjevic@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Junio C Hamano <gitster@pobox.com>,
        Git List <git@vger.kernel.org>, Thomas Rast <tr@thomasrast.ch>,
        Thomas Gummerer <t.gummerer@gmail.com>,
        =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Jacob Keller <jacob.keller@gmail.com>
Subject: Re: [PATCH v2 02/18] Add a new builtin: branch-diff
Message-ID: <20180521214057.GB125693@google.com>
References: <nycvar.QRO.7.76.6.1805052355190.77@tvgsbejvaqbjf.bet>
 <xmqqk1shsecd.fsf@gitster-ct.c.googlers.com>
 <nycvar.QRO.7.76.6.1805061419530.77@tvgsbejvaqbjf.bet>
 <CAPig+cS0pvdg78fGUu8m2xspDDMHxi=uAMCkbLuthy7R4p3fQw@mail.gmail.com>
 <nycvar.QRO.7.76.6.1805062155120.77@tvgsbejvaqbjf.bet>
 <20180507074843.GC31170@sigill.intra.peff.net>
 <3cefc6b3-3dbd-9cb1-20d0-193116191726@gmail.com>
 <nycvar.QRO.7.76.6.1805211153370.77@tvgsbejvaqbjf.bet>
 <CAGZ79kYcWuVorfk7eYjUuLi2XeMS8sPrJYE0OQmgiQi2NkuDZA@mail.gmail.com>
 <20180521202414.GA14250@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180521202414.GA14250@sigill.intra.peff.net>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 05/21, Jeff King wrote:
> On Mon, May 21, 2018 at 10:56:47AM -0700, Stefan Beller wrote:
> 
> > > It is very much about
> > > comparing two *ranges of* revisions, and not just any ranges, no. Those
> > > ranges need to be so related as to contain mostly identical changes.
> > 
> > range-diff, eh?
> > 
> > > Most fellow German software engineers (who seem to have a knack for
> > > idiotically long variable/function names) would now probably suggest:
> > >
> > >         git compare-patch-series-with-revised-patch-series
> > 
> > or short:
> > 
> >   revision-compare
> >   compare-revs
> >   com-revs
> > 
> >   revised-diff
> >   revise-diff
> >   revised-compare
> > 
> >   diff-revise

I haven't really been following all of the discussion but from what I
can tell the point of this command is to generate a diff based on two
different versions of a series, so why not call it 'series-diff'? :)

-- 
Brandon Williams
