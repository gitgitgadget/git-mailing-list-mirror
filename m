Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2815B1F597
	for <e@80x24.org>; Mon, 16 Jul 2018 22:37:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729583AbeGPXGt (ORCPT <rfc822;e@80x24.org>);
        Mon, 16 Jul 2018 19:06:49 -0400
Received: from mail-yb0-f196.google.com ([209.85.213.196]:41281 "EHLO
        mail-yb0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728742AbeGPXGs (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Jul 2018 19:06:48 -0400
Received: by mail-yb0-f196.google.com with SMTP id s8-v6so16067604ybe.8
        for <git@vger.kernel.org>; Mon, 16 Jul 2018 15:37:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=u9yl4QcPmeRjvddwyUmh9oMDkXTrBXhksI2zXJ064z8=;
        b=BqdYTrjh3mOPmJQWL78x+xbJ60mSbe90n+UbDhVsp1iQIYNbqH8ET8jorw9pBKBlQN
         tr+BoUSoK0k1Jk/KBTOpkkypvJ5COgpRcbDCD6YvCYjlJDwF82rrSGsfibflNlY/69fO
         Rt20pIGTTdubn52NAJYpfRRS5mfJRMoTtgHSnpbjzzhLxtD3QXRG81zxcpphdrokWqS6
         bTooq38r+DyElWVpmHknJZAzaTQJkm+M/fV+4N2FET7ifcgteeLzN23Xb2r8CtChcWB+
         1OPYS5svvuPFeBQC1paqrn3wh3srffeT+TcTJF2Ai7dIV/vldD/FcVRHrNoTudztz8XA
         ehpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=u9yl4QcPmeRjvddwyUmh9oMDkXTrBXhksI2zXJ064z8=;
        b=NVTdZ08qlqw/xMGHyYN87Rs/NZHSqdUtqqlAS5z3FVI+5MaYi9dV0nGtqR90HhmpH/
         4o4Gs7zYmZCbK7NEVm52bqR++cwNaP6RvGHh4YCOq/PzVzqQqrD1MjjAAmbm0vGOCexV
         ntU2egyeEzLCPD8X3T3lgwBlzkLYr7ZusoIcoX/Y2U0HV6SCQYnll+t285EHrNs3Ynwv
         IA+rAeq8Zt1rNOm8AsvYfx+Hr5dyok+kELC9qhQicT77zkCbckzg555RlX8/AR0g3tGz
         FdvFu9eTTbs49He354i+Ywi2Zq/toMJOPkOnIx80o85e88lC+sMRQx6B75n5ggz2y8Mf
         U/Iw==
X-Gm-Message-State: AOUpUlEOzIbY4a08Eo22a6fgS5OpSAhAM9k6uv6qqmx+FSc6w3INuPMC
        2RpotisvcE07Nn4ZUIkVVEff8OTsTEm6j2nhOA7dyA/UcpA=
X-Google-Smtp-Source: AAOMgpfnsAzyPy1p8OYmlznPu4M3h2VEUxLEAU+ycZXy4B503VrSg99Ju+zlN/PRWAWdj2ZrwGmKqn63bTtXBxUpnkE=
X-Received: by 2002:a5b:307:: with SMTP id j7-v6mr9663884ybp.352.1531780638793;
 Mon, 16 Jul 2018 15:37:18 -0700 (PDT)
MIME-Version: 1.0
References: <pull.10.git.gitgitgadget@gmail.com> <816821eec9ba476ccdfbfdf6e3cdd3619743ea2e.1531746012.git.gitgitgadget@gmail.com>
In-Reply-To: <816821eec9ba476ccdfbfdf6e3cdd3619743ea2e.1531746012.git.gitgitgadget@gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Mon, 16 Jul 2018 15:37:08 -0700
Message-ID: <CAGZ79kY5rEUp3Vsi5ux=KaC0t4vrp8UME-CaQtTvnYsizUGfFQ@mail.gmail.com>
Subject: Re: [PATCH 15/16] commit-reach: make can_all_from_reach... linear
To:     gitgitgadget@gmail.com
Cc:     git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jul 16, 2018 at 6:00 AM Derrick Stolee via GitGitGadget
<gitgitgadget@gmail.com> wrote:
>
> Note how the time increases between the two cases in the two versions.
> The new code increases relative to the number of commits that need to be
> walked, but not directly relative to the number of 'from' commits.

Cool!

>  int can_all_from_reach_with_flag(struct object_array *from,
>                                  int with_flag, int assign_flag,
> -                                time_t min_commit_date)
> +                                time_t min_commit_date,
> +                                uint32_t min_generation)
>  {

>         for (i = 0; i < from->nr; i++) {
[...]
> +               parse_commit(list[i]);

parse_commit_or_die or handle the return code?
(or a comment why we specifically are allowed to ignore
the return code here)

[...]
> +                       for (parent = stack->item->parents; parent; parent = parent->next) {
[...]
> +                                       parse_commit(parent->item);

same here.
