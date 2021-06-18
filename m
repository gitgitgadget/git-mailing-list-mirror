Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E24BC48BDF
	for <git@archiver.kernel.org>; Fri, 18 Jun 2021 19:48:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5AC6C6128C
	for <git@archiver.kernel.org>; Fri, 18 Jun 2021 19:48:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232033AbhFRTuU (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 18 Jun 2021 15:50:20 -0400
Received: from cloud.peff.net ([104.130.231.41]:60660 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229591AbhFRTuT (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Jun 2021 15:50:19 -0400
Received: (qmail 28808 invoked by uid 109); 18 Jun 2021 19:48:09 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 18 Jun 2021 19:48:09 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 19659 invoked by uid 111); 18 Jun 2021 19:48:09 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 18 Jun 2021 15:48:09 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 18 Jun 2021 15:48:08 -0400
From:   Jeff King <peff@peff.net>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     git@vger.kernel.org,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] t: use portable wrapper for readlink(1)
Message-ID: <YMz4eFmwFuPv3Ke+@coredump.intra.peff.net>
References: <YMzKlrmHFZdx2ti9@coredump.intra.peff.net>
 <YMzwWxkQXjDT+mi+@camp.crustytoothpaste.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YMzwWxkQXjDT+mi+@camp.crustytoothpaste.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jun 18, 2021 at 07:13:31PM +0000, brian m. carlson wrote:

> > This is a re-post that doesn't seem to have made it into "seen"; the
> > original[1] was buried in a thread, but Ævar reported there that it
> > fixes t3210 on his AIX build.
> >
> > [1] https://lore.kernel.org/git/YLk0Zm2J6VOA%2Flks@coredump.intra.peff.net/
> 
> In case I didn't say it up in the previous post, this looks fine to me.
> Using Perl here seems like a fine solution.  If we needed to in the
> future, we could add this to test-tool and use the real readlink(2), but
> we can hold off until we decide we need to.

Agreed on all counts (if we do want to drop perl from the test suite,
there are a lot of these little one-liners that would need converting).

Thanks.

-Peff
