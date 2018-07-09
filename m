Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 174851F6AC
	for <e@80x24.org>; Mon,  9 Jul 2018 21:12:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933256AbeGIVMA (ORCPT <rfc822;e@80x24.org>);
        Mon, 9 Jul 2018 17:12:00 -0400
Received: from mail-yb0-f195.google.com ([209.85.213.195]:44199 "EHLO
        mail-yb0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933003AbeGIVL7 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Jul 2018 17:11:59 -0400
Received: by mail-yb0-f195.google.com with SMTP id a2-v6so7763351ybe.11
        for <git@vger.kernel.org>; Mon, 09 Jul 2018 14:11:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ywbP2aNUXTxTQ9JfA9qxKbbQYoXhsYvobnbXQ0X1yBc=;
        b=JzfGvwMjFP+EnVywi72z2Cp6nfPnXzlF9nnERDy0/yTqXVyDk7VmWtVROcIMIDb75e
         dXIqhXUc8ZOoKT80no1L0jKFYhHZbSx3lYPrwvK+y7oOTRqF081ywpEoAloHuXvd2z0q
         gylXbjJI/oGqvws6Iz75Yg23JwqOkW1irT7t1zpEk6ywJDqzmVr6sQiPzCV3VoNkAZc9
         LM3CEe32a/Olm259CBnB9CADxABTW9mLT2fkVSKPxBuSc2Y+hruFKpD1/YJCZH818uEh
         Kl0KcrzRtkCAVaI6aT1K40hMEsUgYJg6ByeSE1HrPMrg35cFmF9OHpBRXFJDkpP2kt7g
         Ocsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ywbP2aNUXTxTQ9JfA9qxKbbQYoXhsYvobnbXQ0X1yBc=;
        b=bpqSYd9OtjG87e5Nk9IqMUVcBSdThSRqlkfRrYsiBzy/0cS0GQtheoA1dPrZ5gg1Yh
         sjHvOSQv1KvA1oN0CIhnWBF99NupUN2soIYSMmeumSxZIAOhJq87VqMGHJAxemoT0M0L
         O3t+GSA7B/r353y1k289Lg0F17eVFVjKK84WeP3FqiHwC2DU6cZQLEeLcgCeif31LsnX
         w7chAcAju27q4tuGbHUolySOmpGKek+BahWuOTfyn57VJiUJsXZZZbalgma6WKg3gquu
         Efaas2mEqjZ72RGPWl8o4mBB6b42uc/UWa08IoljG1uDQ7KX0mFa2XLxhGt1cRIMOG4V
         vzJA==
X-Gm-Message-State: APt69E29MWtWx9P6KBHAVTMB6yghcmlwYR97yzFJtjPGRl6paY5btGf8
        AjdeMUY0+YlbxFAICGxHFqQsqUPOkP0DhBE2gdLC+w==
X-Google-Smtp-Source: AAOMgpfN8+ZslZJZeEsbYgJeA+kjnaM+arJyeXq7yAsXWzq8EPRJMj5BUIodL9JpejsHCJuZdjqnFlIU+mIS3NGVo5I=
X-Received: by 2002:a25:560b:: with SMTP id k11-v6mr11832331ybb.292.1531170718464;
 Mon, 09 Jul 2018 14:11:58 -0700 (PDT)
MIME-Version: 1.0
References: <20180707204404.7208-1-newren@gmail.com> <20180707204404.7208-2-newren@gmail.com>
In-Reply-To: <20180707204404.7208-2-newren@gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Mon, 9 Jul 2018 14:11:47 -0700
Message-ID: <CAGZ79kZ0xyHMT8SngGCUSAEf31NXdPvzkvdaPb8Khm27xRjgTg@mail.gmail.com>
Subject: Re: [PATCH 1/3] t7405: add a file/submodule conflict
To:     Elijah Newren <newren@gmail.com>
Cc:     git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Jul 7, 2018 at 1:44 PM Elijah Newren <newren@gmail.com> wrote:
>
> In the case of a file/submodule conflict, although both cannot exist at
> the same path, we expect both to be present somewhere for the user to be
> able to resolve the conflict with.  Add a testcase for this.
>
> Signed-off-by: Elijah Newren <newren@gmail.com>
> ---
>  t/t7405-submodule-merge.sh | 56 ++++++++++++++++++++++++++++++++++++++
>  1 file changed, 56 insertions(+)
>
> diff --git a/t/t7405-submodule-merge.sh b/t/t7405-submodule-merge.sh
> index 7bfb2f498..95fd05d83 100755
> --- a/t/t7405-submodule-merge.sh
> +++ b/t/t7405-submodule-merge.sh
> @@ -279,4 +279,60 @@ test_expect_success 'recursive merge with submodule' '
>          grep "$(cat expect3)" actual > /dev/null)
>  '
>
> +# File/submodule conflict
> +#   Commit O: <empty>
> +#   Commit A: path (submodule)
> +#   Commit B: path
> +#   Expected: path/ is submodule and file contents for B's path are somewhere
> +
> +test_expect_success 'setup file/submodule conflict' '
> +       test_create_repo file-submodule &&
> +       (
> +               cd file-submodule &&
> +
> +               git commit --allow-empty -m O &&
> +
> +               git branch A &&
> +               git branch B &&
> +
> +               git checkout B &&
> +               echo contents >path &&
> +               git add path &&
> +               git commit -m B &&
> +
> +               git checkout A &&
> +               test_create_repo path &&
> +               (
> +                       cd path &&
> +
> +                       echo hello >world &&

    test_commit -C path &&

or do we need a dirty submodule specifically?
If so what is important, the untracked file or
would changes in the index be sufficient?

> +                       git add world &&

when observing this one in verbose mode , you may be
asked to use 'git submodule add' instead
https://github.com/git/git/blob/master/builtin/add.c#L323

> +                       git commit -m "submodule"

Not sure if we'd need the shell it is only test_commit,
the [submodule] add and commit, so maybe we can get away with
3 times -C ?

> +test_expect_failure 'file/submodule conflict' '

Which part fails here?

> +       test_when_finished "git -C file-submodule reset --hard" &&
> +       (
> +               cd file-submodule &&
> +
> +               git checkout A^0 &&
> +               test_must_fail git merge B^0 >out 2>err &&
> +
> +               git ls-files -s >out &&
> +               test_line_count = 2 out &&
> +               git ls-files -u >out &&
> +               test_line_count = 2 out &&
> +
> +               # path/ is still a submodule
> +               test_path_is_dir path/.git &&
> +
> +               echo Checking if contents from B:path showed up anywhere &&

This could be a comment instead?

> +               grep -q content * 2>/dev/null

Ah that is why we needed the specific echo above.

Sorry for being dense here, I am not quite following the last part of the test,
as it is unclear what ought to fail in this test.

Thanks,
Stefan
