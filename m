Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 701341F404
	for <e@80x24.org>; Fri,  7 Sep 2018 15:03:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729145AbeIGTor (ORCPT <rfc822;e@80x24.org>);
        Fri, 7 Sep 2018 15:44:47 -0400
Received: from cloud.peff.net ([104.130.231.41]:42708 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1728074AbeIGTor (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Sep 2018 15:44:47 -0400
Received: (qmail 11604 invoked by uid 109); 7 Sep 2018 15:03:29 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 07 Sep 2018 15:03:29 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 14168 invoked by uid 111); 7 Sep 2018 15:03:40 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Fri, 07 Sep 2018 11:03:40 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 07 Sep 2018 11:03:27 -0400
Date:   Fri, 7 Sep 2018 11:03:27 -0400
From:   Jeff King <peff@peff.net>
To:     Allan Sandfeld Jensen <allan.jensen@qt.io>
Cc:     Stefan Beller <sbeller@google.com>, git@vger.kernel.org
Subject: Re: Old submodules broken in 2.19rc1 and 2.19rc2
Message-ID: <20180907150327.GB26719@sigill.intra.peff.net>
References: <2659750.rG6xLiZASK@twilight>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <2659750.rG6xLiZASK@twilight>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Sep 07, 2018 at 11:52:58AM +0200, Allan Sandfeld Jensen wrote:

> Submodules checked out with older versions of git not longer works in the 
> latest 2.19 releases. A "git submodule update --recursive" command wil fail 
> for each submodule with a line saying "fatal: could not open 
> '<submodule>/.git' for writing> Is a directory.

I couldn't reproduce after cloning with v1.6.6.3 (which creates ".git"
as a directory in the tree). Is it possible for you to bisect (or
perhaps share with us the broken example)?

> I checked the release notes so far, and they do not say the old submodules 
> from git 2.16- were no longer supported, so I assume it is a bug?

I don't think it was intentional. +cc Stefan for submodule expertise.

-Peff
