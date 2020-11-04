Return-Path: <SRS0=V3lj=EK=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF1B2C2D0A3
	for <git@archiver.kernel.org>; Wed,  4 Nov 2020 13:33:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 583962222C
	for <git@archiver.kernel.org>; Wed,  4 Nov 2020 13:33:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728922AbgKDNdo (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 4 Nov 2020 08:33:44 -0500
Received: from cloud.peff.net ([104.130.231.41]:47178 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726350AbgKDNdn (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 4 Nov 2020 08:33:43 -0500
Received: (qmail 9761 invoked by uid 109); 4 Nov 2020 13:33:43 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 04 Nov 2020 13:33:43 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 10245 invoked by uid 111); 4 Nov 2020 13:33:42 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 04 Nov 2020 08:33:42 -0500
Authentication-Results: peff.net; auth=none
Date:   Wed, 4 Nov 2020 08:33:42 -0500
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Daniel Duvall <dan@mutual.io>, Git Users <git@vger.kernel.org>
Subject: Re: [PATCH] upload-pack: allow stateless client EOF just prior to
 haves
Message-ID: <20201104133342.GB3030480@coredump.intra.peff.net>
References: <1604022059-18527-1-git-send-email-dan@mutual.io>
 <20201030044012.GA3259692@coredump.intra.peff.net>
 <CANo+1gv0otfjRexAVW6E+yPEvGLo55_tQWN-81mQMm4U0seCJQ@mail.gmail.com>
 <20201030090902.GA3268509@coredump.intra.peff.net>
 <xmqqeelaqh7m.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqeelaqh7m.fsf@gitster.c.googlers.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Nov 03, 2020 at 01:10:53PM -0800, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > I'm still uncertain whether it could all be done in one request for v0.
> > But one possible solution is: let's not care. If v2 does it correctly,
> > that's the future anyway (or present; it's now the default in v2.29).
> > And the change you're proposing in upload-pack would be desirable anyway
> > to help deal with older clients.
> >
> > If that's the route we go, we should make sure the commit message
> > explains it.
> 
> Yeah, I'd agree that punting on v0 and making sure the current
> version would work well is good enough.
> 
> I lost track and am not sure what's the current status of the topic
> is.  Is v3 [*1*] the latest and satisfactory one?

Yeah, I just read over v3 again and it looks good to me. Thanks, Daniel!

-Peff
