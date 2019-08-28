Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AB79E1F461
	for <e@80x24.org>; Wed, 28 Aug 2019 10:24:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726898AbfH1KYg (ORCPT <rfc822;e@80x24.org>);
        Wed, 28 Aug 2019 06:24:36 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:48155 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726763AbfH1KYX (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Aug 2019 06:24:23 -0400
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1i2v7j-0004V0-Aw; Wed, 28 Aug 2019 12:24:19 +0200
Received: from ukl by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1i2v7h-00006o-SA; Wed, 28 Aug 2019 12:24:17 +0200
Date:   Wed, 28 Aug 2019 12:24:17 +0200
From:   Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Bryan Turner <bturner@atlassian.com>
Cc:     Jeff King <peff@peff.net>,
        SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder.dev@gmail.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Git Users <git@vger.kernel.org>, entwicklung@pengutronix.de
Subject: Re: git slow unless piped to cat
Message-ID: <20190828102417.un2hjuizfmu3n7ya@pengutronix.de>
References: <20190827081559.mt5wjpdvqzn62dib@pengutronix.de>
 <20190827084111.GU20404@szeder.dev>
 <20190827085637.g6cpnuofpteyfqfz@pengutronix.de>
 <1566897126.4102.5.camel@pengutronix.de>
 <20190827094407.GV20404@szeder.dev>
 <20190827100427.u3a5uvmylm5vddn2@pengutronix.de>
 <20190827185929.GA3150@sigill.intra.peff.net>
 <20190827213248.kzpszutt46ipboq4@pengutronix.de>
 <CAGyf7-EaumF+oZFUhNtifrCvqBr1DjcFh8rgQMswcpwip3Bx7w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAGyf7-EaumF+oZFUhNtifrCvqBr1DjcFh8rgQMswcpwip3Bx7w@mail.gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello,

On Tue, Aug 27, 2019 at 02:38:57PM -0700, Bryan Turner wrote:
> On Tue, Aug 27, 2019 at 2:32 PM Uwe Kleine-König
> <u.kleine-koenig@pengutronix.de> wrote:
> >
> > On Tue, Aug 27, 2019 at 02:59:30PM -0400, Jeff King wrote:
> > > On Tue, Aug 27, 2019 at 12:04:27PM +0200, Uwe Kleine-König wrote:
> > >
> > > to see the loose ones. If there are a lot, try:
> > >
> > >   git pack-refs --prune --all
> > >
> > > (or just "git gc", which does this).
> >
> > This is a daily updated mirror that is also incrementally backed up. I
> > repack from time to time, but hesitate to do this regularily as each
> > time I repack the next backup run is "expensive" and I get many small
> > packs. I did this now anyhow.
> 
> Just noting that Jeff didn't suggest a repack; he suggested a
> pack-refs. This should have little, if any impact on your backup
> processing, because all it's going to do is rewrite the "packed-refs"
> file and delete loose refs. It doesn't modify any files under objects/
> at all.

Ah, right. That also explains why I still had a few loose objects. I
cut-n-pasted the command, so I did as suggested, just thought it was
something different.

Thanks
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
