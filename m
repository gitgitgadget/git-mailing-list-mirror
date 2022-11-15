Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00A1EC433FE
	for <git@archiver.kernel.org>; Tue, 15 Nov 2022 17:07:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230241AbiKORHN (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 15 Nov 2022 12:07:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229809AbiKORHJ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Nov 2022 12:07:09 -0500
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CB2A233
        for <git@vger.kernel.org>; Tue, 15 Nov 2022 09:07:08 -0800 (PST)
Received: (qmail 18558 invoked by uid 109); 15 Nov 2022 17:07:07 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 15 Nov 2022 17:07:07 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 23458 invoked by uid 111); 15 Nov 2022 17:07:07 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 15 Nov 2022 12:07:07 -0500
Authentication-Results: peff.net; auth=none
Date:   Tue, 15 Nov 2022 12:07:06 -0500
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Taylor Blau <me@ttaylorr.com>,
        =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] bisect; remove unused "git-bisect.sh" and ".gitignore"
 entry
Message-ID: <Y3PHOpIqMC9ZT4pg@coredump.intra.peff.net>
References: <patch-1.1-7be23b6faa0-20221115T093130Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <patch-1.1-7be23b6faa0-20221115T093130Z-avarab@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Nov 15, 2022 at 10:32:42AM +0100, Ævar Arnfjörð Bjarmason wrote:

> Since fc304fb52f9 (Merge branch 'dd/git-bisect-builtin' into next,
> 2022-11-14) we've used builtin/bisect.c instead of git-bisect.sh to
> implement the "bisect" command. Let's remove the unused leftover
> script, and the ".gitignore" entry for the "git-bisect--helper", which
> also hasn't been built since fc304fb52f9.

A small nit, but it's probably not a good idea to refer to merge commits
from 'next'. They may be meaningful now, but they aren't part of the
long-term history, and will get gc'd eventually when Junio rewinds next
after a release. Which will leave this reference useless for people
looking at "git log" a year from now.

A better reference is probably 73fce29427 (Turn `git bisect` into a full
built-in, 2022-11-10), which will remain stable as it gets merged
eventually into master.

>  .gitignore    |  1 -
>  git-bisect.sh | 63 ---------------------------------------------------

The patch itself looks like an obviously correct thing to do.

-Peff
