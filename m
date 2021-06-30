Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E4F9C11F67
	for <git@archiver.kernel.org>; Wed, 30 Jun 2021 01:35:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F19B561D8C
	for <git@archiver.kernel.org>; Wed, 30 Jun 2021 01:35:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231856AbhF3BiM (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 29 Jun 2021 21:38:12 -0400
Received: from cloud.peff.net ([104.130.231.41]:36912 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230033AbhF3BiL (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 Jun 2021 21:38:11 -0400
Received: (qmail 22116 invoked by uid 109); 30 Jun 2021 01:35:44 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 30 Jun 2021 01:35:44 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 792 invoked by uid 111); 30 Jun 2021 01:35:44 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 29 Jun 2021 21:35:44 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 29 Jun 2021 21:35:42 -0400
From:   Jeff King <peff@peff.net>
To:     Patrick Steinhardt <ps@pks.im>
Cc:     git@vger.kernel.org, Felipe Contreras <felipe.contreras@gmail.com>,
        SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>,
        Chris Torek <chris.torek@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 2/3] receive-pack: skip connectivity checks on
 delete-only commands
Message-ID: <YNvKbtE+EWKvf2Qe@coredump.intra.peff.net>
References: <cover.1624858240.git.ps@pks.im>
 <b3272f499e51cfc53345f9f09f8762db1a4cf0a6.1624858240.git.ps@pks.im>
 <YNvJj42ALg4/t+0l@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YNvJj42ALg4/t+0l@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jun 29, 2021 at 09:31:59PM -0400, Jeff King wrote:

> If I run "git rev-list --not --all --stdin </dev/null" in linux.git, it
> takes about 35ms. But if I make a ton of refs, like:

The "--stdin" should be before "--not", of course, to mimic a real
connectivity check. But it doesn't matter in this case because we're
feeding an empty input. :)

-Peff
