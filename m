Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 245D020229
	for <e@80x24.org>; Thu, 10 Nov 2016 21:55:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934806AbcKJVy6 (ORCPT <rfc822;e@80x24.org>);
        Thu, 10 Nov 2016 16:54:58 -0500
Received: from cloud.peff.net ([104.130.231.41]:41362 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751713AbcKJVy5 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Nov 2016 16:54:57 -0500
Received: (qmail 13209 invoked by uid 109); 10 Nov 2016 21:54:57 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 10 Nov 2016 21:54:57 +0000
Received: (qmail 8313 invoked by uid 111); 10 Nov 2016 21:55:26 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 10 Nov 2016 16:55:26 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 10 Nov 2016 16:54:55 -0500
Date:   Thu, 10 Nov 2016 16:54:55 -0500
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Lars Schneider <larsxschneider@gmail.com>,
        Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>,
        git <git@vger.kernel.org>
Subject: Re: [PATCH v1 2/2] travis-ci: disable GIT_TEST_HTTPD for macOS
Message-ID: <20161110215454.zcphqxzkvt4mlpwb@sigill.intra.peff.net>
References: <20161017002550.88782-1-larsxschneider@gmail.com>
 <20161017002550.88782-3-larsxschneider@gmail.com>
 <203BDCB2-1975-4590-B4B8-3C5E9D210430@gmail.com>
 <20161107212004.x4y7bcl2p4chfkm6@sigill.intra.peff.net>
 <CBAF806C-7E1E-4490-A07C-F98DB7488F5F@gmail.com>
 <20161110161012.jube4bwbww2wa2ew@sigill.intra.peff.net>
 <xmqq1syj6mvq.fsf@gitster.mtv.corp.google.com>
 <20161110214345.cau5i4eybqdv74k3@sigill.intra.peff.net>
 <xmqqk2cb57jz.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqk2cb57jz.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Nov 10, 2016 at 01:49:52PM -0800, Junio C Hamano wrote:

> Yes, I recall the IIS one raised and discussed at least twice on the
> list in the past, and it sounded that we want some solution to that.

The patches had some issues. I suspect the population of people who want
to run a git server on IIS is relatively small. I am content to wait for
somebody who has such a setup to produce a working patch.

> >   3. What happens when you ask for "foo.git/info/refs" and "foo.git" is
> >      a bundle file (Apache gives you a 404, lighttpd serves the bundle).
> 
> That's a bad one.  Do we want a client-side "I am connecting to a
> site that knows how to talk smart-http" option or something to work
> it around?

It doesn't matter because we don't actually support fetching HTTP
bundles via "git fetch" yet.

But I ran it across the issue and did make such a fix when I was
implementing that feature long ago. See the discussion of "surprise" in
[1] and [2].

Wow, that series is exactly 5 years old today. Have I really been
procrastinating on re-rolling it that long? Yikes.

-Peff

[1] http://public-inbox.org/git/20111110075052.GI27950@sigill.intra.peff.net/

[2] http://public-inbox.org/git/20111110075052.GI27950@sigill.intra.peff.net/
