Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDB7FC433ED
	for <git@archiver.kernel.org>; Fri, 23 Apr 2021 09:32:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 91DF46145A
	for <git@archiver.kernel.org>; Fri, 23 Apr 2021 09:32:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241739AbhDWJdA (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 23 Apr 2021 05:33:00 -0400
Received: from cloud.peff.net ([104.130.231.41]:33136 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229939AbhDWJc7 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Apr 2021 05:32:59 -0400
Received: (qmail 6031 invoked by uid 109); 23 Apr 2021 09:32:21 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 23 Apr 2021 09:32:21 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 6487 invoked by uid 111); 23 Apr 2021 09:32:23 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 23 Apr 2021 05:32:23 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 23 Apr 2021 05:32:20 -0400
From:   Jeff King <peff@peff.net>
To:     Patrick Steinhardt <ps@pks.im>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
Subject: Re: [PATCH v5 0/3] config: allow overriding global/system config
Message-ID: <YIKUJMyxL17I+42V@coredump.intra.peff.net>
References: <cover.1618297711.git.ps@pks.im>
 <cover.1618835148.git.ps@pks.im>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1618835148.git.ps@pks.im>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Apr 19, 2021 at 02:31:04PM +0200, Patrick Steinhardt wrote:

> this is the fifth version of my patch series to provide a way of
> overriding the global system configuration.
> 
> Changes to v4:
> 
>     - Readded the call to `git_config_system()`, which I've previously
>       dropped by accident. I didn't move it into the new
>       `git_system_config()` function as it would change semantics of
>       `git config --system`.
> 
>     - Added a testcase which verifies that GIT_CONFIG_NOSYSTEM and
>       GIT_CONFIG_SYSTEM properly interact with each other: if
>       GIT_CONFIG_NOSYSTEM is set, no system-level configuration shall be
>       read. This is different than the tests for `git config --system`
>       which used to and still does ignore GIT_CONFIG_NOSYSTEM.
> 
>     - Small fixups for another testcase to drop needless redirects and
>       the `sane_unset` of GIT_CONFIG_NOSYSTEM.

With the extra fixup to avoid unsetting GIT_CONFIG_NOSYSTEM for the
whole test suite, this looks good to me.

-Peff
