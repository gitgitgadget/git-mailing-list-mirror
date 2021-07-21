Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45399C6377A
	for <git@archiver.kernel.org>; Wed, 21 Jul 2021 11:24:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3055060FF3
	for <git@archiver.kernel.org>; Wed, 21 Jul 2021 11:24:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237238AbhGUKni (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 21 Jul 2021 06:43:38 -0400
Received: from cloud.peff.net ([104.130.231.41]:52982 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238592AbhGUJ2A (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Jul 2021 05:28:00 -0400
Received: (qmail 1860 invoked by uid 109); 21 Jul 2021 10:08:00 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 21 Jul 2021 10:08:00 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 2832 invoked by uid 111); 21 Jul 2021 10:08:20 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 21 Jul 2021 06:08:20 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 21 Jul 2021 06:08:18 -0400
From:   Jeff King <peff@peff.net>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, dstolee@microsoft.com, gitster@pobox.com,
        jonathantanmy@google.com
Subject: Re: [PATCH v2 04/24] Documentation: build 'technical/bitmap-format'
 by default
Message-ID: <YPfyEiXw7szt5mjl@coredump.intra.peff.net>
References: <cover.1617991824.git.me@ttaylorr.com>
 <cover.1624314293.git.me@ttaylorr.com>
 <b0bb2e8051f19ec47140fda6500e092e37c6bea8.1624314293.git.me@ttaylorr.com>
 <YPfv0YoLtpYp9866@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YPfv0YoLtpYp9866@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jul 21, 2021 at 05:58:41AM -0400, Jeff King wrote:

> On Mon, Jun 21, 2021 at 06:25:07PM -0400, Taylor Blau wrote:
> 
> > Even though the 'TECH_DOCS' variable was introduced all the way back in
> > 5e00439f0a (Documentation: build html for all files in technical and
> > howto, 2012-10-23), the 'bitmap-format' document was never added to that
> > list when it was created.
> > 
> > Prepare for changes to this file by including it in the list of
> > technical documentation that 'make doc' will build by default.
> 
> OK. I don't care that much about being able to format this as html, but
> I agree it's good to be consistent with the other stuff in technical/.
> 
> The big question is whether it looks OK rendered by asciidoc, and the
> answer seems to be "yes" (from a cursory look I gave it).

Actually, I take it back. After looking more carefully, it renders quite
poorly. There's a lot of structural indentation that ends up being
confused as code blocks.

I don't know if it's better to have a poorly-formatted HTML file, or
none at all. :)

Personally, I would just read the source. And I have a slight concern
that if we start "cleaning it up" to render as asciidoc, the source
might end up a lot less readable (though I'd reserve judgement until
actually seeing it).

-Peff
