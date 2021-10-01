Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CFEBC433EF
	for <git@archiver.kernel.org>; Fri,  1 Oct 2021 05:28:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F252B615A4
	for <git@archiver.kernel.org>; Fri,  1 Oct 2021 05:28:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241584AbhJAFab (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 1 Oct 2021 01:30:31 -0400
Received: from cloud.peff.net ([104.130.231.41]:58876 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230483AbhJAFab (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 Oct 2021 01:30:31 -0400
Received: (qmail 26132 invoked by uid 109); 1 Oct 2021 05:28:47 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 01 Oct 2021 05:28:47 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 7882 invoked by uid 111); 1 Oct 2021 05:28:46 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 01 Oct 2021 01:28:46 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 1 Oct 2021 01:28:46 -0400
From:   Jeff King <peff@peff.net>
To:     Elijah Newren <newren@gmail.com>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Sergey Organov <sorganov@gmail.com>
Subject: Re: [PATCH 2/7] merge-ort: add ability to record conflict messages
 in a file
Message-ID: <YVacjhpgu1BwXzdk@coredump.intra.peff.net>
References: <pull.1080.git.git.1630376800.gitgitgadget@gmail.com>
 <ed71913886e19ccc276b382de707b4bab7834d12.1630376800.git.gitgitgadget@gmail.com>
 <YVOXPTjsp9lrxmS6@coredump.intra.peff.net>
 <CABPp-BEioOUJRd6FSsmsDtYHhUy7xhr4YabdEmVKzkduo4g9TQ@mail.gmail.com>
 <YVVuP8ReqaPi/Z5E@coredump.intra.peff.net>
 <CABPp-BFimGLnP331aFqLx0x-uQG7wHwSoN25fcYrPzWU93fn6Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CABPp-BFimGLnP331aFqLx0x-uQG7wHwSoN25fcYrPzWU93fn6Q@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Sep 30, 2021 at 07:07:21PM -0700, Elijah Newren wrote:

> > That said, I think it could also make sense to annotate the conflict
> > files by giving them an unusual set of mode bits. That would be easier
> > to recognize (and while real trees _could_ have silly modes, we do
> > complain about them in fsck, so it shouldn't happen in practice).
> 
> I tried giving things unusual mode bits in early versions of merge-ort
> for other reasons.  It doesn't work: canon_mode() will "fix" the
> unusualness so there's no way for the reader to know that they had
> unusual bits.

Ah, right, I totally forgot about that.

> But, as you said later, avoiding these pseudo-files is going to be
> cleaner anyway, so let's just do that.

I'm quite happy if you're on board with that direction. :)

-Peff
