Received: from mail-il1-f174.google.com (mail-il1-f174.google.com [209.85.166.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B3B22773EC
	for <git@vger.kernel.org>; Tue,  9 Sep 2025 08:58:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757408318; cv=none; b=m27Z/xLweR3jDgr9u3TtTexeAY0ESq3PewqLqzZQcBf7KnY9yYymi2iroAi5D9pTSX4tJs3mChHccONJdczT5gbEzuXYBLejBQgtse3MdlA3uFENahBkATjSnN6XgTzFPRJQ6UEaC2gicH/y2Ytzd/48XTTMY9qFCqmpDYlhKW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757408318; c=relaxed/simple;
	bh=pzfOOYCvn40nmg9SBXInMkCtBEszg2mgzLWyXUM8AFU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JSPYIDeqD9bL82BQA+mUaRahGAkXnZp0neIsMsL+o8y8uCBV8hpTHdYuLkLWb5pDcetXHrV8v3zyr3drCL6Q5XWHJ1Jjo5sskmNg5I700R8Zm8XP0bXLpVJzdpSTtNEbU2fOORd3FepqSXfIV52zUAGkE/ycR9bh5EhKyRnrpJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UurZ3ohj; arc=none smtp.client-ip=209.85.166.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UurZ3ohj"
Received: by mail-il1-f174.google.com with SMTP id e9e14a558f8ab-406630d3b17so20271155ab.0
        for <git@vger.kernel.org>; Tue, 09 Sep 2025 01:58:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757408315; x=1758013115; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d1rnCLGwDVH9oM5SMJ6AC99S9fyx1jZVfNUw3opbuMc=;
        b=UurZ3ohjXfFaLi5UO21No7dxGdfvpAyxtLLtYYnXyO9WZ5HSM0TeToeQJPEs38WrsK
         gn8WsBj5cu7d+iv4b4EJuucOweYVQkC6hbGiaOHa27rdqBrVmkPUGP4t5p1eBD3E4IYP
         UYnzZ5P+UXwcyQCyRjdfD8SNargpQNtetRtjJMva/iQ3IWXUMvdNqQn7BqsmQ0E9HnLt
         9ScmzG9f+I9drGDGjJPoMPSwf0A2Yzyf1qQuTnGGw3uxdbZTydK3sgfesChXGcmc3C4+
         OLiX4ZGGYdc9FztgphfB+ln3247jqc7xJY/+cq+h9GuVAv11dQ4wnIbsorlmYFD3IHbr
         +QJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757408315; x=1758013115;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=d1rnCLGwDVH9oM5SMJ6AC99S9fyx1jZVfNUw3opbuMc=;
        b=s5E6ay8vnjHL+0WtPTJkOh5EYK/251Izh2Q0Yxmbg+19x0mgc5gzCaoiSroRYldBxs
         iwfxUh998cUsUFqxTaU9i8R1hvR1+xKFdPUXWJHIYGouBOP1Yhu7L2c8fvMu1f0P8WNS
         7N49sjc4PgyubYry6MHfbyv9xeq4/bz4pCth2TIl7hcp1KKT7GUtkV+18mV0xIyVfyb6
         9pGmHGq+ldg9KCfsF2KBgqCbOALJOVWbB/gJFtrVvNhhKy3RgziMQopwiIP0ktADPXvI
         EhZV9ayf2BfYBk/xxJE4TKp3Cgelh9P7MKhv5r3PKJ1octGa1CEQxeF0Xsb00IGd/E3z
         AuFA==
X-Gm-Message-State: AOJu0YxpYPzlTf78eOg6gSEU9YK1IhMgXZ6ZY0xGestkSHfp5VJTk6s0
	iUBXpP0w/jMlbWAireWc+8tQ5fJ7CR6nLAC01oUjMbl6Ft+8I8FRfhHKPbWzw2tvnSjzs/WslOH
	YKLNcun3ZuBMT6OVdPTCvEGob1V7W2wz2/g==
X-Gm-Gg: ASbGncua5c/YUiawdObN/IsiIsGjE+Zxuk3myJA5p6XfgFV3A5YtFBaWhtGhI1gXarl
	o+k4aIfdVCEANjHj2iv/RjJMupw0m1BFYCaSGR54LD/31j7n758GVlXbehpINqTrS/pF3OPIBdv
	90fylK1ntc29+O4lgDDWHhGTZ35r3R/J/5TAJx5B93WGK8+SU6r0V8ez5ykqHf/B6bLtXVlpbnR
	eBHFDA3LI/5sOqm/cXEf1GdIAaNCytYX8GNCD8=
X-Google-Smtp-Source: AGHT+IGwaRt7ox0BDHbie1KQOT4FowQL/7VRBJFSvfr2Z0fGbRkFYfaNx1PH20r8yM1vtZYURJO+GHABBVqQG8ns6k4=
X-Received: by 2002:a05:6e02:3784:b0:3f3:bbda:d037 with SMTP id
 e9e14a558f8ab-3fd965c4d04mr170544075ab.26.1757408315233; Tue, 09 Sep 2025
 01:58:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2048.git.git.1757274320.gitgitgadget@gmail.com> <d1657f51012c8ee97f81bf5e3550aa47a0c5b70c.1757274320.git.gitgitgadget@gmail.com>
In-Reply-To: <d1657f51012c8ee97f81bf5e3550aa47a0c5b70c.1757274320.git.gitgitgadget@gmail.com>
From: Elijah Newren <newren@gmail.com>
Date: Tue, 9 Sep 2025 01:58:22 -0700
X-Gm-Features: Ac12FXwyzNMK_bgcQ8dy6w1WhkwejtmWrwfXKAqlsT34dLerQ1ZqVWqOG4PTT3g
Message-ID: <CABPp-BEnvJ2x5sC-fYHHKm7Cqu=CWtNzGBDT10JU-yS4hw2dpQ@mail.gmail.com>
Subject: Re: [PATCH 09/17] xdiff: treat xdfile_t.rchg like an enum
To: Ezekiel Newren via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Ezekiel Newren <ezekielnewren@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Sep 7, 2025 at 12:46=E2=80=AFPM Ezekiel Newren via GitGitGadget
<gitgitgadget@gmail.com> wrote:
>
> From: Ezekiel Newren <ezekielnewren@gmail.com>
>
> Define macros NO(0), YES(1), MAYBE(2) as the enum values for rchg to
> make the code easier to follow. Perhaps 'rchg' should be renamed to
> 'changed'?
>
> Signed-off-by: Ezekiel Newren <ezekielnewren@gmail.com>
> ---
>  xdiff/xdiff.h      |  4 ++++
>  xdiff/xdiffi.c     | 29 ++++++++++++++---------------
>  xdiff/xhistogram.c |  8 ++++----
>  xdiff/xpatience.c  |  8 ++++----
>  xdiff/xprepare.c   | 24 ++++++++++++------------
>  5 files changed, 38 insertions(+), 35 deletions(-)
>
> diff --git a/xdiff/xdiff.h b/xdiff/xdiff.h
> index 2cecde5afe..7092879829 100644
> --- a/xdiff/xdiff.h
> +++ b/xdiff/xdiff.h
> @@ -27,6 +27,10 @@
>  extern "C" {
>  #endif /* #ifdef __cplusplus */
>
> +#define NO 0
> +#define YES 1
> +#define MAYBE 2
> +
>  /* xpparm_t.flags */
>  #define XDF_NEED_MINIMAL (1 << 0)
>
> diff --git a/xdiff/xdiffi.c b/xdiff/xdiffi.c
> index a66125d44a..44fd27823a 100644
> --- a/xdiff/xdiffi.c
> +++ b/xdiff/xdiffi.c
> @@ -278,10 +278,10 @@ int xdl_recs_cmp(xdfile_t *xdf1, long off1, long li=
m1,
>          */
>         if (off1 =3D=3D lim1) {
>                 for (; off2 < lim2; off2++)
> -                       xdf2->rchg[xdf2->rindex[off2]] =3D 1;
> +                       xdf2->rchg[xdf2->rindex[off2]] =3D YES;
>         } else if (off2 =3D=3D lim2) {
>                 for (; off1 < lim1; off1++)
> -                       xdf1->rchg[xdf1->rindex[off1]] =3D 1;
> +                       xdf1->rchg[xdf1->rindex[off1]] =3D YES;
>         } else {
>                 xdpsplit_t spl;
>                 spl.i1 =3D spl.i2 =3D 0;
> @@ -708,7 +708,7 @@ struct xdlgroup {
>  static void group_init(xdfile_t *xdf, struct xdlgroup *g)
>  {
>         g->start =3D g->end =3D 0;
> -       while (xdf->rchg[g->end])
> +       while (xdf->rchg[g->end] =3D=3D YES)

You've got a few places like this where the old code would have
behaved differently if there were some MAYBE values.  I presume you've
carefully vetted that those can't happen at these points in the code,
but it might be worth calling that out in the commit message for
reviewers who'll otherwise wonder if there's a behavior change that
has occurred.

>                 g->end++;
>  }
>
> @@ -722,7 +722,7 @@ static inline int group_next(xdfile_t *xdf, struct xd=
lgroup *g)
>                 return -1;
>
>         g->start =3D g->end + 1;
> -       for (g->end =3D g->start; xdf->rchg[g->end]; g->end++)
> +       for (g->end =3D g->start; xdf->rchg[g->end] =3D=3D YES; g->end++)

Here's another of those where you assume MAYBE isn't possible.

>                 ;
>
>         return 0;
> @@ -738,7 +738,7 @@ static inline int group_previous(xdfile_t *xdf, struc=
t xdlgroup *g)
>                 return -1;
>
>         g->end =3D g->start - 1;
> -       for (g->start =3D g->end; xdf->rchg[g->start - 1]; g->start--)
> +       for (g->start =3D g->end; xdf->rchg[g->start - 1] =3D=3D YES; g->=
start--)

...and another.

>                 ;
>
>         return 0;
> @@ -753,10 +753,10 @@ static int group_slide_down(xdfile_t *xdf, struct x=
dlgroup *g)
>  {
>         if (g->end < xdf->nrec &&
>             recs_match(&xdf->recs[g->start], &xdf->recs[g->end])) {
> -               xdf->rchg[g->start++] =3D 0;
> -               xdf->rchg[g->end++] =3D 1;
> +               xdf->rchg[g->start++] =3D NO;
> +               xdf->rchg[g->end++] =3D YES;
>
> -               while (xdf->rchg[g->end])
> +               while (xdf->rchg[g->end] =3D=3D YES)

...and another.

>                         g->end++;
>
>                 return 0;
> @@ -774,10 +774,10 @@ static int group_slide_up(xdfile_t *xdf, struct xdl=
group *g)
>  {
>         if (g->start > 0 &&
>             recs_match(&xdf->recs[g->start - 1], &xdf->recs[g->end - 1]))=
 {
> -               xdf->rchg[--g->start] =3D 1;
> -               xdf->rchg[--g->end] =3D 0;
> +               xdf->rchg[--g->start] =3D YES;
> +               xdf->rchg[--g->end] =3D NO;
>
> -               while (xdf->rchg[g->start - 1])
> +               while (xdf->rchg[g->start - 1] =3D=3D YES)

...and another.

>                         g->start--;
>
>                 return 0;
> @@ -932,16 +932,15 @@ int xdl_change_compact(xdfile_t *xdf, xdfile_t *xdf=
o, long flags) {
>
>  int xdl_build_script(xdfenv_t *xe, xdchange_t **xscr) {
>         xdchange_t *cscr =3D NULL, *xch;
> -       char *rchg1 =3D xe->xdf1.rchg, *rchg2 =3D xe->xdf2.rchg;
>         long i1, i2, l1, l2;
>
>         /*
>          * Trivial. Collects "groups" of changes and creates an edit scri=
pt.
>          */
>         for (i1 =3D xe->xdf1.nrec, i2 =3D xe->xdf2.nrec; i1 >=3D 0 || i2 =
>=3D 0; i1--, i2--)
> -               if (rchg1[i1 - 1] || rchg2[i2 - 1]) {
> -                       for (l1 =3D i1; rchg1[i1 - 1]; i1--);
> -                       for (l2 =3D i2; rchg2[i2 - 1]; i2--);
> +               if (xe->xdf1.rchg[i1 - 1] || xe->xdf2.rchg[i2 - 1]) {
> +                       for (l1 =3D i1; xe->xdf1.rchg[i1 - 1]; i1--);
> +                       for (l2 =3D i2; xe->xdf2.rchg[i2 - 1]; i2--);

The changes in this xdl_build_script() function appear to be
orthogonal to what was described in the commit message.  If it's a
separate cleanup, perhaps justify it in a separate patch?

>
>                         if (!(xch =3D xdl_add_change(cscr, i1, i2, l1 - i=
1, l2 - i2))) {
>                                 xdl_free_script(cscr);
> diff --git a/xdiff/xhistogram.c b/xdiff/xhistogram.c
> index 4d857e8ae2..c2e85b8ab9 100644
> --- a/xdiff/xhistogram.c
> +++ b/xdiff/xhistogram.c
> @@ -318,11 +318,11 @@ redo:
>
>         if (!count1) {
>                 while(count2--)
> -                       env->xdf2.rchg[line2++ - 1] =3D 1;
> +                       env->xdf2.rchg[line2++ - 1] =3D YES;
>                 return 0;
>         } else if (!count2) {
>                 while(count1--)
> -                       env->xdf1.rchg[line1++ - 1] =3D 1;
> +                       env->xdf1.rchg[line1++ - 1] =3D YES;
>                 return 0;
>         }
>
> @@ -335,9 +335,9 @@ redo:
>         else {
>                 if (lcs.begin1 =3D=3D 0 && lcs.begin2 =3D=3D 0) {
>                         while (count1--)
> -                               env->xdf1.rchg[line1++ - 1] =3D 1;
> +                               env->xdf1.rchg[line1++ - 1] =3D YES;
>                         while (count2--)
> -                               env->xdf2.rchg[line2++ - 1] =3D 1;
> +                               env->xdf2.rchg[line2++ - 1] =3D YES;
>                         result =3D 0;
>                 } else {
>                         result =3D histogram_diff(xpp, env,
> diff --git a/xdiff/xpatience.c b/xdiff/xpatience.c
> index bf69a58527..20cda5e258 100644
> --- a/xdiff/xpatience.c
> +++ b/xdiff/xpatience.c
> @@ -331,11 +331,11 @@ static int patience_diff(xpparam_t const *xpp, xdfe=
nv_t *env,
>         /* trivial case: one side is empty */
>         if (!count1) {
>                 while(count2--)
> -                       env->xdf2.rchg[line2++ - 1] =3D 1;
> +                       env->xdf2.rchg[line2++ - 1] =3D YES;
>                 return 0;
>         } else if (!count2) {
>                 while(count1--)
> -                       env->xdf1.rchg[line1++ - 1] =3D 1;
> +                       env->xdf1.rchg[line1++ - 1] =3D YES;
>                 return 0;
>         }
>
> @@ -347,9 +347,9 @@ static int patience_diff(xpparam_t const *xpp, xdfenv=
_t *env,
>         /* are there any matching lines at all? */
>         if (!map.has_matches) {
>                 while(count1--)
> -                       env->xdf1.rchg[line1++ - 1] =3D 1;
> +                       env->xdf1.rchg[line1++ - 1] =3D YES;
>                 while(count2--)
> -                       env->xdf2.rchg[line2++ - 1] =3D 1;
> +                       env->xdf2.rchg[line2++ - 1] =3D YES;
>                 xdl_free(map.entries);
>                 return 0;
>         }
> diff --git a/xdiff/xprepare.c b/xdiff/xprepare.c
> index 92f9845003..36437f91bb 100644
> --- a/xdiff/xprepare.c
> +++ b/xdiff/xprepare.c
> @@ -215,9 +215,9 @@ static int xdl_clean_mmatch(char const *dis, long i, =
long s, long e) {
>          * current line (i) is already a multimatch line.
>          */
>         for (r =3D 1, rdis0 =3D 0, rpdis0 =3D 1; (i - r) >=3D s; r++) {
> -               if (!dis[i - r])
> +               if (dis[i - r] =3D=3D NO)
>                         rdis0++;
> -               else if (dis[i - r] =3D=3D 2)
> +               else if (dis[i - r] =3D=3D MAYBE)
>                         rpdis0++;
>                 else
>                         break;
> @@ -231,9 +231,9 @@ static int xdl_clean_mmatch(char const *dis, long i, =
long s, long e) {
>         if (rdis0 =3D=3D 0)
>                 return 0;
>         for (r =3D 1, rdis1 =3D 0, rpdis1 =3D 1; (i + r) <=3D e; r++) {
> -               if (!dis[i + r])
> +               if (dis[i + r] =3D=3D NO)
>                         rdis1++;
> -               else if (dis[i + r] =3D=3D 2)
> +               else if (dis[i + r] =3D=3D MAYBE)
>                         rpdis1++;
>                 else
>                         break;
> @@ -273,7 +273,7 @@ static int xdl_cleanup_records(xdlclassifier_t *cf, x=
dfile_t *xdf1, xdfile_t *xd
>         for (i =3D xdf1->dstart, recs =3D &xdf1->recs[xdf1->dstart]; i <=
=3D xdf1->dend; i++, recs++) {
>                 rcrec =3D cf->rcrecs[recs->ha];
>                 nm =3D rcrec ? rcrec->len2 : 0;
> -               dis1[i] =3D (nm =3D=3D 0) ? 0: (nm >=3D mlim && !need_min=
) ? 2: 1;
> +               dis1[i] =3D (nm =3D=3D 0) ? NO: (nm >=3D mlim && !need_mi=
n) ? MAYBE: YES;
>         }
>
>         if ((mlim =3D xdl_bogosqrt(xdf2->nrec)) > XDL_MAX_EQLIMIT)
> @@ -281,26 +281,26 @@ static int xdl_cleanup_records(xdlclassifier_t *cf,=
 xdfile_t *xdf1, xdfile_t *xd
>         for (i =3D xdf2->dstart, recs =3D &xdf2->recs[xdf2->dstart]; i <=
=3D xdf2->dend; i++, recs++) {
>                 rcrec =3D cf->rcrecs[recs->ha];
>                 nm =3D rcrec ? rcrec->len1 : 0;
> -               dis2[i] =3D (nm =3D=3D 0) ? 0: (nm >=3D mlim && !need_min=
) ? 2: 1;
> +               dis2[i] =3D (nm =3D=3D 0) ? NO: (nm >=3D mlim && !need_mi=
n) ? MAYBE: YES;
>         }
>
>         for (nreff =3D 0, i =3D xdf1->dstart, recs =3D &xdf1->recs[xdf1->=
dstart];
>              i <=3D xdf1->dend; i++, recs++) {
> -               if (dis1[i] =3D=3D 1 ||
> -                   (dis1[i] =3D=3D 2 && !xdl_clean_mmatch(dis1, i, xdf1-=
>dstart, xdf1->dend))) {
> +               if (dis1[i] =3D=3D YES ||
> +                   (dis1[i] =3D=3D MAYBE && !xdl_clean_mmatch(dis1, i, x=
df1->dstart, xdf1->dend))) {
>                         xdf1->rindex[nreff++] =3D i;
>                 } else
> -                       xdf1->rchg[i] =3D 1;
> +                       xdf1->rchg[i] =3D YES;
>         }
>         xdf1->nreff =3D nreff;
>
>         for (nreff =3D 0, i =3D xdf2->dstart, recs =3D &xdf2->recs[xdf2->=
dstart];
>              i <=3D xdf2->dend; i++, recs++) {
> -               if (dis2[i] =3D=3D 1 ||
> -                   (dis2[i] =3D=3D 2 && !xdl_clean_mmatch(dis2, i, xdf2-=
>dstart, xdf2->dend))) {
> +               if (dis2[i] =3D=3D YES ||
> +                   (dis2[i] =3D=3D MAYBE && !xdl_clean_mmatch(dis2, i, x=
df2->dstart, xdf2->dend))) {
>                         xdf2->rindex[nreff++] =3D i;
>                 } else
> -                       xdf2->rchg[i] =3D 1;
> +                       xdf2->rchg[i] =3D YES;
>         }
>         xdf2->nreff =3D nreff;
>
> --
> gitgitgadget

Everything else looks like the straightforward translation you called
out in your commit message.
