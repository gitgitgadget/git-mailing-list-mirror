Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EABC5C43334
	for <git@archiver.kernel.org>; Fri,  1 Jul 2022 18:05:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230369AbiGASFC (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 1 Jul 2022 14:05:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229606AbiGASFB (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 Jul 2022 14:05:01 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F7453BBF3
        for <git@vger.kernel.org>; Fri,  1 Jul 2022 11:04:59 -0700 (PDT)
Received: (qmail 9631 invoked by uid 109); 1 Jul 2022 18:04:59 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 01 Jul 2022 18:04:59 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 27542 invoked by uid 111); 1 Jul 2022 18:04:58 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 01 Jul 2022 14:04:58 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 1 Jul 2022 14:04:58 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH v3 1/4] cocci: add and apply a rule to find "unused"
 strbufs
Message-ID: <Yr83SjgGMMwN0r0s@coredump.intra.peff.net>
References: <cover-v2-0.2-00000000000-20220621T223954Z-avarab@gmail.com>
 <cover-v3-0.4-00000000000-20220701T102506Z-avarab@gmail.com>
 <patch-v3-1.4-49e9ccb5819-20220701T102506Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <patch-v3-1.4-49e9ccb5819-20220701T102506Z-avarab@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jul 01, 2022 at 12:30:56PM +0200, Ævar Arnfjörð Bjarmason wrote:

> The use of "with strict" here will be explained and amended in the
> following commit.

Really s/the following/a following/ now that there's another commit in
between. :)

I didn't find the comment there very enlightening, though. It says we're
dropping "with strict" to catch some new cases around early returns. But
it's not clear to me what "strict" does in the first place, why we'd
want it, or what we might be losing by dropping it.

I know, I can probably go read the coccinelle docs to figure it out, but
it might be worth saying why it's worth including in the first place
somewhere (either here or in the follow-up commit).

-Peff
