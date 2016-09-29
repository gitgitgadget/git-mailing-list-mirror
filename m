Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AE045207EC
	for <e@80x24.org>; Thu, 29 Sep 2016 18:31:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932620AbcI2Sbb (ORCPT <rfc822;e@80x24.org>);
        Thu, 29 Sep 2016 14:31:31 -0400
Received: from cloud.peff.net ([104.130.231.41]:50036 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753230AbcI2Sba (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Sep 2016 14:31:30 -0400
Received: (qmail 11694 invoked by uid 109); 29 Sep 2016 18:31:30 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 29 Sep 2016 18:31:30 +0000
Received: (qmail 3450 invoked by uid 111); 29 Sep 2016 18:31:45 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 29 Sep 2016 14:31:45 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 29 Sep 2016 14:31:27 -0400
Date:   Thu, 29 Sep 2016 14:31:27 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     "Kyle J. McKay" <mackyle@gmail.com>,
        Git mailing list <git@vger.kernel.org>
Subject: Re: [PATCH 5/5] log: add --commit-header option
Message-ID: <20160929183127.4ptf2dqdeo67avte@sigill.intra.peff.net>
References: <20160929083315.vwb3aurwbyjwlkjn@sigill.intra.peff.net>
 <20160929083851.kx6itvrh4n2rttrx@sigill.intra.peff.net>
 <xmqqtwcyfvfz.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqtwcyfvfz.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Sep 29, 2016 at 10:49:04AM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > This lets you stick a header right before a commit, but
> > suppresses headers that are duplicates. This means you can
> > do something like:
> >
> >   git log --graph --author-date-order --commit-header='== %as =='
> >
> > to get a marker in the graph whenever the day changes.
> 
> That's interesting.  So it is not really "commit" header, but a
> header for groups of commits.  Credits for realizing the usefulness
> of such grouping may go to Kyle, but the implementation is also
> brilliant ;-).

Yeah, I really don't like the name "--commit-header" that much. I
initially thought to call it "--graph-header", but it is potentially
useful without a graph, too. Maybe "--group-header" or something.
I dunno. I'd leave that to somebody who actually wanted to polish the
patches up enough for submission. That might even be me someday, but not
today. :)

-Peff
