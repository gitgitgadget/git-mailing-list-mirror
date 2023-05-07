Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36667C77B75
	for <git@archiver.kernel.org>; Sun,  7 May 2023 01:36:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230479AbjEGBg2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 6 May 2023 21:36:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230218AbjEGBg0 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 6 May 2023 21:36:26 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AC432684
        for <git@vger.kernel.org>; Sat,  6 May 2023 18:36:25 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id 38308e7fff4ca-2ac7707e34fso37788951fa.1
        for <git@vger.kernel.org>; Sat, 06 May 2023 18:36:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683423383; x=1686015383;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2Es+5rDhS92mDLmKmIwhC/B6B2Y4P/MAUS3EWWnFZ/U=;
        b=fvVUVZNbzhtVKbPyFN7NLz+XaVplaKDItTQZYKB7zSXuo8qObyQs108Y/6TiBhEjD8
         CGCAZjj/DU4IE6EZIBmYrw9oMM8hjpW7mQKqeKWr+2oOrJwTKCSwXrZ4sSyOQGhCVRV3
         eeFJLXE6KRIDMBDrtfM5yiC0Lb7uf2XPnxZ+zNAwJQd2HwfPAmcNOSQrI1qUnz5QV3Ye
         2sRoBElXiahOnEPOzURYpIsjcjYAtQjGhTIn0tFGADMxc/gcAPEvLeKKkZQP3Uhvg8cz
         Pc0Qji8WcCIX2sy5vpzUuL4oDOmIhARO63agFQwVEEQbNw18A4ch2YwR/PqiShfzntn0
         YuKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683423383; x=1686015383;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2Es+5rDhS92mDLmKmIwhC/B6B2Y4P/MAUS3EWWnFZ/U=;
        b=kwfGk5Uu853XNelTcaKvi+hXdo+487iX3cA4D+vMEDQofcYUJGIRhsh201SCpcr20x
         FrJalIXRaD9Ap/oIwWk4BxWuWf+Yy96h3Wt0kXO6RAyrySTKYqqSOtauIdM49Q7t2Osf
         SVJkN8EggQ7VNqDs6EFZFV6Gvi7QKGhgrtKAF4B93QE4oxpHfJMehAnje2oGCAPo76r+
         G4lyKS+MuB19mlD0l6/VcKQcobK+707VI+t/ltZGsRX7pkw9nQB8eMagSrMLrU4lv+3e
         C+aTp9Rgm2F11yy1KcvgLRfkCwoPjzcsnPiH7wDNj/H1Uj0iVHmj2UdIkapemvP0npnE
         8ScQ==
X-Gm-Message-State: AC+VfDzXW8dAZcQlE2IZasVegStRSosj2ldm+anXLmoe+gR8F857BWKt
        xktCBpQRdzdP2JQ0WpdtmJgHXQ70VVcrOvVoIR5cpq9w
X-Google-Smtp-Source: ACHHUZ4pCtjiqjI8Nuyr8ESg/Yv6Q+UK/ibqY9w4X6RXg4dyyYj/X43R9pkGSCfCgRVdxhUJvs8pr4Law7rQhy0s6fg=
X-Received: by 2002:ac2:53bc:0:b0:4e8:4106:ea93 with SMTP id
 j28-20020ac253bc000000b004e84106ea93mr1585668lfh.69.1683423383074; Sat, 06
 May 2023 18:36:23 -0700 (PDT)
MIME-Version: 1.0
References: <pull.862.v2.git.git.1683127916363.gitgitgadget@gmail.com> <pull.862.v3.git.git.1683150400953.gitgitgadget@gmail.com>
In-Reply-To: <pull.862.v3.git.git.1683150400953.gitgitgadget@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Sat, 6 May 2023 18:36:11 -0700
Message-ID: <CABPp-BEu6F1KYq8vHjypc470HH0fu-4DR6jXogAP=zY1jGNEXg@mail.gmail.com>
Subject: Re: [PATCH v3] docs: clarify git rm --cached function in gitignore note
To:     Sohom Datta via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Sohom Datta <sohomdatta1@gmail.com>,
        Sohom Datta <sohom.datta@learner.manipal.edu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, May 3, 2023 at 2:46=E2=80=AFPM Sohom Datta via GitGitGadget
<gitgitgadget@gmail.com> wrote:
>
> From: Sohom Datta <sohom.datta@learner.manipal.edu>
>
> Explain to users that the step to untrack a file will not also prevent th=
em
> from getting added in the future.
>
> Signed-off-by: Sohom Datta <sohom.datta@learner.manipal.edu>
> ---
>     docs: Clarify git rm --cached function in gitignore note
>
>     I've fixed the Sign-Off v/s commit author issue and incorporated the
>     changes suggested :)
>
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-862=
%2Fsohomdatta1%2Fgitignore-note-v3
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-862/so=
homdatta1/gitignore-note-v3
> Pull-Request: https://github.com/git/git/pull/862
>
> Range-diff vs v2:
>
>  1:  c3257398c8f ! 1:  ae09ff2e70c docs: clarify git rm --cached function=
 in gitignore note
>      @@
>        ## Metadata ##
>      -Author: Sohom <sohom.datta@learner.manipal.edu>
>      +Author: Sohom Datta <sohom.datta@learner.manipal.edu>
>
>        ## Commit message ##
>           docs: clarify git rm --cached function in gitignore note
>
>      -    Explain to users that the step to untrack a file will not also =
keep it
>      -    untracked in the future.
>      +    Explain to users that the step to untrack a file will not also =
prevent them
>      +    from getting added in the future.
>
>           Signed-off-by: Sohom Datta <sohom.datta@learner.manipal.edu>
>
>      @@ Documentation/gitignore.txt: The purpose of gitignore files is to=
 ensure that ce
>        To stop tracking a file that is currently tracked, use
>       -'git rm --cached'.
>       +'git rm --cached' to remove the file from the index. The filename
>      -+can then be added to the `gitignore` file to stop the file from
>      ++can then be added to the `.gitignore` file to stop the file from
>       +being reintroduced in later commits.
>
>        Git does not follow symbolic links when accessing a `.gitignore` f=
ile in
>
>
>  Documentation/gitignore.txt | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/Documentation/gitignore.txt b/Documentation/gitignore.txt
> index f2738b10db6..4c17f2356c4 100644
> --- a/Documentation/gitignore.txt
> +++ b/Documentation/gitignore.txt
> @@ -146,7 +146,9 @@ The purpose of gitignore files is to ensure that cert=
ain files
>  not tracked by Git remain untracked.
>
>  To stop tracking a file that is currently tracked, use
> -'git rm --cached'.
> +'git rm --cached' to remove the file from the index. The filename
> +can then be added to the `.gitignore` file to stop the file from
> +being reintroduced in later commits.
>
>  Git does not follow symbolic links when accessing a `.gitignore` file in
>  the working tree. This keeps behavior consistent when the file is
>
> base-commit: 69c786637d7a7fe3b2b8f7d989af095f5f49c3a8
> --
> gitgitgadget

v3 looks good to me:

Reviewed-by: Elijah Newren <newren@gmail.com>
