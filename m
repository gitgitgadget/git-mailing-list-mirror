Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46511C433DB
	for <git@archiver.kernel.org>; Tue, 23 Feb 2021 18:32:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 071FB64E6B
	for <git@archiver.kernel.org>; Tue, 23 Feb 2021 18:32:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233982AbhBWScE (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 23 Feb 2021 13:32:04 -0500
Received: from cloud.peff.net ([104.130.231.41]:41960 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233178AbhBWScB (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Feb 2021 13:32:01 -0500
Received: (qmail 26724 invoked by uid 109); 23 Feb 2021 18:31:20 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 23 Feb 2021 18:31:20 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 2305 invoked by uid 111); 23 Feb 2021 18:31:19 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 23 Feb 2021 13:31:19 -0500
Authentication-Results: peff.net; auth=none
Date:   Tue, 23 Feb 2021 13:31:19 -0500
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 0/6] Makefile: add {program,xdiff,test,git,fuzz}-objs
 & objects targets
Message-ID: <YDVJ9wumbORxTmJ5@coredump.intra.peff.net>
References: <20210201111715.10200-1-avarab@gmail.com>
 <20210223114132.24345-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210223114132.24345-1-avarab@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Feb 23, 2021 at 12:41:26PM +0100, Ævar Arnfjörð Bjarmason wrote:

> As Jeff points out in
> https://lore.kernel.org/git/YBuc5iOCCHk4fPqs@coredump.intra.peff.net/
> the use-case for having "{program-xdiff,test,git}-objs & objects"
> targets is a bit harder to justify.
> 
> I still think they're useful, particularly for testing on e.g. slow
> single-core VMs or other test setups (I use the GCC farm) where I know
> I just want to compile e.g. "test" objects, and compiling one of them
> takes 1-2 seconds.

OK. I doubt I'll end up using them myself, but I'll keep my eyes open
for opportunities. But I agree they are not creating any kind of
maintenance burden, since people would be touching the FOO_OBJS lists
both before and after your patches anyway. So it does not hurt to try.

> Ævar Arnfjörð Bjarmason (6):
>   Makefile: guard against TEST_OBJS in the environment
>   Makefile: split up long OBJECTS line
>   Makefile: sort OBJECTS assignment for subsequent change
>   Makefile: split OBJECTS into OBJECTS and GIT_OBJS
>   Makefile: add {program,xdiff,test,git,fuzz}-objs & objects targets
>   Makefile: build "$(FUZZ_OBJS)" in CI, not under "all"

The first five all look good to me.  I'm skeptical of the final one; I
wrote more comments in response to that patch.

-Peff
