Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A048C433B4
	for <git@archiver.kernel.org>; Wed, 21 Apr 2021 20:08:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1D31B61422
	for <git@archiver.kernel.org>; Wed, 21 Apr 2021 20:08:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245643AbhDUUIu (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 21 Apr 2021 16:08:50 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:35638 "EHLO dcvr.yhbt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S245642AbhDUUIu (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Apr 2021 16:08:50 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
        by dcvr.yhbt.net (Postfix) with ESMTP id 109F31F5AE;
        Wed, 21 Apr 2021 20:08:17 +0000 (UTC)
Date:   Wed, 21 Apr 2021 20:08:16 +0000
From:   Eric Wong <e@80x24.org>
To:     git@vger.kernel.org
Subject: Re: Strategy to deal with slow cloners
Message-ID: <20210421200816.GA13772@dcvr>
References: <20210419124623.wwps2s35x2mrrhi6@nitro.local>
 <20210419180803.GA10171@dcvr>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210419180803.GA10171@dcvr>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Eric Wong <e@80x24.org> wrote:
> Konstantin Ryabitsev <konstantin@linuxfoundation.org> wrote:
> > Hello:
> > 
> > I try to keep repositories routinely repacked and optimized for clones, in
> > hopes that most operations needing lots of objects would be sending packs
> > straight from disk. However, every now and again a client from a slow
> > connection requests a large clone and then takes half a day downloading it,
> > resulting in gigabytes of RAM being occupied by a temporary pack.
> 
> Yeah, I'm familiar with the problem.

Also, AFAIK nginx has "proxy_buffering on" by default.  However,
I seem to recall that prevents clients from seeing a single byte
until the pack is completely generated.  It's been many years
since I've used nginx myself, so my knowledge about it could be
out-of-date.
