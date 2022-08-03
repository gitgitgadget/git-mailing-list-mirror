Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09AABC19F28
	for <git@archiver.kernel.org>; Wed,  3 Aug 2022 17:33:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236999AbiHCRdb (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 3 Aug 2022 13:33:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236024AbiHCRd1 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 Aug 2022 13:33:27 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69282564CB
        for <git@vger.kernel.org>; Wed,  3 Aug 2022 10:33:26 -0700 (PDT)
Received: (qmail 8359 invoked by uid 109); 3 Aug 2022 17:33:26 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 03 Aug 2022 17:33:26 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 13248 invoked by uid 111); 3 Aug 2022 17:33:25 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 03 Aug 2022 13:33:25 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 3 Aug 2022 13:33:25 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v3 0/6] revisions API: fix more memory leaks
Message-ID: <YuqxZTKR65pVFqBp@coredump.intra.peff.net>
References: <cover-v2-0.6-00000000000-20220729T082919Z-avarab@gmail.com>
 <cover-v3-0.6-00000000000-20220802T152925Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover-v3-0.6-00000000000-20220802T152925Z-avarab@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Aug 02, 2022 at 05:33:10PM +0200, Ævar Arnfjörð Bjarmason wrote:

> Changes since v2:
> 
> * I think the rewrite here of fixing the leak should address Jeff
>   King's concerns. I was somewhat mentally stuck on trying to change
>   the code to make the leak fix easier, and then having the leak fix.
> 
>   But I think as the new 3/6 shows fixing the leak first is much
>   easier, and more straightforward to explain.

Yeah, I think fixing the leak first is fine. I did prefer the end result
of the earlier round, but I can live with it either way.

> * A new 4/6 then follows-up and rewrites the variable clobbering that
>   was needed for the pre-image of 3/6.
> 
> * Don't reference the "XXX" comment in 6/6.

I'd hoped you'd take my replacement 5/6, but again, I can live with it
either way.

-Peff
