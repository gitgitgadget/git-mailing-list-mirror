Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0C3531F4B5
	for <e@80x24.org>; Wed, 13 Nov 2019 05:31:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726160AbfKMFbx (ORCPT <rfc822;e@80x24.org>);
        Wed, 13 Nov 2019 00:31:53 -0500
Received: from cloud.peff.net ([104.130.231.41]:46226 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1725976AbfKMFbw (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Nov 2019 00:31:52 -0500
Received: (qmail 12808 invoked by uid 109); 13 Nov 2019 05:31:53 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 13 Nov 2019 05:31:53 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 22709 invoked by uid 111); 13 Nov 2019 05:35:24 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 13 Nov 2019 00:35:24 -0500
Authentication-Results: peff.net; auth=none
Date:   Wed, 13 Nov 2019 00:31:51 -0500
From:   Jeff King <peff@peff.net>
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, bturner@atlassian.com,
        Derrick Stolee <dstolee@microsoft.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/1] test-tool: use 'read-graph' helper
Message-ID: <20191113053151.GC3547@sigill.intra.peff.net>
References: <pull.460.git.1573577900.gitgitgadget@gmail.com>
 <bdbc7b71884cba192c67c2bc26db5b9b3a040043.1573577900.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <bdbc7b71884cba192c67c2bc26db5b9b3a040043.1573577900.git.gitgitgadget@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Nov 12, 2019 at 04:58:20PM +0000, Derrick Stolee via GitGitGadget wrote:

> From: Derrick Stolee <dstolee@microsoft.com>
> 
> The 'git commit-graph read' subcommand is used in test scripts to check
> that the commit-graph contents match the expected data. Mostly, this
> helps check the header information and the list of chunks. Users do not
> need this information, so move the functionality to a test helper.

This looks good to me.

>  t/helper/test-read-graph.c         | 53 +++++++++++++++++++++++

I wondered if we might want a commit-graph test-tool with sub-commands.
But it probably doesn't matter. This would be the only thing in it. And
there's less need these days to keep the number of tools down, since
they're all linked into the same binary. And we can always change it
later, since it's not a public interface.

So this is the simplest thing, which is probably best for now.

-Peff
