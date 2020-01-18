Return-Path: <SRS0=dClv=3H=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8062BC32771
	for <git@archiver.kernel.org>; Sat, 18 Jan 2020 03:38:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 44F3024656
	for <git@archiver.kernel.org>; Sat, 18 Jan 2020 03:38:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726761AbgARDe4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 17 Jan 2020 22:34:56 -0500
Received: from cloud.peff.net ([104.130.231.41]:39368 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726566AbgARDe4 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Jan 2020 22:34:56 -0500
Received: (qmail 15467 invoked by uid 109); 18 Jan 2020 03:34:56 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Sat, 18 Jan 2020 03:34:56 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 21764 invoked by uid 111); 18 Jan 2020 03:41:29 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 17 Jan 2020 22:41:29 -0500
Authentication-Results: peff.net; auth=none
Date:   Fri, 17 Jan 2020 22:34:55 -0500
From:   Jeff King <peff@peff.net>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH] Makefile: use compat regex with SANITIZE=address
Message-ID: <20200118033455.GA33232@coredump.intra.peff.net>
References: <20200116175138.GA691238@coredump.intra.peff.net>
 <xmqqr1zydlwt.fsf@gitster-ct.c.googlers.com>
 <20200117174931.GA8958@coredump.intra.peff.net>
 <20200117233931.GB6570@camp.crustytoothpaste.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200117233931.GB6570@camp.crustytoothpaste.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jan 17, 2020 at 11:39:31PM +0000, brian m. carlson wrote:

> > I don't think there's a huge rush. It only triggers ASan and recent
> > compilers, so AFAIK nobody has been hitting this in CI. I occasionally
> > test with whatever is the most recent compiler in Debian unstable to see
> > if it turns up any interesting new warnings or errors (but gcc-9 is
> > still the default there).
> 
> I've reported this as a bug to Debian on the clang-8 and libasan6
> packages, along with a trivial test case.  Hopefully this will get fixed
> soon.

Thanks. I'm not entirely convinced it's a bug (after all, we are
squatting on a well-known POSIX function name), but we'll see what they
say. :)

-Peff
