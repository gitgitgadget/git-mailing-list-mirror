Received: from mail-il1-f182.google.com (mail-il1-f182.google.com [209.85.166.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 261FF274B5D
	for <git@vger.kernel.org>; Tue,  9 Sep 2025 08:56:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757408188; cv=none; b=a8lDhmgX3+LgvUPL5fgepyq/hKZTue7WCf5F9NAnoQOjmBc+R3st32uygtNgGuWr+WaTopLc6bHye3QzXrxSynYlw2p92mai+UNVFPh6xnxIFfgN8VXeFwXuRkfD157I9jcX7dJFlEN/ejX6vZXH3PY4eUc28TrDQKgwcBHU45o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757408188; c=relaxed/simple;
	bh=qqI2TXxaAp7aTPU0Znf7MtISKtrsuuxLiIaR1E+Wxwg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MVN118oztrwF3ARYFyjlEynhARZEwjXjlQ5JL/9vF28jktctqeAXPL+29CS/OhbzwBOCjammdhLaCxcENzUW4dJ+an8S6AObWXTJQqSvFffrwf796JqbO0th24PU9vG9apEPCMXAqexiBE0HCvSJjzTPsm0NPQ+omHM3HahQ/lc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LqrkTD2W; arc=none smtp.client-ip=209.85.166.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LqrkTD2W"
Received: by mail-il1-f182.google.com with SMTP id e9e14a558f8ab-401078bfacdso29564605ab.3
        for <git@vger.kernel.org>; Tue, 09 Sep 2025 01:56:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757408186; x=1758012986; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3kIGJ9kl0r6kUwjXUZ1ORfokl7oD/4uZqckj4InLdxM=;
        b=LqrkTD2WQgpu4CGAZvw8xnMU/HEo5F2/wuwqoZte0O8RuARx4YTqxghADYNwoJ1iI/
         BEovD1LQd5SA13IJyI52a4RqovGxAFBAt30syf3MPX7BqmAxQhvN+GgFoelWHuvv9JoY
         MGmWGXN7WdwX5HQhBgR31E4kqkro7nfjNrsbl4s04cte97YUyJ6Ayiw4jFgzPjGDkAB/
         ieAtmPQdZyIQeRkOEItjff5xx7e86T6qDMmm5dwUwDc/9Gljlv7shy3USxF0qhBm132b
         ZtcrR2UKj5FbDRoDyw8yt8ayni+NZr/iy8Y0ts7Kuak/H9kEB8aso2ru80Y3VpMAg8u3
         omMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757408186; x=1758012986;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3kIGJ9kl0r6kUwjXUZ1ORfokl7oD/4uZqckj4InLdxM=;
        b=wkOVacIIednorfWHABOVs//5alE9bC4f397GwK3emQiczZ3jrS+1ZE4mt8mC/dY/qu
         WGW0BbAllmjqhTgpL4+UD6lQ5LcpfgNAnRsqZ5C2TSJrLjhWuYClSIjq10CWNS/Erdad
         AYE3PO2BsnAufNwTR3pDDo1VjbZZ8Emq/wfiif8l2el94qTIpoDlNq27QwUyjrZb2M2T
         sxUKvSf45kDuHLupGc2I5daQB7C8q77Kqkp4HQM2lyU+BBkZAnRQ6p3/XqdtlNcwgd20
         WQfPaOqc/xnUljWOPqx+LyUEHbx97nzL8E6IsuqRNxh4nyVRN9OJ8bWZcLQVLiuc5CJo
         IiKQ==
X-Gm-Message-State: AOJu0YwC6a9Du7fbqe0QV9jzheacA0Rsue7W6X/aF6WzXpl0VY79vy5S
	Yt2RN6vnV1W6ThBbDLFKQhUvstTe0ksF4cWoRl/zgSN9r4MF8rtRK1J5k8K29J2YcMOhKIA88px
	RmDKciHDulOi/Vik7w5vCAfKE4ygPyBf+rg==
X-Gm-Gg: ASbGncvIrDungisB8VgV3KhwofxCmTq/Y2bSWRUxRVNiCoLGquZeBDkknTggHf8TsPw
	C7P3I0RiW1h2iorPv4B6qeAw71qzZLq0czZ+UXFuLVTjLUOdP9xUr3v11SHVmAbauVszfyxTnqe
	0HYbsjb8rZsbq2cy1gsR8XLImhqyMelMY9sWvTP5Do1WnqsSUDc/uTjTgtH4a+yeTOUFG7O/baT
	Ysx6gztOoVonYShdoBlIsvK65/gttx2U3r9gOWzSF1MoXR4DQ==
X-Google-Smtp-Source: AGHT+IFEHOer0sNC7iVnpabcHIxYR18kQOBZ/IFaBwTGohsjCOtPDW5bbLHovIYxl1Lvhu1RxurinuDEzKgVIs5HNGQ=
X-Received: by 2002:a92:ca0f:0:b0:3e5:4bc5:539a with SMTP id
 e9e14a558f8ab-3fd94a13fcemr131997355ab.19.1757408186243; Tue, 09 Sep 2025
 01:56:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2048.git.git.1757274320.gitgitgadget@gmail.com> <7d5e387916eaf4afd40afc85b1678306b8a5f076.1757274320.git.gitgitgadget@gmail.com>
In-Reply-To: <7d5e387916eaf4afd40afc85b1678306b8a5f076.1757274320.git.gitgitgadget@gmail.com>
From: Elijah Newren <newren@gmail.com>
Date: Tue, 9 Sep 2025 01:56:15 -0700
X-Gm-Features: Ac12FXw6S0iG5kONgkTmkwTQqe-RdlsxxRo5HZ8P1WpobKmyKNFwzLQa6cNwq6Y
Message-ID: <CABPp-BHWMZ4-T_DfOnS4AP-5qANjtdxasFojicy3w1ZTdoETBQ@mail.gmail.com>
Subject: Re: [PATCH 03/17] xdiff: delete unnecessary fields from xrecord_t and xdfile_t
To: Ezekiel Newren via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Ezekiel Newren <ezekielnewren@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Sep 7, 2025 at 12:45=E2=80=AFPM Ezekiel Newren via GitGitGadget
<gitgitgadget@gmail.com> wrote:
>
> From: Ezekiel Newren <ezekielnewren@gmail.com>
>
> xrecord_t.next, xdfile_t.hbits, xdfile_t.rhash are initialized,
> but never used for anything by the code. Remove them.
>
> Signed-off-by: Ezekiel Newren <ezekielnewren@gmail.com>
> ---
>  xdiff/xprepare.c | 15 ++-------------
>  xdiff/xtypes.h   |  3 ---
>  2 files changed, 2 insertions(+), 16 deletions(-)
>
> diff --git a/xdiff/xprepare.c b/xdiff/xprepare.c
> index 2ed1785b09..91b0ed54e0 100644
> --- a/xdiff/xprepare.c
> +++ b/xdiff/xprepare.c
> @@ -91,8 +91,7 @@ static void xdl_free_classifier(xdlclassifier_t *cf) {
>  }
>
>
> -static int xdl_classify_record(unsigned int pass, xdlclassifier_t *cf, x=
record_t **rhash,
> -                              unsigned int hbits, xrecord_t *rec) {
> +static int xdl_classify_record(unsigned int pass, xdlclassifier_t *cf, x=
record_t *rec) {
>         long hi;
>         char const *line;
>         xdlclass_t *rcrec;
> @@ -126,10 +125,6 @@ static int xdl_classify_record(unsigned int pass, xd=
lclassifier_t *cf, xrecord_t
>
>         rec->ha =3D (unsigned long) rcrec->idx;
>
> -       hi =3D (long) XDL_HASHLONG(rec->ha, hbits);
> -       rec->next =3D rhash[hi];
> -       rhash[hi] =3D rec;
> -
>         return 0;
>  }
>
> @@ -137,7 +132,6 @@ static int xdl_classify_record(unsigned int pass, xdl=
classifier_t *cf, xrecord_t
>  static void xdl_free_ctx(xdfile_t *xdf)
>  {
>
> -       xdl_free(xdf->rhash);
>         xdl_free(xdf->rindex);
>         xdl_free(xdf->rchg - 1);
>         xdl_free(xdf->ha);
> @@ -156,7 +150,6 @@ static int xdl_prepare_ctx(unsigned int pass, mmfile_=
t *mf, long narec, xpparam_
>         xdf->ha =3D NULL;
>         xdf->rindex =3D NULL;
>         xdf->rchg =3D NULL;
> -       xdf->rhash =3D NULL;
>         xdf->recs =3D NULL;
>
>         if (xdl_cha_init(&xdf->rcha, sizeof(xrecord_t), narec / 4 + 1) < =
0)
> @@ -164,10 +157,6 @@ static int xdl_prepare_ctx(unsigned int pass, mmfile=
_t *mf, long narec, xpparam_
>         if (!XDL_ALLOC_ARRAY(xdf->recs, narec))
>                 goto abort;
>
> -       xdf->hbits =3D xdl_hashbits((unsigned int) narec);
> -       if (!XDL_CALLOC_ARRAY(xdf->rhash, 1 << xdf->hbits))
> -               goto abort;
> -
>         xdf->nrec =3D 0;
>         if ((cur =3D blk =3D xdl_mmfile_first(mf, &bsize))) {
>                 for (top =3D blk + bsize; cur < top; ) {
> @@ -181,7 +170,7 @@ static int xdl_prepare_ctx(unsigned int pass, mmfile_=
t *mf, long narec, xpparam_
>                         crec->size =3D (long) (cur - prev);
>                         crec->ha =3D hav;
>                         xdf->recs[xdf->nrec++] =3D crec;
> -                       if (xdl_classify_record(pass, cf, xdf->rhash, xdf=
->hbits, crec) < 0)
> +                       if (xdl_classify_record(pass, cf, crec) < 0)
>                                 goto abort;
>                 }
>         }
> diff --git a/xdiff/xtypes.h b/xdiff/xtypes.h
> index 8442bd436e..8b8467360e 100644
> --- a/xdiff/xtypes.h
> +++ b/xdiff/xtypes.h
> @@ -39,7 +39,6 @@ typedef struct s_chastore {
>  } chastore_t;
>
>  typedef struct s_xrecord {
> -       struct s_xrecord *next;
>         char const *ptr;
>         long size;
>         unsigned long ha;
> @@ -48,8 +47,6 @@ typedef struct s_xrecord {
>  typedef struct s_xdfile {
>         chastore_t rcha;
>         long nrec;
> -       unsigned int hbits;
> -       xrecord_t **rhash;
>         long dstart, dend;
>         xrecord_t **recs;
>         char *rchg;
> --
> gitgitgadget

Always nice to see unused fields get removed.
