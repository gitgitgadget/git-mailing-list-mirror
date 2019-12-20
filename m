Return-Path: <SRS0=PG55=2K=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AB59C43603
	for <git@archiver.kernel.org>; Fri, 20 Dec 2019 21:15:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 75247206DA
	for <git@archiver.kernel.org>; Fri, 20 Dec 2019 21:15:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727522AbfLTVP1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 20 Dec 2019 16:15:27 -0500
Received: from cloud.peff.net ([104.130.231.41]:51484 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1727402AbfLTVP1 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Dec 2019 16:15:27 -0500
Received: (qmail 3359 invoked by uid 109); 20 Dec 2019 21:15:27 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 20 Dec 2019 21:15:27 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 15372 invoked by uid 111); 20 Dec 2019 21:20:11 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 20 Dec 2019 16:20:11 -0500
Authentication-Results: peff.net; auth=none
Date:   Fri, 20 Dec 2019 16:15:25 -0500
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Elijah Newren <newren@gmail.com>,
        Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>, blees@dcon.de,
        Kyle Meyer <kyle@kyleam.com>, Samuel Lijin <sxlijin@gmail.com>
Subject: Re: [PATCH v4 6/8] dir: fix checks on common prefix directory
Message-ID: <20191220211525.GC2752079@coredump.intra.peff.net>
References: <pull.676.v3.git.git.1576571586.gitgitgadget@gmail.com>
 <pull.676.v4.git.git.1576697386.gitgitgadget@gmail.com>
 <1f3978aa461929923eeb5037e69be6569f0ba331.1576697386.git.gitgitgadget@gmail.com>
 <xmqq1rt1e30q.fsf@gitster-ct.c.googlers.com>
 <CABPp-BHhAPjL9daPdp7UmVT+vLrcpo6SX0rKt5s1bH4Vz31wxw@mail.gmail.com>
 <20191219222403.GA705525@coredump.intra.peff.net>
 <xmqqlfr6anbi.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqlfr6anbi.fsf@gitster-ct.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Dec 20, 2019 at 10:01:21AM -0800, Junio C Hamano wrote:

> In the meantime, here is to apologize for merging the patch a bit
> too early to 'next'.
> 
> -- >8 --
> From: Junio C Hamano <gitster@pobox.com>
> Date: Fri, 20 Dec 2019 09:55:53 -0800
> Subject: [PATCH] dir.c: use st_add3() for allocation size

Thanks, I think this is an easy improvement worth doing (I laid out more
in my response to Elijah, but: I don't think this is exploitable, but
I'd rather err on the side of caution and ease of auditing).

-Peff
