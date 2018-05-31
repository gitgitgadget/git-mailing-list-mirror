Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6AF331F42D
	for <e@80x24.org>; Thu, 31 May 2018 05:54:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753828AbeEaFyy (ORCPT <rfc822;e@80x24.org>);
        Thu, 31 May 2018 01:54:54 -0400
Received: from cloud.peff.net ([104.130.231.41]:57458 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1752048AbeEaFyx (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 31 May 2018 01:54:53 -0400
Received: (qmail 13072 invoked by uid 109); 31 May 2018 05:54:54 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 31 May 2018 05:54:54 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 9471 invoked by uid 111); 31 May 2018 05:55:04 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Thu, 31 May 2018 01:55:04 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 31 May 2018 01:54:51 -0400
Date:   Thu, 31 May 2018 01:54:51 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] fsckObjects tests: show how v2.17.1 can exploit
 downstream
Message-ID: <20180531055451.GD17344@sigill.intra.peff.net>
References: <20180529211950.26896-1-avarab@gmail.com>
 <20180529212458.GC7964@sigill.intra.peff.net>
 <87a7sif7is.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87a7sif7is.fsf@evledraar.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, May 29, 2018 at 11:59:07PM +0200, Ævar Arnfjörð Bjarmason wrote:

> > I'm not sure what testing this buys us. [...]
> 
> Half of what I'm trying to do here is clarifying the v2.17.1 release
> notes. The initial version Junio had & my proposed amendment on
> git-security was:

I think that's a fine goal, but I doubt that adding a test is going to
help much. That's why I say this seems like it should be a documentation
patch and not a test one. People are much less likely to crawl through
our tests than they are to crawl through the documentation.

> The other half, which is why I think this patch is needed, is making
> this aspect of it clearer to future maintainers. Before I started
> hacking on my recent fsck series[1] I didn't realize the intricacies of
> how *.fsckObjects worked in various situations, and I think explicitly
> calling this case out in code helps.

I agree we should be testing that, but I don't think it should be tied
into this test that is specific to one particular fsck check. Don't we
already check the behavior of the various fsckObjects options elsewhere,
like in t5504?

-Peff
