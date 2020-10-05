Return-Path: <SRS0=R7wA=DM=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8757C4363A
	for <git@archiver.kernel.org>; Mon,  5 Oct 2020 08:24:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AF6FB20776
	for <git@archiver.kernel.org>; Mon,  5 Oct 2020 08:24:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725915AbgJEIYt (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 5 Oct 2020 04:24:49 -0400
Received: from cloud.peff.net ([104.130.231.41]:49374 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725885AbgJEIYt (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Oct 2020 04:24:49 -0400
Received: (qmail 31184 invoked by uid 109); 5 Oct 2020 08:24:49 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 05 Oct 2020 08:24:49 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 17162 invoked by uid 111); 5 Oct 2020 08:24:49 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 05 Oct 2020 04:24:49 -0400
Authentication-Results: peff.net; auth=none
Date:   Mon, 5 Oct 2020 04:24:48 -0400
From:   Jeff King <peff@peff.net>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 3/7] t7415: rename to expand scope
Message-ID: <20201005082448.GB2862927@coredump.intra.peff.net>
References: <20201005071751.GA2290770@coredump.intra.peff.net>
 <20201005071954.GC2291074@coredump.intra.peff.net>
 <20201005075020.GF1166820@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201005075020.GF1166820@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Oct 05, 2020 at 12:50:20AM -0700, Jonathan Nieder wrote:

> >  ...5-submodule-names.sh => t7450-bad-meta-files.sh} | 13 ++++++++++---
> >  1 file changed, 10 insertions(+), 3 deletions(-)
> >  rename t/{t7415-submodule-names.sh => t7450-bad-meta-files.sh} (95%)
> 
> I've never heard of a "meta file" before, but I don't tend to discover
> test scripts based on their filename anyway. :)  Thanks for updating the
> test_description.

I couldn't think of a better name for "files that start with .git". I
almost called it "dot-git", but then I worried about confusion with the
actual ".git" directory.

> t7* is "the porcelainish commands concerning the working tree".  Should
> this go in t1* (basic commands concerning database) instead?
> 
> t745* is unused number space so this at least won't hit any conflicts,
> so fwiw

We've generally tried to order tests so that basic functionality in some
area comes before more advanced. So I tried to put these specialty
.gitmodules tests after the basic submodule tests (and likewise after
any attribute or gitignore tests).

In practice, I doubt it matters that much. We don't tend to run the test
suite serially in order these days anyway, so the notion that finding a
bug in an early test might save you CPU time or time spent reading error
messages likely no longer applies.

-Peff
