Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FF16C4332F
	for <git@archiver.kernel.org>; Sat,  5 Nov 2022 12:55:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229593AbiKEMzl (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 5 Nov 2022 08:55:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229560AbiKEMzj (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 5 Nov 2022 08:55:39 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73B5427FF4
        for <git@vger.kernel.org>; Sat,  5 Nov 2022 05:55:38 -0700 (PDT)
Received: (qmail 24716 invoked by uid 109); 5 Nov 2022 12:55:38 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sat, 05 Nov 2022 12:55:38 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 7342 invoked by uid 111); 5 Nov 2022 12:55:37 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sat, 05 Nov 2022 08:55:37 -0400
Authentication-Results: peff.net; auth=none
Date:   Sat, 5 Nov 2022 08:55:37 -0400
From:   Jeff King <peff@peff.net>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org,
        Junio C Hamano <gitster@pobox.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH v2 0/3] receive-pack: only use visible refs for
 connectivity check
Message-ID: <Y2ZdScjauDUKOG+z@coredump.intra.peff.net>
References: <cover.1666967670.git.ps@pks.im>
 <cover.1667485737.git.ps@pks.im>
 <Y2WxAwNuKTOJEhz0@nand.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Y2WxAwNuKTOJEhz0@nand.local>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Nov 04, 2022 at 08:40:35PM -0400, Taylor Blau wrote:

> On Thu, Nov 03, 2022 at 03:37:25PM +0100, Patrick Steinhardt wrote:
> > Hi,
> >
> > this is the second version of my patch series that tries to improve
> > performance of the connectivity check by only considering preexisting
> > refs as uninteresting that could actually have been advertised to the
> > client.
> 
> This version was delightful to read, and I don't have any concerns with
> the approach or implementation.
> 
> I would appreciate another set of reviewer eyes on the topic, but if
> not, I am comfortable starting to merge this down as-is.

I like the overall direction, but I had some suggestions for the
interface in patch 2. Hopefully Patrick agrees, and we'll see a v2.

-Peff
