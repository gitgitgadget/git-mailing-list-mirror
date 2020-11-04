Return-Path: <SRS0=V3lj=EK=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0DB5C2D0A3
	for <git@archiver.kernel.org>; Wed,  4 Nov 2020 17:13:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AE0042075E
	for <git@archiver.kernel.org>; Wed,  4 Nov 2020 17:13:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731175AbgKDRNq (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 4 Nov 2020 12:13:46 -0500
Received: from cloud.peff.net ([104.130.231.41]:47508 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730362AbgKDRNq (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 4 Nov 2020 12:13:46 -0500
Received: (qmail 10387 invoked by uid 109); 4 Nov 2020 17:13:46 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 04 Nov 2020 17:13:46 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 12290 invoked by uid 111); 4 Nov 2020 17:13:45 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 04 Nov 2020 12:13:45 -0500
Authentication-Results: peff.net; auth=none
Date:   Wed, 4 Nov 2020 12:13:44 -0500
From:   Jeff King <peff@peff.net>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Johannes Postler <johannes.postler@txture.io>,
        Git List <git@vger.kernel.org>
Subject: Re: [PATCH 1/3] format-patch: refactor output selection
Message-ID: <20201104171344.GA3047090@coredump.intra.peff.net>
References: <20201104132428.GA2491189@coredump.intra.peff.net>
 <20201104132522.GA3030146@coredump.intra.peff.net>
 <CAPig+cRG4uPL1TDpEOgOZwSEJfyt-d0XmsVz3hcCebgwbO_v_A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAPig+cRG4uPL1TDpEOgOZwSEJfyt-d0XmsVz3hcCebgwbO_v_A@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Nov 04, 2020 at 12:01:53PM -0500, Eric Sunshine wrote:

> > diff --git a/builtin/log.c b/builtin/log.c
> > @@ -1942,20 +1942,20 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
> > +       if (use_stdout + !!output_directory > 1)
> > +               die(_("specify only one of --stdout, --output, and --output-directory"));
> 
> Is mention of --output intentional here? The commit message only talks
> about --stdout and --output-directory.

Whoops, thanks. I wrote this line after adding the new feature, but
forgot to revise it when I rebased.

> It's subjective, but "mutually exclusive" sounds a bit more consistent
> with other similar error messages elsewhere:
> 
>     --stdout, --output, and --output-directory are mutually exclusive

Yeah, that reads better. I remember I reworded it a few times to try to
get it not-awkward, but I'm not sure how I failed to come up with that
quite obvious wording. ;)

-Peff
