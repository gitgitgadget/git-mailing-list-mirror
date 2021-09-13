Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C89AFC433EF
	for <git@archiver.kernel.org>; Mon, 13 Sep 2021 18:04:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A392860EE9
	for <git@archiver.kernel.org>; Mon, 13 Sep 2021 18:04:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346476AbhIMSGE (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 13 Sep 2021 14:06:04 -0400
Received: from cloud.peff.net ([104.130.231.41]:46426 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236904AbhIMSGE (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Sep 2021 14:06:04 -0400
Received: (qmail 20785 invoked by uid 109); 13 Sep 2021 18:04:48 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 13 Sep 2021 18:04:48 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 12368 invoked by uid 111); 13 Sep 2021 18:04:47 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 13 Sep 2021 14:04:47 -0400
Authentication-Results: peff.net; auth=none
Date:   Mon, 13 Sep 2021 14:04:47 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v2 0/4] difftool refactoring + remove OPT_ARGUMENT() macro
Message-ID: <YT+Sv6gdNTMuP5NC@coredump.intra.peff.net>
References: <cover-0.2-00000000000-20210911T182009Z-avarab@gmail.com>
 <cover-v2-0.4-00000000000-20210913T033204Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover-v2-0.4-00000000000-20210913T033204Z-avarab@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Sep 13, 2021 at 05:35:36AM +0200, Ævar Arnfjörð Bjarmason wrote:

> I think this v2 should address the comments Jeff King had in
> https://lore.kernel.org/git/YT6BnnXeAWn8BycF@coredump.intra.peff.net/;
> there's now an amended version of his proposed patch as part of this,
> but I prepended it with another one to prepare the "struct
> child_process" in cmd_difftool().
> 
> Doing so nicely gets around the question of the strvec memory
> management, since we can trust the run-command.c API to do that for
> us, but couldn't in my v1 when we'd copy our own "struct strvec *" to
> its "args".

Thanks for taking my suggestions into account. I like this approach, and
I don't see any bugs. I replied separately to patch 3 with some further
opportunities for cleanup, but with or without them, this is all a
strict improvement.

-Peff
