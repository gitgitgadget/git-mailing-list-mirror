Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A356C4338F
	for <git@archiver.kernel.org>; Tue, 27 Jul 2021 12:44:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 37CE361A4F
	for <git@archiver.kernel.org>; Tue, 27 Jul 2021 12:44:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232013AbhG0Mom (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 27 Jul 2021 08:44:42 -0400
Received: from cloud.peff.net ([104.130.231.41]:58492 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231840AbhG0Mol (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Jul 2021 08:44:41 -0400
Received: (qmail 30191 invoked by uid 109); 27 Jul 2021 12:44:41 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 27 Jul 2021 12:44:41 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 30721 invoked by uid 111); 27 Jul 2021 12:44:40 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 27 Jul 2021 08:44:40 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 27 Jul 2021 08:44:40 -0400
From:   Jeff King <peff@peff.net>
To:     Evan Miller <emmiller@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: Exit code 255 after large clone (32-bit PowerPC)
Message-ID: <YP//uBa+VTzusgjr@coredump.intra.peff.net>
References: <D3C1583B-8CC8-434B-8AF5-B9827A7FD037@gmail.com>
 <YP8ykvsZie4mPE5o@camp.crustytoothpaste.net>
 <874kcgsh94.fsf@evledraar.gmail.com>
 <YP9jU194U7S1PFxS@camp.crustytoothpaste.net>
 <xmqq8s1sfqez.fsf@gitster.g>
 <372227AB-E4CF-42B6-9B08-261037F39B49@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <372227AB-E4CF-42B6-9B08-261037F39B49@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jul 26, 2021 at 11:05:27PM -0400, Evan Miller wrote:

> The described symptoms match what I am seeing. It makes sense that
> ancient hardware would bring out the bug – triggering the server
> timeout with a long local computation.
> 
> Switching to protocol 0 successfully works around the issue. This
> concludes my interest in the error. I suggest reviving a discussion of
> Jeff King's patch here:
> 
> https://lore.kernel.org/git/YKU4mbq%2Fam%2FliAN4@coredump.intra.peff.net/

Yeah, everything you've described is consistent with the problem being
fixed there. Good news, then: the patch is already in Git's "master"
branch, and will be part of the next release (which should be v2.33.0).

If you can reproduce the problem at will and building from master isn't
too hard, it would be nice to know if that indeed fixes it for you.

-Peff
