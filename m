Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A64F41F461
	for <e@80x24.org>; Tue, 20 Aug 2019 08:58:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729623AbfHTI6c (ORCPT <rfc822;e@80x24.org>);
        Tue, 20 Aug 2019 04:58:32 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:51469 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729405AbfHTI6c (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Aug 2019 04:58:32 -0400
Received: by mail-wm1-f66.google.com with SMTP id k1so1615716wmi.1
        for <git@vger.kernel.org>; Tue, 20 Aug 2019 01:58:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=reply-to:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=8k/d9Lp/2TjmmLQbYcYBwUvwA8cPWbnuPuBBHAgMKbw=;
        b=SN06iQ+I8nx8wW5sCuysE1KiwOnwC+PE9jmdZaJXEVqnvGWGBAbbTc8aqZhOsDjKqV
         sHIbGrZVZxyFBlR1CZ2lxpLoGhH9qXuc120oSa7SdFcllWnoRe2sk5Ypft/ZF/5nlxEj
         tJCOHnTDs9c7o56AaJ1tSUHXvrKwaYZLKip5NZzuxC0op5zzrF4lOJm2cgvJARdvk4ZC
         bMt3gTkJV5+hwZnQ73ccSqT2KIW6W5QD884joZtRPkd+/2GHw3XmMG9uxVaRSLHFdHSR
         B55LK1MOKBIZY4Ef7ykqMRPnf10IN76j6VXDPl0QGBjeBSYiLpLCoAHJjvYKRb6Z6ofM
         wE5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:subject:to:cc:references:from
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=8k/d9Lp/2TjmmLQbYcYBwUvwA8cPWbnuPuBBHAgMKbw=;
        b=Os6jNSnh9sJk93IQVMF5ioKtGjS3ppbGfQL6HxETnp5CvIPS51Qisode9uWESDfuEd
         ddh2wB/mf4vBPz7FlLR0SYBQeLI5dYlJwIdSfyNkuGUES0RPqLDPcErU5SrkaEOAGuyM
         FfzNq1gnTZtyZB3XXJARpItSpSacAb1bH4jyKZaXcN/qMznIseFVaBMP1bju6z0CGBGn
         RYK8zZVGc6C5Dzpdon+z3yDhxFjXbotHkk0e8kUpGkaeQsxoQtLgnGqNpKUKccNhYUUY
         MJaPj30SjAM+uiN4QhqsKyUgm5i5cVAQbaAwLbRgOszCI8RXZKQQp13tlrXgLi1o5PaA
         V+fw==
X-Gm-Message-State: APjAAAU2XfA/gnfCU1Tc4U0wAKy/uSD/ql/Ee/OSni/TYYnPtSzLRxDo
        XsrWuhiirWG7VMTU63TR+NI=
X-Google-Smtp-Source: APXvYqwAk4AxQIAmfZb9TJL9l4vO8zWUuX0cp+R6P8bVnBNlw6DGBHWD4U3w1yViIGvTuCnPYYyFEw==
X-Received: by 2002:a1c:a101:: with SMTP id k1mr25335350wme.98.1566291510152;
        Tue, 20 Aug 2019 01:58:30 -0700 (PDT)
Received: from [192.168.2.240] (host-92-22-12-34.as13285.net. [92.22.12.34])
        by smtp.gmail.com with ESMTPSA id 2sm18468612wrg.83.2019.08.20.01.58.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Aug 2019 01:58:29 -0700 (PDT)
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH 1/2] t3420: never change upstream branch
To:     Ben Wijen <ben@wijen.net>, git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Pratik Karki <predatoramigo@gmail.com>
References: <20190818095349.3218-1-ben@wijen.net>
 <20190818095349.3218-2-ben@wijen.net>
From:   Phillip Wood <phillip.wood123@gmail.com>
Message-ID: <a8645289-ff60-7739-b010-039583beef1c@gmail.com>
Date:   Tue, 20 Aug 2019 09:58:28 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190818095349.3218-2-ben@wijen.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB-large
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Ben

On 18/08/2019 10:53, Ben Wijen wrote:
> When using `git rebase --autostash <upstream> <branch>` and
> the workarea is dirty, the active branch is incorrectly reset
> to the rebase <upstream> branch.
> 
> This test will check for such behavior.
> 
> Signed-off-by: Ben Wijen <ben@wijen.net>
> ---
>   t/t3420-rebase-autostash.sh | 9 +++++++++
>   1 file changed, 9 insertions(+)
> 
> diff --git a/t/t3420-rebase-autostash.sh b/t/t3420-rebase-autostash.sh
> index b8f4d03467..867e4e0b17 100755
> --- a/t/t3420-rebase-autostash.sh
> +++ b/t/t3420-rebase-autostash.sh
> @@ -306,4 +306,13 @@ test_expect_success 'branch is left alone when possible' '
>   	test unchanged-branch = "$(git rev-parse --abbrev-ref HEAD)"
>   '
>   
> +test_expect_success 'never change upstream branch' '
> +	test_when_finished "git reset --hard && git branch -D upstream" &&
> +	git checkout -b upstream unrelated-onto-branch &&
> +	echo changed >file0 &&
> +	git add file0 &&
> +	git rebase --autostash upstream feature-branch &&
> +	test $(git rev-parse upstream) = $(git rev-parse unrelated-onto-branch)

In addition to Junio's suggestions I'd add using
	test_cmp_rev upstream unrelated-onto-branch
for the last line.

Best Wishes

Phillip

> +'
> +
>   test_done
> 
