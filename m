Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 703F4C433F5
	for <git@archiver.kernel.org>; Tue, 11 Oct 2022 02:03:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229637AbiJKCDH (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 10 Oct 2022 22:03:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbiJKCDG (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Oct 2022 22:03:06 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD1D17549E
        for <git@vger.kernel.org>; Mon, 10 Oct 2022 19:03:05 -0700 (PDT)
Received: (qmail 30095 invoked by uid 109); 11 Oct 2022 02:03:05 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 11 Oct 2022 02:03:05 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 16511 invoked by uid 111); 11 Oct 2022 02:03:06 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 10 Oct 2022 22:03:06 -0400
Authentication-Results: peff.net; auth=none
Date:   Mon, 10 Oct 2022 22:03:04 -0400
From:   Jeff King <peff@peff.net>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, jacob@initialcommit.io, gitster@pobox.com
Subject: Re: [PATCH 4/7] shortlog: support arbitrary commit format `--group`s
Message-ID: <Y0TO2I3PmUjJ5926@coredump.intra.peff.net>
References: <cover.1665448437.git.me@ttaylorr.com>
 <6f38990cc2ea8460ce37437e0770784d9b712dab.1665448437.git.me@ttaylorr.com>
 <Y0TDDvzeCxIMFbG5@coredump.intra.peff.net>
 <Y0TF0M6UzLS9r6iM@nand.local>
 <Y0TGuFDhoG1Nu6ND@nand.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Y0TGuFDhoG1Nu6ND@nand.local>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Oct 10, 2022 at 09:28:24PM -0400, Taylor Blau wrote:

> On Mon, Oct 10, 2022 at 09:24:32PM -0400, Taylor Blau wrote:
> > > Makes sense. Two other tests that might be worth including:
> > >
> > >   - "shortlog --group=bogus" generates an error (we might already have
> > >     such a test; I didn't check)
> >
> > We didn't have such a test before, so adding one is a good call, thanks!
> 
> Just writing back to say that this was a really good suggestion, since
> it caught my mistake in writing:
> 
>     } else if (strchrnul(arg, '%')) {
> 
> since we'll always get back a non-NULL answer from calling `strchrnul`
> instead of `strchr`.

I'm going to pretend that I noticed that bug and was gently leading you
to it, rather than that I was oblivious and lucky.

-Peff
