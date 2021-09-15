Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81E51C433F5
	for <git@archiver.kernel.org>; Wed, 15 Sep 2021 18:34:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 622BF60F92
	for <git@archiver.kernel.org>; Wed, 15 Sep 2021 18:34:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231151AbhIOSgQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 15 Sep 2021 14:36:16 -0400
Received: from cloud.peff.net ([104.130.231.41]:48352 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229718AbhIOSgQ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Sep 2021 14:36:16 -0400
Received: (qmail 376 invoked by uid 109); 15 Sep 2021 18:34:56 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 15 Sep 2021 18:34:56 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 26789 invoked by uid 111); 15 Sep 2021 18:34:56 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 15 Sep 2021 14:34:56 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 15 Sep 2021 14:34:55 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Junio C Hamano <gitster@pobox.com>,
        Taylor Blau <me@ttaylorr.com>,
        Martin =?utf-8?B?w4VncmVu?= <martin.agren@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: [PATCH v3 0/11] limit memory allocations for v2 servers
Message-ID: <YUI8z5SiyvgrDBas@coredump.intra.peff.net>
References: <YUC/6n1hhUbMJiLw@coredump.intra.peff.net>
 <YUE1alo58cGyTw6/@coredump.intra.peff.net>
 <YUI8kBkK6SJYJcDO@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YUI8kBkK6SJYJcDO@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Sep 15, 2021 at 02:33:53PM -0400, Jeff King wrote:

> OK, hopefully third time's the charm. The changes from v2 are pretty
> minor:
> 
>  - test typos noticed by Eric (none affected the outcome of the tests)
> 
>  - I added "object-format=$(test_oid algo)" to the input of a few of the
>    new tests even where it doesn't change the outcome, for consistency
>    with the existing tests
> 
>  - dropped out-dated "collect" comment noticed by Junio
> 
>  - explained the command=ls-refs=foo case a little further, including
>    specific references in how it violates the spec
> 
> Range-diff is below.

Er, that should have been "v3" in the subject, as this one now is.

-Peff
