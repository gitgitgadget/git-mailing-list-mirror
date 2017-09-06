Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8F1A020281
	for <e@80x24.org>; Wed,  6 Sep 2017 23:45:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752383AbdIFXpq (ORCPT <rfc822;e@80x24.org>);
        Wed, 6 Sep 2017 19:45:46 -0400
Received: from cloud.peff.net ([104.130.231.41]:59114 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751797AbdIFXpq (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Sep 2017 19:45:46 -0400
Received: (qmail 12075 invoked by uid 109); 6 Sep 2017 23:45:46 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 06 Sep 2017 23:45:46 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 26073 invoked by uid 111); 6 Sep 2017 23:46:18 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Wed, 06 Sep 2017 19:46:18 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 06 Sep 2017 19:45:43 -0400
Date:   Wed, 6 Sep 2017 19:45:43 -0400
From:   Jeff King <peff@peff.net>
To:     Martin =?utf-8?B?w4VncmVu?= <martin.agren@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH v3 1/3] refs/files-backend: add longer-scoped copy of
 string to list
Message-ID: <20170906234543.2lnja2lds62z7fog@sigill.intra.peff.net>
References: <CAN0heSqn59sFF3A-eQ593G+ZDWnO9pKM5F=sgiSQk+prUr-nSQ@mail.gmail.com>
 <4b4c0d178ad2216eecbc49fb6f54dd8a1d1ac119.1504024261.git.martin.agren@gmail.com>
 <91e365b5-6a5d-1e1c-ab7a-579efa7c1ae8@alum.mit.edu>
 <CAN0heSqa8OnPnkd1xbyZ=QN9qg_8OaxBYnwzOZDDA3g+uGE71g@mail.gmail.com>
 <xmqq60cxcvjk.fsf@gitster.mtv.corp.google.com>
 <CAN0heSqnrPUEgP-BgvuHuVrDG2ifuHHDOPPmxiXJ73u4-PrOng@mail.gmail.com>
 <20170905203622.6fs3hr7zfa7mwpqn@sigill.intra.peff.net>
 <xmqqmv68bzvj.fsf@gitster.mtv.corp.google.com>
 <CAN0heSr0AWj-QwchX2DPzkZs9cx1gsfUTevN4JD1Ze=2t-YZiQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAN0heSr0AWj-QwchX2DPzkZs9cx1gsfUTevN4JD1Ze=2t-YZiQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Sep 06, 2017 at 08:12:24PM +0200, Martin Ågren wrote:

> On 5 September 2017 at 23:26, Junio C Hamano <gitster@pobox.com> wrote:
> > Jeff King <peff@peff.net> writes:
> >
> >> I noticed the HEAD funniness, too, when looking at this earlier. I agree
> >> with Junio that it's not quite consistent with the general rule of
> >> "string list items point to their refnames", but I don't think it
> >> matters in practice.
> >
> > Yup, we are on the same page; the "fix" I was alluding to would look
> > exactly like what you wrote below, but I agree the distinction does
> > not matter in practice.  IOW, I do not think the code after Martin's
> > fix is wrong per-se.
> 
> Well, "not wrong per-se" tells me you'd feel slightly more comfortable
> about the state of things if we did this. ;)
> 
> I'll take Peff's hint, tweak/add comments for correctness and symmetry
> with the previous patch and add an if-BUG for symmetry. Peff: Do I have
> your sign-off? (Do I need it?)

Yes, you have my sign-off. Probably it is not necessary for such a
trivial patch, but it never hurts to be sure.

> If we re-roll, would you prefer Peff's much smaller take on patch 2
> (strbuf_release where it matters, instead of sprinkling "goto out" all
> over)? I think me and him agreed that we'd be fine either way. I'd reuse
> my commit message, if I get his sign-off and "From:".

You are welcome to forge my sign-off there (but I really am OK with
either approach).

-Peff
