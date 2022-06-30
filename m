Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D45E3C43334
	for <git@archiver.kernel.org>; Thu, 30 Jun 2022 09:34:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234045AbiF3JeP (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 30 Jun 2022 05:34:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234111AbiF3JeM (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Jun 2022 05:34:12 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFBB442EE6
        for <git@vger.kernel.org>; Thu, 30 Jun 2022 02:34:05 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id h23so37753364ejj.12
        for <git@vger.kernel.org>; Thu, 30 Jun 2022 02:34:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:reply-to:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=8Z5gXVfCj4NOcqk4rVEJD6a85bwvxT7lHBeoVIsByR8=;
        b=IKkN7tWC+f6JrRakxZ8ATW88uVDJ2sGyUU63V/PtGMPqAbMTfY7n819/kTbBmgJxqQ
         yN1XNDWZAF3akVsKPlYztC74iQYHbe9N0yJVZR8DARBpp+z54QUkeicxDa9I/6e4TdJ9
         LMKEgjv8Xqhrz7mW5fDeUZL6sN1MnfM+78oxXairJlALuGZPGPGIlY+9bg/Uz67uy8iX
         IA0PA79MGMjFDNjJO6S0u+/adZNykCNtJWv8qXFe8en1rZscNdTvnR2BFUzpwRfYdb3T
         Y57bPET8GWkxmliP73Ojr1ZPMshvFHuRB9CFKk612qnMHWQRs7zugzeTvmwzoMKeglKE
         7+kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:reply-to
         :subject:content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=8Z5gXVfCj4NOcqk4rVEJD6a85bwvxT7lHBeoVIsByR8=;
        b=auZq+5NN9WBjNxUfrS7BKyaxLqWvuQ5ZmYrVQspkhAXq1GlY6qYrgmgF2n4C2B4Aqe
         kTrNuRSKz93xw15FocSUUB9QpEDClcy1M/0+VZ4zo7kPpLQ4Vx1FqLVt3J/iA122PQjm
         2BMSSDouoY5hqZ6zax7BMxDcCJWPypN1DQG0tZqUukV4XtWgX3zXIeQPusPLJP6hKsFB
         6GEE/bkGNGr/7sWB4ucwa4AWAnAVy5woKu8mnsfjulY4mRQpsVtO9IulFtpqIoxAigXL
         m56NoP9SIYYq932rssZgqZ63PYpHWinqQP8qv9ArxFHpRMP8iP+/uJRjgU69Wx9DGwng
         sjow==
X-Gm-Message-State: AJIora/aWvcsQP6Us7xCPn1oqtahoa22CaZCr7xDLMvHHB9TEKOz21s6
        4/dSbUebZDNApE+SKow2VrU=
X-Google-Smtp-Source: AGRyM1uEk1Uf0rBdflptrTQIc8tz7+EBpSgCcRnr4pEaBrTC9vFVaBTQQ1MYuzCOH6KGMe2AvohUnw==
X-Received: by 2002:a17:907:97d0:b0:726:ccd3:1757 with SMTP id js16-20020a17090797d000b00726ccd31757mr7898099ejc.399.1656581644349;
        Thu, 30 Jun 2022 02:34:04 -0700 (PDT)
Received: from [192.168.1.201] ([31.185.185.192])
        by smtp.googlemail.com with ESMTPSA id b3-20020a17090636c300b00726b8e84c1asm4325757ejc.21.2022.06.30.02.34.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Jun 2022 02:34:04 -0700 (PDT)
Message-ID: <d6ea65f5-3aa5-aa8c-dad1-a8f36d56b07b@gmail.com>
Date:   Thu, 30 Jun 2022 10:34:02 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v3 3/8] rebase-interactive: update 'merge' description
Content-Language: en-US
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     gitster@pobox.com, johannes.schindelin@gmx.de, me@ttaylorr.com,
        Jeff Hostetler <git@jeffhostetler.com>,
        Elijah Newren <newren@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>
References: <pull.1247.v2.git.1654634569.gitgitgadget@gmail.com>
 <pull.1247.v3.git.1656422759.gitgitgadget@gmail.com>
 <669f4abd59e7dbb13281e85144d085180934fd15.1656422759.git.gitgitgadget@gmail.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <669f4abd59e7dbb13281e85144d085180934fd15.1656422759.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 28/06/2022 14:25, Derrick Stolee via GitGitGadget wrote:
> From: Derrick Stolee <derrickstolee@github.com>
> 
> The 'merge' command description for the todo list documentation in an
> interactive rebase has multiple lines. The lines other than the first
> one start with dots ('.') while the similar multi-line documentation for
> 'fixup' does not.
> 
> The 'merge' command was documented when interactive rebase was first
> ported to C in 145e05ac44b (rebase -i: rewrite append_todo_help() in C,
> 2018-08-10). These dots might have been carried over from the previous
> shell implementation.
> 
> The 'fixup' command was documented more recently in 9e3cebd97cb (rebase
> -i: add fixup [-C | -c] command, 2021-01-29).
> 
> Looking at the output in an editor, my personal opinion is that the dots
> are unnecessary and noisy. Remove them now before adding more commands
> with multi-line documentation.

I agree, this is a nice cleanup

Thanks

Phillip

> Signed-off-by: Derrick Stolee <derrickstolee@github.com>
> ---
>   rebase-interactive.c | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/rebase-interactive.c b/rebase-interactive.c
> index 87649d0c016..22394224faa 100644
> --- a/rebase-interactive.c
> +++ b/rebase-interactive.c
> @@ -54,9 +54,9 @@ void append_todo_help(int command_count,
>   "l, label <label> = label current HEAD with a name\n"
>   "t, reset <label> = reset HEAD to a label\n"
>   "m, merge [-C <commit> | -c <commit>] <label> [# <oneline>]\n"
> -".       create a merge commit using the original merge commit's\n"
> -".       message (or the oneline, if no original merge commit was\n"
> -".       specified); use -c <commit> to reword the commit message\n"
> +"        create a merge commit using the original merge commit's\n"
> +"        message (or the oneline, if no original merge commit was\n"
> +"        specified); use -c <commit> to reword the commit message\n"
>   "\n"
>   "These lines can be re-ordered; they are executed from top to bottom.\n");
>   	unsigned edit_todo = !(shortrevisions && shortonto);

