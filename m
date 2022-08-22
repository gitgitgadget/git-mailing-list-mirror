Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75049C28D13
	for <git@archiver.kernel.org>; Mon, 22 Aug 2022 22:26:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237799AbiHVW0G (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 22 Aug 2022 18:26:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232461AbiHVW0F (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Aug 2022 18:26:05 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A19ED3AE7E
        for <git@vger.kernel.org>; Mon, 22 Aug 2022 15:26:04 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id a22so15737323edj.5
        for <git@vger.kernel.org>; Mon, 22 Aug 2022 15:26:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=gt/dlluTfKupxyn9PqcdI15OC74CoWJX7Q0Xt/rj8HQ=;
        b=aQ1FSlgipUeapw7lceUBsA3pD1+mY8tbWXqvpRGmjDC3EpE5V+Qm3TTct3kUA8hXsd
         TNYPDyHLu+WglfUFRcgTLLtCY+i5PhQNS131r4bPhmBPdEjT/4l5Z+NJl3ILvMjyEuql
         KpegZpN5PZTsnjXw8I9/B9OUn7nYWyMv+Izd0zJHsg64J79B6TF3+7zwsmilLbOMGIzd
         Dgewo2YXga2Bi4UW9ZOw9Fje0M8r4tHAWDjeOmoLYz0o15ZeaFSvf02RDEG5rK/0W9+y
         nYA3daKVYesQCzI5zq9E3UrZR3LUzk92MdmnSyriIqkzpGJlYsVmnsk3Z/5PCwbZS+3p
         Hv3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=gt/dlluTfKupxyn9PqcdI15OC74CoWJX7Q0Xt/rj8HQ=;
        b=bafpTwLG6kv9SmimLjz8/oDMWfDOFAMzvmJX7Q+pq03J8oLFXj3bI+gcYLRV8wJZ8m
         cZepfoOqNXNtYlA4uca59FCQC0le/3j/gc5fnFXDfR6dcj98M7XU88RkEKEwHCjbSo4/
         wFEZpKqxs3253zP/dNdA7Q7iGSUf8qT7A2vwRvtgnY7flclcFuYTGzUlUuEadOGjdcSJ
         JWjfwLLk9dpkE3GIXb9xx5lXkokkDb83vla9qgG5oSoB92PwqyxyAgDMQcOUaL4qKrWo
         iichl7yslIAf2n7hP1JPmkkb1d5MoW1PwZiJBIM3KPS+HW+mBZAW2mKCItpl9YyXtvWw
         U61Q==
X-Gm-Message-State: ACgBeo3K2LOfVA/YCvAFWGxZzJDYL+wyhgJTkvtRV8aEZCxQRgaXV5kI
        9iio92r9qW14sASzfAEqfbo=
X-Google-Smtp-Source: AA6agR51wok2JP/azPlR+y/dEWHG8NM50MUlPQIpauqdshbvl2WRL+m8gRnl/p5m76F4OnAPUC/PrA==
X-Received: by 2002:a05:6402:5cd:b0:446:5965:f4af with SMTP id n13-20020a05640205cd00b004465965f4afmr1050261edx.12.1661207163139;
        Mon, 22 Aug 2022 15:26:03 -0700 (PDT)
Received: from localhost (84-236-78-250.pool.digikabel.hu. [84.236.78.250])
        by smtp.gmail.com with ESMTPSA id la19-20020a170907781300b00734bfab4d59sm3492281ejc.170.2022.08.22.15.26.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Aug 2022 15:26:02 -0700 (PDT)
Date:   Tue, 23 Aug 2022 00:26:01 +0200
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Derrick Stolee <derrickstolee@github.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: [Question] How to fix 'static-analysis' build on Ubuntu 20.04
Message-ID: <20220822222601.GA1760@szeder.dev>
References: <eb8779bc-fc41-f601-05f2-024e6bf3f316@github.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <eb8779bc-fc41-f601-05f2-024e6bf3f316@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Aug 22, 2022 at 11:19:11AM -0400, Derrick Stolee wrote:
> While preparing my latest series, I noticed that the GitHub Actions CI
> builds were cancelling the 'static-analysis' job because of a brownout of
> Ubuntu 18.04. We are recommended to upgrade to 20.04.
> 
> However, we explicitly chose 18.04 in d051ed77ee6
> (.github/workflows/main.yml: run static-analysis on bionic, 2021-02-08)
> because coccinelle was not available in 20.04. It still isn't available
> since I tried the basic update and it failed [1]
> 
> [1] https://github.com/gitgitgadget/git/runs/7955077955?check_suite_focus=true#step:3:98
> 
> Does anyone have an idea of how to install coccinelle on this newer
> version? 

Containers?  I've built Docker containers from most recent Coccinelle
versions and used to use them in my custom Travis CI build jobs; the
version included in Ubuntu 18.04 is rather old, and apparently it
doesn't catch some transformations that later versions do [1].  I'm
sure it's somehow possible to use such containers in GitHub Actions as
well.

> Should we try compiling it from source for this job?

It's not that difficult to build Coccinelle from source once you
figure out its OCaml dependencies...  And luckily those dependencies
seem to be rather stable: we can pass the same dozen or so package
names to 'apt-get' to install all its build dependencies both on
ubuntu:18.04 and :20.04 base images.

However, installing dependencies and building Coccinelle takes almost
5 minutes on my machine; I don't think we'd want to add that much
overhead to every CI build.

> Should we
> consider moving off of coccinelle and onto a different tool?

Is there any other comparable tool out there?!


[1] https://public-inbox.org/git/20220822213408.662482-1-szeder.dev@gmail.com/
    a6a01e7d8a (promisor-remote: fix xcalloc() argument order, 2022-08-22)
    d2c4e6292a (builtin rebase: use oideq(), 2019-04-06)
    7762f44ee0 (builtin rebase: use FREE_AND_NULL, 2019-04-06)
[2] In a sequential build; alas parallel builds always fail.
