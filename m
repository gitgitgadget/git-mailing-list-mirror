Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F222C433F5
	for <git@archiver.kernel.org>; Fri,  3 Dec 2021 13:58:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381280AbhLCOCD (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 3 Dec 2021 09:02:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352843AbhLCOCD (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Dec 2021 09:02:03 -0500
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58BE9C06173E
        for <git@vger.kernel.org>; Fri,  3 Dec 2021 05:58:39 -0800 (PST)
Received: by mail-qt1-x829.google.com with SMTP id o17so3325508qtk.1
        for <git@vger.kernel.org>; Fri, 03 Dec 2021 05:58:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=98VJtzmV5TetmeJHUZ+Jmn/+fUaH6BZDLIjtPNcB3Dw=;
        b=V+v5whwsxiYz5E6tBOm3VXVrafGZ8OWcek0P7SeG09aERDaQOxNEty5XVRhvsVHGEs
         KNkqVwP4rwYj+seTYh4kzvLpFCVlVWJ550LuUN2VEfcceoBZmXCilfLzCuuh0YOf6duo
         tsA6o4SV9bWKXD8Cel75YmwLASsTcUy70zaDI7tk9XIBDpKhMPpujl4EaIMBJKPgaqxY
         dNLJufHURKT+NCMA+Hwsy3xl7QD77fxPnrkHTlVxyPeELpB/rNy3t47Y7BmKXukmihXC
         GEaz9Zc7c8TMuMFvzn8CpILmz9G9CMVTw4IA7o040Y2iri9LAuZyFRI86km5rIaxpWkz
         9mag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=98VJtzmV5TetmeJHUZ+Jmn/+fUaH6BZDLIjtPNcB3Dw=;
        b=P+RimIEiStJbqu3o/soFP6DZ+IxoAC4sKfd6Sle/XJ1KqJrAxq+q08Nae51ALMIZ0Z
         vufDRnbEejc3Qb4iQCsbHu3462hnewTOGv/7zjPBDbEsSEarPg3SE/vfkNi7yk6BugHr
         /MhWPYGqeVql6Qk2CmrKOmLbhaqyRAPEEob21myq05OsNBgH8wolcreO1vq1W1uDdDE6
         OxpxylJnuFyhOrIt+qG0966Ny43AkgBu4s+sGkVd0WIG0Mf94L/KmryN/BJwVH3xVoaK
         A6ZHpKkIs1qQ8auAS5AiS7BbeF6zpgA61sUYzQ5ThmEUXratYhsgFVtYrDhM9tlYKssn
         PPdg==
X-Gm-Message-State: AOAM532LLyqpp74nU/BdOc0O3e/jlq4oGDHkK3MkZik0zlfQEhtrtv1o
        +xJewd+TxZcd78niXL3PtPQ=
X-Google-Smtp-Source: ABdhPJyTXBLlgN9k5XeTFALlsegPR2s3/KZz0sglj5Ra1oqTm1PqxHXhim84pwb0mplueRkAVK8Q7w==
X-Received: by 2002:a05:622a:246:: with SMTP id c6mr21245073qtx.100.1638539918559;
        Fri, 03 Dec 2021 05:58:38 -0800 (PST)
Received: from [192.168.1.127] (173-246-5-136.qc.cable.ebox.net. [173.246.5.136])
        by smtp.gmail.com with ESMTPSA id m19sm2204192qkn.129.2021.12.03.05.58.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Dec 2021 05:58:37 -0800 (PST)
Subject: Re: [PATCH 0/2] Use the built-in implementation of the interactive
 add command by default
To:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     =?UTF-8?B?U2xhdmljYSDEkHVracSH?= <slawica92@hotmail.com>,
        Denton Liu <liu.denton@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
References: <pull.1087.git.1638281655.gitgitgadget@gmail.com>
From:   Philippe Blain <levraiphilippeblain@gmail.com>
Message-ID: <2ffbab1a-d5b2-fee5-806b-4e81eb759e11@gmail.com>
Date:   Fri, 3 Dec 2021 08:58:36 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.11; rv:78.0)
 Gecko/20100101 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <pull.1087.git.1638281655.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Dscho,

Le 2021-11-30 à 09:14, Johannes Schindelin via GitGitGadget a écrit :
> Over two years ago, Slavica Đukić participated in the Outreachy project,
> starting to implement a built-in version of the interactive git add command.
> A little over a year ago, Git turned on that mode whenever users were
> running with feature.experimental = true.
> 
> It is time to declare this implementation robust, to use it by default, and
> to start deprecating the scripted implementation.
> 
> Johannes Schindelin (2):
>    t2016: require the PERL prereq only when necessary
>    add -i: default to the built-in implementation
> 
>   Documentation/config/add.txt |  6 +++---
>   builtin/add.c                | 15 +++++--------
>   ci/run-build-and-tests.sh    |  2 +-
>   t/README                     |  2 +-
>   t/t2016-checkout-patch.sh    | 42 +++++++++++++++++++-----------------
>   5 files changed, 32 insertions(+), 35 deletions(-)

I just noticed that 'INSTALL' mentions that Perl is needed for 'git add interactive'
et al, so maybe we would want to tweak the wording a bit in there when switch the default
to the C version ?

Cheers,
Philippe.
