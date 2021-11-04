Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00856C433F5
	for <git@archiver.kernel.org>; Thu,  4 Nov 2021 09:47:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CB6A0610E7
	for <git@archiver.kernel.org>; Thu,  4 Nov 2021 09:47:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231136AbhKDJtv (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 4 Nov 2021 05:49:51 -0400
Received: from cloud.peff.net ([104.130.231.41]:52950 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230057AbhKDJtv (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 Nov 2021 05:49:51 -0400
Received: (qmail 8135 invoked by uid 109); 4 Nov 2021 09:47:11 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 04 Nov 2021 09:47:11 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 32197 invoked by uid 111); 4 Nov 2021 09:47:13 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 04 Nov 2021 05:47:13 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 4 Nov 2021 05:47:10 -0400
From:   Jeff King <peff@peff.net>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org, Alejandro Sanchez <asanchez1987@gmail.com>
Subject: Re: [PATCH 2/2] prompt.c: add and use a GIT_TEST_TERMINAL_PROMPT=true
Message-ID: <YYOsHkMgUa7CXLic@coredump.intra.peff.net>
References: <20190524062724.GC25694@sigill.intra.peff.net>
 <cover-0.2-00000000000-20211102T155046Z-avarab@gmail.com>
 <patch-2.2-964e7f4531f-20211102T155046Z-avarab@gmail.com>
 <YYJ5IpvGRoDvp8V6@coredump.intra.peff.net>
 <xmqqo8716sqx.fsf@gitster.g>
 <nycvar.QRO.7.76.6.2111040945280.56@tvgsbejvaqbjf.bet>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <nycvar.QRO.7.76.6.2111040945280.56@tvgsbejvaqbjf.bet>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Nov 04, 2021 at 09:48:35AM +0100, Johannes Schindelin wrote:

> Hi Junio & Peff,
> 
> On Wed, 3 Nov 2021, Junio C Hamano wrote:
> 
> > Jeff King <peff@peff.net> writes:
> >
> > > Basically, I think I just disagree with this paragraph entirely.
> > > Moving to stdin in the commits you referenced was done to help
> > > testing, but I also think it's just a more flexible direction overall.
> >
> > It is OK, and it is more convenient for writing test scripts, to take
> > interactive input from the standard input stream, if the command does
> > not use the standard input for other purposes.
> 
> I think I remember when we talked about this, it was in the context of
> `git add -p` becoming a built-in, and we all agreed that it is actually a
> very nice side effect that you can feed commands to `git add -p` in
> scripts via stdin, not only for testing.
> 
> It might have been in the context of another command, but even then it is
> a fact that this is a very nice side effect.

Yes, we definitely had that discussion about "add -p", and I agree it is
nice. People are probably less likely to drive other tools like git-am
and git-bisect in such a way, though, as their interactive modes just do
a lot less.

-Peff
