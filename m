Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB9B6C47082
	for <git@archiver.kernel.org>; Sat,  5 Jun 2021 22:36:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8B827613AC
	for <git@archiver.kernel.org>; Sat,  5 Jun 2021 22:36:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230050AbhFEWiF (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 5 Jun 2021 18:38:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229998AbhFEWiE (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 5 Jun 2021 18:38:04 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3474AC061766
        for <git@vger.kernel.org>; Sat,  5 Jun 2021 15:36:16 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id x10so6553109plg.3
        for <git@vger.kernel.org>; Sat, 05 Jun 2021 15:36:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1MfMFEkX4yvAliFSNppN+VFlLacMRf73GLGySFvrvQ8=;
        b=ty7HrBAXoYcUNNCc7iw3EnBTwTmFr6gjgKa7qOCAsx1DyhL2VaCOhpZVsledEdeJzK
         UtQ8jPmmwMASOj7Acp3uYT8qfS6/tcD2u//Q3uU0zn6joeLcgHCXWIBvzUKumdXKKiDj
         Pw+p0j9LTWlfrOawK5EQVnJHsV72UPkSi6pyzRlDTlwkWEKsQYTK63Ji/9STPZt5rdPm
         PyYGR1AXXOi9pkcP1QlJj0nP81GAr0MpY4yqlq4bYG7fmXNpjRvW9/VW+CbrS3n3rq36
         kHrStMDvtgbBaUi6aUGZRmUjxqC1zpK68sA5cWfDDE+Vx+9DFj5s42Eb9gayWcABnvYr
         rX9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1MfMFEkX4yvAliFSNppN+VFlLacMRf73GLGySFvrvQ8=;
        b=KTMY3SR0nU620migsnBdgTibynpP4c+aLIz1Zkcw8sksc7CdinjQhDBkTuupWCoIJy
         mZXS3SdR+qI5Dt4u5xpJKxov+YKAWuo/23OfLZ2Q9VBbukOaHqzoKdbv+S6p33Jb6nGy
         9cXpBr3qQIi9h53EZkv/KidZyl1XlFVFDpLvxyT2F5JDXmhLd2COsBt8fSg4/8AedLyf
         epdt+DVDEQxZimybNNzc/7avrfbVE2V+epfyED+CCLzQBFzGpYBhy12/qsYPsxyb05Bl
         qyqY9ZwWt5mM5nVjn9eOvhGRhX5KQ4VqFhabCdFiTIFjNtrx09q5aZviCe/nhtykovGp
         Rmgg==
X-Gm-Message-State: AOAM533o7AbKZ/GZSzARhoIRH7o7ZI8EMGyUcJfnRR013CYUkc6PYrHI
        PLBb8qoIoxGfoWxyxe8oaPtFqk13GktAN+ZTxtjWqJRSiBYslw==
X-Google-Smtp-Source: ABdhPJwvgZ494xmfuN0jZsBlveK5/JugU5lw42Gh69RvDIJDUZ8x66OTYL95c4z893+0JmDl0XJI3PUGsC54NBmw168=
X-Received: by 2002:a17:90b:3001:: with SMTP id hg1mr24091315pjb.169.1622932574638;
 Sat, 05 Jun 2021 15:36:14 -0700 (PDT)
MIME-Version: 1.0
References: <pull.970.git.1622828605.gitgitgadget@gmail.com>
 <c3bf266cf03a9678933623b48927ee749956218d.1622828605.git.gitgitgadget@gmail.com>
 <CAKiG+9W8Da4bG87VjTKN6m=cX+v_x33YAw8p4MqCfmNinYt1XA@mail.gmail.com>
In-Reply-To: <CAKiG+9W8Da4bG87VjTKN6m=cX+v_x33YAw8p4MqCfmNinYt1XA@mail.gmail.com>
From:   Matt Rogers <mattr94@gmail.com>
Date:   Sat, 5 Jun 2021 18:36:05 -0400
Message-ID: <CAOjrSZsyUi+RAqxXyd6JqzWqO8hMdtwTuWpZy+cKbz654Xu45A@mail.gmail.com>
Subject: Re: [PATCH 2/3] cmake: create compile_commands.json by default
To:     Sibi Siddharthan <sibisiddharthan.github@gmail.com>
Cc:     Matthew Rogers via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>,
        Philip Oakley <philipoakley@iee.email>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Danh Doan <congdanhqx@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jun 4, 2021 at 5:09 PM Sibi Siddharthan
<sibisiddharthan.github@gmail.com> wrote:
>
> On Fri, Jun 4, 2021 at 11:13 PM Matthew Rogers via GitGitGadget
> <gitgitgadget@gmail.com> wrote:
> >
> > A straightforward way to accomplish this is to make it as simple as
> > possible is to enable the generation of the compile_commands.json file,
> > which is supported by many tools such as: clang-tidy, clang-format,
> > sourcetrail, etc.
> >
> > This does come with a small run-time overhead during the configuration
> > step (~6 seconds on my machine):
> >
> >     Time to configure with CMAKE_EXPORT_COMPILE_COMMANDS=TRUE
> >
> >     real    1m9.840s
> >     user    0m0.031s
> >     sys     0m0.031s
> >
> >     Time to configure with CMAKE_EXPORT_COMPILE_COMMANDS=FALSE
> >
> >     real    1m3.195s
> >     user    0m0.015s
> >     sys     0m0.015s
> >
> > This seems like a small enough price to pay to make the project more
> > accessible to newer users.  Additionally there are other large projects
> > like llvm [2] which has had this enabled by default for >6 years at the
> > time of this writing, and no real negative consequences that I can find
> > with my search-skills.
> >
>
> The overhead is actually much smaller than that. In my system it is
> less than 150ms.

Is that 150 ms for the whole process or just the difference between the two
options?  I'm running this on windows via the git bash provided by the
git sdk.

> The first configure takes this long because we generate command-list.h
> and config-list.h.
> This process is really slow under Windows.
>

I used two different build directories for both my invocations specifically
to avoid having to account for cache variables and other side effects
from earlier configurations.  The variation could also be from network
latency since in this test I was downloading vcpkg, etc.

> Thank You,
> Sibi Siddharthan



-- 
Matthew Rogers
