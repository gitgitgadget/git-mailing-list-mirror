Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 68E3C201B0
	for <e@80x24.org>; Tue, 28 Feb 2017 13:13:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752337AbdB1NM7 (ORCPT <rfc822;e@80x24.org>);
        Tue, 28 Feb 2017 08:12:59 -0500
Received: from cloud.peff.net ([104.130.231.41]:35611 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751737AbdB1NM7 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Feb 2017 08:12:59 -0500
Received: (qmail 26303 invoked by uid 109); 28 Feb 2017 13:12:58 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 28 Feb 2017 13:12:58 +0000
Received: (qmail 25809 invoked by uid 111); 28 Feb 2017 13:13:03 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 28 Feb 2017 08:13:03 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 28 Feb 2017 08:12:56 -0500
Date:   Tue, 28 Feb 2017 08:12:56 -0500
From:   Jeff King <peff@peff.net>
To:     Ramsay Jones <ramsay@ramsayjones.plus.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        GIT Mailing-list <git@vger.kernel.org>
Subject: Re: [PATCH 1/2] wrapper.c: remove unused git_mkstemp() function
Message-ID: <20170228131255.ufpoexm55ovpwka3@sigill.intra.peff.net>
References: <976c40d1-42dc-1fc5-45d5-05bdcf04d97e@ramsayjones.plus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <976c40d1-42dc-1fc5-45d5-05bdcf04d97e@ramsayjones.plus.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Feb 28, 2017 at 01:24:10AM +0000, Ramsay Jones wrote:

> The last caller of git_mkstemp() was removed in commit 6fec0a89
> ("verify_signed_buffer: use tempfile object", 16-06-2016). Since
> the introduction of the 'tempfile' APIs, along with git_mkstemp_mode,
> it is unlikely that new callers will materialize. Remove the dead
> code.

Yeah, I think the tempfile API is a better choice for anybody who wants
to add a new call. Removing the temptation (and the dead code) is a good
move.

-Peff
