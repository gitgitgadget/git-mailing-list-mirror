Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5085BC83F01
	for <git@archiver.kernel.org>; Thu, 31 Aug 2023 00:13:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345163AbjHaANv (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 30 Aug 2023 20:13:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345573AbjHaANu (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Aug 2023 20:13:50 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D8A3CE0
        for <git@vger.kernel.org>; Wed, 30 Aug 2023 17:13:31 -0700 (PDT)
Received: (qmail 20205 invoked by uid 109); 31 Aug 2023 00:13:30 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 31 Aug 2023 00:13:30 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 32144 invoked by uid 111); 31 Aug 2023 00:13:27 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 30 Aug 2023 20:13:27 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 30 Aug 2023 20:13:25 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Wesley <wesleys@opperschaap.net>, git@vger.kernel.org
Subject: Re: [PATCH] git-svn: drop FakeTerm hack
Message-ID: <20230831001325.GA2685726@coredump.intra.peff.net>
References: <20230810004956.GA816605@coredump.intra.peff.net>
 <20230810011831.1423208-1-wesleys@opperschaap.net>
 <xmqqcyzupf3b.fsf@gitster.g>
 <8d683835-31d4-41f0-9d4e-90c95acbea28@opperschaap.net>
 <xmqqwmy2no2e.fsf@gitster.g>
 <20230811145121.GB2303200@coredump.intra.peff.net>
 <xmqqjzu1o97n.fsf@gitster.g>
 <xmqqa5u888lz.fsf_-_@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqa5u888lz.fsf_-_@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Aug 30, 2023 at 03:32:08PM -0700, Junio C Hamano wrote:

> > True.  Let me drop the patch from the 'next down to master
> > fast-track' candidate status.
> 
> We did the above but then everybody seems to have forgotten about
> it.  Let's resurrect the topic.  Here is my attempt.
> 
> ---- >8 ----
> From: Wesley Schwengle <wesleys@opperschaap.net>
> Subject: [PATCH] git-svn: drop FakeTerm hack
> 
> Drop the FakeTerm hack, just like dfd46bae (send-email: drop
> FakeTerm hack, 2023-08-08) did, for exactly the same reason.

Yep, it looks good to me.

Optionally you could add this to the commit message:

  It has been obsolete in git-svn since 30d45f798d (git-svn: delay term
  initialization, 2014-09-14). Note that unlike send-email, we already
  make sure to load Term::ReadLine only once. So this is just a cleanup,
  and not fixing any bug.

-Peff
