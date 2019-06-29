Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A3AF61F461
	for <e@80x24.org>; Sat, 29 Jun 2019 17:30:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726887AbfF2RaG (ORCPT <rfc822;e@80x24.org>);
        Sat, 29 Jun 2019 13:30:06 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:33840 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726849AbfF2RaG (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 29 Jun 2019 13:30:06 -0400
Received: by mail-wm1-f66.google.com with SMTP id w9so11428243wmd.1
        for <git@vger.kernel.org>; Sat, 29 Jun 2019 10:30:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Dur/D8eI/qEjO+O83BGO9nBFghAhfpORPlhWkcgPUoI=;
        b=kFNQA9HPCvMQToJBi/MP7VwwrOpmOD3o3a3reCMUvzL6b3xzij2yybtFDW8m/Y4WKA
         8adGcjhfl9eCsZdU/5gWR4Y3uf7E24TNRT+7ljuPACSZSMq2p5Q30Vpg3hfG6LllQ0SK
         vKj6o+YuSMfEQN03PPYCGP3YcvxaxBYKwRT/M8TmmLRQsizdNEgVXn0QbEL4xn44Pj/Q
         l4MdVFTLE7fNO46lr2x8q43cGK283qpUrhx33jwtlyTg5+ByD6T80FHiNbxMYB+9qCJE
         NL/L/AEKg+7vZSwdM1wqbvNR0a2zqRyHCbqwpszaCqWpZOtCeEIG7hxBlQ7Muuys4Ft9
         UsiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Dur/D8eI/qEjO+O83BGO9nBFghAhfpORPlhWkcgPUoI=;
        b=SiwYKMyQemo76iPd8svRmcGXGvijiWJgklJbzdgyhRgzHMIzLT/DeAonx8JJaqCpQz
         z8jCn5z2Th7/Po9wbZzzb61ILgNKeGlN3SyJIqBN7KtrH84ljTrmwwnZ3UIYoOAElsDZ
         0OPyc9xSJElQ/JKyFfmq470sANmQ8ehAcezybF49QCEYE02YfWnRtF2sHaErlpqe4tFz
         JcMSc1W+QTc+iAghTBd/VCKEqDbRlYPH6eV2TBz70HPWrUcctgKJYa6M+7YFiAviHgPy
         AMb89Y4ZOBlhJLflxNaSqwYvIOnXNGT9GHrQdh+yJaPBiC+LAUrQF9+8nbL3qPiMKoW5
         XxmQ==
X-Gm-Message-State: APjAAAX0nOQ2X2GRw96esN6ab/XGbYrPT9NLproXquK6fVChQ+K4SZVF
        /m4YH669UmLFrgGxrIVSV/w=
X-Google-Smtp-Source: APXvYqzCULOvjyw9l/GQFpG4inQSWPEK9XoPJzlctpaMNasm6CUDkJn4U/mC+y0+92LOFboFsmor7w==
X-Received: by 2002:a7b:c444:: with SMTP id l4mr11233704wmi.15.1561829403944;
        Sat, 29 Jun 2019 10:30:03 -0700 (PDT)
Received: from szeder.dev (x4db511ea.dyn.telefonica.de. [77.181.17.234])
        by smtp.gmail.com with ESMTPSA id c1sm11619161wrh.1.2019.06.29.10.30.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 29 Jun 2019 10:30:03 -0700 (PDT)
Date:   Sat, 29 Jun 2019 19:30:01 +0200
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Jeff Hostetler via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, git@jeffhostetler,
        Junio C Hamano <gitster@pobox.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: [PATCH 1/3] status: add status.aheadbehind setting
Message-ID: <20190629173001.GI21574@szeder.dev>
References: <pull.272.git.gitgitgadget@gmail.com>
 <2f0f2a2df9410947b985d83a924d2549d62bb65f.1560889284.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <2f0f2a2df9410947b985d83a924d2549d62bb65f.1560889284.git.gitgitgadget@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jun 18, 2019 at 01:21:25PM -0700, Jeff Hostetler via GitGitGadget wrote:
> diff --git a/t/t6040-tracking-info.sh b/t/t6040-tracking-info.sh
> index 716283b274..febf63f28a 100755
> --- a/t/t6040-tracking-info.sh
> +++ b/t/t6040-tracking-info.sh
> @@ -159,6 +159,19 @@ test_expect_success 'status -s -b --no-ahead-behind (diverged from upstream)' '
>  	test_i18ncmp expect actual
>  '
>  
> +cat >expect <<\EOF
> +## b1...origin/master [different]
> +EOF
> +
> +test_expect_success 'status.aheadbehind=false status -s -b (diverged from upstream)' '
> +	(
> +		cd test &&
> +		git checkout b1 >/dev/null &&
> +		git -c status.aheadbehind=false status -s -b | head -1

These tests specifically check 'git status', but the pipe hides its
exit code.  Please use an intermediate file instead.

> +	) >actual &&

I found it odd to save the output of a whole subshell and redirect
'git checkout's stdout to /dev/null to prevent it from itnerfering
with the stdout of the subshell, instead of saving only the stdout of
the command the test focuses on.

> +	test_i18ncmp expect actual
> +'
> +
>  cat >expect <<\EOF
>  On branch b1
>  Your branch and 'origin/master' have diverged,
> @@ -174,6 +187,15 @@ test_expect_success 'status --long --branch' '
>  	test_i18ncmp expect actual
>  '
>  
> +test_expect_success 'status --long --branch' '
> +	(
> +		cd test &&
> +		git checkout b1 >/dev/null &&
> +		git -c status.aheadbehind=true status --long -b | head -3
> +	) >actual &&
> +	test_i18ncmp expect actual
> +'
> +
>  cat >expect <<\EOF
>  On branch b1
>  Your branch and 'origin/master' refer to different commits.
> @@ -188,6 +210,15 @@ test_expect_success 'status --long --branch --no-ahead-behind' '
>  	test_i18ncmp expect actual
>  '
>  
> +test_expect_success 'status.aheadbehind=false status --long --branch' '
> +	(
> +		cd test &&
> +		git checkout b1 >/dev/null &&
> +		git -c status.aheadbehind=false status --long -b | head -2
> +	) >actual &&
> +	test_i18ncmp expect actual
> +'
> +
>  cat >expect <<\EOF
>  ## b5...brokenbase [gone]
>  EOF
