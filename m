Return-Path: <SRS0=QOHA=BI=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69F55C433DF
	for <git@archiver.kernel.org>; Wed, 29 Jul 2020 18:22:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 54E6820809
	for <git@archiver.kernel.org>; Wed, 29 Jul 2020 18:22:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726751AbgG2SWI (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 29 Jul 2020 14:22:08 -0400
Received: from cloud.peff.net ([104.130.231.41]:41342 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726336AbgG2SWI (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 Jul 2020 14:22:08 -0400
Received: (qmail 8140 invoked by uid 109); 29 Jul 2020 18:22:07 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 29 Jul 2020 18:22:07 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 7063 invoked by uid 111); 29 Jul 2020 18:22:07 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 29 Jul 2020 14:22:07 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 29 Jul 2020 14:22:06 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 2/3] revision: add "--ignore-merges" option to counteract
 "-m"
Message-ID: <20200729182206.GA2339835@coredump.intra.peff.net>
References: <20200728163617.GA2649887@coredump.intra.peff.net>
 <20200728163853.GB2650252@coredump.intra.peff.net>
 <xmqqv9i7cq1k.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqv9i7cq1k.fsf@gitster.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jul 28, 2020 at 02:01:27PM -0700, Junio C Hamano wrote:

> >  -m::
> > +--no-ignore-merges::
> 
> This invites a natural "does --ignore-merges exist, and if so what
> does it do?"  Why not to have "--[no-]ignore-merges" as a separate
> entry immediately after the existing "-m" instead?

I was hoping it would all be implied and I could dodge those questions.
But it seems not. :)

After thinking on it more, I flipped it to:

  -m::
  --diff-merges::
     [existing text...]

and then I don't think we need to have another block for
--no-diff-merges.

I'll likewise add a statement that "-m" is implied by "--first-parent"
and can be counteracted with the "--no" form, which I think should spell
out all the implications of the series.

-Peff
