Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-12.3 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8E0CD1F87F
	for <e@80x24.org>; Thu, 15 Nov 2018 19:39:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729252AbeKPFsk (ORCPT <rfc822;e@80x24.org>);
        Fri, 16 Nov 2018 00:48:40 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:33488 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725742AbeKPFsk (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Nov 2018 00:48:40 -0500
Received: by mail-ed1-f65.google.com with SMTP id r27so14755338eda.0
        for <git@vger.kernel.org>; Thu, 15 Nov 2018 11:39:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ijBc9U8W9CwjH2ACl+QsDbdykmkwgrYKcZ+VXtQYz8A=;
        b=qBv1lKKXXntPQTxnijIM5NGJeuCIiGN6wVda8zx2oELJ5yXXd9brat/b8IqTPJiSXV
         A5cF9vzeggO1Rhkf/D2DHJ3CDN3E/OgnqI8U3ZorC/4sJkN5kFEeA1kmCInWCJI+dmkZ
         fcHsBAQXuT90+14nq32/kWsv2uITUAPY2sHd8d6vVI5Zvkj7P88tJFyqUq0zBTSpqRM7
         aw3CxyDuT/yI8anYTex4P1pYABRliKf8PRJIZfLsSdtl8G9fIFpqdn6gOtHhyEqJGtXm
         9VaDa67bLfzzd0X4H/Uv2v+h07t9ybp9Hpc3UtzhPDMiqmgRlrROTidGn275imt1VeLB
         UVxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ijBc9U8W9CwjH2ACl+QsDbdykmkwgrYKcZ+VXtQYz8A=;
        b=WeTjSY4NQeDojHpmaqq5EmkOGF9JoOK1FJVlhVxA5gFkarwb3+jLRQOpnXUzYtP8kw
         gyl3eAeW89U3R2DQDF3/awm/bAJAJjWQ8kgUK/FJ/JWrIF3CAhTgLS/UU4qBz54r72cG
         4XkSTsXMgah45uM6KyUx5D6t2asAy9yA+L7NXcJkjc0oy3BuUFh6tyvxkijkwZ77TM5a
         lymMC9VZ/0xSOGrPVr8XrFUi7Ml5OZTuv72Ou7hrNIQCef6G9MeSqb1MFGVFPEHjSevc
         HTrUOBsaYnpsLj+KkkkkE9QUNMe70mWHoT9+7MsxEYhKzdGhmNkzAxmM+STeX+C8Bwe5
         FNGQ==
X-Gm-Message-State: AGRZ1gIIrkgq9SfPHpKv89qWf3YyTJDnntPEjDCvRCOhNmSu0sJ8VF+1
        /GE28bCBALVqMFakx+CbSpdhPfGm1ERgHnJ9JZN6ng==
X-Google-Smtp-Source: AJdET5cWm9YVYjrtTX/njdArIpCZnoqtx8yLpzpeBfZV0UnPNpwejCk2VHW3cSO1xUcTxvK79eInpyP1GTpLum8totw=
X-Received: by 2002:a50:aca2:: with SMTP id x31-v6mr6798080edc.76.1542310770077;
 Thu, 15 Nov 2018 11:39:30 -0800 (PST)
MIME-Version: 1.0
References: <CAGw6cBvLDNtYT6vfHcxmX0S_SS1vmYVCEkSD_ixah6cGKJ4H9w@mail.gmail.com>
 <CAGw6cBvaC+TEOM9Tjdbs5zkz2hzW4649=4rsAo58cNOVHOQS=Q@mail.gmail.com>
 <CAGZ79ka=tkKYNkPmSjhomcfAPbEg6PQPSRtpe3uq2B45fNoyjg@mail.gmail.com> <CAGw6cBvJSswpvrMwKU9b+ANEHO4tWjWVhLL54nUyod2NoHJe1w@mail.gmail.com>
In-Reply-To: <CAGw6cBvJSswpvrMwKU9b+ANEHO4tWjWVhLL54nUyod2NoHJe1w@mail.gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Thu, 15 Nov 2018 11:39:19 -0800
Message-ID: <CAGZ79kb+KSt_verjDR0yMj3y_QjsS5npX151iKP5hZL0HvUs+g@mail.gmail.com>
Subject: Re: Confusing behavior with ignored submodules and `git commit -a`
To:     Michael Forney <mforney@mforney.org>
Cc:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> I have a git repository which contains a number of submodules that
> refer to external repositories. Some of these repositories need to
> patched in some way, so patches are stored alongside the submodules,
> and are applied when building. This mostly works fine, but causes
> submodules to show up as modified in `git status` and get updated with
> `git commit -a`. To resolve this, I've added `ignore = all` to
> .gitmodules for all the submodules that need patches applied. This
> way, I can explicitly `git add` the submodule when I want to update
> the base commit, but otherwise pretend that they are clean. This has
> worked pretty well for me, but less so since git 2.15 when this issue
> was introduced.

> > This is really bad. git-status and git-commit share some code,
> > and we'll populate the commit message with a status output.
> > So it seems reasonable to expect the status and the commit to match,
> > i.e. if status tells me there is no change, then commit should not record
> > the submodule update.
>
> I just checked and if I don't specify a message on the command-line,
> the status output in the message template *does* mention that `inner`
> is getting updated.

That's good.

> >> > There have been a couple occasions where I accidentally pushed local
> >> > changes to ignored submodules because of this. Since they don't show
> >> > up in the log output, it is difficult to figure out what actually has
> >> > gone wrong.
> >
> > How was it prevented before? Just by git commit -a not picking up the
> > submodule change?
>
> Yes. Previously, `git commit -a` would not pick up the change (unless
> I added it explicitly with `git add`), and `git log` would still show
> changes to ignored submodules (which is the behavior I want).

and both are broken currently (commit -a will commit a submodule if
it is changed, and it will also not show that in log, but it did show that
it is committing it in the commit message template)

> I just came across someone else affected by this issue:
> https://github.com/git/git/commit/55568086#commitcomment-27137460

Point taken.
