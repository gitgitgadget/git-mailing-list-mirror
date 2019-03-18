Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6271C20248
	for <e@80x24.org>; Mon, 18 Mar 2019 21:12:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727654AbfCRVMS (ORCPT <rfc822;e@80x24.org>);
        Mon, 18 Mar 2019 17:12:18 -0400
Received: from cloud.peff.net ([104.130.231.41]:55470 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1727132AbfCRVMR (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Mar 2019 17:12:17 -0400
Received: (qmail 10111 invoked by uid 109); 18 Mar 2019 21:12:18 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 18 Mar 2019 21:12:18 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 23759 invoked by uid 111); 18 Mar 2019 21:12:38 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Mon, 18 Mar 2019 17:12:38 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 18 Mar 2019 17:12:15 -0400
Date:   Mon, 18 Mar 2019 17:12:15 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Roberto Tyley <roberto.tyley@gmail.com>
Subject: Re: [RFC/PATCH] point pull requesters to Git Git Gadget
Message-ID: <20190318211215.GB29661@sigill.intra.peff.net>
References: <20190312213246.GA6252@sigill.intra.peff.net>
 <xmqqsgvrfsrh.fsf@gitster-ct.c.googlers.com>
 <20190313193909.GB3400@sigill.intra.peff.net>
 <20190313201854.GA5530@sigill.intra.peff.net>
 <xmqqzhps6ghl.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqzhps6ghl.fsf@gitster-ct.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Mar 18, 2019 at 11:52:54AM +0900, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > Hmm. I guess it is still an issue in GGG. This thread has identical
> > timestamps on patches 1 and 2 (and my server received them out of order
> > by 2 seconds, so mutt orders them wrong):
> >
> >   https://public-inbox.org/git/pull.163.git.gitgitgadget@gmail.com/
> >
> > I do still think GGG has a more feasible path forward on this particular
> > bug, though.
> 
> If the MSA is rewriting the timestamp (but why?  Is the original
> date "Wed, 13 Mar 2019 19:20:12 GMT" malformed or perhaps in the
> future or something?), then there isn't much the sending program
> can---'git send-email' would suffer from the same symptom.

I think this statement from me is mid-way through my discovery of the
actual issue. Yes, if the mail server is rewriting, the best we can do
is put in an artificial sleep.

It looks like GitGitGadget just uses normal SMTP to submit the messages.
I wonder if normal people using gmail as their SMTP server for
send-email also suffer from this. I've not ever noticed it, but I
don't know how common that setup is.

-Peff
