Return-Path: <SRS0=DRt7=BH=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7ACF6C433E1
	for <git@archiver.kernel.org>; Tue, 28 Jul 2020 16:47:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5BE0B207F5
	for <git@archiver.kernel.org>; Tue, 28 Jul 2020 16:47:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731568AbgG1Qr2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Jul 2020 12:47:28 -0400
Received: from cloud.peff.net ([104.130.231.41]:39958 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731367AbgG1Qr2 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Jul 2020 12:47:28 -0400
Received: (qmail 27816 invoked by uid 109); 28 Jul 2020 16:47:28 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 28 Jul 2020 16:47:28 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 26708 invoked by uid 111); 28 Jul 2020 16:47:27 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 28 Jul 2020 12:47:27 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 28 Jul 2020 12:47:27 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: Re: [PATCH 0/3] making --first-parent imply -m
Message-ID: <20200728164727.GA2650574@coredump.intra.peff.net>
References: <20200728163617.GA2649887@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200728163617.GA2649887@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jul 28, 2020 at 12:36:18PM -0400, Jeff King wrote:

> For some projects, it's useful to walk the first parent history, looking
> at each merge commit as a normal commit introducing all of the changes
> no its side branch. E.g.:
> 
>   git log --first-parent -m -Sfoo -p

One thing I should have mentioned, since the subject may be misleading:
this is only for git-log, not for plumbing like rev-list (which anyway
would need the option in diff-tree). The commits themselves are clear
that this is the case, but the cover letter was not. :)

-Peff
