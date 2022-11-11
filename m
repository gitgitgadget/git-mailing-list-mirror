Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C255CC433FE
	for <git@archiver.kernel.org>; Fri, 11 Nov 2022 15:38:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233804AbiKKPiB (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 11 Nov 2022 10:38:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233654AbiKKPh7 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Nov 2022 10:37:59 -0500
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEC6063BA2
        for <git@vger.kernel.org>; Fri, 11 Nov 2022 07:37:58 -0800 (PST)
Received: (qmail 412 invoked by uid 109); 11 Nov 2022 15:37:57 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 11 Nov 2022 15:37:57 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 6112 invoked by uid 111); 11 Nov 2022 15:37:57 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 11 Nov 2022 10:37:57 -0500
Authentication-Results: peff.net; auth=none
Date:   Fri, 11 Nov 2022 10:37:57 -0500
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>, git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Taylor Blau <me@ttaylorr.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 11/11] Turn `git bisect` into a full built-in
Message-ID: <Y25sVYUAVvsfRiPK@coredump.intra.peff.net>
References: <cover.1668097286.git.congdanhqx@gmail.com>
 <cover.1668097962.git.congdanhqx@gmail.com>
 <dadca7adbe3e7984f60fd6de6c8d63edb6a1ad8f.1668097966.git.congdanhqx@gmail.com>
 <221111.86edu9oa9d.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <221111.86edu9oa9d.gmgdl@evledraar.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Nov 11, 2022 at 02:53:19PM +0100, Ævar Arnfjörð Bjarmason wrote:

> Do we have a test for at least the exit code of "git bisect -h"? I think
> not, because before this it would have been (from skimming
> git-sh-setup.sh) 1, but 129 after.
> 
> The new exit code is better, but let's test that. For some exitsing tests:
> 
> 	git grep 'test_expect_code 129 .*-h'

It should be covered by t0012 automatically once it becomes a builtin
(and checking out the tip of dd/git-bisect-builtin, that seems to be the
case).

-Peff
