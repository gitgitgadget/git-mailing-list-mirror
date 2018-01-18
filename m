Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 38C7D1FADF
	for <e@80x24.org>; Thu, 18 Jan 2018 21:51:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753189AbeARVvO (ORCPT <rfc822;e@80x24.org>);
        Thu, 18 Jan 2018 16:51:14 -0500
Received: from mail-wm0-f66.google.com ([74.125.82.66]:41491 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752840AbeARVvL (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Jan 2018 16:51:11 -0500
Received: by mail-wm0-f66.google.com with SMTP id f71so90249wmf.0
        for <git@vger.kernel.org>; Thu, 18 Jan 2018 13:51:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=lzpQ6R7TqDBjM0DBk2mbbqpH6UVeiF0kB+FGxcfQ678=;
        b=Vxf80d6OOUD9xhJ6tATYqXJx90dnHpBUDM9Qib5ggXQMPrBkyYHcKyHG59wLsDWAnh
         Akv3T6dAGlJAstf3GkQDp2zcEM8NdiYJ8AB3daMmEwwxk8ZlJjZiKDr6wQq9Iee2DDx6
         QnnV1/krYDfJARqdr7ogT0ADmnmGs+S3kpLwH9S6cUcGzLEDjwIiFYtydIlBOYRiY8KT
         3jIe4Ad4Jf/4LdmkR9fRma1P15Vw/0a0JRfmlmSjNLuWdBlUXAPw/BgrZq++GrHL/XHs
         tD6nLWyqmlogSbFnaQB+r5D2s6WIruLIfE+nlmQkUhavCOQ7ycsKt4kiy8jZnxw9tN2b
         OQUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=lzpQ6R7TqDBjM0DBk2mbbqpH6UVeiF0kB+FGxcfQ678=;
        b=M0PttcbKMMNiRG0hjnn8xRbledoPD4QOOiLmWozEem286SWNrvBnZ2bEXo5yJpqSqv
         m7bmRAUUvgLuivt47SsFVzT74FMy9xOGzweFR1StcB3fggC7gv28H7NCXuFSzks8moOf
         Jz+f7n8po0ZghPcncAUd5uXqEYKoZypMqDmGXjGAHICvJE59uy7EShRqcNKYGJlEPWZ6
         bD7vx05+Zo/IKtzucNM292Cv4yYglWol/V+1wBmPs0c3yo6bVDzi/dLC25rtlnoI72Qa
         4cJ3XX5cFGuUXdmyCg7uVj9NcA+E7XmtV0hwpT7AkoERqWgGJLOrmEfB1tBaMS+L+KAJ
         uqQw==
X-Gm-Message-State: AKwxytf/YPTpu05p8B9KKfNDYWqurh2ZAzpMP5f5XgxQyk94x6o8wESm
        4KQdSucF0TFrRyo+dHiZe1L/t08r
X-Google-Smtp-Source: ACJfBovuHVBLj5pVqAd8LTjTWpfsHnWeOhV/Co2+vOOHphXEDNGJZXSPL0ddQqWwANHPAPTyb7+GaA==
X-Received: by 10.28.236.201 with SMTP id h70mr7032530wmi.72.1516312270562;
        Thu, 18 Jan 2018 13:51:10 -0800 (PST)
Received: from localhost (cpc73832-dals21-2-0-cust969.20-2.cable.virginm.net. [81.110.231.202])
        by smtp.gmail.com with ESMTPSA id b136sm370319wme.34.2018.01.18.13.51.09
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 18 Jan 2018 13:51:09 -0800 (PST)
Date:   Thu, 18 Jan 2018 21:53:31 +0000
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Lars Schneider <larsxschneider@gmail.com>,
        Brandon Williams <bmwill@google.com>,
        Jeff King <peff@peff.net>, git@vger.kernel.org,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder.dev@gmail.com>
Subject: Re: [PATCH v3 0/3] fixes for split index mode
Message-ID: <20180118215331.GN2641@hank>
References: <20171217225122.28941-1-t.gummerer@gmail.com>
 <20180107223015.17720-1-t.gummerer@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180107223015.17720-1-t.gummerer@gmail.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Friendly ping on this series now that 2.16 is out :) Is there anything
in this series (up to 3/3, 4/3 can be dropped now that Duy fixed it in
a nicer way) that still needs updating?  It fixes a few bugs in split
index mode with submodules/worktrees, so it would be nice to get this
reviewed/merged.

On 01/07, Thomas Gummerer wrote:
> Thanks Brandon and Lars for comments on the previous round.
> 
> Previous rounds were at <20171210212202.28231-1-t.gummerer@gmail.com>
> and <20171217225122.28941-1-t.gummerer@gmail.com>.
> 
> Changes since the previous round:
> 
> - reworked the patches to no longer try to use struct repository for
>   worktrees, but pass gitdir into read_index_from instead (Thanks
>   Brandon :)).  So the fixes that were in 1/3 and 2/3 previously are
>   now in 1/3
> - 2/3 now fixes t7009 properly.  I thought it was fixed before, but it
>   probably just passed the tests because of the GIT_TEST_SPLIT_INDEX
>   "randomness".
> - The travis job is now only running the 64-bit linux build with split
>   index mode to save even more cycles.
> - As this wasn't picked up anywhere yet, I took the freedom to rebase
>   this onto the current master, which includes sg/travis-fixes, which
>   made it a bit easier for me to test.  If this makes the life harder
>   for anyone reviewing this let me know and I can base it on the same
>   commit previous iterations were based on.
> 
> Thomas Gummerer (3):
>   read-cache: fix reading the shared index for other repos
>   split-index: don't write cache tree with null sha1 entries
>   travis: run tests with GIT_TEST_SPLIT_INDEX
> 
>  cache-tree.c            |  2 +-
>  cache.h                 |  8 +++++---
>  ci/run-linux32-build.sh |  1 +
>  ci/run-tests.sh         |  4 ++++
>  read-cache.c            | 25 ++++++++++++++-----------
>  repository.c            |  2 +-
>  revision.c              |  3 ++-
>  split-index.c           |  2 ++
>  t/t1700-split-index.sh  | 19 +++++++++++++++++++
>  9 files changed, 49 insertions(+), 17 deletions(-)
> 
> -- 
> 2.16.0.rc1.238.g530d649a79
> 
