Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6B42E1F97E
	for <e@80x24.org>; Thu, 11 Oct 2018 13:57:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728051AbeJKVYU (ORCPT <rfc822;e@80x24.org>);
        Thu, 11 Oct 2018 17:24:20 -0400
Received: from cloud.peff.net ([104.130.231.41]:37178 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726537AbeJKVYU (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 Oct 2018 17:24:20 -0400
Received: (qmail 19043 invoked by uid 109); 11 Oct 2018 13:57:01 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 11 Oct 2018 13:57:01 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 29753 invoked by uid 111); 11 Oct 2018 13:56:10 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Thu, 11 Oct 2018 09:56:10 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 11 Oct 2018 09:57:00 -0400
Date:   Thu, 11 Oct 2018 09:57:00 -0400
From:   Jeff King <peff@peff.net>
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH v3 2/7] test-reach: add run_three_modes method
Message-ID: <20181011135659.GB27312@sigill.intra.peff.net>
References: <pull.25.v2.git.gitgitgadget@gmail.com>
 <pull.25.v3.git.gitgitgadget@gmail.com>
 <b2a1ade148bc5ef175338ba116bd33b6b5e8d386.1537551564.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <b2a1ade148bc5ef175338ba116bd33b6b5e8d386.1537551564.git.gitgitgadget@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Sep 21, 2018 at 10:39:29AM -0700, Derrick Stolee via GitGitGadget wrote:

> From: Derrick Stolee <dstolee@microsoft.com>
> 
> The 'test_three_modes' method assumes we are using the 'test-tool
> reach' command for our test. However, we may want to use the data
> shape of our commit graph and the three modes (no commit-graph,
> full commit-graph, partial commit-graph) for other git commands.
> 
> Split test_three_modes to be a simple translation on a more general
> run_three_modes method that executes the given command and tests
> the actual output to the expected output.
>
> [...]
> +test_three_modes () {
> +	run_three_modes test-tool reach "$@"
> +}

Makes sense. Sometimes in the test suite we want to be able to pass a
whole shell snippet to eval, but unless we specifically need that for
this series, running "$@" directly is simpler.

-Peff
