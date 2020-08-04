Return-Path: <SRS0=W4Po=BO=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76EB8C433DF
	for <git@archiver.kernel.org>; Tue,  4 Aug 2020 19:20:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 64590206DA
	for <git@archiver.kernel.org>; Tue,  4 Aug 2020 19:20:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727035AbgHDTUz (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 4 Aug 2020 15:20:55 -0400
Received: from cloud.peff.net ([104.130.231.41]:48006 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726090AbgHDTUy (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Aug 2020 15:20:54 -0400
Received: (qmail 5357 invoked by uid 109); 4 Aug 2020 19:20:54 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 04 Aug 2020 19:20:54 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 14766 invoked by uid 111); 4 Aug 2020 19:20:53 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 04 Aug 2020 15:20:53 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 4 Aug 2020 15:20:53 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Sibi Siddharthan <sibisiv.siddharthan@gmail.com>,
        git@vger.kernel.org
Subject: Re: What's cooking in git.git (Aug 2020, #01; Mon, 3)
Message-ID: <20200804192053.GA1400936@coredump.intra.peff.net>
References: <xmqq8sevt1lf.fsf@gitster.c.googlers.com>
 <20200804185057.GA1400256@coredump.intra.peff.net>
 <xmqqr1sms0f0.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqr1sms0f0.fsf@gitster.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Aug 04, 2020 at 11:58:43AM -0700, Junio C Hamano wrote:

> > I ran into issues with this, as I have several in-progress topics (not
> > yet sent to the list) that touch our Makefile, and they needed updates
> > to the cmake file (because it reproduces a lot of the lists and logic
> > from the Makefile).
> >
> > The original philosophy behind putting it in contrib is that most people
> > wouldn't have to care, and folks interested in cmake would be
> > responsible for keeping it up to date. But the top patch makes it hard
> > to ignore, because the vs-build CI job will fail.
> >
> > I'm not sure of the right path forward. I was definitely unenthused to
> > be dealing with cmake, and the problem came up as soon as the series hit
> > next.
> 
> My hope is that if we let vs-build broken long enough, those who
> want to see cmake to graduate would fix it.  We can always threaten
> the topic to be discarded out of 'next' after the next release if it
> hasn't been fixed ;-)

That was my philosophy, too, but it's annoying in the meantime as I get
a notification for "your build is broken" every time I run CI. So it
becomes a game of chicken over who gets annoyed first. ;)

-Peff
