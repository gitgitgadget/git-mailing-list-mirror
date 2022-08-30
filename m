Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B66D4ECAAD1
	for <git@archiver.kernel.org>; Tue, 30 Aug 2022 15:20:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230210AbiH3PUn (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 30 Aug 2022 11:20:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229652AbiH3PUl (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Aug 2022 11:20:41 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9187758085
        for <git@vger.kernel.org>; Tue, 30 Aug 2022 08:20:39 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id v16so11956374wrm.8
        for <git@vger.kernel.org>; Tue, 30 Aug 2022 08:20:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc;
        bh=Dw3IjqxctPdkCjpeheRU24aRPESvwGAN+cDdR0vCDy0=;
        b=juJ81AVxWvwl3uQ0yqco4MLiKIzW+G9oyBaIGK4TIqKTexupeDgaTc0p6p1RKH5eaK
         NzU8svoYR54K3l4DQ0UXZLLNZ7NHVrFPlY1alAR+e9coBvds51QV6MN6NypHA+7hcuQS
         llfIHPXiUvG6hQbKgJ4PopGvlEfyadNeOA9cOAKnvkgOXG4f6Mtgxi0j+ouBpFxFYxrl
         9X4JKyq43Nrvve9LugYFPl4dRuomwzVyv3Ua+/ymzCzz7BddBEI2blLjnSvWpI3F2X+F
         nHxe+NwpqPmlde9CmAbM0FEKRAikl2b5aSaOpfUTVOoUZmRjlACLytf7MTOD+PR8t7ML
         me0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc;
        bh=Dw3IjqxctPdkCjpeheRU24aRPESvwGAN+cDdR0vCDy0=;
        b=Fm1Y2596xpAkyEdgBKuO4/solKidiurKH2Hk9BE1WNLEW51weegxff9NIly7quKnZV
         AiDoaCe4+Zs6P2ZCOCult3yaHYm/GW2DDW6x3l3EzGMnH3idaD/2uZD/xOby7sP+ueh6
         outGsBFnwj9lL1X6lI/LTuqxFexkF89hHHGPrl/VZ075PiSoMqhI7YeFv2PdOF1Dyh0/
         RVfAp4rJFgZBqD0rL+UWKcXcramVxzBGaZM8627Ojsa13A0ehCIp56NKVo+Z5QMP1GmB
         ho0LKfcrSaf9YJ+jFe7KqQxeLgbYvkZ/KMyTJ8jUmYKOsyIetbhMAbQnw6hoUaURMuPz
         0yNA==
X-Gm-Message-State: ACgBeo1gLdeIINCb/JQwfvC0nU3jhdL3Yc0AeomaSgCXh0sga0zG3zQA
        U/I0/5SdaEcP7pyHN7gT8rE=
X-Google-Smtp-Source: AA6agR6HzEuymsPcsji1Dh42hzV3PdpOrkOSBnhmoG5OU2zPRjByON1N6JxYFqF3tmsFCV6vR8wgbQ==
X-Received: by 2002:a5d:50c3:0:b0:226:e77f:ccaf with SMTP id f3-20020a5d50c3000000b00226e77fccafmr1190738wrt.163.1661872838155;
        Tue, 30 Aug 2022 08:20:38 -0700 (PDT)
Received: from [192.168.1.74] ([31.185.185.144])
        by smtp.gmail.com with ESMTPSA id r10-20020adff10a000000b002211fc70174sm11404437wro.99.2022.08.30.08.20.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Aug 2022 08:20:37 -0700 (PDT)
Message-ID: <26fdecfe-1715-1b12-2cd4-ec114f5b426b@gmail.com>
Date:   Tue, 30 Aug 2022 16:19:47 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH 0/3] A couple of CI fixes regarding the built-in add
 --patch
Content-Language: en-US
To:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>
References: <pull.1340.git.1661867664.gitgitgadget@gmail.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <pull.1340.git.1661867664.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Dscho

All three patches look good to me, thanks for working on them.

Phillip

On 30/08/2022 14:54, Johannes Schindelin via GitGitGadget wrote:
> This is an attempt to address the concern Junio raised in
> https://lore.kernel.org/git/xmqq7d3gm1bl.fsf@gitster.g/: originally
> motivated by a test suite failure when running Git's test suite in Visual
> Studio, this pulls out the signed vs unsigned fix whose implications are
> potentially much wider than Visual C.
> 
> While in that space, I spent the time (which took almost as long as I
> expected
> [https://lore.kernel.org/git/nrr2312s-q256-61n7-2843-7r0s817rp432@tzk.qr/])
> to craft a semantic patch to scrutinize Git's source code for similar issues
> (narrator's voice: there were no other instances, what did ya expect?).
> 
> To verify the fix, I then worked on a patch to exercise the built-in git add
> -p in the test suite even when NO_PERL is set, and while developing this
> patch and validating it, I got really puzzled that the add -p test case in
> t6132 did not need to be guarded behind a PERL prereq. So this patch series
> also includes a fix for that.
> 
> The story arc that binds all of these patches together is that they all
> revolve around NO_PERL and CI issues that involve git add --patch.
> 
> Note: This patch series is based on ds/github-actions-use-newer-ubuntu (but
> probably applies cleanly even on maint) because I tried to develop a
> semantic patch to fix similar issues in the code base. However, I've since
> run into what looks like a bug in Coccinelle
> [https://github.com/coccinelle/coccinelle/issues/284]. My latest version of
> that semantic patch looks like this, but I stopped when running it on Git's
> source code triggered the bug for 66 of Git's .c files:
> 
> @@
> type T = { unsigned int };
> T:n b;
> type S != { unsigned int, size_t };
> S s;
> binary operator o != { &&, || };
> @@
> -s o b
> +s o (S)b
> 
> @@
> type T = { unsigned int };
> T:n b;
> type S != { unsigned int, size_t };
> S s;
> binary operator o != { &&, || };
> @@
> -b o s
> +(S)b o s
> 
> 
> Johannes Schindelin (3):
>    add -p: avoid ambiguous signed/unsigned comparison
>    t3701: test the built-in `add -i` regardless of NO_PERL
>    t6132(NO_PERL): do not run the scripted `add -p`
> 
>   add-patch.c                 | 2 +-
>   t/t3701-add-interactive.sh  | 4 ++--
>   t/t6132-pathspec-exclude.sh | 6 +++++-
>   3 files changed, 8 insertions(+), 4 deletions(-)
> 
> 
> base-commit: ef46584831268a83591412a33783caf866867482
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1340%2Fdscho%2Fbuilt-in-add-i-does-not-need-perl-v1
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1340/dscho/built-in-add-i-does-not-need-perl-v1
> Pull-Request: https://github.com/gitgitgadget/git/pull/1340
