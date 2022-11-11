Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A4DCC43217
	for <git@archiver.kernel.org>; Fri, 11 Nov 2022 15:20:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233981AbiKKPUQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 11 Nov 2022 10:20:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233478AbiKKPTp (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Nov 2022 10:19:45 -0500
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AF7D833B3
        for <git@vger.kernel.org>; Fri, 11 Nov 2022 07:19:31 -0800 (PST)
Received: (qmail 372 invoked by uid 109); 11 Nov 2022 15:19:31 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 11 Nov 2022 15:19:31 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 5938 invoked by uid 111); 11 Nov 2022 15:19:30 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 11 Nov 2022 10:19:30 -0500
Authentication-Results: peff.net; auth=none
Date:   Fri, 11 Nov 2022 10:19:30 -0500
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Glen Choo <chooglen@google.com>, Taylor Blau <me@ttaylorr.com>,
        Glen Choo via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH] t: run t5551 tests with both HTTP and HTTP/2
Message-ID: <Y25oAj+OdC4s+jJM@coredump.intra.peff.net>
References: <pull.1377.git.git.1667955151994.gitgitgadget@gmail.com>
 <Y2xnUyEoCFmbPtUI@nand.local>
 <kl6lpmdu3dl5.fsf@chooglen-macbookpro.roam.corp.google.com>
 <Y21yPIDmwB53e+aj@coredump.intra.peff.net>
 <kl6lk0422zgd.fsf@chooglen-macbookpro.roam.corp.google.com>
 <Y22ze1m6ayQCv9B5@coredump.intra.peff.net>
 <Y25hDr7aHvKnxso3@coredump.intra.peff.net>
 <221111.86wn81mssk.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <221111.86wn81mssk.gmgdl@evledraar.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Nov 11, 2022 at 04:06:20PM +0100, Ævar Arnfjörð Bjarmason wrote:

> > In theory other http-related test scripts could benefit from the same
> > duplication, but doing t5551 should give us a reasonable check of basic
> > functionality, and would have caught both bugs we've seen in the wild
> > with HTTP/2.
> 
> Looking at the diff below, would it be much more work to just support a
> GIT_TEST_HTTP_VERSION=2?

No, but 99% of the tests would not benefit (because they don't run http
at all), and it would consume a bunch of extra CPU.

> There's the "!HTTP2" additions, which you mention you'll be "fixing
> momentarily", but this is a stand-alone patch, so maybe I'm missing that
> context...

The other context is Glen's patch that started this thread.

-Peff
