Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B9B811FBB0
	for <e@80x24.org>; Thu,  1 Dec 2016 21:30:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752165AbcLAVaX (ORCPT <rfc822;e@80x24.org>);
        Thu, 1 Dec 2016 16:30:23 -0500
Received: from cloud.peff.net ([104.130.231.41]:50236 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750775AbcLAVaW (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Dec 2016 16:30:22 -0500
Received: (qmail 18531 invoked by uid 109); 1 Dec 2016 21:30:22 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 01 Dec 2016 21:30:22 +0000
Received: (qmail 4508 invoked by uid 111); 1 Dec 2016 21:30:58 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 01 Dec 2016 16:30:58 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 01 Dec 2016 16:30:20 -0500
Date:   Thu, 1 Dec 2016 16:30:20 -0500
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: [RFC/PATCH] add diff-pairs tool
Message-ID: <20161201213019.qfkqd324ommikym2@sigill.intra.peff.net>
References: <20161201204042.6yslbyrg7l6ghhww@sigill.intra.peff.net>
 <xmqqbmwv8j9m.fsf@gitster.mtv.corp.google.com>
 <20161201205504.flgaf7dwv3b3dkkd@sigill.intra.peff.net>
 <xmqq7f7j8iz6.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq7f7j8iz6.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Dec 01, 2016 at 12:58:21PM -0800, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > On Thu, Dec 01, 2016 at 12:52:05PM -0800, Junio C Hamano wrote:
> >
> >> Jeff King <peff@peff.net> writes:
> >> 
> >> > This takes the output of `diff-tree -z --raw` and feeds it
> >> > back to the later stages of the diff machinery to produce
> >> > diffs in other formats.
> >> 
> >> A full circle.  This reminds me of the experiment done more than 10
> >> years ago at the beginning of the "diffcore transformations" design.
> >
> > Heh, I didn't even think to dig for prior art on the list.
> 
> It took me a while to dig it up because the topic is so old, but
> 
> https://public-inbox.org/git/Pine.LNX.4.58.0504251832480.18901@ppc970.osdl.org/
> 
> is the thread I had in mind.  The idea of rename detection followed
> soon afterwards.

Thanks for an interesting read. Your diff-tree-helper patch is very
similar to what I wrote.

I do think the right decision was made back then. The single-process
model is much more efficient, and it was over 10 years until somebody
actually wanted to expose the functionality to a script (and even now,
I'm not convinced enough people want it to even merit inclusion).

-Peff
