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
	by dcvr.yhbt.net (Postfix) with ESMTP id 7CA7D1F4B5
	for <e@80x24.org>; Tue, 12 Nov 2019 11:18:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727402AbfKLLSR (ORCPT <rfc822;e@80x24.org>);
        Tue, 12 Nov 2019 06:18:17 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:52314 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727345AbfKLLSO (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Nov 2019 06:18:14 -0500
Received: by mail-wm1-f67.google.com with SMTP id l1so2696316wme.2
        for <git@vger.kernel.org>; Tue, 12 Nov 2019 03:18:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=i850ajUU39PFYX0uC7iQjkO5vjf8IrCsmcKUgBTPmzg=;
        b=DAbf1oBMN9k/O5vxhWAcM920T3MC2+EfNSSgzpW15fSteDnylJ4gnYuRNEWJZgs7OY
         DlLnRbH6cGt82PsmYszefm9ONaZYo067GRVKyaGAqKQRXvyq+xTWxTXwLy82HD9BFdPR
         rTCLd7u0bcFs6Cj5kzvkPsVbxy/CnjQ1MF2wf64t3IhLfJlZ2bJsGOC5oit465xO5Imu
         5T3JmQs2h31VLdf5WnnlGqgYb8eun6u1IqA77RfW35vcXBXmNvmcK5fPmMDbCL21RGzt
         cP+5joP76RPKZjwZU/gNVwIHbzU4Fw060yPWnEIKwjCQDqr3X4fvxG2ljFs3cKuiQVEg
         QZpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=i850ajUU39PFYX0uC7iQjkO5vjf8IrCsmcKUgBTPmzg=;
        b=pkH41r4NOzToLVTkigbI1v6inH9DxeZ9/8MatJwBC/N+rEObKoNFoXgRLZv6DaE+q8
         xWq3C7dkFmmMmdhKP5XBAxNVWm8Kq+rR+8BC/Gdv7PaMMymYJKhn6zWvd+wm370/Yb1F
         PgzuVvI/vqk9Jlviclo5pSYkouyMe6vOx8aydYxdFaWdGh09dhhgIpncaQrvdNJe9/k8
         xDcIyfsTWCHWqlpUFjc7cCbCu5xSh7uzX0TaBMi/bO+6Cn9tX/Mnt/kbz8SFcEgk4HEo
         QK2scHRT/cKpeXkm4ZtNUgNtfHmvSXeA3B5FVeAu55NjdNedv2qWwiOCjWVxSGz/bL0p
         J4tw==
X-Gm-Message-State: APjAAAVVu/cRWxbuy6Xc4hOuB0tAeMqXqvDveL8R0HBl1zTiJBjkw6vu
        04V4M0TY3+181IA26L/bZYY=
X-Google-Smtp-Source: APXvYqyPLOhD+w0uZXmmh5LLcJXmPM9GYNCF4+T0UZpTDKMNMWsE4c2h0JORn3AfSjyzR2xTFLt5TQ==
X-Received: by 2002:a7b:cae2:: with SMTP id t2mr3204994wml.161.1573557492642;
        Tue, 12 Nov 2019 03:18:12 -0800 (PST)
Received: from szeder.dev (x4d0c65ae.dyn.telefonica.de. [77.12.101.174])
        by smtp.gmail.com with ESMTPSA id z6sm23556725wro.18.2019.11.12.03.18.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 12 Nov 2019 03:18:11 -0800 (PST)
Date:   Tue, 12 Nov 2019 12:18:09 +0100
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Utsav Shah via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Utsav Shah <ukshah2@illinois.edu>,
        Junio C Hamano <gitster@pobox.com>,
        Utsav Shah <utsav@dropbox.com>
Subject: Re: [PATCH 1/1] fsmonitor: skip sanity check if the index is split
Message-ID: <20191112111809.GN4348@szeder.dev>
References: <pull.458.git.1573196960.gitgitgadget@gmail.com>
 <8d69ba362261690e58b3879c33ac01c8888dc473.1573196960.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <8d69ba362261690e58b3879c33ac01c8888dc473.1573196960.git.gitgitgadget@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Nov 08, 2019 at 07:09:20AM +0000, Utsav Shah via GitGitGadget wrote:
> The checks added in 3444ec2eb2 ("fsmonitor: don't fill bitmap with
> entries to be removed", 2019-10-11), to ensure that the
> fsmonitor_dirty bitmap does not have more bits than the index
> do not play well with the split index.
> 
> git update-index --fsmonitor --split-index calls write_locked_index
> which calls write_shared_index as well as write_split_index.
> The first call fills up the fsmonitor_dirty bitmap,
> and the second modifies the index such that istate->cache_nr is zero and
> this assert is hit.

Just to make sure that we are on the same page, is this the one?

  BUG: fsmonitor.c:88: fsmonitor_dirty has more entries than the index (102 > 1)

> The test written does reproduce the error, but only flakily. There is
> limited difference with GIT_TEST_FSMONITOR=fsmonitor-all or
> GIT_TEST_FSMONITOR=fsmonitor-watchman, so the flakiness might come from
> somewhere else, which I haven't tracked down.
> 
> The test also requires checkout of a new branch, and checking out back
> to master.

It doesn't; see below.

> It's clear that the index gets into some poor state through
> these operations, and there is a deeper bug somewhere.
> 
> At the very least, this patch mitigates an over-eager check for split
> index users while maintaining good invariants for the standard case.
> Also, I haven't been able to reproduce this with "standard" user
> commands, like status/checkout/stash, so the blast radius seems limited.
> 
> Helped-by: Kevin Willford <kewillf@microsoft.com>
> Helped-by: Junio C Hamano <gitster@pobox.com>
> Signed-off-by: Utsav Shah <utsav@dropbox.com>
> ---

> diff --git a/t/t7519-status-fsmonitor.sh b/t/t7519-status-fsmonitor.sh
> index d8df990972..b5029eff3e 100755
> --- a/t/t7519-status-fsmonitor.sh
> +++ b/t/t7519-status-fsmonitor.sh
> @@ -371,4 +371,27 @@ test_expect_success 'status succeeds after staging/unstaging ' '
>  	)
>  '
>  
> +# Git will only split indices if we have a bunch of files created,
> +# so that prep work of creating a few hundred files is required.

'git update-index --split-index' splits the index no matter what; it
even splits an empty index.

> +# Note that this test doesn't fail determinstically without
> +# its corresponding bugfix.
> +test_expect_success 'update-index succeeds after staging with split index' '
> +	test_create_repo fsmonitor-stage-split &&
> +	(
> +		cd fsmonitor-stage-split &&
> +		test_commit initial &&
> +		files=$(test_seq 1 100) &&
> +		echo "hello world" > file &&
> +		touch $files &&
> +		git add -A &&
> +		git commit -m "next" &&
> +		git config core.fsmonitor "$TEST_DIRECTORY/t7519/fsmonitor-watchman" &&
> +		echo "hello world" > file &&
> +		git checkout -b new-branch &&
> +		git checkout master &&
> +		echo hello >> file &&
> +		git update-index --split-index --untracked-cache --fsmonitor
> +	)
> +'

I could reproduce the failure with '-r 30 --stress' relatively easily
[1], but with those options I could shave off a lot from this test:

        test_create_repo fsmonitor-stage-split &&
        (
                cd fsmonitor-stage-split &&
                >tracked &&
                git add tracked &&
                git config core.fsmonitor
                "$TEST_DIRECTORY/t7519/fsmonitor-watchman" &&
                >untracked &&
                git update-index --split-index --untracked-cache --fsmonitor
        )

and could still trigger the failure:

  + git update-index --split-index --untracked-cache --fsmonitor
  open2: exec of watchman -j failed at /home/szeder/src/git/t/t7519/fsmonitor-watchman line 47.
  BUG: fsmonitor.c:88: fsmonitor_dirty has more entries than the index (1 > 0)


[1] There is a quite expensive lazy prereq evaluation outside of
    'test_expect_*' that I disabled it with the following for
    speedier stress testing:

diff --git a/t/t7519-status-fsmonitor.sh b/t/t7519-status-fsmonitor.sh
index 997d5fb349..103520415d 100755
--- a/t/t7519-status-fsmonitor.sh
+++ b/t/t7519-status-fsmonitor.sh
@@ -50,8 +50,7 @@ write_integration_script () {
 }
 
 test_lazy_prereq UNTRACKED_CACHE '
-	{ git update-index --test-untracked-cache; ret=$?; } &&
-	test $ret -ne 1
+	true
 '
 
 test_expect_success 'setup' '
