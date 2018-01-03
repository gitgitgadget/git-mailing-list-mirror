Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 07D201F406
	for <e@80x24.org>; Wed,  3 Jan 2018 21:02:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751192AbeACVCc (ORCPT <rfc822;e@80x24.org>);
        Wed, 3 Jan 2018 16:02:32 -0500
Received: from mail-vk0-f67.google.com ([209.85.213.67]:45392 "EHLO
        mail-vk0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751099AbeACVCa (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 Jan 2018 16:02:30 -0500
Received: by mail-vk0-f67.google.com with SMTP id o16so1620872vke.12
        for <git@vger.kernel.org>; Wed, 03 Jan 2018 13:02:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=emux8+jJ6sv+BqFeWFM6rqx3R2ZnXk9HCSXQ+jcH5oY=;
        b=MAVFSTostzbstPAmtS7pLucPfdSO/gSOClc8aF53YiLrfehPvbcVk1UrKasoWPQOrR
         +fkhOnXzm1OtRUi9QOi6R6wZLf6Qh60Lr243xPNS3fafQkFzAVHcaMHwUi6zj07uvKNN
         9ahKTf514JuO9W/ktKd/3idWq2T5lcM7bnl5zSgDys4/1jxxAmUYExGp5vKFWS2qoa8e
         m6jvNIJZIMTPYsIAY18rREqR94hEjRP9TTYAfLmHLrjV/FoaMFQGZ/7xkAfGJJJW6rQV
         SL9hOZs89/wtWUs6UkzNlTss4ho4S85ytV1Jxcde9MTijCYm3J9HSo6G+vZe1Zipii/c
         ylPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=emux8+jJ6sv+BqFeWFM6rqx3R2ZnXk9HCSXQ+jcH5oY=;
        b=fPC4WHxTuq84HGFZ7A8E4kf19uKujs2MkZAxOfJhEa0pkgm2/zTVzk9gAhLMxkvhRa
         AOakdMu9A48ZuOTaFJ+tIdKUoLQIsxEzH83ICueDeOXYZjFGlkGAou9pbGly5m99RpbR
         iGwXr4HILZx2hpLq6DMNy0nY41MPwr3l7zMe/yDF1I0+nRcH+4V3KOWNinm6SJnfHNUt
         vs6aXtJwm5zDyWjedGzBsXt1huyVeTSe8UMzK3FW2uGkHvV9ONcd8b569zjOYrcSL0qo
         TmncT3ZN7ZHDWbYXY2PWfN0aIAFROLKEcXn2uJtU3AxU/xYw/7JL2LOS/snPjwC24+sk
         YDYw==
X-Gm-Message-State: AKGB3mLV8Kd4zj5IQdc1Z7OD40t0/VJCC5QsrPZ1c6T8Uck2Xyjo/0mk
        CySC149nIRvvrfjabqsODHBCsmNF0t2/kutzdIE=
X-Google-Smtp-Source: ACJfBou6moef9QpmX1DMqNd4k/lqfpbk46Py2A0wI6J+WfyVcWOnHRsIK9NIJ/De/bWIOzCaItiftmcDdMnnH69EEA0=
X-Received: by 10.31.150.79 with SMTP id y76mr2406691vkd.183.1515013349792;
 Wed, 03 Jan 2018 13:02:29 -0800 (PST)
MIME-Version: 1.0
Received: by 10.176.82.5 with HTTP; Wed, 3 Jan 2018 13:02:29 -0800 (PST)
In-Reply-To: <7ecea1b4-d713-7298-1697-ae25532e26e0@kdbg.org>
References: <20171228041352.27880-1-newren@gmail.com> <CABPp-BEnpm=OEXZXMeuaxBaOLimucoEKH643jm516YufrtQ-iA@mail.gmail.com>
 <7ecea1b4-d713-7298-1697-ae25532e26e0@kdbg.org>
From:   Elijah Newren <newren@gmail.com>
Date:   Wed, 3 Jan 2018 13:02:29 -0800
Message-ID: <CABPp-BF0Tby4+Va_MV-j3kC-phV8D84PJboBhE-AR2pXQMwL2g@mail.gmail.com>
Subject: Re: [PATCH v5 00/34] Add directory rename detection to git
To:     Johannes Sixt <j6t@kdbg.org>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Stefan Beller <sbeller@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Jeff King <peff@peff.net>, Matthieu Moy <Matthieu.Moy@imag.fr>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jan 3, 2018 at 2:57 AM, Johannes Sixt <j6t@kdbg.org> wrote:

> I tested the series on Windows recently. It requires the patch below.
> I don't know whether this is indicating some portability issues of grep
> (^ being used in the middle of a RE instead of at the very beginning) or
> just a quirk in my setup.

Thanks for testing it out.  What version of Windows were you running
on?  With cygwin or without?  I tested previously on cygwin (I think
on Windows Server 2012??) and got all the tests passing there,
eventually[1].  I'm not sure I can find access to any other Windows
systems, but I'd be happy to take a look if I can.

[1] https://public-inbox.org/git/CABPp-BEJ6-mrY0OCz1WWetrtG_iehKzOdCUOn_PUuKVywaU9Zw@mail.gmail.com/

The need to backslash escape a caret for a literal match when it
appears in the middle of the string makes sense.  Thanks for sending
along the patch.  Would you prefer I squashed it into the series
(still sitting in 'pu'), or keep your patch separate?  I'm fine with
either, I'm just unsure the protocol here.

> But it still does not pass the test suite because the system does not
> like file names such as y/c~HEAD:
>
> ++ grep 'Refusing to lose dirty file at z/c' out
> Refusing to lose dirty file at z/c
> ++ grep -q stuff x/b y/a y/c y/c~HEAD z/c
> grep: y/c: Invalid request code
> error: last command exited with $?=2
> not ok 94 - 11d-check: Avoid losing not-uptodate with rename + D/F conflict

This is exceptionally odd.  The actual line from the testsuite was
  grep -q stuff */*

which suggests your shell is both doing the pathname expansion and
treating the resulting filename not as a string but as something to be
interpreted that happens to have some kind of special
characters/commands, and then choking on the result.  Super weird.  I
could probably work around this by just running
  grep -q stuff z/c

I think I had the asterisks in there because I was thinking in terms
of directory rename detection potentially moving the file, but that's
probably just overkill.  Does the test pass for you with that change?
(If so, there are also two similar tests that I'd need to make similar
changes to.)

However, although that might fix this particular case, it suggests
some fragility of the tests and filenames for whatever system you
happen to be using.  merge-recursive.c's unique_path has created
filenames with tilde's in them for many years, it may just be that I'm
the first to use the resulting file in combination with grep to ensure
the contents are as we expect.  There may be other issues lurking
(even if not yet appearing in the testsuite) for your system when
dealing with merge conflicts.


Thanks,
Elijah









>
> ---- 8< ----
> From: Johannes Sixt <j6t@kdbg.org>
> Date: Fri, 22 Dec 2017 09:33:13 +0100
> Subject: [PATCH] fixup directory rename tests
>
> Signed-off-by: Johannes Sixt <j6t@kdbg.org>
> ---
>  t/t6043-merge-rename-directories.sh | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/t/t6043-merge-rename-directories.sh b/t/t6043-merge-rename-directories.sh
> index f0af66b8a9..b8cd428341 100755
> --- a/t/t6043-merge-rename-directories.sh
> +++ b/t/t6043-merge-rename-directories.sh
> @@ -2940,8 +2940,8 @@ test_expect_success '10b-check: Overwrite untracked with dir rename + delete' '
>                 echo contents >y/e &&
>
>                 test_must_fail git merge -s recursive B^0 >out 2>err &&
> -               test_i18ngrep "CONFLICT (rename/delete).*Version B^0 of y/d left in tree at y/d~B^0" out &&
> -               test_i18ngrep "Error: Refusing to lose untracked file at y/e; writing to y/e~B^0 instead" out &&
> +               test_i18ngrep "CONFLICT (rename/delete).*Version B\^0 of y/d left in tree at y/d~B\^0" out &&
> +               test_i18ngrep "Error: Refusing to lose untracked file at y/e; writing to y/e~B\^0 instead" out &&
>
>                 test 3 -eq $(git ls-files -s | wc -l) &&
>                 test 2 -eq $(git ls-files -u | wc -l) &&
> @@ -3010,7 +3010,7 @@ test_expect_success '10c-check: Overwrite untracked with dir rename/rename(1to2)
>
>                 test_must_fail git merge -s recursive B^0 >out 2>err &&
>                 test_i18ngrep "CONFLICT (rename/rename)" out &&
> -               test_i18ngrep "Refusing to lose untracked file at y/c; adding as y/c~B^0 instead" out &&
> +               test_i18ngrep "Refusing to lose untracked file at y/c; adding as y/c~B\^0 instead" out &&
>
>                 test 6 -eq $(git ls-files -s | wc -l) &&
>                 test 3 -eq $(git ls-files -u | wc -l) &&
> --
> 2.14.2.808.g3bc32f2729
