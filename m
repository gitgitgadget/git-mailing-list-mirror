Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4CAF8203BD
	for <e@80x24.org>; Wed, 26 Oct 2016 20:26:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933879AbcJZU04 (ORCPT <rfc822;e@80x24.org>);
        Wed, 26 Oct 2016 16:26:56 -0400
Received: from cloud.peff.net ([104.130.231.41]:34523 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933448AbcJZU0z (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Oct 2016 16:26:55 -0400
Received: (qmail 31418 invoked by uid 109); 26 Oct 2016 20:26:55 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 26 Oct 2016 20:26:55 +0000
Received: (qmail 14118 invoked by uid 111); 26 Oct 2016 20:27:19 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 26 Oct 2016 16:27:19 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 26 Oct 2016 16:26:52 -0400
Date:   Wed, 26 Oct 2016 16:26:52 -0400
From:   Jeff King <peff@peff.net>
To:     Johannes Sixt <j6t@kdbg.org>
Cc:     Stefan Beller <sbeller@google.com>,
        Simon Ruderich <simon@ruderich.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        Brandon Williams <bmwill@google.com>,
        Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH 27/36] attr: convert to new threadsafe API
Message-ID: <20161026202652.kz63mxqqjan7swvl@sigill.intra.peff.net>
References: <20161022233225.8883-1-sbeller@google.com>
 <20161022233225.8883-28-sbeller@google.com>
 <alpine.DEB.2.20.1610261049470.3264@virtualbox>
 <20161026093558.drsdwn2hm7bbcktt@ruderich.org>
 <20161026121525.twgiavpgfbr2ahvn@sigill.intra.peff.net>
 <CAGZ79kYgk9rQDju0MT2uniaxhAWpzJ9f1T9czgNnxfq+Wz6m+A@mail.gmail.com>
 <e1f760f5-27a7-8266-5d6c-d61fab7e194d@kdbg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <e1f760f5-27a7-8266-5d6c-d61fab7e194d@kdbg.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Oct 26, 2016 at 10:25:38PM +0200, Johannes Sixt wrote:

> Am 26.10.2016 um 21:51 schrieb Stefan Beller:
> > it is
> > very convenient to not have to explicitly initialize mutexes?
> 
> Not to initialize a mutex is still wrong for pthreads.

I think Stefan was being loose with his wording. There would still be an
initializer, but it would be a constant (and in the case of pthread
emulation on Windows, would just be NULL).

-Peff
