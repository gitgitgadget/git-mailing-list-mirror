Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A693D1F405
	for <e@80x24.org>; Thu, 20 Dec 2018 20:13:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732338AbeLTUM7 (ORCPT <rfc822;e@80x24.org>);
        Thu, 20 Dec 2018 15:12:59 -0500
Received: from cloud.peff.net ([104.130.231.41]:47438 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1728835AbeLTUM7 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Dec 2018 15:12:59 -0500
Received: (qmail 14808 invoked by uid 109); 20 Dec 2018 20:12:59 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 20 Dec 2018 20:12:59 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 4691 invoked by uid 111); 20 Dec 2018 20:11:20 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Thu, 20 Dec 2018 15:11:20 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 20 Dec 2018 15:11:46 -0500
Date:   Thu, 20 Dec 2018 15:11:46 -0500
From:   Jeff King <peff@peff.net>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     git@vger.kernel.org, gitster@pobox.com, stolee@gmail.com,
        avarab@gmail.com, szeder.dev@gmail.com
Subject: Re: [PATCH v4 0/3] Add commit-graph fuzzer and fix buffer overflow
Message-ID: <20181220201145.GA11002@sigill.intra.peff.net>
References: <cover.1544048946.git.steadmon@google.com>
 <cover.1544729841.git.steadmon@google.com>
 <20181218173539.GA31070@sigill.intra.peff.net>
 <20181218210551.GG37614@google.com>
 <20181219155107.GD14802@sigill.intra.peff.net>
 <nycvar.QRO.7.76.6.1812202034390.41@tvgsbejvaqbjf.bet>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <nycvar.QRO.7.76.6.1812202034390.41@tvgsbejvaqbjf.bet>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Dec 20, 2018 at 08:35:57PM +0100, Johannes Schindelin wrote:

> > I do wonder if we'll run into problems on Windows, though.
> 
> As long as we're talking about Unix shell scripts, /dev/zero should be
> fine, as we are essentially running in a variant of Cygwin.
> 
> If you try to pass /dev/zero as an argument to a Git command, that's an
> entirely different thing: this most likely won't work.

Thanks for confirming. We're talking about passing it to dd here, so I
think it should be OK.

-Peff
