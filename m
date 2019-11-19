Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B5E961F4B5
	for <e@80x24.org>; Tue, 19 Nov 2019 07:37:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727139AbfKSHhz (ORCPT <rfc822;e@80x24.org>);
        Tue, 19 Nov 2019 02:37:55 -0500
Received: from cloud.peff.net ([104.130.231.41]:50816 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1725536AbfKSHhz (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Nov 2019 02:37:55 -0500
Received: (qmail 10571 invoked by uid 109); 19 Nov 2019 07:37:55 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 19 Nov 2019 07:37:54 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 21314 invoked by uid 111); 19 Nov 2019 07:41:38 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 19 Nov 2019 02:41:38 -0500
Authentication-Results: peff.net; auth=none
Date:   Tue, 19 Nov 2019 02:37:54 -0500
From:   Jeff King <peff@peff.net>
To:     Anthony Sottile <asottile@umich.edu>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: git rev-parse --show-toplevel inside `.git` returns 0 and prints
 nothing
Message-ID: <20191119073754.GA30634@sigill.intra.peff.net>
References: <CA+dzEBmrMavFJeyPSQr2wA9kFZwz_Kfr6PFBLRfLJ-EuCVXJnA@mail.gmail.com>
 <xmqqk17wziex.fsf@gitster-ct.c.googlers.com>
 <20191119033311.GA18613@sigill.intra.peff.net>
 <CA+dzEBmekzDVdqy=4GDF+Wm8e-YTPEdbh0oVowZNQYO67vEhEg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CA+dzEBmekzDVdqy=4GDF+Wm8e-YTPEdbh0oVowZNQYO67vEhEg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Nov 18, 2019 at 08:13:02PM -0800, Anthony Sottile wrote:

> > I think the reason this hasn't come up until now is callers are expected
> > to use require_work_tree() or "rev-parse --is-inside-work-tree" first.
> >
> > It would probably make sense for the rev-parse documentation to also
> > clarify what "the top-level directory" is.
> >
> > -Peff
> 
> I realize I forgot to include the X to my Y :) -- this was a totally
> silly case that I got as a bug report:
> https://github.com/pre-commit/pre-commit/issues/1219
> 
> I *expected* an error case but didn't get one

Yes, and I do agree that an error is the right thing.

Would that have helped your pre-commit script? I guess it would have
barfed at that point. :) It sounds like it should be checking first that
it has a working tree.

-Peff
