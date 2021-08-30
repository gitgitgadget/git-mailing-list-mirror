Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17554C432BE
	for <git@archiver.kernel.org>; Mon, 30 Aug 2021 17:47:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EBC7460F42
	for <git@archiver.kernel.org>; Mon, 30 Aug 2021 17:47:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238130AbhH3Rr5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 30 Aug 2021 13:47:57 -0400
Received: from relay10.mail.gandi.net ([217.70.178.230]:35381 "EHLO
        relay10.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234054AbhH3Rr5 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Aug 2021 13:47:57 -0400
Received: (Authenticated sender: me@yadavpratyush.com)
        by relay10.mail.gandi.net (Postfix) with ESMTPSA id 42503240008;
        Mon, 30 Aug 2021 17:47:00 +0000 (UTC)
Date:   Mon, 30 Aug 2021 23:16:58 +0530
From:   Pratyush Yadav <me@yadavpratyush.com>
To:     "Kirill A. Shutemov" <kirill@shutemov.name>
Cc:     git@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Konstantin Ryabitsev <konstantin@linuxfoundation.org>
Subject: Re: Problem accessing git.kernel.org with git v2.33 plus gitproxy
Message-ID: <20210830174658.zd7r6kx7s7lxlihg@yadavpratyush.com>
References: <20210830161149.xggfosjthnjxcoxp@box.shutemov.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210830161149.xggfosjthnjxcoxp@box.shutemov.name>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 30/08/21 07:11PM, Kirill A. Shutemov wrote:
> Hi folks,
> 
> I've stepped on a problem after upgrading git to v2.33.0. git fetch-pack
> fails with an error:
> 
>         fetch-pack: unexpected disconnect while reading sideband packet
> 
> It only happens when I access git.kernel.org over git:// (github over
> git:// works fine) and if there's a gitproxy configured.
> 
> For test I used a dummy gitproxy:
> 
>         #!/bin/sh -efu
>         socat - "TCP:$1:$2"
> 
> It is enough to trigger the issue.
> 
> I'm not sure if it's kernel.org problem or git problem.
> 
> Has anybody else stepped on the issue? Any clues?

I can reproduce it on my computer at work, which needs to sit behind a 
proxy. Not too sure what is causing it though.

-- 
Regards,
Pratyush Yadav
