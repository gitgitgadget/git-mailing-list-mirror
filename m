Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 78D961F97F
	for <e@80x24.org>; Sun, 14 Oct 2018 23:59:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726262AbeJOHmf (ORCPT <rfc822;e@80x24.org>);
        Mon, 15 Oct 2018 03:42:35 -0400
Received: from cloud.peff.net ([104.130.231.41]:40236 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1725792AbeJOHmf (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 Oct 2018 03:42:35 -0400
Received: (qmail 8824 invoked by uid 109); 14 Oct 2018 23:59:53 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Sun, 14 Oct 2018 23:59:53 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 27549 invoked by uid 111); 14 Oct 2018 23:59:02 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Sun, 14 Oct 2018 19:59:02 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 14 Oct 2018 19:59:50 -0400
Date:   Sun, 14 Oct 2018 19:59:50 -0400
From:   Jeff King <peff@peff.net>
To:     Ramsay Jones <ramsay@ramsayjones.plus.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        GIT Mailing-list <git@vger.kernel.org>
Subject: Re: [RFC/PATCH] headers: normalize the spelling of some header guards
Message-ID: <20181014235950.GA13510@sigill.intra.peff.net>
References: <2804aa4e-c078-c981-be93-27e6e58b2042@ramsayjones.plus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <2804aa4e-c078-c981-be93-27e6e58b2042@ramsayjones.plus.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Oct 14, 2018 at 09:13:09PM +0100, Ramsay Jones wrote:

> This patch is marked RFC because I am not aware of any policy with
> regard to header guard spelling. Having said that, apart from the
> fetch-negotiator.h header, all of these headers are using a reserved
> identifier (see C99 Standard 7.1.3).
>
> These headers were found, thus:
> 
>   $ git grep -n -E '^#ifn?def ' -- '*.h' | grep 'h\:1\:' | grep -v '^compat' | grep -v -E '[A-Z_]*_H$'
>   alias.h:1:#ifndef __ALIAS_H__
>   commit-reach.h:1:#ifndef __COMMIT_REACH_H__
>   fetch-negotiator.h:1:#ifndef FETCH_NEGOTIATOR
>   midx.h:1:#ifndef __MIDX_H__
>   t/helper/test-tool.h:1:#ifndef __TEST_TOOL_H__
>   vcs-svn/fast_export.h:1:#ifndef FAST_EXPORT_H_
>   vcs-svn/line_buffer.h:1:#ifndef LINE_BUFFER_H_
>   vcs-svn/sliding_window.h:1:#ifndef SLIDING_WINDOW_H_
>   vcs-svn/svndiff.h:1:#ifndef SVNDIFF_H_
>   vcs-svn/svndump.h:1:#ifndef SVNDUMP_H_

I think the ones with a trailing underscore are actually OK according to
the standard (not sure if your "all of these" was including the ones in
vcs-svn ;) ).

I'm in favor of normalizing even the ones that aren't illegal, though
I'm OK either way on the vcs-svn bits if they're going away anyway.

-Peff
