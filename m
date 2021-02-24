Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CB47C433E0
	for <git@archiver.kernel.org>; Wed, 24 Feb 2021 21:03:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2E0C164E60
	for <git@archiver.kernel.org>; Wed, 24 Feb 2021 21:03:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233276AbhBXVD5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 24 Feb 2021 16:03:57 -0500
Received: from cloud.peff.net ([104.130.231.41]:43880 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231970AbhBXVD5 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Feb 2021 16:03:57 -0500
Received: (qmail 2028 invoked by uid 109); 24 Feb 2021 21:03:15 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 24 Feb 2021 21:03:15 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 19211 invoked by uid 111); 24 Feb 2021 21:03:14 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 24 Feb 2021 16:03:14 -0500
Authentication-Results: peff.net; auth=none
Date:   Wed, 24 Feb 2021 16:03:14 -0500
From:   Jeff King <peff@peff.net>
To:     Yaron Wittenstein <yaron.wittenstein@gmail.com>
Cc:     Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Subject: Re: [QUESTION] Tracking HEAD changes?
Message-ID: <YDa/EupbrNa62r+D@coredump.intra.peff.net>
References: <CAGgn8PdU1GE_CZdGUpJWKzygd0O+Yn2BnAFGmPfKAxFpoVoqUA@mail.gmail.com>
 <YDROhhrM5qJti1ir@coredump.intra.peff.net>
 <YDVo0kGYODP0JjqT@coredump.intra.peff.net>
 <CAGgn8PcPtLNtZTmMqKKTmH3KOezkr-jY7aTEDA-0dvYWuzid9A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAGgn8PcPtLNtZTmMqKKTmH3KOezkr-jY7aTEDA-0dvYWuzid9A@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Feb 24, 2021 at 10:21:55PM +0200, Yaron Wittenstein wrote:

> That indeed seems to do the trick.
> I've done a little experiment and saw that when doing git reset the
> hook gets called.
> 
> However, when switching branches the hook doesn't execute :(
> 
> I don't understand if it's intentional, since when I've moved to a new
> branch HEAD pointed to another commit id.
> The only workaround I see here is using the post-checkout hook in addition.

Hmm, I would have thought that the branch switch would trigger the hooks
because they're updating HEAD. I wonder if that is a bug (or lack of
feature :) ) in the transaction hooks, or something Patrick did
intentionally.

-Peff
