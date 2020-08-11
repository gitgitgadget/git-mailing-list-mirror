Return-Path: <SRS0=r8De=BV=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76E79C433E1
	for <git@archiver.kernel.org>; Tue, 11 Aug 2020 04:18:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5B300206DA
	for <git@archiver.kernel.org>; Tue, 11 Aug 2020 04:18:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726134AbgHKERr (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 11 Aug 2020 00:17:47 -0400
Received: from aibo.runbox.com ([91.220.196.211]:47882 "EHLO aibo.runbox.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725860AbgHKERr (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Aug 2020 00:17:47 -0400
Received: from [10.9.9.74] (helo=submission03.runbox)
        by mailtransmit03.runbox with esmtp (Exim 4.86_2)
        (envelope-from <me@pluvano.com>)
        id 1k5LjM-00031X-VW; Tue, 11 Aug 2020 06:17:45 +0200
Received: by submission03.runbox with esmtpsa  [Authenticated alias (964124)]  (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.90_1)
        id 1k5LjK-0000wT-Rf; Tue, 11 Aug 2020 06:17:43 +0200
Date:   Tue, 11 Aug 2020 04:17:28 +0000
From:   Emma Brooks <me@pluvano.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org,
        Jakub =?utf-8?B?TmFyxJlic2tp?= <jnareb@gmail.com>
Subject: Re: [PATCH v2] gitweb: map names/emails with mailmap
Message-ID: <20200811041728.GA1748@pluvano.com>
References: <20200808213457.13116-1-me@pluvano.com>
 <20200809230436.2152-1-me@pluvano.com>
 <20200810100249.GC37030@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200810100249.GC37030@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2020-08-10 06:02:49-0400, Jeff King wrote:
> There was a little discussion in response to v1 on whether we could
> reuse the existing C mailmap code:
> 
>   https://lore.kernel.org/git/20200731010129.GD240563@coredump.intra.peff.net/
> 
> Did you have any thoughts on that?

I think it's probably not worth the effort to make the necessary changes
to "rev-list --header" Junio mentioned, just for gitweb.

I agree it's a bit worrisome to have a second parser that could
potentially behave slightly differently than the main implementation.
What if we added tests for gitweb's mailmap parsing based on the same
cases used for Git itself?
