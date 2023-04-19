Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 033CBC6FD18
	for <git@archiver.kernel.org>; Wed, 19 Apr 2023 15:17:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233653AbjDSPRY (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 19 Apr 2023 11:17:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233674AbjDSPRF (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Apr 2023 11:17:05 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 152F27A87
        for <git@vger.kernel.org>; Wed, 19 Apr 2023 08:16:19 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id 4fb4d7f45d1cf-5067716f9e7so22395a12.0
        for <git@vger.kernel.org>; Wed, 19 Apr 2023 08:16:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681917342; x=1684509342;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DJjaKaRyZTeYClXdhLPGBx+CeAG8J3OeQXZASGzmr3A=;
        b=sQ8fNrhUCHNnQil8tcN51g+gm7pZsGjSa787ZaL0uz2ssu/nS9l1PdB35n6eckQ6hF
         g/TeXIXOiNG/391i+v7L5i1rmrOLWWV3Be5hlf1TsmpgnScVQ7206HCmXvaOlxACeQtX
         0Uu+dFx7xvGAxOUkdUpkJsQjBPUUqxJYhVrCsw6KbJvYPfn1czGT7n4yc/Yo2y1QedSs
         /ot/TFob7zj9rvmG8pXNjxYC12IzMB1dyUj+rdlPG5pEOakmWqtOnG+x3FzNO2ajSuOf
         tXbjwQuMIIyhPArxp5tbDjdIrvppCtTTRMSmCNdHlQ+2sFX+k0jsLjwhp7b6FE4uarbN
         wXgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681917342; x=1684509342;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DJjaKaRyZTeYClXdhLPGBx+CeAG8J3OeQXZASGzmr3A=;
        b=SQRMz6YF9+6wwRUdC9iKOK+6Plm6j8wEd4440OtmWx22tyHEErrhfs0VeudXSkorKT
         no4gEfpS83YR/02hCAl9ofSCXTwTClfnygsumOrQasIYRF5AnWBSik1xWh/WxkYGyod6
         laS24b3fytXKoBRfFz6Fw8ilI7NWUdigY0zIlqeLXN0faUewlWkGHXKAVEY/eU7WcG0f
         4JT/A+l6HSKVxsSD0ZfowkQuQk1j7j056p4biZMpQqIW1enxACYwtkymC7X28C+ddA3K
         PP1/nGAhL6o2EXK3A9pMo5UboCgD9p6BjmiLnwRXsTRJlWHckS3Uc0kpjos0bAkq9adL
         WanA==
X-Gm-Message-State: AAQBX9f8eU0AUlPdLoPIJN/Ce393zCeWBjROCQnKLPGLZTARJDzFlxsD
        tiNcAhebkP0r1ZyKViIG+X0yG5zGfkA814EjQA/PpX9/SS0piw==
X-Google-Smtp-Source: AKy350ZXDSG+UpBlkTWbBPReoA3NYRcpqkrGv9bY5Q0o4Qk+E0VaGOAYZRfRWD6uRp+uYiJMEQezzCOAntDCwQiiBZE=
X-Received: by 2002:a05:6402:4304:b0:504:8a10:b6ab with SMTP id
 m4-20020a056402430400b005048a10b6abmr19567366edc.2.1681917341948; Wed, 19 Apr
 2023 08:15:41 -0700 (PDT)
MIME-Version: 1.0
References: <20230403190538.361840-1-nanth.raghul@gmail.com>
 <20230408112342.404318-1-nanth.raghul@gmail.com> <62821012-4fc3-5ad8-695c-70f7ab14a8c9@github.com>
In-Reply-To: <62821012-4fc3-5ad8-695c-70f7ab14a8c9@github.com>
From:   RAGHUL NANTH <nanth.raghul@gmail.com>
Date:   Wed, 19 Apr 2023 20:45:31 +0530
Message-ID: <CAPnUp-=3aoG9WwCcLnMZ4UL90j+snL8qUePPmm02WQK9tUkCzw@mail.gmail.com>
Subject: Re: [GSOC][PATCH v2] diff-index: enable sparse index
To:     Victoria Dye <vdye@github.com>
Cc:     git@vger.kernel.org, derrickstolee@github.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Apr 14, 2023 at 2:44=E2=80=AFAM Victoria Dye <vdye@github.com> wrot=
e:
>
> Please include the range-diff comparing the previous version to the new o=
ne
> in your future iterations & patch series in general. GitGitGadget adds it=
 by
> default, but if you're using 'send-email' you should be able to use the
> '--range-diff' option to generate it (see MyFirstContribution [1] for mor=
e
> information).
>

Yeah, I will keep this in mind. Sorry about that

> Re: my last review [2] - did you look into the behavior of 'diff' with
> pathspecs and whether this 'pathspec_needs_expanded_index()' could be
> centralized (in e.g. 'run_diff_index()')? What did you find?

I hadn't understood the review properly. I just thought you wanted to
make sure the function was added to diiff-index itself. I have read
through some of it, but I am still not 100% sure of the behaviour.
Will run through it more to get more definitive answers

> Using '! ensure_not_expanded' will fail if the command expands the index
> _or_ if the command fails altogether, which could inadvertently make thes=
e
> tests pass even when there's a breakage in 'diff-index'. An
> 'ensure_expanded' function was created in [3] to test these types of case=
s;
> you can use that here if you base your branch on 'sl/diff-files-sparse' (=
see
> SubmittingPatches for more information [4]).
>
> [3] https://lore.kernel.org/git/20230322161820.3609-3-cheskaqiqi@gmail.co=
m/
> [4] https://git-scm.com/docs/SubmittingPatches#base-branch
>
> > +     ! ensure_not_expanded diff-index "**a"

Yeah, I saw this function, but since this wasn't integrated into
master, I wasn't sure how I would go about using it. I will base my
work off of the mentioned branch for now then. As for making sure the
function doesn't give false positives, it should be fine in this
current case, since I did try to manually run through the commands
just as a guarantee, and that seemed to run fine, but yes, I will make
sure to make those updates


> Git pathspec syntax [5] does not follow glob rules (without the ':(glob)'
> prefix, at least), so the '**' doesn't do anything special here that a
> single '*' wouldn't do. So, to make it clear that you aren't using glob
> patterns, it might be better to use '*a' instead.
>
> Also, why are the wildcard pathspecs here in double-quotes, but the ones =
in
> the previous test ('sparse index is not expanded: diff-index') aren't?


The double quotes were just to use the glob provided by pathspec. As
for why the previous ones don't have them, they are just using regular
pathspecs.

I will make the necessary changes as mentioned here.

Thank you,
Raghul
