Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C8E7C432BE
	for <git@archiver.kernel.org>; Fri, 27 Aug 2021 21:07:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4A9F760F58
	for <git@archiver.kernel.org>; Fri, 27 Aug 2021 21:07:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231796AbhH0VHz (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 27 Aug 2021 17:07:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231570AbhH0VHy (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 27 Aug 2021 17:07:54 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 427A2C0613D9
        for <git@vger.kernel.org>; Fri, 27 Aug 2021 14:07:05 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id p15so13695070ljn.3
        for <git@vger.kernel.org>; Fri, 27 Aug 2021 14:07:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eO+xkYN7wCTO2roMfbx5ska1TMsAVRW48YFdAf1g+tY=;
        b=Ojxvr9v6MfLOft1/bKMH9Y6glsYyxHAyyN/34vb9QhcSGejRFcCDdX909zTXfFt/1O
         q5vhl0CHO/M4EEb8aRphVScTgNc6JI/CCOzVvW/81ChXvrWW0vikqfMEBGoQD5b7cneG
         gIidn38ztHu5DT5F9rA93WLlvpsQmnotO8vL9OmGD2AC7JlAwnYOBckq7bXBk6Mae93B
         mmKN6GMzRchyt4AUsTrntJLSG+6tTyHosGnr8GhoLW8izLALAh/cIphCVO+zaGMQetpq
         juDgqi1+qDt4LNzuaJPu9ZsNhKeZaXkmP+dkTdWtgZbnB/UEUZ3+3IBtaqXirulMb/SH
         o7DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eO+xkYN7wCTO2roMfbx5ska1TMsAVRW48YFdAf1g+tY=;
        b=jwT5PbJlIhhc5cKuqtMzfuHLn/L4SC/xv98wmLMdd6BHApUGbI6cfmq7ooba4pbMCL
         DYPVPJG95cCa5bYsBKEP1g4P9saHPO6FwBqZWpU5QhcBdheKWhN1DxP+828jvrKcxSAS
         Ok9pgArGhEERD3L31RnxzTaG70Ns0r6ySeMy62jzk9OdQTAo8Y3VqREXgLbfaJQNa/VF
         h0f+U+m3OT0iCn1gFO9Ij8cuxsASkqqe1kN6wxT7tO/2YqsN3HZvHJYp2Jx5FoE2MGz/
         uI7GSXnLrEcXZ87EQWbd++DXn4LYNirkiX3iyhqryvdIFLCBv2Qco+zuJPt4yc9tdY94
         /0Og==
X-Gm-Message-State: AOAM532cPBIUzHwBbpqKdWCAqNyA4rCH70cjwpa+kOaVD6RXIyUZ7+bJ
        49UdkfjALWwnIQK8TT/wKTeWg3cAFMGaiU45fAA5hA==
X-Google-Smtp-Source: ABdhPJwRHNnj5M0at06SV1nogoIW2JwykkUIvJTTNo0NuytHItIM5zCkrvcn/WEkWLlZvPSfNEG14qxmJcvNDEQWQAA=
X-Received: by 2002:a05:651c:211c:: with SMTP id a28mr9643598ljq.8.1630098423565;
 Fri, 27 Aug 2021 14:07:03 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1018.git.1629842085.gitgitgadget@gmail.com> <e80fcfa932cca394c5c8b349cafadb0754a594dd.1629842085.git.gitgitgadget@gmail.com>
In-Reply-To: <e80fcfa932cca394c5c8b349cafadb0754a594dd.1629842085.git.gitgitgadget@gmail.com>
From:   Matheus Tavares Bernardino <matheus.bernardino@usp.br>
Date:   Fri, 27 Aug 2021 18:06:52 -0300
Message-ID: <CAHd-oW7D1jikE5ByS36AjACfSJoZeekLCKzX2MRRfayKwKv=qQ@mail.gmail.com>
Subject: Re: [PATCH 05/13] add: fail when adding an untracked sparse file
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git <git@vger.kernel.org>, Elijah Newren <newren@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <stolee@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Aug 24, 2021 at 6:54 PM Derrick Stolee via GitGitGadget
<gitgitgadget@gmail.com> wrote:
>
> From: Derrick Stolee <dstolee@microsoft.com>
>
> The add_files() method in builtin/add.c takes a set of untracked files
> that are being added by the input pathspec and inserts them into the
> index. If these files are outside of the sparse-checkout cone, then they
> gain the SKIP_WORKTREE bit at some point. However, this was not checked
> before inserting into the index, so these files are added even though we
> want to avoid modifying the index outside of the sparse-checkout cone.
>
> Add a check within add_files() for these files and write the advice
> about files outside of the sprase-checkout cone.

s/sprase/sparse/

> This behavior change modifies some existing tests within t1092. These
> tests intended to document how a user could interact with the existing
> behavior in place. Many of these tests need to be marked as expecting
> failure. A future change will allow these tests to pass by adding a flag
> to 'git add' that allows users to modify index entries outside of the
> sparse-checkout cone.
>
> The 'submodule handling' test is intended to document what happens to
> directories that contain a submodule when the sparse index is enabled.
> It is not trying to say that users should be able to add submodules
> outside of the sparse-checkout cone, so that test can be modified to
> avoid that operation.

While I was playing with this patch, I did the following:

echo a >a
echo b >b
git add .
git commit -m files
git sparse-checkout set a
echo c >c
git add c

And the last `git add` was successful in adding the untracked `c` file
which is outside the sparse checkout. I'm not sure if I'm doing
something wrong, but it seems that `path_in_sparse_checkout()` returns
UNDECIDED for `c`. Is it because there was no pattern in the list
explicitly excluding it? And if so, should we consider UNDECIDED as
NOT_MATCHED for `path_in_sparse_checkout()`?

> Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
> ---
>  builtin/add.c                            | 14 ++++++++++
>  t/t1092-sparse-checkout-compatibility.sh | 33 +++++++++++++++++-------
>  2 files changed, 38 insertions(+), 9 deletions(-)
>
> diff --git a/builtin/add.c b/builtin/add.c
> index 88a6c0c69fb..3a109276b74 100644
> --- a/builtin/add.c
> +++ b/builtin/add.c
> @@ -443,6 +443,7 @@ static void check_embedded_repo(const char *path)
>  static int add_files(struct dir_struct *dir, int flags)
>  {
>         int i, exit_status = 0;
> +       struct string_list only_match_skip_worktree = STRING_LIST_INIT_NODUP;

I see this reuses the logic from cmd_add() and refresh(). But since we
are operating on untracked files here, perhaps we could replace
"skip_worktree" by "sparse_paths" or something similar?

>         if (dir->ignored_nr) {
>                 fprintf(stderr, _(ignore_error));
> @@ -456,6 +457,11 @@ static int add_files(struct dir_struct *dir, int flags)
>         }
>
>         for (i = 0; i < dir->nr; i++) {
> +               if (!path_in_sparse_checkout(dir->entries[i]->name, &the_index)) {
> +                       string_list_append(&only_match_skip_worktree,
> +                                          dir->entries[i]->name);
> +                       continue;
> +               }
>                 if (add_file_to_index(&the_index, dir->entries[i]->name, flags)) {
>                         if (!ignore_add_errors)
>                                 die(_("adding files failed"));
> @@ -464,6 +470,14 @@ static int add_files(struct dir_struct *dir, int flags)
>                         check_embedded_repo(dir->entries[i]->name);
>                 }
>         }
> +
> +       if (only_match_skip_worktree.nr) {
> +               advise_on_updating_sparse_paths(&only_match_skip_worktree);


Hmm, advise_on_updating_sparse_paths() takes a list of pathspecs that
only matched sparse paths, but here we are passing a list of actual
pathnames... Well, these are technically pathspecs too, but the advice
message may be confusing.

For example, if we ran `git add *.c` on a repo with the untracked
files `d1/file.c` and `d2/file.c`, we will get:

The following pathspecs didn't match any eligible path, but they do match index
entries outside the current sparse checkout:
d1/file.c
d2/file.c

However, `d1/file.c` and `d2/file.c` are neither index entries nor the
pathspecs that the user has given to `git add`. So perhaps we need to
change the error/advice message?


> +               exit_status = 1;
> +       }
> +       string_list_clear(&only_match_skip_worktree, 0);
> +
>         return exit_status;
>  }
