Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A8DDC00144
	for <git@archiver.kernel.org>; Fri, 29 Jul 2022 20:33:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238897AbiG2UdA (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 29 Jul 2022 16:33:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238670AbiG2Uc4 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 Jul 2022 16:32:56 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89E6E8B49C
        for <git@vger.kernel.org>; Fri, 29 Jul 2022 13:32:55 -0700 (PDT)
Received: (qmail 22425 invoked by uid 109); 29 Jul 2022 20:32:54 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 29 Jul 2022 20:32:54 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 28959 invoked by uid 111); 29 Jul 2022 20:32:54 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 29 Jul 2022 16:32:54 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 29 Jul 2022 16:32:53 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, me@ttaylorr.com, vdye@github.com,
        steadmon@google.com, Derrick Stolee <derrickstolee@github.com>
Subject: Re: [PATCH 2/3] log: add default decoration filter
Message-ID: <YuRD9Uu/yAGg6roj@coredump.intra.peff.net>
References: <pull.1301.git.1658844250.gitgitgadget@gmail.com>
 <6b40b84773c70244bb13204ec566b713f1bdf865.1658844250.git.gitgitgadget@gmail.com>
 <xmqqczdqtxro.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqczdqtxro.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jul 27, 2022 at 07:50:51AM -0700, Junio C Hamano wrote:

> > * Notes (refs/notes/)
> 
> Questionable.  None of the notes commits are on the primary history,
> so it is unlikely to be even used for decoration, so it would not
> hurt to have them as part of possible decoration sources, but on the
> other hand, the value of using them is dubious.
> 
> > * Stashes (refs/stash/)
> 
> Questionable, for the same reason as 'notes'.

Even more so, IMHO, because we are not even decorating all of the
stashes. Because the stash is kept in a reflog, it is really just
decorating stash@{0}.

As you said elsewhere, I'm OK with keeping it in the name of "it's
probably not hurting", but I'd be really surprised if it has ever helped
anyone.

-Peff
