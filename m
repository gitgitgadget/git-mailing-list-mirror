Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF3EBE7E63F
	for <git@archiver.kernel.org>; Tue, 26 Sep 2023 14:39:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234417AbjIZOjn (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 26 Sep 2023 10:39:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234854AbjIZOjl (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Sep 2023 10:39:41 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 313DAE6
        for <git@vger.kernel.org>; Tue, 26 Sep 2023 07:39:35 -0700 (PDT)
Received: (qmail 19224 invoked by uid 109); 26 Sep 2023 14:39:34 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 26 Sep 2023 14:39:34 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 25684 invoked by uid 111); 26 Sep 2023 14:39:34 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 26 Sep 2023 10:39:34 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 26 Sep 2023 10:39:33 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH 3/6] coverity: allow overriding the Coverity project
Message-ID: <20230926143933.GA1897653@coredump.intra.peff.net>
References: <pull.1588.git.1695379323.gitgitgadget@gmail.com>
 <6c1c82862814f40a408231cb249fb4b653276b52.1695379323.git.gitgitgadget@gmail.com>
 <20230923070019.GD1469941@coredump.intra.peff.net>
 <a839daf1-9e32-96f8-4eab-7c845e128488@gmx.de>
 <20230925121157.GB1623701@coredump.intra.peff.net>
 <4e0f404e-0c49-b085-c35d-be53b0381402@gmx.de>
 <xmqq4jjhow3h.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq4jjhow3h.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Sep 26, 2023 at 07:19:46AM -0700, Junio C Hamano wrote:

> At the same time, it would be one less thing they need to tweak
> before starting to use it, and if there are two or more users to do
> so, it would already have paid off.  Developers typically outnumber
> projects they work on.
> 
> I also have to wonder if it might make it more obvious what is going
> on if you made the default to $user/$fork and have the project
> override it, which hopefully may make it easier to find out what
> they need to do for those who want to override it to a different
> value to suit their need?

Yeah, that was my thinking (and what I had been proposing).

But I really think it probably doesn't matter that much either way. I
would not be surprised if there are zero developers who use this,
because of the setup on the coverity side, and the fact that the results
are not always immediately actionable.

Even I, who has been running coverity on my local fork for a few years,
will probably just switch to using the git.git run and occasionally
looking at the results (that creates an extra headache because somebody
has to grant acess to the git.git run results to interested parties, but
it's also a one-time setup thing).

-Peff
