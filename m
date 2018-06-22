Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F0FC51F516
	for <e@80x24.org>; Fri, 22 Jun 2018 08:17:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751183AbeFVIRW (ORCPT <rfc822;e@80x24.org>);
        Fri, 22 Jun 2018 04:17:22 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:55313 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750934AbeFVIRU (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Jun 2018 04:17:20 -0400
Received: by mail-wm0-f66.google.com with SMTP id v16-v6so1274097wmh.5
        for <git@vger.kernel.org>; Fri, 22 Jun 2018 01:17:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Z4OnyyFibha38DT1arDzUO99f94hBFmYop3F8eAMNi4=;
        b=tqMAqogGrBTg4AdKOoPGt2I2rglsqeqY7hswT5cH32PD3i8kjo6M9fhX0hJ0H6hGWF
         B8dx16X4ppEqWQIfXPXpB4P4yT5vb2Y2pGkxUkl3/dX4vn644kCHhoU3DyEvhmtaH6Ur
         E1qgDS5QZZ7Tum0XUz/5g9msFD5rmcljTKupCniIYVSgbHQPwoUKdjjkVBLO53TXcSGs
         XQXAPW7A9QfroKWXtmZYaZn7IjahIsh87nAIJnk22fEIJkeyIwYJl1bs5kk7T3E6S1Jx
         nOdGMV5XKl81gMmdjV1R2V8ovW8SEnVuJgSNLiXoyma9+aVH9L2oboRVsDDAgyskwTht
         Ghzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Z4OnyyFibha38DT1arDzUO99f94hBFmYop3F8eAMNi4=;
        b=lwAcmiaNPHS5q8IuLUutuzO7PW/5AJwIhXm4gL1bAHlX/a2c6YCWohS2F4v4oLsEJf
         6jeH+zxlRKU6q+Zv7EUmamfQSYYQbnqVlz+G3z1Ox8V0XHbWJvGn39uAvVgfjjMg67Ci
         N/pNmXkvPpzMdIByxtZRux7MFhZT6WtkNVB/O2HMMm6Q9NvXsrcwXyVGhNPD7uGlaYGB
         C8KyKbuV3ZUVCz9iCSBnfh/4mfIkELYPbkcdmis7/eCgVOah4fzeE2+JVBDRUxSSeQ5k
         WSAviOC4HsAr0kPtfBEGmHBfrrt2mu2wt+WEl55eC9nZIOTPJZzIseNcv29/6L5jTFCe
         LSMA==
X-Gm-Message-State: APt69E221kyvIJe5zcUo/0BNmTQf7+pacL3ZJFg87Aj8OGmCqTlIQICi
        bTYQJwJ9W/9GhBFeMrv7okc=
X-Google-Smtp-Source: ADUXVKIz020luILgfVRnVE2/ARzGGUrsqdyROfI1YDJHtjY1MsNazVbMvqhJjHEBeXXfgZKQJA5ZUA==
X-Received: by 2002:a1c:4adb:: with SMTP id n88-v6mr891352wmi.121.1529655439094;
        Fri, 22 Jun 2018 01:17:19 -0700 (PDT)
Received: from localhost.localdomain (x590cf49f.dyn.telefonica.de. [89.12.244.159])
        by smtp.gmail.com with ESMTPSA id t124-v6sm930444wmt.29.2018.06.22.01.17.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 22 Jun 2018 01:17:18 -0700 (PDT)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH] submodule.c: report the submodule that an error occurs in
Date:   Fri, 22 Jun 2018 10:17:13 +0200
Message-Id: <20180622081713.5360-1-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.18.0.171.g58aaabc06c
In-Reply-To: <20180620223253.226092-1-sbeller@google.com>
References: <20180620223253.226092-1-sbeller@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


> When an error occurs in updating the working tree of a submodule in
> submodule_move_head, tell the user which submodule the error occurred in.
> 
> The call to read-tree contains a super-prefix, such that the read-tree
> will correctly report any path related issues, but some error messages
> do not contain a path, for example:
> 
>   ~/gerrit$ git checkout --recurse-submodules origin/master
>   ~/gerrit$ fatal: failed to unpack tree object 07672f31880ba80300b38492df9d0acfcd6ee00a
> 
> Give the hint which submodule has a problem.
> 
> Signed-off-by: Stefan Beller <sbeller@google.com>
> ---
>  submodule.c               | 2 +-
>  t/lib-submodule-update.sh | 3 ++-
>  2 files changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/submodule.c b/submodule.c
> index 939d6870ecd..ebd092a14fd 100644
> --- a/submodule.c
> +++ b/submodule.c
> @@ -1668,7 +1668,7 @@ int submodule_move_head(const char *path,
>  	argv_array_push(&cp.args, new_head ? new_head : empty_tree_oid_hex());
>  
>  	if (run_command(&cp)) {
> -		ret = -1;
> +		ret = error(_("Submodule '%s' could not be updated."), path);

This is a translated error message ...

>  		goto out;
>  	}
>  
> diff --git a/t/lib-submodule-update.sh b/t/lib-submodule-update.sh
> index 1f38a85371a..e27f5d8541d 100755
> --- a/t/lib-submodule-update.sh
> +++ b/t/lib-submodule-update.sh
> @@ -781,7 +781,8 @@ test_submodule_recursing_with_args_common() {
>  		(
>  			cd submodule_update &&
>  			git branch -t invalid_sub1 origin/invalid_sub1 &&
> -			test_must_fail $command invalid_sub1 &&
> +			test_must_fail $command invalid_sub1 2>err &&
> +			grep sub1 err &&

... so the test should use 'test_i18ngrep' to check it.

>  			test_superproject_content origin/add_sub1 &&
>  			test_submodule_content sub1 origin/add_sub1
>  		)
> -- 
> 2.18.0.rc2.346.g013aa6912e-goog
> 
> 
