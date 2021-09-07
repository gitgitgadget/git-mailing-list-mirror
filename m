Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA1D1C433F5
	for <git@archiver.kernel.org>; Tue,  7 Sep 2021 16:44:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B4ABE60E77
	for <git@archiver.kernel.org>; Tue,  7 Sep 2021 16:44:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344586AbhIGQps (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Sep 2021 12:45:48 -0400
Received: from cloud.peff.net ([104.130.231.41]:40706 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238089AbhIGQpr (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Sep 2021 12:45:47 -0400
Received: (qmail 19592 invoked by uid 109); 7 Sep 2021 16:44:41 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 07 Sep 2021 16:44:41 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 15163 invoked by uid 111); 7 Sep 2021 16:44:41 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 07 Sep 2021 12:44:41 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 7 Sep 2021 12:44:40 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Andrzej Hunt <andrzej@ahunt.org>,
        =?utf-8?B?TMOpbmHDr2M=?= Huard <lenaic@lhuard.fr>,
        Derrick Stolee <dstolee@microsoft.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>,
        =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>, Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v4 0/3] add a test mode for SANITIZE=leak, run it in CI
Message-ID: <YTeW+MpIVNCcd2nF@coredump.intra.peff.net>
References: <cover-v3-0.8-00000000000-20210831T132546Z-avarab@gmail.com>
 <cover-v4-0.3-00000000000-20210907T151855Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover-v4-0.3-00000000000-20210907T151855Z-avarab@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Sep 07, 2021 at 05:33:28PM +0200, Ævar Arnfjörð Bjarmason wrote:

> Changes since v3:
> 
>  * Much updated commit message
> 
>  * Re-arranged the t/README change to avoid a conflict with "seen".
> 
>  * Now testing OSX as well as Linux. Full CI passes on top of "master"
>    on both: https://github.com/avar/git/runs/3535331215
> 
>  * I ejected the previous 4-8/8 patches of adding SANITIZE=leak
>    annotations to various tests, let's focus on the test mode itself
>    here and not overly distracting ourselves with whatever other
>    regressions on "seen" those annotations might cause, I can submit
>    those annotations later.
> 
>  * As noted in the updated commit message I didn't end up going with
>    Jeff King's suggestion of supporting LSAN_OPTIONS directly, and
>    fixing the "fd" the tests write to. All of those things can be
>    extended or fixed later.

OK, I think we should proceed with this series/approach, then. The
question of friction when CI fails is an open one, but we won't know
until we have more data. So let's see what happens. :)

The patches themselves look fine to me, though I had a few nits on the
third commit message.

-Peff
