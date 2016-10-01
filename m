Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DBCE51F4F8
	for <e@80x24.org>; Sat,  1 Oct 2016 09:16:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751580AbcJAJQC (ORCPT <rfc822;e@80x24.org>);
        Sat, 1 Oct 2016 05:16:02 -0400
Received: from cloud.peff.net ([104.130.231.41]:50800 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750912AbcJAJQB (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 1 Oct 2016 05:16:01 -0400
Received: (qmail 17510 invoked by uid 109); 1 Oct 2016 09:16:00 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Sat, 01 Oct 2016 09:16:00 +0000
Received: (qmail 16990 invoked by uid 111); 1 Oct 2016 09:16:16 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Sat, 01 Oct 2016 05:16:16 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 01 Oct 2016 05:15:58 -0400
Date:   Sat, 1 Oct 2016 05:15:58 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] diff_unique_abbrev(): document its assumtion and
 limitation
Message-ID: <20161001091558.guduirzlkog5fkzd@sigill.intra.peff.net>
References: <xmqqvaxd9ssy.fsf@gitster.mtv.corp.google.com>
 <20160930180957.xj4jqoslbtevhqpb@sigill.intra.peff.net>
 <xmqqd1jl9ovc.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqd1jl9ovc.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Sep 30, 2016 at 12:19:51PM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > ... Now that function _would_
> > want to be updated as a result of the other conversation (it would need
> > to do something sensible with "-1", like turning it into "7", or
> > whatever else is deemed reasonable outside of a repository).
> >
> > Anyway. I just wonder if you want to give it a better name while you are
> > at it.
> 
> I'd say the patch to introduce the new function that makes the old
> name potentially confusing is a good one to do the rename.  Until
> then I do not think there is no need to rename the existing one ;-)

I guess my point was that the poor name may have contributed to the need
to explain it. But I'm happy to deal with it in my series (I also
updated it to use "struct oid"; I'll probably rebase mine on top of your
comment to save you dealing with the nasty merge).

> Related tangent about "like turning it into", I am thinking adding
> something like this as a preparatory step to Linus's auto-sizing
> serires.  That way, we do not have to spell "7"
> [...]
> -- >8 --
> Subject: abbrev: add FALLBACK_DEFAULT_ABBREV to prepare for auto sizing

Yep, looks like a good idea.

-Peff
