Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36A15C433F5
	for <git@archiver.kernel.org>; Mon, 11 Oct 2021 16:23:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1608A60EE2
	for <git@archiver.kernel.org>; Mon, 11 Oct 2021 16:23:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231891AbhJKQZh (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 11 Oct 2021 12:25:37 -0400
Received: from cloud.peff.net ([104.130.231.41]:37028 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231749AbhJKQZd (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Oct 2021 12:25:33 -0400
Received: (qmail 29163 invoked by uid 109); 11 Oct 2021 16:23:33 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 11 Oct 2021 16:23:33 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 19795 invoked by uid 111); 11 Oct 2021 16:23:32 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 11 Oct 2021 12:23:32 -0400
Authentication-Results: peff.net; auth=none
Date:   Mon, 11 Oct 2021 12:23:32 -0400
From:   Jeff King <peff@peff.net>
To:     Carlo Arenas <carenas@gmail.com>
Cc:     Benjamin Kircher <bkircher@0xadd.de>, git@vger.kernel.org
Subject: Re: git log with %(describe) placeholder does not find most recent
 tag
Message-ID: <YWRlBLu+st02X7MD@coredump.intra.peff.net>
References: <61d28b8e9dd906eba821ecc9ee81bd4ac2374494.camel@0xadd.de>
 <CAPUEsphLXcCw=Qj1Rw5ONf2GduQAs62VwkVd3gTt4=PLaGkBcg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAPUEsphLXcCw=Qj1Rw5ONf2GduQAs62VwkVd3gTt4=PLaGkBcg@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Oct 11, 2021 at 05:27:39AM -0700, Carlo Arenas wrote:

> On Mon, Oct 11, 2021 at 1:10 AM Benjamin Kircher <bkircher@0xadd.de> wrote:
> > produces a different result than
> >
> >     git describe --tags
> 
> if the repository you are looking at has non annotated tags (the ones
> that have no signature or message and that are created by default with
> `git tag`), then that is expected and explained in the documentation
> for the '--tags' option you are using.

Yes, that's the case in the example repo he showed. I don't think there
is currently a way to convince %(describe) to use "--tags" in the
underlying describe command, but it seems like a reasonable extension if
somebody is interested in writing it. We already take some options to
%(describe), so the syntax is prepared to add more.

-Peff
