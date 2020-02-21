Return-Path: <SRS0=3Brp=4J=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14214C35641
	for <git@archiver.kernel.org>; Fri, 21 Feb 2020 06:10:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E3554208C4
	for <git@archiver.kernel.org>; Fri, 21 Feb 2020 06:10:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726084AbgBUGKJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 21 Feb 2020 01:10:09 -0500
Received: from cloud.peff.net ([104.130.231.41]:50138 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1725800AbgBUGKJ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Feb 2020 01:10:09 -0500
Received: (qmail 15903 invoked by uid 109); 21 Feb 2020 06:10:09 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 21 Feb 2020 06:10:09 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 16521 invoked by uid 111); 21 Feb 2020 06:19:11 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 21 Feb 2020 01:19:11 -0500
Authentication-Results: peff.net; auth=none
Date:   Fri, 21 Feb 2020 01:10:07 -0500
From:   Jeff King <peff@peff.net>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v2 0/5] Wildcard matching for credentials
Message-ID: <20200221061007.GG1280313@coredump.intra.peff.net>
References: <20200220022413.258026-1-sandals@crustytoothpaste.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200220022413.258026-1-sandals@crustytoothpaste.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Feb 20, 2020 at 02:24:08AM +0000, brian m. carlson wrote:

> This series introduces wildcard matching (that is, urlmatch support) for
> credential config options, just like for the http options.  This is
> helpful in corporate environments where custom credentials should be
> used across a wide variety of subdomains.
> 
> Changes from v1:
> * Add a variety of additional tests in patch 3.
> * Switch to using the last matching config option for
>   credential.username like we do everywhere else.
> * Use all matching config keys, as we did before.
> * Skip calling git_default_config.
> * Fix percent-encoding handling and add a function to handle that.

Thanks, this addresses all of my concerns, and I'm really happy to see
all the new tests covering various bits from our discussion. Really
cleanly done.

-Peff
