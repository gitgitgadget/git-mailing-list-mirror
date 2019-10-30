Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9A2021F4C0
	for <e@80x24.org>; Wed, 30 Oct 2019 10:11:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726073AbfJ3KLM (ORCPT <rfc822;e@80x24.org>);
        Wed, 30 Oct 2019 06:11:12 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:36359 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726046AbfJ3KLM (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Oct 2019 06:11:12 -0400
Received: by mail-wm1-f67.google.com with SMTP id c22so1463361wmd.1
        for <git@vger.kernel.org>; Wed, 30 Oct 2019 03:11:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=reply-to:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=hqKs1TUmLYfRJ9hMy6b8Hv4oPf4C84Mducxj5krLfLQ=;
        b=WMy+Lu+/OeEGrrIlqEl+0GnoX2FVCGEcQ6O1SZH+myBWBey5bP+guc5sauAxEeOj5f
         iXMt0iCVBw5IAhf6bj4h2gbJ+1SK5k+VRQiaKaI1WfgwQvoCGz/eH6knSuedD2HhapFl
         Abvu1SOpE4F3To9GwVpc31NT84J3hIPDzcAnXT3Mm8px7rcLNgQZg1mRIiE8IFWzDkc2
         D+NplTKp/mTE35WiVNhKAqG2L3CqZzvV1aI5z6k8OJKCQKrKYz+I39H1OKPIErnb8vgk
         N8x+7v5qgvqJk26ARCaFfkVmJk8LsQGdaviS1nxoNxDSkHBjT2q+FHQRgY2IBv1AD+zp
         rWLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:subject:to:cc:references:from
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=hqKs1TUmLYfRJ9hMy6b8Hv4oPf4C84Mducxj5krLfLQ=;
        b=TtkCom1eroGF+AOeS2/eK4C9n+NP38uFvmOz0t3ltgkSmLQMYnBIh0QNlKcky2YTsM
         W7cAZHhVX7Qp86D8uEeq5SISh54wSbv1y47S8h1GNY5+NXnzwavFvAKKwRbsBaoDqjdd
         QsFRex/U1K/6LAE4fsUx9C0GBd0A1SIuha7fyuqEbqqlHSlGyu6c143xwQ6U0mUOuTRJ
         6c7ZYUf8pEK88wRTh8yKVqkzsFKia31LBKUR1SXeseK1JM8Kzf2kSnerelcrsEXofVbn
         oCGHXnORzQQsOSeZLpZL3NVm/5XvBI9jetwbA8Z6r6T45/mqBWwdmdl1eRUFz3nhbmNU
         XtnA==
X-Gm-Message-State: APjAAAWRq6nymRoa/LNZIKSIVDG62+n4hpPFwjphdwfmi6DwWOqHufZg
        ABflETkuKW48QvEkYaI3zog=
X-Google-Smtp-Source: APXvYqy2VdzuvfLqrJBQSbsXglLOmej9KKBBM0ODOt573mU9rvTUzn3/t6C37WgwaHKheiyeEBIqpA==
X-Received: by 2002:a7b:cc0c:: with SMTP id f12mr8089088wmh.40.1572430270099;
        Wed, 30 Oct 2019 03:11:10 -0700 (PDT)
Received: from [192.168.2.240] (host-92-22-20-250.as13285.net. [92.22.20.250])
        by smtp.gmail.com with ESMTPSA id r13sm2439662wra.74.2019.10.30.03.11.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Oct 2019 03:11:09 -0700 (PDT)
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v2] git-diff.txt: document return code of `--no-index`
To:     Denton Liu <liu.denton@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>
References: <3f6d132663cacde01df68bfe88c6ef108cf6cf74.1572337045.git.liu.denton@gmail.com>
 <ed9f16c30a0f3852abaf0053d8c2b4a0ecd12f01.1572367897.git.liu.denton@gmail.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
Message-ID: <4548d037-3fc5-b625-b7f9-646392392d0c@gmail.com>
Date:   Wed, 30 Oct 2019 10:11:08 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <ed9f16c30a0f3852abaf0053d8c2b4a0ecd12f01.1572367897.git.liu.denton@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB-large
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Denton

The description is good, but the patch has a typo

On 29/10/2019 16:54, Denton Liu wrote:
> Within diff_no_index(), we have the following:
> 
> 	revs->diffopt.flags.exit_with_status = 1;
> 
> 	...
> 
> 	/*
> 	 * The return code for --no-index imitates diff(1):
> 	 * 0 = no changes, 1 = changes, else error
> 	 */
> 	return diff_result_code(&revs->diffopt, 0);
> 
> Which means when `git diff` is run in `--no-index` mode, `--exit-code`
> is implied. However, the documentation for this is missing in
> git-diff.txt.
> 
> Add a note about how `--exit-code` is implied in the `--no-index`
> documentation to cover this documentation blindspot.
> 
> Signed-off-by: Denton Liu <liu.denton@gmail.com>
> ---
> Thanks for the review, Dscho. I guess it slipped my mind that we could
> write it this way too. Oops!
> 
>   Documentation/git-diff.txt | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/git-diff.txt b/Documentation/git-diff.txt
> index 72179d993c..56b396ef81 100644
> --- a/Documentation/git-diff.txt
> +++ b/Documentation/git-diff.txt
> @@ -36,7 +36,7 @@ two blob objects, or changes between two files on disk.
>   	running the command in a working tree controlled by Git and
>   	at least one of the paths points outside the working tree,
>   	or when running the command outside a working tree
> -	controlled by Git.
> +	controlled by Git. This form implies `--no-exit`.

s/--no-exit/--exit-code/

Best Wishes

Phillip

>   
>   'git diff' [<options>] --cached [<commit>] [--] [<path>...]::
>   
> 
