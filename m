Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A72BC433EF
	for <git@archiver.kernel.org>; Mon, 25 Oct 2021 19:09:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1E96B60FE8
	for <git@archiver.kernel.org>; Mon, 25 Oct 2021 19:09:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233118AbhJYTLV (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 25 Oct 2021 15:11:21 -0400
Received: from cloud.peff.net ([104.130.231.41]:46050 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230146AbhJYTLU (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Oct 2021 15:11:20 -0400
Received: (qmail 6559 invoked by uid 109); 25 Oct 2021 19:08:58 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 25 Oct 2021 19:08:58 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 22679 invoked by uid 111); 25 Oct 2021 19:08:57 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 25 Oct 2021 15:08:57 -0400
Authentication-Results: peff.net; auth=none
Date:   Mon, 25 Oct 2021 15:08:57 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/6] Makefile: be less eager to re-build, *.sh code
 cleanups
Message-ID: <YXcAyWR55UurEUwv@coredump.intra.peff.net>
References: <cover-0.6-00000000000-20211021T195538Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover-0.6-00000000000-20211021T195538Z-avarab@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Oct 21, 2021 at 09:57:54PM +0200, Ævar Arnfjörð Bjarmason wrote:

> This removes the dependency of our built *.sh on $(GIT_VERSION), which
> as noted in 2/6 looks to have been the intention back in 2012, but
> didn't happen then.
> 
> The rest of the series removes more dead code related to our
> $(SCRIPT_DEFINES), some of it it not used or needed for 5-15ish years.
> 
> Ævar Arnfjörð Bjarmason (6):
>   Makefile: move git-SCRIPT-DEFINES adjacent to $(SCRIPT_DEFINES)
>   Makefile: remove $(GIT_VERSION) from $(SCRIPT_DEFINES)
>   Makefile: remove $(NO_CURL) from $(SCRIPT_DEFINES)
>   git-instaweb: unconditionally assume that gitweb is mod_perl capable
>   git-sh-setup: remove unused sane_egrep() function
>   git-sh-setup: remove "sane_grep", it's not needed anymore

The first five all look obviously correct to me. The 6th also looks
fine, but I don't have a strong opinion on the filter-branch thing
either way.

-Peff
