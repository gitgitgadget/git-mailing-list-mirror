Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 458D8C433B4
	for <git@archiver.kernel.org>; Thu, 13 May 2021 12:40:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1699C613C1
	for <git@archiver.kernel.org>; Thu, 13 May 2021 12:40:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233779AbhEMMlf (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 13 May 2021 08:41:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231529AbhEMMld (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 May 2021 08:41:33 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17CC6C061574
        for <git@vger.kernel.org>; Thu, 13 May 2021 05:40:22 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id i9so31761403lfe.13
        for <git@vger.kernel.org>; Thu, 13 May 2021 05:40:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MmI1w9oWFOKNcOAMqKHB7LEKqQqGb2PnZ6JCauzy1oQ=;
        b=XSCk7VUuJAKI9ZBz72f5ydPJHjCqbvRoUngntX+yzbfMyRNttV7GI7w0Ykr5A9L5dT
         EZdzPYtw7oS1E6WIegmyve9vKoJU+T8xW7wjvkcDJAvPlbWAyOS0mcSnIx4aRLgIk56F
         qCKJR4cBz04lZU5ss6dKq60IGOByn0RjRZXhITPL3XMA3poD+mAjHqVjKAHWB9vMEHSR
         +wnkyRzt6pNjr6IMSwEj0PHmTOwqxDe6vSrxFo4yCB8Xf3CQ99HnwaR784XFLwxn/o+u
         796tRdQzBAQW5tilBi+h8T0/doea4mDEhT6/Can7XK3vWuDZjfBjZq07w+0251SpNSzu
         0fIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MmI1w9oWFOKNcOAMqKHB7LEKqQqGb2PnZ6JCauzy1oQ=;
        b=dU6/uCHpOByslzEvGp3FfVcLWjK7n1bPtVZjCmHHJtsMlSLsImsgukPV4EGCrr085F
         QeNO0ZPJ8JXUjSmQSJe2SqPFfs+NCJPJFrFnopBVvhMmi32grJDyEdKpK9jmExKmGnSW
         AhUuBnrEGNZfqRTZo7ixgO6rYQsNNihQv7tQjer9j6i+ZkBAvVMi1yap0Cu9RCOE+4C8
         DeW6/Rjh1DFQobxbBwWXd0ePQNQYSbG9Jb9fEuJAizaeVYPcFdB5kgSwL2f1V20VNoRc
         TySrGgRB1VuzBqq8vocnMnXLXyLl40CEe7l6UIrBjhC2gdoGk+j0GoHLEITG3gWiu1jx
         vATw==
X-Gm-Message-State: AOAM531OK7uRl+4k3lXE8/CUStkHxTHouxu2J6HIbicc2nGnEvsUcOS9
        I1FUisUI9oiAhQ5dulrUNHsWL35+cxdwzlWrxpsqwA==
X-Google-Smtp-Source: ABdhPJw+FbGXteBIJ5lZcNZzOTmkFVknMpKu1RtHQZMuOnk9zoaZG3auy0fGPIP9Z6KJO+SdXx/nXBIcah2C5m1NDvU=
X-Received: by 2002:a19:f00c:: with SMTP id p12mr28613258lfc.502.1620909620392;
 Thu, 13 May 2021 05:40:20 -0700 (PDT)
MIME-Version: 1.0
References: <pull.932.git.1618322497.gitgitgadget@gmail.com>
 <pull.932.v2.git.1619213665.gitgitgadget@gmail.com> <3bac9edae7d82ef9fdabbe2f3959e574f79f1dd0.1619213665.git.gitgitgadget@gmail.com>
In-Reply-To: <3bac9edae7d82ef9fdabbe2f3959e574f79f1dd0.1619213665.git.gitgitgadget@gmail.com>
From:   Matheus Tavares Bernardino <matheus.bernardino@usp.br>
Date:   Thu, 13 May 2021 09:40:09 -0300
Message-ID: <CAHd-oW7X07EU+bX7vZQ+6Jr6ghEQ8kQMuFFCFew6T3mYArBTKg@mail.gmail.com>
Subject: Re: [PATCH v2 1/8] t1092: add tests for status/add and sparse files
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Apr 23, 2021 at 6:34 PM Derrick Stolee via GitGitGadget
<gitgitgadget@gmail.com> wrote:
>
> From: Derrick Stolee <dstolee@microsoft.com>
>
> Before moving to update 'git status' and 'git add' to work with sparse
> indexes, add an explicit test that ensures the sparse-index works the
> same as a normal sparse-checkout when the worktree contains directories
> and files outside of the sparse cone.
>
> Specifically, 'folder1/a' is a file in our test repo, but 'folder1' is
> not in the sparse cone. When 'folder1/a' is modified, the file
> 'folder1/a' is shown as modified, but adding it fails.

Hmm, I might be doing something wrong, but I think `folder1/a` is not
shown as modified.

$ git init test
$ mkdir test/folder1
$ echo original >test/folder1/a
$ echo original >test/b
$ git -C test add . && git -C test commit -m files
$ git -C test sparse-checkout init --cone --sparse-index
$ ls test
b
$ mkdir test/folder1 && echo modified >test/folder1/a
$ git -C test status
On branch master
You are in a sparse checkout with 50% of tracked files present.
nothing to commit, working tree clean

> This is new
> behavior as of a20f704 (add: warn when asked to update SKIP_WORKTREE
> entries, 2021-04-08). Before that change, these adds would be silently
> ignored.
>
> Untracked files are fine: adding new files both with 'git add .' and
> 'git add folder1/' works just as in a full checkout. This may not be
> entirely desirable, but we are not intending to change behavior at the
> moment, only document it. A future change could alter the behavior to
> be more sensible, and this test could be modified to satisfy the new
> expected behavior.
>
> Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
> ---
>  t/t1092-sparse-checkout-compatibility.sh | 40 ++++++++++++++++++++++++
>  1 file changed, 40 insertions(+)
>
> diff --git a/t/t1092-sparse-checkout-compatibility.sh b/t/t1092-sparse-checkout-compatibility.sh
> index 12e6c453024f..0ec487acd283 100755
> --- a/t/t1092-sparse-checkout-compatibility.sh
> +++ b/t/t1092-sparse-checkout-compatibility.sh
> @@ -232,6 +232,46 @@ test_expect_success 'add, commit, checkout' '
>         test_all_match git checkout -
>  '
>
> +test_expect_success 'status/add: outside sparse cone' '
> +       init_repos &&

A minor suggestion: before recreating folder1/a, we could also test
that `git add folder1/a` will not remove the sparse entry from the
index and will properly warn about it on both sparse repos. I.e.
adding a:

        test_sparse_match test_must_fail git add folder1/a

> +       # folder1 is at HEAD, but outside the sparse cone
> +       run_on_sparse mkdir folder1 &&
> +       cp initial-repo/folder1/a sparse-checkout/folder1/a &&
> +       cp initial-repo/folder1/a sparse-index/folder1/a &&
> +
> +       test_sparse_match git status &&
> +
> +       write_script edit-contents <<-\EOF &&
> +       echo text >>$1
> +       EOF
> +       run_on_all ../edit-contents folder1/a &&

Hmm, we modify `folder1/a` in all repos, but we only try adding it on
the sparse repos, and then we immediately restore it on the full repo.
As we won't use the modified version on the full repo, could this
perhaps be `run_on_sparse` instead? If so, we could also save the
later `git -C full-checkout checkout HEAD -- folder1/a`.

> +       run_on_all ../edit-contents folder1/new &&
> +
> +       test_sparse_match git status --porcelain=v2 &&
> +
> +       # This "git add folder1/a" is completely ignored
> +       # by the sparse-checkout repos. It causes the
> +       # full repo to have a different staged environment.
> +       #
> +       # This is not a desirable behavior, but this test
> +       # ensures that the sparse-index is not the cause
> +       # of a behavior change.

I'm not sure I understand what the undesirable behavior is in this
sentence. Is it "git add folder1/a" erroring out and not updating
`folder1/a`? Or the full repo having a different staged environment?

> +       test_sparse_match test_must_fail git add folder1/a &&
> +       test_sparse_match test_must_fail git add --refresh folder1/a &&
> +       git -C full-checkout checkout HEAD -- folder1/a &&
> +       test_all_match git status --porcelain=v2 &&
> +
> +       test_all_match git add . &&
> +       test_all_match git status --porcelain=v2 &&
> +       test_all_match git commit -m folder1/new &&
> +
> +       run_on_all ../edit-contents folder1/newer &&
> +       test_all_match git add folder1/ &&
> +       test_all_match git status --porcelain=v2 &&
> +       test_all_match git commit -m folder1/newer
> +'
> +
>  test_expect_success 'checkout and reset --hard' '
>         init_repos &&
>
> --
> gitgitgadget
>
