Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CC77420286
	for <e@80x24.org>; Sat,  9 Sep 2017 06:52:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752415AbdIIGwv (ORCPT <rfc822;e@80x24.org>);
        Sat, 9 Sep 2017 02:52:51 -0400
Received: from cloud.peff.net ([104.130.231.41]:33186 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1750817AbdIIGwu (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 9 Sep 2017 02:52:50 -0400
Received: (qmail 21103 invoked by uid 109); 9 Sep 2017 06:52:49 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Sat, 09 Sep 2017 06:52:49 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 12899 invoked by uid 111); 9 Sep 2017 06:53:23 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Sat, 09 Sep 2017 02:53:23 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 09 Sep 2017 02:52:47 -0400
Date:   Sat, 9 Sep 2017 02:52:47 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Stefan Beller <sbeller@google.com>,
        =?utf-8?B?0JLQsNC70LXQvdGC0LjQvQ==?= <valiko.ua@gmail.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: "git shortlog -sn --follow -- <path>" counts all commits to
 entire repo
Message-ID: <20170909065247.wob3nuxvox4f65gg@sigill.intra.peff.net>
References: <CAJrPYn8_n1JD3hL1LSAVz2Khs=dZRVaZ-gpru5AV+ottv5WfAw@mail.gmail.com>
 <CAGZ79kZAeCERKn6he2LzAj97BXEJ5U+Fy4sorAPNmW_XaCS9Vg@mail.gmail.com>
 <20170908051015.ybq4egdrddecl4se@sigill.intra.peff.net>
 <xmqqo9qlzodi.fsf@gitster.mtv.corp.google.com>
 <20170908074910.reoyb47navgsg6kt@sigill.intra.peff.net>
 <xmqqbmmlytv3.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqbmmlytv3.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Sep 09, 2017 at 02:37:20AM +0900, Junio C Hamano wrote:

> > That said, I don't think we can go wrong by making shortlog's traversal
> > more like log's. Any changes we make to --follow will be aimed at and
> > tested with git-log, so the more code they share the more likely it is
> > that shortlog won't bitrot.
> 
> Both true.  
> 
> Using log-tree traversal machinery instead of just get_revision()
> would probably mean we would slow it down quite a bit unless we are
> careful, but at the same time, things like "git shortlog -G<string>"
> would suddenly start working, so this is not just helping the
> "--follow" hack.

I didn't notice that, but I'm not surprised that there are more options
that shortlog doesn't quite work with.

I don't plan on working on this myself any time soon, so maybe it's a
good #leftoverbits candidate (though it's perhaps a little more involved
than some).

-Peff
