Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F29D41F453
	for <e@80x24.org>; Mon, 15 Oct 2018 14:22:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726864AbeJOWHt (ORCPT <rfc822;e@80x24.org>);
        Mon, 15 Oct 2018 18:07:49 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:38607 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726590AbeJOWHs (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 Oct 2018 18:07:48 -0400
Received: by mail-pf1-f196.google.com with SMTP id f29-v6so9767852pff.5
        for <git@vger.kernel.org>; Mon, 15 Oct 2018 07:22:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=3lcd2551AVK6gq5VxFBPg56EEjvylvTmf2q/PjUs2iY=;
        b=wR5NUj1FNcb4pIA6n8JKU0oaznfOHPFGYPKJ8B2PaIrU361a5w3z4qKBjcUYIA+bEg
         mYWb+1F+7LY2KlzmVX48++SdP8PI38xY/4L/cfrjQxulG+pE0v8c8xPR/RaSn7ET+NUX
         22kHn/QTIHTWmlexagkv7WJLaLtjV5AHc7Gg3H9maoi5OPrmj1hEznGKkNmKJM+EnIQY
         TEYL2eNh0xRJRslBzrVAJCxlRqmKeqc+HqHeAuts4dgNNlR9xwfw7wK7N4Pj4mrPwARD
         bKwHngaHeG4vfwkCCuWH3HNHfU7r52Y+D8ypfzLbPnvEUCCPElBcQjSufABdtxep84yR
         azlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=3lcd2551AVK6gq5VxFBPg56EEjvylvTmf2q/PjUs2iY=;
        b=RFT3YExFsBXGSNersdIiDnCldleZP/q/2no3c0K0xoaUdOEu5ELLEsioTXBhePULFt
         u2IWOvYe8JuvzS6aKw+g9MnvUX6ZVrsy9iJ1aQvg+OCcyyyGIqlDbF5VHUUpRZy6mFgN
         uocy1s6e63bTcDTr4PEJDvmboPI61meV39mi8qKq16oSQiCX37xwztfwoXPqRcwTit4B
         44n9/tEaoSHB/mA4POKxcdOt88ZdnGD+NL7sEu50sc5alSByll8fLjR/8xMtNyWW+xXx
         8QkquSAgVXLzA2Xt4YDsDqfr5DIDlbNn9vkX/0wqz1PiHLgVLzDuTkMPcbR5rL1N86q6
         0PgA==
X-Gm-Message-State: ABuFfojwoOBHXG8HZ32T5Y8z0v0CqeVq2VlUPCbEq/uejdcywKQ2K/yM
        Czt8p1Kfm0dfbGvHvJvgm146fSjhGR0=
X-Google-Smtp-Source: ACcGV63LnLl2BGiawEpNN305HVzI7z5QNSEnMMbgMPxRVdQdrFEK+Xc7kZQzLJftnCjynzZhUsk9Lw==
X-Received: by 2002:a62:f909:: with SMTP id o9-v6mr17899143pfh.160.1539613338108;
        Mon, 15 Oct 2018 07:22:18 -0700 (PDT)
Received: from localhost ([2601:602:9200:32b0:1c3a:f9e2:ac71:29a4])
        by smtp.gmail.com with ESMTPSA id q24-v6sm18458466pfi.165.2018.10.15.07.22.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 15 Oct 2018 07:22:17 -0700 (PDT)
From:   Taylor Blau <me@ttaylorr.com>
X-Google-Original-From: Taylor Blau <ttaylorr@github.com>
Date:   Mon, 15 Oct 2018 07:22:15 -0700
To:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 00/13] Offer to run CI/PR builds in Azure Pipelines
Message-ID: <20181015142215.GB1764@syl.hsd1.wa.comcast.net>
References: <pull.31.git.gitgitgadget@gmail.com>
 <pull.31.v2.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <pull.31.v2.git.gitgitgadget@gmail.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Johannes,

Thanks for putting this together, and offering to build Git on Azure
Pipelines. I haven't followed v1 of this series very closely, so please
excuse me if my comments have already been addressed, and I missed them
in a skim of the last revision.

On Mon, Oct 15, 2018 at 03:11:57AM -0700, Johannes Schindelin via GitGitGadget wrote:
> It is also an invaluable tool for contributors who can validate their code
> contributions via PRs on GitHub, e.g. to verify that their tests do actually
> run on macOS (i.e. with the BSD family of Unix tools instead of the GNU
> one).

Agree.

> The one sad part about this is the Windows support. Travis lacks it, and we
> work around that by using Azure Pipelines (the CI part of Azure DevOps,
> formerly known as Visual Studio Team Services) indirectly: one phase in
> Travis would trigger a build, wait for its log, and then paste that log.

I wonder if Travis' recent announcement [1] affects this at all. To
summarize [1], Travis is offering an early version of adding Windows to
their list of supported builder operations systems. This brings the list
to macOS, Linux, and Windows, which I think satisfies what we would
like to regularly build git.git on.

Would we like to abandon Travis as our main CI service for upstream
git.git, and build on Azure Pipelines only? If so, I think that this is
an OK way to go, but I think that I would be opposed to having more than
one build system. (FWIW, we tend to _three_ for Git LFS, and it can be a
hassle at times).

I see some benefit to sticking with Travis, since we already have a
build configuration that works there. But, you've done the work to
"port" that build configuration over to Azure, so perhaps the point is
moot.

> As Git's Windows builds (and tests!) take quite a bit of time, Travis often
> timed out, or somehow the trigger did not work, and for security reasons
> (the Windows builds are performed in a private pool of containers), the
> Windows builds are completely disabled for Pull Requests on GitHub.

This would be a concession of [1], in my mind: is it possible to run the
tests on Windows in a time such that Travis will not time out?

> As a special treat, this patch series adds the ability to present the
> outcome of Git's test suite as JUnit-style .xml files. This allows the Azure
> Pipelines build to present fun diagrams, trends, and makes it a lot easier
> to drill down to test failures than before. See for example
> https://dev.azure.com/git/git/_build/results?buildId=113&view=ms.vss-test-web.test-result-details
> [https://dev.azure.com/git/git/_build/results?buildId=113&view=ms.vss-test-web.test-result-details]
> (you can click on the label of the failed test, and then see the detailed
> output in the right pane).

That's pretty cool. Travis doesn't support this (to the best of my
knowledge).

Thanks,
Taylor

[1]: https://blog.travis-ci.com/2018-10-11-windows-early-release
