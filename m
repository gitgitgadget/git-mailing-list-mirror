Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,BODY_8BITS,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8643220281
	for <e@80x24.org>; Thu, 21 Sep 2017 05:30:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751661AbdIUFaJ (ORCPT <rfc822;e@80x24.org>);
        Thu, 21 Sep 2017 01:30:09 -0400
Received: from cloud.peff.net ([104.130.231.41]:45668 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751588AbdIUFaI (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Sep 2017 01:30:08 -0400
Received: (qmail 3688 invoked by uid 109); 21 Sep 2017 05:30:09 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 21 Sep 2017 05:30:09 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 19480 invoked by uid 111); 21 Sep 2017 05:30:45 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Thu, 21 Sep 2017 01:30:45 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 21 Sep 2017 01:30:06 -0400
Date:   Thu, 21 Sep 2017 01:30:06 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?0J7Qu9GPINCi0LXQu9C10LbQvdCw0Y8=?= 
        <olyatelezhnaya@gmail.com>
Cc:     Christian Couder <christian.couder@gmail.com>,
        git <git@vger.kernel.org>
Subject: Re: My first contribution. Outreachy
Message-ID: <20170921053006.xcwru5vuplafhhxf@sigill.intra.peff.net>
References: <CAL21Bm=zQ2ADTOSVk5kL1q=VyLV91J+VbsLLFbSdgPxeg3FW1g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAL21Bm=zQ2ADTOSVk5kL1q=VyLV91J+VbsLLFbSdgPxeg3FW1g@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

[Note that your email didn't make it to the mailing list because it
 was formatted as HTML. You may want to tweak your gmail settings to
 send plain text. Those of us on the to/cc did get it, though].

On Tue, Sep 19, 2017 at 03:45:18PM +0300, Оля Тележная wrote:

> If you could help me with choosing my first task and give some
> thoughts about where to look to solve the problem - that would be
> great.

Here are a few possibilities:

  - The task mentioned in:

       https://public-inbox.org/git/20170912172839.GB144745@aiede.mtv.corp.google.com/

    to convert the ad-hoc doubly-linked list implementation used in
    mru.c and mru.h to use the implementation from list.h.

    Note that I've pointed a few other people at this task, so you may
    find other candidates working on it, too (and it's possible if we
    get multiple good versions submitted yours might not get applied; I
    still think it's a good simple task that will help get you familiar
    with writing and submitting a patch).

  - We've been working with some leak-checking tools lately to try to
    find memory leaks in Git by running the test suite. You can see some
    example patches:

      https://public-inbox.org/git/1505936846-2195-1-git-send-email-martin.agren@gmail.com/

      https://public-inbox.org/git/1505936846-2195-2-git-send-email-martin.agren@gmail.com/

      https://public-inbox.org/git/1505936846-2195-3-git-send-email-martin.agren@gmail.com/

    You can find more instances by building with the leak-checker
    (you'll need to have a recent version of gcc or clang as your
    compiler):

      make SANITIZE=leak

    and then running individual test scripts, seeing what fails, and
    investigating the leak-checker output. There's a bit more discussion
    in the cover letter here:

      https://public-inbox.org/git/20170905130149.agc3zp3s6i6e5aki@sigill.intra.peff.net/

    Even though the patches are relatively small, there are a lot of
    things to learn here about building Git and running the tests. Don't
    hesitate to ask if you get stuck.

  - We've started marking small unfinished tasks with the
    "#leftoverbits" tag in emails, which can then be searched in the
    mailing list archive:

       https://public-inbox.org/git/?q=leftoverbits

    We don't use a formal bug-tracker, so this is a good way of seeing
    which discussions people feel newcomers may be able to jump in on.
    You may need to read the surrounding thread to get context, but
    again, don't hesitate to ask if you need help figuring out exactly
    what the task is or how it should be done.

-Peff
