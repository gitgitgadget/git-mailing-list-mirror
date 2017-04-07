Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E053D1FAFB
	for <e@80x24.org>; Fri,  7 Apr 2017 05:23:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752784AbdDGFW7 (ORCPT <rfc822;e@80x24.org>);
        Fri, 7 Apr 2017 01:22:59 -0400
Received: from cloud.peff.net ([104.130.231.41]:57900 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752449AbdDGFW6 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Apr 2017 01:22:58 -0400
Received: (qmail 24922 invoked by uid 109); 7 Apr 2017 05:22:58 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 07 Apr 2017 05:22:58 +0000
Received: (qmail 32117 invoked by uid 111); 7 Apr 2017 05:23:16 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 07 Apr 2017 01:23:16 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 07 Apr 2017 01:22:55 -0400
Date:   Fri, 7 Apr 2017 01:22:55 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: [PATCH] test-read-cache: setup git dir
Message-ID: <20170407052255.vc6ch633zcdiplgy@sigill.intra.peff.net>
References: <020feb89-be3e-1261-d9b5-cad7c38ef2f0@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <020feb89-be3e-1261-d9b5-cad7c38ef2f0@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Apr 06, 2017 at 10:41:41PM +0200, René Scharfe wrote:

> b1ef400e (setup_git_env: avoid blind fall-back to ".git") made programs
> that tried to access a repository without initializing properly die with
> a diagnostic message.  One offender is test-read-cache, which is used in
> p0002.  Fix it by calling setup_git_directory() before accessing the
> index.

Right, makes sense. I wondered why we didn't notice this before, but
it's because it's _only_ called from the perf suite.

-Peff
