Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 82BD91F404
	for <e@80x24.org>; Mon, 26 Feb 2018 17:08:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751661AbeBZRIX (ORCPT <rfc822;e@80x24.org>);
        Mon, 26 Feb 2018 12:08:23 -0500
Received: from mail-qk0-f196.google.com ([209.85.220.196]:32905 "EHLO
        mail-qk0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751637AbeBZRIW (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Feb 2018 12:08:22 -0500
Received: by mail-qk0-f196.google.com with SMTP id f25so19932556qkm.0
        for <git@vger.kernel.org>; Mon, 26 Feb 2018 09:08:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=I4Ssfw/ikzokWYzJ2qgwE3yJsq/OF46SkmTZ7rTz+Ek=;
        b=GYhiMeWxIBpej/JSyjvKA5vZVtizYmPO9OUKDEfRZXhKUWcUEZbUotngGesnExwt3x
         vxzOGAutE1DKkcEWFhJjLAa9qpvAOQlCnpPlTXOqGhqrOUgKEVXi76kLGHjkFF0kiFSv
         NvDEI8j8tNWLewp4KM62OoBu9zF7s4CY3Vo5cwNP1bGeO8+B0cbX5dKJf7JI/hCFWyaI
         /khuXQuq/V0qnlxAbwKEd0zqhzm9Z7LTnBYe+juVV0B1KaaPgnPUquTN6JLKTlagN3H7
         36OFxv+IK/UqYNH5yo32bLoy8eJ2BO226xSVbopl3ZiVyZImt+q0DrzncZv0eiHMr0ww
         tlBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=I4Ssfw/ikzokWYzJ2qgwE3yJsq/OF46SkmTZ7rTz+Ek=;
        b=sFHrAmIPMTbDzXjexMeYLGBTCdlT8u+Cq/qEw4DcqjAOJKaDyiWW41SrKmybSq4h5V
         SOGmQdD9R5nFy6Onvl+/PvhJePPhBiqbs9IX2yFOEDbgq9vWxODvXkyDyiu+3DssJAic
         HpMucRTp3EWFMgA8/bzgAmTKfVro2wVDWUvhUX81mou49SIriuj3LIAuStEjA8IFNbby
         FBAY/ATkjpt4qv8IFS+ky+viMNzn4dnS118VZvuHSW/SFfeXCG/d2UvJospgWx5LAkmr
         tupQD1u0tcofYWwHkqOj3Of0BS+Uggw+Ltn2svPGxDkAK8WsnCqv0tDjZXXTD2tPVF/D
         yk2g==
X-Gm-Message-State: APf1xPAFT0rYlxGgXebFAQYR+oBBczb/EaNKr/v3iMWJ23rXnN5vRKur
        QEp0Kh+/2i5yiW3/q7aYZpw=
X-Google-Smtp-Source: AG47ELulTOizt/N/iMCm3THlKHETAK10rtwTTPddUVi1Ncs62+VQ8eVyQEaMuJM+/c7YlEnWTLulKA==
X-Received: by 10.55.146.7 with SMTP id u7mr18228848qkd.0.1519664901309;
        Mon, 26 Feb 2018 09:08:21 -0800 (PST)
Received: from ?IPv6:2001:4898:6808:13e:c4e6:7a22:56f1:df04? ([2001:4898:8010:0:ae1c:7a22:56f1:df04])
        by smtp.gmail.com with ESMTPSA id z9sm5653896qtb.49.2018.02.26.09.08.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 26 Feb 2018 09:08:20 -0800 (PST)
Subject: Re: [PATCH v4 03/13] commit-graph: create git-commit-graph builtin
To:     =?UTF-8?Q?SZEDER_G=c3=a1bor?= <szeder.dev@gmail.com>
Cc:     git@vger.kernel.org, git@jeffhostetler.com, peff@peff.net,
        jonathantanmy@google.com, sbeller@google.com, gitster@pobox.com,
        Derrick Stolee <dstolee@microsoft.com>
References: <20180226162539.7463-1-szeder.dev@gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <755dead9-17fc-4735-99d2-d3f2dcb102ae@gmail.com>
Date:   Mon, 26 Feb 2018 12:08:19 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180226162539.7463-1-szeder.dev@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2/26/2018 11:25 AM, SZEDER Gábor wrote:
>> Teach git the 'commit-graph' builtin that will be used for writing and
>> reading packed graph files. The current implementation is mostly
>> empty, except for an '--object-dir' option.
> Since 'git commit-graph' is a builtin command, it shouldn't show up in
> completion when doing 'git co<TAB>'.
> Please squash in the patch below to make it so.
>
> Furthermore, please have a look at
>    
>    https://public-inbox.org/git/20180202160132.31550-1-szeder.dev@gmail.com/
>
> for an other oneliner change.
>
>
> diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
> index 17929b0809..fafed13c06 100644
> --- a/contrib/completion/git-completion.bash
> +++ b/contrib/completion/git-completion.bash
> @@ -841,6 +841,7 @@ __git_list_porcelain_commands ()
>   		check-ref-format) : plumbing;;
>   		checkout-index)   : plumbing;;
>   		column)           : internal helper;;
> +		commit-graph)     : plumbing;;
>   		commit-tree)      : plumbing;;
>   		count-objects)    : infrequent;;
>   		credential)       : credentials;;

Thanks for this, and the reminder. I made these changes locally, so they 
will be in v5.

-Stolee
