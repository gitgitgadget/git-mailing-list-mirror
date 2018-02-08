Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1A70F1F404
	for <e@80x24.org>; Thu,  8 Feb 2018 18:58:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752058AbeBHS6p (ORCPT <rfc822;e@80x24.org>);
        Thu, 8 Feb 2018 13:58:45 -0500
Received: from cloud.peff.net ([104.130.231.41]:45538 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1752028AbeBHS6o (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Feb 2018 13:58:44 -0500
Received: (qmail 32084 invoked by uid 109); 8 Feb 2018 18:58:44 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 08 Feb 2018 18:58:44 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 13313 invoked by uid 111); 8 Feb 2018 18:59:27 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Thu, 08 Feb 2018 13:59:27 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 08 Feb 2018 13:58:42 -0500
Date:   Thu, 8 Feb 2018 13:58:42 -0500
From:   Jeff King <peff@peff.net>
To:     Jon Simons <jon@jonsimons.org>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 2/2] always check for NULL return from packet_read_line()
Message-ID: <20180208185842.GA1814@sigill.intra.peff.net>
References: <1518115670-2646-1-git-send-email-jon@jonsimons.org>
 <1518115670-2646-3-git-send-email-jon@jonsimons.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1518115670-2646-3-git-send-email-jon@jonsimons.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Feb 08, 2018 at 01:47:50PM -0500, Jon Simons wrote:

> The packet_read_line() function will die if it sees any
> protocol or socket errors. But it will return NULL for a
> flush packet; some callers which are not expecting this may
> dereference NULL if they get an unexpected flush. This would
> involve the other side breaking protocol, but we should
> flag the error rather than segfault.

As one might guess from the dual authorship on this series, Jon and I
discussed these off list. So this one is

  Reviewed-by: Jeff King <peff@peff.net>

And the other one, too, but I'm not sure that carries any weight. :)

-Peff
