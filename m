Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADC55C4338F
	for <git@archiver.kernel.org>; Thu, 29 Jul 2021 13:04:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 846EA6056C
	for <git@archiver.kernel.org>; Thu, 29 Jul 2021 13:04:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237278AbhG2NEr (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 29 Jul 2021 09:04:47 -0400
Received: from cloud.peff.net ([104.130.231.41]:60738 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237222AbhG2NEp (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Jul 2021 09:04:45 -0400
Received: (qmail 8477 invoked by uid 109); 29 Jul 2021 13:04:41 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 29 Jul 2021 13:04:41 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 19354 invoked by uid 111); 29 Jul 2021 13:04:41 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 29 Jul 2021 09:04:41 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 29 Jul 2021 09:04:40 -0400
From:   Jeff King <peff@peff.net>
To:     Andrei Rybak <rybak.a.v@gmail.com>
Cc:     git@vger.kernel.org, Thomas Ackermann <th.acker@arcor.de>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Documentation: render special characters correctly
Message-ID: <YQKnaCcfJaagTF/h@coredump.intra.peff.net>
References: <20210729110252.116214-1-rybak.a.v@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210729110252.116214-1-rybak.a.v@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jul 29, 2021 at 01:02:52PM +0200, Andrei Rybak wrote:

> Three hyphens are rendered verbatim, so "--" has to be used to produce a
> dash.  There is no double arrow ("<->" is rendered as "<→"), so a left
> and right arrow "<-->" have to be combined for that.
> 
> So fix asciidoc output for special characters.  This is similar to fixes
> in commit de82095a95 (doc hash-function-transition: fix asciidoc output,
> 2021-02-05).

Thanks. I looked at the doc-diff output before and after this patch, and
they both seem like strict improvements.

The double-arrow thing is kind of weird to me in the first place,
though. I suspect it might be more clear if it just spelled out what it
is trying to say with words. Something like:

  The pruning feature doesn't actually care about branches. Instead, it
  will prune local refs tracking remote ones as a function of...

But I'm OK to leave that to do on top; the current code simply renders
incorrectly, and your patch is fixing that.

-Peff
