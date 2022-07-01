Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F30AC433EF
	for <git@archiver.kernel.org>; Fri,  1 Jul 2022 21:05:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231981AbiGAVFW (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 1 Jul 2022 17:05:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232119AbiGAVFV (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 Jul 2022 17:05:21 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A4B26B247
        for <git@vger.kernel.org>; Fri,  1 Jul 2022 14:05:20 -0700 (PDT)
Received: (qmail 11576 invoked by uid 109); 1 Jul 2022 21:05:19 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 01 Jul 2022 21:05:19 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 29861 invoked by uid 111); 1 Jul 2022 21:05:19 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 01 Jul 2022 17:05:19 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 1 Jul 2022 17:05:19 -0400
From:   Jeff King <peff@peff.net>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, pclouds@gmail.com
Subject: Re: [PATCH] pack-objects.h: remove outdated pahole results
Message-ID: <Yr9hj19gmoiArVat@coredump.intra.peff.net>
References: <1379af2e9d271b501ef3942398e7f159a9c77973.1656440978.git.me@ttaylorr.com>
 <Yr85+tcexG2geaPP@coredump.intra.peff.net>
 <Yr9Pg9mRQWe1tgE+@nand.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Yr9Pg9mRQWe1tgE+@nand.local>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jul 01, 2022 at 03:48:19PM -0400, Taylor Blau wrote:

> > I agree the actual numbers aren't helping anybody. We _could_ leave a
> > comment that says "we store a lot of these in memory; be careful of
> > where and how you add new fields to avoid increasing the struct size".
> > And then people can run "pahole" before and after their changes.
> >
> > But then that is also true of other structs (like "struct object"), and
> > we do not bother there. So it probably is fine not to annotate this
> > specifically.
> 
> We have such a comment at the very type of the block comment above
> `struct object_entry`'s definition:
> 
>     "The size of struct nearly determines pack-object's memory
>     consumption. This struct is packed tight for that reason. When you
>     add or reorder something in this struct, think a bit about this".
> 
> thanks to Duy back in 3b13a5f263 (pack-objects: reorder members to
> shrink struct object_entry, 2018-04-14).

Oh, indeed. Then I withdraw my (non-)complaint. :)

-Peff
