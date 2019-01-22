Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 775151F453
	for <e@80x24.org>; Tue, 22 Jan 2019 21:01:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726175AbfAVVBA (ORCPT <rfc822;e@80x24.org>);
        Tue, 22 Jan 2019 16:01:00 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:51930 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726143AbfAVVBA (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Jan 2019 16:01:00 -0500
Received: by mail-wm1-f66.google.com with SMTP id b11so15613578wmj.1
        for <git@vger.kernel.org>; Tue, 22 Jan 2019 13:00:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=mRDog89hHgnhwdPa+ZhygsZq4bIHjeeoTZY/eMxpiWI=;
        b=t3mDhP1cW5IHrGGdAfNK4ZfMzrRi4puGbhh/LLwY5vYpLqL7JbNiTd5GftIIb2Ar4Y
         9eP9cHhA7unWuSNY1AMfAbwdBzzHpTEjonJdhttadInX/f1hOAtVEsl5dDp3WP5FbFaG
         447I/Pd1vREuQQf2DoUHAcujXi7B1Yt1P1AsewPRYB2PD9EZ0aWOwFIRg13di2JBPCWn
         +gPYdQd1yTyPvahBTIodV0xDkWc+I3DPdr2eX1F144wgmy4BQjC0mqUxYQtDcu/BhN35
         8jFMubWv407o4zLXjLe5HUaCTib/3NC9ld9qhL3G/OpnMsjcENxELSFjdrTrBCfb3lEI
         Otsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=mRDog89hHgnhwdPa+ZhygsZq4bIHjeeoTZY/eMxpiWI=;
        b=DA8ShYa1+tPmNW6FQsR4uR+hrYja4BVcCdEbNAI6/VNJGfCLUO5R0frUwyZlVdZ0Iu
         hMwQFpiO5e8K6+t5q2s6waX3koGsNuer4KjptfIMu2a5V9P5arDos9GduI6dh/abIA0R
         K8qTag9PEk1VWoydzFWrjOZsqT6lvicYwFTaP4IitvgPhZM5rmngcPi8+iUQUyk6tvVq
         U9K5FdfJwLN1D+y35z/e3FIUGin6Ds5Q+iHy1oaZYQGSLSWdt2urJQoGJVtoiFnRR5Y+
         EASVh593La0aY7MP8NerJTGHfLBQA8Dx0fS9WSdTVAp0sDUKzIGISoGGk7J34Bp8EX3u
         xfKw==
X-Gm-Message-State: AJcUukcPtkCdy21b7dQdHmttW6ver2+rj7bb3OhOx4vsNeVhsllGPw9c
        y/eWL8Gl2tAZnpWT6knotrE=
X-Google-Smtp-Source: ALg8bN6BxpRQwC31AWKZdb06JV5l8E7dqa5PlecYrIX/4N0XcduERk7k/k9fjMz5hNDzGnpBKHBy0Q==
X-Received: by 2002:a7b:cb18:: with SMTP id u24mr70309wmj.138.1548190857597;
        Tue, 22 Jan 2019 13:00:57 -0800 (PST)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id i192sm58952308wmg.7.2019.01.22.13.00.56
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 22 Jan 2019 13:00:56 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Ben Peart <benpeart@microsoft.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 1/1] tests: explicitly use `test-tool.exe` on Windows
References: <pull.111.git.gitgitgadget@gmail.com>
        <f396aa113ac3c50ca6a2402cedc71a37cdf63504.1548083538.git.gitgitgadget@gmail.com>
Date:   Tue, 22 Jan 2019 13:00:56 -0800
In-Reply-To: <f396aa113ac3c50ca6a2402cedc71a37cdf63504.1548083538.git.gitgitgadget@gmail.com>
        (Johannes Schindelin via GitGitGadget's message of "Mon, 21 Jan 2019
        07:12:19 -0800 (PST)")
Message-ID: <xmqqpnsoe7av.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> From: Johannes Schindelin <johannes.schindelin@gmx.de>
>
> In 8abfdf44c882 (tests: explicitly use `git.exe` on Windows,
> 2018-11-14), we made sure to use the `.exe` file extension when
> using an absolute path to `git.exe`, to avoid getting confused with a
> file or directory in the same place that lacks said file extension.
>
> For the same reason, we need to handle test-tool.exe the same way.
>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>  t/test-lib.sh | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/t/test-lib.sh b/t/test-lib.sh
> index a1abb1177a..9876b4bab0 100644
> --- a/t/test-lib.sh
> +++ b/t/test-lib.sh
> @@ -1154,7 +1154,7 @@ test -d "$GIT_BUILD_DIR"/templates/blt || {
>  	error "You haven't built things yet, have you?"
>  }
>  
> -if ! test -x "$GIT_BUILD_DIR"/t/helper/test-tool
> +if ! test -x "$GIT_BUILD_DIR"/t/helper/test-tool$X
>  then
>  	echo >&2 'You need to build test-tool:'
>  	echo >&2 'Run "make t/helper/test-tool" in the source (toplevel) directory'

Thanks for being thorough.  Will queue.
