Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2263C433F5
	for <git@archiver.kernel.org>; Tue, 22 Feb 2022 13:54:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232575AbiBVNzS (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 22 Feb 2022 08:55:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232359AbiBVNzP (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Feb 2022 08:55:15 -0500
Received: from mail-qv1-xf2e.google.com (mail-qv1-xf2e.google.com [IPv6:2607:f8b0:4864:20::f2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47577119411
        for <git@vger.kernel.org>; Tue, 22 Feb 2022 05:54:50 -0800 (PST)
Received: by mail-qv1-xf2e.google.com with SMTP id d3so42142238qvb.5
        for <git@vger.kernel.org>; Tue, 22 Feb 2022 05:54:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=uwTsx90EHW/ayNF8rTstYcaCHfJBtBL9T+P/kiRaKdA=;
        b=e/tCQKeF2L8OPdQ/lERZ6HC5aUqMxRSd/Pbjz0IE4Da8AVutfp66k6VPNfK2nvY26i
         RxmoqrtJpYgJxwLvE+L0E94/Xxl5Mw1aq2E5jZyIgJsP5h9ZGfqXCFFSnhFKooxh0dzq
         ScHsd6XK40EWhN9AZk4WbKHnBR3x9rntxMijBYDBX6OFuyts/uRwGyoCYNp+3z7AUXdu
         DvaV3mqI78SbIdwPkdxXThAVfp1CUM76gyK4VJg8hJK3kKLx5iDI0WNxtisv/p4p+9MG
         X7fF9xkUMrjd812VLAOMYseNIgisFDNCBdD3SWxyIJ5xGFIeB90kyj9+Ty7Vlkd/ESum
         9fUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=uwTsx90EHW/ayNF8rTstYcaCHfJBtBL9T+P/kiRaKdA=;
        b=XmiXRbASXeYT5tK/R3OKuu7y7mzrYshbUsvCbr5dgwebWhZloY8SvVCaCS9T1Fq2tq
         YJWvnJfkMNypT7dwd/O10oujGmqJlsav5WzOORuadsSl5G2pVSKm0yscmwElkk9LWEa/
         QlOuvcSx3R22KlFsqmFzbMHOY33XEnYm3loIiLoi6tFSUwTpRmkVnODqJSoTuPvQkqY1
         32mahjZ/mH7NVD2LxgdDMKRa8cFYlX4ohWWgvSikmRySbqpXhBYH4ivuAVQ37aE9/c/A
         EVoei9osPc1TdJqok5Ck/R5Qs8ILaDG3a8p0E/tPcx/3inyyO551jo2T/3MvL3a+mLfP
         Ozjg==
X-Gm-Message-State: AOAM533Y2MKLaL9vuNabncpocfq2LEZlOkRiArPoJhMl8fG+SvmiJgzF
        kDPZZuHcm9SYGOAek5EA1+3v
X-Google-Smtp-Source: ABdhPJwP0cCTYDyKbWpNtVP2p1fRbChQsAxdLG4TJqpjpkpYwt0HRu7yYpYqQMkMjUAec9iFxzTZ/Q==
X-Received: by 2002:a05:622a:170f:b0:2de:1b24:dc1f with SMTP id h15-20020a05622a170f00b002de1b24dc1fmr9044213qtk.299.1645538089341;
        Tue, 22 Feb 2022 05:54:49 -0800 (PST)
Received: from [192.168.1.110] ([99.85.27.166])
        by smtp.gmail.com with ESMTPSA id d8sm871178qko.85.2022.02.22.05.54.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Feb 2022 05:54:49 -0800 (PST)
Message-ID: <9d08d2a6-82ed-7d6c-6a82-0e89c55bd94a@github.com>
Date:   Tue, 22 Feb 2022 08:54:48 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH 1/2] t0001: remove pipes
Content-Language: en-US
To:     Shubham Mishra <shivam828787@gmail.com>, git@vger.kernel.org
Cc:     me@ttaylorr.com
References: <20220222114313.14921-1-shivam828787@gmail.com>
 <20220222114313.14921-2-shivam828787@gmail.com>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <20220222114313.14921-2-shivam828787@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2/22/2022 6:43 AM, Shubham Mishra wrote:
> pipes doesn't care about error codes and ignore them thus we should not use them in tests.
> As an easy alternative, I am using a tmp file to write from git command so we can test the exit code.

Please be careful about the length of your lines in your
commit message. vim should auto-wrap as you write.

There are also some grammar issues, so here is an update
to what you wrote:

  Pipes ignore error codes and thus we should not use them
  in tests. As an alternative, use a 'tmp' file to write the
  Git output so we can test the exit code.

(My wrapping is probably too short here.)

> Signed-off-by: Shubham Mishra <shivam828787@gmail.com>
> ---
>  t/t0001-init.sh | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/t/t0001-init.sh b/t/t0001-init.sh
> index 3235ab4d53..9a8f209648 100755
> --- a/t/t0001-init.sh
> +++ b/t/t0001-init.sh
> @@ -489,11 +489,11 @@ test_expect_success 're-init from a linked worktree' '
>  		git worktree add ../linked-worktree &&
>  		mv .git/info/exclude expected-exclude &&
>  		cp .git/config expected-config &&
> -		find .git/worktrees -print | sort >expected &&
> +		find .git/worktrees -print >tmp && sort tmp >expected &&

Split each part of the &&-chain across lines, like this:

+		find .git/worktrees -print >tmp &&
+		sort tmp >expected &&

>  		git -C ../linked-worktree init &&
>  		test_cmp expected-exclude .git/info/exclude &&
>  		test_cmp expected-config .git/config &&
> -		find .git/worktrees -print | sort >actual &&
> +		find .git/worktrees -print >tmp && sort tmp >actual &&

Here, too.

I could make the same comments on patch 2, but I think you
have enough info to go on.

Thanks,
-Stolee
