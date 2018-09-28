Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 300DB1F453
	for <e@80x24.org>; Fri, 28 Sep 2018 00:26:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727524AbeI1Gr2 (ORCPT <rfc822;e@80x24.org>);
        Fri, 28 Sep 2018 02:47:28 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:34683 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725924AbeI1Gr2 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Sep 2018 02:47:28 -0400
Received: by mail-wr1-f65.google.com with SMTP id z4-v6so3095754wrb.1
        for <git@vger.kernel.org>; Thu, 27 Sep 2018 17:26:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=mWR/9KMm1Ww7a5hfrCClclXXZB7DM2sKTf93dJC00iA=;
        b=MwEJIiU5h8tse46BWwV5kDEtRBsEHM/nt6gSF54ykyNnGGSLSwPGzpG5B6DTgLLeJ1
         maElazydYIO5QAyP0mtEVgZYFWyVAqY31nsEH8j0KECQVVikiQrAuRLHjCIXYyvtzun1
         tpUycoSaI6LXVs3TVJ8b3hjzJeyRZ2MdHFv15JP9Dy404nsNFouFpY797VrslTEHUNkf
         WQnJkjmeHxR/OYfuR0reJ4QGs08aG9yymIC0wkI1/DTQkOyO0GM1F8hnS+zFHDcWlm3K
         Dmrmgcva3nMRE7QAOue2OxRYnJusKbBwyRQsTXiLkfTMtkcpl/Fjw66As2z70hum/vwn
         1Z0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=mWR/9KMm1Ww7a5hfrCClclXXZB7DM2sKTf93dJC00iA=;
        b=U5sAoll3tUAhtdgIhoCUuT9x50C2C4LRKzlCtCya+CF4oM7nFlc93CGO1oLEH3JoWV
         4ZUYCP3/ijb22wFqYV2CmKTLEsrX5GZQa9nxUVZ3Tx73srg/iWlPAAKDubWe22EHp9BS
         7V5f3Uxs3k9LpbDNzJHqP+U1GN9PKYTO8YE0eSeJYoLGKtKRBI3JJD9/XxsqZwToJUlE
         Pe0IIhzdHUiYUGhxN9g0e8xxRwL3o3svBwfSpBE27YuvO3zyNtTZycOCleXDjNiCVJXf
         W7FRg9VB51PAFP3wT7Uver2nQvcsUkn7B8fg2jxWjZKugg6MmxYA/TlWAqmc+hAyzo6B
         GNkg==
X-Gm-Message-State: ABuFfoiSF0DRhOPnfqU5PofUn8Jr6gxZYZ7u2NIu1B0CeBcWSFandEsD
        9GEXxZyheCy8Xc4Oht2vQ0Q=
X-Google-Smtp-Source: ACcGV607gdBGMqIRijWbK+fWDFypCUrP7GPa60ZjjBg1BWh1m+AC8Wi2Z5PUuRJ7Q1RhqGEvf9WPvQ==
X-Received: by 2002:adf:f111:: with SMTP id r17-v6mr2367364wro.303.1538094390695;
        Thu, 27 Sep 2018 17:26:30 -0700 (PDT)
Received: from localhost (x4dbd8656.dyn.telefonica.de. [77.189.134.86])
        by smtp.gmail.com with ESMTPSA id i4-v6sm5979546wrs.87.2018.09.27.17.26.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 27 Sep 2018 17:26:29 -0700 (PDT)
Date:   Fri, 28 Sep 2018 02:26:27 +0200
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Ben Peart <peartben@gmail.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, pclouds@gmail.com,
        Ben Peart <benpeart@microsoft.com>,
        Ben Peart <Ben.Peart@microsoft.com>
Subject: Re: [PATCH v6 4/7] config: add new index.threads config setting
Message-ID: <20180928002627.GO27036@localhost>
References: <20180823154053.20212-1-benpeart@microsoft.com>
 <20180926195442.1380-1-benpeart@microsoft.com>
 <20180926195442.1380-5-benpeart@microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180926195442.1380-5-benpeart@microsoft.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Sep 26, 2018 at 03:54:39PM -0400, Ben Peart wrote:
> Add support for a new index.threads config setting which will be used to
> control the threading code in do_read_index().  A value of 0 will tell the
> index code to automatically determine the correct number of threads to use.
> A value of 1 will make the code single threaded.  A value greater than 1
> will set the maximum number of threads to use.
> 
> For testing purposes, this setting can be overwritten by setting the
> GIT_TEST_INDEX_THREADS=<n> environment variable to a value greater than 0.
> 
> Signed-off-by: Ben Peart <Ben.Peart@microsoft.com>
> ---

> diff --git a/t/README b/t/README
> index aa33ac4f26..0fcecf4500 100644
> --- a/t/README
> +++ b/t/README
> @@ -332,6 +332,11 @@ This is used to allow tests 1, 4-9 in t1700-split-index.sh to succeed
>  as they currently hard code SHA values for the index which are no longer
>  valid due to the addition of the EOIE extension.
>  
> +GIT_TEST_INDEX_THREADS=<n> enables exercising the multi-threaded loading
> +of the index for the whole test suite by bypassing the default number of
> +cache entries and thread minimums. Settting this to 1 will make the

s/ttt/tt/

> +index loading single threaded.
> +
>  Naming Tests
>  ------------
>  
> diff --git a/t/t1700-split-index.sh b/t/t1700-split-index.sh
> index 1f168378c8..ab205954cf 100755
> --- a/t/t1700-split-index.sh
> +++ b/t/t1700-split-index.sh
> @@ -8,6 +8,7 @@ test_description='split index mode tests'
>  sane_unset GIT_TEST_SPLIT_INDEX
>  sane_unset GIT_FSMONITOR_TEST
>  GIT_TEST_DISABLE_EOIE=true; export GIT_TEST_DISABLE_EOIE
> +GIT_TEST_INDEX_THREADS=1; export GIT_TEST_INDEX_THREADS

Why does multithreading have to be disabled in this test?

>  test_expect_success 'enable split index' '
>  	git config splitIndex.maxPercentChange 100 &&
> -- 
> 2.18.0.windows.1
> 
