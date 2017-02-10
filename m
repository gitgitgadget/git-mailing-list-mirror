Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 040131FC46
	for <e@80x24.org>; Fri, 10 Feb 2017 18:50:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753487AbdBJSuW (ORCPT <rfc822;e@80x24.org>);
        Fri, 10 Feb 2017 13:50:22 -0500
Received: from mail-pf0-f193.google.com ([209.85.192.193]:32770 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752327AbdBJSuS (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Feb 2017 13:50:18 -0500
Received: by mail-pf0-f193.google.com with SMTP id e4so3024294pfg.0
        for <git@vger.kernel.org>; Fri, 10 Feb 2017 10:50:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=87z2rvKuxlPawcuUOlTwn2worE22CkTjS1lFpmu/acU=;
        b=Pr5N2Wpu0IGWVyA2LoAKBcfGhLkrvxbsg6oX52pzS2wE380oWf8bth7dfER9LwBKUy
         YNx9z70nu/WTI0EXr6CVjcO4lCQD61CzqRc4Mg231PsVizyKefUwe20ouYTE/CVUkpem
         Gg6xi2aiCiHaDsZ5ZUz7Gjf4ygvXSZwyfBIxTIJHDrHX9akVFEp7B9DTnREPhDGh9Pxu
         Dbss0uT+1W4k8cY00PuieyC4nUT+UHzWsLJ51on+Os8iBUEcFwKgEPXIQ0MTUjv06b7V
         EaI8pa5Tu3ru58S+nCj1ek7VTw0a5k1gffTjmQ1+5u0Jl+gSTgnwUlvsw1UxNVRTGSwr
         6B0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=87z2rvKuxlPawcuUOlTwn2worE22CkTjS1lFpmu/acU=;
        b=exibQcIptXRd+zFtTH29xPvcdjnwK3sUXn08C1f8DWqVp5Uk8TzJrmvQEggd+Yy5Fm
         0gVapse7tSA15zE79wAwtD/FS2A04a8uqpU2i6GUi4wk+bN8mmEVrYSfjQrypNirwUyo
         ILsEbPVFFw8M6urxgwMaU2cfH0W4RG0KguErl8oMd2ziYOTXjcvbFqdY6CYmgTT2nEFZ
         Jq4MLqxn1QoNkY1mtqgbiLEzYEYDuaE9i62YMPAClKk2ws+Kh/nXf3lA4aabqBYiRKOj
         3qwY3pAWIRaiDvIWwu9vZwSA/YFVT85W122+qAqMnaSMOhdVn8ZgOj/sbUwvcVVeTyq0
         ryAw==
X-Gm-Message-State: AMke39kjog20cXDuH1IvIXXiTwZILi9kuEIcygRhIeQof7tJDpUCypb4UgptyeBQWdN77A==
X-Received: by 10.84.191.129 with SMTP id a1mr13197091pld.62.1486752617817;
        Fri, 10 Feb 2017 10:50:17 -0800 (PST)
Received: from localhost ([2620:0:1000:8622:8499:2e0a:2c80:2b60])
        by smtp.gmail.com with ESMTPSA id n87sm766176pfi.122.2017.02.10.10.50.16
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 10 Feb 2017 10:50:16 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <johannes.schindelin@gmx.de>
Cc:     git@vger.kernel.org, Michael Rappazzo <rappazzo@gmail.com>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Subject: Re: [PATCH v2 1/2] rev-parse tests: add tests executed from a subdirectory
References: <50fe3ea3302c40f4c96eaa5a568837e3334f9dc4.1486555851.git.johannes.schindelin@gmx.de>
        <cover.1486740772.git.johannes.schindelin@gmx.de>
        <cc23463af8096c5f8429f939ce881cf0eb5c2dcd.1486740772.git.johannes.schindelin@gmx.de>
Date:   Fri, 10 Feb 2017 10:50:16 -0800
In-Reply-To: <cc23463af8096c5f8429f939ce881cf0eb5c2dcd.1486740772.git.johannes.schindelin@gmx.de>
        (Johannes Schindelin's message of "Fri, 10 Feb 2017 16:33:41 +0100
        (CET)")
Message-ID: <xmqqshnllw2f.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <johannes.schindelin@gmx.de> writes:

> From: Michael Rappazzo <rappazzo@gmail.com>
>
> t2027-worktree-list has an incorrect expectation for --git-common-dir
> which has been adjusted and marked to expect failure.
>
> Some of the tests added have been marked to expect failure.  These
> demonstrate a problem with the way that some options to git rev-parse
> behave when executed from a subdirectory of the main worktree.
>
> [jes: fixed incorrect assumption that objects/ lives in the
> worktree-specific git-dir (it lives in the common dir instead).]
>
> Signed-off-by: Michael Rappazzo <rappazzo@gmail.com>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---

Just one iffy part; otherwise looks good.

> diff --git a/t/t1500-rev-parse.sh b/t/t1500-rev-parse.sh
> index 038e24c4014..f39f783f2db 100755
> --- a/t/t1500-rev-parse.sh
> +++ b/t/t1500-rev-parse.sh
> @@ -87,4 +87,32 @@ test_rev_parse -C work -g ../repo.git -b t 'GIT_DIR=../repo.git, core.bare = tru
>  
>  test_rev_parse -C work -g ../repo.git -b u 'GIT_DIR=../repo.git, core.bare undefined' false false true ''
>  
> +test_expect_success 'git-common-dir from worktree root' '
> +	echo .git >expect &&
> +	git rev-parse --git-common-dir >actual &&
> +	test_cmp expect actual
> +'
> +
> +test_expect_failure 'git-common-dir inside sub-dir' '
> +	mkdir -p path/to/child &&
> +	test_when_finished "rm -rf path" &&
> +	echo "$(git -C path/to/child rev-parse --show-cdup).git" >expect &&
> +	git -C path/to/child rev-parse --git-common-dir >actual &&
> +	test_cmp expect actual
> +'
> +
> +test_expect_success 'git-path from worktree root' '
> +	echo .git/objects >expect &&
> +	git rev-parse --git-path objects >actual &&
> +	test_cmp expect actual
> +'
> +
> +test_expect_failure 'git-path inside sub-dir' '
> +	mkdir -p path/to/child &&
> +	test_when_finished "rm -rf path" &&
> +	echo "$(git -C path/to/child rev-parse --show-cdup).git/objects" >expect &&
> +	git -C path/to/child rev-parse --git-path objects >actual &&
> +	test_cmp expect actual
> +'

All of these look sensible.

>  test_done
> diff --git a/t/t1700-split-index.sh b/t/t1700-split-index.sh
> index 292a0720fcc..1d6e27a09d8 100755
> --- a/t/t1700-split-index.sh
> +++ b/t/t1700-split-index.sh
> @@ -200,4 +200,21 @@ EOF
>  	test_cmp expect actual
>  '
>  
> +test_expect_failure 'rev-parse --shared-index-path' '
> +	rm -rf .git &&
> +	test_create_repo . &&
> +	git update-index --split-index &&
> +	ls -t .git/sharedindex* | tail -n 1 >expect &&
> +	git rev-parse --shared-index-path >actual &&
> +	test_cmp expect actual &&
> +	mkdir work &&
> +	test_when_finished "rm -rf work" &&
> +	(
> +		cd work &&
> +		ls -t ../.git/sharedindex* | tail -n 1 >expect &&
> +		git rev-parse --shared-index-path >actual &&
> +		test_cmp expect actual
> +	)

This looks iffy.  If we expect multiple sharedindex* files, the
first output from "ls -t" may or may not match the real one in use
(multiple things do happen within a single second or whatever your
filesystem's time granularity is).  Two "ls -t" run in this test
would (hopefully) give stable results, but I suspect that the chance
the first line in the output matches what --shared-index-path reports
is 50% if we expect to have two sharedindex* files.

On the other hand, if we do not expect multiple sharedindex* files,
use of "ls" piped to "tail" is simply misleading.

If this test can be written in such a way that there is only one
such file that match the pattern, it would be the cleanest to
understand and explain.  As there is only a single invocation of
"update-index --split-index" immediately after a new repository is
created, I suspect that the expectation to see only one sharedindex*
file already holds (because its name is unpredictable, we still need
to catch it with wildcard), and if that is the case, we can just
lose "-t" and pipe to tail, i.e. "ls .git/sharedindex* >expect".

> diff --git a/t/t2027-worktree-list.sh b/t/t2027-worktree-list.sh
> index 465eeeacd3d..c1a072348e7 100755
> --- a/t/t2027-worktree-list.sh
> +++ b/t/t2027-worktree-list.sh
> @@ -8,16 +8,24 @@ test_expect_success 'setup' '
>  	test_commit init
>  '
>  
> -test_expect_success 'rev-parse --git-common-dir on main worktree' '
> +test_expect_failure 'rev-parse --git-common-dir on main worktree' '
>  	git rev-parse --git-common-dir >actual &&
>  	echo .git >expected &&
>  	test_cmp expected actual &&
>  	mkdir sub &&
>  	git -C sub rev-parse --git-common-dir >actual2 &&
> -	echo sub/.git >expected2 &&
> +	echo ../.git >expected2 &&
>  	test_cmp expected2 actual2
>  '

OK, this swaps a wrong expectation with a more usable one.

> +test_expect_failure 'rev-parse --git-path objects linked worktree' '
> +	echo "$(git rev-parse --show-toplevel)/.git/objects" >expect &&
> +	test_when_finished "rm -rf linked-tree && git worktree prune" &&
> +	git worktree add --detach linked-tree master &&
> +	git -C linked-tree rev-parse --git-path objects >actual &&
> +	test_cmp expect actual
> +'
> +

Looking good.

Thanks.
