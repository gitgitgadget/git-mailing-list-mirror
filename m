Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13DDEC433E6
	for <git@archiver.kernel.org>; Fri, 15 Jan 2021 09:37:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B6EC222A84
	for <git@archiver.kernel.org>; Fri, 15 Jan 2021 09:37:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728064AbhAOJgz (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 15 Jan 2021 04:36:55 -0500
Received: from cloud.peff.net ([104.130.231.41]:57034 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726652AbhAOJgz (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Jan 2021 04:36:55 -0500
Received: (qmail 32481 invoked by uid 109); 15 Jan 2021 09:36:22 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 15 Jan 2021 09:36:22 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 25817 invoked by uid 111); 15 Jan 2021 09:36:24 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 15 Jan 2021 04:36:24 -0500
Authentication-Results: peff.net; auth=none
Date:   Fri, 15 Jan 2021 04:36:21 -0500
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Denton Liu <liu.denton@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 1/6] test-lib: add tests for test_might_fail
Message-ID: <YAFiFW7D1qD7ZJ8I@coredump.intra.peff.net>
References: <20191115040909.GA21654@sigill.intra.peff.net>
 <20210114233515.31298-2-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210114233515.31298-2-avarab@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jan 15, 2021 at 12:35:10AM +0100, Ævar Arnfjörð Bjarmason wrote:

> +test_expect_success 'test_might_fail is like test_must_fail ok=' '
> +	! test_must_fail git version &&
> +	! test_must_fail ok= git version &&
> +	test_might_fail git version
> +'

The title confuses me. Isn't might_fail like "must_fail ok=success"?

And certainly the code here shows us expecting the _opposite_ of what
"Must_fail ok=" does.

-Peff
