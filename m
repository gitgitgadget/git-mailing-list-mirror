Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 09E841F404
	for <e@80x24.org>; Mon, 10 Sep 2018 18:48:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728012AbeIJXnq (ORCPT <rfc822;e@80x24.org>);
        Mon, 10 Sep 2018 19:43:46 -0400
Received: from cloud.peff.net ([104.130.231.41]:45180 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726603AbeIJXnp (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Sep 2018 19:43:45 -0400
Received: (qmail 18365 invoked by uid 109); 10 Sep 2018 18:48:19 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 10 Sep 2018 18:48:19 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 10660 invoked by uid 111); 10 Sep 2018 18:48:32 -0000
Received: from Unknown (HELO sigill.intra.peff.net) (10.0.1.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Mon, 10 Sep 2018 14:48:32 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 10 Sep 2018 14:48:17 -0400
Date:   Mon, 10 Sep 2018 14:48:17 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Stefan Beller <sbeller@google.com>, git@vger.kernel.org
Subject: Re: [PATCH 0/4] un-breaking pack-objects with bitmaps
Message-ID: <20180910184817.GB20678@sigill.intra.peff.net>
References: <20180821184140.GA24165@sigill.intra.peff.net>
 <20180821190701.GE30764@sigill.intra.peff.net>
 <8736uud0gq.fsf@evledraar.gmail.com>
 <20180831225558.GA22917@sigill.intra.peff.net>
 <20180901074145.GA24023@sigill.intra.peff.net>
 <87d0toqyj6.fsf@evledraar.gmail.com>
 <xmqq1sa1uwd7.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <xmqq1sa1uwd7.fsf@gitster-ct.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Sep 10, 2018 at 09:53:56AM -0700, Junio C Hamano wrote:

> Ævar Arnfjörð Bjarmason <avarab@gmail.com> writes:
> 
> > I'm just reverting jk/pack-delta-reuse-with-bitmap out of next when
> > building my own package of git, but I think this really should be fixed
> > in that branch, either by merging the fix down or reverting the original
> > series out of next, I think just merging the fix down makes sense, but
> > have no strong opinion on it.
> 
> Either is fine.  I am not moving 'next' beyond what is necessary for
> this release cycle during the pre-release freeze period, and because
> I thought that Peff was in favor of squashing in the changes to the
> original when the next cycle starts, I haven't bothered to merge the
> fix there yet.

I think Ævar's point is just that the current tip of next is badly
broken if you use bitmaps, and it's worth hot-fixing that in the
meantime.

After the release, I'm OK with either one of squashing that first patch
in, or just merging as-is.

-Peff
