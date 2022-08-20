Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82FD1C25B08
	for <git@archiver.kernel.org>; Sat, 20 Aug 2022 07:01:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343701AbiHTHBo (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 20 Aug 2022 03:01:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245060AbiHTHBn (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 20 Aug 2022 03:01:43 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9CE7C2F94
        for <git@vger.kernel.org>; Sat, 20 Aug 2022 00:01:42 -0700 (PDT)
Received: (qmail 21289 invoked by uid 109); 20 Aug 2022 07:01:41 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sat, 20 Aug 2022 07:01:41 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 9274 invoked by uid 111); 20 Aug 2022 07:01:43 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sat, 20 Aug 2022 03:01:43 -0400
Authentication-Results: peff.net; auth=none
Date:   Sat, 20 Aug 2022 03:01:41 -0400
From:   Jeff King <peff@peff.net>
To:     Derrick Stolee <derrickstolee@github.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 4/6] verify_one_sparse(): drop unused repository parameter
Message-ID: <YwCG1doiwSDOJuGK@coredump.intra.peff.net>
References: <Yv9Oay+tNqhLDqVl@coredump.intra.peff.net>
 <Yv9O+HDMLKglLcqY@coredump.intra.peff.net>
 <cbbfbbdd-94de-d981-804b-fe199ca49754@github.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cbbfbbdd-94de-d981-804b-fe199ca49754@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Aug 19, 2022 at 03:04:19PM -0400, Derrick Stolee wrote:

> On 8/19/2022 4:51 AM, Jeff King wrote:
> > This function has never used its repository parameter since it was
> > introduced in 9ad2d5ea71 (sparse-index: loose integration with
> > cache_tree_verify(), 2021-03-30). As that commit notes, it may
> > eventually be extended further, and that might require looking at a
> > repository struct. But it would be easy to add it back later if
> > necessary.
> 
> The good news is that 'struct index_state' now has a pointer to
> its repository, so we wouldn't need to add it back in.

Oh, right, that is even better. I think I have a few other patches in
the pile that similarly remove repository pointers. When I'm writing
them up, I'll check to see if they can use the same (much better)
reasoning.

-Peff
