Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D54A31F461
	for <e@80x24.org>; Thu, 18 Jul 2019 21:43:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728020AbfGRVn1 (ORCPT <rfc822;e@80x24.org>);
        Thu, 18 Jul 2019 17:43:27 -0400
Received: from cloud.peff.net ([104.130.231.41]:39810 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1727780AbfGRVn1 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Jul 2019 17:43:27 -0400
Received: (qmail 30606 invoked by uid 109); 18 Jul 2019 21:43:27 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 18 Jul 2019 21:43:27 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 21445 invoked by uid 111); 18 Jul 2019 21:44:24 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Thu, 18 Jul 2019 17:44:24 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 18 Jul 2019 17:43:25 -0400
Date:   Thu, 18 Jul 2019 17:43:25 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org,
        Ulrich Windl <Ulrich.Windl@rz.uni-regensburg.de>
Subject: Re: [PATCH] rm: resolving by removal is not a warning-worthy event
Message-ID: <20190718214325.GA28619@sigill.intra.peff.net>
References: <5D2ED50D020000A100032435@gwsmtp.uni-regensburg.de>
 <xmqqd0i81ui4.fsf@gitster-ct.c.googlers.com>
 <xmqqims0z99w.fsf_-_@gitster-ct.c.googlers.com>
 <20190718202656.GC22038@sigill.intra.peff.net>
 <xmqq8ssvxd9w.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq8ssvxd9w.fsf@gitster-ct.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jul 18, 2019 at 02:07:23PM -0700, Junio C Hamano wrote:

> >> +	git rm qfwfq >msg &&
> >> +	test_i18ngrep ! "needs merge" msg &&
> >
> > Should we capture stderr from "git rm", too, to cover all bases?
> 
> Do you mean
> 
> 	git rm blob >msg 2>&1
> 
> because we could later change our mind and send "needs merge"
> message to the standard error stream?

Yes, exactly.

-Peff
