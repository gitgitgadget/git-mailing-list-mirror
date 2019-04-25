Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5B8C51F453
	for <e@80x24.org>; Thu, 25 Apr 2019 18:05:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730262AbfDYSFQ (ORCPT <rfc822;e@80x24.org>);
        Thu, 25 Apr 2019 14:05:16 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:32976 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726006AbfDYSFP (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Apr 2019 14:05:15 -0400
Received: by mail-pf1-f193.google.com with SMTP id h5so312937pfo.0
        for <git@vger.kernel.org>; Thu, 25 Apr 2019 11:05:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=zJdx2hqW7gEp5k17HIy0leuFl1tJfpwxEuYIZqWmf0Y=;
        b=hME7HWdN9LRJZ5A1771cKLA1MzGkdBvwnDU6ij0zH0oyx8rzEDqjHsgHNZzfhi2SW+
         1OM8CiIS1eIfnp78+hvP52DZ783jkpSk54q+4uL3/W3Ruegq6HHoSjAvxf72LbzTN9KG
         vRn+etu1fSak5vBZBjubmCq5Knu+Ezmjnd7F45MHlL5CJAZsjG6jbQyAECqMZGn8Xr+g
         PLF19oE6xlk4Qe+KCibLYFkK1b48n7fSxByv7it2zdx/rS5is89P7tTKTcB4Rs4tikgL
         I/dE8ytl3FSBaIm891xrEwHoSFTK3i+fnBhP8m19WV1npmDXPcohmj96fQuhsEncVaPo
         Au+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=zJdx2hqW7gEp5k17HIy0leuFl1tJfpwxEuYIZqWmf0Y=;
        b=O2+tRRzQswiU4kTZvsKR8hMeo+xai1wc6RZFwcqOOPUNqKtEWr4pa2GDRDhtnB1IUa
         5soe6+mKTWNFUcRAr5woYwBmgQe9zcigBmOFBHyHrf1mAdmuNp0GqyProEM5Wwil3Qro
         /dqnDiTdoCvzsN0UT3+l2fO22skKvjGn8HxtyYmg3nyk1HNU9tk+H4tKgeOYmA3Yvy61
         tDBitbblWxtGG8fJYvZE3bVdmtMr+5WI9SkL7fSZPRv8kJ89EH2xfK2wkpF+aUuu0Ks1
         TtvPrIccqWllzYhmyBs2o8GBnC4RlXjeNUN3cQlkfbZvLMkn6Tb6cXFC34Sr2Wg4DvJm
         HwCA==
X-Gm-Message-State: APjAAAW7aBMVI1C8BUMWIVJRCIFTJyMietK53/lKxW86KIcIPaxceEe+
        Qi4H+YFpnKHH3CofzrMJvZI=
X-Google-Smtp-Source: APXvYqy+8DgxZNdUR6PXBvBonp6CBgfgLxgxB4mhVsB5RMFpr3Cn5LWIaevLCzie74HlXUP8iLVgtg==
X-Received: by 2002:a62:140d:: with SMTP id 13mr16388218pfu.114.1556215515167;
        Thu, 25 Apr 2019 11:05:15 -0700 (PDT)
Received: from dev-l ([149.28.200.39])
        by smtp.gmail.com with ESMTPSA id k26sm3354313pfo.2.2019.04.25.11.05.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 25 Apr 2019 11:05:13 -0700 (PDT)
Date:   Thu, 25 Apr 2019 11:05:12 -0700
From:   Denton Liu <liu.denton@gmail.com>
To:     SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder.dev@gmail.com>
Cc:     Jeff King <peff@peff.net>, Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Thomas Gummerer <t.gummerer@gmail.com>
Subject: Re: [PATCH v3 0/4] remove extern from function declarations
Message-ID: <20190425180512.GA6409@dev-l>
References: <cover.1555352526.git.liu.denton@gmail.com>
 <cover.1555487380.git.liu.denton@gmail.com>
 <20190422214901.GA14528@sigill.intra.peff.net>
 <20190425120758.GD8695@szeder.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190425120758.GD8695@szeder.dev>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Apr 25, 2019 at 02:07:58PM +0200, SZEDER Gábor wrote:
> On Mon, Apr 22, 2019 at 05:49:01PM -0400, Jeff King wrote:
> > On Wed, Apr 17, 2019 at 12:58:31AM -0700, Denton Liu wrote:
>  
> > >  compat/mingw.c                    |   2 +-
> > >  compat/mingw.h                    |   6 +-
> > >  compat/nedmalloc/malloc.c.h       |   6 +-
> > >  compat/obstack.h                  |  14 +-
> > >  compat/poll/poll.h                |   2 +-
> > >  compat/regex/regex.h              |  66 ++---
> > >  compat/win32/pthread.h            |   8 +-
> > 
> > We sometimes avoid touching compat/ code for style issues because it's
> > copied from elsewhere. And diverging from upstream is more evil than a
> > pure style issue. So potentially we could drop these hunks (though I
> > think maybe mingw is our own thing?).
> > 
> > >  contrib/coccinelle/noextern.cocci |   6 +
> > 
> > I have mixed feelings on this cocci script.
> 
> I have actual bad experience with this :)
> 
> v4 of this patch series excluded 'compat/' from the conversion, but
> the semantic patch is applied to 'compat/' all the same, resulting in
> failed CI builds because of the four 'extern's in 'compat/obstack.h',
> and will continue to do so.
> 
> (Coccinelle has no issues with those other header files; I guess those
> are not included in the '.c' source files we analyze with Coccinelle
> in a stock Linux build environment).

Since this is the case, we should drop 4/4 because it is not only
unhelpful, because it doesn't scan header files, but actively harmful.
The cocci script used is in the log for 1/4 anyway.

Thanks for checking on this,

Denton

> 
> 
> > I'm happy to _see_ it, as
> > it's important to show how the transformation was done. But for most of
> > the other scripts, we expect programmers to introduce new cases that
> > need converting, and we'd like to catch those automatically. Here I find
> > it reasonably unlikely for a lot of "extern" to slip in, with the
> > exception of some topics in flight.
> > 
> > And these coccinelle scripts are kind of expensive to run. So I wonder
> > if the tradeoff is worth it here (perhaps it is now, as we catch those
> > topics in flight, it might be worth dropping this one in a few months).
> > 
> > At any rate, thanks for doing all of this tedious work. :)
> > 
> > -Peff
