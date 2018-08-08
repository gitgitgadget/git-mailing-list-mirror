Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E91BC1F405
	for <e@80x24.org>; Wed,  8 Aug 2018 18:32:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728434AbeHHUxG (ORCPT <rfc822;e@80x24.org>);
        Wed, 8 Aug 2018 16:53:06 -0400
Received: from mail-yw1-f65.google.com ([209.85.161.65]:42803 "EHLO
        mail-yw1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727295AbeHHUxG (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Aug 2018 16:53:06 -0400
Received: by mail-yw1-f65.google.com with SMTP id y203-v6so2278084ywd.9
        for <git@vger.kernel.org>; Wed, 08 Aug 2018 11:32:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4F9qAnF1jFI058lez68Kxp5D6MpPJ4wvSydfGRTv4Eg=;
        b=e5mnFfVIIy8bTMflV0o1yDu35miT17YVxBQJV5YQK+ETcivbSjRDLZ6UOhWZbGiJ/y
         Y0+BKoEa4nf1f6kZLp2zMzjsNsboPr87WY+mmfqXMczby7Pho/MVC5dsKwjZ+9Vx/3M5
         4OsAl6QxQNOwyKtzVqbBWKuCsbIOGCFOTpUCwMJZkr/T8UA7qYdVipuQE4pVh661EsvV
         mvNADDoPyMtZYt4PtAwCMjzP+x+It40sazVkrPGrXGwR3wwe12Usf63ZQp5Ig1h4QalH
         CpUpAF2u3P3UfeeNRBPWIJ9Husa0drKyodHGj6URSIjy/i9jG63S9oqqA9d3HmTvadCE
         lkpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4F9qAnF1jFI058lez68Kxp5D6MpPJ4wvSydfGRTv4Eg=;
        b=rdE7RmJBjFaFHPdObCCIBMmPMkwSqbivW0zIVvvlcf6c6Uk4uzY57T5tWYYT2vzq2X
         2mFRKdllFIjVd5eq/qcNKSt0C0OzLhc+8K9aaaFygwrKLFWc7Pt2IGUX2OOAMnD/Pce9
         qiVf+URzB0qUGGvXSu5BAC0cNCIZkHJvLh2gX+Vlq7gQ/wlpriUgV7NzVswF2KM3kI3D
         jiNAjbfsAFpPkvtBbP+71jUZCh6TEaFv87eAAgWM9vf1cOPM0svbv9WDtM+AuqamGxpQ
         1HSovgm8FAA15ddm8NHR7P83Q8i56yUJXbaDYrAT/fyFN1/2ODK41A65UxAF+/gRZrIM
         +lVw==
X-Gm-Message-State: AOUpUlEDryN29JxX52rNTB5fN6YCqYPJcn0ttPoRdOjl25/3rowoO5vW
        04LMaER0U40XDsfWIBa0oo8E/IXV5MY3/FGKB0y2sg==
X-Google-Smtp-Source: AA+uWPy0A8fX0Y12xR/zIxdk7bvKnmBtLv2jT+eyV6UlkuqLbdzGEx4ZnjZfwiZvQA72lKeB1+GvlifEOScfAREwY8A=
X-Received: by 2002:a25:7144:: with SMTP id m65-v6mr2078125ybc.352.1533753130275;
 Wed, 08 Aug 2018 11:32:10 -0700 (PDT)
MIME-Version: 1.0
References: <20180808134830.19949-1-predatoramigo@gmail.com> <20180808134830.19949-5-predatoramigo@gmail.com>
In-Reply-To: <20180808134830.19949-5-predatoramigo@gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Wed, 8 Aug 2018 11:31:59 -0700
Message-ID: <CAGZ79kah=sGgzJS1rL6Bx1Vkd6RVFLUNEk_o4iqKsjDx5_arJw@mail.gmail.com>
Subject: Re: [PATCH 04/11] builtin rebase: support --quiet
To:     Pratik Karki <predatoramigo@gmail.com>
Cc:     git <git@vger.kernel.org>,
        Christian Couder <christian.couder@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Alban Gruin <alban.gruin@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Aug 8, 2018 at 6:51 AM Pratik Karki <predatoramigo@gmail.com> wrote:
>
> This commit introduces a rebase option `--quiet`. While `--quiet` is
> commonly perceived as opposite to `--verbose`, this is not the case for
> the rebase command: both `--quiet` and `--verbose` default to `false` if
> neither `--quiet` nor `--verbose` is present.
>
> This commit goes further and introduces `--no-quiet` which is the
> contrary of `--quiet` and it's introduction doesn't modify any
> behaviour.
>
> Note: The `flags` field in `rebase_options` will accumulate more bits in
> subsequent commits, in particular a verbose and a diffstat flag. And as
> --quoet inthe shell scripted version of the rebase command switches off

  --quote in the

(in case a resend is needed)
