Return-Path: <SRS0=o1/V=3D=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73907C33C9E
	for <git@archiver.kernel.org>; Tue, 14 Jan 2020 22:03:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4466224673
	for <git@archiver.kernel.org>; Tue, 14 Jan 2020 22:03:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728731AbgANWD6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 14 Jan 2020 17:03:58 -0500
Received: from cloud.peff.net ([104.130.231.41]:36630 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1727289AbgANWD6 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Jan 2020 17:03:58 -0500
Received: (qmail 10507 invoked by uid 109); 14 Jan 2020 22:03:58 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 14 Jan 2020 22:03:58 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 25669 invoked by uid 111); 14 Jan 2020 22:10:13 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 14 Jan 2020 17:10:13 -0500
Authentication-Results: peff.net; auth=none
Date:   Tue, 14 Jan 2020 17:03:57 -0500
From:   Jeff King <peff@peff.net>
To:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH] dir: restructure in a way to avoid passing around a
 struct dirent
Message-ID: <20200114220357.GA3957260@coredump.intra.peff.net>
References: <pull.692.git.git.1579019532809.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <pull.692.git.git.1579019532809.gitgitgadget@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jan 14, 2020 at 04:32:12PM +0000, Elijah Newren via GitGitGadget wrote:

>     When I was more than a bit burned out on dir.c in late December, I had
>     looked at making another change to remove the need for a dirent but
>     punted because it looked like "way too much work". Junio and Peff both
>     later suggested the same cleanup, but I said it was too much work. Peff
>     posted a patch which demonstrated that it was actually pretty simple[1],
>     but I somehow read his email wrong and assumed he was commenting on my
>     patch (if I had looked even slightly closer...). His patch was actually
>     for before en/fill-directory-fixes was applied, so I have updated it
>     slightly to apply after that series.

Yeah, I hadn't really grokked your patch, so I was hoping you'd build
your stuff on top. :)

>     I'm not sure if I'm supposed to add a Reviewed-by me or a Signed-off-by
>     or both, but I read through it closely to avoid any hidden surprises. I
>     probably could have saved Dscho some time last month if I would have
>     just looked a little closer. Sorry about all that...
>     
>     (And yeah, we'll need Peff's Signed-off-by, since I'm leaving him as the
>     author; I really only made a small tweak to update his patch.)
>     
>     CC: Jeff King peff@peff.net [peff@peff.net], Johannes Schindelin 
>     Johannes.Schindelin@gmx.de [Johannes.Schindelin@gmx.de]

Hmm, looks like you maybe meant for more headers (and cc's) to happen
than did. Anyway, I'm certainly fine with this direction, and you have
my:

  Signed-off-by: Jeff King <peff@peff.net>

-Peff
