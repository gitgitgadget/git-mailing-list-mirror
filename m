Return-Path: <SRS0=Te6D=5Z=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C73ADC2BA19
	for <git@archiver.kernel.org>; Thu,  9 Apr 2020 19:21:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A00D72072F
	for <git@archiver.kernel.org>; Thu,  9 Apr 2020 19:21:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726703AbgDITVu (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Apr 2020 15:21:50 -0400
Received: from cloud.peff.net ([104.130.231.41]:38510 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1725970AbgDITVu (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Apr 2020 15:21:50 -0400
Received: (qmail 20889 invoked by uid 109); 9 Apr 2020 19:21:50 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 09 Apr 2020 19:21:50 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 21547 invoked by uid 111); 9 Apr 2020 19:32:20 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 09 Apr 2020 15:32:20 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 9 Apr 2020 15:21:49 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Derrick Stolee <stolee@gmail.com>,
        Philip Oakley <philipoakley@iee.email>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, me@ttaylorr.com,
        Derrick Stolee <dstolee@microsoft.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] revision: --include-diversions adds helpful merges
Message-ID: <20200409192149.GA4168991@coredump.intra.peff.net>
References: <20200408200526.GA2270445@coredump.intra.peff.net>
 <9eab6c60-3c99-d6ac-9206-02ce37f7a479@gmail.com>
 <xmqqv9m9oe2p.fsf@gitster.c.googlers.com>
 <91fafa17-c58f-dcd0-320d-48c4512561f6@gmail.com>
 <xmqqimi9o705.fsf@gitster.c.googlers.com>
 <7d84fc45-786f-7a2e-5889-ef26916627ef@iee.email>
 <xmqqeeswodol.fsf@gitster.c.googlers.com>
 <63667043-dbca-0092-209d-865c2f60efc8@gmail.com>
 <20200409182455.GA4166316@coredump.intra.peff.net>
 <xmqq369co5e0.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq369co5e0.fsf@gitster.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Apr 09, 2020 at 11:55:51AM -0700, Junio C Hamano wrote:

> > On Thu, Apr 09, 2020 at 01:20:57PM -0400, Derrick Stolee wrote:
> >
> >> In conclusion, I think "--show-pulls" provides the right context for these
> >> extra merges to show in the history view. It also roots these merges in a
> >> Git-native name (that also happens to evoke the "pull request" concept that
> >> is _not_ native to Git).
> >> 
> >> What do you think?
> >
> > Yeah, after reading more of the thread, I think the simplest way to
> > think about is "keep merges that pulled in something" with the
> > implication of "(even if the other side didn't touch anything)".
> 
> Isn't it more like "even if our side didn't touch anything", though?

I meant the _other_ other. :) I.e., the other one that is not what just
got pulled in. Which is the first parent. ;)

So yes, I think we are on the same page, and I just said it badly. Using
"our side" is better than trying to double-negate "other".

-Peff
