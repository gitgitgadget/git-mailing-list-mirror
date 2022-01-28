Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C611AC433EF
	for <git@archiver.kernel.org>; Fri, 28 Jan 2022 08:55:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238937AbiA1IzK (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 28 Jan 2022 03:55:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230118AbiA1IzI (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Jan 2022 03:55:08 -0500
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com [IPv6:2607:f8b0:4864:20::b34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DDD7C061714
        for <git@vger.kernel.org>; Fri, 28 Jan 2022 00:55:08 -0800 (PST)
Received: by mail-yb1-xb34.google.com with SMTP id k31so16514392ybj.4
        for <git@vger.kernel.org>; Fri, 28 Jan 2022 00:55:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=DpO60d/4YQJUlTa9nfDp+GgB2+THUmBfwAlvDlbUClI=;
        b=ZfQpmUO/NWg06zwzL8Hkpf9stowzRThkus1bYUtqJeJODv2FmFxtB9pZI7Y3b9JVSD
         FH+X0KYsuNXUXkXrWLBwDxs8uGh4dXJrzaiG+ShTZWs208wdedCUwYSpChupHjgi5zTg
         K+RR14XIozZqqDJPjpWTD/Ckv7nySd3m6EAy0ypSPlNkD/3r9r0jFWFN8jI9VRp2IzLk
         jkIFVipvnRxF1s/3mvjeFzO55C6OruD8cb3iu0gZzHgD0rbrzLIYk+OHCRxAxFwSKDOd
         9IdqInU375cZmX640gIGEGnunztEl7RMkpNhIZEezhH5f2dwI0k5+KPsVWDMErgII9Im
         YWOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:content-transfer-encoding;
        bh=DpO60d/4YQJUlTa9nfDp+GgB2+THUmBfwAlvDlbUClI=;
        b=amXW/UChHN+yiGi81pGFZ73fDEx19Az4CERSVvsAdN2EuoMOICwDax8RlOQmJmv0ed
         HpEnMj6FbFDSiezpISt3RxCserpxjAK9Nzf7Vqq9P3rzZB1LZFK/tUFG05Brm+yXjnM6
         Q6ob3VBomkraRG6g1eu/XsUqWoDLMcfbJHXQb5brNDogdIad2Ecw24FCV4CqfTUaPOJ7
         8u5BhZ4JCwT3qhA0EW7W3BdWnZclCKstQvZLagqaIcAVTUQwDpijCQzMwYI/A7kGBm2w
         6pfMUmmCwOGIs+/XgJts/vYsDR8EAAz0YdBH9hoboJVikSwd0pnPl7Xc6PDZ1x84DAWJ
         i5Yg==
X-Gm-Message-State: AOAM5334pKzxSe/zu2q28v0E0NUpwZZyoMlolN5A/u/HmAUudGR1+tKt
        iIxFT22L1UY2mDY6l0lGZMSx43EwIzcoR3TucZhaCtE+Sbs=
X-Google-Smtp-Source: ABdhPJyCcsuBZLF3wQQvyYyQOCMavh0C34kXWg+HIMAqnQm8o6H78gXVNoUhDm5bsCf2OyHAaID7HDFvBCh3EGW/kqI=
X-Received: by 2002:a25:4b83:: with SMTP id y125mr11036632yba.287.1643360107866;
 Fri, 28 Jan 2022 00:55:07 -0800 (PST)
MIME-Version: 1.0
References: <pull.1132.git.1643328752.gitgitgadget@gmail.com> <CAN7CjDC+O883DB1iaJAXF5ZCis7FP2Z9z0y2qS2-JVAKfQA8aA@mail.gmail.com>
In-Reply-To: <CAN7CjDC+O883DB1iaJAXF5ZCis7FP2Z9z0y2qS2-JVAKfQA8aA@mail.gmail.com>
From:   "Miriam R." <mirucam@gmail.com>
Date:   Fri, 28 Jan 2022 09:54:57 +0100
Message-ID: <CAN7CjDBSSCe9nyti8bF-cYW3LU+6E9brz91GY2=Db4NSmCpr9w@mail.gmail.com>
Subject: Fwd: [PATCH 00/11] Finish converting git bisect into a built-in
To:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Johannes,

I had done the last commits to finish the porting of git bisect
command since my Outreachy internship two years ago
(https://gitlab.com/mirucam/git/-/commits/git-bisect-work-part5-v1),
and I was planning to send them in the last patch series during this
February. I have a very very little availability and I can not send
the patch series frequently and I understand you are in hurry to
finish this.

I am sure your patch series will be more complete and better and you
will do not need it, but if you want to use some of my commits(or
parts) be my guest :).
Regards,
Miriam.



El vie, 28 ene 2022 a las 1:12, Johannes Schindelin via GitGitGadget
(<gitgitgadget@gmail.com>) escribi=C3=B3:
>
> After three GSoC/Outreachy students spent an incredible effort on this, i=
t
> is finally time to put a neat little bow on it.
>
> Johannes Schindelin (11):
>   bisect run: fix the error message
>   bisect--helper: retire the --no-log option
>   bisect--helper: really retire --bisect-next-check
>   bisect--helper: really retire `--bisect-autostart`
>   bisect--helper: align the sub-command order with git-bisect.sh
>   bisect--helper: make `--bisect-state` optional
>   bisect: move even the option parsing to `bisect--helper`
>   bisect--helper: using `--bisect-state` without an argument is a bug
>   Turn `git bisect` into a full built-in.
>   bisect: remove Cogito-related code
>   bisect: no longer try to clean up left-over `.git/head-name` files
>
>  Makefile                               |   3 +-
>  bisect.c                               |   3 -
>  builtin.h                              |   2 +-
>  builtin/{bisect--helper.c =3D> bisect.c} | 201 ++++++++++---------------
>  git-bisect.sh                          |  84 -----------
>  git.c                                  |   2 +-
>  t/t6030-bisect-porcelain.sh            |   1 -
>  7 files changed, 84 insertions(+), 212 deletions(-)
>  rename builtin/{bisect--helper.c =3D> bisect.c} (87%)
>  delete mode 100755 git-bisect.sh
>
>
> base-commit: 89bece5c8c96f0b962cfc89e63f82d603fd60bed
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1132%2F=
dscho%2Fbisect-in-c-v1
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1132/dscho=
/bisect-in-c-v1
> Pull-Request: https://github.com/gitgitgadget/git/pull/1132
> --
> gitgitgadget
