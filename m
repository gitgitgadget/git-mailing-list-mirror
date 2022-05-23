Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C4D2C433FE
	for <git@archiver.kernel.org>; Mon, 23 May 2022 19:36:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231551AbiEWTge (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 23 May 2022 15:36:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232303AbiEWTgZ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 May 2022 15:36:25 -0400
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com [IPv6:2607:f8b0:4864:20::732])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3FFA72E25
        for <git@vger.kernel.org>; Mon, 23 May 2022 12:23:31 -0700 (PDT)
Received: by mail-qk1-x732.google.com with SMTP id c1so13527777qkf.13
        for <git@vger.kernel.org>; Mon, 23 May 2022 12:23:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=k776yns1r9KDyNOVJ2IwooW1PYRT2pvtpwjACFM+ffU=;
        b=Ive/3jbvPPStjb44Q+jToO2xzfNtg40RNDKTrOSrd66EMaPrrz7VB13GgyFbOASlY9
         pk0pGKcOk7NvW5tmjAQ1CiDwrGO4x9WHYZ1VKxyS8HYbfC7TUH1pK4N/n6nWuxqh/Yat
         phyRaWerDSyFfSvShkZ438CD146GgHOx+YjJAsgQ5afp9T/Hc2E2+Wc6brQLLYRK5H3C
         yV0n7cjx2MUAzzDThGACiKaqFW122oTjtqEyCKxkRC3k/b/REN2MRYn9zSRM23ZfXrcL
         YqWX4GminnYohbFSObUqLIjdxJP17PQAKZUQ9/Vc8P0qCLfHThPlZmdIREOu3+6CREpK
         X6VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=k776yns1r9KDyNOVJ2IwooW1PYRT2pvtpwjACFM+ffU=;
        b=mZ2EtgXkObQ1i3ntksVqTuirpPT2Jb3A/OZgxyC7T1tWxkNn4rIqUFw65fkW6TCFvW
         /hgq1V6YGmrp+O3tEI/7NgxvTxJ/s6woSja2lr48ywKolFKOTOqqDq+cJ2TsOPfPc1kR
         1G9qJXmh6HeUECkbPE0UTU0Y1fxATmuZ9HJbalBxN1dFUb2pmszyUvu0cY9MQBPUygvM
         u1VTmqK/mFmEBW+kc3pfsK3iVsZP0G/v8See+eP0fKZoHPsmhdM14lLJ6wP1xEIrhM0g
         FsakV0gWlAnv2Pk2C2BeTdse/1rrQfokxcVLCRAlvxiRLOyCK+RJt4HkEWr18NCukTBO
         h16w==
X-Gm-Message-State: AOAM530p2vBtVdOLGKxhOZsbXnGthi4vSuyMT/c0I1Qh1Kf/+mN3Ny5z
        HA87B3Mrd07Uo8bMaCsIE1S4
X-Google-Smtp-Source: ABdhPJyCHCSx8Bqxs/NDoKfBBDwZrz79mzuVI/6XSKEEpLIoyyO0D9fmD93war9pTQnsfk11QW+69Q==
X-Received: by 2002:a05:620a:2a11:b0:6a3:622a:8447 with SMTP id o17-20020a05620a2a1100b006a3622a8447mr7992750qkp.513.1653333811009;
        Mon, 23 May 2022 12:23:31 -0700 (PDT)
Received: from ?IPV6:2600:1700:e72:80a0:71ba:8ad9:40cd:d364? ([2600:1700:e72:80a0:71ba:8ad9:40cd:d364])
        by smtp.gmail.com with ESMTPSA id ca13-20020a05622a1f0d00b002f39b99f6c0sm4731280qtb.90.2022.05.23.12.23.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 May 2022 12:23:30 -0700 (PDT)
Message-ID: <900d91cb-1982-b892-17e3-ad678e711dc9@github.com>
Date:   Mon, 23 May 2022 15:23:29 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.9.1
Subject: Re: [PATCH v2 1/2] dir: consider worktree config in path recursion
Content-Language: en-US
To:     Goss Geppert <gg.oss.dev@gmail.com>, git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        christian w <usebees@gmail.com>,
        Elijah Newren <newren@gmail.com>
References: <20220505203234.21586-1-ggossdev@gmail.com>
 <20220510171527.25778-1-ggossdev@gmail.com>
 <20220510171527.25778-2-ggossdev@gmail.com>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <20220510171527.25778-2-ggossdev@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 5/10/22 1:15 PM, Goss Geppert wrote:
> Since 8d92fb2927 (dir: replace exponential algorithm with a linear one,
> 2020-04-01) the following no longer works:
> 
>     1) Initialize a repository.
>     2) Set the `core.worktree` location to a parent directory of the
>        default worktree.
>     3) Add a file located in the default worktree location to the index
>        (i.e. anywhere in the immediate parent directory of the gitdir).
> 
> This commit adds a check to determine whether a nested repository that
> is encountered in recursing a path is actually `the_repository`.  If so,
> simply treat the directory as if it doesn't contain a nested repository.
> 
> Prior to this commit, the `add` operation was silently ignored.
> 
> Signed-off-by: Goss Geppert <ggossdev@gmail.com>
> ---
>  dir.c                          | 22 +++++++++
>  t/t2205-add-worktree-config.sh | 89 ++++++++++++++++++++++++++++++++++
>  2 files changed, 111 insertions(+)
>  create mode 100755 t/t2205-add-worktree-config.sh
> 
> diff --git a/dir.c b/dir.c
> index f2b0f24210..a1886e61a3 100644
> --- a/dir.c
> +++ b/dir.c
> @@ -1893,9 +1893,31 @@ static enum path_treatment treat_directory(struct dir_struct *dir,
>  
>  	if ((dir->flags & DIR_SKIP_NESTED_GIT) ||
>  		!(dir->flags & DIR_NO_GITLINKS)) {
> +		/*
> +		 * Determine if `dirname` is a nested repo by confirming that:
> +		 * 1) we are in a nonbare repository, and
> +		 * 2) `dirname` is not an immediate parent of `the_repository->gitdir`,
> +		 *    which could occur if the `worktree` location was manually
> +		 *    configured by the user; see t2205 testcases 1a-1d for examples
> +		 *    where this matters
> +		 */
>  		struct strbuf sb = STRBUF_INIT;
>  		strbuf_addstr(&sb, dirname);
>  		nested_repo = is_nonbare_repository_dir(&sb);
> +
> +		if (nested_repo) {
> +			char *real_dirname, *real_gitdir;
> +			strbuf_reset(&sb);
> +			strbuf_addstr(&sb, dirname);
> +			strbuf_complete(&sb, '/');
> +			strbuf_addstr(&sb, ".git");

This could be strbuf_add(&sb, ".git", 4); to avoid a (minor)
strlen() computation.

> +			real_dirname = real_pathdup(sb.buf, 0);
> +			real_gitdir = real_pathdup(the_repository->gitdir, 0);

With regards to Junio's comment about repeating real_pathdup()
on the_repository->gitdir, we might be able to short-circuit
this by making real_gitdir static and only calling
real_pathdup() if real_gitdir is NULL. It would cut the cost
of these checks by half for big traversals.

> +
> +			nested_repo = !!strcmp(real_dirname, real_gitdir);
> +			free(real_gitdir);
> +			free(real_dirname);
> +		}
...
> +
> +test_description='directory traversal respects worktree config
> +
> +This test configures the repository`s worktree to be two levels above the
> +`.git` directory and checks whether we are able to add to the index those files
> +that are in either (1) the manually configured worktree directory or (2) the
> +standard worktree location with respect to the `.git` directory (i.e. ensuring
> +that the encountered `.git` directory is not treated as belonging to a foreign
> +nested repository)'

The test description should be a single line. The longer paragraph
could be a comment before your "setup" test case.

> +. ./test-lib.sh
> +
> +test_expect_success '1a: setup' '

Also, there is no need to number your tests in their names, as the
testing infrastructure will apply numbers based on their order in
the test file. These labels will grow stale if tests are removed
or inserted into the order.

> +	test_create_repo test1 &&
> +	git --git-dir="test1/.git" config core.worktree "$(pwd)" &&
> +
> +	mkdir -p outside-tracked outside-untracked &&
> +	mkdir -p test1/inside-tracked test1/inside-untracked &&
> +	>file-tracked &&
> +	>file-untracked &&
> +	>outside-tracked/file &&
> +	>outside-untracked/file &&
> +	>test1/file-tracked &&
> +	>test1/file-untracked &&
> +	>test1/inside-tracked/file &&
> +	>test1/inside-untracked/file &&
> +
> +	cat >expect-tracked-unsorted <<-EOF &&
> +	../file-tracked
> +	../outside-tracked/file
> +	file-tracked
> +	inside-tracked/file
> +	EOF
> +
> +	cat >expect-untracked-unsorted <<-EOF &&
> +	../file-untracked
> +	../outside-untracked/file
> +	file-untracked
> +	inside-untracked/file
> +	EOF
> +
> +	cat expect-tracked-unsorted expect-untracked-unsorted >expect-all-unsorted &&
> +
> +	cat >.gitignore <<-EOF
> +	.gitignore
> +	actual-*
> +	expect-*
> +	EOF

This use of .gitignore to ignore the helper files being used
during the test is interesting. I was thinking it would be better
to create isolated directories where the only activity was that
which you were testing:

	mkdir -p worktree &&
	test_create_repo worktree/contains-git &&

...or something like that. The names are more descriptive, and
we don't need the .gitignore trick.

> +'
> +
> +test_expect_success '1b: pre-add all' '
> +	local parent_dir="$(pwd)" &&

I was surprised by this "local". It isn't needed at this
point in the test script. We use it for helper methods to
be sure that we aren't stomping variables from test scripts,
but since the test is being executed inside an eval(), this
local isn't important.

> +	(
> +		cd test1 &&
> +		git ls-files -o --exclude-standard "$parent_dir" >../actual-all-unsorted

You can avoid the sub-shell using "git -C test1 ls-files ..."
right?

> +	) &&
> +	sort actual-all-unsorted >actual-all &&
> +	sort expect-all-unsorted >expect-all &&
> +	test_cmp expect-all actual-all
> +'
> +
> +test_expect_success '1c: post-add tracked' '
> +	local parent_dir="$(pwd)" &&
> +	(
> +		cd test1 &&
> +		git add file-tracked &&
> +		git add inside-tracked &&
> +		git add ../outside-tracked &&
> +		git add "$parent_dir/file-tracked" &&
> +		git ls-files "$parent_dir" >../actual-tracked-unsorted
> +	) &&

This sub-shell is important because of the relative paths
involved. OK.

This also checks to see if _any_ of these "git add"
commands fail, as opposed to failing immediately after
the first one fails. I think your approach is simpler and
should be relatively simple to identify which command did
the wrong thing by looking at the test_cmp output.

> +	sort actual-tracked-unsorted >actual-tracked &&
> +	sort expect-tracked-unsorted >expect-tracked &&
> +	test_cmp expect-tracked actual-tracked
> +'
> +
> +test_expect_success '1d: post-add untracked' '
> +	local parent_dir="$(pwd)" &&
> +	(
> +		cd test1 &&
> +		git ls-files -o --exclude-standard "$parent_dir" >../actual-untracked-unsorted
> +	) &&

Again, this one is not needed.

> +	sort actual-untracked-unsorted >actual-untracked &&
> +	sort expect-untracked-unsorted >expect-untracked &&
> +	test_cmp expect-untracked actual-untracked
> +'
> +

Thanks,
-Stolee
