Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 43A1920248
	for <e@80x24.org>; Sun,  3 Mar 2019 16:54:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726423AbfCCQyu (ORCPT <rfc822;e@80x24.org>);
        Sun, 3 Mar 2019 11:54:50 -0500
Received: from cloud.peff.net ([104.130.231.41]:36516 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726382AbfCCQyt (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 3 Mar 2019 11:54:49 -0500
Received: (qmail 13193 invoked by uid 109); 3 Mar 2019 16:54:49 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Sun, 03 Mar 2019 16:54:49 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 16291 invoked by uid 111); 3 Mar 2019 16:55:05 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Sun, 03 Mar 2019 11:55:05 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 03 Mar 2019 11:54:47 -0500
Date:   Sun, 3 Mar 2019 11:54:47 -0500
From:   Jeff King <peff@peff.net>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Junio C Hamano <gitster@pobox.com>,
        SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>,
        Git mailing list <git@vger.kernel.org>,
        Clemens Buchacher <drizzd@gmx.net>
Subject: Re: t5570-git-daemon fails with SIGPIPE on OSX
Message-ID: <20190303165447.GA31116@sigill.intra.peff.net>
References: <CAM0VKj=MCS+cmOgzf_XyPeb+qZrFmuMH52-PV_NDMZA9X+rRoA@mail.gmail.com>
 <20180814223246.GA2379@sigill.intra.peff.net>
 <nycvar.QRO.7.76.6.1902080958190.41@tvgsbejvaqbjf.bet>
 <nycvar.QRO.7.76.6.1902081024550.41@tvgsbejvaqbjf.bet>
 <20190208195459.GA32556@sigill.intra.peff.net>
 <nycvar.QRO.7.76.6.1903011557430.41@tvgsbejvaqbjf.bet>
 <20190301190042.GF30847@sigill.intra.peff.net>
 <nycvar.QRO.7.76.6.1903022209110.45@tvgsbejvaqbjf.bet>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <nycvar.QRO.7.76.6.1903022209110.45@tvgsbejvaqbjf.bet>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Mar 02, 2019 at 10:21:00PM +0100, Johannes Schindelin wrote:

> Do you want to turn these two patches into a proper patch series?
> Otherwise I can take care of it, probably this Monday or Tuesday.

Here they are. The old email sending the first one actually had a typo
(it sent "0000" instead of "0001" for some packets; oops), which is
fixed here.

I'm actually not sure of the placement for the second one; see the
comments there.

  [1/2]: fetch: avoid calling write_or_die()
  [2/2]: fetch: ignore SIGPIPE during network operation

 builtin/fetch.c | 2 ++
 fetch-pack.c    | 9 ++++++---
 pkt-line.c      | 6 ++++--
 3 files changed, 12 insertions(+), 5 deletions(-)

-Peff
