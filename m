Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6614E1F453
	for <e@80x24.org>; Tue, 29 Jan 2019 15:58:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726861AbfA2P6c (ORCPT <rfc822;e@80x24.org>);
        Tue, 29 Jan 2019 10:58:32 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:39059 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725795AbfA2P6c (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 Jan 2019 10:58:32 -0500
Received: by mail-wr1-f65.google.com with SMTP id t27so22655113wra.6
        for <git@vger.kernel.org>; Tue, 29 Jan 2019 07:58:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=eFfLAEt1MbfJl56ENz7azlcQVWHme9q+cYpiJBzvmPw=;
        b=uK3PxuRmjs9fw+g9FWAQVKAXQf3Pz0LlSjGpeLKrqxsmpn3rr1sAL+cSo8xeu3Zfpo
         xBQKYfdH/OUOvK/6fl4m2121XgttnrFS6JLqCFSqqnSKVsr4QPixT4ijBpMoS0rEhhoa
         oj5/h7hUM75wnzsqfdCfDwxjBdjaYLbGJxFL9Qj5R56Sl7RRlTL/3hIhNZB2DqanyMFz
         hLKsUh1kkRrcY/+bTRSI/h6Kr6BLcXye8kFX6/LR0ZRMz6tAJa3Y3l/4Jzrzwi2uERKh
         ecFNz1Dv4Kyt6YjpJD/3bnoXdE/nfhUxZpj9plt6cMOZD8PLYJKEN3D712ptjvhf1EsI
         SNjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=eFfLAEt1MbfJl56ENz7azlcQVWHme9q+cYpiJBzvmPw=;
        b=aAPU3VpBBZEcFhvkvA7KXS9vj2rugqDnsj96S/kkvyYVzZ0WgeHoqQXeEyJqdLSQ0J
         RousuxmsQxji34m3gB8TUlP9phQkbFiVjmi1+h6UGsXMJFhynaopOvWPZN/XkUz7fDXa
         Qiz6/QsKNKZMcdjHkUY3mCeMjZx9xivFjSQBSatUrVztrVprczICytFvOf+KiOEsxJ2F
         jRLGJAuC0nWARyLMAPLfCPoK5UjAToklPPXEOZ8pVsEkuXIbaeW8MEj1pk5VoLoy9uRu
         t6WQBfWuY4QH4VC1Oew9UZijOitINDoulSLxGAtu8jYwsAi6SuF5UvD1Q+c8gp2u9anh
         agtQ==
X-Gm-Message-State: AJcUukcSeVuyHdPloTjn0/9wqB/nKNF8LkVRGUXI4wJTW7K7bBqMyKZk
        1Pss6evnmWljhygmShJ15k8=
X-Google-Smtp-Source: ALg8bN5CigGRGJ1XtUMMNIlYn2pl46hfw+jNDsYLJrxeNwr+TruKJ8yXlSaRKn/YDTWA84VlOS3lVw==
X-Received: by 2002:a5d:448f:: with SMTP id j15mr24760083wrq.108.1548777510004;
        Tue, 29 Jan 2019 07:58:30 -0800 (PST)
Received: from szeder.dev (x4db3778b.dyn.telefonica.de. [77.179.119.139])
        by smtp.gmail.com with ESMTPSA id h13sm100819760wrp.61.2019.01.29.07.58.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 29 Jan 2019 07:58:28 -0800 (PST)
Date:   Tue, 29 Jan 2019 16:58:27 +0100
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH 1/1] Makefile: add prove and coverage-prove targets
Message-ID: <20190129155827.GC13764@szeder.dev>
References: <pull.114.git.gitgitgadget@gmail.com>
 <294187c6968eff952e78bcea808c66fbedbf1f90.1548773766.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <294187c6968eff952e78bcea808c66fbedbf1f90.1548773766.git.gitgitgadget@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jan 29, 2019 at 06:56:08AM -0800, Derrick Stolee via GitGitGadget wrote:
> When running the test suite for code coverage using
> 'make coverage-test', a single test failure stops the
> test suite from completing. This leads to significant
> undercounting of covered blocks.
> 
> Add two new targets to the Makefile:
> 
> * 'prove' runs the test suite using 'prove'.
> 
> * 'coverage-prove' compiles the source using the
>   coverage flags, then runs the test suite using
>   'prove'.
> 
> These targets are modeled after the 'test' and
> 'coverage-test' targets.

I think the cover letter would be a better commit message.

> Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
> ---
>  Makefile | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/Makefile b/Makefile
> index 1a44c811aa..ec886635ae 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -2665,6 +2665,9 @@ export TEST_NO_MALLOC_CHECK
>  test: all
>  	$(MAKE) -C t/ all
>  
> +prove: all
> +	$(MAKE) -C t/ prove
> +

You don't need this 'prove' target in the "main" Makefile, because
'make test' will run the test suite using DEFAULT_TEST_TARGET anyway.

>  perf: all
>  	$(MAKE) -C t/perf/ all
>  
> @@ -3077,6 +3080,10 @@ coverage-test: coverage-clean-results coverage-compile
>  	$(MAKE) CFLAGS="$(COVERAGE_CFLAGS)" LDFLAGS="$(COVERAGE_LDFLAGS)" \
>  		DEFAULT_TEST_TARGET=test -j1 test
>  
> +coverage-prove: coverage-clean-results coverage-compile
> +	$(MAKE) CFLAGS="$(COVERAGE_CFLAGS)" LDFLAGS="$(COVERAGE_LDFLAGS)" \
> +		DEFAULT_TEST_TARGET=prove -j1 prove

First I was wondering why do you need a dedicated 'coverage-prove'
target, instead of letting DEFAULT_TEST_TARGET from the environment or
from 'config.mak' do its thing.  But then I noticed in the hunk
context, that, for some reason, the 'coverage-test' target hardcoded
'DEFAULT_TEST_TARGET=test -j1'.  Then I was wondering why would it
want to do that, and stumbled upon commit c14cc77c11:

    coverage: set DEFAULT_TEST_TARGET to avoid using prove
    
    If the user sets DEFAULT_TEST_TARGET=prove in his config.mak, that
    carries over into the coverage tests.  Which is really bad if he also
    sets GIT_PROVE_OPTS=-j<..> as that completely breaks the coverage
    runs.
    
    Instead of attempting to mess with the GIT_PROVE_OPTS, just force the
    test target to 'test' so that we run under make, like we intended all
    along.

I'm afraid that this issue would badly affect 'coverage-prove' as well
(I didn't try).  Or if doesn't (anymore?), then that should be
mentioned in the commit message, and then perhaps it's time to remove
that '-j1' from the 'coverage-test' target as well.


