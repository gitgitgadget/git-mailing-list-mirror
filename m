Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1965FC433F5
	for <git@archiver.kernel.org>; Mon, 18 Oct 2021 17:14:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E766B61263
	for <git@archiver.kernel.org>; Mon, 18 Oct 2021 17:14:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233535AbhJRRNv (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 18 Oct 2021 13:13:51 -0400
Received: from cloud.peff.net ([104.130.231.41]:41008 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232556AbhJRRNu (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Oct 2021 13:13:50 -0400
Received: (qmail 2850 invoked by uid 109); 18 Oct 2021 17:11:38 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 18 Oct 2021 17:11:38 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 32460 invoked by uid 111); 18 Oct 2021 17:11:38 -0000
Received: from Unknown (HELO sigill.intra.peff.net) (10.0.1.3)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 18 Oct 2021 13:11:38 -0400
Authentication-Results: peff.net; auth=none
Date:   Mon, 18 Oct 2021 13:11:37 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     Fabian Stelzer <fs@gigacodes.de>
Subject: [PATCH 0/2] some leak fixes on fs/ssh-signing-fix
Message-ID: <YW2qpuosxr9PNwVa@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This fixes two small leaks on top of fs/ssh-signing-fix noticed by
Coverity. I guess it's too late to squash them in, so I prepared patches
on top.

  [1/2]: gpg-interface: fix leak of "line" in parse_ssh_output()
  [2/2]: gpg-interface: fix leak of strbufs in get_ssh_key_fingerprint()

 gpg-interface.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

-Peff
