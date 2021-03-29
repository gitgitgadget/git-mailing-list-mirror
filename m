Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EB9AC433E3
	for <git@archiver.kernel.org>; Mon, 29 Mar 2021 10:41:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 56F8161938
	for <git@archiver.kernel.org>; Mon, 29 Mar 2021 10:41:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232374AbhC2Kkf (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 29 Mar 2021 06:40:35 -0400
Received: from cloud.peff.net ([104.130.231.41]:35286 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231716AbhC2KkS (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Mar 2021 06:40:18 -0400
Received: (qmail 10077 invoked by uid 109); 29 Mar 2021 10:40:18 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 29 Mar 2021 10:40:18 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 12062 invoked by uid 111); 29 Mar 2021 10:40:19 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 29 Mar 2021 06:40:19 -0400
Authentication-Results: peff.net; auth=none
Date:   Mon, 29 Mar 2021 06:40:17 -0400
From:   Jeff King <peff@peff.net>
To:     "lilinchao@oschina.cn" <lilinchao@oschina.cn>
Cc:     Junio C Hamano <gitster@pobox.com>, git <git@vger.kernel.org>
Subject: Re: Re: [PATCH 2/2] remote-curl.c: handle v1 when check_smart_http
Message-ID: <YGGukSxGVnTeXae0@coredump.intra.peff.net>
References: <20210324053648.25584-1-lilinchao@oschina.cn>
 <006547b28c6311eb93820024e87935e7@oschina.cn>
 <xmqq7dlwxpn3.fsf@gitster.g>
 <e4d6bef08dfb11eb90f0a4badb2c2b1115536@peff.net>
 <68765f14907111eb8e180024e87935e7@oschina.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <68765f14907111eb8e180024e87935e7@oschina.cn>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Mar 29, 2021 at 05:30:29PM +0800, lilinchao@oschina.cn wrote:

> >Anyway, that's all just an interesting side note. The client is happy
> >with either form (though it might be nice if we had tests for the "#
> >service" form; I suspect our tests don't cover that because they are all
> >using http-backend).
> >
> >Getting back to the patch at hand, if there is a server saying "version
> >1" without a "service" line, then I think that is a bug in that server.
> > 
> If the problem is on the server side, then, is this patch worth continuing?

IMHO, no. I think the response from gitee.com is violating the protocol
spec. It would be nice to fix, but in practice it isn't all that
important because somebody would have to manually set protocol.version=1
to see the problem.

-Peff
