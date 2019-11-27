Return-Path: <SRS0=iCZD=ZT=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BD71C432C0
	for <git@archiver.kernel.org>; Wed, 27 Nov 2019 11:58:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC7662053B
	for <git@archiver.kernel.org>; Wed, 27 Nov 2019 11:58:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726537AbfK0L6L (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 27 Nov 2019 06:58:11 -0500
Received: from cloud.peff.net ([104.130.231.41]:33764 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726496AbfK0L6K (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Nov 2019 06:58:10 -0500
Received: (qmail 10684 invoked by uid 109); 27 Nov 2019 11:58:10 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 27 Nov 2019 11:58:10 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 9522 invoked by uid 111); 27 Nov 2019 12:02:13 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 27 Nov 2019 07:02:13 -0500
Authentication-Results: peff.net; auth=none
Date:   Wed, 27 Nov 2019 06:58:09 -0500
From:   Jeff King <peff@peff.net>
To:     Andreas Schwab <schwab@linux-m68k.org>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Carlo Marcelo Arenas =?utf-8?B?QmVsw7Nu?= <carenas@gmail.com>,
        Beat Bolli <dev+git@drbeat.li>
Subject: Re: [PATCH] t7812: add missing redirects
Message-ID: <20191127115809.GF22221@sigill.intra.peff.net>
References: <20190724151415.3698-1-avarab@gmail.com>
 <20190726150818.6373-7-avarab@gmail.com>
 <87blsyl32c.fsf_-_@igel.home>
 <nycvar.QRO.7.76.6.1911262325390.31080@tvgsbejvaqbjf.bet>
 <874kyqkzbe.fsf@igel.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <874kyqkzbe.fsf@igel.home>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Nov 27, 2019 at 12:11:49AM +0100, Andreas Schwab wrote:

> On Nov 26 2019, Johannes Schindelin wrote:
> 
> > footer, and the commit reference is not in the recommended format either
> > because it lacks the date),
> 
> Where is that documented?

It's mentioned as the preferred way to reference commits in
SubmittingPatches (search for %ad).

But I don't see why it is "not a footer". The "Fixes:" key conforms to
the trailer syntax, and the value of a trailer is free-form. Running:

  git log --format='%(trailers:key=Fixes)'

shows that Git is happy with it. And indeed, a few other people have
used it before you. None of them with a date. ;)

-Peff
