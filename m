Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 47967202A0
	for <e@80x24.org>; Sun, 19 Nov 2017 19:04:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751003AbdKSTEP (ORCPT <rfc822;e@80x24.org>);
        Sun, 19 Nov 2017 14:04:15 -0500
Received: from mail-qt0-f194.google.com ([209.85.216.194]:40390 "EHLO
        mail-qt0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750952AbdKSTEO (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 19 Nov 2017 14:04:14 -0500
Received: by mail-qt0-f194.google.com with SMTP id u42so12439355qte.7
        for <git@vger.kernel.org>; Sun, 19 Nov 2017 11:04:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=/BAAspRvSumLQgXwnXKwujcwMbSPbFguYd/Vw2y/2JY=;
        b=meXLW6iUB3h0rXKeQABDGDsDn3coI0gRg3311l94ixS6ZvQMb92FxtMZjqadxRmVZR
         iO68e6BdO3sMm5wVF3PhFrvQ7ul8U0dY/fNkTC1TM1G3Tr7N9Kq6Hevi/fYZtgURUhty
         zn39bOsGxgD3JuapdbftitHTiCSTluW4a1o48p9l+zAoV4D6VkRVua7H6Y9uFnJnJyJv
         PznoBJ3QT1GeqW7dpGZgG79xCSlcDkUC3UrpxGseVd1HwS8un7XFxqhwMivLgnWgLz3A
         z37k3klZKg+Qbs/gWyfviuyHXL5mGpCjFtLOb/mg7h8mkR6XGz+CD3c8Yc42OEJlUqxw
         ZYdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=/BAAspRvSumLQgXwnXKwujcwMbSPbFguYd/Vw2y/2JY=;
        b=uSNFEnnwZgeUM6cLJSiuYCTkUFfgCNcyWfp88zPOqB1r+I9LV3aHGC0mgBgIry+76L
         mj+r406m2qh1D2q/dFnJYUEyRMw+LrK1nfB/WQKGXmKRCL8Ej6QSSK/9YNGpTrE/QmC5
         ggwmeN99N6A85Ll5tKprTLLltcqy+fhz1hdbsz6rKfsRIkDIC01LSttFKb1CFpy+9ich
         TMfcgNdiKOByLbGBNaiG+XH5z2nsdH29eMuuTUWeCz3HnXhEM6Rr4d/dcOxEZlMNE2ZW
         +KdXZ9RU9FIqwwJzOLLb9u46p9vGLUHazuqQ0naa6OUwACoxv+5jJ4/zDkqWp/ONKlwT
         AZAw==
X-Gm-Message-State: AJaThX7NGSbyH8ykPuyj5qBG25KwrVUPbrtYD2myL1iZeBp5DymiqG1t
        hkFkP1TgKzHUt/ySdvxEsNYpAxH8hK/41OIEak8=
X-Google-Smtp-Source: AGs4zMb67VpMecJsOLq6/RXLtZmAj4vdlTsdw5f5HyjJRpdsH7cJzoAXcpBA0uT49E3jOUxHSmvlmykRURizVQYqtWs=
X-Received: by 10.200.5.2 with SMTP id u2mr17757255qtg.217.1511118253465; Sun,
 19 Nov 2017 11:04:13 -0800 (PST)
MIME-Version: 1.0
Received: by 10.12.155.209 with HTTP; Sun, 19 Nov 2017 11:04:13 -0800 (PST)
In-Reply-To: <20171118224706.13810-4-t.gummerer@gmail.com>
References: <20171118181103.28354-1-t.gummerer@gmail.com> <20171118224706.13810-1-t.gummerer@gmail.com>
 <20171118224706.13810-4-t.gummerer@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Sun, 19 Nov 2017 14:04:13 -0500
X-Google-Sender-Auth: U3zC1keE-yLZ0ODnwU9OdMH92q4
Message-ID: <CAPig+cQqbvuZg0Y8ZMObZc7mYXzohooVBFj0-o+CGGXrgGLp5w@mail.gmail.com>
Subject: Re: [PATCH v3 3/3] worktree: make add <path> dwim
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
> Currently 'git worktree add <path>' creates a new branch named after the
> basename of the <path>, that matches the HEAD of whichever worktree we
> were on when calling "git worktree add <path>".
>
> Make 'git worktree add <path> behave more like the dwim machinery in
> 'git checkout <new-branch>', i.e. check if the new branch name uniquely
> matches the branch name of a remote tracking branch, and if so check out
> that branch and set the upstream to the remote tracking branch.
>
> This is a change of behaviour compared to the current behaviour, where
> we create a new branch matching HEAD.  However as 'git worktree' is
> still an experimental feature, and it's easy to notice/correct the
> behaviour in case it's not what the user desired it's probably okay to
> break existing behaviour here.
>
> In order to also satisfy users who want the current behaviour of
> creating a new branch from HEAD, add a '--no-track' flag, which disables
> the new behaviour, and keeps the old behaviour of creating a new branch
> from the head of the current worktree.
>
> Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>
> ---
> diff --git a/Documentation/git-worktree.txt b/Documentation/git-worktree.txt
> @@ -60,9 +60,18 @@ $ git worktree add -b <branch> <path> <remote>/<branch>
>  ------------
>  If `<branch>` is omitted and neither `-b` nor `-B` nor `--detach` used,
> -then, as a convenience, a new branch based at HEAD is created automatically,
> -as if `-b $(basename <path>)` was specified.
> -
> +then, as a convenience, if there exists a tracking branch in exactly
> +one remote (call it <remote>) matching the basename of the path
> +(call it <branch>), treat it as equivalent to

Inconsistent typesetting. In the context, typesetting is `<foo>`,
whereas in the new content, you've used <foo> for these two.

> +------------
> +$ git worktree add -b <branch> <path> <remote>/<branch>
> +------------
> +If no tracking branch exists in exactly one remote, <branch> is

Typesetting: `<foo>`

> +created based on HEAD, as if `-b $(basename <path>)` was specified.
> ++
> +To disable the behaviour of trying to match the basename of <path> to
> +a remote, and always create a new branch from HEAD, the `--no-track`

Does --[no-]track deserve to be documented in the OPTIONS section like
the other options are?

> +flag can be passed to `git worktree add`.
>  list::

You lost a blank line before "list::".

>  List details of each worktree.  The main worktree is listed first, followed by
> diff --git a/builtin/worktree.c b/builtin/worktree.c
> @@ -351,6 +352,7 @@ static int add(int ac, const char **av, const char *prefix)
> +               OPT_BOOL(0, "track", &track_dwim, N_("checkout upstream branch if there's a unique match")),

git-checkout and git-branch help describe this as "setting upstream"
and "setting up tracking", respectively. Using "checkout" in this help
message could be confusing, especially since git-worktree has a
--no-checkout option; this seems to imply that --track would override
it.

>                 OPT_END()
>         };
>
> diff --git a/t/t2025-worktree-add.sh b/t/t2025-worktree-add.sh
> @@ -360,4 +360,64 @@ test_expect_success '"add" <path> <branch> dwims' '
> +test_expect_success 'git worktree add --no-track does not set up tracking' '
> +       test_when_finished rm -rf repo_a &&
> +       test_when_finished rm -rf repo_b &&
> +       test_when_finished rm -rf foo &&
> +       git init repo_a &&
> +       (
> +               cd repo_a &&
> +               test_commit a_master &&
> +               git checkout -b foo &&
> +               test_commit a_foo
> +       ) &&
> +       git init repo_b &&
> +       (
> +               cd repo_b &&
> +               test_commit b_master &&
> +               git remote add repo_a ../repo_a &&
> +               git config remote.repo_a.fetch \
> +                       "+refs/heads/*:refs/remotes/other_a/*" &&
> +               git fetch --all &&
> +               git worktree add --no-track ../foo
> +       ) &&
> +       (
> +               cd foo &&
> +               ! test_branch_upstream foo repo_a foo &&
> +               git rev-parse other_a/foo >expect &&
> +               git rev-parse foo >actual &&
> +               ! test_cmp expect actual
> +       )
> +'

Most of the boilerplate in the three new tests (added in this and the
previous patch) is identical (and very verbose). Perhaps the bulk of
it can be factored out into a function?

> +
> +test_expect_success 'git worktree add sets up tracking' '
> +       test_when_finished rm -rf repo_a &&
> +       test_when_finished rm -rf repo_b &&
> +       test_when_finished rm -rf foo &&
> +       git init repo_a &&
> +       (
> +               cd repo_a &&
> +               test_commit a_master &&
> +               git checkout -b foo &&
> +               test_commit a_foo
> +       ) &&
> +       git init repo_b &&
> +       (
> +               cd repo_b &&
> +               test_commit b_master &&
> +               git remote add repo_a ../repo_a &&
> +               git config remote.repo_a.fetch \
> +                       "+refs/heads/*:refs/remotes/other_a/*" &&
> +               git fetch --all &&
> +               git worktree add ../foo
> +       ) &&
> +       (
> +               cd foo &&
> +               test_branch_upstream foo repo_a foo &&
> +               git rev-parse other_a/foo >expect &&
> +               git rev-parse foo >actual &&
> +               test_cmp expect actual
> +       )
> +'
> +
>  test_done
