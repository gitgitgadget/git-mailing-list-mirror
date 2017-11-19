Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8078A202F2
	for <e@80x24.org>; Sun, 19 Nov 2017 08:32:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750803AbdKSIcA (ORCPT <rfc822;e@80x24.org>);
        Sun, 19 Nov 2017 03:32:00 -0500
Received: from mail-qt0-f193.google.com ([209.85.216.193]:33883 "EHLO
        mail-qt0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750780AbdKSIb7 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 19 Nov 2017 03:31:59 -0500
Received: by mail-qt0-f193.google.com with SMTP id 33so2726134qtv.1
        for <git@vger.kernel.org>; Sun, 19 Nov 2017 00:31:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=B3xTMQZhzx6II3VAEEnvqlw3jTjb/DXBR9We1X/MfKQ=;
        b=ITs1MdBihiyuZEEh21hKbOiVevckvx2yp/FiVFHshOEs8QX1zg4MQKxkcy2o7Ee6JV
         UF+vxsz8Kd0leQoK8GS/amY2phH0n+vh+XSDtMwNI+XwX1yO3bUX23kYYXwO7X/XvzLt
         vZtklJiGYJeA8FEa7+EKw7svmPn99WVWqeqnI4r8+quoz6P6M5uhUhO7d84+w8tlWHOz
         44rjPL9qPCatAU4TeQIitLWV4IqDXxW3/GPwPS2QnomyS/0Vtq4nrY4Z5n/ljWfMfCNj
         5cv7oHxAuCOpQmwEJlsIaxv02HBWFFOHUGuVkGqYUPR0LnlLqsALb/UHWS2m6bw8fyvb
         VPIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=B3xTMQZhzx6II3VAEEnvqlw3jTjb/DXBR9We1X/MfKQ=;
        b=rga5DZROt6lfmVLT/dhVs1tsyqUj3MtRfIsf0OMdMTwW5IN+ng4XCikPWScgDz1SGx
         8lLsgj3ngfPRcHw761ofaoK6ww9tlNPLOPGb0psilhvMoVxU2UeJdzOtCPl8/NlMvmU1
         fV1S9My0Sjnf1/BDp7lFfkSVZyCaPDdLVu6GF8IKms1z0vcdMNxMKUGxuQXSfxqESQpj
         1N++PpBqkjtTmFN5t/aIX0/ogpFdJ83SSFfGU1VAd3DwXNtPQeclaNVu1EK1mYD3Lqo/
         blJVKLLbmJ+bpVjA4IPO9/aM1dk2bfBMQxFgEFiF4ueKWg6MVw1db5dGf9PJOze+Dhf1
         25wA==
X-Gm-Message-State: AJaThX50vbkzrlXKtDQnOCsRsqkYVrdQWEaZgU+C0AAbTvO2dlPtqQEt
        610MabX9OClyB2x1s0rUyYML2AK+mjzJJDNlUn8=
X-Google-Smtp-Source: AGs4zMYxR1GE9aVcENKfb4KOf96t6pzJW6gNx9oDl49ST8LA39Auco2VLXo6lZmjT5VSuAEKzGZi7Jz0dvaWp6wCdPY=
X-Received: by 10.237.37.47 with SMTP id v44mr17121217qtc.55.1511080318225;
 Sun, 19 Nov 2017 00:31:58 -0800 (PST)
MIME-Version: 1.0
Received: by 10.12.155.209 with HTTP; Sun, 19 Nov 2017 00:31:57 -0800 (PST)
In-Reply-To: <20171118224706.13810-3-t.gummerer@gmail.com>
References: <20171118181103.28354-1-t.gummerer@gmail.com> <20171118224706.13810-1-t.gummerer@gmail.com>
 <20171118224706.13810-3-t.gummerer@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Sun, 19 Nov 2017 03:31:57 -0500
X-Google-Sender-Auth: Gc5y3Yat-zFSJs3gGNXTe9BDlUk
Message-ID: <CAPig+cS-eQGXU8YKsOAP_RE55GreqLJXPooddpzewUYUZeP6LQ@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] worktree: make add <path> <branch> dwim
To:     Thomas Gummerer <t.gummerer@gmail.com>
Cc:     Git List <git@vger.kernel.org>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>, Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Nov 18, 2017 at 5:47 PM, Thomas Gummerer <t.gummerer@gmail.com> wrote:
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
> diff --git a/Documentation/git-worktree.txt b/Documentation/git-worktree.txt
> @@ -52,6 +52,13 @@ is linked to the current repository, sharing everything except working
> +If <branch> is not found, and neither `-b` nor `-B` nor `--detach` are
> +used, but there does exist a tracking branch in exactly one remote
> +(call it <remote>) with a matching name, treat as equivalent to
> +------------
> +$ git worktree add -b <branch> <path> <remote>/<branch>
> +------------

The example from which this was copied in git-checkout.txt shows the
--track option being used, which makes it clear that the new local
branch will track the remote-tracking branch. git-worktree, of course,
does not have a --track option, but would it make sense to mention
explicitly in the prose that the newly-created local branch tracks the
remote one? (Or are readers sufficiently savvy to intuit it?)

> diff --git a/builtin/worktree.c b/builtin/worktree.c
> index 7b9307aa58..05fc902bcc 100644
> --- a/builtin/worktree.c
> +++ b/builtin/worktree.c
> @@ -1,4 +1,5 @@
>  #include "cache.h"
> +#include "checkout.h"
>  #include "config.h"
>  #include "builtin.h"
>  #include "dir.h"
> @@ -386,6 +387,20 @@ static int add(int ac, const char **av, const char *prefix)
>                 opts.new_branch = xstrndup(s, n);
>         }
>
> +       if (ac == 2 && !opts.new_branch && !opts.detach) {
> +               struct object_id oid;
> +               struct commit *commit;
> +               const char *remote;
> +
> +               commit = lookup_commit_reference_by_name(branch);
> +               if (!commit)
> +                       remote = unique_tracking_name(branch, &oid);
> +               if (!commit && remote) {
> +                       opts.new_branch = branch;
> +                       branch = remote;
> +               }
> +       }

You can simplify the above conditionals to:

    commit = ...
    if (!commit) {
        remote = ...
        if (remote) {
            ...
        }
    }

So, although you're not passing --track explicitly to the "git branch"
invocation just below, you get --track for free since it's the default
behavior when creating a new local branch from a remote one, correct?
(Just checking my understanding.)

>         if (opts.new_branch) {
>                 struct child_process cp = CHILD_PROCESS_INIT;
>                 cp.git_cmd = 1;
> diff --git a/t/t2025-worktree-add.sh b/t/t2025-worktree-add.sh
> @@ -6,6 +6,16 @@ test_description='test git worktree add'
> +# Is branch "refs/heads/$1" set to pull from "$2/$3"?
> +test_branch_upstream () {
> +       printf "%s\n" "$2" "refs/heads/$3" >expect.upstream &&
> +       {
> +               git config "branch.$1.remote" &&
> +               git config "branch.$1.merge"
> +       } >actual.upstream &&
> +       test_cmp expect.upstream actual.upstream
> +}

Not a big deal, but it wouldn't hurt to move this function down to the
point where it is first needed...

>  test_expect_success 'setup' '
>         test_commit init
>  '
> @@ -314,4 +324,40 @@ test_expect_success 'rename a branch under bisect not allowed' '
> +test_expect_success '"add" <path> <non-existent-branch> fails' '
> +       test_must_fail git worktree add foo non-existent
> +'
> +
> +test_expect_success '"add" <path> <branch> dwims' '
> +       test_when_finished rm -rf repo_upstream &&
> +       test_when_finished rm -rf repo_dwim &&
> +       test_when_finished rm -rf foo &&

Also not a big deal, but could all be combined into a single invocation:

    test_when_finished rm -rf repo_upstream repo_dwim foo &&

> +       git init repo_upstream &&
> +       (
> +               cd repo_upstream &&
> +               test_commit upstream_master &&
> +               git checkout -b foo &&
> +               test_commit a_foo
> +       ) &&
> +       git init repo_dwim &&
> +       (
> +               cd repo_dwim &&
> +               test_commit dwim_master &&
> +               git remote add repo_upstream ../repo_upstream &&
> +               git config remote.repo_upstream.fetch \
> +                         "refs/heads/*:refs/remotes/repo_upstream/*" &&
> +               git fetch --all &&
> +               test_must_fail git worktree add -b foo ../foo foo &&
> +               test_must_fail git worktree add --detach ../foo foo &&
> +               git worktree add ../foo foo
> +       ) &&
> +       (
> +               cd foo &&
> +               test_branch_upstream foo repo_upstream foo &&
> +               git rev-parse repo_upstream/foo >expect &&
> +               git rev-parse foo >actual &&
> +               test_cmp expect actual
> +       )
> +'
