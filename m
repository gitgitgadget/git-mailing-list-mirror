Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D7E741F404
	for <e@80x24.org>; Thu, 22 Feb 2018 20:12:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751000AbeBVUMv (ORCPT <rfc822;e@80x24.org>);
        Thu, 22 Feb 2018 15:12:51 -0500
Received: from cloud.peff.net ([104.130.231.41]:33174 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1750776AbeBVUMv (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Feb 2018 15:12:51 -0500
Received: (qmail 30062 invoked by uid 109); 22 Feb 2018 20:12:51 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 22 Feb 2018 20:12:51 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 7266 invoked by uid 111); 22 Feb 2018 20:13:38 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Thu, 22 Feb 2018 15:13:38 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 22 Feb 2018 15:12:49 -0500
Date:   Thu, 22 Feb 2018 15:12:49 -0500
From:   Jeff King <peff@peff.net>
To:     Lars Schneider <larsxschneider@gmail.com>
Cc:     Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>,
        Junio C Hamano <gitster@pobox.com>,
        lars.schneider@autodesk.com, git@vger.kernel.org, j6t@kdbg.org,
        sunshine@sunshineco.com, ramsay@ramsayjones.plus.com,
        Johannes.Schindelin@gmx.de
Subject: Re: [PATCH v7 0/7] convert: add support for different encodings
Message-ID: <20180222201248.GA23561@sigill.intra.peff.net>
References: <20180215152711.158-1-lars.schneider@autodesk.com>
 <xmqqr2pm81hh.fsf@gitster-ct.c.googlers.com>
 <DC552BF4-3E87-41E0-BF92-4BA9633D374E@gmail.com>
 <20180216165815.GA4681@tor.lan>
 <19EDC192-0D83-4762-AC6A-81F7D693475A@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <19EDC192-0D83-4762-AC6A-81F7D693475A@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Feb 22, 2018 at 09:00:45PM +0100, Lars Schneider wrote:

> > If it was only about a diff of UTF-16 files, I may suggest a patch.
> > I simply copy-paste it here for review, if someone thinks that it may
> > be useful, I can send it as a real patch/RFC.
> 
> That's a nice idea but I see two potential problems:
> 
> (1) Git hosting services (GitLab, BitBucket, GitHub, ...) would still
>     show these files as binary. That's a huge problem for my users as
>     they interact more with these services than the Git command line.
>     That's the main reason why I implemented the "UTF-8 as canonical
>     form" approach in my series.

I can't speak for the other services, but I can tell you that GitHub
would be pretty eager to enable such a feature if it existed.

I suspect most services providing human-readable diffs would want to do
the same. Though there are still cases where you'd see a binary patch
(e.g., format-patch in emails, or GitHub's .patch endpoint, since those
are meant to be applied and must contain the "real" data).

-Peff
