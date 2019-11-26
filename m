Return-Path: <SRS0=BbQ7=ZS=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 050BBC432C3
	for <git@archiver.kernel.org>; Tue, 26 Nov 2019 22:40:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C5FFF20722
	for <git@archiver.kernel.org>; Tue, 26 Nov 2019 22:40:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726876AbfKZWkp (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 26 Nov 2019 17:40:45 -0500
Received: from dcvr.yhbt.net ([64.71.152.64]:54050 "EHLO dcvr.yhbt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726232AbfKZWkp (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Nov 2019 17:40:45 -0500
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
        by dcvr.yhbt.net (Postfix) with ESMTP id 197EA1F463;
        Tue, 26 Nov 2019 22:40:45 +0000 (UTC)
Date:   Tue, 26 Nov 2019 22:40:44 +0000
From:   Eric Wong <e@80x24.org>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Jeff King <peff@peff.net>, Emily Shaffer <emilyshaffer@google.com>,
        git@vger.kernel.org
Subject: Re: GitGitGadget on git/git, was Re: Should we auto-close PRs on
 git/git?
Message-ID: <20191126224044.GA13328@dcvr>
References: <nycvar.QRO.7.76.6.1911131234380.46@tvgsbejvaqbjf.bet>
 <20191114074117.GB17186@sigill.intra.peff.net>
 <nycvar.QRO.7.76.6.1911142354290.46@tvgsbejvaqbjf.bet>
 <nycvar.QRO.7.76.6.1911181930290.46@tvgsbejvaqbjf.bet>
 <20191121105414.GA16238@sigill.intra.peff.net>
 <nycvar.QRO.7.76.6.1911221430510.31080@tvgsbejvaqbjf.bet>
 <20191125143023.GF494@sigill.intra.peff.net>
 <nycvar.QRO.7.76.6.1911262151590.31080@tvgsbejvaqbjf.bet>
 <20191126215648.GA18872@dcvr>
 <nycvar.QRO.7.76.6.1911262322130.31080@tvgsbejvaqbjf.bet>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <nycvar.QRO.7.76.6.1911262322130.31080@tvgsbejvaqbjf.bet>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> On Tue, 26 Nov 2019, Eric Wong wrote:
> > Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> > > The biggest obstacle is that at least one of those Pipelines requires
> > > access to a clone of public-inbox.org/git, and cloning that is rather
> > > expensive. Even a shallow fetch would be super expensive, by virtue of
> > > _all_ the mails being blobs reachable from the tip commit's tree.
> >
> > Fwiw, lore.kernel.org/git/$EPOCH.git ought to be somewhat cheaper,
> > but it's a different (more scalable) format which requires SQLite:
> >
> > 	https://public-inbox.org/public-inbox-v2-format.html
> 
> Is this incremental? GitGitGadget needs this to be incremental ;-)

Incremental as far as "git fetch" goes?  Of course :>
The "m" file is overwritten with every commit, so the tree size
stays at 1 (tree growth was a major scalability problem in v1).
