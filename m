Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37FF9C433DB
	for <git@archiver.kernel.org>; Fri, 26 Mar 2021 04:20:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DB38F61A42
	for <git@archiver.kernel.org>; Fri, 26 Mar 2021 04:20:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229458AbhCZETy (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 26 Mar 2021 00:19:54 -0400
Received: from cloud.peff.net ([104.130.231.41]:49460 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229446AbhCZETv (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 Mar 2021 00:19:51 -0400
Received: (qmail 28476 invoked by uid 109); 26 Mar 2021 04:19:51 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 26 Mar 2021 04:19:51 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 7418 invoked by uid 111); 26 Mar 2021 04:19:52 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 26 Mar 2021 00:19:52 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 26 Mar 2021 00:19:50 -0400
From:   Jeff King <peff@peff.net>
To:     Jeffrey Walton <noloader@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>
Subject: Re: not ok 47 - log.decorate configuration
Message-ID: <YF1g5jrCtCSmfwH/@coredump.intra.peff.net>
References: <CAH8yC8mnaEpnw8xCKsyBg0XXsuwhiE10AFXFDBdH2AW0qUP3HQ@mail.gmail.com>
 <CAH8yC8nr-zhT-T2UK6q1cvFRzpi0fvyYuh8iydNscEse75X=gA@mail.gmail.com>
 <xmqqy2easpxb.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqy2easpxb.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Mar 25, 2021 at 05:45:52PM -0700, Junio C Hamano wrote:

> Jeffrey Walton <noloader@gmail.com> writes:
> 
> > On Thu, Mar 25, 2021 at 3:57 AM Jeffrey Walton <noloader@gmail.com> wrote:
> >> ...
> >
> > Cancel this. It just tested OK a second time around.
> 
> Which may indicate that the test is flakey (e.g. timing dependent,
> only reproducing when two commands in the test sequence are executed
> across a second boundary, or something like that), which may be
> worth fixing.

I can't get it to fail with "./t4202-log.sh --stress", which usually
turns up races or other flakes. But perhaps there is something unique
about your (Jeff) system that triggers it.

It's hard to tell more without any verbose output from the failing test.
In general, failure reports accompanied by the output (or at least the
end of the output) of "./t4202-log.sh -v -i -x" will be a lot more
useful.

If you're seeing intermittent failures from a larger "make test",
consider putting "--verbose-log -x" into GIT_TEST_OPTS (either on the
make command-line, or in config.mak). The logs will be in
t/test-results/t4202-log.out, etc.

-Peff
