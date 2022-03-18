Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80073C433EF
	for <git@archiver.kernel.org>; Fri, 18 Mar 2022 11:15:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235691AbiCRLQV (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 18 Mar 2022 07:16:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235663AbiCRLQU (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Mar 2022 07:16:20 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF2D419F459
        for <git@vger.kernel.org>; Fri, 18 Mar 2022 04:15:00 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id u10so11265574wra.9
        for <git@vger.kernel.org>; Fri, 18 Mar 2022 04:15:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:reply-to:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=r0rqV5bIGXAzLV3V1QQ1AsKzKlr9/ZrI9F4wVkMpDG4=;
        b=Kl2Yw6WeDKiVoK6NCtdLS1KuWI3OXm4F2HKqmChoIaYL0aZuYLS0KHoQruRuzJoUUs
         abUTYHILkrMR22Ub8as3OeZ4244zPoFXdvhVAqmSeEHkaQdR1UcabDh10NhHGHLm9c0H
         h0m6mIKQrNXLZZqKpv5Sd76VPuLRIYTvV8PDG7r54o6zmm+SExRoK0cuS6WfYkIBxumB
         OLuqW0tq/X2eLL1GTIStTDDzZyxBt0vr6D9+H9ZLacDLrfgfdXijBcw9KmDqCYc8lDTA
         J0+7E4Jp4l/ONx8smjvTzyMHtixSQxhf1mybzX/3Sw4dtoYWRW5tayEXPu0N77USATad
         9A3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:reply-to
         :subject:content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=r0rqV5bIGXAzLV3V1QQ1AsKzKlr9/ZrI9F4wVkMpDG4=;
        b=W5PPIJRDtxELv1oypDUS56VG/0L+M4x3aHEroPH89Y8LGCitRMMDnf1r3TaLG4k5mv
         SW+P+Fw3cMZW7zuvQ5M9JeeVS+6Qod1K22RFh8EntMdDq4K1sqCxO4m9sFqJPzC6DnsK
         OMh6ECyNYYZOrraXbXvMTpU/n6l8HPf7064j4TxFWVUs3Y5EU2T01fbZz1gHVeg+e4yR
         YZFt03uE9pkL2G248UWuZ4j6YmAKLJd8GiBixrkDCHNw7MCXekkqWcJ7rUVkPPM8CLth
         32+MUSg16RV6rBTl//QtrRpCXuHjOrRfxWXuDPmlgS5TlFwP+iGZyIT9piFPFrL9KNL0
         1U6A==
X-Gm-Message-State: AOAM533I50Wu3dnmdMRhIcqh4M9fZqYBRcbs4R3gIlB1CxPBNeRDXth9
        gsiaCjA4mtE82Y6ERMV+I/MDktXFZtw=
X-Google-Smtp-Source: ABdhPJyzOQuepNC7g0VjnukfeOBZ8O2ZtVVjJAoSsyCTOJNLvK40RLf1Yb71bHWZLK46RDcUBlSJCA==
X-Received: by 2002:a05:6000:1a8f:b0:203:7ca5:8dc0 with SMTP id f15-20020a0560001a8f00b002037ca58dc0mr7414051wry.358.1647602099399;
        Fri, 18 Mar 2022 04:14:59 -0700 (PDT)
Received: from [192.168.1.201] (31.107.7.51.dyn.plus.net. [51.7.107.31])
        by smtp.googlemail.com with ESMTPSA id i10-20020a0560001aca00b00203daf3759asm6629804wry.68.2022.03.18.04.14.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Mar 2022 04:14:59 -0700 (PDT)
Message-ID: <7f76e3e3-20d5-d249-c376-962dcc73869f@gmail.com>
Date:   Fri, 18 Mar 2022 11:14:58 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v4 2/3] rebase: use test_commit helper in setup
Content-Language: en-US
To:     John Cai via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        John Cai <johncai86@gmail.com>
References: <pull.1226.v3.git.git.1647487001.gitgitgadget@gmail.com>
 <pull.1226.v4.git.git.1647546828.gitgitgadget@gmail.com>
 <5c40e116eba00b5b1a64191c6adf211d326e7f96.1647546828.git.gitgitgadget@gmail.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <5c40e116eba00b5b1a64191c6adf211d326e7f96.1647546828.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi John

On 17/03/2022 19:53, John Cai via GitGitGadget wrote:
> From: John Cai <johncai86@gmail.com>
> 
> To prepare for the next commit that will test rebase with oids instead
> of branch names, update the rebase setup test to add a couple of tags we
> can use. This uses the test_commit helper so we can replace some lines
> that add a commit manually.
> 
> Setting logAllRefUpdates is not necessary because it's on by default for
> repositories with a working tree.
> 
> Helped-by: Phillip Wood <phillip.wood123@gmail.com>
> Signed-off-by: John Cai <johncai86@gmail.com>
> ---
>   t/t3400-rebase.sh | 18 ++++--------------
>   1 file changed, 4 insertions(+), 14 deletions(-)
> 
> diff --git a/t/t3400-rebase.sh b/t/t3400-rebase.sh
> index 5c4073f06d6..2fb3fabe60e 100755
> --- a/t/t3400-rebase.sh
> +++ b/t/t3400-rebase.sh
> @@ -18,10 +18,7 @@ GIT_AUTHOR_EMAIL=bogus@email@address
>   export GIT_AUTHOR_NAME GIT_AUTHOR_EMAIL
>   
>   test_expect_success 'prepare repository with topic branches' '
> -	git config core.logAllRefUpdates true &&
> -	echo First >A &&
> -	git update-index --add A &&
> -	git commit -m "Add A." &&
> +	test_commit "Add A." A First First &&
>   	git checkout -b force-3way &&
>   	echo Dummy >Y &&
>   	git update-index --add Y &&
> @@ -32,17 +29,13 @@ test_expect_success 'prepare repository with topic branches' '
>   	git mv A D/A &&
>   	git commit -m "Move A." &&
>   	git checkout -b my-topic-branch main &&
> -	echo Second >B &&
> -	git update-index --add B &&
> -	git commit -m "Add B." &&
> +	test_commit "Add B." B Second Second &&
>   	git checkout -f main &&
>   	echo Third >>A &&
>   	git update-index A &&
>   	git commit -m "Modify A." &&
>   	git checkout -b side my-topic-branch &&

This version has added some more conversions that are not mentioned it 
the commit message. If you want to covert the whole setup to use 
test_commit then that's great but I think you need to do the whole thing 
and say in the commit message that you're modernizing everything. As it 
stands a reader is left wondering why some of the setup that is not used 
in the next commit  has been converted but other bits such as the 
"Modify A." above are left as is. I think the two possibilities that 
make sense are (a) convert only what we need for the next commit, or (b) 
modernize the test and convert everything.

Best Wishes

Phillip

> -	echo Side >>C &&
> -	git add C &&
> -	git commit -m "Add C" &&
> +	test_commit --no-tag "Add C" C Side &&
>   	git checkout -f my-topic-branch &&
>   	git tag topic
>   '
> @@ -119,10 +112,7 @@ test_expect_success 'rebase off of the previous branch using "-"' '
>   test_expect_success 'rebase a single mode change' '
>   	git checkout main &&
>   	git branch -D topic &&
> -	echo 1 >X &&
> -	git add X &&
> -	test_tick &&
> -	git commit -m prepare &&
> +	test_commit prepare X 1 &&
>   	git checkout -b modechange HEAD^ &&
>   	echo 1 >X &&
>   	git add X &&

