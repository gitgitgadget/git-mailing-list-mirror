Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 414841F4DD
	for <e@80x24.org>; Wed, 23 Aug 2017 21:43:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751197AbdHWVnx (ORCPT <rfc822;e@80x24.org>);
        Wed, 23 Aug 2017 17:43:53 -0400
Received: from cloud.peff.net ([104.130.231.41]:47322 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751104AbdHWVnw (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Aug 2017 17:43:52 -0400
Received: (qmail 30443 invoked by uid 109); 23 Aug 2017 21:43:52 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 23 Aug 2017 21:43:52 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 5086 invoked by uid 111); 23 Aug 2017 21:44:20 -0000
Received: from Unknown (HELO sigill.intra.peff.net) (10.0.1.3)
 by peff.net (qpsmtpd/0.94) with SMTP; Wed, 23 Aug 2017 17:44:20 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 23 Aug 2017 17:43:49 -0400
Date:   Wed, 23 Aug 2017 17:43:49 -0400
From:   Jeff King <peff@peff.net>
To:     Nicolas Morey-Chaisemartin <NMoreyChaisemartin@suse.de>
Cc:     Nicolas Morey-Chaisemartin <nicolas@morey-chaisemartin.com>,
        git@vger.kernel.org
Subject: Re: [RFC 0/3] imap-send curl tunnelling support
Message-ID: <20170823214349.k4ayl2urqepch7p4@sigill.intra.peff.net>
References: <ab866314-608b-eaca-b335-12cffe165526@morey-chaisemartin.com>
 <20170816083432.rgurgckch6phcul3@sigill.intra.peff.net>
 <0beb0a6c-acb3-ae24-5c52-95747f74c07f@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <0beb0a6c-acb3-ae24-5c52-95747f74c07f@suse.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Aug 21, 2017 at 09:34:19AM +0200, Nicolas Morey-Chaisemartin wrote:

> >> It appears curl do not support the PREAUTH tag.
> > Too bad. IMHO preauth is the main reason to use a tunnel in the first
> > place.
> 
> It shouldn't be too hard to add support for this in curl.
> If it's the main usecase, it'll simply means the curl tunnelling
> should be disabled by default for older curl (in this case, meaning
> every version until it gets supported) versions.

Yes, I agree. I was hoping when we started this discussion that we were
more ready to switch to curl-by-default. But sadly, that isn't close to
being the case. But hopefully we can at least end up with logic that
lets us use it in the easy cases (no tunneling) and falls back in the
harder ones.

-Peff
