Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D57C0201B0
	for <e@80x24.org>; Sun, 26 Feb 2017 00:48:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751864AbdBZArB (ORCPT <rfc822;e@80x24.org>);
        Sat, 25 Feb 2017 19:47:01 -0500
Received: from cloud.peff.net ([104.130.231.41]:34260 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751434AbdBZArA (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 25 Feb 2017 19:47:00 -0500
Received: (qmail 20813 invoked by uid 109); 26 Feb 2017 00:46:59 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Sun, 26 Feb 2017 00:46:59 +0000
Received: (qmail 19663 invoked by uid 111); 26 Feb 2017 00:47:04 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Sat, 25 Feb 2017 19:47:04 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 25 Feb 2017 19:46:57 -0500
Date:   Sat, 25 Feb 2017 19:46:57 -0500
From:   Jeff King <peff@peff.net>
To:     Lars Schneider <larsxschneider@gmail.com>
Cc:     Jakub =?utf-8?B?TmFyxJlic2tp?= <jnareb@gmail.com>,
        Joey Hess <id@joeyh.name>, git@vger.kernel.org
Subject: Re: SHA1 collisions found
Message-ID: <20170226004657.zowlojdzqrrcalsm@sigill.intra.peff.net>
References: <20170223164306.spg2avxzukkggrpb@kitenet.net>
 <9cedbfa5-4095-15d8-639c-0e3b9b98d6b9@gmail.com>
 <20170224230604.nt37uw5y3uehukfd@sigill.intra.peff.net>
 <D74A82FF-BF00-481F-9B2A-4AF8EF3D062F@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <D74A82FF-BF00-481F-9B2A-4AF8EF3D062F@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Feb 25, 2017 at 11:35:27PM +0100, Lars Schneider wrote:

> > So we don't actually know how Git would behave in the face of a SHA-1
> > collision. It would be pretty easy to simulate it with something like:
> [...]
> 
> That's a good idea! I wonder if it would make sense to setup an 
> additional job in TravisCI that patches every Git version with some hash 
> collisions and then runs special tests. This way we could ensure Git 
> behaves reasonable in case of a collision. E.g. by printing errors and 
> not crashing or corrupting the repo. Do you think that would be worth 
> the effort?

I think it would be interesting to see the results under various
scenarios. I don't know that it would be all that interesting from an
ongoing CI perspective. But we wouldn't know until somebody actually
writes the tests and we see what they do.

-Peff
