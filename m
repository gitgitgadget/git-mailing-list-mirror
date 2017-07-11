Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 58C9920357
	for <e@80x24.org>; Tue, 11 Jul 2017 10:44:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755558AbdGKKoH (ORCPT <rfc822;e@80x24.org>);
        Tue, 11 Jul 2017 06:44:07 -0400
Received: from cloud.peff.net ([104.130.231.41]:36846 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1755421AbdGKKoH (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Jul 2017 06:44:07 -0400
Received: (qmail 3218 invoked by uid 109); 11 Jul 2017 10:44:06 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 11 Jul 2017 10:44:06 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 15191 invoked by uid 111); 11 Jul 2017 10:44:18 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Tue, 11 Jul 2017 06:44:18 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 11 Jul 2017 06:44:04 -0400
Date:   Tue, 11 Jul 2017 06:44:04 -0400
From:   Jeff King <peff@peff.net>
To:     Martin =?utf-8?B?w4VncmVu?= <martin.agren@gmail.com>
Cc:     git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Brandon Williams <bmwill@google.com>
Subject: Re: [PATCH 7/7] tag: make git tag -l use pager by default
Message-ID: <20170711104404.5shbsptdbzcujwj7@sigill.intra.peff.net>
References: <cover.1499723297.git.martin.agren@gmail.com>
 <e893a0b87b14143af6fc162d1acb21012523af69.1499723297.git.martin.agren@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e893a0b87b14143af6fc162d1acb21012523af69.1499723297.git.martin.agren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jul 10, 2017 at 11:55:20PM +0200, Martin Ågren wrote:

> The previous patch introduced `pager.tag.list`. Its default was to use
> the value of `pager.tag` or, if that was also not set, to fall back to
> "off".
> 
> Change that fallback value to "on". Let the default value for
> `pager.tag` remain at "off". Update documentation and tests.

Thanks for splitting this out. The default setting is definitely
orthogonal to allowing the config.

I've been running with this default for several years now (using the
patch I showed in the earlier thread you linked). It _does_ occasionally
annoy me, but I think overall it's an improvement. So it seems like a
good thing to try, and we can see how people respond as they try it out.

-Peff
