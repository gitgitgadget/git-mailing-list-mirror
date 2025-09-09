Received: from mail-io1-f41.google.com (mail-io1-f41.google.com [209.85.166.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBF282765C1
	for <git@vger.kernel.org>; Tue,  9 Sep 2025 08:57:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757408257; cv=none; b=Zrybhasil/pUllS4FpnHh0XH1PRQHIIVe5T5SqmdB/zZxjadR3n/tgDzNocPEpwVDYu7i4t5lZG/tpsY1jVFiXR8XLzVzP8E5JBiKlPTZ5yusp0p6WREw4kU7KEEwKG0yN3rKuA3wd38bmEdbCKsvdlIICvtTL7ES2PJR6ftIH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757408257; c=relaxed/simple;
	bh=iourXDID7auOS9LhtF+zcViM/7tT7oi1Z6kcqwVAZBE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=D4IoBYyBMhfCvdEo1QgcelFhtphwM+ouldrExRKLO3V3KJsTABsLk7YVhYhTJJ+O8hmg6NNgmkaJxb4rDn5D8VAurbbmXF6xxNpIXXqC1r2PKZiL62v7lBRB6bl8yglyIXcF2Zj76MM1aB5GDoyc3wxTmT7DnQetg4HldWArDBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZeszIzIa; arc=none smtp.client-ip=209.85.166.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZeszIzIa"
Received: by mail-io1-f41.google.com with SMTP id ca18e2360f4ac-8876de33c86so325332939f.3
        for <git@vger.kernel.org>; Tue, 09 Sep 2025 01:57:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757408255; x=1758013055; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RMvThHzI5OB4HJp0NwmtK234E/PW/atSIsBUWfnGQcY=;
        b=ZeszIzIa0VS2Z3WyIbI9nYYtSHc2QXetSZJb0j4ncHTqInmyLpffsSduG0rxUM4lXu
         KRD+p0uq91I++ZguBmNBXWM90kq0bHE2GwcnV4HxQwPmolhCscLauZJw5Lh0MBF+NeQ0
         PBOotgLayqG1PBoOg3LZNAi80xfsnv3J6p6acoieJzvi/5ZeX0XvjSj6zbzGHzktPuJH
         tlYl6il65IQOvtReNw9HVEaxr3unMYOJAkNItzahF2SRYUgDZgyCbexO3i4Y32HaDpaW
         cYf8IuicCx8lXi/gW9WrT2Ir6GltYmrpvAulPyQoOR3o13l8varxdqWQL7KQPlulcqhC
         4fhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757408255; x=1758013055;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RMvThHzI5OB4HJp0NwmtK234E/PW/atSIsBUWfnGQcY=;
        b=H5WvHleSw0HSKnU10rJhiqfn6GH5dKscCnTDVjdSotYZ1xJDDOvt91a1ZDTiZ4qzoi
         c8Do2XWQBBYYqSNrO6AkhmPIBRtR7V7o7U9HXiD5LnTkA17cjqJcoUsT6ZLu5u5pgLS2
         TFW4d8wCVZppvSVvNQM2v68Oht4IRJbMNItp9aQN1W0BwTguWKXTZZSwsVV3ykOGJHGO
         yfRNPTk5cdxV6tSQixOyFl0YzeqF4C+lvZedV7M0QXOM5CQ0tUzWgxpJuLJAEKeN++Fw
         oMYNGz7PaPZiC7QvWGLd/G/yiVQ9Tbkip/69dvfbkT22hAvrGFMSYV/+pFcUB26BGFSK
         v6uA==
X-Gm-Message-State: AOJu0Ywp32oBlVCd9psuWXMBaWZIoC0g2eFZlTbyDKkjQ80DCP+XW8Nf
	q7PTiWTxYOa15/w52OiN36vez3Zkon/w9I3WnkcHlewAuZopyKEa+uQvlG5BBDLAQe+HkE7oYVw
	bDRj62K9k/Bjj5WX/vkUb6BoeXJzoZXzQRw==
X-Gm-Gg: ASbGncsCz/NWdctFYtu7NKWu0iE7w8brqDwMG48ufdnJFMqm2jpmM6dk0Fdi+LlLPUg
	IOEZ1Dw8LYW+Hh95fP1waD0jLtD8U2vq7lpgEyBYZqERUWUoZX8xzF5rU3pQuvfHMbPwnyy6yw/
	yAhMd6Bmxpkx6nYsnXSYZ+nskqOXa1EEpXvFbT1aotlX2iSJp2iA76PDrRXbeUUj6AJcbqcfMY1
	sHPR5ukdad7VB6xeIJP6uBI0YneW4uMoThmZcU=
X-Google-Smtp-Source: AGHT+IF6xFRfawMk47rC3tWGHh4lMh7qpSnDm3R9bq2aFa2xh3Vcv12yQ5Ia/wUb8n/GRcB/btlMuQwYpyE8D3XgYUY=
X-Received: by 2002:a05:6602:621b:b0:887:77bb:8d2f with SMTP id
 ca18e2360f4ac-88777bb936bmr1442680439f.17.1757408254778; Tue, 09 Sep 2025
 01:57:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2048.git.git.1757274320.gitgitgadget@gmail.com> <bff456860268a833078b273ff34e3bc26a0c3975.1757274320.git.gitgitgadget@gmail.com>
In-Reply-To: <bff456860268a833078b273ff34e3bc26a0c3975.1757274320.git.gitgitgadget@gmail.com>
From: Elijah Newren <newren@gmail.com>
Date: Tue, 9 Sep 2025 01:57:23 -0700
X-Gm-Features: Ac12FXxbMw3SnYI4LcESI8HAF5jUTPp_LKIKlDLtLGOhXq3Kl-XSo0P6XPjLTKg
Message-ID: <CABPp-BEh1UYwQsFhF_9uHEOi_xfhUJppXcSbJkQv_VuaAbAR0w@mail.gmail.com>
Subject: Re: [PATCH 06/17] xdiff: delete redundant array xdfile_t.ha
To: Ezekiel Newren via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Ezekiel Newren <ezekielnewren@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Sep 7, 2025 at 12:46=E2=80=AFPM Ezekiel Newren via GitGitGadget
<gitgitgadget@gmail.com> wrote:
>
> From: Ezekiel Newren <ezekielnewren@gmail.com>
>
> When 0 <=3D i < xdfile_t.nreff the following is true:
> xdfile_t.ha[i] =3D=3D xdfile_t.recs[xdfile_t.rindex[i]]

I like getting rid of redundant stuff.  One thing to note here is that
you're replacing a single indirection with two...

>
> Signed-off-by: Ezekiel Newren <ezekielnewren@gmail.com>
> ---
>  xdiff/xdiffi.c   | 24 ++++++++++++++----------
>  xdiff/xprepare.c | 12 ++----------
>  xdiff/xtypes.h   |  1 -
>  3 files changed, 16 insertions(+), 21 deletions(-)
>
> diff --git a/xdiff/xdiffi.c b/xdiff/xdiffi.c
> index bbf0161f84..11cd090b53 100644
> --- a/xdiff/xdiffi.c
> +++ b/xdiff/xdiffi.c
> @@ -22,6 +22,11 @@
>
>  #include "xinclude.h"
>
> +static unsigned long get_hash(xdfile_t *xdf, long index)
> +{
> +       return xdf->recs[xdf->rindex[index]]->ha;
> +}
> +
>  #define XDL_MAX_COST_MIN 256
>  #define XDL_HEUR_MIN_COST 256
>  #define XDL_LINE_MAX (long)((1UL << (CHAR_BIT * sizeof(long) - 1)) - 1)
> @@ -42,8 +47,8 @@ typedef struct s_xdpsplit {
>   * using this algorithm, so a little bit of heuristic is needed to cut t=
he
>   * search and to return a suboptimal point.
>   */
> -static long xdl_split(unsigned long const *ha1, long off1, long lim1,
> -                     unsigned long const *ha2, long off2, long lim2,
> +static long xdl_split(xdfile_t *xdf1, long off1, long lim1,
> +                     xdfile_t *xdf2, long off2, long lim2,
>                       long *kvdf, long *kvdb, int need_min, xdpsplit_t *s=
pl,
>                       xdalgoenv_t *xenv) {
>         long dmin =3D off1 - lim2, dmax =3D lim1 - off2;
> @@ -87,7 +92,7 @@ static long xdl_split(unsigned long const *ha1, long of=
f1, long lim1,
>                                 i1 =3D kvdf[d + 1];
>                         prev1 =3D i1;
>                         i2 =3D i1 - d;
> -                       for (; i1 < lim1 && i2 < lim2 && ha1[i1] =3D=3D h=
a2[i2]; i1++, i2++);
> +                       for (; i1 < lim1 && i2 < lim2 && get_hash(xdf1, i=
1) =3D=3D get_hash(xdf2, i2); i1++, i2++);

You're not going to be happy with me asking, so sorry in advance, but
I'm really curious...we are now replacing a single indirection with a
double-indirection inside a for loop, which is nested within two other
for loops.  Three levels of for-loops to me suggests it might be a hot
codepath.  Does this double indirection in these codepaths affect
performance?

>                         if (i1 - prev1 > xenv->snake_cnt)
>                                 got_snake =3D 1;
>                         kvdf[d] =3D i1;
> @@ -124,7 +129,7 @@ static long xdl_split(unsigned long const *ha1, long =
off1, long lim1,
>                                 i1 =3D kvdb[d + 1] - 1;
>                         prev1 =3D i1;
>                         i2 =3D i1 - d;
> -                       for (; i1 > off1 && i2 > off2 && ha1[i1 - 1] =3D=
=3D ha2[i2 - 1]; i1--, i2--);
> +                       for (; i1 > off1 && i2 > off2 && get_hash(xdf1, i=
1 - 1) =3D=3D get_hash(xdf2, i2 - 1); i1--, i2--);
>                         if (prev1 - i1 > xenv->snake_cnt)
>                                 got_snake =3D 1;
>                         kvdb[d] =3D i1;
> @@ -159,7 +164,7 @@ static long xdl_split(unsigned long const *ha1, long =
off1, long lim1,
>                                 if (v > XDL_K_HEUR * ec && v > best &&
>                                     off1 + xenv->snake_cnt <=3D i1 && i1 =
< lim1 &&
>                                     off2 + xenv->snake_cnt <=3D i2 && i2 =
< lim2) {
> -                                       for (k =3D 1; ha1[i1 - k] =3D=3D =
ha2[i2 - k]; k++)
> +                                       for (k =3D 1; get_hash(xdf1, i1 -=
 k) =3D=3D get_hash(xdf2, i2 - k); k++)
>                                                 if (k =3D=3D xenv->snake_=
cnt) {
>                                                         best =3D v;
>                                                         spl->i1 =3D i1;
> @@ -183,7 +188,7 @@ static long xdl_split(unsigned long const *ha1, long =
off1, long lim1,
>                                 if (v > XDL_K_HEUR * ec && v > best &&
>                                     off1 < i1 && i1 <=3D lim1 - xenv->sna=
ke_cnt &&
>                                     off2 < i2 && i2 <=3D lim2 - xenv->sna=
ke_cnt) {
> -                                       for (k =3D 0; ha1[i1 + k] =3D=3D =
ha2[i2 + k]; k++)
> +                                       for (k =3D 0; get_hash(xdf1, i1 +=
 k) =3D=3D get_hash(xdf2, i2 + k); k++)
>                                                 if (k =3D=3D xenv->snake_=
cnt - 1) {
>                                                         best =3D v;
>                                                         spl->i1 =3D i1;
> @@ -260,13 +265,12 @@ static long xdl_split(unsigned long const *ha1, lon=
g off1, long lim1,
>  int xdl_recs_cmp(xdfile_t *xdf1, long off1, long lim1,
>                  xdfile_t *xdf2, long off2, long lim2,
>                  long *kvdf, long *kvdb, int need_min, xdalgoenv_t *xenv)=
 {
> -       unsigned long const *ha1 =3D xdf1->ha, *ha2 =3D xdf2->ha;
>
>         /*
>          * Shrink the box by walking through each diagonal snake (SW and =
NE).
>          */
> -       for (; off1 < lim1 && off2 < lim2 && ha1[off1] =3D=3D ha2[off2]; =
off1++, off2++);
> -       for (; off1 < lim1 && off2 < lim2 && ha1[lim1 - 1] =3D=3D ha2[lim=
2 - 1]; lim1--, lim2--);
> +       for (; off1 < lim1 && off2 < lim2 && get_hash(xdf1, off1) =3D=3D =
get_hash(xdf2, off2); off1++, off2++);
> +       for (; off1 < lim1 && off2 < lim2 && get_hash(xdf1, lim1 - 1) =3D=
=3D get_hash(xdf2, lim2 - 1); lim1--, lim2--);
>
>         /*
>          * If one dimension is empty, then all records on the other one m=
ust
> @@ -285,7 +289,7 @@ int xdl_recs_cmp(xdfile_t *xdf1, long off1, long lim1=
,
>                 /*
>                  * Divide ...
>                  */
> -               if (xdl_split(ha1, off1, lim1, ha2, off2, lim2, kvdf, kvd=
b,
> +               if (xdl_split(xdf1, off1, lim1, xdf2, off2, lim2, kvdf, k=
vdb,
>                               need_min, &spl, xenv) < 0) {
>
>                         return -1;
> diff --git a/xdiff/xprepare.c b/xdiff/xprepare.c
> index 91b0ed54e0..59730989a3 100644
> --- a/xdiff/xprepare.c
> +++ b/xdiff/xprepare.c
> @@ -134,7 +134,6 @@ static void xdl_free_ctx(xdfile_t *xdf)
>
>         xdl_free(xdf->rindex);
>         xdl_free(xdf->rchg - 1);
> -       xdl_free(xdf->ha);
>         xdl_free(xdf->recs);
>         xdl_cha_free(&xdf->rcha);
>  }
> @@ -147,7 +146,6 @@ static int xdl_prepare_ctx(unsigned int pass, mmfile_=
t *mf, long narec, xpparam_
>         char const *blk, *cur, *top, *prev;
>         xrecord_t *crec;
>
> -       xdf->ha =3D NULL;
>         xdf->rindex =3D NULL;
>         xdf->rchg =3D NULL;
>         xdf->recs =3D NULL;
> @@ -182,8 +180,6 @@ static int xdl_prepare_ctx(unsigned int pass, mmfile_=
t *mf, long narec, xpparam_
>             (XDF_DIFF_ALG(xpp->flags) !=3D XDF_HISTOGRAM_DIFF)) {
>                 if (!XDL_ALLOC_ARRAY(xdf->rindex, xdf->nrec + 1))
>                         goto abort;
> -               if (!XDL_ALLOC_ARRAY(xdf->ha, xdf->nrec + 1))
> -                       goto abort;
>         }
>
>         xdf->rchg +=3D 1;
> @@ -301,9 +297,7 @@ static int xdl_cleanup_records(xdlclassifier_t *cf, x=
dfile_t *xdf1, xdfile_t *xd
>              i <=3D xdf1->dend; i++, recs++) {
>                 if (dis1[i] =3D=3D 1 ||
>                     (dis1[i] =3D=3D 2 && !xdl_clean_mmatch(dis1, i, xdf1-=
>dstart, xdf1->dend))) {
> -                       xdf1->rindex[nreff] =3D i;
> -                       xdf1->ha[nreff] =3D (*recs)->ha;
> -                       nreff++;
> +                       xdf1->rindex[nreff++] =3D i;
>                 } else
>                         xdf1->rchg[i] =3D 1;
>         }
> @@ -313,9 +307,7 @@ static int xdl_cleanup_records(xdlclassifier_t *cf, x=
dfile_t *xdf1, xdfile_t *xd
>              i <=3D xdf2->dend; i++, recs++) {
>                 if (dis2[i] =3D=3D 1 ||
>                     (dis2[i] =3D=3D 2 && !xdl_clean_mmatch(dis2, i, xdf2-=
>dstart, xdf2->dend))) {
> -                       xdf2->rindex[nreff] =3D i;
> -                       xdf2->ha[nreff] =3D (*recs)->ha;
> -                       nreff++;
> +                       xdf2->rindex[nreff++] =3D i;
>                 } else
>                         xdf2->rchg[i] =3D 1;
>         }
> diff --git a/xdiff/xtypes.h b/xdiff/xtypes.h
> index 8b8467360e..85848f1685 100644
> --- a/xdiff/xtypes.h
> +++ b/xdiff/xtypes.h
> @@ -52,7 +52,6 @@ typedef struct s_xdfile {
>         char *rchg;
>         long *rindex;
>         long nreff;
> -       unsigned long *ha;
>  } xdfile_t;
>
>  typedef struct s_xdfenv {
> --
> gitgitgadget

Other than the performance question, it looks like you've made a
straightforward mechanical change as highlighted in the commit
message.
