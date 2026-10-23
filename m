Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.161.45
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792756897;
	b=4v7RVfflq9My+iAuXuaBqj4f77G8MjjCyHpxNPhHr1VM25+C50pZtUC+kMrufEntXvL3
	 zgg/oR+L9j3VDr9hr8HGmoSonke5uqiAZCu25M3syuM+vs23zC8CIQPthUMhDKH28QE1L
	 ZNAAQIe5F5SzL3e9enPfQs61TrbZEz0ZxZlYOWWWY0SYck1TDC0MRAoMLseN+SpHn60XD
	 BThz+zyLMChnwWsuc4iYvQKzZShCI1U0y4iKzf7JawdRo08W/vartSiSL824O/qSLNdCy
	 b3D6NHbnZ0hTK6EH/Dh96d0/9bbu22pSY9F+lIyxRiaRszSbWj0Ty/LYMr6IEW44sqA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792756897;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=nudPFtTy9uFZrQk6/h/6VawsvyXPWRfTPXuwPZCeUvw=;
	b=TS2Fj1LvQnmw1vdFHFW/33eAtKRpOf50PXmwO5IHPMwr69PxrzrircPCiQrO68F1lLBM
	 MUYIAs9oP0OnpbuYz7sqzuIe9CUPLSlXoyviq5Z5hbHLJbZ84LDJYiRfVUW8MgO4aztXO
	 aUrJ8CuTBoUcfFBX4X5K4WRNlTbjIgZv7SnErGjWwaFd4CTWFG9Ede+g09j1zUnD1Ej5C
	 9qbfPwf/aUM+O1veav+GFY9Kup8lTTm9vhK5nb8JDbbxjPIbblt4MaeFXaNu74ApjeiNa
	 rGoADPMCVAp5vY19BsZoWkg9JThSZl/l/w7W7BeYIXEFRyMPaaByx5p2E2HucAz8Gew==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=fUcZgaLU;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.161.45
Received: from mail-oo1-f45.google.com (mail-oo1-f45.google.com [209.85.161.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA65F606A31A
	for <git@vger.kernel.org>; Fri, 23 Oct 2026 12:01:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AA65F606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=fUcZgaLU
Received: by mail-oo1-f45.google.com with SMTP id 006d021491bc7-6dd4f3f696aso477756eaf.1
        for <git@vger.kernel.org>; Fri, 23 Oct 2026 05:01:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792756896; cv=none;
        d=google.com; s=arc-20260327;
        b=ig+p54mdsfXcKndikULm4zfhQuiZmuOepCHsmAVKc+X2gzniJZbqGWbuMhIHU3nw84
         mBNxjsE+Ls8JAYbCGiO1cgMSRiTdeRfJgpqMhR9qLWgKsxB5QLRnUlyqf9ow+pugTI9y
         s7ZtI74rVpsa2Da5iv3476l41xKWipWGvdLXzeWt3I7SPl1SEnsbhCSwQS3eKVGZpabh
         2W08U9SkuRL5Yxv2XY1mALxWve8ZK/0I2cODSZ0sRMngUGECgJGdCO25K32aK0qkZ4SC
         S6fZeSl9U7SZNLmwMGht7/wyoqMfIWDsFfmT7rQpFlKrKMB9eeupw7OQhCNvovcfPzlQ
         OQ6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=nudPFtTy9uFZrQk6/h/6VawsvyXPWRfTPXuwPZCeUvw=;
        fh=zmy31XQZO3P3w6SLarz79Vf7zbk6CuV4vF5b7qdNdCA=;
        b=q4qxg8do/LRoR+SeKNl5OJlu4vh+aISeL4a0GIT+gVWXW9C6mpbrSRCun2oFQIdtvL
         85nS6ZLkv1EZ1k778WxjLYfBHRQjQBV1eOzAyeKCw29s0pFKe+FxhvlLVILADbKeJW3x
         A1KEVDIrRCNpFB8qFTH0Pfx74CD6PHB5XMoxCVt3ESkYrssZrleaYEcK8U7ECkMJr6pT
         29zssUfCqVtuHdaPrNISc2ze8jm73Z03l801EOWZlBGlAFWy5TLjtElGjzuThoJD+dYK
         ZrpFp9FjCEGTYLh1JNqvHAgMHLv3gzj4gG9z5kUpqvS0sd8ZVl03AMROcYQJk65MmE55
         lEYA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792756896; x=1793361696; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=nudPFtTy9uFZrQk6/h/6VawsvyXPWRfTPXuwPZCeUvw=;
        b=fUcZgaLUzx2nzMqLEEuyNLdqwXVWhRQ079Zugz6bMLLGtxd8y/9g6YSL8wc2mUid7n
         SspanSNxRQSKajneFPqgBLHvkQOBjvwjFFghYtN0CRajiHNq9FoYiFTlFLsl68rT/ikh
         BkWk2BcKd8fV6+PGa7wCRA9jhv01sXSMklmP1Hmil6HOm5bNcYO/Zp345RRtSKqqAawl
         fBAuPsxE6NjRie3qrXMEZBkrTP9abOGTZVBJHZ/IAKu+c6B62sII7dYi+XW4HJ1g6mwb
         OOt67gbiUmtVF+J1msVUhc3gdHDu9LYMLYPBkTpn6ZwdSCGP+rQYmSErTLOt2hJp2uLQ
         FgqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792756896; x=1793361696;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=nudPFtTy9uFZrQk6/h/6VawsvyXPWRfTPXuwPZCeUvw=;
        b=gMCwYLFFWPmF17DaUxsEsfqG9i5kqAu+GNix+IrTu2OCxh5Sw9bO7urZ4JQmDANb96
         soc14eCrXI3jmztzT8mWj2eWqYHzyk0dKKsxVjtD7d2H4eXlWwBHwJ0cYecTnQQvnXYX
         EiuUGp7xfxFLOcgPL24ZjltfC6XwXq0pfWgoxCo1iCwJPKdmfb5BQx/FbgxsMQ5ricDi
         wMXGEpo6WnqKcUXVpwwUPETSGni1yS+49GKyppmf2MQKZU8RyH55kO5jzobsb4XI34fY
         5NqaWgp2Q2rRmJvHDz8TVG2duEP05Y1bEAoIGXOf78XU3SlDCi2NTj7zvd/etIwShfc+
         wNvg==
X-Forwarded-Encrypted: i=1; AKwUvBwNIWG5geu3bNtKj9T+puV5K9TYWPXxKl8fFM7st3eayvbj+X7Mw2OPirwbJXaxY+y2CwM=@vger.kernel.org
X-Gm-Message-State: AFq9FYJ3EY6YXDAiZ3iLLhyATdhfL+RcG0n4r1h1Pz1oI/GQMM8CJ2ew
	cbieykQURLuA9Gy48zEDifWWyte0hRkm7NHqTr8v/lVrkmJ0XUc94//k+VKtzj1vTaeUdaFHKfl
	eQOWr+sNijOsG8QZXhjUqxl9ewwsFuzU=
X-Gm-Gg: AYBFou1hx8MSzlSCrGLqyCVoISg1JaZSyjFaALM8NxXX81crtFUAG1wLCD2iYxrMxKz
	XKeLyhnFYXZqrADfZ/WC9iU9mInKagz0rX2+RDsCmoaThSgQPF4ajYDHYWTEko7E3I6sczPJ+WC
	ZmR2aqp40LTRiJzgpVEaE2gNezjFSA2NVxxEroNr3Uo8agUabjRpCotr8IL+vblbII9f0RCQmSX
	E1Ul+vSxbFuw+HAj9DkeOlmqkExexjp2vKAO+/J+3xS+UJrF238sg8R2Pmt2DRMHVp51Srwd/IF
	Vuc+tkcOJqA8yyIwTEF8eGlquCONsHan2aubjodG18GwjRx37kJVIZpTw1ktNnUXyizO24SxGuP
	/EvfeEFPrU5YBPzjK19AjZMjULZN4aokAcwtbmN558+MFnOaqYTd6z42ZaMPXkU6dejIRn+ahji
	eE6ivU
X-Received: by 2002:a05:6820:2205:b0:6b6:87cf:d1dc with SMTP id
 006d021491bc7-70b889b7a27mr1211810eaf.24.1792756895651; Fri, 23 Oct 2026
 05:01:35 -0700 (PDT)
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <pull.2271.git.1792522587065.gitgitgadget@gmail.com>
 <pull.2271.v2.git.1792662432.gitgitgadget@gmail.com> <df93a2a86cae7d342270c0ee67a1c0d41ada202e.1792662432.git.gitgitgadget@gmail.com>
 <atnz1HFcA8q8IuE_@pks.im>
In-Reply-To: <atnz1HFcA8q8IuE_@pks.im>
From: Joie Joie <soniqjjj@gmail.com>
Date: Fri, 23 Oct 2026 13:00:48 +0100
X-Gm-Features: AclHuK-NaD2Y2aBV0xPJiyDGJzP1S1bZNdPe4i31LJ7n2T1SA1pwhNpvv66VCnU
Message-ID: <CAH=d44czyUb3Kam8oEfdqY0ROO4636XN5NuuQ0gn+wHUe9xETw@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] repo: zero-initialize configuration values
To: Patrick Steinhardt <ps@pks.im>
Cc: Usman Akinyemi <usmanakinyemi202@gmail.com>, christian.couder@gmail.com, 
	git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Patrick,

Thanks for the review and the suggested wording. I'll add an
explanation to the commit message and remove the now-unnecessary
comment.

I'll include both changes in the next version of the series.

Thanks again,
Joy

On Thu, Oct 22, 2026 at 12:30=E2=80=AFPM Patrick Steinhardt <ps@pks.im> wro=
te:
>
> On Thu, Oct 22, 2026 at 09:47:11AM +0000, Joy Gundu via GitGitGadget wrot=
e:
> > From: Joy Gundu <soniqjjj@gmail.com>
>
> Even though the patch speaks for itself, we typically still like to a
> sentence or two in the commit message itself. E.g.:
>
>     When initializing `struct repo_config_values` we manually zero out a
>     lot of its members, which is tedious. Reduce the boilerplate by first
>     zeroing out the whole structure so that we only have to set those
>     members that have a non-zero default value.
>
> > Signed-off-by: Joy Gundu <soniqjjj@gmail.com>
> > ---
> >  environment.c | 14 ++------------
> >  1 file changed, 2 insertions(+), 12 deletions(-)
> >
> > diff --git a/environment.c b/environment.c
> > index c83cf44839..89af09aa40 100644
> > --- a/environment.c
> > +++ b/environment.c
> > @@ -752,34 +752,24 @@ int git_default_config(const char *var, const cha=
r *value,
> >
> >  void repo_config_values_init(struct repo_config_values *cfg)
> >  {
> > +     memset(cfg, 0, sizeof(*cfg));
> > +
> >       /* section "core" config values */
> > -     cfg->attributes_file =3D NULL;
> > -     cfg->excludes_file =3D NULL;
> > -     cfg->editor_program =3D NULL;
> > -     cfg->pager_program =3D NULL;
> > -     cfg->askpass_program =3D NULL;
> > -     cfg->apply_default_whitespace =3D NULL;
> > -     cfg->apply_default_ignorewhitespace =3D NULL;
> >       cfg->push_default =3D PUSH_DEFAULT_UNSPECIFIED;
> >       cfg->autorebase =3D AUTOREBASE_NEVER;
> >       cfg->object_creation_mode =3D OBJECT_CREATION_MODE;
> > -     cfg->apply_sparse_checkout =3D 0;
> >       cfg->trust_ctime =3D 1;
> >       cfg->check_stat =3D 1;
> >       cfg->zlib_compression_level =3D Z_BEST_SPEED;
> >       cfg->pack_compression_level =3D Z_DEFAULT_COMPRESSION;
> >       cfg->precomposed_unicode =3D -1; /* see probe_utf8_pathname_compo=
sition() */
> > -     cfg->core_sparse_checkout_cone =3D 0;
> >       cfg->warn_on_object_refname_ambiguity =3D 1;
> >       cfg->protect_hfs =3D PROTECT_HFS_DEFAULT;
> >       cfg->protect_ntfs =3D PROTECT_NTFS_DEFAULT;
> > -     cfg->ignore_case =3D 0;
> >       cfg->trust_executable_bit =3D 1;
> >       cfg->has_symlinks =3D platform_has_symlinks();
> > -     cfg->use_nanosec =3D 0;
> >
> >       /* section "sparse" config values */
> > -     cfg->sparse_expect_files_outside_of_patterns =3D 0;
>
> We should probably drop this comment together with the code.
>
> >       /* section "branch" config values */
> >       cfg->branch_track =3D BRANCH_TRACK_REMOTE;
>
> Other than that this looks good to me.
>
> Patrick
