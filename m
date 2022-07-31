Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3500BC19F28
	for <git@archiver.kernel.org>; Sun, 31 Jul 2022 00:29:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231950AbiGaA30 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 30 Jul 2022 20:29:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229737AbiGaA3Z (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 30 Jul 2022 20:29:25 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FF60C5B
        for <git@vger.kernel.org>; Sat, 30 Jul 2022 17:29:23 -0700 (PDT)
Received: (qmail 28103 invoked by uid 109); 31 Jul 2022 00:29:23 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sun, 31 Jul 2022 00:29:23 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 7916 invoked by uid 111); 31 Jul 2022 00:29:23 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sat, 30 Jul 2022 20:29:23 -0400
Authentication-Results: peff.net; auth=none
Date:   Sat, 30 Jul 2022 20:29:22 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: What's cooking in git.git (Jul 2022, #08; Fri, 29)
Message-ID: <YuXM4pmsuDzIqbQT@coredump.intra.peff.net>
References: <xmqq7d3v33to.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq7d3v33to.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jul 29, 2022 at 04:18:59PM -0700, Junio C Hamano wrote:

> * jk/struct-zero-init-with-older-gcc (2022-07-29) 1 commit
>  - config.mak.dev: squelch -Wno-missing-braces for older gcc
> 
>  Older gcc with -Wall complains about the universal zero initializer
>  "struct s = { 0 };" idiom, which makes developers' lives
>  inconvenient (as -Werror is enabled by DEVELOPER=YesPlease).  The
>  build procedure has been tweaked to help them with thes compilers.
> 
>  Will merge to 'next'.
>  source: <YuQ60ZUPBHAVETD7@coredump.intra.peff.net>

If you get a chance before merging, can you please squash in this
typo-fix?

diff --git a/config.mak.dev b/config.mak.dev
index b9878a4994..4fa19d361b 100644
--- a/config.mak.dev
+++ b/config.mak.dev
@@ -60,7 +60,7 @@ endif
 # uninitialized warnings on gcc 4.9.2 in xdiff/xdiffi.c and config.c
 # not worth fixing since newer compilers correctly stop complaining
 #
-# Likwise, gcc older than 4.9 complains about initializing a
+# Likewise, gcc older than 4.9 complains about initializing a
 # struct-within-a-struct using just "{ 0 }"
 ifneq ($(filter gcc4,$(COMPILER_FEATURES)),)
 ifeq ($(filter gcc5,$(COMPILER_FEATURES)),)

Thanks.

-Peff
