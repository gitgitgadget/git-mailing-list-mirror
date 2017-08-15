Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EF327208CD
	for <e@80x24.org>; Tue, 15 Aug 2017 21:34:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751224AbdHOVeZ (ORCPT <rfc822;e@80x24.org>);
        Tue, 15 Aug 2017 17:34:25 -0400
Received: from cloud.peff.net ([104.130.231.41]:40150 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751119AbdHOVeY (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Aug 2017 17:34:24 -0400
Received: (qmail 8738 invoked by uid 109); 15 Aug 2017 21:34:24 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 15 Aug 2017 21:34:24 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 14599 invoked by uid 111); 15 Aug 2017 21:34:49 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Tue, 15 Aug 2017 17:34:49 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 15 Aug 2017 17:34:22 -0400
Date:   Tue, 15 Aug 2017 17:34:22 -0400
From:   Jeff King <peff@peff.net>
To:     Stefan Beller <sbeller@google.com>
Cc:     jonathantanmy@google.com, git@vger.kernel.org
Subject: Re: [PATCH] sha1_file: make read_info_alternates static
Message-ID: <20170815213421.amvtzyxfbbajvf4w@sigill.intra.peff.net>
References: <20170815201319.32395-1-sbeller@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170815201319.32395-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Aug 15, 2017 at 01:13:19PM -0700, Stefan Beller wrote:

> read_info_alternates is not used from outside, so let's make it static.
> 
> We have to declare the function before link_alt_odb_entry instead of
> moving the code around, link_alt_odb_entry calls read_info_alternates,
> which in turn calls link_alt_odb_entry.
> 
> Signed-off-by: Stefan Beller <sbeller@google.com>

Thanks, this looks good. It should have been part of my series with
a5b34d2152 (alternates: provide helper for adding to alternates list,
2016-10-03), which removed the last external call.

-Peff
