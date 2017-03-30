Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CAD1220958
	for <e@80x24.org>; Thu, 30 Mar 2017 03:22:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753959AbdC3DWX (ORCPT <rfc822;e@80x24.org>);
        Wed, 29 Mar 2017 23:22:23 -0400
Received: from cloud.peff.net ([104.130.231.41]:53942 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753927AbdC3DWW (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 Mar 2017 23:22:22 -0400
Received: (qmail 1863 invoked by uid 109); 30 Mar 2017 03:22:22 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 30 Mar 2017 03:22:22 +0000
Received: (qmail 28166 invoked by uid 111); 30 Mar 2017 03:22:37 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 29 Mar 2017 23:22:37 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 29 Mar 2017 23:22:19 -0400
Date:   Wed, 29 Mar 2017 23:22:19 -0400
From:   Jeff King <peff@peff.net>
To:     Stefan Beller <sbeller@google.com>
Cc:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH 3/3] WIP - Allow custom printf function for column
 printing
Message-ID: <20170330032219.ujqddocibufn535d@sigill.intra.peff.net>
References: <20170330014238.30032-1-sbeller@google.com>
 <20170330014238.30032-4-sbeller@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170330014238.30032-4-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Mar 29, 2017 at 06:42:38PM -0700, Stefan Beller wrote:

> Ever wondered why column.ui applies the untracked files in git-status,
> but not for the help text comment in git-commit? Nobody wrote the code!
> 
> This is marked as WIP, as it barely demonstrates how the code may look
> like. No tests, no documentation.

I'm confused about what this patch is trying to do. Is it just to turn
on column.status support for the template shown by git-commit? Or is it
columnizing more than the untracked files list?

If the former, why isn't just setting s.colopts enough? I guess because
we write into a strbuf?

If the latter, then isn't that a separate logical patch from "should
commit use columns"?

I don't have an opinion on the whole thing myself, as I do not use
columns nor really know how they are supposed to work. You found my
4d2292e9a9, but I was explicitly trying _not_ to get involved in any
behavior changes there due to my cluelessness. :)

I think Duy, who wrote all of the column code, is a better person to cc.

-Peff
