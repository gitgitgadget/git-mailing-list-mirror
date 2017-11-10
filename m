Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7430D201C8
	for <e@80x24.org>; Fri, 10 Nov 2017 18:26:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753734AbdKJS0S (ORCPT <rfc822;e@80x24.org>);
        Fri, 10 Nov 2017 13:26:18 -0500
Received: from mail-qt0-f194.google.com ([209.85.216.194]:49731 "EHLO
        mail-qt0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753292AbdKJS0R (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Nov 2017 13:26:17 -0500
Received: by mail-qt0-f194.google.com with SMTP id p44so2443906qtj.6
        for <git@vger.kernel.org>; Fri, 10 Nov 2017 10:26:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=6E4z78wI8Me/kpVbcYQtqCermM6Ejnw5c4rOHvO7Xqo=;
        b=exlg2dLc158sIgKfkVHn4NUjJaT9WR5Pq1aJcOPw2Qpyh0BlQhQGxHkz9+pK7pXvyn
         f3mp9mAw08ZxeDUHehvF92498D/xmJctLN6ngykbNn6lsDGf76sHE8HnjyypDvrAU6kl
         c1v6ve30z4vnISgncvjeTeYcHc5B1nWszRMXYlxlWuO4HJu3bOOJuiBTQxRnb95fUxd5
         TG9zC01UPP/3NQiKrNaCDzPm5vRH/OU9N2fAOm3sQXPBzzOE/2l1zkIe2eU4FNhN1w33
         3DXuvJZmOG3rg7vMzvgjaN1v6c86mgDC/Oen/Kl0XePhpKSgH/N0hRrhKN7/ZD70nmcX
         FeEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=6E4z78wI8Me/kpVbcYQtqCermM6Ejnw5c4rOHvO7Xqo=;
        b=CJsJxIaEqfvRjT+tkba34ynim9wfwRlRdj2F/6IeIN966AK6bMLgS5dEWjZGZaETP7
         sh862KMdQdLRoJRpslOcEfIx41TUXYTuImTO2iTrRsQfcQzIb4XuyGCzZH+jsehxKCtt
         T/AQkHnPWtMihVWd75u/0oOh1hyXIUefR9AYusOB/2EKMpgYRJ3KmOg7+lHguOLQEI0W
         6/pTxpQLdBY/F32VdBaygcqFv0XzNQvJ9d77lin4FvklOtxLp5XYqakDawp9YQM1qPAT
         biISzh8TmlTN89483WrWW2IHVa0XN2kXBxvNnzXRxtG3Y6+UH29bhyZHCqWgSJLPZCo8
         fLTw==
X-Gm-Message-State: AJaThX4qpEW2MaWsRk0g17EokGGaHPP/IswK6qZn3hAZOf0ptVwVVuWk
        x9toy47USHgdFoeTwpJWFDqy2i+LIMsZWCr1+T1b8FEJpvI=
X-Google-Smtp-Source: AGs4zMY8DKmIaoIjKJdBYzGTnUJRx154bWmsgtV+wXsZLl1bZdmu5ngq6+PZrR9SmROvnsoh3kXAIneOD4eV4FZl6B0=
X-Received: by 10.200.54.86 with SMTP id n22mr1970996qtb.224.1510338376331;
 Fri, 10 Nov 2017 10:26:16 -0800 (PST)
MIME-Version: 1.0
Received: by 10.140.102.70 with HTTP; Fri, 10 Nov 2017 10:26:15 -0800 (PST)
In-Reply-To: <20171110173956.25105-3-newren@gmail.com>
References: <20171110173956.25105-1-newren@gmail.com> <20171110173956.25105-3-newren@gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Fri, 10 Nov 2017 10:26:15 -0800
Message-ID: <CAGZ79kbqxA9U7EsU6_i895vgrTUwmqv8f02NCoUqPS1_nD2PtA@mail.gmail.com>
Subject: Re: [PATCH 2/4] Remove silent clamp of renameLimit
To:     Elijah Newren <newren@gmail.com>
Cc:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Nov 10, 2017 at 9:39 AM, Elijah Newren <newren@gmail.com> wrote:
> In commit 0024a5492 (Fix the rename detection limit checking; 2007-09-14),
> the renameLimit was clamped to 32767.  This appears to have been to simply
> avoid integer overflow in the following computation:
>
>    num_create * num_src <= rename_limit * rename_limit
>
> although it also could be viewed as a hardcoded bound on the amount of CPU
> time we're willing to allow users to tell git to spend on handling
> renames.  An upper bound may make sense, particularly as the computation
> is O(rename_limit^2), but only if the bound is documented and communicated
> to the user -- neither of which were true.
>
> In fact, the silent clamping of the renameLimit to a smaller value and
> lack of reporting of the needed renameLimit when it was too large made it
> appear to the user as though they had used a high enough value; however,
> git would proceed to mess up the merge or cherry-pick badly based on the
> lack of rename detection.  Some hardy folks, despite the lack of feedback
> on the correct limit to choose, were desperate enough to repeatedly retry
> their cherry-picks with increasingly larger renameLimit values (going
> orders of magnitude beyond the built-in limit of 32767), but were
> consistently met with the same failure.
>
> Although large limits can make things slow, we have users who would be
> ecstatic to have a small five file change be correctly cherry picked even
> if they have to manually specify a large limit and it took git ten minutes
> to compute it.
>
> Signed-off-by: Elijah Newren <newren@gmail.com>
> ---
>  diff.c            |  2 +-
>  diffcore-rename.c | 11 ++++-------
>  2 files changed, 5 insertions(+), 8 deletions(-)
>
> diff --git a/diff.c b/diff.c
> index 6fd288420b..c6597e3231 100644
> --- a/diff.c
> +++ b/diff.c
> @@ -5524,7 +5524,7 @@ void diff_warn_rename_limit(const char *varname, int needed, int degraded_cc)
>                 warning(_(rename_limit_warning));
>         else
>                 return;
> -       if (0 < needed && needed < 32767)
> +       if (0 < needed)
>                 warning(_(rename_limit_advice), varname, needed);
>  }
>
> diff --git a/diffcore-rename.c b/diffcore-rename.c
> index 0d8c3d2ee4..7f9a463f5a 100644
> --- a/diffcore-rename.c
> +++ b/diffcore-rename.c
> @@ -391,14 +391,10 @@ static int too_many_rename_candidates(int num_create,
>          * growing larger than a "rename_limit" square matrix, ie:
>          *
>          *    num_create * num_src > rename_limit * rename_limit
> -        *
> -        * but handles the potential overflow case specially (and we
> -        * assume at least 32-bit integers)
>          */
> -       if (rename_limit <= 0 || rename_limit > 32767)
> -               rename_limit = 32767;
>         if ((num_create <= rename_limit || num_src <= rename_limit) &&
> -           (num_create * num_src <= rename_limit * rename_limit))
> +           ((double)num_create * (double)num_src
> +            <= (double)rename_limit * (double)rename_limit))
>                 return 0;

From a technical perspective, I would think that if
(num_create <= rename_limit || num_src <= rename_limit)
holds true, that the double-cast condition would also be always true?
Could we just remove that last check?

Or phrased differently, if we can cast to double and extend the check
here, do we have to adapt code at other places as well?

>
>         options->needed_rename_limit =
> @@ -415,7 +411,8 @@ static int too_many_rename_candidates(int num_create,
>                 num_src++;
>         }
>         if ((num_create <= rename_limit || num_src <= rename_limit) &&
> -           (num_create * num_src <= rename_limit * rename_limit))
> +           ((double)num_create * (double)num_src
> +            <= (double)rename_limit * (double)rename_limit))
>                 return 2;
>         return 1;
>  }
> --
> 2.15.0.5.g9567be9905
>
