Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3CAED1F97E
	for <e@80x24.org>; Fri,  5 Oct 2018 19:44:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728341AbeJFCo0 (ORCPT <rfc822;e@80x24.org>);
        Fri, 5 Oct 2018 22:44:26 -0400
Received: from cloud.peff.net ([104.130.231.41]:43682 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1728139AbeJFCo0 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 Oct 2018 22:44:26 -0400
Received: (qmail 25822 invoked by uid 109); 5 Oct 2018 19:44:15 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 05 Oct 2018 19:44:15 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 15443 invoked by uid 111); 5 Oct 2018 19:43:30 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Fri, 05 Oct 2018 15:43:30 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 05 Oct 2018 15:44:13 -0400
Date:   Fri, 5 Oct 2018 15:44:13 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
        Derrick Stolee <stolee@gmail.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH 15/16] commit-reach: make can_all_from_reach... linear
Message-ID: <20181005194412.GA19689@sigill.intra.peff.net>
References: <pull.10.git.gitgitgadget@gmail.com>
 <816821eec9ba476ccdfbfdf6e3cdd3619743ea2e.1531746012.git.gitgitgadget@gmail.com>
 <d1b58614-989f-5998-6c53-c19eee409a2f@web.de>
 <dd798e76-922f-a113-4408-e3892bee3b44@gmail.com>
 <223b14f7-213f-4d22-4776-22dcfd1806c2@web.de>
 <7b95417a-c8fb-4f1e-cb09-c36804a3a4d0@web.de>
 <20181005165157.GC11254@sigill.intra.peff.net>
 <878t3cgqd2.fsf@evledraar.gmail.com>
 <20181005192816.GE17482@sigill.intra.peff.net>
 <877eiwgoxy.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <877eiwgoxy.fsf@evledraar.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Oct 05, 2018 at 09:42:49PM +0200, Ævar Arnfjörð Bjarmason wrote:

> >  that I imagine will create a lot of new problems. (We're just now
> > allowing C99 -- I don't even want to think about what kind of compiler
> > issues we'll run into on antique systems trying to use C++).
> 
> ...But just on this point: I was under the impression that this problem
> was way easier with C++. I.e. reason we're just now using C99 for
> portable C projects is because Microsoft for years refused to put any
> effort into updating their compiler to support newer C versions, while
> keeping up-to-date with C++, and that this has only recently started
> changing: https://en.wikipedia.org/wiki/C99#Implementations
> 
> Maybe there was some other popular vendor of C/C++ compilers that had
> the inverse of that story, but I'm not aware of any.

I'd worry about what the C++ story is on AIX, etc.

-Peff
