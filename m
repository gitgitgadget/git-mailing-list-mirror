Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B09BC1F42D
	for <e@80x24.org>; Sun, 18 Mar 2018 09:28:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752711AbeCRJ22 (ORCPT <rfc822;e@80x24.org>);
        Sun, 18 Mar 2018 05:28:28 -0400
Received: from cloud.peff.net ([104.130.231.41]:33178 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751934AbeCRJ22 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 18 Mar 2018 05:28:28 -0400
Received: (qmail 3188 invoked by uid 109); 18 Mar 2018 09:28:28 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Sun, 18 Mar 2018 09:28:28 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 10599 invoked by uid 111); 18 Mar 2018 09:29:23 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Sun, 18 Mar 2018 05:29:23 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 18 Mar 2018 05:28:26 -0400
Date:   Sun, 18 Mar 2018 05:28:26 -0400
From:   Jeff King <peff@peff.net>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        git@vger.kernel.org, larsxschneider@gmail.com,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Makefile: detect compiler and enable more warnings in
 DEVELOPER=1
Message-ID: <20180318092825.GC29208@sigill.intra.peff.net>
References: <20180317160832.GB15772@sigill.intra.peff.net>
 <20180318081834.16081-1-pclouds@gmail.com>
 <20180318090607.GA26226@flurp.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180318090607.GA26226@flurp.local>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Mar 18, 2018 at 05:06:07AM -0400, Eric Sunshine wrote:

> On MacOS, "cc -v" output is:
> 
> --- >8 ---
> Apple LLVM version 9.0.0 (clang-900.0.39.2)
> Target: x86_64-apple-darwin16.7.0
> Thread model: posix
> InstalledDir: ...
> --- >8 ---

Is that really way ahead of the clang releases (which are at 7.0,
AFAIK), or do they use a totally different number scheme?

If the latter, I guess we'd have to treat it separately from clang and
have all of the conditionals treat it independently? Yuck.

-Peff
