Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0DE062047F
	for <e@80x24.org>; Thu, 28 Sep 2017 05:20:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751107AbdI1FUq (ORCPT <rfc822;e@80x24.org>);
        Thu, 28 Sep 2017 01:20:46 -0400
Received: from cloud.peff.net ([104.130.231.41]:53122 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751046AbdI1FUq (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Sep 2017 01:20:46 -0400
Received: (qmail 20775 invoked by uid 109); 28 Sep 2017 05:20:46 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 28 Sep 2017 05:20:46 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 23301 invoked by uid 111); 28 Sep 2017 05:21:25 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Thu, 28 Sep 2017 01:21:25 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 28 Sep 2017 01:20:44 -0400
Date:   Thu, 28 Sep 2017 01:20:44 -0400
From:   Jeff King <peff@peff.net>
To:     Toni Uebernickel <tuebernickel@gmail.com>
Cc:     Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org
Subject: Re: Updated to v2.14.2 on macOS; git add --patch broken
Message-ID: <20170928052043.vh5wyecibe3cujwp@sigill.intra.peff.net>
References: <86D0A377-8AFD-460D-A90E-6327C6934DFC@gmail.com>
 <20170927170716.slqxje2tkh5ws5ak@sigill.intra.peff.net>
 <38D148EC-B77D-426E-A7E0-128509590407@gmail.com>
 <20170927180127.khwqwmv74tsji5im@sigill.intra.peff.net>
 <20170927195159.GE19555@aiede.mtv.corp.google.com>
 <20170927195310.GF19555@aiede.mtv.corp.google.com>
 <21387D23-F581-4179-969E-823FEF82C405@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <21387D23-F581-4179-969E-823FEF82C405@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Sep 28, 2017 at 07:03:55AM +0200, Toni Uebernickel wrote:

> color.ui=always

This is the problem, and Jonathan's guess was correct that 136c8c8b8f
(color: check color.ui in git_default_config(), 2017-07-13) is related.

Re-reading that commit message, I'm inclined to say that the commit
isn't wrong, and that setting color.ui to "always" has always been a bad
idea. Of course, I also wrote that commit message, so I may be biased. :)

What led you to setting color.ui to "always" in your config?  The more
usual value is "auto" (which is also the default these days).

-Peff
