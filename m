Return-Path: <SRS0=R9sp=CF=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86B7CC433DF
	for <git@archiver.kernel.org>; Thu, 27 Aug 2020 04:25:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5E675206D8
	for <git@archiver.kernel.org>; Thu, 27 Aug 2020 04:25:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725988AbgH0EZb (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 27 Aug 2020 00:25:31 -0400
Received: from cloud.peff.net ([104.130.231.41]:42204 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725847AbgH0EZb (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Aug 2020 00:25:31 -0400
Received: (qmail 13169 invoked by uid 109); 27 Aug 2020 04:25:31 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 27 Aug 2020 04:25:31 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 22408 invoked by uid 111); 27 Aug 2020 04:25:30 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 27 Aug 2020 00:25:30 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 27 Aug 2020 00:25:30 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Sergey Organov <sorganov@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH] pretty-options.txt: fix --no-abbrev-commit description
Message-ID: <20200827042530.GE3346457@coredump.intra.peff.net>
References: <20200826144923.16806-1-sorganov@gmail.com>
 <xmqqv9h5uw7u.fsf@gitster.c.googlers.com>
 <87pn7d9inu.fsf@osv.gnss.ru>
 <xmqqr1rtt613.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqr1rtt613.fsf@gitster.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Aug 26, 2020 at 03:07:52PM -0700, Junio C Hamano wrote:

> Sergey Organov <sorganov@gmail.com> writes:
> 
> >> Keeping the original sentence structure, e.g.
> >>
> >>     ... and those options which imply abbreviating commit object names
> >>     such as ...
> >>
> >> would have been what I wrote, instead of "either explicit or implied
> >> by", though.
> >
> > Sorry, but it'd then read:
> >
> >   This negates `--abbrev-commit` and those options which imply
> >   abbreviating commit object names such as "--oneline".
> >
> > that again essentially reduces to:
> >
> >   This negates "--oneline"
> 
> "--oneline" means a lot more than "do not use full object name", and
> I think we are on the same page with our shared goal of not negating
> everything "--oneline" means.  We just want to say the option
> negates only the "do not use full object name" aspect.
> 
> "and the effect of abbreviating commit objects implied by other
> options, such as '--oneline'" may be a more verbose way to say the
> same thing, I would think, but that would be overkill.  I would have
> expected that with common sense readers would think it would be
> crazy for --no-abbrev to override everything --oneline means, but if
> you found that the original risks such an interpretation, perhaps we
> would need to be more verbose and explicit.  I dunno.

FWIW, as a third-party observer (because you wanted more opinions,
right?), I found the result of Sergey's original patch easy to read and
understand.

I also think it's unlikely for people to misinterpret the current text,
but it does not hurt to be more precise just in case.

-Peff
