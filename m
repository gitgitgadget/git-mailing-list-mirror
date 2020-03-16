Return-Path: <SRS0=/LSK=5B=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 489AFC0044D
	for <git@archiver.kernel.org>; Mon, 16 Mar 2020 19:28:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2618320753
	for <git@archiver.kernel.org>; Mon, 16 Mar 2020 19:28:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732439AbgCPT2y (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 16 Mar 2020 15:28:54 -0400
Received: from cloud.peff.net ([104.130.231.41]:41204 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1732366AbgCPT2y (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Mar 2020 15:28:54 -0400
Received: (qmail 23592 invoked by uid 109); 16 Mar 2020 19:28:54 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 16 Mar 2020 19:28:54 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 647 invoked by uid 111); 16 Mar 2020 19:38:26 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 16 Mar 2020 15:38:26 -0400
Authentication-Results: peff.net; auth=none
Date:   Mon, 16 Mar 2020 15:28:52 -0400
From:   Jeff King <peff@peff.net>
To:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH] oidset: remove unnecessary include
Message-ID: <20200316192852.GC1073710@coredump.intra.peff.net>
References: <pull.727.git.git.1584213347500.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <pull.727.git.git.1584213347500.gitgitgadget@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Mar 14, 2020 at 07:15:47PM +0000, Elijah Newren via GitGitGadget wrote:

> From: Elijah Newren <newren@gmail.com>
> 
> When commit 8b2f8cbcb1 ("oidset: use khash", 2018-10-04) moved from
> using oidmap to khash, it replaced the oidmap.h include with both one
> for hashmap.h and khash.h.  Since the hashmap.h header is unnecessary,
> and the point of the patch was to switch from hashmap (used by oidmap)
> to khash.h, remove the unneccessary include.

Good catch. I doubt this is causing problems, but it's obviously the
right thing to do. I ran "make hdr-check" to confirm that no _other_
headers were subtly relying on this include.

-Peff
