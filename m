Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18E8AC05027
	for <git@archiver.kernel.org>; Thu,  9 Feb 2023 07:50:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229602AbjBIHu6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Feb 2023 02:50:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjBIHu4 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Feb 2023 02:50:56 -0500
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BCA710AB8
        for <git@vger.kernel.org>; Wed,  8 Feb 2023 23:50:55 -0800 (PST)
Received: by mail-lj1-x22c.google.com with SMTP id u27so1086485ljo.12
        for <git@vger.kernel.org>; Wed, 08 Feb 2023 23:50:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=06M46ZYHOYHkz0sVqXq/k11ozbH47lDeAySHplcVR1M=;
        b=Q3EB3JqEI80eUx7qGGJuZXPqtUnuZv9D/hERyH4DpApZ8s9WqgRVDQNifpyBDtSHNM
         J8iDlNaWYskKKMmUk7LREuDtbnQkylEO6/6UeHNsHzJIOeMwSQBq6fN0I3Z1Br/8sk11
         bpsF+Mjx+VYxk05Zzk5y75iz0W7fRFEp/kMnqmimUzrmFjMzO/sRPJrVmSNQvnFyQjkX
         89Im96bE0v8Q10MJXSsNLzpXAARHWKhX2fGbYmT3h8F8u4aoWSLpB9pBkThqhXiYRccK
         pcE1ImL2lapUAvrM/b3fMzhjKPkBzqLbsYeLdIiI8GvZ7t0ASzDoJD3/U7SRfpGxwmhS
         TenQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=06M46ZYHOYHkz0sVqXq/k11ozbH47lDeAySHplcVR1M=;
        b=X37wOf68cgEaJrJ6OevcF4zuzTOUR7YGZEZITZoTG0eo8uVSs/TSjyI/p/IGVNz2UL
         UNXDEbYdgF+u1HKUxAkgUTitk55Bdw4L3t0jvF1Dg/gtsaGCkN9eFdDGJLC8Xa1Pbal/
         SOolkZ1RCClhC+tZLb5pYA2EFGLvKA/EV8/K5qAajsvAvOGY48tEJnhVu9v3oNIjJrt5
         z7nVnO8bkX3lOVumsm0Ge93cmWjHzBgsFrV91oDnIj2O9gF2gsB6Y/q3n92YFh82f2za
         lcJKYuuhHFWWl0LBXfCtSh3Q8afCFDowBA4Q3TA6y7QJw0AxqSzfwODDXJUKvV3A4Dko
         W+Ew==
X-Gm-Message-State: AO0yUKUrXV1jTU7bJVE195dZmQMZdcoDJnYtPE0vAowHSB2eiRLGoWP8
        mez9siTR5olM65Tjgf9EivaYTGbot8YpNxX9aaoA/1GXuu8=
X-Google-Smtp-Source: AK7set/1qYX1robTDINHFrhM4thnmkTlHKHh7Ce8hQkmA+9fmZntcplfez0kWWnhlaIw6njMTFVQNeyZNXKqQZusAFA=
X-Received: by 2002:a2e:380a:0:b0:282:9ddb:546e with SMTP id
 f10-20020a2e380a000000b002829ddb546emr1681899lja.6.1675929053504; Wed, 08 Feb
 2023 23:50:53 -0800 (PST)
MIME-Version: 1.0
References: <pull.1452.git.git.1675568781.gitgitgadget@gmail.com>
 <8e73793b0db3e84366a9c6441cc0fdc04f9614a5.1675568781.git.gitgitgadget@gmail.com>
 <230206.865yce7n1w.gmgdl@evledraar.gmail.com>
In-Reply-To: <230206.865yce7n1w.gmgdl@evledraar.gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Wed, 8 Feb 2023 23:50:41 -0800
Message-ID: <CABPp-BGdKjnChEp4zeCcz24wiEJVJb9Tp40MTWn1m0LRZu+M+Q@mail.gmail.com>
Subject: Re: [PATCH 2/2] diff: teach diff to read gitattribute diff-algorithm
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     John Cai via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, John Cai <johncai86@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Feb 6, 2023 at 9:24 AM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avar=
ab@gmail.com> wrote:
>
> On Sun, Feb 05 2023, John Cai via GitGitGadget wrote:
>
> > From: John Cai <johncai86@gmail.com>
> > [...]
> > +
> > +             if (!o->xdl_opts_command_line) {
> > +                     static struct attr_check *check;
> > +                     const char *one_diff_algo;
> > +                     const char *two_diff_algo;
> > +
> > +                     check =3D attr_check_alloc();
> > +                     attr_check_append(check, git_attr("diff-algorithm=
"));
> > +
> > +                     git_check_attr(the_repository->index, NULL, one->=
path, check);
> > +                     one_diff_algo =3D check->items[0].value;
> > +                     git_check_attr(the_repository->index, NULL, two->=
path, check);
> > +                     two_diff_algo =3D check->items[0].value;
> > +
> > +                     if (!ATTR_UNSET(one_diff_algo) && !ATTR_UNSET(two=
_diff_algo) &&
> > +                             !strcmp(one_diff_algo, two_diff_algo))
> > +                             set_diff_algorithm(o, one_diff_algo);
> > +
> > +                     attr_check_free(check);
>
> This is a bit nitpicky, but I for one would find this much easier to
> read with some shorter variables, here just with "a" rather than
> "one_diff_algo", "b" instead of "two_diff_algo", and splitting
> "the_repository->index" into "istate" (untested):
>
>         +               if (!o->xdl_opts_command_line) {
>         +                       static struct attr_check *check;
>         +                       const char *a;
>         +                       const char *b;
>         +                       struct index_state *istate =3D the_reposi=
tory->index;
>         +
>         +                       check =3D attr_check_alloc();
>         +                       attr_check_append(check, git_attr("diff-a=
lgorithm"));
>         +
>         +                       git_check_attr(istate, NULL, one->path, c=
heck);
>         +                       a =3D check->items[0].value;
>         +                       git_check_attr(istate, NULL, two->path, c=
heck);
>         +                       b =3D check->items[0].value;
>         +
>         +                       if (!ATTR_UNSET(a) && !ATTR_UNSET(b) && !=
strcmp(a, b))
>         +                               set_diff_algorithm(o, a);
>         +
>         +                       attr_check_free(check);
>         +               }
>
> That also nicely keeps the line length shorter.
>
> > @@ -333,6 +333,8 @@ struct diff_options {
> >       int prefix_length;
> >       const char *stat_sep;
> >       int xdl_opts;
> > +     /* If xdl_opts has been set via the command line. */
> > +     int xdl_opts_command_line;
> >
> >       /* see Documentation/diff-options.txt */
> >       char **anchors;
> > diff --git a/t/lib-diff-alternative.sh b/t/lib-diff-alternative.sh
> > index 8d1e408bb58..630c98ea65a 100644
> > --- a/t/lib-diff-alternative.sh
> > +++ b/t/lib-diff-alternative.sh
> > @@ -107,8 +107,27 @@ EOF
> >
> >       STRATEGY=3D$1
> >
> > +     test_expect_success "$STRATEGY diff from attributes" '
> > +             echo "file* diff-algorithm=3D$STRATEGY" >.gitattributes &=
&
> > +             test_must_fail git diff --no-index file1 file2 > output &=
&
> > +             test_cmp expect output
> > +     '
> > +
> >       test_expect_success "$STRATEGY diff" '
> > -             test_must_fail git diff --no-index "--$STRATEGY" file1 fi=
le2 > output &&
> > +             test_must_fail git diff --no-index "--diff-algorithm=3D$S=
TRATEGY" file1 file2 > output &&
>
> Nit: The usual style is ">output", not "> output".
>
> > +             test_cmp expect output
> > +     '
> > +
> > +     test_expect_success "$STRATEGY diff command line precedence befor=
e attributes" '
> > +             echo "file* diff-algorithm=3Dmeyers" >.gitattributes &&
> > +             test_must_fail git diff --no-index "--diff-algorithm=3D$S=
TRATEGY" file1 file2 > output &&
> > +             test_cmp expect output
> > +     '
> > +
> > +     test_expect_success "$STRATEGY diff attributes precedence before =
config" '
> > +             git config diff.algorithm default &&
> > +             echo "file* diff-algorithm=3D$STRATEGY" >.gitattributes &=
&
> > +             test_must_fail git diff --no-index "--diff-algorithm=3D$S=
TRATEGY" file1 file2 > output &&
> >               test_cmp expect output
> >       '
> >
> > @@ -166,5 +185,11 @@ EOF
> >               test_must_fail git diff --no-index "--$STRATEGY" uniq1 un=
iq2 > output &&
> >               test_cmp expect output
> >       '
> > +
> > +     test_expect_success "$STRATEGY diff from attributes" '
> > +             echo "file* diff-algorithm=3D$STRATEGY" >.gitattributes &=
&
> > +             test_must_fail git diff --no-index uniq1 uniq2 > output &=
&
> > +             test_cmp expect output
> > +     '
> >  }
>
> For some non-nitpicking, I do worry about exposing this as a DoS vector,
> e.g. here's a diff between two distant points in git.git with the
> various algorithms:
>
>         $ hyperfine -r 1 -L a patience,minimal,histogram,myers 'git diff =
--diff-algorithm=3D{a} v2.0.0 v2.28.0'
>         Benchmark 1: git diff --diff-algorithm=3Dpatience v2.0.0 v2.28.0
>           Time (abs =E2=89=A1):        42.121 s               [User: 41.8=
79 s, System: 0.144 s]
>
>         Benchmark 2: git diff --diff-algorithm=3Dminimal v2.0.0 v2.28.0
>           Time (abs =E2=89=A1):        35.634 s               [User: 35.4=
73 s, System: 0.160 s]
>
>         Benchmark 3: git diff --diff-algorithm=3Dhistogram v2.0.0 v2.28.0
>           Time (abs =E2=89=A1):        46.912 s               [User: 46.6=
57 s, System: 0.228 s]
>
>         Benchmark 4: git diff --diff-algorithm=3Dmyers v2.0.0 v2.28.0
>           Time (abs =E2=89=A1):        33.233 s               [User: 33.0=
72 s, System: 0.160 s]
>
>         Summary
>           'git diff --diff-algorithm=3Dmyers v2.0.0 v2.28.0' ran
>             1.07 times faster than 'git diff --diff-algorithm=3Dminimal v=
2.0.0 v2.28.0'
>             1.27 times faster than 'git diff --diff-algorithm=3Dpatience =
v2.0.0 v2.28.0'
>             1.41 times faster than 'git diff --diff-algorithm=3Dhistogram=
 v2.0.0 v2.28.0'

I'm really surprised by these numbers; they aren't remotely close to
what I compute.  Am I correct in understanding you ran these in
git.git?  Was your computer overloaded?  Was your git.git in some
serious need of repacking?  Was it on a network filesystem?  If you
run with more than 1 run, are your numbers even repeatable?

Using git compiled from current main, I see:

$ hyperfine -L a patience,minimal,histogram,myers './git diff
--diff-algorithm=3D{a} v2.0.0 v2.28.0'
Benchmark 1: ./git diff --diff-algorithm=3Dpatience v2.0.0 v2.28.0
  Time (mean =C2=B1 =CF=83):      1.142 s =C2=B1  0.033 s    [User: 1.022 s=
, System: 0.114 s]
  Range (min =E2=80=A6 max):    1.117 s =E2=80=A6  1.212 s    10 runs

Benchmark 2: ./git diff --diff-algorithm=3Dminimal v2.0.0 v2.28.0
  Time (mean =C2=B1 =CF=83):      1.959 s =C2=B1  0.011 s    [User: 1.830 s=
, System: 0.120 s]
  Range (min =E2=80=A6 max):    1.947 s =E2=80=A6  1.976 s    10 runs

Benchmark 3: ./git diff --diff-algorithm=3Dhistogram v2.0.0 v2.28.0
  Time (mean =C2=B1 =CF=83):      1.187 s =C2=B1  0.007 s    [User: 1.065 s=
, System: 0.115 s]
  Range (min =E2=80=A6 max):    1.175 s =E2=80=A6  1.200 s    10 runs

Benchmark 4: ./git diff --diff-algorithm=3Dmyers v2.0.0 v2.28.0
  Time (mean =C2=B1 =CF=83):      1.194 s =C2=B1  0.007 s    [User: 1.068 s=
, System: 0.120 s]
  Range (min =E2=80=A6 max):    1.184 s =E2=80=A6  1.206 s    10 runs

Summary
  './git diff --diff-algorithm=3Dpatience v2.0.0 v2.28.0' ran
    1.04 =C2=B1 0.03 times faster than './git diff
--diff-algorithm=3Dhistogram v2.0.0 v2.28.0'
    1.05 =C2=B1 0.03 times faster than './git diff --diff-algorithm=3Dmyers
v2.0.0 v2.28.0'
    1.71 =C2=B1 0.05 times faster than './git diff --diff-algorithm=3Dminim=
al
v2.0.0 v2.28.0'

And this is on a kind-of low-end refurbished laptop from a few years
ago (although the repo was recently gc'ed).

I'm biased towards histogram (and making it the default rather than
making it configurable per file), but that's probably obvious given
that I made ort use it unconditionally.  And when I made ort use it,
it was actually a minor performance penalty (~1% IIRC)[*], but I
thought it was worth it since (a) histogram diffs are more
understandable to users in general, (b) the histogram diff data
structures provide an idea for possibly solving some ugly corner cases
that I don't see a way to solve with the other diffs.

[*] Phillip came along and made histogram faster after my measurements
(663c5ad035 ("diff histogram: intern strings", 2021-11-17)), so that
may not be true anymore.
