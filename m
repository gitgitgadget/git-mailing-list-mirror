Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 410B31F4F8
	for <e@80x24.org>; Fri, 23 Sep 2016 04:07:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754131AbcIWEHf (ORCPT <rfc822;e@80x24.org>);
        Fri, 23 Sep 2016 00:07:35 -0400
Received: from cloud.peff.net ([104.130.231.41]:46993 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753398AbcIWEHd (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Sep 2016 00:07:33 -0400
Received: (qmail 25660 invoked by uid 109); 23 Sep 2016 04:07:33 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 23 Sep 2016 04:07:33 +0000
Received: (qmail 14332 invoked by uid 111); 23 Sep 2016 04:07:46 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 23 Sep 2016 00:07:46 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 23 Sep 2016 00:07:30 -0400
Date:   Fri, 23 Sep 2016 00:07:30 -0400
From:   Jeff King <peff@peff.net>
To:     Stefan Beller <sbeller@google.com>
Cc:     Jonas Thiel <jonas.lierschied@gmx.de>,
        John Keeping <john@keeping.me.uk>,
        Heiko Voigt <hvoigt@hvoigt.net>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: Re: Re: Homebrew and Git
Message-ID: <20160923040730.76stbefz2ivyfy45@sigill.intra.peff.net>
References: <trinity-9c8f1bd1-d6be-48f3-8575-03be09bd1243-1474213828361@3capp-gmx-bs53>
 <20160920110228.GA64315@book.hvoigt.net>
 <20160920110700.GB64315@book.hvoigt.net>
 <20160920191555.GB1673@john.keeping.me.uk>
 <20160921084841.phq7cfbagi5k7ku4@sigill.intra.peff.net>
 <trinity-7a55c197-21af-4808-9919-6fc26bdcece2-1474536212197@3capp-gmx-bs75>
 <CAGZ79kYUcyCrjPfqWtyWE-kaqbQZPG1qosc3qJrDfHixivyFew@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAGZ79kYUcyCrjPfqWtyWE-kaqbQZPG1qosc3qJrDfHixivyFew@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Sep 22, 2016 at 08:57:45AM -0700, Stefan Beller wrote:

> On Thu, Sep 22, 2016 at 2:23 AM, Jonas Thiel <jonas.lierschied@gmx.de> wrote:
> > Sorry for my late reply. Thanks for your support -- I really appreciate that.
> >
> > @Jeff: Unfortunately, I do not know how to implement the patch you provided. Can you explain how to do that?
> 
> I think this should do:
> 
>     git clone https://github.com/git/git
>     cd git
>     # get the email
>     wget http://public-inbox.org/git/20160921084841.phq7cfbagi5k7ku4@sigill.intra.peff.net/raw
>     # apply patch:
>     git am raw

I publish my topic branches via git, too, so it may be easier to replace
these steps with:

  git clone -b jk/ident-canonname https://github.com/peff/git
  cd git

>     make
>     make install

After installing, you probably want to do:

  PATH=/path/to/git/bin-wrappers:$PATH

to run the new git (and make sure that any git sub-commands that are run
come from the built version, not the rest of the system).

I have access to an OS X system, but if I understand the bug correctly,
reproducing it may involve re-setting the system hostname, which is not
something I'll be able to do. But I'll give it a shot.

-Peff
