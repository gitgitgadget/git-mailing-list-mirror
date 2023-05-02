Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86A87C77B7E
	for <git@archiver.kernel.org>; Tue,  2 May 2023 10:19:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233772AbjEBKTX (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 2 May 2023 06:19:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233797AbjEBKTA (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 May 2023 06:19:00 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D60A5270
        for <git@vger.kernel.org>; Tue,  2 May 2023 03:18:57 -0700 (PDT)
Received: (qmail 24894 invoked by uid 109); 2 May 2023 10:18:57 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 02 May 2023 10:18:57 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 9281 invoked by uid 111); 2 May 2023 10:18:55 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 02 May 2023 06:18:55 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 2 May 2023 06:18:54 -0400
From:   Jeff King <peff@peff.net>
To:     Felipe Contreras <felipe.contreras@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [PATCH 1/2] doc: git-checkout: trivial callout cleanup
Message-ID: <20230502101854.GA1180695@coredump.intra.peff.net>
References: <20230418070048.2209469-1-felipe.contreras@gmail.com>
 <20230418070048.2209469-2-felipe.contreras@gmail.com>
 <xmqq8ren8xz1.fsf@gitster.g>
 <644684018a766_aba29424@chronos.notmuch>
 <xmqq8reg96cu.fsf@gitster.g>
 <20230425061029.GA4015844@coredump.intra.peff.net>
 <644af29c8526c_7f4f2945f@chronos.notmuch>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <644af29c8526c_7f4f2945f@chronos.notmuch>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Apr 27, 2023 at 04:09:32PM -0600, Felipe Contreras wrote:

> > Using just a blank line between the code block and the call-out list
> > (instead of the "+") works for asciidoc (it is happy to keep the two
> > together) but not asciidoctor (it ends the outer ordered list before
> > starting the callout list).
> 
> I don't know what you mean.

For reference, I meant this:

diff --git a/Documentation/git-checkout.txt b/Documentation/git-checkout.txt
index 6bb32ab460..ed32497290 100644
--- a/Documentation/git-checkout.txt
+++ b/Documentation/git-checkout.txt
@@ -529,7 +529,7 @@ $ git checkout master~2 Makefile  <2>
 $ rm -f hello.c
 $ git checkout hello.c            <3>
 ------------
-+
+
 <1> switch branch
 <2> take a file out of another commit
 <3> restore `hello.c` from the index

which asciidoc renders the same, but asciidoctor is not.

Your patch is now in master removing the line entirely, though, so the
point is moot.

-Peff
