Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73652ECAAD5
	for <git@archiver.kernel.org>; Tue, 30 Aug 2022 18:55:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229788AbiH3Sy7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 30 Aug 2022 14:54:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229565AbiH3Sy5 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Aug 2022 14:54:57 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AB5DF5AE
        for <git@vger.kernel.org>; Tue, 30 Aug 2022 11:54:53 -0700 (PDT)
Received: (qmail 7385 invoked by uid 109); 30 Aug 2022 18:54:52 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 30 Aug 2022 18:54:52 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 27748 invoked by uid 111); 30 Aug 2022 18:54:53 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 30 Aug 2022 14:54:53 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 30 Aug 2022 14:54:51 -0400
From:   Jeff King <peff@peff.net>
To:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 2/3] t3701: test the built-in `add -i` regardless of
 NO_PERL
Message-ID: <Yw5c+8kaTRtJ52fk@coredump.intra.peff.net>
References: <pull.1340.git.1661867664.gitgitgadget@gmail.com>
 <54d25d991b09219f6992dc3e8c102ce1ccef6313.1661867664.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <54d25d991b09219f6992dc3e8c102ce1ccef6313.1661867664.git.gitgitgadget@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Aug 30, 2022 at 01:54:23PM +0000, Johannes Schindelin via GitGitGadget wrote:

> From: Johannes Schindelin <johannes.schindelin@gmx.de>
> 
> The built-in `git add --interactive` does not require Perl, therefore we
> can safely run these tests even when building with `NO_PERL=LetsDoThat`.

Make sense. The patch is small enough that it is certainly worth doing
in the meantime, but is it time to start thinking about dropping the
perl implementation (and hence this prereq) entirely?

-Peff
