Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C7CAC433FE
	for <git@archiver.kernel.org>; Fri, 15 Oct 2021 17:06:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 09B656108B
	for <git@archiver.kernel.org>; Fri, 15 Oct 2021 17:06:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241997AbhJORIP (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 15 Oct 2021 13:08:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242026AbhJORIL (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Oct 2021 13:08:11 -0400
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70FE9C061570
        for <git@vger.kernel.org>; Fri, 15 Oct 2021 10:06:05 -0700 (PDT)
Received: by mail-pg1-x54a.google.com with SMTP id 80-20020a630753000000b002997713c266so2525614pgh.9
        for <git@vger.kernel.org>; Fri, 15 Oct 2021 10:06:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=jq7YX6Cz5PXf1dCXGqIjB4ct95t4Tb6rR3NXxFFQUI8=;
        b=QS5VKEiWTGQ62AJzoDQf09d7N2r2zHqC7svT5TxUHhEVbgVSH/hIiBFSyuYgxQUd2n
         fNir/yJROAG4NFvi8dEkEPfTtx3aBW8wyOoFDLXEic9LveQ1QUG5D0JUmRWcMGy6rp7Y
         hzZp7r6chhhVito6C+tQRiXhg6g/MyX2X0+ULxvMLxO8L96Wp4T0AqsF/JztUTUE1BXR
         jQv8KUNP5fs54mgIWE3vkhjsVYui6/xG8jcgMRbfbopSi9bCeA1xhZEK/Q4Vm625x0v7
         pHU/RqeDYDHiBIeTTvWOfTFlVgUO74xUPPJdY2/XXWylCFMliQ7YQIVFg2UxXCY59+FE
         y4cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=jq7YX6Cz5PXf1dCXGqIjB4ct95t4Tb6rR3NXxFFQUI8=;
        b=z5nWyxnVs5O184PFsK+nU+lokx9jEc4n+RqCZFJwAv+MdQeAYIUyVjiiMJ/HNn/LVV
         sM6BfwBNm4jP/vRditWQR48ExUyPDttOhPMjI48ZqZYjm5ioWpDkvoMsi/KRMwR6pzID
         0vWM/xeprKugVHzEOKuVi9b0CvmxmsUfc680AjHe2FNwwP92CechTfixt1hjYQNo05jq
         wdfkD13t4ldbFxRQxo34jKC42DJS1F41GMhjq9B7q0HBCZDTPJGDZZkrRbM/9TgwyTZU
         0rq9/TSTpoJfdHdoFwg98fDqmgcj/GpiYu9+IrrF94aleDUmNdh1mVahU/TojrKdvb3r
         TDkg==
X-Gm-Message-State: AOAM531cnLxON5XwWQR7FNx4IKzQB2zmuQANi2HNDso6axbBZjL828yk
        HLN6ie5Nk3opMv11Xl+NcidlJLsojIXUUA==
X-Google-Smtp-Source: ABdhPJwzYprByV0Ou6Ksb8Qb5zMphNq6Kgz2GawxWMyCRvxEL/bl4/D7hgL2AcZ48EkxgV2V5x4ikcjNtws/Zw==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a17:90b:23d1:: with SMTP id
 md17mr1855439pjb.215.1634317564330; Fri, 15 Oct 2021 10:06:04 -0700 (PDT)
Date:   Fri, 15 Oct 2021 10:06:01 -0700
In-Reply-To: <20211015122515.47535-1-bagasdotme@gmail.com>
Message-Id: <kl6l4k9i1ame.fsf@chooglen-macbookpro.roam.corp.google.com>
Mime-Version: 1.0
References: <20211015122515.47535-1-bagasdotme@gmail.com>
Subject: Re: [PATCH v2] Documentation: specify base point when generating
 MyFirstContribution patchset
From:   Glen Choo <chooglen@google.com>
To:     Bagas Sanjaya <bagasdotme@gmail.com>, git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Carlo Arenas <carenas@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Bagas Sanjaya <bagasdotme@gmail.com> writes:

> diff --git a/Documentation/MyFirstContribution.txt b/Documentation/MyFirstContribution.txt
> index b20bc8e914..5aaf31cb66 100644
> --- a/Documentation/MyFirstContribution.txt
> +++ b/Documentation/MyFirstContribution.txt
> @@ -937,6 +937,23 @@ but want reviewers to look at what they have so far. You can add this flag with
>  Check and make sure that your patches and cover letter template exist in the
>  directory you specified - you're nearly ready to send out your review!
>  
> +It would help those who review and test your patches to specify on what
> +commit the patches should be applied to. To do so, use the `--base` option
> +when running `format-patch`. The option expects hash of the commit the
> +patchset is based on. Since we base `psuh` on top of `master`, the base
> +commit hash can be determined by: 
> +
> +----
> +$ git show -s --format="%H" master
> +----
> +
> +The output of command above can be passed to `--base` option. Replace `<base>`
> +with your own hash:
> +
> +----
> +$ git format-patch --cover-letter --base=<base> -o psuh/ master..psuh
> +----
> +
>  [[cover-letter]]
>  === Preparing Email

This reads quite awkwardly because a few lines above, we already tell
the reader exactly what commands to run:

  Sending emails with Git is a two-part process; before you can prepare the emails
  themselves, you'll need to prepare the patches. Luckily, this is pretty simple:

  ----
  $ git format-patch --cover-letter -o psuh/ master..psuh
  ----

If we do accept this suggestion (and I am not sure if we should, because
as Junio said, there are strong conventions for determining the branch
point), I think this would be easier to follow if we incorporate it into
the existing instructions. Something like..

  Sending emails with Git is a two-part process; before you can prepare the emails
  themselves, you'll need to prepare the patches. Luckily, this is
  pretty simple. First, we'll get the hash of the commit the patchset is
  based on. We call this commit the 'base'.

  ----
  $ git show -s --format="%H" master
  ----

  Now, we'll generate the patches, passing the hash of the 'base' to the
  --base option.

  ----
  $ git format-patch --cover-letter --base=<base> -o psuh/ master..psuh
  ----

  [...describe --base=<base> the way we describe the other options].
