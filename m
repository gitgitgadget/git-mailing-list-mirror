Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E37AC77B73
	for <git@archiver.kernel.org>; Mon, 22 May 2023 19:17:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234203AbjEVTRj (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 22 May 2023 15:17:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233857AbjEVTRh (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 May 2023 15:17:37 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3FDBFE
        for <git@vger.kernel.org>; Mon, 22 May 2023 12:17:31 -0700 (PDT)
Received: (qmail 32322 invoked by uid 109); 22 May 2023 19:17:31 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 22 May 2023 19:17:31 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 4188 invoked by uid 111); 22 May 2023 19:17:30 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 22 May 2023 15:17:30 -0400
Authentication-Results: peff.net; auth=none
Date:   Mon, 22 May 2023 15:17:30 -0400
From:   Jeff King <peff@peff.net>
To:     Patrick Steinhardt <ps@pks.im>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 3/9] fetch: pass through `fetch_config` directly
Message-ID: <20230522191730.GA365027@coredump.intra.peff.net>
References: <cover.1684324059.git.ps@pks.im>
 <b09f21dff786780dfb0ae71efd9a0cabe31c1e0b.1684324059.git.ps@pks.im>
 <20230519001803.GC2442034@coredump.intra.peff.net>
 <ZGsuy6T_yiK4qxxJ@ncase>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZGsuy6T_yiK4qxxJ@ncase>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, May 22, 2023 at 10:58:51AM +0200, Patrick Steinhardt wrote:

> > If the point is that fetch_config may start carrying new information,
> > wouldn't we want to pass it as a whole down to display_state_init()? It
> > might eventually want to see some of that other config, too.
> > 
> > It's presumably academic for now, and it would not be too hard to change
> > later if needed, so I don't know that it's worth a re-roll. I just found
> > it especially funny here since the purpose of the patch is to treat the
> > config struct as a single unit.
> 
> Well, I decided against passing in the full configuration as it feels a
> bit like a layering violation: the other code really is about the fetch
> itself, while this code here is only about display logic. So passing in
> the `fetch_config` felt weird to me, even more so because we continue to
> only need that single value at the end of this series. I do see your
> point though.
> 
> Given that none of your other comments require a reroll I'll leave this
> as-is for now. Thanks for your review!

Yeah, I could see that line of thinking, as well. Leaving sounds good to
me. And I think that was my only substantive comment on the whole
series, so we can consider the whole reviewed-by: me.

-Peff
