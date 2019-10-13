Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9859F1F4C0
	for <e@80x24.org>; Sun, 13 Oct 2019 07:22:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728322AbfJMHWr (ORCPT <rfc822;e@80x24.org>);
        Sun, 13 Oct 2019 03:22:47 -0400
Received: from cloud.peff.net ([104.130.231.41]:46892 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1728159AbfJMHWr (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 13 Oct 2019 03:22:47 -0400
Received: (qmail 5987 invoked by uid 109); 13 Oct 2019 07:22:47 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Sun, 13 Oct 2019 07:22:47 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 15919 invoked by uid 111); 13 Oct 2019 07:25:45 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sun, 13 Oct 2019 03:25:45 -0400
Authentication-Results: peff.net; auth=none
Date:   Sun, 13 Oct 2019 03:22:46 -0400
From:   Jeff King <peff@peff.net>
To:     Denton Liu <liu.denton@gmail.com>
Cc:     James Coglan via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        James Coglan <jcoglan@gmail.com>
Subject: Re: [PATCH 11/11] graph: fix coloring of octopus dashes
Message-ID: <20191013072245.GB30652@sigill.intra.peff.net>
References: <pull.383.git.gitgitgadget@gmail.com>
 <ea0df1d94aa6c42eb00d59b268a90a8724322452.1570724021.git.gitgitgadget@gmail.com>
 <20191010181624.GA97861@generichostname>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20191010181624.GA97861@generichostname>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Oct 10, 2019 at 11:16:24AM -0700, Denton Liu wrote:

> >  test_expect_success 'log --graph with normal octopus merge, no color' '
> 
> So, I decided to merge 'dl/octopus-graph-bug' with your branch and I
> couldn't be happier! I had to make a couple of minor tweaks to the
> existing test cases but most of them only involved flipping
> `test_expect_failure` to `test_expect_success`.

Thanks for doing that. I also checked the output on the git.git case
discussed in:

  https://public-inbox.org/git/20190926202326.GA16664@sigill.intra.peff.net/

and it looks great. Probably because it's the same as your test cases --
the "non-collapsing type" I called it there (or maybe it's all just the
out-of-order thing James brought up; I don't recall discussing that
before, but certainly his test case exhibits the same off-by-one
coloring weirdness without the code change).

-Peff
