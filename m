Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 417722036B
	for <e@80x24.org>; Wed,  4 Oct 2017 05:27:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751215AbdJDF1j (ORCPT <rfc822;e@80x24.org>);
        Wed, 4 Oct 2017 01:27:39 -0400
Received: from cloud.peff.net ([104.130.231.41]:60050 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1750909AbdJDF1i (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 4 Oct 2017 01:27:38 -0400
Received: (qmail 9385 invoked by uid 109); 4 Oct 2017 05:27:39 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 04 Oct 2017 05:27:39 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 14963 invoked by uid 111); 4 Oct 2017 05:27:38 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Wed, 04 Oct 2017 01:27:38 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 04 Oct 2017 01:27:36 -0400
Date:   Wed, 4 Oct 2017 01:27:36 -0400
From:   Jeff King <peff@peff.net>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     Stefan Beller <sbeller@google.com>, git@vger.kernel.org,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] strbuf doc: reuse after strbuf_release is fine
Message-ID: <20171004052736.i3vykavpbcfcztfr@sigill.intra.peff.net>
References: <20171003214646.GZ19555@aiede.mtv.corp.google.com>
 <20171003221740.26325-1-sbeller@google.com>
 <20171003222414.GC19555@aiede.mtv.corp.google.com>
 <20171003234919.qsr54ncmw6cihowi@sigill.intra.peff.net>
 <20171004023954.GK19555@aiede.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20171004023954.GK19555@aiede.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Oct 03, 2017 at 07:39:54PM -0700, Jonathan Nieder wrote:

> > I think it's actually OK to use the string buffer after this function.
> > It's just an empty string.
> >
> > Perhaps we should be more explicit: this releases any resources and
> > resets to a pristine, empty state. I suspect strbuf_detach() probably
> > should make the same claim.
> 
> Like this?

Yes, perfect. Thanks!

-Peff
