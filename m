Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1EE0CDB47E
	for <git@archiver.kernel.org>; Wed, 11 Oct 2023 22:52:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233790AbjJKWwv (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 11 Oct 2023 18:52:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233761AbjJKWwu (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Oct 2023 18:52:50 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D25E8A4
        for <git@vger.kernel.org>; Wed, 11 Oct 2023 15:52:45 -0700 (PDT)
Received: (qmail 20343 invoked by uid 109); 11 Oct 2023 22:52:45 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 11 Oct 2023 22:52:45 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 11099 invoked by uid 111); 11 Oct 2023 22:52:46 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 11 Oct 2023 18:52:46 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 11 Oct 2023 18:52:43 -0400
From:   Jeff King <peff@peff.net>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 03/20] midx: stop ignoring malformed oid fanout chunk
Message-ID: <20231011225243.GG518221@coredump.intra.peff.net>
References: <20231009205544.GA3281950@coredump.intra.peff.net>
 <20231009205919.GC3282181@coredump.intra.peff.net>
 <ZSXjR6BjvaokNwPe@nand.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZSXjR6BjvaokNwPe@nand.local>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Oct 10, 2023 at 07:50:31PM -0400, Taylor Blau wrote:

> All makes sense. I have a mild preference for "missing or corrupt" over
> "missing or corrupted", but it's mild enough that I wouldn't be sad if
> you kept it as-is ;-).

Hmm, now I wonder which is grammatically more appropriate.

According to the internet (which is never wrong), the distinction is
generally one of intrinsic corrupt state versus something that has
become corrupted. So I guess it depends on whether the file was created
corrupt by a bug or corrupted by a hard disk failure. ;)

I do not have a strong preference myself. The commits went into next
already, but I think you also pointed out that many of these could be
marked for translation (though this one is already).

So we could do one or two patches to adjust the error messages on top.

-Peff
