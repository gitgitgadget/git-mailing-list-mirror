Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.177
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793098877;
	b=EacvmLwwtUJV/WBhlHqoG6Ft5bYXQFkjWt9e2zThWEWDQDfXlYfq8/+7zIKAaMsGfDxw
	 rTj0NCSUx6iife78crwPneuYmVc69W5RJrcBeJ749syNpW5MgFj5cwt98VpFdiq6jZH43
	 mQwam1r9cR36UBu+7LVvVxbTea3Ow66srIQD0HpHO1MzDHwbJdiqwO7Nxdgyz99sZaMa/
	 A0kyew00ibpUXB1+5DQ1f1a9+KxCQhUOPPQPRRbEjFbAKzGkKBG3sLHA9N9aGG2z44cpA
	 BnPQbH9KFD+1XpG1Dc060Ia1GK3eMecb8c3t5PmNSOG6RQMNHnk5n1fllJ3xX4x0Fmg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793098877;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=p+wwrVF3OUfpPfnJESGFaoDo1T4IREtEjh3A7Jw92uY=;
	b=NnDW7lDSrPrpbsagyoYtCfVpOG55e9PfBRIh6Gmqjmtrd2Sc0/Wyyv1p8mGAqyYpsaUk
	 on4CK36gp26qcEHxwdHusk1C8NIVG2Zj3kVnBFbdcaeB0QQsTE2N4z8Ck2d35+tV87Kqi
	 gJE7P3lrhAHb+5CCbMbkpAL4Ar+wSZUVYRXg5vq/dAdiNCFaFs9jd76WCWntykD7lr5o8
	 VduyQia1LS/NWS8X1ZpPIi1kCdgHHmyGoGOr7eSf/+wBu7SX5JoH5nPn2ZdhMLZaDz4rJ
	 FEatwSCNRBtGJk8oRGorjZKcIINts5GnuONkJNoPxuYlZZvStPrDUSfDd/uka1kH9aw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=QesPc47v;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.177
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB0B7606A32C
	for <git@vger.kernel.org>; Tue, 27 Oct 2026 11:01:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BB0B7606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=QesPc47v
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-8b0d63f60bcso28623667b3.3
        for <git@vger.kernel.org>; Tue, 27 Oct 2026 04:01:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793098876; cv=none;
        d=google.com; s=arc-20260327;
        b=FQmWsk/6qa6ZaSRQ1t7Xbn2LXj4mB4GeXeJjJSNaGAHSVXfchVw+khvfITLlOdtFND
         dwZlWpMOD4y/sczR8BqSijAe/e+PAELI2ovtDpVapSRBM/5oWtYmvaD8AY3f9OdV7yal
         4XyMfMDvfK81b7HFjKvF3OSem7gzJheG4mvn+3JDmH2jDhp+t1dqxit8uqTkXREpn4XU
         hxRcN9uF1SUCQ+sl6r4LoAl7cuEBASrzSMI3FVyqMsRFecA80MhE8JVJV3FIdMwToK21
         UeooXuYmX43l4FiYETcidKB0cXwwEguCbVozZRtP1VAdru/+iSmO0zoLiZYqRYazP39N
         efUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=p+wwrVF3OUfpPfnJESGFaoDo1T4IREtEjh3A7Jw92uY=;
        fh=9xF8/pJwy7ZYvNA9qBvf3Z7QmRk2IJrjTl8ecjI8DwE=;
        b=Gpox9WSCwQyKEHFVF4spcxlnuPc+nHaxajaTfF0vSjGErMwZmwmjWz504JgQsXl0WE
         3M6MsKGtHSmzMvjjPKeomSoVDyxnoypTZHbrZnx7D6yIpKKIKpKyDZsEP/nJppZbd9Pc
         AOd5Zf+e136Bc+tJO6n4zdiRGtCVTFZABwo5q0goCsXWmnuvlBknkVa/e1blxsWzIb/K
         n8rNF5/E9rgNl/Zs9ZndP6uZy+AmpVfixKcFsP9wCcoiUR6JN7A0x5RtQoqPz0xlaCfX
         NRvSYK5ViipXf7dmsYvJiMAyoXnv7H+vNlH8Y9ajEDVmFtl5XVkuH5sXg5r1/qSb5NTb
         HMBw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1793098876; x=1793703676; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=p+wwrVF3OUfpPfnJESGFaoDo1T4IREtEjh3A7Jw92uY=;
        b=QesPc47vX7u+M+Q6YsupXnUJM/V1TQugz2O+1PAiJPLA7XRb1P/Al/Hw9ykdmS48Dn
         cEkjIC/38ioRQiHPru+fcryxPtKw4ycZqiF7aNlLaZU00J2YRd6EluSw1DnYDywW+pPI
         cGKCJixxj+71Wb0oykQozAWX45JuaLEWvQdpkZ/7Ge/q6IMRhHaPozpbKH5MDV/6aV1F
         k5GtpNDsZ7BYmEc3oWnFqpggT/BA6eKnt4WLplOEqFmcfscvRerOZy9FCp84eJ8tCMMn
         n9AqjM8YYhC2l/RNeFBqHQJGgw4g3Y/Yx4avuN4oOCyTJbNyLfC20Lshfmuw+nG5cvOY
         bVwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793098876; x=1793703676;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=p+wwrVF3OUfpPfnJESGFaoDo1T4IREtEjh3A7Jw92uY=;
        b=JL+Im6xWASZYSOzCv5OoqoXQFTEBpNw1PJ6aflAPbIJQ3HYAx/tGnJHoX4mPtkn40Y
         tu5TqsGbumRFehS+MAQQ1VmrAmO3KkdxiYqAhR0d+HOWCfRy5lG4AOqikl4aXjBpfdxn
         dv7w3hnd0wQJ08MdrVvrPh2vIgGD5rziaRdXM0NBfZg8Quq81sXdyOBcLlnqEBQu2qsJ
         O5Xwky5iMarneTnXrVrW77Lj1DEtLFQngdlOQ+nGoNXeRGeqiQ52xJucjtde/VOZ36vN
         7/SPT9ih9kC7NY/yxRlOyqmIEyOoaBMYL2gFRZaeZ3v/IX9aJIt5AMimVINzIDv+6MLY
         0Wsg==
X-Forwarded-Encrypted: i=1; AKwUvBweHlNZqT5SlmBS37G8jqpWqeK2TW7WmAPxKLH2cVdusl4KLUgiZZRQ2xTOlqeZ4PFIFh4=@vger.kernel.org
X-Gm-Message-State: AFq9FYJG2VNRSPBm/fePW73jRkmQBWL5rZkct/sB2pM7IzBs6MrGl0le
	k4aoF0+fixLn7AwI+z1STGZadmqRDGPnJfaazEgpY+s6X42l3cUfuUw/3WV0h5zdJ1PiPNULBMe
	eBf3o05JQSMUy7kCrrmsYLJmnaKoG7Oo=
X-Gm-Gg: AYBFou1XFpkenc+GKLbMt4iAtJuG+5a4mY5bjiUSYNlCZaCqkzOmPF7hBq25EmOZJqk
	V9JP2HfcjFBRhZgORm9BApaWvJwGv7z04Vij1YpQV6dRlVyjylaF3vFfWk0mGSMdnRBpjFwo7HL
	t5f3nsQXZ1m5T+eunoy468TzZPWABGUGKqlgidsbNBzXSIg9QuXyXHSwjp8NT3eYtpLvtiuFxYy
	r2GxgHWg4/RMRNmPv7AozJE1oF2JSclFHWM95Q2hgQZcyW2+Oaan/JkheXrMmoepOAw27NENgyi
	fD9nNsaCCukAt8gj5X7VscKeok7TIHsyWNn1z+94yiuNSmfdFylIjnsi3vYzjRoCXus6u+cKl7u
	rua8yWwAPG/F3Dmgakp3EQoSOBKO8VbWQRaxYm471N/pMPF4W16d5YWBht8CpV1JkPC4I2FMOvi
	A/d/cq1LB99HbjEDYnUFp3TBycoi87rzQnYfxphR5+6bsRLf3AUueDQjvi
X-Received: by 2002:a05:690c:388:b0:8b1:2b42:c9eb with SMTP id
 00721157ae682-8b166b95b12mr68997147b3.13.1793098875156; Tue, 27 Oct 2026
 04:01:15 -0700 (PDT)
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <pull.2276.git.1792727808109.gitgitgadget@gmail.com>
 <pull.2276.v6.git.1793076683043.gitgitgadget@gmail.com> <DMFJX3GJOXI0.1US2IH6P4LRUR@gmail.com>
In-Reply-To: <DMFJX3GJOXI0.1US2IH6P4LRUR@gmail.com>
From: Srujith Poojary <poojarysrujith@gmail.com>
Date: Tue, 27 Oct 2026 16:31:03 +0530
X-Gm-Features: AclHuK86EReTrDzhA3GYtayvujbHdy8I1AyyxP937NuPUDSHm2eKJOELsFxSvHQ
Message-ID: <CABh_KWhac74wQY3sTAFp7f_9CKKAmBWcE9wir4_1i7iZqsq8fw@mail.gmail.com>
Subject: Re: [PATCH v6] diff-delta: use safe integer arithmetic
To: Pablo Sabater <pabloosabaterr@gmail.com>
Cc: Srujith A Poojary via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org, 
	Phillip Wood <phillip.wood123@gmail.com>, Usman Akinyemi <usmanakinyemi202@gmail.com>, 
	Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 27, 2026 at 4:03=E2=80=AFPM Pablo Sabater <pabloosabaterr@gmail=
.com> wrote:
>
> On Tue Oct 27, 2026 at 4:51 AM WET, Srujith A Poojary via GitGitGadget wr=
ote:
> > From: Srujith A Poojary <poojarysrujith@gmail.com>
> >
> [snip]
> >
> > For the unpacked index allocation:
> > - sizeof(struct unpacked_index_entry) is 12 bytes on 32-bit systems,
> >   which may be padded to 16 bytes depending on compiler alignment rules=
.
>
>         l 117-125 'diff-delta.c'
>
>         struct index_entry {
>                 const unsigned char *ptr;
>                 unsigned int val;
>         };
>
>         struct unpacked_index_entry {
>                 struct index_entry entry;
>                 struct unpacked_index_entry *next;
>         };
>
> On 32 bit systems we have 4 bytes ptr + 4 bytes uint + 4 bytes ptr. I
> don't see how it could be padded to 16.
>
> > - sizeof(struct index_entry *) is 4 bytes.
> > - entries is capped by (0xffffffu / RABIN_WINDOW) where RABIN_WINDOW is=
 16,
> >   limiting entries to 1,048,575.
>
>         l 148-158 'diff-delta.c'
>
>         /* Determine index hash size.  Note that indexing skips the
>            first byte to allow for optimizing the Rabin's polynomial
>            initialization in create_delta(). */
>         entries =3D (bufsize - 1) / RABIN_WINDOW;
>         if (bufsize >=3D 0xffffffffUL) {
>                 /*
>                  * Current delta format can't encode offsets into
>                  * reference buffer with more than 32 bits.
>                  */
>                 entries =3D 0xfffffffeU / RABIN_WINDOW;
>         }
>
> entries are capped by 0xfffffffeU so the real limit is:
> 268 435 455 (256 times more)
>
> > - hsize is the smallest power of 2 greater than or equal to entries,
> >   capped at 1,048,576.
>
> After the code above we find this:
>
>         l 159-162 'diff-delta.c'
>
>         hsize =3D entries / 4;
>         for (i =3D 4; (1u << i) < hsize; i++);
>         hsize =3D 1 << i;
>         hmask =3D hsize - 1;
>
> What this does is set hsize to the smallest power of 2 >=3D entries / 4
> (with a minimum of 16), so it's "capped" at 67 108 864 (2^26).
>
> >
> [snip]
> >
> >  diff-delta.c | 10 +++++-----
> >  1 file changed, 5 insertions(+), 5 deletions(-)
> >
> > diff --git a/diff-delta.c b/diff-delta.c
> > index 7cbedeb507..efebce3aca 100644
> > --- a/diff-delta.c
> > +++ b/diff-delta.c
> > @@ -162,8 +162,8 @@ struct delta_index * create_delta_index(const void =
*buf, size_t bufsize)
> >       hmask =3D hsize - 1;
> >
> >       /* allocate lookup index */
> > -     memsize =3D sizeof(*hash) * hsize +
> > -               sizeof(*entry) * entries;
> > +     memsize =3D st_add(st_mult(sizeof(*hash), hsize),
> > +                      st_mult(sizeof(*entry), entries));
> >       mem =3D malloc(memsize);
> >       if (!mem)
> >               return NULL;
> > @@ -258,9 +258,9 @@ struct delta_index * create_delta_index(const void =
*buf, size_t bufsize)
> >        * Now create the packed index in array form
> >        * rather than linked lists.
> >        */
> > -     memsize =3D sizeof(*index)
> > -             + sizeof(*packed_hash) * (hsize+1)
> > -             + sizeof(*packed_entry) * entries;
> > +     memsize =3D st_add3(sizeof(*index),
> > +                       st_mult(sizeof(*packed_hash), hsize + 1),
> > +                       st_mult(sizeof(*packed_entry), entries));
> >       mem =3D malloc(memsize);
> >       if (!mem) {
> >               free(hash);
> >
> > base-commit: 47fdf2208c5b94c8cc01c106b8f7c85efb91c926
>
> The code looks good.
>
> Good job ;),
> Pablo
>

Hi Pablo,

Thank you for reviewing the code and catching that! You are completely
right=E2=80=94on 32-bit systems, the fields sum up cleanly to 16 bytes with=
out
needing extra alignment padding.
I have updated the commit message in v7 to reflect your exact
breakdown. Thanks again for the thorough check!

Best regards,
Srujith
