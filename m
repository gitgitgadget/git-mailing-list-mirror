Return-Path: <SRS0=v+yc=5F=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12A60C4332B
	for <git@archiver.kernel.org>; Fri, 20 Mar 2020 23:35:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DEEED20752
	for <git@archiver.kernel.org>; Fri, 20 Mar 2020 23:35:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727590AbgCTXfi (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 20 Mar 2020 19:35:38 -0400
Received: from mx.sdf.org ([205.166.94.20]:61523 "EHLO mx.sdf.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726738AbgCTXfi (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Mar 2020 19:35:38 -0400
Received: from sdf.org (IDENT:lkml@sdf.lonestar.org [205.166.94.16])
        by mx.sdf.org (8.15.2/8.14.5) with ESMTPS id 02KNZSi2014152
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits) verified NO);
        Fri, 20 Mar 2020 23:35:29 GMT
Received: (from lkml@localhost)
        by sdf.org (8.15.2/8.12.8/Submit) id 02KNZSvF025632;
        Fri, 20 Mar 2020 23:35:28 GMT
Date:   Fri, 20 Mar 2020 23:35:28 +0000
From:   George Spelvin <lkml@SDF.ORG>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>, lkml@sdf.org
Subject: Re: Feature request: rebase -i inside of rebase -i
Message-ID: <20200320233528.GB19579@SDF.ORG>
References: <20200320223015.GA19579@SDF.ORG>
 <xmqq36a2bpxz.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqq36a2bpxz.fsf@gitster.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Mar 20, 2020 at 03:51:20PM -0700, Junio C Hamano wrote:
> I thought that "git rebase -i" allows the todo file (i.e. list of
> steps still to be performed) to be edited before continuing; would
> your use case be supported by using that?

Mostly, if I do it very carefully, which is why I thought it would
be easy to add.

I think I could manually add the commits to the start of the todo file,
reset --hard to the old state, and rebase --continue.

But cutting and pasting commit IDs from git log into the todo file,
and putting fixup commits in the right place is annoyingly fiddly.
That's exactly the sort of thing computers are good at.
