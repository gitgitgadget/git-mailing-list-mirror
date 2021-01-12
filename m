Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D51D1C433DB
	for <git@archiver.kernel.org>; Tue, 12 Jan 2021 08:52:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 862DB2075E
	for <git@archiver.kernel.org>; Tue, 12 Jan 2021 08:52:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730892AbhALIwV (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 12 Jan 2021 03:52:21 -0500
Received: from cloud.peff.net ([104.130.231.41]:53054 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726890AbhALIwV (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Jan 2021 03:52:21 -0500
Received: (qmail 6102 invoked by uid 109); 12 Jan 2021 08:51:40 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 12 Jan 2021 08:51:40 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 10811 invoked by uid 111); 12 Jan 2021 08:51:42 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 12 Jan 2021 03:51:42 -0500
Authentication-Results: peff.net; auth=none
Date:   Tue, 12 Jan 2021 03:51:40 -0500
From:   Jeff King <peff@peff.net>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, jrnieder@gmail.com
Subject: Re: [PATCH 05/20] check_object(): convert to new revindex API
Message-ID: <X/1jHFiaKkMc2kqh@coredump.intra.peff.net>
References: <cover.1610129796.git.me@ttaylorr.com>
 <c47e77a30eb40d9841a60a28b620671860dc2461.1610129796.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <c47e77a30eb40d9841a60a28b620671860dc2461.1610129796.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jan 08, 2021 at 01:17:00PM -0500, Taylor Blau wrote:

> Replace direct accesses to the revindex with calls to
> 'offset_to_pack_pos()' and 'pack_pos_to_index()'.
> 
> Since this caller already had some error checking (it can jump to the
> 'give_up' label if it encounters an error), we can easily check whether
> or not the provided offset points to an object in the given pack. This
> error checking existed prior to this patch, too, since the caller checks
> whether the return value from 'find_pack_revindex()' was NULL or not.

Yay. Happy again to see things getting more robust.

-Peff
