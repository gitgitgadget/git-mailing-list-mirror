Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9BCEC433E0
	for <git@archiver.kernel.org>; Fri,  5 Feb 2021 22:12:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6D6FB64FA8
	for <git@archiver.kernel.org>; Fri,  5 Feb 2021 22:12:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232690AbhBEWLx (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 5 Feb 2021 17:11:53 -0500
Received: from cloud.peff.net ([104.130.231.41]:51738 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232065AbhBEOiJ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 Feb 2021 09:38:09 -0500
Received: (qmail 18713 invoked by uid 109); 5 Feb 2021 16:15:46 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 05 Feb 2021 16:15:46 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 24612 invoked by uid 111); 5 Feb 2021 16:15:45 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 05 Feb 2021 11:15:45 -0500
Authentication-Results: peff.net; auth=none
Date:   Fri, 5 Feb 2021 11:15:45 -0500
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org
Subject: Re: [PATCH v7 0/3] Cloning with remote unborn HEAD
Message-ID: <YB1vMcR1hYie1XLb@coredump.intra.peff.net>
References: <20201208013121.677494-1-jonathantanmy@google.com>
 <cover.1612493309.git.jonathantanmy@google.com>
 <xmqq5z372ihm.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq5z372ihm.fsf@gitster.c.googlers.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Feb 04, 2021 at 09:25:57PM -0800, Junio C Hamano wrote:

> Jonathan Tan <jonathantanmy@google.com> writes:
> 
> > For what it's worth, here's v7 with advertise/allow/ignore and by
> > default, advertise. I think that some server operators will have use for
> > this feature, and people who want to disable it for whatever reason can
> > still do so. The main disadvantage is complexity - the server knob that
> > server administrators will need to control (but between a simpler
> > allow/ignore knob and a more complicated advertise/allow/ignore knob, I
> > think we might as well go for the slightly more complex one) and
> > complexity in the code (but now that is constrained to one function and
> > a few global variables).
> >
> > As you can see from the range-diff, not much has changed from v6.
> >
> > I've also included Junio's suggestion of tightening the promise made by
> > the server (when the client says "unborn").
> 
> This looks reasonable overall, especially with the feature turned on
> by default, we'd hopefully get reasonable exposure from the get-go.
> 
> Let's mark the topic to be merged to 'next' soonish, unless people
> object.

No objection here. I sent a few comments in response to patch 1; the doc
fix and the leak are probably worth addressing before it hits next. I
couldn't help express my thoughts on the protocol wording, but it may be
best to ignore me. ;)

Thanks for working on this, Jonathan. I think it's a very useful
feature.

-Peff
