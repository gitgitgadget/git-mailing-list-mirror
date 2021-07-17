Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89816C12002
	for <git@archiver.kernel.org>; Sat, 17 Jul 2021 02:34:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6359E613AF
	for <git@archiver.kernel.org>; Sat, 17 Jul 2021 02:34:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232662AbhGQChY (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 16 Jul 2021 22:37:24 -0400
Received: from cloud.peff.net ([104.130.231.41]:52664 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230504AbhGQChX (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Jul 2021 22:37:23 -0400
Received: (qmail 22700 invoked by uid 109); 17 Jul 2021 02:34:28 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sat, 17 Jul 2021 02:34:28 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 16561 invoked by uid 111); 17 Jul 2021 02:34:28 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 16 Jul 2021 22:34:28 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 16 Jul 2021 22:34:26 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Han-Wen Nienhuys <hanwen@google.com>,
        Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH v2 00/11] fix "git reflog expire" race & get rid of
 EISDIR in refs API
Message-ID: <YPJBsnrPTEXvYG7I@coredump.intra.peff.net>
References: <patch-1.1-de0838fe99-20210714T111351Z-avarab@gmail.com>
 <cover-00.11-00000000000-20210716T140631Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover-00.11-00000000000-20210716T140631Z-avarab@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jul 16, 2021 at 04:12:56PM +0200, Ævar Arnfjörð Bjarmason wrote:

>  builtin/reflog.c      |  17 +++---
>  reflog-walk.c         |   3 +-
>  refs.c                |   5 +-
>  refs.h                |   4 +-
>  refs/debug.c          |  10 ++--
>  refs/files-backend.c  | 122 ++++++++++--------------------------------
>  refs/packed-backend.c |   5 ++
>  7 files changed, 54 insertions(+), 112 deletions(-)

The diffstat certainly looks nice. :)

I left a few comments on specific patches, mostly just little things.
The ones I didn't comment on looked good to me. Overall, it seems like a
very nice cleanup. Thanks for putting it together.

-Peff
