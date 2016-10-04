Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5384620986
	for <e@80x24.org>; Tue,  4 Oct 2016 13:43:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753947AbcJDNnn (ORCPT <rfc822;e@80x24.org>);
        Tue, 4 Oct 2016 09:43:43 -0400
Received: from cloud.peff.net ([104.130.231.41]:51992 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753873AbcJDNnn (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Oct 2016 09:43:43 -0400
Received: (qmail 21393 invoked by uid 109); 4 Oct 2016 13:43:42 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 04 Oct 2016 13:43:42 +0000
Received: (qmail 4981 invoked by uid 111); 4 Oct 2016 13:43:59 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 04 Oct 2016 09:43:59 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 04 Oct 2016 09:43:40 -0400
Date:   Tue, 4 Oct 2016 09:43:40 -0400
From:   Jeff King <peff@peff.net>
To:     Jacob Keller <jacob.keller@gmail.com>
Cc:     Git mailing list <git@vger.kernel.org>,
        =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Subject: Re: [PATCH 01/18] t5613: drop reachable_via function
Message-ID: <20161004134339.pn4elyuixslsaya4@sigill.intra.peff.net>
References: <20161003203321.rj5jepviwo57uhqw@sigill.intra.peff.net>
 <20161003203350.3u6ddr6ndr3jwr74@sigill.intra.peff.net>
 <CA+P7+xq3G=CNHNNQ5YpkHkud_5SUrTBOwZ3y7d8DvM9nKyXV9g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CA+P7+xq3G=CNHNNQ5YpkHkud_5SUrTBOwZ3y7d8DvM9nKyXV9g@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Oct 03, 2016 at 10:48:31PM -0700, Jacob Keller wrote:

> On Mon, Oct 3, 2016 at 1:33 PM, Jeff King <peff@peff.net> wrote:
> > This function was never used since its inception in dd05ea1
> > (test case for transitive info/alternates, 2006-05-07).
> > Which is just as well, since it mutates the repo state in a
> > way that would invalidate further tests, without cleaning up
> > after itself. Let's get rid of it so that nobody is tempted
> > to use it.
> >
> 
> Makes sense. It wouldn't be a good idea to leave this around since it
> didn't clean up after itself. Curious why no test actually used it
> though..

I wondered that, too. Sometimes in cases like this a call got dropped
during a re-roll on the list. But the original email:

  http://public-inbox.org/git/20060507181947.GE23738@admingilde.org/

has the problem, too. So probably it was just leftover cruft that was
made obsolete even before it hit the list.

-Peff
