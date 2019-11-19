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
	by dcvr.yhbt.net (Postfix) with ESMTP id 2C3BE1F4B5
	for <e@80x24.org>; Tue, 19 Nov 2019 15:46:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728194AbfKSPqr (ORCPT <rfc822;e@80x24.org>);
        Tue, 19 Nov 2019 10:46:47 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:52156 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728474AbfKSPqq (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Nov 2019 10:46:46 -0500
Received: by mail-wm1-f68.google.com with SMTP id q70so3716303wme.1
        for <git@vger.kernel.org>; Tue, 19 Nov 2019 07:46:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=K3AQ+tD9TiaoLsQKbGQiz/wFblCijmoCwGwB21Gn6sg=;
        b=e0R4DHtwLVaEhAOVfaHUeayv3AE0bT6+mT0k34sP2zu4c+43WJtPr+NV0ik4uEb1AV
         4L+E5HyLanLKTT/xsBNmIZtva5MIW+lmdhFE7a2prcQhwwdryKvP4nYQvGFEbijlmEFO
         N2XsaPbVueS7Rm3hF77r9wsXPdc4FhqKy8fxP5Bf6euABD7AF9oieLsWojjKaGmuurmZ
         RcTv7FVt3KXadoMdGLK92jRNAercsEsev19iLJPs1DqnfEfN0Z6BGyTsEiB6s5TfSSIQ
         iPuaUwLAJkA8YXGvLf7NHIyoZ8rTrHugCU6hIxFlBj/y88nieI9pORXpybH33gFuwO3c
         8cWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=K3AQ+tD9TiaoLsQKbGQiz/wFblCijmoCwGwB21Gn6sg=;
        b=DxIjGia+YNMzKlwG/nR8eQNaHt6tXkeKMomCYNPShMFcWGrP5J4HHz4B6BelMJgnsM
         kcUfrVNOx3z7QUWUxub9Xfz0pjreMzSTcaWTrG/dWDOxrEFJ1xV6UyFS+HkFgVP7+5f2
         +rncLjirks0Zvj8OvllT06JASULKZAbNMq78n5eh7wf6UqxCiG3NZTXeiuBH8FX+yH5R
         Dqwm7HOQ5SZbLX9m6GVS0VdgnGRfzXiuUMA6nGGC4KvNEMF+xmBQE3I/4WNY6IC/XD8k
         OAOmqABfG2M0jQ7mZysHXXaGDpJSQ5cZHC2feNJwlHrVqSnRHbX2Bpip0e1CSd6UB6li
         k/qQ==
X-Gm-Message-State: APjAAAWIZfkdo+aXSbpRj0dq26Se3y0Pulpjhi6Qf6awjKx23QekT8Op
        3rbBUwgm5KjUNxYq7+f7AVc=
X-Google-Smtp-Source: APXvYqyOrICkLi8ceOLMG27wxLaTeMbMiMu68nT5vchDReoxhVZqDMarc3wqLhyTPkXe3EBjmdsveg==
X-Received: by 2002:a1c:7519:: with SMTP id o25mr6288699wmc.70.1574178403231;
        Tue, 19 Nov 2019 07:46:43 -0800 (PST)
Received: from szeder.dev (x4d0c2755.dyn.telefonica.de. [77.12.39.85])
        by smtp.gmail.com with ESMTPSA id o81sm3540598wmb.38.2019.11.19.07.46.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 19 Nov 2019 07:46:42 -0800 (PST)
Date:   Tue, 19 Nov 2019 16:46:40 +0100
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, newren@gmail.com, jon@jonsimons.org,
        Derrick Stolee <dstolee@microsoft.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v5 04/17] sparse-checkout: 'set' subcommand
Message-ID: <20191119154640.GG23183@szeder.dev>
References: <pull.316.v4.git.1571147764.gitgitgadget@gmail.com>
 <pull.316.v5.git.1571666186.gitgitgadget@gmail.com>
 <7d9d66a89f473244af3601e13caa713d929a202d.1571666186.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <7d9d66a89f473244af3601e13caa713d929a202d.1571666186.git.gitgitgadget@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Oct 21, 2019 at 01:56:13PM +0000, Derrick Stolee via GitGitGadget wrote:
> From: Derrick Stolee <dstolee@microsoft.com>
> 
> The 'git sparse-checkout set' subcommand takes a list of patterns
> as arguments and writes them to the sparse-checkout file. Then, it
> updates the working directory using 'git read-tree -mu HEAD'.
> 
> The 'set' subcommand will replace the entire contents of the
> sparse-checkout file. The write_patterns_and_update() method is
> extracted from cmd_sparse_checkout() to make it easier to implement
> 'add' and/or 'remove' subcommands in the future.

Yeah, an 'add' subcommand would be great, because 'set' throwing away
all the existing patterns can lead to some frustration:

  # Let's clone with sparse checkout
  $ git clone --sparse ...
  $ cd clone
  $ less README
  $ git sparse-checkout '/some/dir/*'
  # Erm, what was the next step?
  $ less README
  README: No such file or directory
  # Uhoh.

Having said that, being forced to use 'git sparse-checkout set' and
specify all patterns at once does have its own benefits: I needed like
6 subdirectories to build that subset of a big project that I was
interested in, and now all the necessary patterns are saved in my Bash
history, and I will be able to easily dig out the complete command in
the future.  That wouldn't work with using the 'add' subcommand to add
one pattern at a time.

> diff --git a/t/t1091-sparse-checkout-builtin.sh b/t/t1091-sparse-checkout-builtin.sh
> index cb74715ca6..bf2dc55bb1 100755
> --- a/t/t1091-sparse-checkout-builtin.sh
> +++ b/t/t1091-sparse-checkout-builtin.sh
> @@ -96,4 +96,36 @@ test_expect_success 'clone --sparse' '
>  	test_cmp expect dir
>  '
>  
> +test_expect_success 'set enables config' '
> +	git init empty-config &&
> +	(
> +		cd empty-config &&
> +		test_commit test file &&
> +		test_path_is_missing .git/config.worktree &&
> +		test_must_fail git sparse-checkout set nothing &&

This command prints the same error message twice:

  + test_must_fail git sparse-checkout set nothing
  error: Sparse checkout leaves no entry on working directory
  error: Sparse checkout leaves no entry on working directory


> +		test_i18ngrep "sparseCheckout = false" .git/config.worktree &&

The contents of a configuration file surely can't ever be translated,
can it?!

Please use 'test_cmp_config'.

> +		git sparse-checkout set "/*" &&
> +		test_i18ngrep "sparseCheckout = true" .git/config.worktree
> +	)
> +'
> +
> +test_expect_success 'set sparse-checkout using builtin' '
> +	git -C repo sparse-checkout set "/*" "!/*/" "*folder*" &&
> +	cat >expect <<-EOF &&
> +		/*
> +		!/*/
> +		*folder*
> +	EOF
> +	git -C repo sparse-checkout list >actual &&
> +	test_cmp expect actual &&
> +	test_cmp expect repo/.git/info/sparse-checkout &&
> +	ls repo >dir  &&
> +	cat >expect <<-EOF &&
> +		a
> +		folder1
> +		folder2
> +	EOF
> +	test_cmp expect dir
> +'
> +
>  test_done
> -- 
> gitgitgadget
> 
