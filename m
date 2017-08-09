Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8F8F7208B8
	for <e@80x24.org>; Wed,  9 Aug 2017 21:15:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752168AbdHIVPY (ORCPT <rfc822;e@80x24.org>);
        Wed, 9 Aug 2017 17:15:24 -0400
Received: from cloud.peff.net ([104.130.231.41]:33822 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751884AbdHIVPX (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Aug 2017 17:15:23 -0400
Received: (qmail 28221 invoked by uid 109); 9 Aug 2017 21:15:23 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 09 Aug 2017 21:15:23 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 31246 invoked by uid 111); 9 Aug 2017 21:15:46 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Wed, 09 Aug 2017 17:15:46 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 09 Aug 2017 17:15:21 -0400
Date:   Wed, 9 Aug 2017 17:15:21 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 2/4] http: drop support for curl < 7.16.0
Message-ID: <20170809211520.djwrqds5b2yzmix5@sigill.intra.peff.net>
References: <20170809120024.7phdjzjv54uv5dpz@sigill.intra.peff.net>
 <20170809120157.il4ktf75wscqoyic@sigill.intra.peff.net>
 <xmqq1sok7i82.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq1sok7i82.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Aug 09, 2017 at 10:40:13AM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > -#if LIBCURL_VERSION_NUM >= 0x071700
> > -/* Use CURLOPT_KEYPASSWD as is */
> > -#elif LIBCURL_VERSION_NUM >= 0x070903
> > -#define CURLOPT_KEYPASSWD CURLOPT_SSLKEYPASSWD
> > -#else
> > -#define CURLOPT_KEYPASSWD CURLOPT_SSLCERTPASSWD
> > -#endif
> > -
> 
> This part I am not sure.  Don't we still need to substitute
> CURLOPT_KEYPASSWD with CURLOPT_SSLKEYPASSWD for versions below
> 071700, e.g. 071000 which is 7.16.0?

Yeah, you're right. I'm not sure how I botched that.

Thanks for reading carefully. I'll fix it in a re-roll.

-Peff
