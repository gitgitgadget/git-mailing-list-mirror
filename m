Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FCDEC433F5
	for <git@archiver.kernel.org>; Tue, 21 Sep 2021 14:27:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5315A60F9E
	for <git@archiver.kernel.org>; Tue, 21 Sep 2021 14:27:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233486AbhIUO2y (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 21 Sep 2021 10:28:54 -0400
Received: from cloud.peff.net ([104.130.231.41]:51728 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229577AbhIUO2x (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Sep 2021 10:28:53 -0400
Received: (qmail 5705 invoked by uid 109); 21 Sep 2021 14:27:24 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 21 Sep 2021 14:27:24 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 929 invoked by uid 111); 21 Sep 2021 14:27:23 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 21 Sep 2021 10:27:23 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 21 Sep 2021 10:27:23 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Hamza Mahfooz <someguy@effective-light.com>
Subject: Re: [PATCH 4/5] grep: mark "haystack" buffers as const
Message-ID: <YUnry6IgLyf5LI6g@coredump.intra.peff.net>
References: <YUlVZk1xXulAqdef@coredump.intra.peff.net>
 <YUlWXRYv1KtZrxZ6@coredump.intra.peff.net>
 <87h7ee9lsf.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87h7ee9lsf.fsf@evledraar.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Sep 21, 2021 at 02:04:12PM +0200, Ævar Arnfjörð Bjarmason wrote:

> 
> On Mon, Sep 20 2021, Jeff King wrote:
> 
> > -static int patmatch(struct grep_pat *p, char *line, char *eol,
> > +static int patmatch(struct grep_pat *p,
> > +		    const char *line, const char *eol,
> >  		    regmatch_t *match, int eflags)
> 
> nit; not worth a re-roll, over-line-wrapping here? You usually stay at
> column 79. In this case both line and eol would fit on the patmatch()
> lin, which is being changed anyway...

True. I had to wrap all the others (and IMHO it is worth keeping "line"
and "eol" together), but I didn't calculate that this one can actually
fit the whole thing.

I dunno that it matters. The wrapping is consistent with the others,
even if it is not maximally filling the line.

-Peff
