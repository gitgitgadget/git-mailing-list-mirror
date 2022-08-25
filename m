Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDFEEC3F6B0
	for <git@archiver.kernel.org>; Thu, 25 Aug 2022 10:46:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241312AbiHYKqG (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 25 Aug 2022 06:46:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241306AbiHYKps (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Aug 2022 06:45:48 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95356A2230
        for <git@vger.kernel.org>; Thu, 25 Aug 2022 03:45:35 -0700 (PDT)
Received: (qmail 14164 invoked by uid 109); 25 Aug 2022 10:45:34 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 25 Aug 2022 10:45:34 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 28201 invoked by uid 111); 25 Aug 2022 10:45:37 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 25 Aug 2022 06:45:37 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 25 Aug 2022 06:45:34 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
Subject: [PATCH 0/3] unused function parameters newly in next
Message-ID: <YwdSzrF3xaHvLsI+@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The sg/parse-options-subcommand topic was merged to 'next', and it
introduced a ton of -Wunused-parameter warnings. But I think in this
case it revealed some actual bugs, albeit minor.

Here are some fixes. I prepared them on top of that topic, which is
semantically necessary. But note that the topic is not itself at fault
for _introducing_ any bugs. It just revealed them. So I don't think
there's any need to pause its progress to master.

  [1/3]: pass subcommand "prefix" arguments to parse_options()
  [2/3]: maintenance: add parse-options boilerplate for subcommands
  [3/3]: remote: run "remote rm" argv through parse_options()

 builtin/commit-graph.c     |  4 ++--
 builtin/gc.c               | 43 +++++++++++++++++++++++++++++++++++++-
 builtin/multi-pack-index.c |  8 +++----
 builtin/remote.c           | 36 ++++++++++++++++++-------------
 builtin/sparse-checkout.c  |  8 +++----
 5 files changed, 73 insertions(+), 26 deletions(-)

-Peff
