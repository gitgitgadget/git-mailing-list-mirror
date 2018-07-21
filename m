Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4E2081F597
	for <e@80x24.org>; Sat, 21 Jul 2018 13:02:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727754AbeGUNzb (ORCPT <rfc822;e@80x24.org>);
        Sat, 21 Jul 2018 09:55:31 -0400
Received: from mail-qt0-f195.google.com ([209.85.216.195]:41148 "EHLO
        mail-qt0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727694AbeGUNzb (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 21 Jul 2018 09:55:31 -0400
Received: by mail-qt0-f195.google.com with SMTP id e19-v6so12670160qtp.8
        for <git@vger.kernel.org>; Sat, 21 Jul 2018 06:02:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=3V9bKKVGOdDzzANVQHiV68ct1f4ggkpnFXCSVzk11sM=;
        b=mLg4eUFc9UlE9Q0HdZ3zwmRsxhzzL3ajrMcwFUnQBB3gw4E4kpFDRmAnIpjd4gY9c0
         8jNMwGKw8TGrEpEmTkHwf3625y4427fgjDPqCpE5vUsYx8AmoysZsGy8xiA6k8FRMwtR
         I+k412sJYwBRtsbuVqpRzmd/z3bkOQa8yC/aQUM3lraPQS69NWjusPz7HyqORA6qVW7y
         8c0KHydzC7GW+T5QRJ3Og54EP6Mu1fv0cs8vtoPdOJBTIBGBaYHzGN5YrOaimTEnB/YF
         vUu3lJgecfs/wMp0lw3KrQQs1JXIPLUaKICZpR5URNBg6AfrNH5KNXEg/5Hqngsb0Ond
         E1dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=3V9bKKVGOdDzzANVQHiV68ct1f4ggkpnFXCSVzk11sM=;
        b=ocEtoIGUNwH2ZY0naoRaO2Vs2P1lSBR6Jem/0gr4lfhA5IQ/tKG/BXknY8xQVmOwcy
         zuD24fg/p7yeIJsxHJllEAOPDvKAttLQ9RJmTfPCVisBgcj7DNU0lMWgZ3vMIJel2A+C
         KCxReQTZ5qlSn/0EKxUhscEfKekDg4tVzsM9RAz/6/CYU504oCb4y19P2zoF7oe0GqbV
         RPn9o2sTJ9zlC6UEsUrmcngHPT6r8qd7b7woi8mpxD2BvPdQ+4j8dl6QfSC2Ys7VRiN+
         kcfW2lm7d3YU5Jl4WdAbHlaDZaWlzH5ltdwKaZgQUEwOcYF2gv0lUz0+mWDPD5JqnIi+
         /Mlw==
X-Gm-Message-State: AOUpUlGdBWEDvyZUyJXYUQ+PoKH+3i7GY/lPTGSPpYhhy5LUcUPSOCND
        eD/j6thejGD46HP4XxYNEjE=
X-Google-Smtp-Source: AAOMgpckGYZHmGAUYTJf6FdEFHKhF6Qp/y5Qyi4CzMLX4e57dHHhjCkZ/lqUOH9NK0GTOlZXPMXJAw==
X-Received: by 2002:a0c:e792:: with SMTP id x18-v6mr5152693qvn.3.1532178168904;
        Sat, 21 Jul 2018 06:02:48 -0700 (PDT)
Received: from [192.168.1.97] (70-33-148-227.unassigned.ntelos.net. [70.33.148.227])
        by smtp.gmail.com with ESMTPSA id x206-v6sm2591357qka.89.2018.07.21.06.02.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 21 Jul 2018 06:02:48 -0700 (PDT)
Subject: Re: [PATCH 1/2] t3507: add a testcase showing failure with sparse
 checkout
To:     Elijah Newren <newren@gmail.com>, git@vger.kernel.org
Cc:     gitster@pobox.com, benpeart@microsoft.com, kewillf@microsoft.com
References: <5a8d1098-b4c5-64e1-da98-dac13521e7ba@gmail.com>
 <20180721063428.20518-1-newren@gmail.com>
 <20180721063428.20518-2-newren@gmail.com>
From:   Ben Peart <peartben@gmail.com>
Message-ID: <5250481c-f6a1-0784-28e7-f34a9d6d3c93@gmail.com>
Date:   Sat, 21 Jul 2018 09:02:47 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180721063428.20518-2-newren@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 7/21/2018 2:34 AM, Elijah Newren wrote:
> From: Ben Peart <peartben@gmail.com>
> 
> Signed-off-by: Elijah Newren <newren@gmail.com>
> ---
> Testcase provided by Ben, so committing with him as the author.  Just need
> a sign off from him.

Thanks Elijah, consider it

Signed-off-by: Ben Peart <Ben.Peart@microsoft.com>


> 
>   t/t3507-cherry-pick-conflict.sh | 13 +++++++++++++
>   1 file changed, 13 insertions(+)
> 
> diff --git a/t/t3507-cherry-pick-conflict.sh b/t/t3507-cherry-pick-conflict.sh
> index 7c5ad0862..25fac490d 100755
> --- a/t/t3507-cherry-pick-conflict.sh
> +++ b/t/t3507-cherry-pick-conflict.sh
> @@ -392,4 +392,17 @@ test_expect_success 'commit --amend -s places the sign-off at the right place' '
>   	test_cmp expect actual
>   '
>   
> +test_expect_failure 'failed cherry-pick with sparse-checkout' '
> +       pristine_detach initial &&
> +       git config core.sparseCheckout true &&
> +       echo /unrelated >.git/info/sparse-checkout &&
> +       git read-tree --reset -u HEAD &&
> +       test_must_fail git cherry-pick -Xours picked>actual &&
> +       test_i18ngrep ! "Changes not staged for commit:" actual &&
> +       echo "/*" >.git/info/sparse-checkout &&
> +       git read-tree --reset -u HEAD &&
> +       git config core.sparseCheckout false &&
> +       rm .git/info/sparse-checkout
> +'
> +
>   test_done
> 

