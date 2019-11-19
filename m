Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8107B1F4B5
	for <e@80x24.org>; Tue, 19 Nov 2019 17:50:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727194AbfKSRuv (ORCPT <rfc822;e@80x24.org>);
        Tue, 19 Nov 2019 12:50:51 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:51832 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727117AbfKSRuv (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Nov 2019 12:50:51 -0500
Received: by mail-wm1-f67.google.com with SMTP id q70so4174442wme.1
        for <git@vger.kernel.org>; Tue, 19 Nov 2019 09:50:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Q8HpMp7Hu6nSYHknTOO4KtRpPKhFL0td39GKKc4wCcY=;
        b=UosPhaNo5Ii0zSI9aNkFEumYLs18er3j0H9dzgNUR3nb71ygFUTgWejW9BBgc3j5Q4
         kaA9GzzZc5aEM653/1LVpo7ofANtVN2qi1K/UZrfejWV1E/smLTZqu4TsJBpCCx0AoEZ
         TuzscYWI4NXrtBrBnQgBEXI9IMCev4m9uMPpWVi9vRzk7PddV8tesFMclU0tZq44z8zc
         TZDSzYaPgbeH7/w5AS3xd8qkFVOdbc9pwlT6VNon7AtqOtDbPDpes3uI13jji4zhs2QA
         6WHKusJ+Vi8atjv7WX105fYaNnhrQ1EJ63OGREkLY9hSOEE4HS7ShSOEu1yUeYXmL2ax
         D/Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Q8HpMp7Hu6nSYHknTOO4KtRpPKhFL0td39GKKc4wCcY=;
        b=Q6ZmsbJE2VAMnDFbw5VAt/f76JCoxfYvWSjRqDfgNT2aayDYn088Iqj8B+8n1+opgz
         nfuHWNaEq9e4oAM+xJifRZzacRnDlneVKncugFdh6O5dMbjMPWEWxgXrxQPVa80OQYiU
         byc/qk9EUsC9EHHa1+62/JJr3sAcqdVHKxdH1mRAq0vX8yFSuz1k/o9EcZqwV0mLmEtA
         lDTnhqfZdqoxJZ7djlxVR6a7QQ9faGrR7F1IP4WN2XA5i18TTGt198ucC3xIJRqASzh+
         l8sew1TpFufnUTZ2CrbEMYV+BF/rNlwysNATRrGnXWUzTH4OYRYKtX7AuckMHB8JmY/b
         nRng==
X-Gm-Message-State: APjAAAWvKWQ3y/jTvFCXLS0NZOVlZgfKa8kIMlEtPQpMB7Bt7usGLa0y
        kwedOxduBuKxYRMMb9Yi0AM=
X-Google-Smtp-Source: APXvYqxtc98fPtKE0QZuWZduh3IoJqpNWJyrtvVlXvGveDmW2g4GIdb0dseiDFX3rv/9Fwsck5LUUw==
X-Received: by 2002:a05:600c:2102:: with SMTP id u2mr7246297wml.49.1574185849176;
        Tue, 19 Nov 2019 09:50:49 -0800 (PST)
Received: from szeder.dev (x4d0c2755.dyn.telefonica.de. [77.12.39.85])
        by smtp.gmail.com with ESMTPSA id v9sm27371266wrs.95.2019.11.19.09.50.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 19 Nov 2019 09:50:48 -0800 (PST)
Date:   Tue, 19 Nov 2019 18:50:46 +0100
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, newren@gmail.com, jon@jonsimons.org,
        Derrick Stolee <dstolee@microsoft.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v5 10/17] sparse-checkout: init and set in cone mode
Message-ID: <20191119175046.GK23183@szeder.dev>
References: <pull.316.v4.git.1571147764.gitgitgadget@gmail.com>
 <pull.316.v5.git.1571666186.gitgitgadget@gmail.com>
 <0258ee80265f5f27a7de9b81eaf166648b4511d4.1571666187.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <0258ee80265f5f27a7de9b81eaf166648b4511d4.1571666187.git.gitgitgadget@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Oct 21, 2019 at 01:56:19PM +0000, Derrick Stolee via GitGitGadget wrote:
> From: Derrick Stolee <dstolee@microsoft.com>
> 
> To make the cone pattern set easy to use, update the behavior of
> 'git sparse-checkout [init|set]'.
> 
> Add '--cone' flag to 'git sparse-checkout init' to set the config
> option 'core.sparseCheckoutCone=true'.

It's not necessary to run 'git sparse-checkout init' before running
'git sparse-checkout set'.  The description of the latter in the
documentation is not explicit about it, but the commit message adding
the 'set' subcommand is, and there are several test cases that run
'set' without a preceeding 'init.

Therefore, I think the 'set' subcommand should get a '--cone' option
as well.

> diff --git a/t/t1091-sparse-checkout-builtin.sh b/t/t1091-sparse-checkout-builtin.sh
> index 9907278fc1..ae99803d40 100755
> --- a/t/t1091-sparse-checkout-builtin.sh
> +++ b/t/t1091-sparse-checkout-builtin.sh
> @@ -186,4 +186,55 @@ test_expect_success 'sparse-checkout disable' '
>  	test_cmp expect dir
>  '
>  
> +test_expect_success 'cone mode: init and set' '
> +	git -C repo sparse-checkout init --cone &&
> +	git -C repo config --list >config &&
> +	test_i18ngrep "core.sparsecheckoutcone=true" config &&
> +	ls repo >dir  &&
> +	echo a >expect &&
> +	test_cmp expect dir &&
> +	git -C repo sparse-checkout set deep/deeper1/deepest/ 2>err &&
> +	test_line_count = 0 err &&

'test_must_be_empty err' would be more idiomatic here as well.

> +	ls repo >dir  &&
> +	cat >expect <<-EOF &&
> +		a
> +		deep
> +	EOF
> +	test_cmp expect dir &&
> +	ls repo/deep >dir  &&
> +	cat >expect <<-EOF &&
> +		a
> +		deeper1
> +	EOF
> +	test_cmp expect dir &&
> +	ls repo/deep/deeper1 >dir  &&
> +	cat >expect <<-EOF &&
> +		a
> +		deepest
> +	EOF
> +	test_cmp expect dir &&
> +	cat >expect <<-EOF &&
> +		/*
> +		!/*/
> +		/deep/
> +		!/deep/*/
> +		/deep/deeper1/
> +		!/deep/deeper1/*/
> +		/deep/deeper1/deepest/
> +	EOF
> +	test_cmp expect repo/.git/info/sparse-checkout &&
> +	git -C repo sparse-checkout set --stdin 2>err <<-EOF &&
> +		folder1
> +		folder2
> +	EOF
> +	test_line_count = 0 err &&
> +	cat >expect <<-EOF &&
> +		a
> +		folder1
> +		folder2
> +	EOF
> +	ls repo >dir &&
> +	test_cmp expect dir
> +'
> +
>  test_done
> -- 
> gitgitgadget
> 
