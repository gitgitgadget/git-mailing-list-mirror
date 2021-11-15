Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FBFFC28CFB
	for <git@archiver.kernel.org>; Mon, 15 Nov 2021 20:32:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1125363270
	for <git@archiver.kernel.org>; Mon, 15 Nov 2021 20:32:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349635AbhKOUfC (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 15 Nov 2021 15:35:02 -0500
Received: from cloud.peff.net ([104.130.231.41]:59284 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1345089AbhKOT0S (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 Nov 2021 14:26:18 -0500
Received: (qmail 13843 invoked by uid 109); 15 Nov 2021 19:23:19 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 15 Nov 2021 19:23:19 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 16927 invoked by uid 111); 15 Nov 2021 19:23:19 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 15 Nov 2021 14:23:19 -0500
Authentication-Results: peff.net; auth=none
Date:   Mon, 15 Nov 2021 14:23:18 -0500
From:   Jeff King <peff@peff.net>
To:     Teng Long <dyroneteng@gmail.com>
Cc:     git@vger.kernel.org, gitster@pobox.com
Subject: Re: [PATCH 0/3] support `--oid-only` in `ls-tree`
Message-ID: <YZKzpv+n6bHJ2WOs@coredump.intra.peff.net>
References: <20211115115153.48307-1-dyroneteng@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20211115115153.48307-1-dyroneteng@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Nov 15, 2021 at 07:51:50PM +0800, Teng Long wrote:

> Sometimes, we only want to get the objects from output of `ls-tree`
> and commands like `sed` or `cut` is usually used to intercept the
> origin output to achieve this purpose in practical.
> 
> The patch contains three commits
> 
>     1. Implementation of the option.
>     2. Add new tests in "t3104".
>     3. Documentation modifications.
> 
> I'm appreciate if someone help to review the patch.

This seems like a good feature to have. I think it would make sense to
squash the three patches into a single one. The documentation and test
patches do not stand on their own, which is why there was nothing useful
to say in their commit messages.

The implementation looks generally sensible (modulo the comments already
given). I was surprised that there was not an existing ls-tree script
that these would fit into. But there really isn't; t3101 covers
--name-only and other output, but is really focused on the pathnames
(though I think it would be OK to refactor it to cover output more
generally).

-Peff
