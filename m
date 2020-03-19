Return-Path: <SRS0=WCE0=5E=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 302E7C4332B
	for <git@archiver.kernel.org>; Thu, 19 Mar 2020 17:10:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D1132072D
	for <git@archiver.kernel.org>; Thu, 19 Mar 2020 17:10:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727994AbgCSRKW (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 19 Mar 2020 13:10:22 -0400
Received: from cloud.peff.net ([104.130.231.41]:44134 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1727235AbgCSRKW (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Mar 2020 13:10:22 -0400
Received: (qmail 26318 invoked by uid 109); 19 Mar 2020 17:10:21 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 19 Mar 2020 17:10:21 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 29129 invoked by uid 111); 19 Mar 2020 17:20:00 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 19 Mar 2020 13:20:00 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 19 Mar 2020 13:10:20 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org,
        christian.couder@gmail.com, james@jramsay.com.au
Subject: Re: [RFC PATCH 0/2] upload-pack.c: limit allowed filter choices
Message-ID: <20200319171020.GC4075823@coredump.intra.peff.net>
References: <CAP8UFD0wJo4onz0_Vw4-bcX1h61=J=ZiKfM-fMXLj4B9q0aveg@mail.gmail.com>
 <cover.1584477196.git.me@ttaylorr.com>
 <20200318101825.GB1227946@coredump.intra.peff.net>
 <20200318212818.GE31397@syl.local>
 <xmqq4kulffps.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq4kulffps.fsf@gitster.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Mar 18, 2020 at 03:41:51PM -0700, Junio C Hamano wrote:

> Taylor Blau <me@ttaylorr.com> writes:
> 
> >> We tried equals, like:
> >>
> >>   uploadpack.filter=blob:none.allow
> >>
> >> but there's an interesting side effect. Doing:
> >>
> >>   git -c uploadpack.filter=blob:none.allow=true upload-pack ...
> >>
> >> doesn't work, because the "-c" parser ends the key at the first "=". As
> >> it should, because otherwise we'd get confused by an "=" in a value.
> >> This is a failing of the "-c" syntax; it can't represent values with
> >> "=". 
> 
> s/value/key/ I presume ;-)

Yes. :)

-Peff
