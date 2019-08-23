Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B8A421F461
	for <e@80x24.org>; Fri, 23 Aug 2019 22:53:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726384AbfHWWxV (ORCPT <rfc822;e@80x24.org>);
        Fri, 23 Aug 2019 18:53:21 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:41055 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726283AbfHWWxU (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Aug 2019 18:53:20 -0400
Received: by mail-io1-f66.google.com with SMTP id j5so23695097ioj.8
        for <git@vger.kernel.org>; Fri, 23 Aug 2019 15:53:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=poYE37POFP4F0JwKecWfnClviQ9TAoZAblqLlmZJ3Bk=;
        b=Jg/symW5khsLDB5uGQnIGm9YbRncVke3ChwlzMsGUyPhjgh4A3TaMTovIddPBmUA8F
         pRWnc1Gcw0m9pKoGrV0+au0QQ0coTYuykSnFIMki2R6XadsfjEj9SKIpm8B0iNGY2RTS
         zp7tDJ8M4P+o+U1j3jVYcKGf+L4gpt7P5b9atsdzU0GBq/zSCHKEFu5alkeEn9Z3JhN6
         GNKsZ+XjyeQqV6ioBTrtlyyvm7PdRyFkvn6bfgWxsyoSOkjS2KUEggXEDVV4gAMbokb+
         ovprgKneDiEiAfjY7a74pMt/RzmRBTpmCGKV6adEk7gu8da/dWpa5ZM2m85Kvl/UIML8
         e0xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=poYE37POFP4F0JwKecWfnClviQ9TAoZAblqLlmZJ3Bk=;
        b=AKiJS6/x/H0hS2WXWSUkmYBIUMEgPXL2IySrArmudjaTOuKGSwd5esM/vs4X8HwZmc
         5CGGoXGuvL/Rqs1M1DNFnXzL6QkITa8our4G2waznQIG0CVDzu0ROAa3URM+vro5Tm+F
         pjLtlIfWXd15qV8SBPlVVfWmqORrPldxngzpt6qL+okoOcsCYpH8lgzK8D5D2JKwOU+2
         PKcTf1jMoXi3MYXGbqwTA46fX7FT31vBOUSQDQ+7nyEn9hi2m8necLqN/wvLmO/6RPh/
         6Bp+D14R3nUkEpDZ3Vhb+8j5j2sAAECYW2CAbdKnmd9tA44eS9fb3sXhad4tVcDzylig
         965Q==
X-Gm-Message-State: APjAAAVvebBUkYUsmoLONG/tRj3onHXoywFcrBYMnzmWMW3i27xi+k0y
        VgNt8mz/QqZo+VI0uBOx+SfAd3YXaDMp9NU1tmF0d0to
X-Google-Smtp-Source: APXvYqywLQy7+aW1aFjP1qCYzk4rmII3KXpgg3ugtHH+Hpm5H6ymNr/Ti5qqhoE2fMk8SLH3CaqWVkxck75frQkW874=
X-Received: by 2002:ab0:6911:: with SMTP id b17mr3908260uas.18.1566599435337;
 Fri, 23 Aug 2019 15:30:35 -0700 (PDT)
MIME-Version: 1.0
References: <pull.316.git.gitgitgadget@gmail.com> <c37b5f2c29d42e7c0c727596625d4eb50b6ddb4f.1566313865.git.gitgitgadget@gmail.com>
In-Reply-To: <c37b5f2c29d42e7c0c727596625d4eb50b6ddb4f.1566313865.git.gitgitgadget@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Fri, 23 Aug 2019 15:30:24 -0700
Message-ID: <CABPp-BFT9A5n=_bx5LsjCvbogqwSjiwgr5amcjgbU1iAk4KLJg@mail.gmail.com>
Subject: Re: [PATCH 1/9] sparse-checkout: create builtin with 'list' subcommand
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Aug 20, 2019 at 8:13 AM Derrick Stolee via GitGitGadget
<gitgitgadget@gmail.com> wrote:
<snip>
> The documentation provided is adapted from the "git read-tree"
> documentation with a few edits for clarity in the new context.
> Extra sections are added to hint toward a future change to
> a moer restricted pattern set.

s/moer/more/

<snip>
> +"Sparse checkout" allows populating the working directory sparsely.
> +It uses the skip-worktree bit (see linkgit:git-update-index[1]) to tell
> +Git whether a file in the working directory is worth looking at. If
> +the skip-worktree bit is set, then the file is ignored in the working
> +directory. Git will not populate the contents of those files, which
> +makes a sparse checkout helpful when working in a repository with many
> +files, but only a few are important to the current user.
> +
> +The `$GIT_DIR/info/sparse-checkout` file is used to define the
> +skip-worktree reference bitmap. When Git updates the working
> +directory, it resets the skip-worktree bit in the index based on this
> +file. If an entry
> +matches a pattern in this file, skip-worktree will not be set on
> +that entry. Otherwise, skip-worktree will be set.
> +
> +Then it compares the new skip-worktree value with the previous one. If
> +skip-worktree turns from set to unset, it will add the corresponding
> +file back. If it turns from unset to set, that file will be removed.

I had to read this twice for it to make sense.  Not sure I have a real
good suggestion here, the name "skip-worktree" instead of e.g
"wanted-in-worktree" just naturally leads us into sentences with one
negation automatically and we sometimes have to add more.

Maybe just replace the last two paragraphs with:

The `$GIT_DIR/info/sparse-checkout` file is used to define the
skip-worktree reference bitmap. When Git updates the working
directory, it updates the skip-worktree bits in the index based on this
file and removes or restores files in the working copy to match.

> +
> +## FULL PATTERN SET
> +
> +By default, the sparse-checkout file uses the same syntax as `.gitignore`
> +files.
> +
> +While `$GIT_DIR/info/sparse-checkout` is usually used to specify what
> +files are in, you can also specify what files are _not_ in, using
> +negate patterns. For example, to remove the file `unwanted`:

s/in/included/?

> +Another tricky thing is fully repopulating the working directory when you
> +no longer want sparse checkout. You cannot just disable "sparse
> +checkout" because skip-worktree bits are still in the index and your working
> +directory is still sparsely populated. You should re-populate the working
> +directory with the `$GIT_DIR/info/sparse-checkout` file content as
> +follows:
> +
> +----------------
> +/*
> +----------------

Can we just get rid of this part of the documentation, since there
will be a sparse-checkout command to disable/undo/reset?  However, it
could be useful to mention cases when disabling/undoing/resetting a
sparse-checkout won't work, if there are some.  For example, with the
previous read-tree implementation, you could not undo the sparse
checkout if the index had any unstaged entries, and you couldn't undo
it if there were any files present that corresponding to the sparse
patterns (for fear they'd be overwritten -- however, every once in a
while someone tried to desparsify, it failed e.g. due to the disk
becoming full, and then after freeing up space there were zillions of
files that exactly matched what de-sparsifying would have put there
but the command wanted the user to manually delete them first.)

> +
> +Then you can disable sparse checkout. Sparse checkout support in 'git
> +read-tree' and similar commands is disabled by default. You need to
> +set `core.sparseCheckout` to `true` in order to have sparse checkout
> +support.

...and get rid of this paragraph because I'd expect git
sparse-checkout to come with a subcommand (init/add/whatever) to set
this for the user?  Unless maybe you want to add some words about why
the command sets core.sparseCheckout...and related workspace related
stuff as we talked about elsewhere.

> +test_expect_success 'git sparse-checkout list (empty)' '
> +       git -C repo sparse-checkout list >list 2>err &&
> +       test_line_count = 0 list &&
> +       test_i18ngrep "failed to parse sparse-checkout file; it may not exist" err

Is that the error we want, rather than something like "This worktree
is not sparse (no sparse-checkout file exists and core.sparseCheckout
is false"?

> +'
> +
> +test_expect_success 'git sparse-checkout list (populated)' '
> +       test_when_finished rm -f repo/.git/info/sparse-checkout &&
> +       cat >repo/.git/info/sparse-checkout <<-EOF &&
> +               /folder1/*
> +               /deep/
> +               **/a
> +               !*bin*
> +       EOF
> +       git -C repo sparse-checkout list >list &&
> +       cat >expect <<-EOF &&
> +               /folder1/*
> +               /deep/
> +               **/a
> +               !*bin*
> +       EOF
> +       test_cmp expect list

I have a `./sparsify --stats` that reports
   You are now in a sparse checkout with only 3499 of the 53625 files.
or
  You are not in a sparse checkout.

and I have a --info option that reports both the stats and the list of
sparse paths similar to this sparse-checkout list command.  The stats
aren't important, I guess, but seem nice for the user.  I don't know
if you want to include anything like that in this or another command,
but just thought I'd mention it.
