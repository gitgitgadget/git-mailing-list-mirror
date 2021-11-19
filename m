Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 060EAC433F5
	for <git@archiver.kernel.org>; Fri, 19 Nov 2021 14:34:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DDCE2610D0
	for <git@archiver.kernel.org>; Fri, 19 Nov 2021 14:34:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235924AbhKSOhH (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 19 Nov 2021 09:37:07 -0500
Received: from cloud.peff.net ([104.130.231.41]:34862 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235895AbhKSOhH (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Nov 2021 09:37:07 -0500
Received: (qmail 8262 invoked by uid 109); 19 Nov 2021 14:34:05 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 19 Nov 2021 14:34:05 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 13018 invoked by uid 111); 19 Nov 2021 14:34:05 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 19 Nov 2021 09:34:05 -0500
Authentication-Results: peff.net; auth=none
Date:   Fri, 19 Nov 2021 09:34:04 -0500
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/6] object-store.h: remove unused has_sha1_file*()
Message-ID: <YZe13Blt/NXy85gS@coredump.intra.peff.net>
References: <cover-0.6-00000000000-20211119T124420Z-avarab@gmail.com>
 <patch-3.6-62ed0ec6077-20211119T124420Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <patch-3.6-62ed0ec6077-20211119T124420Z-avarab@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Nov 19, 2021 at 01:46:23PM +0100, Ævar Arnfjörð Bjarmason wrote:

> These macros were last used in 5d3679ee023 (sha1-file: drop
> has_sha1_file(), 2019-01-07), so let's remove coccinelle migration
> rules added 9b45f499818 (object-store: prepare has_{sha1, object}_file
> to handle any repo, 2018-11-13), along with the compatibility macros
> themselves.
> 
> The "These functions.." in the diff context and the general comment
> about compatibility macros still applies to
> "NO_THE_REPOSITORY_COMPATIBILITY_MACROS" use just a few lines below
> this, so let's keep the comment.

Yep, makes sense. I cleaned up the object_id.cocci file, but didn't
think to look for the_repository rules or helpers. Nice to see this
going away, too.

-Peff
