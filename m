Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9F38C203E2
	for <e@80x24.org>; Thu, 10 Nov 2016 16:10:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934596AbcKJQKQ (ORCPT <rfc822;e@80x24.org>);
        Thu, 10 Nov 2016 11:10:16 -0500
Received: from cloud.peff.net ([104.130.231.41]:41158 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934511AbcKJQKP (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Nov 2016 11:10:15 -0500
Received: (qmail 24299 invoked by uid 109); 10 Nov 2016 16:10:14 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 10 Nov 2016 16:10:14 +0000
Received: (qmail 5270 invoked by uid 111); 10 Nov 2016 16:10:43 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 10 Nov 2016 11:10:43 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 10 Nov 2016 11:10:12 -0500
Date:   Thu, 10 Nov 2016 11:10:12 -0500
From:   Jeff King <peff@peff.net>
To:     Lars Schneider <larsxschneider@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>,
        git <git@vger.kernel.org>
Subject: Re: [PATCH v1 2/2] travis-ci: disable GIT_TEST_HTTPD for macOS
Message-ID: <20161110161012.jube4bwbww2wa2ew@sigill.intra.peff.net>
References: <20161017002550.88782-1-larsxschneider@gmail.com>
 <20161017002550.88782-3-larsxschneider@gmail.com>
 <203BDCB2-1975-4590-B4B8-3C5E9D210430@gmail.com>
 <20161107212004.x4y7bcl2p4chfkm6@sigill.intra.peff.net>
 <CBAF806C-7E1E-4490-A07C-F98DB7488F5F@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CBAF806C-7E1E-4490-A07C-F98DB7488F5F@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Nov 10, 2016 at 12:07:14PM +0100, Lars Schneider wrote:

> > Using Apache in the tests has been the source of frequent portability
> > problems and configuration headaches. I do wonder if we'd be better off
> > using some small special-purpose web server (even a short perl script
> > written around HTTP::Server::Simple or something).
> > 
> > On the other hand, testing against Apache approximates a more real-world
> > case, which has value. It might be nice if our tests supported multiple
> > web servers, but that would mean duplicating the config for each
> > manually.
> 
> I agree that the real-world Apache test is more valuable and I really want
> to keep the Linux Apache test running. However, I don't think many people
> use macOS as Git web server and therefore I thought it is not worth the
> effort to investigate this problem further.

IMHO, the value in the http tests is not testing the server side, but
the client side. Without being able to set up a dummy HTTP server, we do
not have any way to exercise the client side of git-over-http at all.
And people on macOS _do_ use that. :)

-Peff
