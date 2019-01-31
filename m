Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 22A8F1F453
	for <e@80x24.org>; Thu, 31 Jan 2019 14:38:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729884AbfAaOiP (ORCPT <rfc822;e@80x24.org>);
        Thu, 31 Jan 2019 09:38:15 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:37046 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728682AbfAaOiP (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 31 Jan 2019 09:38:15 -0500
Received: by mail-wm1-f67.google.com with SMTP id g67so2809000wmd.2
        for <git@vger.kernel.org>; Thu, 31 Jan 2019 06:38:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=EB/w18Nh+1hvDd8q9Gd9z/4FHjZT88X9aWP0xNclk7c=;
        b=GgMC8AStBg9IDoA9l1/K9z0U0kkElvbP5LoriDRHUHNxhsB8zcrzXUh59N8rgIrl74
         j+WYlwPJq/oVjV8pipUnrrBc35fSLx8y8lEsW5Eo8Xbwyy2ixorsaxlpoZq8G9IrPygC
         8no89Stwz1hyoABPZQtt/lZXKPjaujFw4W80ExvM6NVdVhLNtPRsuTB9B5YIhCph9CKR
         7gCKrH3z4f72huCt91c2bYc6C3btaj1GzkkkCv9IHyvIP/zwiFVy3mPaWB0SSLXU8/93
         Gr6IxMI4uXuqY/gpZmJ0FgZHocDy2fTyK1CMGnnSBSta9vTde66W32dCUy1Vlca07CYr
         J8Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=EB/w18Nh+1hvDd8q9Gd9z/4FHjZT88X9aWP0xNclk7c=;
        b=FylhevGMuFhD6y7bNXuCIMMePRZw+pPWAV4dkqm5rcRXhWhzo2zuqmCXjRfNPk3lrY
         bH68RapLIl4KOAfGMmD7MCfTfdm+b0ufNYEuQVOp5AfKgZWkYUs4zPnbscVJeOQdOcr2
         hUSvNKoqyXGu0dH28B5KPJGLfPx0D3j54wdf0fx5h3aWaXSEc8mrixtKdh8yD/9BPmiO
         DvGktJEacd8RPma89p18TveblX5vBzV8EErs+TiB5Ve6MVsdHpg/hKDuvlhoQjawktoW
         6PDEJIHhxY7WDa4RufXGLvcfssZJ386vn8FiQ3AXUI/yjXc4YkojTj0xDX7KQFZfUgb6
         Txrw==
X-Gm-Message-State: AJcUukerdRhf6WQMWPMseAX1yXj6QL9IVIQ5nTR1jxXV8gfRAoPwFaKl
        48QBkq+rrkneTX6KwM+wYBo=
X-Google-Smtp-Source: ALg8bN6bGVdGRnihaAdhY6MKBblQU6YQCfXOheIWTNv8UEnV5zml2ifbTbia4LuOOLFGpQE4WiRSAg==
X-Received: by 2002:a1c:b455:: with SMTP id d82mr31091965wmf.78.1548945493811;
        Thu, 31 Jan 2019 06:38:13 -0800 (PST)
Received: from szeder.dev (x4db675b2.dyn.telefonica.de. [77.182.117.178])
        by smtp.gmail.com with ESMTPSA id n5sm5733889wrr.94.2019.01.31.06.38.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 31 Jan 2019 06:38:13 -0800 (PST)
Date:   Thu, 31 Jan 2019 15:38:11 +0100
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Jeff Hostetler via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, jeffhost@microsoft.com,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 00/14] Trace2 tracing facility
Message-ID: <20190131143811.GB10587@szeder.dev>
References: <pull.108.v2.git.gitgitgadget@gmail.com>
 <pull.108.v3.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <pull.108.v3.git.gitgitgadget@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jan 30, 2019 at 11:51:04AM -0800, Jeff Hostetler via GitGitGadget wrote:
> V3 addresses:
> [] incorporate most of the suggestions from clang-format.

> Range-diff vs v2:
> 
>   1:  1a90de9dab <  -:  ---------- trace2: Documentation/technical/api-trace2.txt
>   -:  ---------- >  1:  60b56d6a8f trace2: Documentation/technical/api-trace2.txt
>   2:  ea39b76d31 !  2:  bfe2fe0bbe trace2: create new combined trace facility

>      @@ -745,7 +734,8 @@
>       +	int j;
>       +	int sum = 0;
>       +
>      -+	for_each_builtin(j, tgt_j) {
>      ++	for_each_builtin(j, tgt_j)
>      ++	{
>       +		if (tgt_j->pfn_init())
>       +			sum++;
>       +	}
>      @@ -763,7 +753,8 @@
>       +	struct tr2_tgt *tgt_j;
>       +	int j;
>       +
>      -+	for_each_builtin(j, tgt_j) {
>      ++	for_each_builtin(j, tgt_j)
>      ++	{
>       +		tgt_j->pfn_term();
>       +	}

Our CodingGuidelines prefer the opening brace on the same line after
the if/for/while/struct/etc. statement, and even omitting the braces
if the if arm or loop body consists of a single statement.  So
unfortunately a considerable part of this range diff goes in the wrong
direction.

