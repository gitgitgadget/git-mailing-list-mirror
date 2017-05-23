Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1FC1D20281
	for <e@80x24.org>; Tue, 23 May 2017 17:26:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965501AbdEWR0i (ORCPT <rfc822;e@80x24.org>);
        Tue, 23 May 2017 13:26:38 -0400
Received: from mail-pf0-f182.google.com ([209.85.192.182]:34799 "EHLO
        mail-pf0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934714AbdEWR0h (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 May 2017 13:26:37 -0400
Received: by mail-pf0-f182.google.com with SMTP id 9so120918294pfj.1
        for <git@vger.kernel.org>; Tue, 23 May 2017 10:26:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=FD+UAbPpeCpYH4vkeGXlJ+oEh3RStVo13+6lgeJsXhA=;
        b=lXJ71wDAdcfkTW4tlOS3QV11Ivf3LWYi8imKMHmhZYZqsmNiFhQ10TCBGoKyTegfiB
         kYZzQ511UYyXKh9ZrC3OEd1TDdcjeenIbYedcVYFQyLWrNPJu07FOBP4pBeHUiJUoVxu
         8z9yzQDOh9SWZkdHqmKW6Fx7A7zw9D15kGW3ljWX00LJHjn61TnKopHTZzbBEeFffp64
         nMaO7qa5qEZT3oZFXvVk+u9Z/Qm/8Vds6XRHK9y5SRr+1JsO9MmilC/y0xTea/QRd+6S
         T68UfN8Yo25I0FobhNKPoKeN8B2fkIxWnyYO/FZvqyaPJLO6YU80DvaziZfob0steZxI
         yYqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=FD+UAbPpeCpYH4vkeGXlJ+oEh3RStVo13+6lgeJsXhA=;
        b=e7xPQ19O8m1EVH2DrjuJdXGtD/AqpLzsXitMCx7WwYVP26Kj2aqN87tUqkScPj0R5f
         kbs+5a0Q7goqCNxJWT+kajPKC+t7VzzDg14v480BMUmB2T4CfBuFqrnpgZ4K2oTHInLK
         Hr/qHlUxzReTyQRvHatZ83v82igpBmM8ojgUCQNegv43K34avH+T2j38XO/bFMecbd9O
         t2110503n9SBBQ0HJ6iz8r9AFieOi2WDFmjyKgMI6C933RJwQ0VfosEFkImtH+u5u2nT
         kh+LzWYNWLU3GyiUh2Qe2foQka61pGiBX9A8z583LknudMjpkMiDdwQY/WAgwOVYu5sL
         h1Pg==
X-Gm-Message-State: AODbwcDVEfnVdComZZVWDcLe6lUnjpiCLrnsrkPw11I67KFyPBDt2fkP
        7HTJHN2h572xJHve
X-Received: by 10.99.164.10 with SMTP id c10mr10523413pgf.65.1495560396798;
        Tue, 23 May 2017 10:26:36 -0700 (PDT)
Received: from google.com ([2620:0:100e:422:6539:887d:745f:6fdf])
        by smtp.gmail.com with ESMTPSA id 3sm2199779pgb.22.2017.05.23.10.26.35
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 23 May 2017 10:26:35 -0700 (PDT)
Date:   Tue, 23 May 2017 10:26:34 -0700
From:   Brandon Williams <bmwill@google.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, Johannes.Schindelin@gmx.de, gitster@pobox.com,
        sbeller@google.com, jrnieder@gmail.com, pclouds@gmail.com
Subject: Re: [WIP/RFC 00/23] repository object
Message-ID: <20170523172634.GA115919@google.com>
References: <20170518232134.163059-1-bmwill@google.com>
 <20170522193535.7cgivd6pmmqhw7ze@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170522193535.7cgivd6pmmqhw7ze@sigill.intra.peff.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 05/22, Jeff King wrote:
> On Thu, May 18, 2017 at 04:21:11PM -0700, Brandon Williams wrote:
> 
> > When I first started working on the git project I found it very difficult to
> > understand parts of the code base because of the inherently global nature of
> > our code.  It also made working on submodules very difficult.  Since we can
> > only open up a single repository per process, you need to launch a child
> > process in order to process a submodule.  But you also need to be able to
> > communicate other stateful information to the children processes so that the
> > submodules know how best to format their output or match against a
> > pathspec...it ends up feeling like layering on hack after hack.  What I would
> > really like to do, is to have the ability to have a repository object so that I
> > can open a submodule in-process.
> 
> We could always buy in fully to the multi-process model and just
> implement a generic RPC protocol between the parent and submodule gits.
> Does CORBA still exist?
> 
> (No, I am not serious about any of that).
> 
> > This is still very much in a WIP state, though it does pass all tests.  What
> > I'm hoping for here is to get a discussion started about the feasibility of a
> > change like this and hopefully to get the ball rolling.  Is this a direction we
> > want to move in?  Is it worth the pain?
> 
> I think the really painful part is going to be all of the system calls
> that rely on global state provided by the OS. Like, say, every
> filesystem call that expects to find working tree files without
> prepending the working tree path.

Yeah that's going to be one of the more challenging things to deal
with...

> 
> That said, even if we never reached the point where we could handle all
> submodule requests in-process, I think sticking the repo-related global
> state in a struct certainly could not hurt general readability. So it's
> a good direction regardless of whether we take it all the way.

Glad you think so!

-- 
Brandon Williams
