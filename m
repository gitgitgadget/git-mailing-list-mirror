Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9837F1F404
	for <e@80x24.org>; Wed,  7 Feb 2018 13:25:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753876AbeBGNZO (ORCPT <rfc822;e@80x24.org>);
        Wed, 7 Feb 2018 08:25:14 -0500
Received: from cloud.peff.net ([104.130.231.41]:43598 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1753720AbeBGNZN (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Feb 2018 08:25:13 -0500
Received: (qmail 8204 invoked by uid 109); 7 Feb 2018 13:25:14 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 07 Feb 2018 13:25:14 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 30139 invoked by uid 111); 7 Feb 2018 13:25:56 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Wed, 07 Feb 2018 08:25:56 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 07 Feb 2018 08:25:11 -0500
Date:   Wed, 7 Feb 2018 08:25:11 -0500
From:   Jeff King <peff@peff.net>
To:     Elijah Newren <newren@gmail.com>
Cc:     Stefan Beller <sbeller@google.com>,
        Git Mailing List <git@vger.kernel.org>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= <pclouds@gmail.com>
Subject: Re: BUG: fetch in certain repo always gives "did not send all
 necessary objects"
Message-ID: <20180207132511.GA19396@sigill.intra.peff.net>
References: <CABPp-BHVD19ZoAmWhQd9aN-v+qB7Ryq9Z-wobLYtJf_b6RWgzQ@mail.gmail.com>
 <CAGZ79kYstN9ATPGKZjnk-hJ6jRsx9Oz0b2hQ5cTiqVqMNDCsyA@mail.gmail.com>
 <CABPp-BHkLLrJDTQwHTYpqC0Cg7Wv_wDr14Fq_LXneg+OzzRngg@mail.gmail.com>
 <20180207132157.GB16018@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180207132157.GB16018@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Feb 07, 2018 at 08:21:57AM -0500, Jeff King wrote:

> The best PSA for this particular bug may be "try pruning the worktrees":
> 
>   $ git worktree prune -v
>   Removing worktrees/foo: gitdir file points to non-existent location
> 
>   $ git prune; echo $?
>   0

Sorry, I just read Stefan's response and not your original before
responding. I see that you did try that. So IMHO that's a separate bug
that "worktree prune" did not do the right thing for your particular
case.

-Peff
