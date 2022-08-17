Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62BC9C25B0E
	for <git@archiver.kernel.org>; Wed, 17 Aug 2022 00:57:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238098AbiHQA5V (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 16 Aug 2022 20:57:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237942AbiHQA5T (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Aug 2022 20:57:19 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15A278A1FC
        for <git@vger.kernel.org>; Tue, 16 Aug 2022 17:57:17 -0700 (PDT)
Received: (qmail 5441 invoked by uid 109); 17 Aug 2022 00:57:17 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 17 Aug 2022 00:57:17 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 11726 invoked by uid 111); 17 Aug 2022 00:57:18 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 16 Aug 2022 20:57:18 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 16 Aug 2022 20:57:16 -0400
From:   Jeff King <peff@peff.net>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Taylor Blau <me@ttaylorr.com>, Junio C Hamano <gitster@pobox.com>,
        git@vger.kernel.org
Subject: Re: Coverity, was Re: What's cooking in git.git (Oct 2021, #02; Wed,
 6)
Message-ID: <Yvw87DJOOu+/jG6o@coredump.intra.peff.net>
References: <xmqqfstdr8b5.fsf@gitster.g>
 <YV5aaD418SyZqS/1@coredump.intra.peff.net>
 <YV5dmkkuCqAY2qqG@coredump.intra.peff.net>
 <YV5yi+AejPGO9qOi@nand.local>
 <YV/BMkZrj4xQyvUL@coredump.intra.peff.net>
 <nycvar.QRO.7.76.6.2110080946060.395@tvgsbejvaqbjf.bet>
 <YWC49+xCh+zum8Ms@coredump.intra.peff.net>
 <nycvar.QRO.7.76.6.2110201416390.56@tvgsbejvaqbjf.bet>
 <YXBALFsf305U8mJs@coredump.intra.peff.net>
 <2n33pn8n-7529-443q-rq7n-q12nrqrn8p27@tzk.qr>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <2n33pn8n-7529-443q-rq7n-q12nrqrn8p27@tzk.qr>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Aug 16, 2022 at 11:05:48AM +0200, Johannes Schindelin wrote:

> > It sounds like Taylor is volunteering to set up the Coverity side for
> > git.git, and I can help him with getting those COVERITY_* variables into
> > the GitHub environment.
> 
> Given the challenges with Coverity (false positives, lack of support on
> Synopsys' side, severely limited access to the reports), and given the
> renewed efforts by OSTIF that focus not on Coverity but on CodeQL, I am
> in favor of abandoning the idea to integrate Coverity in our GitHub
> workflow.
> 
> Regarding CodeQL, I am still uncertain what level of integration we will
> end up with, and the contacts I am working with are currently all on
> vacation, but I am confident that we will have an easier time going
> forward with static analysis using CodeQL instead of Coverity.

OK. I haven't been that impressed with CodeQL for C so far, but it may
be getting better. I certainly would be happier with a system that made
it easier to display and share reports.

Coverity does have a lot of false positives, but I've at least been able
to pick useful fixes out of them (especially because it is good about
saying "here are 5 new things to look at"). I've been continuing to
build my private branch with it, so we'll see if it turns up anything
useful. I do agree that inflicting it on ordinary users may be
counter-productive (I often have to stare really hard to understand why
its false positives are false, and that is not something I would wish
on, say, a GGG user).

-Peff
