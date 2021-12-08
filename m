Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DF0CC433EF
	for <git@archiver.kernel.org>; Wed,  8 Dec 2021 20:19:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240165AbhLHUWd (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Dec 2021 15:22:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232356AbhLHUWd (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Dec 2021 15:22:33 -0500
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 098A7C061746
        for <git@vger.kernel.org>; Wed,  8 Dec 2021 12:19:01 -0800 (PST)
Received: by mail-ed1-x530.google.com with SMTP id e3so12406245edu.4
        for <git@vger.kernel.org>; Wed, 08 Dec 2021 12:19:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=kz9FjzEUm2SwSw6oeS/XrTJy3TKuo2lS0wsPNPW4X+0=;
        b=dkRq4/ajfVtzqu89X6Naj9CBpoedL/NeCKIUgycfMXXrIbhv+O7fKYhPVN963o2YPq
         UWUo7c2FNHZshhlf8Ltu8I2/T3dL+4MlC2IZet4Ni/4HSlTWXujMf64HuaHEuq47Y7nR
         s146j6NlnT3YrRJecvY5yn0/EoUuUEC8t0SMyla1lolQpEREx9zdh8Y8cTZEeAYSWm2i
         qG7DHB8+nVZecjqu8EEo9+m09O1ZBVHUaVYY9aSEJVjQ95ZYoxCCq+CI5nytUhD6zq4n
         DVJYQfZwqzkEQMy71oxtjkeaa7TkzPUZ1UQJfVkkw9qYp7Bm729PNxKWS8S3bhmv+C77
         nwDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=kz9FjzEUm2SwSw6oeS/XrTJy3TKuo2lS0wsPNPW4X+0=;
        b=ICr1QcwNfrVnYPVaY3u1hujwhaymTHI6oFl/4zBLQK0AhS1zEmp/qEcR5DVeGLI41f
         ZfgIDhY13kC2B56gMewTDf3wN+/s6SeIPecueUOw7fLHJpqgRPeEpj5cE7p/SRWJuZgS
         h2rNuQZYGqkmUy7pecVi0i2mgp8MIWB4O/ZZPhiQP0SCuxH1SkxvPM/N4de8ZhpsP4AT
         7PIBCN3RFiZEClaXddFvbN+XkMAxqkDlRj2b7kOlUkWs9AJgEfz/bT5TUuO+nMSLFgaH
         EiuBk/vxaHDUc6WG5wpx7j0LZurqdAXaF2UhnwZcEtQqfr2y9Z02sCWOw+el6VeUC2Mw
         l4QA==
X-Gm-Message-State: AOAM53010XDF04kOcEasGO3HDhppPPIZfVLs+bduDIwIfVSgsNiprVdE
        js0h7cd3HJcRfdrqF7SErfi8xyIYwvHF5EmLp9yz0vDSszg=
X-Google-Smtp-Source: ABdhPJzRao6/xcmbTBbmt1Z0JudtQuIFJbi2rghcZU6G3eCHkNSpmBmQ4cL8FWxeysPCA6UgPnmFbaqN9s25Wvo2H5Q=
X-Received: by 2002:a05:6402:491:: with SMTP id k17mr22371884edv.333.1638994739546;
 Wed, 08 Dec 2021 12:18:59 -0800 (PST)
MIME-Version: 1.0
References: <xmqq8rwv6e0a.fsf@gitster.g> <a4968ff2-17c6-faa8-e9be-0c1880e870dd@gmail.com>
In-Reply-To: <a4968ff2-17c6-faa8-e9be-0c1880e870dd@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Wed, 8 Dec 2021 12:18:47 -0800
Message-ID: <CABPp-BHzzrEkr6NaH5ms+xJC4H3_NxRyUJLqVf1Oth-Ln-mddA@mail.gmail.com>
Subject: Re: ld/sparse-diff-blame, was What's cooking in git.git (Dec 2021,
 #02; Tue, 7)
To:     Lessley Dennington <lessleydennington@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Git Mailing List <git@vger.kernel.org>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Taylor Blau <me@ttaylorr.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Dec 8, 2021 at 11:58 AM Lessley Dennington
<lessleydennington@gmail.com> wrote:
>
> > * ld/sparse-diff-blame (2021-12-06) 8 commits
> >   - blame: enable and test the sparse index
> >   - diff: enable and test the sparse index
> >   - diff: replace --staged with --cached in t1092 tests
> >   - repo-settings: prepare_repo_settings only in git repos
> >   - test-read-cache: set up repo after git directory
> >   - commit-graph: return if there is no git directory
> >   - git: ensure correct git directory setup with -h
> >   - Merge branch 'vd/sparse-reset' into ld/sparse-diff-blame
> >   (this branch is used by ds/fetch-pull-with-sparse-index; uses vd/spar=
se-reset.)
> >
> >   Teach diff and blame to work well with sparse index.
> >
> >   Will merge to 'next'?
> >   source: <pull.1050.v6.git.1638806161.gitgitgadget@gmail.com>
> >
>
> This series has been reviewed at different stages by:
>
> Junio C Hamano <gitster@pobox.com>
>         - Suggested addition of BUG in prepare_repo_settings.
>         - Suggested --help fix for certain builtins when run outside repo=
s
>           or with special config settings.
>         - Suggested using --cached instead of --staged in diff tests.
> Elijah Newren <newren@gmail.com>
>         - Suggested diff commit message cleanup.
>         - Corrected git commit message typo.
>         - Corrected comment on blame sparse index tests specifying why
>           this builtin does not work on files outside the working
>           directory.
> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
>         - Suggested lower case first letter in prepare_repo_settings BUG
>           message.
> Taylor Blau <me@ttaylor.com>
>         - Suggested diff/blame commit description cleanups
>         - Suggested addition of more diff sparse index test cases
>         - Suggested cleanup of blame sparse index test cases
>
>
> I believe all comments have been addressed (either in the form of a
> re-roll or a patch or explanation in my reply) and that this branch is
> ready to merge to 'next'. I have cc'd all reviewers, though, in case ther=
e
> was something I missed.

...and the current version of the series also has my Reviewed-by.  I
too think this topic is ready for next, as I stated elsewhere[1].

[1] https://lore.kernel.org/git/CABPp-BEd-CLaAJvLpcE=3DzSinz1up17zh+iUrG--4=
AXUe765BBA@mail.gmail.com/
