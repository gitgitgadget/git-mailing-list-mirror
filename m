Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB519C4332F
	for <git@archiver.kernel.org>; Mon, 21 Nov 2022 23:32:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231561AbiKUXcP (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Nov 2022 18:32:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230063AbiKUXcN (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Nov 2022 18:32:13 -0500
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AC23D9065
        for <git@vger.kernel.org>; Mon, 21 Nov 2022 15:32:12 -0800 (PST)
Received: (qmail 13236 invoked by uid 109); 21 Nov 2022 23:32:12 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 21 Nov 2022 23:32:12 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 29055 invoked by uid 111); 21 Nov 2022 23:32:12 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 21 Nov 2022 18:32:12 -0500
Authentication-Results: peff.net; auth=none
Date:   Mon, 21 Nov 2022 18:32:11 -0500
From:   Jeff King <peff@peff.net>
To:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v2] config: introduce an Operating System-specific
 `includeIf` condition
Message-ID: <Y3wKe7aO7I7bpmLm@coredump.intra.peff.net>
References: <pull.1429.git.1669037992587.gitgitgadget@gmail.com>
 <pull.1429.v2.git.1669058388327.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <pull.1429.v2.git.1669058388327.gitgitgadget@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Nov 21, 2022 at 07:19:48PM +0000, Johannes Schindelin via GitGitGadget wrote:

> It is relatively common for users to maintain identical `~/.gitconfig`
> files across all of their setups, using the `includeIf` construct
> liberally to adjust the settings to the respective setup as needed.

This seems like a reasonable thing to have in general, but I wonder if
you have an example of how people use this. Mostly I am wondering:

  - is it sometimes a misuse, where users _think_ that the OS is
    correlated with some feature of Git.  And they would be better off
    with some flag like "does the current platform support fsmonitor".

  - for cases where it really  is "uname -s" the best differentiator? Or
    would they commonly want to lump FreeBSD and Linux into the same
    category, or to tell the difference between Debian versus Fedora?

-Peff
