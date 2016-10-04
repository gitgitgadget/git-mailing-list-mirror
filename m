Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B43B720986
	for <e@80x24.org>; Tue,  4 Oct 2016 13:56:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752591AbcJDN4D (ORCPT <rfc822;e@80x24.org>);
        Tue, 4 Oct 2016 09:56:03 -0400
Received: from cloud.peff.net ([104.130.231.41]:52013 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751754AbcJDN4D (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Oct 2016 09:56:03 -0400
Received: (qmail 22218 invoked by uid 109); 4 Oct 2016 13:56:02 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 04 Oct 2016 13:56:02 +0000
Received: (qmail 5096 invoked by uid 111); 4 Oct 2016 13:56:19 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 04 Oct 2016 09:56:19 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 04 Oct 2016 09:56:00 -0400
Date:   Tue, 4 Oct 2016 09:56:00 -0400
From:   Jeff King <peff@peff.net>
To:     Jacob Keller <jacob.keller@gmail.com>
Cc:     Git mailing list <git@vger.kernel.org>,
        =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Subject: Re: [PATCH 16/18] count-objects: report alternates via verbose mode
Message-ID: <20161004135600.5bahz7q75mdtdstn@sigill.intra.peff.net>
References: <20161003203321.rj5jepviwo57uhqw@sigill.intra.peff.net>
 <20161003203618.m6kxd3b6h74jbmqz@sigill.intra.peff.net>
 <CA+P7+xoR-14fmzrYU_sGoTRgcfP8fe5y-+kSkoM-2=E3Jb56FQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CA+P7+xoR-14fmzrYU_sGoTRgcfP8fe5y-+kSkoM-2=E3Jb56FQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Oct 03, 2016 at 11:46:32PM -0700, Jacob Keller wrote:

> \On Mon, Oct 3, 2016 at 1:36 PM, Jeff King <peff@peff.net> wrote:
> > There's no way to get the list of alternates that git
> > computes internally; our tests only infer it based on which
> > objects are available. In addition to testing, knowing this
> > list may be helpful for somebody debugging their alternates
> > setup.
> >
> > Let's add it to the "count-objects -v" output. We could give
> > it a separate flag, but there's not really any need.
> > "count-objects -v" is already a debugging catch-all for the
> > object database, its output is easily extensible to new data
> > items, and printing the alternates is not expensive (we
> > already had to find them to count the objects).
> >
> 
> Makes sense. Unless there's a compelling reason you'd want to print
> out these alternates *without* anything else from -v, but you can just
> use grep like the test does so this seems fine to me.

Yeah. I could definitely be persuaded otherwise, but I just couldn't see
these being used for anything useful beyond debugging.

-Peff
