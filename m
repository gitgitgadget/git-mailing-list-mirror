Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12B47C61DA3
	for <git@archiver.kernel.org>; Sat,  4 Mar 2023 02:22:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229668AbjCDCW6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 3 Mar 2023 21:22:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229659AbjCDCWz (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Mar 2023 21:22:55 -0500
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6519B65C5C
        for <git@vger.kernel.org>; Fri,  3 Mar 2023 18:22:49 -0800 (PST)
Received: (qmail 10941 invoked by uid 109); 4 Mar 2023 02:22:49 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sat, 04 Mar 2023 02:22:49 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 818 invoked by uid 111); 4 Mar 2023 02:22:48 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 03 Mar 2023 21:22:48 -0500
Authentication-Results: peff.net; auth=none
Date:   Fri, 3 Mar 2023 21:22:47 -0500
From:   Jeff King <peff@peff.net>
To:     Michael Henry <git@drmikehenry.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: `git bundle create -` may not write to `stdout`
Message-ID: <ZAKrd3vWyRxX3ZJ/@coredump.intra.peff.net>
References: <80beb487-cd93-06ed-88cf-87a96a829ff6@drmikehenry.com>
 <Y/voNv1OQ1Cf/N5a@coredump.intra.peff.net>
 <xmqqv8jhcvrq.fsf@gitster.g>
 <72e2af95-478d-4a15-d8cc-ce910cb7d520@drmikehenry.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <72e2af95-478d-4a15-d8cc-ce910cb7d520@drmikehenry.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Mar 03, 2023 at 06:59:14PM -0500, Michael Henry wrote:

> I'm not subscribed to the git mailing list (I thought it might
> be too high volume for me), but I thought I'd be getting any
> replies regarding my bug report.  For some reason, though,  I'm
> not getting copied on any of the emails you've sent (from
> peff@peff.net).  I am getting Junio's emails, but today was the
> first time I'd seen a response.  I am able to see the
> conversation via the archive at
> https://marc.info/?l=git&m=167733032407411&w=2, so I've read
> your responses there.

Ah, thanks for letting me know. They seem to be stuck in my mail
server's queue. The problem is that your server supports TLS, but only
TLS v1.0. Recent versions of openssl (at least packaged for Debian) bump
the default to TLS v1.2 (because older versions are considered less
secure).

I relaxed the settings on my server, so you should have gotten a flurry
of deliveries (including this one). But you might run into delivery
problems from other people at some point.

-Peff
