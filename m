Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9E356208B8
	for <e@80x24.org>; Wed,  9 Aug 2017 23:19:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752180AbdHIXTE (ORCPT <rfc822;e@80x24.org>);
        Wed, 9 Aug 2017 19:19:04 -0400
Received: from cloud.peff.net ([104.130.231.41]:33952 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1752067AbdHIXTD (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Aug 2017 19:19:03 -0400
Received: (qmail 1339 invoked by uid 109); 9 Aug 2017 23:19:03 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 09 Aug 2017 23:19:03 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 32030 invoked by uid 111); 9 Aug 2017 23:19:26 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Wed, 09 Aug 2017 19:19:26 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 09 Aug 2017 19:19:00 -0400
Date:   Wed, 9 Aug 2017 19:19:00 -0400
From:   Jeff King <peff@peff.net>
To:     Stefan Beller <sbeller@google.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Brandon Williams <bmwill@google.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: [RFC] clang-format: outline the git project's coding style
Message-ID: <20170809231900.3535ja3zqdvyerv4@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAGZ79kZRhTNez1jJq+DcCyERufd_YfWK7L+ujPjRCivzHz7LBw@mail.gmail.com>
 <CAGZ79kYEyebHxFO++u5RkPBj16xx5nMcahBPxra4xWUfMrXydA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Aug 09, 2017 at 03:53:17PM -0700, Stefan Beller wrote:

> >> Right, the reason I stopped pursuing it was that I couldn't find a way
> >> to have it make suggestions for new code without nagging about existing
> >> code. If we were to aggressively reformat to match the tool for existing
> >> code, that would help. But I'm a bit worried that there would always be
> >> suggestions from the tool that we don't agree with (i.e., where the
> >> guiding principle is "do what is readable").
> 
> We may have different opinions on what is readable/beautiful code.
> If we were to follow a mutual agreed style that is produced by a tool,
> we could use clean/smudge filters with different settings each.

I'm less worried about a difference of opinion between humans. My
concern is that there are cases that the tool's formatting makes _worse_
than what any human would write. And either we accept ugly code because
the tool sucks, or we spend a bunch of time fighting with the tool to
try to make its output look good.

> > I would think based on these options, a pre commit hook can be
> > written that formats precisely the touched lines of code of each file.
> 
> I did not search enough, "clang-tidy-diff.py --fix" should be all that is needed

I think I found that script when we discussed this a while back, but I
couldn't get it to stop bugging me about lines that I hadn't touched.  I
haven't looked at it recently, though.  That's specifically what I was
wondering about with "is the tooling ready for this".

-Peff
