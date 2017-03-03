Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3C57620133
	for <e@80x24.org>; Fri,  3 Mar 2017 12:23:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751323AbdCCMWN (ORCPT <rfc822;e@80x24.org>);
        Fri, 3 Mar 2017 07:22:13 -0500
Received: from cloud.peff.net ([104.130.231.41]:37980 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751278AbdCCMWM (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Mar 2017 07:22:12 -0500
Received: (qmail 612 invoked by uid 109); 3 Mar 2017 11:21:06 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 03 Mar 2017 11:21:06 +0000
Received: (qmail 27268 invoked by uid 111); 3 Mar 2017 11:21:13 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 03 Mar 2017 06:21:13 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 03 Mar 2017 06:21:04 -0500
Date:   Fri, 3 Mar 2017 06:21:04 -0500
From:   Jeff King <peff@peff.net>
To:     Sebastian Schuberth <sschuberth@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] Do not require Python for the git-remote-{bzr,hg}
 placeholder scripts
Message-ID: <20170303112104.2n3hu23sajpn2x2z@sigill.intra.peff.net>
References: <0102015a93d18443-c574aaf8-5656-49e8-8848-810e1fadc87a-000000@eu-west-1.amazonses.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <0102015a93d18443-c574aaf8-5656-49e8-8848-810e1fadc87a-000000@eu-west-1.amazonses.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Mar 03, 2017 at 10:57:46AM +0000, Sebastian Schuberth wrote:

> It does not make sense for these placeholder scripts to depend on Python
> just because the real scripts do. At the example of Git for Windows, we
> would not even be able to see those warnings as it does not ship with
> Python. So just use plain shell scripts instead.

Yeah, this seems like an obvious improvement. I think we got here
because the originals issued a warning but kept working, and then it was
slowly whittled down to remove the "working" part.

At some point these can probably go away. It's been 3 years since they
turned into nothing but warnings, so presumably most people have
upgraded by now (I know people often go a long time on old
distro-packaged versions, but the distro packagers would presumably
figure this out in the meantime).

OTOH, it is not really hurting much, so I do not mind keeping them
around for another 3 years (or more) just to catch any stragglers.

-Peff
