Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E14D720401
	for <e@80x24.org>; Sat, 24 Jun 2017 12:51:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751281AbdFXMvc (ORCPT <rfc822;e@80x24.org>);
        Sat, 24 Jun 2017 08:51:32 -0400
Received: from cloud.peff.net ([104.130.231.41]:51848 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1750817AbdFXMvb (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 24 Jun 2017 08:51:31 -0400
Received: (qmail 2870 invoked by uid 109); 24 Jun 2017 12:51:31 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Sat, 24 Jun 2017 12:51:31 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 23698 invoked by uid 111); 24 Jun 2017 12:51:36 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Sat, 24 Jun 2017 08:51:36 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 24 Jun 2017 08:51:29 -0400
Date:   Sat, 24 Jun 2017 08:51:29 -0400
From:   Jeff King <peff@peff.net>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org, gitster@pobox.com
Subject: Re: [PATCH v4 0/8] Improvements to sha1_file
Message-ID: <20170624125129.q6624q6rrrxrpljs@sigill.intra.peff.net>
References: <cover.1497035376.git.jonathantanmy@google.com>
 <cover.1497920092.git.jonathantanmy@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1497920092.git.jonathantanmy@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jun 19, 2017 at 06:03:07PM -0700, Jonathan Tan wrote:

> > I had the same thoughts (both on the name and the "vocabularies"). IMHO
> > we should consider allocating the bits from the same set. There's only
> > one HAS_SHA1 flag, and it has an exact match in OBJECT_INFO_QUICK.
> 
> Agreed - in this patch set, I have also consolidated the relevant flags,
> including LOOKUP_REPLACE_OBJECT and LOOKUP_UNKNOWN_OBJECT.
> 
> In addition, Junio has mentioned the potential confusion in behavior
> between a NULL and an empty struct passed to
> sha1_object_info_extended(). In this patch set, I require non-NULL, and
> have added an optimization that avoids accessing the pack in certain
> situations, but this optimization requires checking a lot of fields. Let
> me know what you think.

Yes, like that direction (and the direction of the whole series) much
better. Thanks for working on it.

I'm trying to clear my "to be reviewed" backlog before going offline for
a week, so I gave it a fairly cursory review. I had only a few minor
comments, but I agree with the points that Junio already raised.

-Peff
