Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58F56CE7A8E
	for <git@archiver.kernel.org>; Sat, 23 Sep 2023 07:07:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230134AbjIWHHo (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 23 Sep 2023 03:07:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230097AbjIWHHm (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 23 Sep 2023 03:07:42 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E637E199
        for <git@vger.kernel.org>; Sat, 23 Sep 2023 00:07:36 -0700 (PDT)
Received: (qmail 9632 invoked by uid 109); 23 Sep 2023 07:07:36 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sat, 23 Sep 2023 07:07:36 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 24988 invoked by uid 111); 23 Sep 2023 07:07:38 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sat, 23 Sep 2023 03:07:38 -0400
Authentication-Results: peff.net; auth=none
Date:   Sat, 23 Sep 2023 03:07:35 -0400
From:   Jeff King <peff@peff.net>
To:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 6/6] coverity: detect and report when the token or
 project is incorrect
Message-ID: <20230923070735.GC1471672@coredump.intra.peff.net>
References: <pull.1588.git.1695379323.gitgitgadget@gmail.com>
 <458bc2ea91faf88a3e1d21945f12f314d1a7b78e.1695379323.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <458bc2ea91faf88a3e1d21945f12f314d1a7b78e.1695379323.git.gitgitgadget@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Sep 22, 2023 at 10:42:03AM +0000, Johannes Schindelin via GitGitGadget wrote:

> From: Johannes Schindelin <johannes.schindelin@gmx.de>
> 
> When trying to obtain the MD5 of the Coverity Scan Tool (in order to
> decide whether a cached version can be used or a new version has to be
> downloaded), it is possible to get a 401 (Authorization required) due to
> either an incorrect token, or even more likely due to an incorrect
> Coverity project name.
> 
> Let's detect that scenario and provide a helpful error message instead
> of trying to go forward with an empty string instead of the correct MD5.

Ah. :) I think using "curl --fail" is probably a simpler solution here.

-Peff
