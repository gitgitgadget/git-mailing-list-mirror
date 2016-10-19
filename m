Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3CD1120986
	for <e@80x24.org>; Wed, 19 Oct 2016 21:21:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755449AbcJSVVG (ORCPT <rfc822;e@80x24.org>);
        Wed, 19 Oct 2016 17:21:06 -0400
Received: from cloud.peff.net ([104.130.231.41]:59690 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753897AbcJSVVF (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Oct 2016 17:21:05 -0400
Received: (qmail 19536 invoked by uid 109); 19 Oct 2016 21:21:04 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 19 Oct 2016 21:21:04 +0000
Received: (qmail 17904 invoked by uid 111); 19 Oct 2016 21:21:26 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 19 Oct 2016 17:21:26 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 19 Oct 2016 17:21:02 -0400
Date:   Wed, 19 Oct 2016 17:21:02 -0400
From:   Jeff King <peff@peff.net>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Junio C Hamano <gitster@pobox.com>,
        Lars Schneider <larsxschneider@gmail.com>, git@vger.kernel.org
Subject: Re: What's cooking in git.git (Oct 2016, #04; Mon, 17)
Message-ID: <20161019212102.ibzkvutzjjq7yjom@sigill.intra.peff.net>
References: <xmqqtwcasj8y.fsf@gitster.mtv.corp.google.com>
 <9F780406-FC77-4B3E-AEEB-7F6215E6702C@gmail.com>
 <xmqq4m49pffk.fsf@gitster.mtv.corp.google.com>
 <20161019074648.nuk2c2mpvmedjrhb@sigill.intra.peff.net>
 <20161019202856.7ld3kpsnjwu6dbwl@vauxhall.crustytoothpaste.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20161019202856.7ld3kpsnjwu6dbwl@vauxhall.crustytoothpaste.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Oct 19, 2016 at 08:28:56PM +0000, brian m. carlson wrote:

> On Wed, Oct 19, 2016 at 03:46:48AM -0400, Jeff King wrote:
> > FWIW, I gave it a fairly thorough read-over (something I'd been meaning
> > to do for quite a while, but kept never quite getting around to). I
> > think overall it is OK for next. I did find one or two nits, but I think
> > they are things we can fix up in-tree if and when they become a problem
> > (e.g., I noticed that test-genrandom gets piped to "perl -pe". I'm not
> > sure if perl will complain about funny multibyte characters on some
> > systems. I suggest we ignore it until somebody demonstrates that it
> > actually matters).
> 
> I just looked, and that use is fine.  perl -pe is always going to treat
> its data as bytes unless you use -C or explicitly enable Unicode
> functionality.

Thanks. I have vague memories of multibyte warnings, but I think they
may have been on _output_ when passing through binary data that came
on stdin.

-Peff
