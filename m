Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C219C433EF
	for <git@archiver.kernel.org>; Fri, 11 Mar 2022 15:05:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348377AbiCKPGf (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 11 Mar 2022 10:06:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232787AbiCKPGe (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Mar 2022 10:06:34 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C14681B45C4
        for <git@vger.kernel.org>; Fri, 11 Mar 2022 07:05:30 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id e24so13333106wrc.10
        for <git@vger.kernel.org>; Fri, 11 Mar 2022 07:05:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:from:subject:reply-to:to:cc
         :references:content-language:in-reply-to:content-transfer-encoding;
        bh=SiFzbySblI+gcvaG8spzerVBj680plzldS7Z8Wo7lVU=;
        b=RwZWw2KDonEDVUpdTh6aMg+D/vNFvw6BR1I1PTxHWFxVKaex3YDstI4plRPJrcfO0O
         iV7cyZnm5Okqz4wUGC0CYps7hqooDzlQ3cVnl81LQFEmMK8GLa+s+zEXqlPNzP+Q3FON
         j5toYiED6/NWPzljT7kxSe9OiRzO823qgVTAqqFVFDBA/pWXkzyRk0z9zdQIL4tNofwP
         5Rx7usfUwSHOmFVN309OiDHghEw8gLCQ6zQmNtUEXr2zGBal5Uu8ll0jVK9zTvP599x+
         tdycXCGEtkYIvm/brtWNhV9yeu7LcYXfptm4gmhvdljf1nn9q55WGLSaBdHAw8KU84oy
         +6oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:from
         :subject:reply-to:to:cc:references:content-language:in-reply-to
         :content-transfer-encoding;
        bh=SiFzbySblI+gcvaG8spzerVBj680plzldS7Z8Wo7lVU=;
        b=m0Z/bIraxvv1VRqEpHuLailx0rQWJWP6h2XuS4XSXDSkZj4eFrBK/nfbdugaE0ieK9
         q/Tm5/NV/PkpGThJN/xvBeJDfWjOw6HqgykchP+HGD6BNiNoN9vsCzLItGhJs5iEIFd4
         ZSkb6r4yB8IcM0Ej1+Ks50GpQjKA93hJVVXm28a/G4i2tv0kK6hxbtUA86I0Hgsfwjls
         dr/SqoMYW4qROo0RQ+HsoSgFTLLsde04kzZW7Jo1wwk0OSETBOhkpMSvOj0oMV7njsTp
         oy1y2q36I9zQV9QEWyL7ZVltNa2n29piklq+lWlvABGzRyBgNiufAXvebGw7zQ4TDHCI
         xXqw==
X-Gm-Message-State: AOAM530B5L3SHLuag08AOukXdtX67G/taCH79Oq3KlcRyru4qEFAevSZ
        /odUbsR2aJtaxueOjveXd8T5Kl+2O3B6Uw==
X-Google-Smtp-Source: ABdhPJyfmbgqLztI2uAH+ngyyRfEBjbeAT8t2Z44eo3lnXsL+1RQ09BynUXx2JFytu4d4FoyLGtxoA==
X-Received: by 2002:adf:ea0c:0:b0:1f0:657f:1d7d with SMTP id q12-20020adfea0c000000b001f0657f1d7dmr7580791wrm.717.1647011129064;
        Fri, 11 Mar 2022 07:05:29 -0800 (PST)
Received: from [192.168.1.201] (217.2.7.51.dyn.plus.net. [51.7.2.217])
        by smtp.googlemail.com with ESMTPSA id o7-20020a5d6707000000b001f067c7b47fsm10645818wru.27.2022.03.11.07.05.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Mar 2022 07:05:28 -0800 (PST)
Message-ID: <7c1c0b8e-7895-7a0e-6ab0-e45e21ec7329@gmail.com>
Date:   Fri, 11 Mar 2022 15:05:27 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
From:   Phillip Wood <phillip.wood123@gmail.com>
Subject: Re: [PATCH] rebase: set REF_HEAD_DETACH in checkout_up_to_date()
Reply-To: phillip.wood@dunelm.org.uk
To:     John Cai via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     John Cai <johncai86@gmail.com>, Junio C Hamano <gitster@pobox.com>
References: <pull.1226.git.git.1646975144178.gitgitgadget@gmail.com>
Content-Language: en-US
In-Reply-To: <pull.1226.git.git.1646975144178.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi John

Thanks for working on this

On 11/03/2022 05:05, John Cai via GitGitGadget wrote:
> From: John Cai <johncai86@gmail.com>
> 
> Fixes a bug whereby rebase updates the deferenced reference HEAD points
> to instead of HEAD directly.
> 
> If HEAD is on main and if the following is a fast-forward operation,
> 
> git rebase $(git rev-parse main) $(git rev-parse topic)
> 
> Instead of HEAD being set to $(git rev-parse topic), rebase erroneously
> dereferences HEAD and sets main to $(git rev-parse topic). This bug was
> reported by Michael McClimon. See [1].

Often we just add a Reported-by: trailer unless the liked email has some 
useful extra info (which arguably should not be the case with a well 
written commit message)

> This is happening because on a fast foward with an oid as a <branch>,
> update_refs() will only call update_ref() with REF_NO_DEREF if
> RESET_HEAD_DETACH is set. This change was made in 176f5d96 (built-in rebase
> --autostash: leave the current branch alone if possible,
> 2018-11-07). In rebase, we are not setting the RESET_HEAD_DETACH flag,
> which means that the update_ref() call ends up dereferencing
> HEAD and updating it to the oid used as <branch>.
> 
> The correct behavior is that git rebase should update HEAD to $(git
> rev-parse topic) without dereferencing it.
> 
> Fix this bug by adding the RESET_HEAD_DETACH flag in checkout_up_to_date

As Junio points out it is confusing that it is always ok to pass that 
flag, I think we should only set it if we are not checking out a branch, 
see below.

> so that once reset_head() calls update_refs(), it calls update_ref() with
> REF_NO_DEREF which updates HEAD directly intead of deferencing it and
> updating the branch that HEAD points to.
> 
> Also add a test to ensure this behavior.
> 
> 1. https://lore.kernel.org/git/xmqqsfrpbepd.fsf@gitster.g/

Maybe
Reported-by: Michael McClimon <michael@mcclimon.org>
?

> Signed-off-by: John Cai <johncai86@gmail.com>
> ---
>      rebase: update HEAD when is an oid
>      
>      Fixes a bug [1] reported by Michael McClimon where rebase with oids will
>      erroneously update the branch HEAD points to.
>      
>       1. https://lore.kernel.org/git/xmqqsfrpbepd.fsf@gitster.g/
> 
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1226%2Fjohn-cai%2Fjc%2Ffix-rebase-oids-v1
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1226/john-cai/jc/fix-rebase-oids-v1
> Pull-Request: https://github.com/git/git/pull/1226
> 
>   builtin/rebase.c  |  2 +-
>   t/t3400-rebase.sh | 21 +++++++++++++++++++++
>   2 files changed, 22 insertions(+), 1 deletion(-)
> 
> diff --git a/builtin/rebase.c b/builtin/rebase.c
> index b29ad2b65e7..52afeffcc2e 100644
> --- a/builtin/rebase.c
> +++ b/builtin/rebase.c
> @@ -828,7 +828,7 @@ static int checkout_up_to_date(struct rebase_options *options)
>   		    options->switch_to);
>   	ropts.oid = &options->orig_head;
>   	ropts.branch = options->head_name;
> -	ropts.flags = RESET_HEAD_RUN_POST_CHECKOUT_HOOK;
> +	ropts.flags = RESET_HEAD_RUN_POST_CHECKOUT_HOOK | RESET_HEAD_DETACH;

I think it would be clearer if the post image ended up as

	ropts.flags = RESET_HEAD_RUN_POST_CHECKOUT_HOOK
	if (options->head_name)
		ropts.branch = option->head_name
	else
		ropts.flags |= RESET_HEAD_DETACH

and we changed reset_head() to BUG() if both branch and 
RESET_HEAD_DETACH are given.

>   	ropts.head_msg = buf.buf;
>   	if (reset_head(the_repository, &ropts) < 0)
>   		ret = error(_("could not switch to %s"), options->switch_to);
> diff --git a/t/t3400-rebase.sh b/t/t3400-rebase.sh
> index 71b1735e1dd..0b92e78976c 100755
> --- a/t/t3400-rebase.sh
> +++ b/t/t3400-rebase.sh
> @@ -437,4 +437,25 @@ test_expect_success 'rebase when inside worktree subdirectory' '
>   	)
>   '
>   
> +test_expect_success 'rebase with oids' '
> +	git init main-wt &&
> +	(
> +		cd main-wt &&
> +		>file &&
> +		git add file &&
> +		git commit -m initial &&
> +		git checkout -b side &&
> +		echo >>file &&
> +		git commit -a -m side &&
> +		git checkout main &&
> +		git tag hold &&
> +		git checkout -B main hold &&
> +		git rev-parse main >pre &&
> +		git rebase $(git rev-parse main) $(git rev-parse side) &&
> +		git rev-parse main >post &&
> +		test "$(git rev-parse side)" = "$(cat .git/HEAD)" &&
> +		test_cmp pre post
> +	)
> +'

Using a stand alone test for bisecting makes sense but I think we should 
try and use the existing test setup for the regression test (it 
certainly does not need to run in its own worktree). The diff below 
shows how this could be done. Ideally there would be a preparatory 
commit that modernized the whole of the setup test rather than just the 
two commits we're using in the new test but that's not essential.

Best Wishes

Phillip

---- >8 ----
diff --git a/t/t3400-rebase.sh b/t/t3400-rebase.sh
index 71b1735e1d..d5a8ee39fc 100755
--- a/t/t3400-rebase.sh
+++ b/t/t3400-rebase.sh
@@ -18,10 +18,7 @@ GIT_AUTHOR_EMAIL=bogus@email@address
  export GIT_AUTHOR_NAME GIT_AUTHOR_EMAIL

  test_expect_success 'prepare repository with topic branches' '
-       git config core.logAllRefUpdates true &&
-       echo First >A &&
-       git update-index --add A &&
-       git commit -m "Add A." &&
+       test_commit "Add A." A First First &&
         git checkout -b force-3way &&
         echo Dummy >Y &&
         git update-index --add Y &&
@@ -32,9 +29,7 @@ test_expect_success 'prepare repository with topic 
branches' '
         git mv A D/A &&
         git commit -m "Move A." &&
         git checkout -b my-topic-branch main &&
-       echo Second >B &&
-       git update-index --add B &&
-       git commit -m "Add B." &&
+       test_commit "Add B." B Second Second &&
         git checkout -f main &&
         echo Third >>A &&
         git update-index A &&
@@ -399,6 +394,15 @@ test_expect_success 'switch to branch not checked 
out' '
         git rebase main other
  '

+test_expect_success 'switch to non-branch detaches HEAD' '
+       git checkout main &&
+       old_main=$(git rev-parse HEAD) &&
+       git rebase First Second^0 &&
+       test_cmp_rev HEAD Second &&
+       test_cmp_rev main $old_main &&
+       test_must_fail git symbolic-ref HEAD
+'
+
  test_expect_success 'refuse to switch to branch checked out elsewhere' '
         git checkout main &&
         git worktree add wt &&

