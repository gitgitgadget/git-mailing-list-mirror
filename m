Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B908EC77B73
	for <git@archiver.kernel.org>; Fri, 19 May 2023 00:13:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229715AbjESAN7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 18 May 2023 20:13:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229524AbjESAN5 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 May 2023 20:13:57 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AF6A10C2
        for <git@vger.kernel.org>; Thu, 18 May 2023 17:13:57 -0700 (PDT)
Received: (qmail 6188 invoked by uid 109); 19 May 2023 00:13:57 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 19 May 2023 00:13:57 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 26730 invoked by uid 111); 19 May 2023 00:13:56 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 18 May 2023 20:13:56 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 18 May 2023 20:13:55 -0400
From:   Jeff King <peff@peff.net>
To:     Patrick Steinhardt <ps@pks.im>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 2/9] fetch: drop unneeded NULL-check for `remote_ref`
Message-ID: <20230519001355.GB2442034@coredump.intra.peff.net>
References: <cover.1684324059.git.ps@pks.im>
 <7197540df60d34e8f727e29d300dd0c96e31d310.1684324059.git.ps@pks.im>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <7197540df60d34e8f727e29d300dd0c96e31d310.1684324059.git.ps@pks.im>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, May 17, 2023 at 01:48:46PM +0200, Patrick Steinhardt wrote:

> Drop the `NULL` check for `remote_ref` in `update_local_ref()`. The
> function only has a single caller, and that caller always passes in a
> non-`NULL` value.
> 
> This fixes a false positive in Coverity.

Thanks for following up on this. I was thinking of just reposting it,
thinking there weren't that many other cleanups to do in fetch.c. But
you found quite a few. :)

The patch looks obviously good to me.

-Peff
