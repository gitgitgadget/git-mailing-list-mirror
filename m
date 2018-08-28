Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F14BE1F404
	for <e@80x24.org>; Tue, 28 Aug 2018 21:25:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727401AbeH2BSb (ORCPT <rfc822;e@80x24.org>);
        Tue, 28 Aug 2018 21:18:31 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:42201 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727337AbeH2BSb (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Aug 2018 21:18:31 -0400
Received: by mail-pg1-f193.google.com with SMTP id y4-v6so1314513pgp.9
        for <git@vger.kernel.org>; Tue, 28 Aug 2018 14:25:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=VjvpJqYDf60GcEDxtj+iOAikN/r+1mkIxrKedugB/Ck=;
        b=ZmmACjUO5fhjMKDTgnEGkQoUP+k3PfFB6VZQRJaj6SD3dnqs2eqdm50JoxnFJXhpN9
         QdEhnTwwQLKF2o083+P2Kb8w1z0mShjmxI4DCWqBZdG+1bVG2PfGkAjkdYbI4UJ0J7Gg
         wfdi273YXSWvE8Ze+pCe9L/h/eIoZNqviQAsSEU8CL2c0sim3APi166gdnuYME+wUNzK
         nTY4CnWDssK4gBqm4y1BQ5UTX5zyDqG+jPkYkxMgWtmhAmcey+mQAkpSY3fNd72I/aUu
         X7PWtvx4unua3EZueREvr/CAqJ+ezbvda/7DuM/V7CnmktNVGisJnqgLqaCBS2vzK7n3
         B10A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=VjvpJqYDf60GcEDxtj+iOAikN/r+1mkIxrKedugB/Ck=;
        b=cc8aQSshUv0tob7m7eNB2brQTYJg3v4zM2FQZgNlOjK8BNOQzj104nr1Un3WG0nKV+
         Vd+WhcAE8wQBSmpzLFX0HPcGNH4v03EZaN+A9jufb3nTKhDYxMdbsbHOpKCal2z1ou6M
         UWrYzw1/2A4jYw3hzmQ0ksCL+FsIecBoRDw2k2uP/+g861MjNNOnfCjcVcc+KIQgjDAP
         Da3LyKh3Rojcs6VpFXaMPf5nddZJbyMuH4b/XsmlnNuL8vH05PnJ3LjR9gP34HWmIVQv
         K4iR6v2ZaTyVIkXKh43WJ0MVhR7M1R5Mdbvgfm5ofxywn0BVg+RJAd0Mk7S1njS/Bafa
         xVpw==
X-Gm-Message-State: APzg51A1GE5JGVq7vIfjlQDFit9WsNVwYyFWM3/kgJUyInP9ktwu7ZRL
        tnk0XA5EavChfaOz6aBl+Tg=
X-Google-Smtp-Source: ANB0VdZE7j5v+tpz4wt5mzYP6poCDUhEjOqysswv7PITV4r0NCyzwd96mYPY9dpi+0FLBVxLDw81og==
X-Received: by 2002:a62:954:: with SMTP id e81-v6mr3109742pfd.231.1535491499580;
        Tue, 28 Aug 2018 14:24:59 -0700 (PDT)
Received: from aiede.svl.corp.google.com ([2620:0:100e:422:4187:1d6c:d3d6:9ce6])
        by smtp.gmail.com with ESMTPSA id u9-v6sm3673078pfi.104.2018.08.28.14.24.58
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 28 Aug 2018 14:24:58 -0700 (PDT)
Date:   Tue, 28 Aug 2018 14:24:57 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Derrick Stolee <dstolee@microsoft.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        "sbeller@google.com" <sbeller@google.com>,
        "stolee@gmail.com" <stolee@gmail.com>,
        "jonathantanmy@google.com" <jonathantanmy@google.com>,
        "gitster@pobox.com" <gitster@pobox.com>
Subject: Re: [PATCH v2 04/18] commit-reach: move commit_contains from
 ref-filter
Message-ID: <20180828212457.GA74687@aiede.svl.corp.google.com>
References: <pull.10.git.gitgitgadget@gmail.com>
 <20180720163227.105950-1-dstolee@microsoft.com>
 <20180720163227.105950-5-dstolee@microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180720163227.105950-5-dstolee@microsoft.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Derrick Stolee wrote:

> There are several commit walks in the codebase. Group them together into
> a new commit-reach.c file and corresponding header. After we group these
> walks into one place, we can reduce duplicate logic by calling
> equivalent methods.
>
> All methods are direct moves, except we also make the commit_contains()
> method public so its consumers in ref-filter.c can still call it. We can
> also test this method in a test-tool in a later commit.
>
> Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
> ---
>  commit-reach.c | 121 +++++++++++++++++++++++++++++++++++++++++
>  commit-reach.h |  20 ++++++-
>  ref-filter.c   | 145 +++----------------------------------------------
>  3 files changed, 147 insertions(+), 139 deletions(-)
> 
> diff --git a/commit-reach.c b/commit-reach.c
> index a6bc4781a6..01d796f011 100644
> --- a/commit-reach.c
> +++ b/commit-reach.c
> @@ -1,8 +1,10 @@
>  #include "cache.h"
>  #include "commit.h"
> +#include "commit-graph.h"
>  #include "decorate.h"
>  #include "prio-queue.h"
>  #include "tree.h"
> +#include "ref-filter.c"

Did you mean "ref-filter.h"?

This broke the build here.  Is there some check that we can use to
prevent it happening again?  I don't think we ever intentionally
#include a .c file.

Thanks,
Jonathan
