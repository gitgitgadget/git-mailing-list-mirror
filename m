Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7765620899
	for <e@80x24.org>; Wed, 16 Aug 2017 08:39:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751556AbdHPIj2 (ORCPT <rfc822;e@80x24.org>);
        Wed, 16 Aug 2017 04:39:28 -0400
Received: from cloud.peff.net ([104.130.231.41]:40536 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751500AbdHPIj1 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Aug 2017 04:39:27 -0400
Received: (qmail 20534 invoked by uid 109); 16 Aug 2017 08:39:26 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 16 Aug 2017 08:39:26 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 17760 invoked by uid 111); 16 Aug 2017 08:39:52 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Wed, 16 Aug 2017 04:39:52 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 16 Aug 2017 04:39:25 -0400
Date:   Wed, 16 Aug 2017 04:39:25 -0400
From:   Jeff King <peff@peff.net>
To:     Nicolas Morey-Chaisemartin <NMoreyChaisemartin@suse.de>
Cc:     Nicolas Morey-Chaisemartin <nicolas@morey-chaisemartin.com>,
        git@vger.kernel.org
Subject: Re: [RFC 0/3] imap-send curl tunnelling support
Message-ID: <20170816083924.uzukuqdz254iglhr@sigill.intra.peff.net>
References: <ab866314-608b-eaca-b335-12cffe165526@morey-chaisemartin.com>
 <7ee8331d-e154-7539-e000-4087406f39fa@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <7ee8331d-e154-7539-e000-4087406f39fa@suse.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Aug 15, 2017 at 07:46:11PM +0200, Nicolas Morey-Chaisemartin wrote:

> Patch#3 will probably need some updates as I expected Jeff old curl drop patches to make it in.
> As it seems to be going another way a few more ifdefs will be required

I'm not sure where we're going with the old-curl versions thing, but I
don't think it matters much either way for imap-send. If we drop support
for anything, it will be versions of curl less than 7.19.4. But curl
didn't get imap support until 7.34.0 (or at least that's what our
Makefile checks for), so I think that's effectively the oldest version
you'd be dealing with here.

(Which I think means your 7.21.5 #ifdef in patch 3 could never trigger).

-Peff
