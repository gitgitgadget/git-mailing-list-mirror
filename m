Received: from mail-il1-f175.google.com (mail-il1-f175.google.com [209.85.166.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBC71273D67
	for <git@vger.kernel.org>; Tue,  9 Sep 2025 08:57:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757408226; cv=none; b=uEBi2Lrb5xq/VT0EAqLvth3ZABt1Xh8bla86HzK2pxIc9jUzj3Pkhx7iBfvZv1GVclobvwagRait9MVCih5FIVKyH6/zHre6QWEaBWWVA/0zQb3m4NOESP8v3SahA2zLOK0pDbqyXGPcTers8dFgpLo9RwaGE/mEtzjqLmVc0EQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757408226; c=relaxed/simple;
	bh=/Z9yrmHJ3RdAqVaMtYV+gPv7GHjnK9cmfg75J9s9+XU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=F+c+aH7X9r1jBG0hJu0+iVIC+ohAjjRNeP08CPgaKxFKohqFZDS5WbMGznPr+0mmxNlGSMcf3dJzYR/nSRYGu2JUQ0leFMz3me/Dfc2I5cyPGtILM4GH786VnNQuuryl8MY0uGHn95MlPbPlYhOqyM44DZP6ifNS9XyErB5WJYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JgSoktF8; arc=none smtp.client-ip=209.85.166.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JgSoktF8"
Received: by mail-il1-f175.google.com with SMTP id e9e14a558f8ab-407ec3048a0so18996305ab.3
        for <git@vger.kernel.org>; Tue, 09 Sep 2025 01:57:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757408224; x=1758013024; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2kBgLfcQi5N6DDLn8iIQTNhKHzxtwddQSHS8Wyfh/Ek=;
        b=JgSoktF8sefE9iH+h2aTkP34oFfIbZ5e223PkUGRXYdIWiG4c0xBdd5sv98ALq45l9
         VJtAC9/D6UtxEoVF7D48t9cbP7PXdQZLbfSGwIxfTc1I3UTvezcuPGGRfNuwwj2cQhoa
         FXwyWC5wLJ2vqUD5HjcoJAX/Cerzth+E8cUqmVaIr1pZkS23xwLstDtbM/+lF7xxorh1
         Mjb1lLI3Uu453DAvm1h+Ft8af+05vvG7fcb/1yETfLv6sAA3KGyoFaheN460wWhPjVVk
         xwIjGlOzcv3KFeWd8/MElynZsOMZtbVqLTFJIAUxpVLwzPXzODEQUv99PWpSftDofoNB
         X08A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757408224; x=1758013024;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2kBgLfcQi5N6DDLn8iIQTNhKHzxtwddQSHS8Wyfh/Ek=;
        b=keOwl0gWNqmQeJ757bjHOeCxPFJya9HQRmVMdfpihocj4ugPNSqSr+5SoPsdjSG0dJ
         7km14Kpm8BDMC0u/lWzAOnSWgF1PraI8pHfkJRq1BgBr3G5oR3sNN9O8ahZwRwzngqIu
         AWJb2OTeMI5jVSa8fFIasG28z+pR5PJUP9ZX9E0It7e5X6b65niXDBO48d4kJUNZbdXy
         J0m5AJX8eZwuniz5DUCrCLM2w2zQzgIN0WA6V/EZOoFyQIyNNxg5GlBat2dwvwG9drRM
         GtHJGVwxqnBDvoaG53BALBuRr7pUzoR17KNPHg1DyB4zC2YGlzYRemgKuhfT0td3XrMg
         O2CA==
X-Gm-Message-State: AOJu0YyTDnADV5jHoeQnB6dmsSfq7jbfjMoMqCI0ETLKuDHYOwP7xBm7
	kcsF4VSEL9IswSRRYrDK6FUwknHIFQV2c2dinqMMx5vDXRLlH9xBrkFHYebgKyvKFSkN7AXonPm
	ZwvxkJvx2dMplGKKhXrkQoA4PHtguhotckg==
X-Gm-Gg: ASbGncvESICTo1xwNOh+bxlHpNoaK8xRug+GvsV4BtPbi8dDV1wweddYaBIEdrA+cL1
	Ge2kfObv+AwiU/nPhOhMherh4BNZp3Ho9lHfHkFDcRXE2C8gOoCy56zRf+/hoOpXcpaYg+R8NGD
	e9ZfkkB5SL1+S2Tv7GMRlBwRr7pUQHOC+rHUX+7N3O282rE26rG+xLzwhL0vj41SLTJgS4aWitQ
	AyY2QhroTkmjmgxPPA1oPochdKpdfvL9N+bKgI5VJJz8H2SZQ==
X-Google-Smtp-Source: AGHT+IEjthOLe55HQrz5PcTFgAd1pxkbH7bwogXl9bZehJnCD4UqnHMIcxCYOBdECs0YLy75pg9dNWY8y23uE8rwgi0=
X-Received: by 2002:a05:6e02:2309:b0:409:b7a2:bfaa with SMTP id
 e9e14a558f8ab-409b7a2c192mr72648315ab.2.1757408223697; Tue, 09 Sep 2025
 01:57:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2048.git.git.1757274320.gitgitgadget@gmail.com> <6cf371ec13d3e57ea7d679a0170951d0b0346349.1757274320.git.gitgitgadget@gmail.com>
In-Reply-To: <6cf371ec13d3e57ea7d679a0170951d0b0346349.1757274320.git.gitgitgadget@gmail.com>
From: Elijah Newren <newren@gmail.com>
Date: Tue, 9 Sep 2025 01:56:51 -0700
X-Gm-Features: Ac12FXxHHP5zJ49LTg_EesyZMm7SSojItp6VjrwoJwmqheuykftjsswgdRCIzKw
Message-ID: <CABPp-BFuF7i+f=UsbvZpfrFjcsUru7WUyUmCGVQnQwPzfbcp8w@mail.gmail.com>
Subject: Re: [PATCH 05/17] xdiff: delete struct diffdata_t
To: Ezekiel Newren via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Ezekiel Newren <ezekielnewren@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Sep 7, 2025 at 12:45=E2=80=AFPM Ezekiel Newren via GitGitGadget
<gitgitgadget@gmail.com> wrote:
>
> From: Ezekiel Newren <ezekielnewren@gmail.com>
>
> Every field in this struct is an alias for a certain field in xdfile_t.
>
> diffdata_t.nrec   -> xdfile_t.nreff
> diffdata_t.ha     -> xdfile_t.ha
> diffdata_t.rindex -> xdfile_t.rindex
> diffdata_t.rchg   -> xdfile_t.recharge
>
> Signed-off-by: Ezekiel Newren <ezekielnewren@gmail.com>
> ---
>  xdiff/xdiffi.c | 32 ++++++++------------------------
>  xdiff/xdiffi.h | 11 ++---------
>  2 files changed, 10 insertions(+), 33 deletions(-)
>
> diff --git a/xdiff/xdiffi.c b/xdiff/xdiffi.c
> index 5a96e36dfb..bbf0161f84 100644
> --- a/xdiff/xdiffi.c
> +++ b/xdiff/xdiffi.c
> @@ -257,10 +257,10 @@ static long xdl_split(unsigned long const *ha1, lon=
g off1, long lim1,
>   * sub-boxes by calling the box splitting function. Note that the real j=
ob
>   * (marking changed lines) is done in the two boundary reaching checks.
>   */
> -int xdl_recs_cmp(diffdata_t *dd1, long off1, long lim1,
> -                diffdata_t *dd2, long off2, long lim2,
> +int xdl_recs_cmp(xdfile_t *xdf1, long off1, long lim1,
> +                xdfile_t *xdf2, long off2, long lim2,
>                  long *kvdf, long *kvdb, int need_min, xdalgoenv_t *xenv)=
 {
> -       unsigned long const *ha1 =3D dd1->ha, *ha2 =3D dd2->ha;
> +       unsigned long const *ha1 =3D xdf1->ha, *ha2 =3D xdf2->ha;
>
>         /*
>          * Shrink the box by walking through each diagonal snake (SW and =
NE).
> @@ -273,17 +273,11 @@ int xdl_recs_cmp(diffdata_t *dd1, long off1, long l=
im1,
>          * be obviously changed.
>          */
>         if (off1 =3D=3D lim1) {
> -               char *rchg2 =3D dd2->rchg;
> -               long *rindex2 =3D dd2->rindex;
> -
>                 for (; off2 < lim2; off2++)
> -                       rchg2[rindex2[off2]] =3D 1;
> +                       xdf2->rchg[xdf2->rindex[off2]] =3D 1;
>         } else if (off2 =3D=3D lim2) {
> -               char *rchg1 =3D dd1->rchg;
> -               long *rindex1 =3D dd1->rindex;
> -
>                 for (; off1 < lim1; off1++)
> -                       rchg1[rindex1[off1]] =3D 1;
> +                       xdf1->rchg[xdf1->rindex[off1]] =3D 1;
>         } else {
>                 xdpsplit_t spl;
>                 spl.i1 =3D spl.i2 =3D 0;
> @@ -300,9 +294,9 @@ int xdl_recs_cmp(diffdata_t *dd1, long off1, long lim=
1,
>                 /*
>                  * ... et Impera.
>                  */
> -               if (xdl_recs_cmp(dd1, off1, spl.i1, dd2, off2, spl.i2,
> +               if (xdl_recs_cmp(xdf1, off1, spl.i1, xdf2, off2, spl.i2,
>                                  kvdf, kvdb, spl.min_lo, xenv) < 0 ||
> -                   xdl_recs_cmp(dd1, spl.i1, lim1, dd2, spl.i2, lim2,
> +                   xdl_recs_cmp(xdf1, spl.i1, lim1, xdf2, spl.i2, lim2,
>                                  kvdf, kvdb, spl.min_hi, xenv) < 0) {
>
>                         return -1;
> @@ -318,7 +312,6 @@ int xdl_do_diff(mmfile_t *mf1, mmfile_t *mf2, xpparam=
_t const *xpp,
>         long ndiags;
>         long *kvd, *kvdf, *kvdb;
>         xdalgoenv_t xenv;
> -       diffdata_t dd1, dd2;
>         int res;
>
>         if (xdl_prepare_env(mf1, mf2, xpp, xe) < 0)
> @@ -357,16 +350,7 @@ int xdl_do_diff(mmfile_t *mf1, mmfile_t *mf2, xppara=
m_t const *xpp,
>         xenv.snake_cnt =3D XDL_SNAKE_CNT;
>         xenv.heur_min =3D XDL_HEUR_MIN_COST;
>
> -       dd1.nrec =3D xe->xdf1.nreff;
> -       dd1.ha =3D xe->xdf1.ha;
> -       dd1.rchg =3D xe->xdf1.rchg;
> -       dd1.rindex =3D xe->xdf1.rindex;
> -       dd2.nrec =3D xe->xdf2.nreff;
> -       dd2.ha =3D xe->xdf2.ha;
> -       dd2.rchg =3D xe->xdf2.rchg;
> -       dd2.rindex =3D xe->xdf2.rindex;
> -
> -       res =3D xdl_recs_cmp(&dd1, 0, dd1.nrec, &dd2, 0, dd2.nrec,
> +       res =3D xdl_recs_cmp(&xe->xdf1, 0, xe->xdf1.nreff, &xe->xdf2, 0, =
xe->xdf2.nreff,
>                            kvdf, kvdb, (xpp->flags & XDF_NEED_MINIMAL) !=
=3D 0,
>                            &xenv);
>         xdl_free(kvd);
> diff --git a/xdiff/xdiffi.h b/xdiff/xdiffi.h
> index 126c9d8ff4..49e52c67f9 100644
> --- a/xdiff/xdiffi.h
> +++ b/xdiff/xdiffi.h
> @@ -24,13 +24,6 @@
>  #define XDIFFI_H
>
>
> -typedef struct s_diffdata {
> -       long nrec;
> -       unsigned long const *ha;
> -       long *rindex;
> -       char *rchg;
> -} diffdata_t;
> -
>  typedef struct s_xdalgoenv {
>         long mxcost;
>         long snake_cnt;
> @@ -46,8 +39,8 @@ typedef struct s_xdchange {
>
>
>
> -int xdl_recs_cmp(diffdata_t *dd1, long off1, long lim1,
> -                diffdata_t *dd2, long off2, long lim2,
> +int xdl_recs_cmp(xdfile_t *xdf1, long off1, long lim1,
> +                xdfile_t *xdf2, long off2, long lim2,
>                  long *kvdf, long *kvdb, int need_min, xdalgoenv_t *xenv)=
;
>  int xdl_do_diff(mmfile_t *mf1, mmfile_t *mf2, xpparam_t const *xpp,
>                 xdfenv_t *xe);
> --
> gitgitgadget

Viewing this commit with --color-moved helps highlight in the code
what you say in the commit message.  Makes sense.
