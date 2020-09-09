Return-Path: <SRS0=gV3S=CS=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80792C433E2
	for <git@archiver.kernel.org>; Wed,  9 Sep 2020 09:15:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3FBB920708
	for <git@archiver.kernel.org>; Wed,  9 Sep 2020 09:15:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729614AbgIIJPZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Sep 2020 05:15:25 -0400
Received: from cloud.peff.net ([104.130.231.41]:51880 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728207AbgIIJPW (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Sep 2020 05:15:22 -0400
Received: (qmail 3426 invoked by uid 109); 9 Sep 2020 09:15:21 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 09 Sep 2020 09:15:21 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 32171 invoked by uid 111); 9 Sep 2020 09:15:23 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 09 Sep 2020 05:15:23 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 9 Sep 2020 05:15:20 -0400
From:   Jeff King <peff@peff.net>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     git@vger.kernel.org, Tom Hale <tomnott@gmail.com>
Subject: Re: [PATCH 2/2] add--interactive.perl: specify --no-color explicitly
Message-ID: <20200909091520.GC2496536@coredump.intra.peff.net>
References: <20200907080632.GA1261825@coredump.intra.peff.net>
 <20200907081739.GB1263923@coredump.intra.peff.net>
 <nycvar.QRO.7.76.6.2009082047220.54@tvgsbejvaqbjf.bet>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <nycvar.QRO.7.76.6.2009082047220.54@tvgsbejvaqbjf.bet>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Sep 08, 2020 at 08:51:31PM +0200, Johannes Schindelin wrote:

> > One could argue that the test isn't very realistic; it's setting up this
> > "pretend there's a pager" situation to get around the tty restrictions
> > of the test environment. So one option would be to move back towards
> > using a real tty. [...]
> 
> The main reason why we moved away from the "real" TTY is that the TTY we
> simulate in `t/test-terminal.perl` is not actually real at all on Windows.
> Instead, it is the Cygwin/MSYS2-emulated version of a PTY, and as a
> consequence `git.exe` simply has no way of accessing it.
> 
> Which means that by moving "back towards using a real tty" we would lose
> all test coverage on Windows, which is not a thought I like to entertain.

Yeah, regressing the improvements done by 8539b46534 (t3701: avoid
depending on the TTY prerequisite, 2019-12-06) was definitely part of my
motivation, but I guess I didn't spell that out completely.

-Peff
