Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 861082021E
	for <e@80x24.org>; Fri, 11 Nov 2016 09:31:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755723AbcKKJbZ (ORCPT <rfc822;e@80x24.org>);
        Fri, 11 Nov 2016 04:31:25 -0500
Received: from cloud.peff.net ([104.130.231.41]:41691 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752306AbcKKJbZ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Nov 2016 04:31:25 -0500
Received: (qmail 23455 invoked by uid 109); 11 Nov 2016 09:31:24 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 11 Nov 2016 09:31:24 +0000
Received: (qmail 12825 invoked by uid 111); 11 Nov 2016 09:31:53 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 11 Nov 2016 04:31:53 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 11 Nov 2016 04:31:22 -0500
Date:   Fri, 11 Nov 2016 04:31:22 -0500
From:   Jeff King <peff@peff.net>
To:     Lars Schneider <larsxschneider@gmail.com>
Cc:     Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
        git <git@vger.kernel.org>, me@ttaylorr.com
Subject: Re: [RFC] Add way to make Git credentials accessible from
 clean/smudge filter
Message-ID: <20161111093122.osbdwmze5x5t742v@sigill.intra.peff.net>
References: <4C8C5650-7221-4F62-A9CC-81AE01EF6DC7@gmail.com>
 <vpqoa1n1qom.fsf@anie.imag.fr>
 <20161110160809.2gvf67rlnvounulf@sigill.intra.peff.net>
 <77603924-3552-4146-9C9E-A106CFA96D7A@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <77603924-3552-4146-9C9E-A106CFA96D7A@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Nov 11, 2016 at 10:28:56AM +0100, Lars Schneider wrote:

> > Yeah, that is the solution I was going to suggest. The credentials are
> > totally orthogonal to the filters, and I would rather not shove them
> > into the protocol. It's an extra process, but with the new multi-use
> > smudge filter, it's one per git invocation, not one per file.
> 
> The trouble with "git credential" is that it works only if the credential 
> helper is setup correctly. Although I assume that most people have setup this, 
> I have also worked with a number of people who prefer to enter their passwords 
> every time Git makes a network connection.

Are you sure about that? If I do:

  echo url=https://example.com/repo.git |
  git credential fill

I get prompted for a username and password.

-Peff
