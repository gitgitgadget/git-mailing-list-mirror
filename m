Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID,T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 594541F424
	for <e@80x24.org>; Sun,  8 Apr 2018 10:09:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752656AbeDHKJw (ORCPT <rfc822;e@80x24.org>);
        Sun, 8 Apr 2018 06:09:52 -0400
Received: from mail-qk0-f194.google.com ([209.85.220.194]:39253 "EHLO
        mail-qk0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752061AbeDHKJv (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 8 Apr 2018 06:09:51 -0400
Received: by mail-qk0-f194.google.com with SMTP id j73so6133325qke.6
        for <git@vger.kernel.org>; Sun, 08 Apr 2018 03:09:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=M4T3Zry9JdaZIKK6Alod1xJ/JelZZluBcAYaOap7+90=;
        b=b3KoJx+m1D2fAo05WiuWpe9U17UBZ3VoJiZOR9advN8pBAZaZaOvAiQY35r83XeR2G
         8E/wVvcxt5EV8hxJhg214bfGg/yzJVkunyjvv6SRDfd/m3qSzF7BoSi0L+nt9pqAuC4W
         sG0n5fuQqhMQaJ2mo5vrNCAjjgjX106vvFDdgVAN4ullLVWJQZbKcffmR7RFkHjPyT91
         FfIOE1eDf4LlwarT82ogS7uNYmjg9cGIZ46ekTt8V/8nC9/MgUbWfWUVkGUBavzH04p8
         w4bspO6bFdWtBFiyt47uEqK2OrKBJ8enyxMvr5vQTk+euQ3x0LdVHdckzvnus7/BUdej
         Qjsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=M4T3Zry9JdaZIKK6Alod1xJ/JelZZluBcAYaOap7+90=;
        b=tFmsNXlxfPj/RK955pse77EoFOjgrHt9qB0L5+D2ZBSSV/Lc65PGK9cJLwTqIonH62
         rn3wIR+Znj2r9AkTXtbtvN+euPCOj2kGZ0hsTOmKqgqurSOOXQ1kFemhwRoxSD3yuI+q
         5C0IllCnFg7ZbLXYYqLJOiHpvIJ9WrfgOAte7ZwADi6d1IZB+UznBrk83IkaTh1RVvjS
         CBHMuSC8XcU3J5sUHlbxFVFdyJi8gpI9qIOnTvYolSNkf4Li5qAzY1bKBXlPXYJBm83I
         VSr1rRso5YBbxkyr+NwFC1gwrGFUEZvo5uhJdxsM+pat61KRFOGEhQuMua5eHmMgkY4i
         LaSw==
X-Gm-Message-State: ALQs6tCRPocTnsVq6kKpU0umH6H4PBP5afgpHM7gfz8uFgTDNJqfhAkL
        B3DW/RHxbK+xcsGcH1xdD6Tc2NGSjUpgvmJDnt8=
X-Google-Smtp-Source: AIpwx48LDlgqocJXyzhg1b+KPYnngOlP9d249KcNHx64pId0Jde10RHYFbQl6R4R7XiXNESxtwpsxVzlG7tSHaVnZGg=
X-Received: by 10.55.198.217 with SMTP id s86mr43839164qkl.153.1523182190202;
 Sun, 08 Apr 2018 03:09:50 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.12.174.202 with HTTP; Sun, 8 Apr 2018 03:09:49 -0700 (PDT)
In-Reply-To: <20180331151804.30380-7-t.gummerer@gmail.com>
References: <20180325134947.25828-1-t.gummerer@gmail.com> <20180331151804.30380-1-t.gummerer@gmail.com>
 <20180331151804.30380-7-t.gummerer@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Sun, 8 Apr 2018 06:09:49 -0400
X-Google-Sender-Auth: x31BkW4Vwu34NBgiilUyEW0CmiQ
Message-ID: <CAPig+cSRa=HQkBKXoNNf2tW+c_j5mPKu2NHTUGXxyd6qsLzcnQ@mail.gmail.com>
Subject: Re: [PATCH v6 6/6] worktree: teach "add" to check out existing branches
To:     Thomas Gummerer <t.gummerer@gmail.com>
Cc:     Git List <git@vger.kernel.org>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>, Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Mar 31, 2018 at 11:18 AM, Thomas Gummerer <t.gummerer@gmail.com> wrote:
> [...]
> However we can do a little better than that, and check the branch out if
> it is not checked out anywhere else.  This will help users who just want
> to check an existing branch out into a new worktree, and save a few
> keystrokes.
> [...]
> Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>
> ---
> diff --git a/Documentation/git-worktree.txt b/Documentation/git-worktree.txt
> @@ -61,8 +61,13 @@ $ git worktree add --track -b <branch> <path> <remote>/<branch>
>  If `<commit-ish>` is omitted and neither `-b` nor `-B` nor `--detach` used,
> +then, as a convenience, a worktree with a branch named after
> +`$(basename <path>)` (call it `<branch>`) is created.

I had a hard time digesting this. I _think_ it wants to say:

    If `<commit-ish>` is omitted and neither `-b` nor `-B` nor
    `--detach` is used, then, as a convenience, the new worktree is
    associated with a branch (call it `<branch>`) named after
    `$(basename <path>)`.

>  If `<branch>`
> +doesn't exist, a new branch based on HEAD is automatically created as
> +if `-b <branch>` was given.  If `<branch>` exists in the repository,

Maybe: s/exists in the repository/does exist/
Or: s/.../is a local branch/

Though, the latter may be getting too pedantic.

> +it will be checked out in the new worktree, if it's not checked out
> +anywhere else, otherwise the command will refuse to create the
> +worktree (unless `--force` is used).
> diff --git a/t/t2025-worktree-add.sh b/t/t2025-worktree-add.sh
> @@ -198,13 +198,24 @@ test_expect_success '"add" with <branch> omitted' '
> +test_expect_success '"add" checks out existing branch of dwimd name' '
> +       git branch dwim HEAD~1 &&
> +       git worktree add dwim &&
> +       test_cmp_rev HEAD~1 dwim &&
> +       (
> +               cd dwim &&
> +               test_cmp_rev dwim HEAD

Nit: Argument order of the two test_cmp_rev() invocations differs.

> +       )
> +'
> +
> +test_expect_success '"add <path>" dwim fails with checked out branch' '
> +       git checkout -b test-branch &&
> +       test_must_fail git worktree add test-branch &&
> +       test_path_is_missing test-branch
> +'
> +
> +test_expect_success '"add --force" with existing dwimd name doesnt die' '
> +       git worktree add --force test-branch
>  '

Maybe make this last test slightly more robust by having it "git
checkout test-branch" before "git worktree add ..." to protect against
someone inserting a new test (which checks out some other branch)
between these two. Probably not worth a re-roll.
