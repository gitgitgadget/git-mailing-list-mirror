Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 47FFF2036D
	for <e@80x24.org>; Sat, 18 Nov 2017 22:17:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1423936AbdKRWRG (ORCPT <rfc822;e@80x24.org>);
        Sat, 18 Nov 2017 17:17:06 -0500
Received: from mail-wr0-f193.google.com ([209.85.128.193]:43277 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1423922AbdKRWRE (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 18 Nov 2017 17:17:04 -0500
Received: by mail-wr0-f193.google.com with SMTP id u40so4925825wrf.10
        for <git@vger.kernel.org>; Sat, 18 Nov 2017 14:17:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=18CUtYmWzKCAUUYkQVVWaKhIfke43esWn7u5cViXOOw=;
        b=rbYFMcFiGcN6zYUdHwiwnlDGUCcip8f4IryMTne7x/nxC1ojPwJ+KpLJQOzgIUZ4Yu
         3I0pqICnwkwdpI8xaOmFH8SZjwQPys5FQGpM15ZpnEcKDmPaB+PlyDz4RkR500o5CMCG
         x/9VKeY9Ti0I1n3YQ1++CW7FPHC7SYxKuAOXk7yquqoBOBfnEN++e6/DsTEdltTEsYiT
         aFX8Pu5EIH79ObbDIfYSGmc9KMZbxVNRxOzGemgwCwQUHJlqIgCiFp5+A5Df/s6WgX0S
         aZHWP6seP4ShbYZxPs3OZ/6b7qMc7X+w0066b+FyRTd+k79Fa/lZlDGQVxLr0xWBbKLJ
         ZjUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=18CUtYmWzKCAUUYkQVVWaKhIfke43esWn7u5cViXOOw=;
        b=onthv4SMjKMJg/AL6DSsyozU/SbQjYVkv22CD1JNEmCKZjA5OWgcVx/lXnS8gZXsLW
         Rkmu7B1QQOri3cpe3tmPwS2EsgYEr517c2+PGwit8AzHEs5g7TSFVVINHpkudu6JjTpv
         aeBTDiFLZNv48q5VU4GMs5LZlDDtHLdwNhU2rBaGuZWq8LyrOvSAjGghttep3PBiqdZ6
         e+F4Cp4pFXnNJFh5+pYVsqJ4r+q02VfpBI7tImkFp8EvdKGXzgI3iHtc4c9yBnyZLtqr
         cCjIMz0AyZpBEemiATDEfdJ9JSroOWGLiSSh7o3CUloQTczOtDHo7APSKAjSzZUueggn
         P01w==
X-Gm-Message-State: AJaThX4ccmlb2q5ladM4GSXoFrZFTXsJ4uAeAVFqinJzdFraD7/osq+e
        CVDuXA5a5zt8E4MrJq3a7hODqyGg
X-Google-Smtp-Source: AGs4zMZKBT/QNc3+gnOD9oE2/XNjlgLIz8E40CO/HMEYZ4KAkjw2bZjqSfXD/TBeGeFbEg42+CHNfg==
X-Received: by 10.223.184.173 with SMTP id i42mr7222967wrf.31.1511043423256;
        Sat, 18 Nov 2017 14:17:03 -0800 (PST)
Received: from localhost (cpc73832-dals21-2-0-cust969.20-2.cable.virginm.net. [81.110.231.202])
        by smtp.gmail.com with ESMTPSA id 90sm10188324wrp.93.2017.11.18.14.17.01
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 18 Nov 2017 14:17:01 -0800 (PST)
Date:   Sat, 18 Nov 2017 22:18:30 +0000
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     git@vger.kernel.org
Cc:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v2 2/3] worktree: make add <path> <branch> dwim
Message-ID: <20171118221830.GD32324@hank>
References: <20171112134305.3949-1-t.gummerer@gmail.com>
 <20171118181103.28354-1-t.gummerer@gmail.com>
 <20171118181103.28354-2-t.gummerer@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171118181103.28354-2-t.gummerer@gmail.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 11/18, Thomas Gummerer wrote:
> Currently 'git worktree add <path> <branch>', errors out when 'branch'
> is not a local branch.   It has no additional dwim'ing features that one
> might expect.
> 
> Make it behave more like 'git checkout <branch>' when the branch doesn't
> exist locally, but a remote tracking branch uniquely matches the desired
> branch name, i.e. create a new branch from the remote tracking branch
> and set the upstream to the remote tracking branch.
> 
> As 'git worktree add' currently just dies in this situation, there are
> no backwards compatibility worries when introducing this feature.
> 
> Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>
> ---
>  Documentation/git-worktree.txt |  7 +++++++
>  builtin/worktree.c             | 15 ++++++++++++++
>  t/t2025-worktree-add.sh        | 44 ++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 66 insertions(+)
> 
> diff --git a/Documentation/git-worktree.txt b/Documentation/git-worktree.txt
> index b472acc356..3c7c8c3cee 100644
> --- a/Documentation/git-worktree.txt
> +++ b/Documentation/git-worktree.txt
> @@ -52,6 +52,13 @@ is linked to the current repository, sharing everything except working
>  directory specific files such as HEAD, index, etc. `-` may also be
>  specified as `<branch>`; it is synonymous with `@{-1}`.
>  +
> +If <branch> is not found but there does exist a tracking branch in
> +exactly one remote (call it <remote>) with a matching name, treat as
> +equivalent to
> +------------
> +$ git worktree add -b <branch> <path> <remote>/<branch>
> +------------
> ++
>  If `<branch>` is omitted and neither `-b` nor `-B` nor `--detach` used,
>  then, as a convenience, a new branch based at HEAD is created automatically,
>  as if `-b $(basename <path>)` was specified.
> diff --git a/builtin/worktree.c b/builtin/worktree.c
> index 7b9307aa58..92b583ae39 100644
> --- a/builtin/worktree.c
> +++ b/builtin/worktree.c
> @@ -1,4 +1,5 @@
>  #include "cache.h"
> +#include "checkout.h"
>  #include "config.h"
>  #include "builtin.h"
>  #include "dir.h"
> @@ -386,6 +387,20 @@ static int add(int ac, const char **av, const char *prefix)
>  		opts.new_branch = xstrndup(s, n);
>  	}
>  
> +	if (ac == 2) {

Err I just realized this doesn't quite make sense.  Similar to the
dwim for 'git worktree add <path>', this condition should include
'!opts.new_branch && !opts.detach'.  In these cases it's still better
to error out, as the user explicitly asked for a new branch with a
different name/asked not to be put onto a branch.  I'll send a v3 with
this fixed in a bit.

> +		struct object_id oid;
> +		struct commit *commit;
> +		const char *remote;
> +
> +		commit = lookup_commit_reference_by_name(branch);
> +		if (!commit)
> +			remote = unique_tracking_name(branch, &oid);
> +		if (!commit && remote) {
> +			opts.new_branch = branch;
> +			branch = remote;
> +		}
> +	}
> +
>  	if (opts.new_branch) {
>  		struct child_process cp = CHILD_PROCESS_INIT;
>  		cp.git_cmd = 1;
> diff --git a/t/t2025-worktree-add.sh b/t/t2025-worktree-add.sh
> index b5c47ac602..e5959800c0 100755
> --- a/t/t2025-worktree-add.sh
> +++ b/t/t2025-worktree-add.sh
> @@ -6,6 +6,16 @@ test_description='test git worktree add'
>  
>  . "$TEST_DIRECTORY"/lib-rebase.sh
>  
> +# Is branch "refs/heads/$1" set to pull from "$2/$3"?
> +test_branch_upstream () {
> +	printf "%s\n" "$2" "refs/heads/$3" >expect.upstream &&
> +	{
> +		git config "branch.$1.remote" &&
> +		git config "branch.$1.merge"
> +	} >actual.upstream &&
> +	test_cmp expect.upstream actual.upstream
> +}
> +
>  test_expect_success 'setup' '
>  	test_commit init
>  '
> @@ -314,4 +324,38 @@ test_expect_success 'rename a branch under bisect not allowed' '
>  	test_must_fail git branch -M under-bisect bisect-with-new-name
>  '
>  
> +test_expect_success '"add" <path> <non-existent-branch> fails' '
> +	test_must_fail git worktree add foo non-existent
> +'
> +
> +test_expect_success '"add" <path> <branch> dwims' '
> +	test_when_finished rm -rf repo_upstream &&
> +	test_when_finished rm -rf repo_dwim &&
> +	test_when_finished rm -rf foo &&
> +	git init repo_upstream &&
> +	(
> +		cd repo_upstream &&
> +		test_commit upstream_master &&
> +		git checkout -b foo &&
> +		test_commit a_foo
> +	) &&
> +	git init repo_dwim &&
> +	(
> +		cd repo_dwim &&
> +		test_commit dwim_master &&
> +		git remote add repo_upstream ../repo_upstream &&
> +		git config remote.repo_upstream.fetch \
> +			  "refs/heads/*:refs/remotes/repo_upstream/*" &&
> +		git fetch --all &&
> +		git worktree add ../foo foo
> +	) &&
> +	(
> +		cd foo &&
> +		test_branch_upstream foo repo_upstream foo &&
> +		git rev-parse repo_upstream/foo >expect &&
> +		git rev-parse foo >actual &&
> +		test_cmp expect actual
> +	)
> +'
> +
>  test_done
> -- 
> 2.15.0.345.gf926f18f3d
> 
