Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11941C38A2D
	for <git@archiver.kernel.org>; Fri, 21 Oct 2022 23:43:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229783AbiJUXn0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 21 Oct 2022 19:43:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229766AbiJUXnY (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Oct 2022 19:43:24 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2A422ADD33
        for <git@vger.kernel.org>; Fri, 21 Oct 2022 16:43:23 -0700 (PDT)
Received: (qmail 15043 invoked by uid 109); 21 Oct 2022 23:43:23 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 21 Oct 2022 23:43:23 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 18340 invoked by uid 111); 21 Oct 2022 23:43:23 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 21 Oct 2022 19:43:23 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 21 Oct 2022 19:43:22 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org,
        Jan =?utf-8?Q?Pokorn=C3=BD?= <poki@fnusa.cz>
Subject: Re: [PATCH 1/4] repack: convert "names" util bitfield to array
Message-ID: <Y1MumtN5fcCGD5+G@coredump.intra.peff.net>
References: <Y1MR7V8kGolLd8eh@coredump.intra.peff.net>
 <Y1MSWAx+baTklfLL@coredump.intra.peff.net>
 <Y1Mm9zTX3XwN3IWu@nand.local>
 <Y1MrXoobkVKngYL1@coredump.intra.peff.net>
 <xmqqfsfgiwcq.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <xmqqfsfgiwcq.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Oct 21, 2022 at 04:35:17PM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > Yeah, I actually considered writing it that way, but it felt a bit silly
> > to use _ARRAY for something which is clearly meant to be a single item.
> 
> You are not alone.  I updated Réne's coccinelle rules to refrain
> from converting xcalloc() to CALLOC_ARRAY() for a single element
> case exactly because it feels silly to use array function for a
> singleton with 1c57cc70 (cocci: allow xcalloc(1, size), 2021-03-15).

OK. Then I'll leave it as-is, then. :)

-Peff
