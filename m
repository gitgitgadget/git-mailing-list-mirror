Return-Path: <SRS0=RPsp=7C=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E035C433DF
	for <git@archiver.kernel.org>; Wed, 20 May 2020 19:40:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 19A00207E8
	for <git@archiver.kernel.org>; Wed, 20 May 2020 19:40:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726754AbgETTkV (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 20 May 2020 15:40:21 -0400
Received: from cloud.peff.net ([104.130.231.41]:52300 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726548AbgETTkU (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 May 2020 15:40:20 -0400
Received: (qmail 8568 invoked by uid 109); 20 May 2020 19:40:20 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 20 May 2020 19:40:20 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 17141 invoked by uid 111); 20 May 2020 19:40:20 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 20 May 2020 15:40:20 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 20 May 2020 15:40:19 -0400
From:   Jeff King <peff@peff.net>
To:     Andreas Schwab <schwab@linux-m68k.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org
Subject: Re: Fetching 24 Linux commits = 1.2 GiB
Message-ID: <20200520194019.GA340985@coredump.intra.peff.net>
References: <b7f5bfb9-61fb-2552-4399-b744428728e4@suse.cz>
 <20200415135627.vx75hsphbpmgrquv@chatter.i7.local>
 <xmqq1roo947y.fsf@gitster.c.googlers.com>
 <87sgfvq967.fsf@igel.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87sgfvq967.fsf@igel.home>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, May 20, 2020 at 10:53:36AM +0200, Andreas Schwab wrote:

> On Apr 15 2020, Junio C Hamano wrote:
> 
> > Do these (and I think we saw other reports) make us rethink the
> > status of protocol v2 as the default?  Are all of these fallouts 
> > we saw so far easy-to-fix bugs, or are there more fundamental issues
> > in the v2 protocol design?
> 
> I'm now seeing the issue myself, and can provide a backup of the
> offending repository.

The "too big fetch" issue has since been fixed in "master", as well as
reverting the switch to the v2 protocol (which I think is just
belt-and-suspenders; AFAIK there are no known issues after the fix).
Both will be in v2.27. I don't see anything on "maint", but they _could_
be part of an eventual v2.26.3.

The fix was merged in 0b07eecf6e (Merge branch 'jt/v2-fetch-nego-fix',
2020-05-01) for reference.

-Peff
