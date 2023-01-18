Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 708E1C38147
	for <git@archiver.kernel.org>; Wed, 18 Jan 2023 19:17:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229926AbjARTRL (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 18 Jan 2023 14:17:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229946AbjARTRJ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Jan 2023 14:17:09 -0500
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CF1D17CCE
        for <git@vger.kernel.org>; Wed, 18 Jan 2023 11:17:08 -0800 (PST)
Received: (qmail 2753 invoked by uid 109); 18 Jan 2023 19:17:08 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 18 Jan 2023 19:17:08 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 24097 invoked by uid 111); 18 Jan 2023 19:17:09 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 18 Jan 2023 14:17:09 -0500
Authentication-Results: peff.net; auth=none
Date:   Wed, 18 Jan 2023 14:17:07 -0500
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v4 15/19] object-file.c: release the "tag" in check_tag()
Message-ID: <Y8hFs3V7lSKtOTdo@coredump.intra.peff.net>
References: <cover-v3-00.19-00000000000-20230110T054138Z-avarab@gmail.com>
 <cover-v4-00.19-00000000000-20230117T151201Z-avarab@gmail.com>
 <patch-v4-15.19-66c24afb893-20230117T151202Z-avarab@gmail.com>
 <7e571cdd-c0fa-7519-848c-b0bc4613abab@web.de>
 <Y8gqJESD/wbEHZYb@coredump.intra.peff.net>
 <fd883d86-0c85-6c72-a331-2e8b2064befe@web.de>
 <Y8g84mABtIiHmxTI@coredump.intra.peff.net>
 <d30e2fb2-e9dc-20e0-0761-3b585a053586@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d30e2fb2-e9dc-20e0-0761-3b585a053586@web.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jan 18, 2023 at 07:54:41PM +0100, René Scharfe wrote:

> > Yes, but it does so with lookup_commit(), so the resulting commit
> > objects are themselves reachable from the usual obj_hash, and thus not
> > leaked.
> 
> The commit_list structures are leaked, no?

Ah, yeah, you're right.

-Peff
