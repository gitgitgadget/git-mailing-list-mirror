Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DB7E61F453
	for <e@80x24.org>; Wed, 24 Oct 2018 23:58:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726852AbeJYI20 (ORCPT <rfc822;e@80x24.org>);
        Thu, 25 Oct 2018 04:28:26 -0400
Received: from cloud.peff.net ([104.130.231.41]:53480 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726378AbeJYI20 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Oct 2018 04:28:26 -0400
Received: (qmail 5510 invoked by uid 109); 24 Oct 2018 23:58:16 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 24 Oct 2018 23:58:16 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 11402 invoked by uid 111); 24 Oct 2018 23:57:29 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Wed, 24 Oct 2018 19:57:29 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 24 Oct 2018 19:58:14 -0400
Date:   Wed, 24 Oct 2018 19:58:14 -0400
From:   Jeff King <peff@peff.net>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Ben Peart <peartben@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Git List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Ben Peart <benpeart@microsoft.com>,
        Jeff Hostetler <git@jeffhostetler.com>
Subject: Re: Recommended configurations (was Re: [PATCH v1 2/2] reset: add
 new reset.quietDefault config setting)
Message-ID: <20181024235813.GA1399@sigill.intra.peff.net>
References: <20181017164021.15204-1-peartben@gmail.com>
 <20181017164021.15204-3-peartben@gmail.com>
 <CAPig+cQ3ia78pLtnHSq8tM3B-XnFgWhwowJxwacYEEzXosJ16g@mail.gmail.com>
 <20181017182337.GD28326@sigill.intra.peff.net>
 <874lddc9fs.fsf@evledraar.gmail.com>
 <1ba81f12-7040-1ba5-2009-fa681caf9874@gmail.com>
 <87zhv4bfck.fsf@evledraar.gmail.com>
 <29db5fed-4556-277e-7aad-7ff3233550a9@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <29db5fed-4556-277e-7aad-7ff3233550a9@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Oct 24, 2018 at 11:48:20AM -0400, Derrick Stolee wrote:

> Generally, there are a lot of config settings that are likely in the "if you
> have a big repo, then you should use this" category. However, there is
> rarely a one-size-fits-all solution to these problems, just like there are
> different ways a repo can be "big" (working directory? number of commits?
> submodules?).
> [...]
> All of this is to say: it is probably a good idea to have some "recommended
> configuration" for big repos, but there will always be power users who want
> to tweak each and every one of these settings. I'm open to design ideas of
> how to store a list of recommended configurations and how to set a group of
> config settings with one command (say, a "git recommended-config
> [small|large|submodules]" builtin that fills the local config with the
> important settings).

Maybe it would be useful to teach git-sizer[1] to recommend particular
settings based on the actual definitions of "big" that it measures.

I do hope that some options will just be no-brainers to enable always,
though (e.g., I think in the long run commit-graph should just default
to "on"; it's cheap to keep up to date and helps proportionally to the
repo size).

[1] https://github.com/github/git-sizer
