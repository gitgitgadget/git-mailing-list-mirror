Return-Path: <SRS0=IlH6=24=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FEC9C33C8C
	for <git@archiver.kernel.org>; Tue,  7 Jan 2020 18:04:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 160C521744
	for <git@archiver.kernel.org>; Tue,  7 Jan 2020 18:04:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728476AbgAGSER (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Jan 2020 13:04:17 -0500
Received: from cloud.peff.net ([104.130.231.41]:59478 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1728365AbgAGSER (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Jan 2020 13:04:17 -0500
Received: (qmail 14636 invoked by uid 109); 7 Jan 2020 18:04:16 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 07 Jan 2020 18:04:16 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 3754 invoked by uid 111); 7 Jan 2020 18:09:51 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 07 Jan 2020 13:09:51 -0500
Authentication-Results: peff.net; auth=none
Date:   Tue, 7 Jan 2020 13:04:15 -0500
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     James Coglan <jcoglan@gmail.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, brad@brad-smith.co.uk,
        sunshine@sunshineco.com, Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH 3/3] t4215: add bigger graph collapse test
Message-ID: <20200107180415.GB48806@coredump.intra.peff.net>
References: <pull.517.git.1578408947.gitgitgadget@gmail.com>
 <f74e82bea68701beb734537cafd147162d1bb2c6.1578408947.git.gitgitgadget@gmail.com>
 <20200107153922.GC20591@coredump.intra.peff.net>
 <xmqqftgr5elz.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqftgr5elz.fsf@gitster-ct.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jan 07, 2020 at 10:02:48AM -0800, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > On Tue, Jan 07, 2020 at 02:55:47PM +0000, Derrick Stolee via GitGitGadget wrote:
> >
> >> From: Derrick Stolee <dstolee@microsoft.com>
> >> 
> >> A previous test in t4215-log-skewed-merges.sh was added to demonstrate
> >> exactly the topology of a reported failure in "git log --graph". While
> >> investigating the fix, we realized that multiple edges that could
> >> collapse with horizontal lines were not doing so.
> >
> > Thanks for constructing this larger case.
> >
> > As for including this patch, I could take or leave it for now. I like
> > the idea of documenting things further, but unless it's marked
> > expect_failure, I don't think it's going to call anybody's attention
> > more than this thread already has.
> >
> > So I'd love to hear what James thinks should happen here, given that
> > it's an extension of his other work. But I'd just as soon punt on the
> > patch until we decide whether it _should_ change (and then either mark
> > it with expect_failure, or include the test along with a patch changing
> > the behavior).
> 
> ... and nobody CC'ed the person from whom they want to hear opinion?

Doh, thank you. :) I cc'd him in the earlier thread, but GGG creates a
new one.

-Peff
