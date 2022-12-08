Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFB4CC4332F
	for <git@archiver.kernel.org>; Thu,  8 Dec 2022 06:36:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229834AbiLHGgg (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 8 Dec 2022 01:36:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229695AbiLHGgf (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Dec 2022 01:36:35 -0500
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD9A19E45A
        for <git@vger.kernel.org>; Wed,  7 Dec 2022 22:36:34 -0800 (PST)
Received: (qmail 22751 invoked by uid 109); 8 Dec 2022 06:36:34 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 08 Dec 2022 06:36:34 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 9577 invoked by uid 111); 8 Dec 2022 06:36:35 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 08 Dec 2022 01:36:35 -0500
Authentication-Results: peff.net; auth=none
Date:   Thu, 8 Dec 2022 01:36:33 -0500
From:   Jeff King <peff@peff.net>
To:     Derrick Stolee <derrickstolee@github.com>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, gitster@pobox.com, me@ttaylorr.com,
        newren@gmail.com, avarab@gmail.com, mjcheetham@outlook.com,
        steadmon@google.com, chooglen@google.com, jonathantanmy@google.com,
        dyroneteng@gmail.com
Subject: Re: [PATCH v3 10/11] bundle-uri: download bundles from an advertised
 list
Message-ID: <Y5GF8ams0k03kiVU@coredump.intra.peff.net>
References: <pull.1400.v2.git.1668628302.gitgitgadget@gmail.com>
 <pull.1400.v3.git.1670262639.gitgitgadget@gmail.com>
 <69bf154bec63a22df8e5eac89f975625ce73c8ac.1670262639.git.gitgitgadget@gmail.com>
 <Y5CNo5kyByIHDVYh@coredump.intra.peff.net>
 <affbc458-d4f5-525f-d431-5ec1d489afc8@github.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <affbc458-d4f5-525f-d431-5ec1d489afc8@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Dec 07, 2022 at 10:27:06AM -0500, Derrick Stolee wrote:

> > The "uri" parameter in this function is unused. I'm not sure if that's
> > indicative of a bug or missing feature (e.g., could it be the base for a
> > relative url?), or if it's just a leftover from development.
> 
> Thanks for your careful eye. This 'uri' is indeed not needed. I think it
> was initially there for relative URIs, but the given 'list' is expected
> to have that value initialized. I'll make it clear in the doc comment.

That makes sense. I've queued a patch locally to remove it (since
locally I build with -Wunused-parameters), which will eventually make
its way to the list.

> > If the latter, I'm happy to add it to my list of cleanups.
> > 
> > There are a couple other unused parameters in this series, too, but they
> > are all in virtual functions and must be kept. I'll add them to my list
> > of annotations.
> 
> Your UNUSED annotations exist in my tree, so I'll try my best to update
> them in the next version.

Sounds good (and again, I've queued something locally, but if you beat
me to it, it's easy to drop mine).

Note that your series hit 'next' (which is how I noticed it), so there
usually would not be a "next version". Though we will rewind
post-release, so there may still be an opportunity (I didn't follow the
topic closely enough to know if you might want to re-roll for other
reasons).

-Peff
