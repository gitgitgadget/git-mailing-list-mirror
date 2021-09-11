Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACBF0C433F5
	for <git@archiver.kernel.org>; Sat, 11 Sep 2021 14:27:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8BBB7611BF
	for <git@archiver.kernel.org>; Sat, 11 Sep 2021 14:27:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236153AbhIKO2u (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 11 Sep 2021 10:28:50 -0400
Received: from cloud.peff.net ([104.130.231.41]:44878 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235788AbhIKO2t (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 11 Sep 2021 10:28:49 -0400
Received: (qmail 12363 invoked by uid 109); 11 Sep 2021 14:27:36 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sat, 11 Sep 2021 14:27:36 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 20608 invoked by uid 111); 11 Sep 2021 14:27:36 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sat, 11 Sep 2021 10:27:36 -0400
Authentication-Results: peff.net; auth=none
Date:   Sat, 11 Sep 2021 10:27:35 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/3] packfile: use oidset for bad objects
Message-ID: <YTy81+Xq5G1fRxU8@coredump.intra.peff.net>
References: <4a702bfe-afd0-669a-c893-0262289c24b8@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4a702bfe-afd0-669a-c893-0262289c24b8@web.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Sep 11, 2021 at 09:50:36AM +0200, René Scharfe wrote:

> Replace the custom hash array for remembering corrupt pack entries with
> an oidset.  This shortens and simplifies the code.

Thanks, these were a pleasure to read.

I noticed one possible small performance change in the third patch. It
should be easy to remedy if we want (but I could also believe that it
doesn't matter either way, if you care to argue that :) ).

-Peff
