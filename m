Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C32771F461
	for <e@80x24.org>; Sun,  8 Sep 2019 21:32:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730832AbfIHVcf (ORCPT <rfc822;e@80x24.org>);
        Sun, 8 Sep 2019 17:32:35 -0400
Received: from cloud.peff.net ([104.130.231.41]:43590 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1729928AbfIHVcf (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 8 Sep 2019 17:32:35 -0400
Received: (qmail 31097 invoked by uid 109); 8 Sep 2019 21:32:35 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Sun, 08 Sep 2019 21:32:35 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 3009 invoked by uid 111); 8 Sep 2019 21:34:25 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sun, 08 Sep 2019 17:34:25 -0400
Authentication-Results: peff.net; auth=none
Date:   Sun, 8 Sep 2019 17:32:34 -0400
From:   Jeff King <peff@peff.net>
To:     SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        git@vger.kernel.org,
        Martin =?utf-8?B?w4VncmVu?= <martin.agren@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Documentation: fix build with Asciidoctor 2
Message-ID: <20190908213233.GC8514@sigill.intra.peff.net>
References: <20190906232947.GJ11334@genre.crustytoothpaste.net>
 <20190907170746.273984-1-sandals@crustytoothpaste.net>
 <20190908141308.GA7255@szeder.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190908141308.GA7255@szeder.dev>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Sep 08, 2019 at 04:13:08PM +0200, SZEDER Gábor wrote:

> OTOH, these "stripped namespace" messages come from 'xmlto', are not
> warnings but have that "Note:" prefix, and, trusting that you did
> check the results thoroughly, are apparently not a sign of any
> rendering issues.  So I think it's safe to ignore them and this patch
> should strip them from 'make doc's output in
> 'ci/test-documentation.sh'.

Yeah, I'd agree (though I do think there are some other issues with this
approach, at least in my tests).

If we do go this route, it might even be nice to use a small xmlto
wrapper that filters the stderr for us. Then the ci code doesn't have to
know about this distinction, and it prevents users from seeing the ugly
messages.

-Peff
