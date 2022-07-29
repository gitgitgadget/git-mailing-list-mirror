Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE3CDC00144
	for <git@archiver.kernel.org>; Fri, 29 Jul 2022 21:00:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238858AbiG2VAr (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 29 Jul 2022 17:00:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233332AbiG2VAq (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 Jul 2022 17:00:46 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FC8D2CE3C
        for <git@vger.kernel.org>; Fri, 29 Jul 2022 14:00:45 -0700 (PDT)
Received: (qmail 22512 invoked by uid 109); 29 Jul 2022 21:00:44 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 29 Jul 2022 21:00:44 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 29398 invoked by uid 111); 29 Jul 2022 21:00:44 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 29 Jul 2022 17:00:44 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 29 Jul 2022 17:00:43 -0400
From:   Jeff King <peff@peff.net>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>, Git List <git@vger.kernel.org>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH] merge-file: fix build warning with gcc 4.8.5
Message-ID: <YuRKe/LdNs0u7G2w@coredump.intra.peff.net>
References: <365e01e93dce582e9d926e83bdc6891310d22699.1659084832.git.congdanhqx@gmail.com>
 <xmqqbkt7api9.fsf@gitster.g>
 <YuQ60ZUPBHAVETD7@coredump.intra.peff.net>
 <CAPig+cSiAEgopj1zwR4kUG=ZLJQrNAVj0P5g4veWYD-ERr=irw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAPig+cSiAEgopj1zwR4kUG=ZLJQrNAVj0P5g4veWYD-ERr=irw@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jul 29, 2022 at 04:48:55PM -0400, Eric Sunshine wrote:

> Leaving aside for the moment the problem with Apple's oddball invented
> version numbers for `clang`, should this patch also take older `clang`
> versions into consideration rather than focusing only on `gcc`? (Of
> course, `clang` could be dealt with in a separate patch if you'd
> rather not worry about it here.)

I was just fixing the reported gcc issue, and forgot totally that clang
had been mentioned in previous rounds. I'd be happy to just see a clang
patch on top of this once somebody figures out the right versions (but
it may be impossible without figuring out the oddball Apple thing).

-Peff
