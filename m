Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_NONE autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by archive.lwn.net (Postfix) with ESMTP id B48A27D910
	for <lwn-git@archive.lwn.net>; Wed, 11 Mar 2020 16:36:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730232AbgCKQgo (ORCPT <rfc822;lwn-git@archive.lwn.net>);
        Wed, 11 Mar 2020 12:36:44 -0400
Received: from cloud.peff.net ([104.130.231.41]:36458 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1729675AbgCKQgo (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Mar 2020 12:36:44 -0400
Received: (qmail 2255 invoked by uid 109); 11 Mar 2020 16:36:44 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 11 Mar 2020 16:36:44 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 20442 invoked by uid 111); 11 Mar 2020 16:46:05 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 11 Mar 2020 12:46:05 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 11 Mar 2020 12:36:43 -0400
From:   Jeff King <peff@peff.net>
To:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Phillip Wood <phillip.wood123@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH v2 2/2] git-rebase.txt: highlight backend differences
 with commit rewording
Message-ID: <20200311163643.GD27893@coredump.intra.peff.net>
References: <pull.722.git.git.1583903621.gitgitgadget@gmail.com>
 <pull.722.v2.git.git.1583940623.gitgitgadget@gmail.com>
 <6d51cff41d9ee312a0d9ae3308546284ead1d4c6.1583940623.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <6d51cff41d9ee312a0d9ae3308546284ead1d4c6.1583940623.git.gitgitgadget@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://archive.lwn.net:8080/git/20200311163643.GD27893@coredump.intra.peff.net/>
List-Archive: <http://archive.lwn.net:8080/git/>
List-Post: <mailto:git@vger.kernel.org>

On Wed, Mar 11, 2020 at 03:30:23PM +0000, Elijah Newren via GitGitGadget wrote:

> From: Elijah Newren <newren@gmail.com>
> 
> As noted by Junio:
>     Back when "git am" was written, it was not considered a bug that the
>     "git am --resolved" option did not offer the user a chance to update
>     the log message to match the adjustment of the code the user made,
>     but honestly, I'd have to say that it is a bug in "git am" in that
>     over time it wasn't adjusted to the new world order where we
>     encourage users to describe what they did when the automation
>     hiccuped by opening an editor.  These days, even when automation
>     worked well (e.g. a clean auto-merge with "git merge"), we open an
>     editor.  The world has changed, and so should the expectations.
> 
> Junio also suggested providing a workaround such as allowing --no-edit
> together with git rebase --continue, but that should probably be done in
> a patch after the git-2.26.0 release.  For now, just document the known
> difference in the Behavioral Differences section.

Thanks. With the earlier bug fix and this documentation change, I'm OK
with keeping the merge-backend transition in v2.26.0. This change
_might_ cause problems in somebody's script, but that will be true
whether it comes in 2.26 or 2.27, and I think it's clear this is the end
state we want to get to eventually.

-Peff
