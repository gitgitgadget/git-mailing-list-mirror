Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4199A1F42D
	for <e@80x24.org>; Sun, 25 Mar 2018 08:38:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751692AbeCYIh6 (ORCPT <rfc822;e@80x24.org>);
        Sun, 25 Mar 2018 04:37:58 -0400
Received: from mail-qk0-f172.google.com ([209.85.220.172]:33624 "EHLO
        mail-qk0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751007AbeCYIhz (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 25 Mar 2018 04:37:55 -0400
Received: by mail-qk0-f172.google.com with SMTP id d206so4825991qkb.0
        for <git@vger.kernel.org>; Sun, 25 Mar 2018 01:37:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=cwVfoPA5wrQFLB9iBLZ0snahM7hbuqai9/h+beAda74=;
        b=fxCwVtQsiAktuYuIPNAxW+jEumlAldcsDpsBKyDv7Y1N2yE7yyCO/7AGt3GeYgxWZp
         n4ZwBfGqZUkpPpa/T5C3pwpPc8ll8zKyyXXqBDSXzemljN37WEEz3iTFXp3e45rIlVRu
         PsFurEhF3tFbE3I6O98q9jJO8hq6A5tVP16oEUnHB/WZwhQ4+1VfGYo0B7Jf5O/yDuvw
         Qi95WnysDyHR4DLOrW8yV7Maw28aomhBgw0KOVDD9fUGJ1YGcvPjVNtqbLAEjmIALxES
         6P+CdXpOPG3QO/p3O5EjzykkLw4/Qc6vMEKFcD0AkglwwcaSOeUINZO99TuCDk+3BKWv
         aGNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc:content-transfer-encoding;
        bh=cwVfoPA5wrQFLB9iBLZ0snahM7hbuqai9/h+beAda74=;
        b=PnRF1z93NX/msCDantsmmcVlU7nDNY8Vya8lAPe/XngOX6eDyujgZrR48tmBTmpe1k
         ZGwgPHfQfBUwX5MHvbGjUbLTmNuza3AG1WRvfsHkNQ+uED5Bo1qCnKIh3VbWdLS6aN7K
         Dnfh0DB/ic+HWuNCG4CYqcxOtwwi3uEzWvJJo+VtHMPITvGFIU4FFe7vX3ET1NbwZyzI
         lg5f4hbz9tt/ihZmfmMvDI4q8MFLc6AVdrDiGja6Myx1DHGOl1PZn0tZFgDOWmnr0ZBz
         grfnwwCAYYgWGPQ0NI90ahTMVXDjyXFbNfpmw1nkXm6qX7HSu9vmwIadCJgna1LWTp5t
         dICg==
X-Gm-Message-State: AElRT7HU0IdDzcHHJJK6FImLRhbLbqmmd9JPD4u+o/75OBd5ZvvhlsaM
        I0FiDJ3rei6TUr76X1PSIZAqBk7aYbooUUywMFw=
X-Google-Smtp-Source: AG47ELuWHFRCQAjvdNeLHnpR27A9Emus7VKc/RYvrBiLR2Ut7pbjOkFdzxVWpptb3rQsqWjSMk2c2ZCYcLXLBE2JpHs=
X-Received: by 10.55.198.217 with SMTP id s86mr48742103qkl.153.1521967074799;
 Sun, 25 Mar 2018 01:37:54 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.12.174.202 with HTTP; Sun, 25 Mar 2018 01:37:54 -0700 (PDT)
In-Reply-To: <20180323150150.31186-1-predatoramigo@gmail.com>
References: <CAPig+cRnO6e5B=mYAfkt7bdgit2uOJk1a+CAahQ2+uRRbPAObQ@mail.gmail.com>
 <20180323150150.31186-1-predatoramigo@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Sun, 25 Mar 2018 04:37:54 -0400
X-Google-Sender-Auth: DJIR11zoXPiuxBtKpRvE8znz-UE
Message-ID: <CAPig+cS3GjYo+5C_W6WqzK3RP=W+918E6Cz=FSvHky6EWCEZPA@mail.gmail.com>
Subject: Re: [GSoC][PATCH v4] test: avoid pipes in git related commands for test
To:     Pratik Karki <predatoramigo@gmail.com>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Mar 23, 2018 at 11:01 AM, Pratik Karki <predatoramigo@gmail.com> wr=
ote:
> I hope this follow-on patch[1] is ready for merge.

This iteration appears to address review comments from the last few
rounds, however, see below for a few new ones...

> Avoid using pipes downstream of Git commands since the exit codes
> of commands upstream of pipes get swallowed, thus potentially
> hiding failure of those commands. Instead, capture Git command
> output to a file and apply the downstream command(s) to that file.
>
> Signed-off-by: Pratik Karki <predatoramigo@gmail.com>
> ---
> diff --git a/t/t5510-fetch.sh b/t/t5510-fetch.sh
> @@ -840,8 +840,8 @@ test_expect_success C_LOCALE_OUTPUT 'fetch aligned ou=
tput' '
>         test_commit looooooooooooong-tag &&
>         (
>                 cd full-output &&
> -               git -c fetch.output=3Dfull fetch origin 2>&1 | \
> -                       grep -e "->" | cut -c 22- >../actual
> +               git -c fetch.output=3Dfull fetch origin >actual2 2>&1 &&
> +               grep -e "->" actual2 | cut -c 22- >../actual

The file "actual2" is clearly distinct from the file "../actual", so
inventing a name ("actual2") isn't particularly helping; you could
just as easily also name it "actual" without hurting comprehension.
(Not necessarily worth a re-roll.)

>         ) &&
> @@ -855,8 +855,8 @@ test_expect_success C_LOCALE_OUTPUT 'fetch compact ou=
tput' '
>         test_commit extraaa &&
>         (
>                 cd compact &&
> -               git -c fetch.output=3Dcompact fetch origin 2>&1 | \
> -                       grep -e "->" | cut -c 22- >../actual
> +               git -c fetch.output=3Dcompact fetch origin >actual2 2>&1 =
&&
> +               grep -e "->" actual2 | cut -c 22- >../actual

Same comment.

>         ) &&
> diff --git a/t/t9350-fast-export.sh b/t/t9350-fast-export.sh
> @@ -74,11 +74,12 @@ test_expect_success 'iso-8859-1' '
>         git commit -s -m den file &&
> -       git fast-export wer^..wer |
> -               sed "s/wer/i18n/" |
> +       git fast-export wer^..wer >actual &&
> +       sed "s/wer/i18n/" actual |
>                 (cd new &&
>                  git fast-import &&
> -                git cat-file commit i18n | grep "=C3=81=C3=A9=C3=AD =C3=
=B3=C3=BA")
> +                git cat-file commit i18n >actual &&
> +                grep "=C3=81=C3=A9=C3=AD =C3=B3=C3=BA" actual)

It was a bit surprising to see a new "actual" file created inside the
subshell even as 'sed' is processing a file named "actual" outside the
subshell, and, as a reader, I was concerned about bad interaction
between the operations. However, the file in the subshell is really
"new/actual", thus is distinct from the other "actual", so it's okay.

This is one of those cases, however, in which it might make sense to
give the files different names to make the code easier to grok, so
future readers don't stumble over this as well. For instance, the
outer file could be named "iso8859-1.fi" (or something), and the file
in the subshell can remain "actual". Not itself worth a re-roll, but
probably a good idea.

(This differs in couple ways from my comment above about t5510 tests
naming files "actual2" and "../actual". In that case, it was quite
clear that, within the cd'd subshell, file "../actual" was distinct
from the file created within the cd'd directory, so no confusion.
Moreover, those files were not being accessed at the same time,
whereas in this t9350 test, the 'sed' is reading from the a file at
the same time as 'git cat-file' is outputting to a similarly named
file, which is potentially confusing and requires extra brain cycles
to sort out.)

>  '
> @@ -87,18 +88,16 @@ test_expect_success 'import/export-marks' '
>         test_line_count =3D 3 tmp-marks &&
> -       test $(
> -               git fast-export --import-marks=3Dtmp-marks\
> -               --export-marks=3Dtmp-marks HEAD |
> -               grep ^commit |
> +       git fast-export --import-marks=3Dtmp-marks \
> +               --export-marks=3Dtmp-marks HEAD >actual &&
> +       test $(grep ^commit actual |
>                 wc -l) \
>         -eq 0 &&

Since the git-fast-export invocation has been pulled out of the
$(...), the entire 'test' expression is now short enough to fit easily
on one line. Making such a change would improve readability
considering how hard it is to read split over three lines like that
(with inconsistent indentation, moreover):

    test $(grep ^commit actual | wc -l) -eq 0 &&

>         echo change > file &&
>         git commit -m "last commit" file &&
> -       test $(
> -               git fast-export --import-marks=3Dtmp-marks \
> -               --export-marks=3Dtmp-marks HEAD |
> -               grep ^commit\  |
> +       git fast-export --import-marks=3Dtmp-marks \
> +               --export-marks=3Dtmp-marks HEAD >actual &&
> +       test $(grep ^commit\  actual |
>                 wc -l) \
>         -eq 1 &&

Same comment.

>         test_line_count =3D 4 tmp-marks
> @@ -500,13 +501,13 @@ test_expect_success 'refs are updated even if no co=
mmits need to be exported' '
>         git fast-export --import-marks=3Dtmp-marks \
>                 --export-marks=3Dtmp-marks master > /dev/null &&
>         git fast-export --import-marks=3Dtmp-marks \
> -               --export-marks=3Dtmp-marks master > actual &&
> +               --export-marks=3Dtmp-marks master >actual &&

This change is unrelated to the purpose of this patch, thus is noise
which distracts reviewers from real changes. Fixing style problems in
code you're touching is fine (and usually recommended), however, this
code is outside the scope of what the patch should be touching (there
is no piping output of a git command here). Moreover, it doesn't make
sense to fix only "> actual" but not "> /dev/null" just above it.
Consequently, this change should be dropped from the patch.

>         test_cmp expected actual
>  '
