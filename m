Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B43ABC432BE
	for <git@archiver.kernel.org>; Wed,  1 Sep 2021 10:10:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9E76160234
	for <git@archiver.kernel.org>; Wed,  1 Sep 2021 10:10:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232543AbhIAKLQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 1 Sep 2021 06:11:16 -0400
Received: from cloud.peff.net ([104.130.231.41]:36230 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232258AbhIAKLP (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Sep 2021 06:11:15 -0400
Received: (qmail 16456 invoked by uid 109); 1 Sep 2021 10:10:18 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 01 Sep 2021 10:10:18 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 5581 invoked by uid 111); 1 Sep 2021 10:10:20 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 01 Sep 2021 06:10:20 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 1 Sep 2021 06:10:17 -0400
From:   Jeff King <peff@peff.net>
To:     Carlo Marcelo Arenas =?utf-8?B?QmVsw7Nu?= <carenas@gmail.com>
Cc:     git@vger.kernel.org, avarab@gmail.com, phillip.wood@dunelm.org.uk,
        gitster@pobox.com, mackyle@gmail.com, sunshine@sunshineco.com
Subject: Re: [RFC PATCH v2 0/4] developer: support pedantic
Message-ID: <YS9RieTeJSFmd6M7@coredump.intra.peff.net>
References: <20210809013833.58110-4-carenas@gmail.com>
 <20210901091941.34886-1-carenas@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210901091941.34886-1-carenas@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Sep 01, 2021 at 02:19:37AM -0700, Carlo Marcelo Arenas Belón wrote:

> first patch was suggested[1] by Peff, so hopefully my commit message
> and his assumed SoB are still worth not mixing it with patch 2 (which
> has a slight different but related focus and touches the same files)
> but since it is no longer a single patch, lets go wild.

My SoB is fine there (though really Ævar did the actual thinking; I just
deleted a lot of lines in vim :) ).

Patch 2 looks good to me, though I kind of wonder if it is even worth
having an option to turn it off.

> patches 3 and 4 are optional and mostly for RFC, so that a solution
> to any possible issue that the retiring of USE_PARENS_AROUND_GETTEXT_N
> are addressed.

IMHO the issue it is trying to find is not worth the inevitable problems
that hacky perl parsing of C will cause (both false positives and
negatives). Not a statement on your perl code, but just based on
previous experience.

So I'd probably take the first two patches, and leave the others.

-Peff
