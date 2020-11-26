Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 103D8C6379D
	for <git@archiver.kernel.org>; Thu, 26 Nov 2020 07:49:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B9961206C0
	for <git@archiver.kernel.org>; Thu, 26 Nov 2020 07:49:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731462AbgKZHta (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 26 Nov 2020 02:49:30 -0500
Received: from cloud.peff.net ([104.130.231.41]:43482 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731115AbgKZHta (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Nov 2020 02:49:30 -0500
Received: (qmail 15079 invoked by uid 109); 26 Nov 2020 07:49:30 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 26 Nov 2020 07:49:30 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 14503 invoked by uid 111); 26 Nov 2020 07:49:29 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 26 Nov 2020 02:49:29 -0500
Authentication-Results: peff.net; auth=none
Date:   Thu, 26 Nov 2020 02:49:29 -0500
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [RFC/PATCH 05/12] mktag tests: remove needless SHA-1 hardcoding
Message-ID: <X79eCcmLbgtV1jzJ@coredump.intra.peff.net>
References: <X7wq3ba3QoxjyyrQ@coredump.intra.peff.net>
 <20201126012854.399-6-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20201126012854.399-6-avarab@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Nov 26, 2020 at 02:28:47AM +0100, Ævar Arnfjörð Bjarmason wrote:

> But here we're testing for a SHA-length string which contains
> characters outside of the /[0-9a-f]/i set. Let's just do that with a
> ROT13 invocation.
> 
> We could get really unlucky and switch to a future hash function that
> just happens to produce all [0-9] output for this particular input,
> but that's very unlikely.

Maybe s/[0-9a-f]/z/ would be both simpler and more robust?

-Peff
