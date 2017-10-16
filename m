Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B0F0B202A3
	for <e@80x24.org>; Mon, 16 Oct 2017 21:53:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753974AbdJPVxO (ORCPT <rfc822;e@80x24.org>);
        Mon, 16 Oct 2017 17:53:14 -0400
Received: from cloud.peff.net ([104.130.231.41]:54542 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1752107AbdJPVxN (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Oct 2017 17:53:13 -0400
Received: (qmail 9905 invoked by uid 109); 16 Oct 2017 21:53:13 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 16 Oct 2017 21:53:13 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 17069 invoked by uid 111); 16 Oct 2017 21:53:17 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Mon, 16 Oct 2017 17:53:17 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 16 Oct 2017 17:53:11 -0400
Date:   Mon, 16 Oct 2017 17:53:11 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 1/2] color: downgrade "always" to "auto" only for on-disk
 configuration
Message-ID: <20171016215311.m72jarmqhjagy6o6@sigill.intra.peff.net>
References: <xmqqr2uao2vy.fsf@gitster.mtv.corp.google.com>
 <20171012021007.7441-1-gitster@pobox.com>
 <20171012021007.7441-2-gitster@pobox.com>
 <20171012123153.i265nun6pklw7kjg@sigill.intra.peff.net>
 <xmqqinfjykm2.fsf@gitster.mtv.corp.google.com>
 <20171013014721.d4vesqv4v5j7tmk2@sigill.intra.peff.net>
 <xmqqzi8vvht6.fsf@gitster.mtv.corp.google.com>
 <20171013130638.dgc6kawy5mvrbasz@sigill.intra.peff.net>
 <xmqqshemtoth.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqshemtoth.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Oct 14, 2017 at 12:01:46PM +0900, Junio C Hamano wrote:

> > That takes us back to the pre-regression state. The ancient bug from
> > 4c7f1819 still exists, but that would be OK for v2.15. We'd probably
> > want to bump the -rc cycle a bit to give more confidence that (2) caught
> > everything.
> 
> Yes, I think that is the approach I was pushing initially with the
> jc/ref-filter-colors-fix topic that was later retracted; the result
> of your 4-patch series more or less matches that one, modulo that I
> didn't treat for-each-ref as a plumbing.

Ah, right, I forgot about that one while I was putting it together. So
many alternatives floating around.

> I do share the worry that
> it is hard to make sure that these post-revert adjustment caught
> everything; after all, that was a major part of the reason why my
> earlier attempt was retracted.  I still think this is the _right_
> direction to go in, even though it is harder to get right.

To be honest, I'm not actually very worried. I think missing a
post-revert adjustment is the main risk, but my general sense is that
there hasn't been a lot going on with color fixes outside of my recent
work. Famous last words and all that, I'm sure. :)

> True.  Let's see what others think.  I know Jonathan is running
> the fork at $work with "downgrade always to auto" patches, and while
> I think both approaches would probably work well in practice, I have
> preference for this "harder but right" approach, so I'd want to see
> different views discussed on the list before we decide.

After pondering over it, I have a slight preference for that, too. But
I'm also happy to hear more input.

-Peff
