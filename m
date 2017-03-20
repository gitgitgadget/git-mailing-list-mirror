Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1D07520958
	for <e@80x24.org>; Mon, 20 Mar 2017 18:44:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932418AbdCTSlQ (ORCPT <rfc822;e@80x24.org>);
        Mon, 20 Mar 2017 14:41:16 -0400
Received: from cloud.peff.net ([104.130.231.41]:47838 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755337AbdCTRuj (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Mar 2017 13:50:39 -0400
Received: (qmail 12020 invoked by uid 109); 20 Mar 2017 17:49:41 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 20 Mar 2017 17:49:41 +0000
Received: (qmail 3744 invoked by uid 111); 20 Mar 2017 17:49:54 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 20 Mar 2017 13:49:54 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 20 Mar 2017 13:49:37 -0400
Date:   Mon, 20 Mar 2017 13:49:37 -0400
From:   Jeff King <peff@peff.net>
To:     Michael Haggerty <mhagger@alum.mit.edu>
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        David Turner <novalis@novalis.org>, git@vger.kernel.org
Subject: Re: [PATCH 09/20] refs: split `ref_cache` code into separate files
Message-ID: <20170320174937.xkozsdruyrj44qg2@sigill.intra.peff.net>
References: <cover.1490026594.git.mhagger@alum.mit.edu>
 <f16c123354404088f9ffef0b0e31d4a9817cb804.1490026594.git.mhagger@alum.mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <f16c123354404088f9ffef0b0e31d4a9817cb804.1490026594.git.mhagger@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Mar 20, 2017 at 05:33:14PM +0100, Michael Haggerty wrote:

> The `ref_cache` code is currently too tightly coupled to
> `files-backend`, making the code harder to understand and making it
> awkward for new code to use `ref_cache` (as we indeed have planned).
> Start loosening that coupling by splitting `ref_cache` into a separate
> module.
> 
> This commit moves code, adds declarations, and changes the visibility
> of some functions, but doesn't change any code.
> 
> The modules are still too tightly coupled, but the situation will be
> improved in subsequent commits.
> 
> Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
> ---
>  Makefile             |   1 +
>  refs/files-backend.c | 736 +--------------------------------------------------
>  refs/ref-cache.c     | 512 +++++++++++++++++++++++++++++++++++
>  refs/ref-cache.h     | 251 ++++++++++++++++++
>  4 files changed, 767 insertions(+), 733 deletions(-)
>  create mode 100644 refs/ref-cache.c
>  create mode 100644 refs/ref-cache.h

I'm not surprised that stock format-patch didn't treat this as a rename,
but I would have thought it would with "-B". It doesn't seem to, though.
Perhaps because of the code movement, etc.

It might have been a bit easier to review as separate steps for that
reason, but I doubt it's worth going back and re-doing. I'll take your
word that nothing substantive changed.

-Peff
