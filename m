Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D7D2C7EE22
	for <git@archiver.kernel.org>; Thu, 11 May 2023 17:01:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238739AbjEKRBk (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 11 May 2023 13:01:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238731AbjEKRBi (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 May 2023 13:01:38 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1D8D30EE
        for <git@vger.kernel.org>; Thu, 11 May 2023 10:01:34 -0700 (PDT)
Received: (qmail 26973 invoked by uid 109); 11 May 2023 17:01:34 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 11 May 2023 17:01:34 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 11067 invoked by uid 111); 11 May 2023 17:01:33 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 11 May 2023 13:01:33 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 11 May 2023 13:01:33 -0400
From:   Jeff King <peff@peff.net>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH 3/3] fsck: mention file path for index errors
Message-ID: <20230511170133.GA1977634@coredump.intra.peff.net>
References: <Y/hv0MXAyBY3HEo9@coredump.intra.peff.net>
 <Y/hxW9i9GyKblNV4@coredump.intra.peff.net>
 <305ccc55-25e3-6b01-cd86-9a9035839d06@sunshineco.com>
 <20230511161757.GA1973344@coredump.intra.peff.net>
 <CAPig+cQP736+944k40wgE8Vybk=ajD-kLTDHM6Y92dKEeWMB8g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAPig+cQP736+944k40wgE8Vybk=ajD-kLTDHM6Y92dKEeWMB8g@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, May 11, 2023 at 12:28:45PM -0400, Eric Sunshine wrote:

> > So the code is working as intended, but I may have misused the term
> > "main" with respect to other worktree code. I didn't even know that was
> > a concept, not having dealt much with worktrees.
> >
> > Maybe it's worth s/main/current/ here (and I guess in t1450)?
> 
> Yes, s/main/current/ probably would be helpful for future readers of
> the code. It's unfortunate that the term "current" can ambiguously
> also be read as meaning "the up-to-date index" or "the present-time
> index" as opposed to "the index in this directory/worktree", which is
> the intention here. But "current" is consistent with the existing
> `struct worktree.is_current`, so hopefully should not be too
> confusing.

I think in this context it should be pretty clear. Do you want to
prepare a patch?

-Peff
