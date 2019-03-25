Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E2C8820248
	for <e@80x24.org>; Mon, 25 Mar 2019 23:35:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727394AbfCYXfS (ORCPT <rfc822;e@80x24.org>);
        Mon, 25 Mar 2019 19:35:18 -0400
Received: from cloud.peff.net ([104.130.231.41]:35900 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726061AbfCYXfS (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Mar 2019 19:35:18 -0400
Received: (qmail 5547 invoked by uid 109); 25 Mar 2019 23:35:18 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 25 Mar 2019 23:35:18 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 13425 invoked by uid 111); 25 Mar 2019 23:35:42 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Mon, 25 Mar 2019 19:35:42 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 25 Mar 2019 19:35:16 -0400
Date:   Mon, 25 Mar 2019 19:35:16 -0400
From:   Jeff King <peff@peff.net>
To:     Michael Platings <michael@platin.gs>
Cc:     Barret Rhoden <brho@google.com>,
        Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        Stefan Beller <stefanbeller@gmail.com>,
        Jeff Smith <whydoubt@gmail.com>,
        =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Subject: Re: [RFC PATCH 0/1] Fuzzy blame
Message-ID: <20190325233516.GB23728@sigill.intra.peff.net>
References: <20190324235020.49706-1-michael@platin.gs>
 <xmqq5zs7oexn.fsf@gitster-ct.c.googlers.com>
 <CAJDYR9RWUmXzh9Pn3qGBXAxNf70-SMKUCB3wwXVYKRTKOy8F_g@mail.gmail.com>
 <b077afed-d143-506e-977e-6edf2492f75f@google.com>
 <CAJDYR9R77_+gfOgLXX_Az8iODNRyDTHAT8BAubZeptEWJViYqA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAJDYR9R77_+gfOgLXX_Az8iODNRyDTHAT8BAubZeptEWJViYqA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Mar 25, 2019 at 11:21:19PM +0000, Michael Platings wrote:

> > I work on a project that needs a major reformatting, and one thing
> > delaying me was the lack of an ability to ignore commits during blame.
> 
> I think we understand each other well then - I'm working on a plan to
> change the variable naming rule in LLVM, and naturally other
> developers aren't keen on making git blame less useful.

This is sort of a tangent to the thread, but have you looked into tools
that provide an interactive "re-blame from the parent" operation? I use
tig for this.  Quite often my blame turns up on some boring line
(whitespace fixing, minor tweaking of a function interface, etc), and
then I want to keep digging on the "same" line, as counted by line count
(but it's OK if it's off by one or two lines, since I'm looking at a
blame of the whole file).

Obviously this isn't as automated as saying "ignore commit X, it's just
variable renaming". But it also eliminates the need to a priori figure
out all such X that affect the lines you care about. You get an answer,
your human mind says "nope, that's not interesting", and you press a
button to dig further.

I think there's room for both solutions to co-exist, but just suggesting
you to try out the one that's already been implemented if you haven't. ;)

-Peff
