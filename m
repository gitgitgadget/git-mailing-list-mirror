Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 273071F453
	for <e@80x24.org>; Mon, 24 Sep 2018 21:09:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728447AbeIYDNm (ORCPT <rfc822;e@80x24.org>);
        Mon, 24 Sep 2018 23:13:42 -0400
Received: from cloud.peff.net ([104.130.231.41]:57862 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1728388AbeIYDNm (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Sep 2018 23:13:42 -0400
Received: (qmail 11616 invoked by uid 109); 24 Sep 2018 21:09:35 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 24 Sep 2018 21:09:35 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 30811 invoked by uid 111); 24 Sep 2018 21:09:18 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Mon, 24 Sep 2018 17:09:18 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 24 Sep 2018 17:09:33 -0400
Date:   Mon, 24 Sep 2018 17:09:33 -0400
From:   Jeff King <peff@peff.net>
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH v4 1/1] commit-reach: properly peel tags and clear flags
Message-ID: <20180924210933.GC6255@sigill.intra.peff.net>
References: <pull.39.v3.git.gitgitgadget@gmail.com>
 <pull.39.v4.git.gitgitgadget@gmail.com>
 <a0a3cf01343381281554d0e175b2f4ec5fbe0abb.1537822669.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <a0a3cf01343381281554d0e175b2f4ec5fbe0abb.1537822669.git.gitgitgadget@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Sep 24, 2018 at 01:57:52PM -0700, Derrick Stolee via GitGitGadget wrote:

> From: Derrick Stolee <dstolee@microsoft.com>
> 
> The can_all_from_reach_with_flag() algorithm was refactored in 4fbcca4e
> "commit-reach: make can_all_from_reach... linear" but incorrectly
> assumed that all objects provided were commits. During a fetch
> negotiation, ok_to_give_up() in upload-pack.c may provide unpeeled tags
> to the 'from' array. The current code creates a segfault.
> [...]

Thanks, this version looks good to me.

-Peff
