Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 757731F404
	for <e@80x24.org>; Fri, 13 Apr 2018 18:22:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751032AbeDMSW0 (ORCPT <rfc822;e@80x24.org>);
        Fri, 13 Apr 2018 14:22:26 -0400
Received: from mail-yb0-f177.google.com ([209.85.213.177]:39697 "EHLO
        mail-yb0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750928AbeDMSWZ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Apr 2018 14:22:25 -0400
Received: by mail-yb0-f177.google.com with SMTP id g197-v6so4758627ybf.6
        for <git@vger.kernel.org>; Fri, 13 Apr 2018 11:22:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=q2H4Mtte1TZCVnwP9ekfo2yAhg2NbwvFL39h03Zuy4s=;
        b=H+ZHZfiJfA5BnrBWWyZJWmqD4FABy5O1CZQKUODWLDyXSh+bTESL0HGQxudf3gZe4d
         0FYOVf3bg6RAnv2szez1oCTdrN9WKTioxcbX3PHpunXDfexnnS78jG01IyOSr4TzeCzz
         ObmZSzNC7MO9noi4bXGvSpK4amUUyNc1uD0UeiezA2IDuhRF4RJ4Kq+TTokh/+QFWk1a
         YMRlbyzMi+4tQ5gSWr46cMOw6b/xYz4i+ZZvwbOCINREMq3P0vYp70l+RIm9EO3BM4Yz
         yvS0xNjro1t8KslyoyffyufqKBvVfoVKIuDHbF8/2yBxAgoR91yBoNDvlr9jDlJC8kUC
         sc1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=q2H4Mtte1TZCVnwP9ekfo2yAhg2NbwvFL39h03Zuy4s=;
        b=rVeWsCYkXYxxBairk8QpCnQOXwaExPC0zwonuDtEPH9y6UKdElmQmBlWdfS9ufR2L4
         jbOtEcCmDNntWBJBqxazEk7reyTb/R5w16QiEXLS1WznFmOYTadGYWEhh53HmlD0CiM+
         Xd829kon0KVMoc2EKKQUWEEm7KpHMzlVED8ea3mhgoGFWwAOJ+QVGGJWq+TUtz43NKeV
         pAzxHbJJdtEk0oHuTNGE/gz4kM7rpAnVnqUreBSwLFo1az5ixrVXnMwTfu2+kiUneGdJ
         1Ex2hwi3CSguLpVbgQBtjar+tVYffk+ky819Tkl038/PtfeAXVEy6WOrM9gBP7t/8p8o
         iP1Q==
X-Gm-Message-State: ALQs6tDRiX1mNtApYKR2ALnIRdJfQTKk6eR6vBS5++HcDx5YH/kXdVGC
        5PKwaafuE8l4N4zbpdje9BIg7ZzKDO6TP3H8e//USw==
X-Google-Smtp-Source: AIpwx48iBCTklQbxvlhuycnEhvXPPDFjWO+5tZ/m6icrLwIZqBKpmuMFstaxgjwLw9foxGbPe1WTPVlNz3ApUBOJHa8=
X-Received: by 2002:a25:2704:: with SMTP id n4-v6mr5654698ybn.167.1523643744006;
 Fri, 13 Apr 2018 11:22:24 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:cf81:0:0:0:0:0 with HTTP; Fri, 13 Apr 2018 11:22:23
 -0700 (PDT)
In-Reply-To: <0f0942043678fe76f8d654306482ee26fac643f0.1523617836.git.johannes.schindelin@gmx.de>
References: <0f0942043678fe76f8d654306482ee26fac643f0.1523617836.git.johannes.schindelin@gmx.de>
From:   Stefan Beller <sbeller@google.com>
Date:   Fri, 13 Apr 2018 11:22:23 -0700
Message-ID: <CAGZ79kbEec_U5wL_aOS5O_3+ZOshGwARALpjz801h-fRx-zotA@mail.gmail.com>
Subject: Re: [PATCH] Deprecate support for .git/info/grafts
To:     Johannes Schindelin <johannes.schindelin@gmx.de>
Cc:     git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Jakub Narebski <jnareb@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Johannes,

On Fri, Apr 13, 2018 at 4:11 AM, Johannes Schindelin
<johannes.schindelin@gmx.de> wrote:
> The grafts feature was a convenient way to "stich together" ancient
> history to the fresh start of linux.git.

Did you mean: stitch?

> Its implementation is, however, not up to Git's standards, as there are
> too many ways where it can lead to surprising and unwelcome behavior.
>
> For example, when pushing from a repository with active grafts, it is
> possible to miss commits that have been "grafted out", resulting in a
> broken state on the other side.
>
> Also, the grafts feature is limited to "rewriting" commits' list of
> parents, it cannot replace anything else.
>
> The much younger feature implemented as `git replace` set out to remedy
> those limitations and dangerous bugs.
>
> Seeing as `git replace` is pretty mature by now, it is time to deprecate
> support for the graft file, and to retire it eventually.

It seems that the maturity needed for this commit was reached in
4228e8bc98 (replace: add --graft option, 2014-07-19)

Reviewed-by: Stefan Beller <sbeller@google.com>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---

>                 return -1;
> +       if (advice_graft_file_deprecated)
> +               advise(_("Support for <GIT_DIR>/info/grafts is deprecated\n"
> +                        "and will be removed in a future Git version.\n"
> +                        "\n"
> +                        "Please use \"git replace --graft [...]\" instead.\n"
> +                        "\n"
> +                        "Turn this message off by running\n"
> +                        "\"git config advice.graftFileDeprecated false\""));

So the user would have to run:

  for line in <GIT_DIR>/info/grafts:
      git replace --graft $line
      # The order in the grafts file is the same as the arguments,
      # but we'd have to pass each as its own argument
  rm <GIT_DIR>/info/grafts

I wonder if we want to offer a migration tool or just leave it
at this hint.

Thanks,
Stefan
