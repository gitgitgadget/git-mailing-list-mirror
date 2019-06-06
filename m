Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2B8D31F609
	for <e@80x24.org>; Thu,  6 Jun 2019 19:05:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728742AbfFFTFG (ORCPT <rfc822;e@80x24.org>);
        Thu, 6 Jun 2019 15:05:06 -0400
Received: from cloud.peff.net ([104.130.231.41]:48216 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1728217AbfFFTFG (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Jun 2019 15:05:06 -0400
Received: (qmail 16744 invoked by uid 109); 6 Jun 2019 19:05:06 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 06 Jun 2019 19:05:06 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 32043 invoked by uid 111); 6 Jun 2019 19:05:50 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Thu, 06 Jun 2019 15:05:50 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 06 Jun 2019 15:05:04 -0400
Date:   Thu, 6 Jun 2019 15:05:04 -0400
From:   Jeff King <peff@peff.net>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Git List <git@vger.kernel.org>,
        Derrick Stolee <dstolee@microsoft.com>,
        Jeffrey Walton <noloader@gmail.com>
Subject: Re: Git self test failure on Solaris 11.3
Message-ID: <20190606190503.GA3265@sigill.intra.peff.net>
References: <CAH8yC8kynjwT8wbHYV0DpDaMX=AnfmXeOci3uYUnnfsvbq4iRg@mail.gmail.com>
 <CAH8yC8knkXtBii9KhS2iUo908zTx_NyPUgXZhqdwmwEF7Gz8Jg@mail.gmail.com>
 <CAPig+cS98DeSaF6pNqKCn6bAy=jjiTuc3AZpPB2cXm6hQ6vcqQ@mail.gmail.com>
 <20190606173516.GA25089@sigill.intra.peff.net>
 <CAPig+cQi6V=B7GtdN3+-1nPnLXiVjz-O+=WJt5f94o7wHy1VHg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAPig+cQi6V=B7GtdN3+-1nPnLXiVjz-O+=WJt5f94o7wHy1VHg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jun 06, 2019 at 03:00:00PM -0400, Eric Sunshine wrote:

> > I can't reproduce the intermittent failure either on 2.21.0, or with
> > v2.22.0-rc3.
> 
> I can't reproduce it either on Jeff's Solaris box. Perhaps Jeff can
> add "-v -x" to his automated build/test script in order to help
> diagnose the problem if it occurs again.

Jeff: try "--verbose-log -x" if you're doing this as part of an automated
run. That will leave you nice logs in t/test-results without dumping it
all (and in particular, if you run the tests in parallel, it will avoid
interleaving output from various tests).

-Peff
