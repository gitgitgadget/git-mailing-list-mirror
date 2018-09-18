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
	by dcvr.yhbt.net (Postfix) with ESMTP id 45AA41F453
	for <e@80x24.org>; Tue, 18 Sep 2018 18:02:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729955AbeIRXfv (ORCPT <rfc822;e@80x24.org>);
        Tue, 18 Sep 2018 19:35:51 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:44240 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728403AbeIRXfu (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Sep 2018 19:35:50 -0400
Received: by mail-wr1-f67.google.com with SMTP id v16-v6so3069636wro.11
        for <git@vger.kernel.org>; Tue, 18 Sep 2018 11:02:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=KqvnOX/L58p+p2im3FN0IDwl2MGv6LUMQOjWX4s4yZE=;
        b=aD+n0IJ/tZwovKMfLMzsAjCnJI456FFgqjGKwIvHBBmVMFYtsFC0iaMqKCl4K26kDH
         TchhrNOfsEz31SlH4DeAAO6QtNCdzEfgf467JxPVMsYVkILFRicJ6ax7Yne2N5tPmjs7
         vZtHU4ygB9yzFW5K7YG+sbVs2nsT6L4C2QWKNPOsiaPNloiFI1RIT9MGc8Q4qzwa02RP
         aTDmRT/X7qce4EfZ6DfX/qHlXYeiq9bCu3QzOY9Ec4zzqzZekRPmyY1OzVkITNZro78z
         rUrrbX0ilKH3Ub8K9ggF1rQEE9nnPjZiurobFBfNgStOvDowmgjP8aTDumRFz499boT9
         nt5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=KqvnOX/L58p+p2im3FN0IDwl2MGv6LUMQOjWX4s4yZE=;
        b=I5bhzfxZmgtx0HYlbyI2lUsZ+Yfv158DSQUwc/j0+kEe/dwfKoZA13iauvUztva+X7
         rR0KU5FUhtv+kGuZW4mElX4m7hWGpNu6ju6z/iBtJQpi4YRFo82qla4IncALSx+2DdAE
         g3OgGHMCXrTkDRpWgp3EzjZnmMMxAQEBtTgSvadxBUrKqb3N4rQf2SL7fle/7ndqyedu
         YD0N0U80AdjDqdSefcyEIjluC1jyLMQ2A3St5NzoRYB1gwSWGj6i/BIIJ1jpIRkYM02n
         sEcBETL9ENVkDOcjc9rL97wWZ+e9B4qZ2mSE3VQZh3yja4zFghBVcLGkkDGelK+JS8tQ
         TbtQ==
X-Gm-Message-State: APzg51Aplr1vm++jo/BxSXGVignhnM71aQBR669F0IsgryGp3S66NePo
        Gicu25TUsn36r2W8DdWUB7I=
X-Google-Smtp-Source: ANB0Vda0lpR+DZqSVOZzQhB2aUhbBgO1fI2AlUjc8Ri3nG1ssKGkyFFOk9h2j+TBoYoj1hKGSiyw9w==
X-Received: by 2002:adf:e30e:: with SMTP id b14-v6mr24109695wrj.158.1537293724766;
        Tue, 18 Sep 2018 11:02:04 -0700 (PDT)
Received: from localhost (x590dd623.dyn.telefonica.de. [89.13.214.35])
        by smtp.gmail.com with ESMTPSA id 144-v6sm3179109wma.19.2018.09.18.11.02.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 18 Sep 2018 11:02:03 -0700 (PDT)
Date:   Tue, 18 Sep 2018 20:02:00 +0200
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH v2 2/6] test-reach: add run_three_modes method
Message-ID: <20180918180200.GD27036@localhost>
References: <pull.25.git.gitgitgadget@gmail.com>
 <pull.25.v2.git.gitgitgadget@gmail.com>
 <404c9186080ecee6c1cc39a6dcd17deaaa7a620a.1537243720.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <404c9186080ecee6c1cc39a6dcd17deaaa7a620a.1537243720.git.gitgitgadget@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Sep 17, 2018 at 09:08:44PM -0700, Derrick Stolee via GitGitGadget wrote:
> From: Derrick Stolee <dstolee@microsoft.com>
> 
> The 'test_three_modes' method assumes we are using the 'test-tool
> reach' command for our test. However, we may want to use the data
> shape of our commit graph and the three modes (no commit-graph,
> full commit-graph, partial commit-graph) for other git commands.
> 
> Split test_three_modes to be a simple translation on a more general
> run_three_modes method that executes the given command and tests
> the actual output to the expected output.
> 
> While inspecting this code, I realized that the final test for
> 'commit_contains --tag' is silently dropping the '--tag' argument.
> It should be quoted to include both.

Nit: while quoting the function's arguments does fix the issue, it
leaves the tests prone to the same issue in the future.  Wouldn't it
be better to use $@ inside the function to refer to all its arguments?


> Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
> ---
>  t/t6600-test-reach.sh | 14 +++++++++-----
>  1 file changed, 9 insertions(+), 5 deletions(-)
> 
> diff --git a/t/t6600-test-reach.sh b/t/t6600-test-reach.sh
> index d139a00d1d..1b18e12a4e 100755
> --- a/t/t6600-test-reach.sh
> +++ b/t/t6600-test-reach.sh
> @@ -53,18 +53,22 @@ test_expect_success 'setup' '
>  	git config core.commitGraph true
>  '
>  
> -test_three_modes () {
> +run_three_modes () {
>  	test_when_finished rm -rf .git/objects/info/commit-graph &&
> -	test-tool reach $1 <input >actual &&
> +	$1 <input >actual &&
>  	test_cmp expect actual &&
>  	cp commit-graph-full .git/objects/info/commit-graph &&
> -	test-tool reach $1 <input >actual &&
> +	$1 <input >actual &&
>  	test_cmp expect actual &&
>  	cp commit-graph-half .git/objects/info/commit-graph &&
> -	test-tool reach $1 <input >actual &&
> +	$1 <input >actual &&
>  	test_cmp expect actual
>  }
>  
> +test_three_modes () {
> +	run_three_modes "test-tool reach $1"
> +}
> +
>  test_expect_success 'ref_newer:miss' '
>  	cat >input <<-\EOF &&
>  	A:commit-5-7
> @@ -219,7 +223,7 @@ test_expect_success 'commit_contains:hit' '
>  	EOF
>  	echo "commit_contains(_,A,X,_):1" >expect &&
>  	test_three_modes commit_contains &&
> -	test_three_modes commit_contains --tag
> +	test_three_modes "commit_contains --tag"
>  '
>  
>  test_expect_success 'commit_contains:miss' '
> -- 
> gitgitgadget
> 
