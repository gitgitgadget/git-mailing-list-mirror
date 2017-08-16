Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3A23020899
	for <e@80x24.org>; Wed, 16 Aug 2017 08:20:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751588AbdHPIU0 (ORCPT <rfc822;e@80x24.org>);
        Wed, 16 Aug 2017 04:20:26 -0400
Received: from cloud.peff.net ([104.130.231.41]:40518 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751082AbdHPIUZ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Aug 2017 04:20:25 -0400
Received: (qmail 19505 invoked by uid 109); 16 Aug 2017 08:20:24 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 16 Aug 2017 08:20:24 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 17690 invoked by uid 111); 16 Aug 2017 08:20:49 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Wed, 16 Aug 2017 04:20:49 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 16 Aug 2017 04:20:22 -0400
Date:   Wed, 16 Aug 2017 04:20:22 -0400
From:   Jeff King <peff@peff.net>
To:     Martin =?utf-8?B?w4VncmVu?= <martin.agren@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Jacob Keller <jacob.keller@gmail.com>,
        Christian Couder <christian.couder@gmail.com>
Subject: Re: [PATCH v4 5/8] interpret-trailers: add --parse convenience option
Message-ID: <20170816082022.5use3im2bq27wik4@sigill.intra.peff.net>
References: <20170815102254.knccmhgralfijwli@sigill.intra.peff.net>
 <20170815102334.qc4w7akl44bti44x@sigill.intra.peff.net>
 <CAN0heSrUz2jU2ijeSjYRhvyXA8qpw=JoOhaK-4Fuyv4_1L6Gtw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAN0heSrUz2jU2ijeSjYRhvyXA8qpw=JoOhaK-4Fuyv4_1L6Gtw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Aug 15, 2017 at 01:26:53PM +0200, Martin Ågren wrote:

> >  This command reads some patches or commit messages from either the
> > -<file> arguments or the standard input if no <file> is specified. Then
> > -this command applies the arguments passed using the `--trailer`
> > -option, if any, to the commit message part of each input file. The
> > -result is emitted on the standard output.
> > +<file> arguments or the standard input if no <file> is specified. If
> > +`--parse` is specified, the output consists of the parsed trailers.
> > +
> > +Otherwise, the this command applies the arguments passed using the
> > +`--trailer` option, if any, to the commit message part of each input
> > +file. The result is emitted on the standard output.
> 
> "the this"

Thanks.

> I think I get why you use --parse above (and in the synopsis), although
> it kind of feels like it should be --only-input or perhaps "--only-input
> (or --parse)".

I really wanted to point people to --parse as the go-to option for the
parsing mode for the sake of simplicity (in fact I initially considered
not even exposing them at all). And I hoped that if they jumped to the
definition of --parse, that would lead them to the other options.

I dunno. I agree it is does not read particularly well. Probably the
whole description section could be rewritten to cover the newly dual
nature of the command a bit better. But I didn't want to disrupt the
existing flow too much.

-Peff
