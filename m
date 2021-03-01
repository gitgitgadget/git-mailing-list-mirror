Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4987C433E6
	for <git@archiver.kernel.org>; Mon,  1 Mar 2021 09:53:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 83DC164E40
	for <git@archiver.kernel.org>; Mon,  1 Mar 2021 09:53:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234280AbhCAJxY (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 1 Mar 2021 04:53:24 -0500
Received: from cloud.peff.net ([104.130.231.41]:47884 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234374AbhCAJwY (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 Mar 2021 04:52:24 -0500
Received: (qmail 4611 invoked by uid 109); 1 Mar 2021 09:51:41 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 01 Mar 2021 09:51:41 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 21830 invoked by uid 111); 1 Mar 2021 09:51:41 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 01 Mar 2021 04:51:41 -0500
Authentication-Results: peff.net; auth=none
Date:   Mon, 1 Mar 2021 04:51:40 -0500
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Lars Schneider <larsxschneider@gmail.com>,
        git <git@vger.kernel.org>,
        SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
Subject: Re: [PATCH/RFC] test-lib: make --verbose work under prove
Message-ID: <YDy5LDsnF1THmvUw@coredump.intra.peff.net>
References: <20161021104107.vh3bjx6x6pd6izat@sigill.intra.peff.net>
 <20161021104759.hx6q7u66r3ll7l44@sigill.intra.peff.net>
 <87tupwj5y5.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87tupwj5y5.fsf@evledraar.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Feb 28, 2021 at 09:25:06PM +0100, Ævar Arnfjörð Bjarmason wrote:

> As explained in 452320f1f5 (test-lib: add --verbose-log option,
> 2016-10-21) combining the "--verbose" option with the TAP-parsing
> "prove" utility would result in broken tests.
> 
> This is because "prove" expects valid TAP on stdout, and if there's a
> stray line starting with "ok", or other invalid TAP syntax it will
> error on the test.
> 
> In 452320f1f5 numerous potential methods are discussed for dealing
> with this problem, but not the one implemented here, which I think is
> a much simpler approach.

I guess I don't really have an objection to this method existing, but I
don't see the point of it now. The original problem has been solved, and
I don't find this any simpler than --verbose-log (on the contrary, I
find it much more complicated). So I don't know why I would want to use
this instead.

-Peff
