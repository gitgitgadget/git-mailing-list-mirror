Return-Path: <SRS0=+hCi=DN=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97969C4363D
	for <git@archiver.kernel.org>; Tue,  6 Oct 2020 14:02:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4AE5520760
	for <git@archiver.kernel.org>; Tue,  6 Oct 2020 14:02:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726096AbgJFOCA (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 6 Oct 2020 10:02:00 -0400
Received: from cloud.peff.net ([104.130.231.41]:50782 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725902AbgJFOB7 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Oct 2020 10:01:59 -0400
Received: (qmail 7520 invoked by uid 109); 6 Oct 2020 14:01:59 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 06 Oct 2020 14:01:59 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 29518 invoked by uid 111); 6 Oct 2020 14:01:58 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 06 Oct 2020 10:01:58 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 6 Oct 2020 10:01:58 -0400
From:   Jeff King <peff@peff.net>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH 5/7] t0060: test obscured .gitattributes and .gitignore
 matching
Message-ID: <20201006140158.GA6601@coredump.intra.peff.net>
References: <20201005071751.GA2290770@coredump.intra.peff.net>
 <20201005072102.GE2291074@coredump.intra.peff.net>
 <20201005080353.GH1166820@google.com>
 <20201005084051.GD2862927@coredump.intra.peff.net>
 <nycvar.QRO.7.76.6.2010052306470.50@tvgsbejvaqbjf.bet>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <nycvar.QRO.7.76.6.2010052306470.50@tvgsbejvaqbjf.bet>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Oct 05, 2020 at 11:20:48PM +0200, Johannes Schindelin wrote:

> > > > Note that the ntfs magic prefix names in the tests come from the
> > > > algorithm described in e7cb0b4455 (and are different for each file).
> > >
> > > Doesn't block this patch, but I'm curious: how hard would it be to make
> > > a test with an NTFS prerequisite that makes sure we got the magic prefix
> > > right?
> >
> > I suspect hard since Dscho punted on it in the original series. :) If I
> > understand correctly, it would require having an NTFS filesystem, and
> > generating 10,000+ files with a clashing prefix.
> 
> It's not quite _as_ bad: you only need to generate 4 files with a clashing
> prefix and then the real one:

Ah, that really isn't that bad, then. Still, I don't mind leaving this
as-is under the notion that if the algorithm does change, it would
likely make it onto your radar anyway (or the radar of _anybody_ who
would raise the issue).

-Peff
