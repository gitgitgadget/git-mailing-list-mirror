Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 33EC4209F1
	for <e@80x24.org>; Thu,  6 Apr 2017 08:34:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753677AbdDFIeb (ORCPT <rfc822;e@80x24.org>);
        Thu, 6 Apr 2017 04:34:31 -0400
Received: from cloud.peff.net ([104.130.231.41]:57389 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753351AbdDFIe2 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Apr 2017 04:34:28 -0400
Received: (qmail 28501 invoked by uid 109); 6 Apr 2017 08:34:27 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 06 Apr 2017 08:34:27 +0000
Received: (qmail 24137 invoked by uid 111); 6 Apr 2017 08:34:46 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 06 Apr 2017 04:34:46 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 06 Apr 2017 04:34:25 -0400
Date:   Thu, 6 Apr 2017 04:34:25 -0400
From:   Jeff King <peff@peff.net>
To:     Martin =?utf-8?B?TGnFoWth?= <mliska@suse.cz>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 1/2] Fix nonnull errors reported by UBSAN with GCC 7.
Message-ID: <20170406083425.7psdmrploxar3h6v@sigill.intra.peff.net>
References: <295981e7-d2e9-d3db-e32d-8dd80ca47136@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <295981e7-d2e9-d3db-e32d-8dd80ca47136@suse.cz>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Apr 06, 2017 at 10:02:22AM +0200, Martin Liška wrote:

> Subject: [PATCH 1/2] Fix nonnull errors reported by UBSAN with GCC 7.
> 
> Memory functions like memmove and memcpy should not be called
> with an argument equal to NULL.

Yeah, makes sense. Your fixes are obviously correct. In other cases
we've added wrappers like sane_qsort() that do the size check
automatically. I'm not sure if we'd want to do the same here.

Either way, it probably makes sense to take this as a quick fix and
worry about refactoring as a possible patch on top.

Thanks.

-Peff
