Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4688EEE49A0
	for <git@archiver.kernel.org>; Mon, 21 Aug 2023 21:02:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231553AbjHUVCx (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Aug 2023 17:02:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229508AbjHUVCw (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Aug 2023 17:02:52 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87E6FBC
        for <git@vger.kernel.org>; Mon, 21 Aug 2023 14:02:51 -0700 (PDT)
Received: (qmail 17750 invoked by uid 109); 21 Aug 2023 21:02:51 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 21 Aug 2023 21:02:51 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 19525 invoked by uid 111); 21 Aug 2023 21:02:51 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 21 Aug 2023 17:02:51 -0400
Authentication-Results: peff.net; auth=none
Date:   Mon, 21 Aug 2023 17:02:50 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v3 0/5] fix interactions with "-w" and "--exit-code"
Message-ID: <20230821210250.GE1800481@coredump.intra.peff.net>
References: <20230817222949.3835424-1-gitster@pobox.com>
 <20230818235932.3253552-1-gitster@pobox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230818235932.3253552-1-gitster@pobox.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Aug 18, 2023 at 04:59:27PM -0700, Junio C Hamano wrote:

> Paul Watson reported that "diff --no-index --exit-code
> --ignore-all-space" does not work when used with "--shortstat".  It
> turns out that this is not limited to "--no-index" mode, and it is
> not limited to "--shortstat".  Anything that does not use the "--patch"
> machinery to discover the content level differences ignored --exit-code
> when used with options like "-w" and always exited with 0.  In fact,
> even the "--patch" machinery was slightly faulty in corner cases.
> 
> And here is another round to fix it.
> Previous one is at https://lore.kernel.org/git/20230817222949.3835424-1-gitster@pobox.com/

This looks good to me. I left some musings, but I don't think there is
anything that merits a re-roll (you might want to fix-up a commit
message typo locally).

Thanks for running with it. It's much nicer than v1. :)

-Peff
