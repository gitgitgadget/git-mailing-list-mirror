Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4F56820954
	for <e@80x24.org>; Wed, 22 Nov 2017 23:39:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751525AbdKVXjI (ORCPT <rfc822;e@80x24.org>);
        Wed, 22 Nov 2017 18:39:08 -0500
Received: from cloud.peff.net ([104.130.231.41]:38196 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751507AbdKVXjH (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Nov 2017 18:39:07 -0500
Received: (qmail 7784 invoked by uid 109); 22 Nov 2017 23:39:07 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 22 Nov 2017 23:39:07 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 5782 invoked by uid 111); 22 Nov 2017 23:39:23 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with ESMTPA; Wed, 22 Nov 2017 18:39:23 -0500
Authentication-Results: peff.net; auth=pass (cram-md5) smtp.auth=relayok
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 22 Nov 2017 18:39:05 -0500
Date:   Wed, 22 Nov 2017 18:39:05 -0500
From:   Jeff King <peff@peff.net>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     Stefan Beller <sbeller@google.com>, git@vger.kernel.org,
        git@jeffhostetler.com
Subject: Re: [PATCH 0/3] Introduce BUG_ON(cond, msg) MACRO
Message-ID: <20171122233905.GC8577@sigill>
References: <20171122223827.26773-1-sbeller@google.com>
 <20171122232457.GA8577@sigill>
 <20171122232814.GH11671@aiede.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20171122232814.GH11671@aiede.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Nov 22, 2017 at 03:28:14PM -0800, Jonathan Nieder wrote:

> > I do like human readable messages. But sometimes such a message just
> > makes the code harder to read (and to write). E.g., is there any real
> > value in:
> >
> >   BUG_ON(!foo, "called bar() with a foo!");
> >
> > over:
> >
> >   assert(foo);
> 
> I think you're hinting at wanting
> 
> 	BUG_ON(!foo);
> 
> which is something that the Linux kernel has (and which is not done in
> this series).

Yes. I'd be fine having a single-argument BUG_ON() like that. But then,
I'm not sure what it's buying us over assert().

I get why the kernel cannot use the default "dump core and exit"
behavior of assert(), but that's basically what our BUG() does.

-Peff
