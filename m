Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 318691F4F8
	for <e@80x24.org>; Fri, 14 Oct 2016 19:18:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756521AbcJNTSi (ORCPT <rfc822;e@80x24.org>);
        Fri, 14 Oct 2016 15:18:38 -0400
Received: from cloud.peff.net ([104.130.231.41]:57623 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753627AbcJNTSa (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Oct 2016 15:18:30 -0400
Received: (qmail 23502 invoked by uid 109); 14 Oct 2016 19:18:29 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 14 Oct 2016 19:18:29 +0000
Received: (qmail 8224 invoked by uid 111); 14 Oct 2016 19:18:49 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 14 Oct 2016 15:18:49 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 14 Oct 2016 15:18:27 -0400
Date:   Fri, 14 Oct 2016 15:18:27 -0400
From:   Jeff King <peff@peff.net>
To:     Daniel Lopez <dlopez@csscorporate.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        Francisco Carreira <fcarreira@csscorporate.com>
Subject: Re: Change Default merge strategy options
Message-ID: <20161014191827.qf43nk3bum7gy4dj@sigill.intra.peff.net>
References: <HE1PR0101MB2187D29367CB67F42373647CBDDC0@HE1PR0101MB2187.eurprd01.prod.exchangelabs.com>
 <HE1PR0101MB218771966DAC7634B9735634BDDC0@HE1PR0101MB2187.eurprd01.prod.exchangelabs.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <HE1PR0101MB218771966DAC7634B9735634BDDC0@HE1PR0101MB2187.eurprd01.prod.exchangelabs.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Oct 13, 2016 at 03:57:55PM +0000, Daniel Lopez wrote:

> How to use 'git config --global' to set default strategy like
> recursive.

I don't think there is a way to do so, though note that the default
strategy is already "recursive". You can set individual file merge
drivers with gitattributes, but I don't know of a way to set the overall
strategy.

> Example:
> Currently , when we want to enforce a specific strategic we need to
> include  its reference on the command line : 
> git.exe merge --strategy=recursive --strategy-option=ignore-all-space dev-local

Some strategy options have their own config already (like
merge.renormalize). I guess in theory we could grow config options for
the other ones, though I think config for "strategy and its options"
might be more elegant.

-Peff
