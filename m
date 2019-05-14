Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3B48D1F461
	for <e@80x24.org>; Tue, 14 May 2019 09:54:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726369AbfENJys (ORCPT <rfc822;e@80x24.org>);
        Tue, 14 May 2019 05:54:48 -0400
Received: from cloud.peff.net ([104.130.231.41]:56636 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1725916AbfENJys (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 May 2019 05:54:48 -0400
Received: (qmail 3289 invoked by uid 109); 14 May 2019 09:54:48 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 14 May 2019 09:54:48 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 11192 invoked by uid 111); 14 May 2019 09:55:26 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Tue, 14 May 2019 05:55:26 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 14 May 2019 05:54:46 -0400
Date:   Tue, 14 May 2019 05:54:46 -0400
From:   Jeff King <peff@peff.net>
To:     Shawn Landden <shawn@git.icu>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: allow a differn't diff.context config for git format-patch
Message-ID: <20190514095446.GA12299@sigill.intra.peff.net>
References: <CA+49okrda1=dV=rN23oFg7LQmRp+idkDDDxFQ9R5jhGJFHKpEg@mail.gmail.com>
 <20190423030648.GA6344@sigill.intra.peff.net>
 <xmqqftq95qr6.fsf@gitster-ct.c.googlers.com>
 <20190423035537.GB7753@sigill.intra.peff.net>
 <CA+49okrzR7GAZCFDfaoJ9pvK+o=DVWoZ9vA6YL=u72s_rnjDxQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CA+49okrzR7GAZCFDfaoJ9pvK+o=DVWoZ9vA6YL=u72s_rnjDxQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, May 12, 2019 at 07:29:42AM -0500, Shawn Landden wrote:

> > After init_revisions(), we'll have called diff_setup(), which puts
> > diff_context_default into revs->diffopt. So we still have to do the "if
> > we have a format-specific value, then override..." conditional. But we
> > can do it without touching the hidden variable:
> >
> Looks like this fell into the cracks. You guys know the code much better
> than me, but do I have to write a patch to make this happen?

I think there is more work to be done in actually parsing such a config
option, plus adding documentation and tests.

But more importantly, it needs somebody to champion the feature. I don't
find it an unreasonable thing to want. But I'm not personally
interested, nor am I completely sure that it wouldn't have any unwanted
side effects.

So ideally somebody would write the patch and a compelling commit
message that explains why it is a good idea.

-Peff
