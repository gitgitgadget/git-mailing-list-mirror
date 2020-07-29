Return-Path: <SRS0=QOHA=BI=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30F37C433E0
	for <git@archiver.kernel.org>; Wed, 29 Jul 2020 16:34:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 16DDA2075F
	for <git@archiver.kernel.org>; Wed, 29 Jul 2020 16:34:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726779AbgG2QeV (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 29 Jul 2020 12:34:21 -0400
Received: from cloud.peff.net ([104.130.231.41]:41206 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726509AbgG2QeU (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 Jul 2020 12:34:20 -0400
Received: (qmail 7518 invoked by uid 109); 29 Jul 2020 16:34:20 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 29 Jul 2020 16:34:20 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 5895 invoked by uid 111); 29 Jul 2020 16:34:19 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 29 Jul 2020 12:34:19 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 29 Jul 2020 12:34:19 -0400
From:   Jeff King <peff@peff.net>
To:     Christian Couder <christian.couder@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git <git@vger.kernel.org>
Subject: Re: [PATCH 11/11] strvec: rename struct fields
Message-ID: <20200729163419.GC2320983@coredump.intra.peff.net>
References: <20200728202124.GA1021264@coredump.intra.peff.net>
 <20200728202823.GK1021513@coredump.intra.peff.net>
 <xmqqr1svcpcn.fsf@gitster.c.googlers.com>
 <xmqqmu3jcp9u.fsf@gitster.c.googlers.com>
 <CAP8UFD3Z86nQq_iZ3kqvuL4Vr9PxL+71VBgd7my+YUxgFyYvXA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAP8UFD3Z86nQq_iZ3kqvuL4Vr9PxL+71VBgd7my+YUxgFyYvXA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jul 29, 2020 at 08:55:46AM +0200, Christian Couder wrote:

> > > I'd agree that v[] is a good name.  If it is too short, I can live
> > > with item[], but not with items[]....
> >
> > What are individual component of a vector called?  An element?  If
> > so, elem[] would be much better name than item[].
> 
> Individual components of a string vector or a string array are
> strings, so "str" if we abbreviate "string" to "str".
> 
> Using "str" would be consistent with oid_array where the individual
> component is called "oid" as it is defined this way:
> 
> struct oid_array {
>         struct object_id *oid;
>         size_t nr;
>         size_t alloc;
>         int sorted;
> };

Yeah, I agree "str" is a reasonable name, and probably better than
"elem" or "items". I do still like the super-concise "v" better, though.

-Peff
