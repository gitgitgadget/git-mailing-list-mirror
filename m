Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CF4B720323
	for <e@80x24.org>; Fri, 17 Mar 2017 00:21:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752179AbdCQAVo (ORCPT <rfc822;e@80x24.org>);
        Thu, 16 Mar 2017 20:21:44 -0400
Received: from cloud.peff.net ([104.130.231.41]:45579 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751483AbdCQAVn (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Mar 2017 20:21:43 -0400
Received: (qmail 12448 invoked by uid 109); 17 Mar 2017 00:14:20 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 17 Mar 2017 00:14:20 +0000
Received: (qmail 1081 invoked by uid 111); 17 Mar 2017 00:14:31 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 16 Mar 2017 20:14:31 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 16 Mar 2017 20:14:16 -0400
Date:   Thu, 16 Mar 2017 20:14:16 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH 0/2] Re-integrate sha1dc
Message-ID: <20170317001416.bthqvjbf554zhrj5@sigill.intra.peff.net>
References: <alpine.LFD.2.20.1703161315310.18484@i7.lan>
 <20170316220456.m4yz2kbvzv6waokn@sigill.intra.peff.net>
 <20170316221044.ij5yuifmohktn6cl@sigill.intra.peff.net>
 <xmqq37ecc134.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq37ecc134.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Mar 16, 2017 at 03:23:59PM -0700, Junio C Hamano wrote:

> I am wondering if we should queue another one for .travis.yml on top
> to force use of USE_SHA1DC=YesPlease during the tests.  I expect
> that we'd be encouraging its use for ordinary users without any
> specific needs in the release notes in 2.13 release.

I don't think it would buy us much. There's not really any way for this
build to interact with the rest of the code in any interesting way, so
either it works as a SHA-1 implementation or it doesn't. If you just
want it exercised, I'll say that it's powering all of github.com right
now.

I did wonder if we should ship with it as the default (instead of
openssl). It's definitely slower, but maybe widespread safety is a good
thing. OTOH, I think we have a fair bit of time before we see any
real-life collisions, just given the time and expense of generating
them.

-Peff
