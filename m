Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 619F3206A3
	for <e@80x24.org>; Wed,  9 Nov 2016 15:31:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753182AbcKIPbc (ORCPT <rfc822;e@80x24.org>);
        Wed, 9 Nov 2016 10:31:32 -0500
Received: from cloud.peff.net ([104.130.231.41]:40715 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751847AbcKIPbb (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Nov 2016 10:31:31 -0500
Received: (qmail 31245 invoked by uid 109); 9 Nov 2016 15:31:30 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 09 Nov 2016 15:31:30 +0000
Received: (qmail 29706 invoked by uid 111); 9 Nov 2016 15:31:59 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 09 Nov 2016 10:31:59 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 09 Nov 2016 10:31:28 -0500
Date:   Wed, 9 Nov 2016 10:31:28 -0500
From:   Jeff King <peff@peff.net>
To:     Andreas Schwab <schwab@suse.de>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Johannes Sixt <j6t@kdbg.org>, git@vger.kernel.org
Subject: Re: [PATCH] t6026-merge-attr: don't fail if sleep exits early
Message-ID: <20161109153128.aqm2lgdntdlycnaq@sigill.intra.peff.net>
References: <mvmtwbhdhvb.fsf@hawking.suse.de>
 <20161108200543.7ivo3xoafdl4uw6h@sigill.intra.peff.net>
 <alpine.DEB.2.20.1611091437280.72596@virtualbox>
 <mvmzil8btzb.fsf@hawking.suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <mvmzil8btzb.fsf@hawking.suse.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Nov 09, 2016 at 03:36:40PM +0100, Andreas Schwab wrote:

> On Nov 09 2016, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> 
> > The reason why we do not ignore kill errors is that we want to make sure
> > that the script *actually ran*. Otherwise, the thing we need to test here
> > does not necessarily get tested.
> 
> That can be tested by looking for the pid file.

I agree that makes the intent a lot more obvious. Having a necessary
condition of the test stuffed into a test_when_finished block seems
counter-intuitive.

-Peff
