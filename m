Return-Path: <SRS0=KdtI=BW=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C267C433DF
	for <git@archiver.kernel.org>; Wed, 12 Aug 2020 16:06:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D739B20675
	for <git@archiver.kernel.org>; Wed, 12 Aug 2020 16:06:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726540AbgHLQGz (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 12 Aug 2020 12:06:55 -0400
Received: from cloud.peff.net ([104.130.231.41]:56516 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726456AbgHLQGy (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Aug 2020 12:06:54 -0400
Received: (qmail 9961 invoked by uid 109); 12 Aug 2020 16:06:54 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 12 Aug 2020 16:06:54 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 32582 invoked by uid 111); 12 Aug 2020 16:06:53 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 12 Aug 2020 12:06:53 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 12 Aug 2020 12:06:53 -0400
From:   Jeff King <peff@peff.net>
To:     Sibi Siddharthan <sibisiv.siddharthan@gmail.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: What's cooking in git.git (Aug 2020, #01; Mon, 3)
Message-ID: <20200812160653.GA42443@coredump.intra.peff.net>
References: <xmqq8sevt1lf.fsf@gitster.c.googlers.com>
 <20200804185057.GA1400256@coredump.intra.peff.net>
 <xmqqr1sms0f0.fsf@gitster.c.googlers.com>
 <20200804192053.GA1400936@coredump.intra.peff.net>
 <nycvar.QRO.7.76.6.2008121516560.50@tvgsbejvaqbjf.bet>
 <20200812141958.GA32453@coredump.intra.peff.net>
 <CAKw82xxOZFcsMw47TSrD7-pXpqO7O0_m84o96iH6+ZVeN9j1uw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAKw82xxOZFcsMw47TSrD7-pXpqO7O0_m84o96iH6+ZVeN9j1uw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Aug 12, 2020 at 09:26:05PM +0530, Sibi Siddharthan wrote:

> The CMake script was not intended to be a write once and forget
> situation, it tries to pull from the Makefile as much
> as possible. A few changes are needed, which I intend to do.

Yeah, I know. My main beef was that because it fails CI, the urgency of
doing that fix gets pushed onto people working on their individual
topics (in fact there is nothing for you to fix yet because I haven't
even sent these topics upstream). I don't know how to solve that without
stopping its use in the vsbuild CI job, though. And clearly we need
_something_ to generate the build data for that job. So this may be the
last bad thing.

From my perspective as somebody who does not work on Windows, I wonder
how much value there is in running vsbuild _and_ Windows CI for average
developers. I have certainly gotten information from these jobs (e.g.,
when introducing a portability problem, or missing a refactoring spot in
Windows-only code). But I don't think I've ever gotten information from
vsbuild that wasn't also in the regular windows build.

-Peff
