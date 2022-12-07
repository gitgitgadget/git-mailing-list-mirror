Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57A07C47089
	for <git@archiver.kernel.org>; Wed,  7 Dec 2022 06:02:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229685AbiLGGCK (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 7 Dec 2022 01:02:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229901AbiLGGCF (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Dec 2022 01:02:05 -0500
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFF8711A38
        for <git@vger.kernel.org>; Tue,  6 Dec 2022 22:02:03 -0800 (PST)
Received: (qmail 17623 invoked by uid 109); 7 Dec 2022 06:02:03 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 07 Dec 2022 06:02:03 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 30561 invoked by uid 111); 7 Dec 2022 06:02:04 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 07 Dec 2022 01:02:04 -0500
Authentication-Results: peff.net; auth=none
Date:   Wed, 7 Dec 2022 01:02:02 -0500
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Taylor Blau <me@ttaylorr.com>,
        =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-compat-util.h: introduce CALLOC(x)
Message-ID: <Y5AsWvLSwy7EgiHT@coredump.intra.peff.net>
References: <6694c52b38674859eb0390c7f62da1209a8d8ec3.1670266373.git.me@ttaylorr.com>
 <a8e33b1e-1056-5f75-55b5-65c0bceef3ca@web.de>
 <Y45yaYV3xFB/xR2G@nand.local>
 <221206.868rjle7za.gmgdl@evledraar.gmail.com>
 <Y46fHhD3xionHgPE@coredump.intra.peff.net>
 <221206.86v8mpcmnt.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <221206.86v8mpcmnt.gmgdl@evledraar.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Dec 06, 2022 at 02:58:53AM +0100, Ævar Arnfjörð Bjarmason wrote:

> This is probably too ugly to exist, but if we are going to have more
> variants maybe one that would allow use within declarations would be
> better, e.g.:
> 
> 	
> 	diff --git a/attr.c b/attr.c
> 	index 42ad6de8c7c..43ade426e57 100644
> 	--- a/attr.c
> 	+++ b/attr.c
> 	@@ -666,11 +666,10 @@ static void handle_attr_line(struct attr_stack *res,
> 	 
> 	 static struct attr_stack *read_attr_from_array(const char **list)
> 	 {
> 	-	struct attr_stack *res;
> 	+	struct attr_stack *INIT_CALLOC_ARRAY(res, 1);

Yeah. While clever, I would agree that is probably too ugly to exist.

-Peff
