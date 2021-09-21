Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77292C433F5
	for <git@archiver.kernel.org>; Tue, 21 Sep 2021 19:18:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5784761166
	for <git@archiver.kernel.org>; Tue, 21 Sep 2021 19:18:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234380AbhIUTUF (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 21 Sep 2021 15:20:05 -0400
Received: from cloud.peff.net ([104.130.231.41]:51998 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234301AbhIUTUE (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Sep 2021 15:20:04 -0400
Received: (qmail 6446 invoked by uid 109); 21 Sep 2021 19:18:35 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 21 Sep 2021 19:18:35 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 3904 invoked by uid 111); 21 Sep 2021 19:18:35 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 21 Sep 2021 15:18:35 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 21 Sep 2021 15:18:34 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Hamza Mahfooz <someguy@effective-light.com>,
        Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH 6/5] grep.c: mark eol/bol and derived as "const char *
 const"
Message-ID: <YUowCkmWqKgIldNz@coredump.intra.peff.net>
References: <YUlVZk1xXulAqdef@coredump.intra.peff.net>
 <patch-1.1-c317e6e125e-20210921T124416Z-avarab@gmail.com>
 <YUnx7gt0KQNRlhuZ@coredump.intra.peff.net>
 <874kadapq1.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <874kadapq1.fsf@evledraar.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Sep 21, 2021 at 05:17:57PM +0200, Ævar Arnfjörð Bjarmason wrote:

> 
> On Tue, Sep 21 2021, Jeff King wrote:
> 
> > On Tue, Sep 21, 2021 at 02:45:16PM +0200, Ævar Arnfjörð Bjarmason wrote:
> >
> >> I think that generally git's codebase could use going beyond just
> >> "const char *" when a "const char * const" would suffice, for some
> >> reason we seem to mostly use it for the static usage variables.
> >
> > I didn't dig up the references in the list archive, but I feel like
> > we've had this discussion long ago. One of the reasons not to do so is
> > that it pollutes the function's interface with internal details.[...]
> 
> Are there cases in my conversion where the caller has to do anything
> special that they didn't before? These are also all static functions, so
> it's all internal details exported to nobody.

No, they don't have to do anything differently. I just meant that it
clutters the interface when a human is reading it.

-Peff
