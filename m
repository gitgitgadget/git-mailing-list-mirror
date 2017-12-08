Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B1A101FC34
	for <e@80x24.org>; Fri,  8 Dec 2017 22:00:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752697AbdLHWAt (ORCPT <rfc822;e@80x24.org>);
        Fri, 8 Dec 2017 17:00:49 -0500
Received: from cloud.peff.net ([104.130.231.41]:52936 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1752289AbdLHWAs (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Dec 2017 17:00:48 -0500
Received: (qmail 31816 invoked by uid 109); 8 Dec 2017 22:00:48 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 08 Dec 2017 22:00:48 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 6638 invoked by uid 111); 8 Dec 2017 22:01:10 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with ESMTPA; Fri, 08 Dec 2017 17:01:10 -0500
Authentication-Results: peff.net; auth=pass (cram-md5) smtp.auth=relayok
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 08 Dec 2017 17:00:46 -0500
Date:   Fri, 8 Dec 2017 17:00:46 -0500
From:   Jeff King <peff@peff.net>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     git@vger.kernel.org, Lars Schneider <larsxschneider@gmail.com>,
        Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH v2 4/4] t/Makefile: introduce TEST_SHELL_PATH
Message-ID: <20171208220046.GA26270@sigill.intra.peff.net>
References: <20171208104647.GA4016@sigill.intra.peff.net>
 <20171208104722.GD4939@sigill.intra.peff.net>
 <alpine.DEB.2.21.1.1712081602570.4318@virtualbox>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1.1712081602570.4318@virtualbox>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Dec 08, 2017 at 04:08:19PM +0100, Johannes Schindelin wrote:

> > Yes, but test-lib.sh sources GIT-BUILD-OPTIONS, which we
> > built during the first "make". And that overrides the
> > environment, giving us the original SHELL_PATH again.
> 
> ... and we could simply see whether the environment variable
> TEST_SHELL_PATH (which we would set in t/Makefile from the passed-in
> SHELL_PATH) is set, and override it again.
> 
> I still think we can do without recording test-phase details in the
> build-phase (which may, or may not, know what the test-phase wants to do).
> 
> In other words, I believe that we can make the invocation you mentioned
> above work, by touching only t/Makefile (to pass SHELL_PATH as
> TEST_SHELL_PATH) and t/test-lib.sh (to override the SHELL_PATH from
> GIT-BUILD-OPTIONS with TEST_SHELL_PATH, if set).

We could do that, but it makes TEST_SHELL_PATH inconsistent with all of
the other config.mak variables.

-Peff
