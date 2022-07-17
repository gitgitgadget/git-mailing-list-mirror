Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FE5AC433EF
	for <git@archiver.kernel.org>; Sun, 17 Jul 2022 16:45:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232902AbiGQQpA (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 17 Jul 2022 12:45:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229536AbiGQQo7 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 17 Jul 2022 12:44:59 -0400
Received: from mail-il1-x12a.google.com (mail-il1-x12a.google.com [IPv6:2607:f8b0:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AE161056B
        for <git@vger.kernel.org>; Sun, 17 Jul 2022 09:44:58 -0700 (PDT)
Received: by mail-il1-x12a.google.com with SMTP id d4so4940523ilc.8
        for <git@vger.kernel.org>; Sun, 17 Jul 2022 09:44:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=7rbwXFxyJDrQDGqykeK3Jx6HMlPBNBEfMHtWYAEgEkY=;
        b=nUaKQmOxOS9bQBWx4f/N9XlVKI5af9YPpLFFrVQQrdmRFEU9PaUCoic8uCGhtcCvnY
         0y+hUuRA8WEuWRQltVLa3MflRQytndiZQPikg4h066a1YJo4SvIrjF595r9BPUXSSGWA
         9l58jZCwn0KmYUehG8wRiIBT807Ry7nAZfHGb0Qths4lnKyyLJCZpOausuHwVRZ2hSxT
         zSk2jQMxLlxvrT8gyoFjHwN2BHLbDn7vOoWsZJ4G6z6fkd+h04jb4ABR9V7Hq0aUYPW3
         HV0/xLMUBw4FFkczMqAC2bRgOGfCbisKFufi5k6iVfOCh3lXZ587EW6kpw81Jl2PMGlP
         +ljg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=7rbwXFxyJDrQDGqykeK3Jx6HMlPBNBEfMHtWYAEgEkY=;
        b=3Q00RHl58Fkn3mO4n0Ba1Rs1F9MpmZJqTdVtS2O8vovlEmwGfHUcFQSuMLYBA83ihE
         Kdr/ebaDg3KgclBLWee7R8LROxyI7jI+a4XhRfq8BrhZJrYyJ+LL10/5gwfSP/2E0I+q
         +cGDwfvE/L7J2Xuh51JXNbkcuQFgomg8w7RkDkHnIUOLqIIq0UeE8sUpyL6oxC4VbKbT
         75Sk/KK85JdpWbKlULjZnG1t6ub1EYvyArmqevjxYdw26FSDg4Fjl3LC+8ILFxTx8oa0
         DEz9JYFMcJa4ccH9hiyqziGeJe6tr4WfB3YXUvQ5vL9L/MvM9Ml08JKpFn+uGJfaQ1Bj
         v98w==
X-Gm-Message-State: AJIora+SOTnnh71IxhU6WVyUi2JnKf8JvnCGnxFDhh2oUs1NBPYuQcf+
        9yNi/0lOcPB+pTcZkyRLF/QQNaqZUXvfcSrpbbPg1yBpeTLdEA==
X-Google-Smtp-Source: AGRyM1uYE9SXiGFM+I/wi0YMC6ZOT2VR7HHz+YYzOA/3uZHgNZrf3P2Kqoyp6JOJNCU/u1wycqOdHre9Gkvnccxet3E=
X-Received: by 2002:a05:6e02:174a:b0:2dc:7bc5:f810 with SMTP id
 y10-20020a056e02174a00b002dc7bc5f810mr11930423ill.254.1658076297780; Sun, 17
 Jul 2022 09:44:57 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1231.git.1652977582.gitgitgadget@gmail.com>
 <pull.1231.v2.git.1655621424.gitgitgadget@gmail.com> <0783b48c121fe74051c13e7d9118d1a5b7cb9aa9.1655621424.git.gitgitgadget@gmail.com>
In-Reply-To: <0783b48c121fe74051c13e7d9118d1a5b7cb9aa9.1655621424.git.gitgitgadget@gmail.com>
From:   ZheNing Hu <adlternative@gmail.com>
Date:   Mon, 18 Jul 2022 00:44:46 +0800
Message-ID: <CAOLTT8QtqVotu8Y0JYDFdxz2p2MvRitGgrfLJ_yCnT0XZoB40Q@mail.gmail.com>
Subject: Re: [PATCH v2 6/6] merge: do not exit restore_state() prematurely
To:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git List <git@vger.kernel.org>, Elijah Newren <newren@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren via GitGitGadget <gitgitgadget@gmail.com> =E4=BA=8E2022=E5=B9=
=B46=E6=9C=8819=E6=97=A5=E5=91=A8=E6=97=A5 14:50=E5=86=99=E9=81=93=EF=BC=9A
>
> From: Elijah Newren <newren@gmail.com>
>
> @@ -398,7 +398,9 @@ static void restore_state(const struct object_id *hea=
d,
>          */
>         run_command_v_opt(args, RUN_GIT_CMD);
>
> -       refresh_cache(REFRESH_QUIET);
> +refresh_cache:
> +       if (discard_cache() < 0 || read_cache() < 0)
> +               die(_("could not read index"));
>  }
>

We don't need to check discard_cache() return value,
it's equal to zero constantly.

>  /* This is called when no merge was necessary. */
> diff --git a/t/t7607-merge-state.sh b/t/t7607-merge-state.sh
> new file mode 100755
> index 00000000000..655478cd0b3
> --- /dev/null
> +++ b/t/t7607-merge-state.sh
> @@ -0,0 +1,25 @@
> +#!/bin/sh
> +
> +test_description=3D"Test that merge state is as expected after failed me=
rge"
> +
> +GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=3Dmain
> +export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
> +. ./test-lib.sh
> +
> +test_expect_success 'set up custom strategy' '
> +       test_commit --no-tag "Initial" base base &&
> +git show-ref &&
> +
> +       for b in branch1 branch2 branch3
> +       do
> +               git checkout -b $b main &&
> +               test_commit --no-tag "Change on $b" base $b
> +       done &&
> +
> +       git checkout branch1 &&
> +       test_must_fail git merge branch2 branch3 &&
> +       git diff --exit-code --name-status &&
> +       test_path_is_missing .git/MERGE_HEAD
> +'
> +

Little typo: less a small tab before "git show ref"?

> +test_done
> --
> gitgitgadget
