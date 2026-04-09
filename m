Received: from mail-yx1-f46.google.com (mail-yx1-f46.google.com [74.125.224.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 291E43E022F
	for <git@vger.kernel.org>; Thu,  9 Apr 2026 15:46:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775749601; cv=none; b=Ft3G4Hml0xL+ua6W+Cw0oQpRwtAy5SUcznBSdD/bWExD/mybLfFvYhpslano9bHXgZ6IcygeG7d5gjS5lE7SQpcy2IlWjyIFFAyvXSnPs+APhYr7PCN/VzzfvMg4LoIrVDGr9rWCU1YZJp2iaV9UrmSUX/Ut3jdbIiu8f3eyPtU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775749601; c=relaxed/simple;
	bh=Pk+l5CF5h1K3lFXinVeegyPB8wjxXk5LtTXIg+SgUOk=;
	h=Content-Type:From:Mime-Version:Subject:Date:Message-Id:References:
	 Cc:In-Reply-To:To; b=XkjyhxiTpsolcZHRc0NqA+bq81B3oQSTSaoqmurqTunjoQ/cN+FsyLrO7qvoR3ikb8UjU39USndpxsZd/0cmuanMNRL+QjIU1yRAz37YilfuHQ3oedH1B0wbKNPJomaVG9f6MDs0KGUJXQ5UJoqwRixJmBFhbxySrgRWpNemeOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=USXEbS4L; arc=none smtp.client-ip=74.125.224.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="USXEbS4L"
Received: by mail-yx1-f46.google.com with SMTP id 956f58d0204a3-6501d242e2fso1122708d50.3
        for <git@vger.kernel.org>; Thu, 09 Apr 2026 08:46:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775749597; x=1776354397; darn=vger.kernel.org;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YZJdo90HWUjPh3Vc6O16+5ViS6QIpUqFTIjPUahm25o=;
        b=USXEbS4Lis2sp7JQpSegBk0X9pohYda/Pcl7wR4RtCho9MFjLHECT/XcqMPN3dcoNO
         jnFzU8gEAlW1d+VyluyRNWcFG9NTfowylZFOcs6RVluGoz50SPN1p/GECPIcfg4ZE6Vi
         z8Cx22jDktmK//C+KW5ZWGGiV2S0xH+ZPLmKA11e31+E/dl7M1zQ628xTbpl10X7WBHF
         QvUYqkjrrIgbmCcrQzTakRbWXx39EvVYyaDqZb7kNJ+vjzcgqnUh5YpqFxp/S6HTxOLe
         1HWciz/6WGo+WfrxgHIB5wWRYw12tKk78l+YiE4xBpxr+fjhogC5c0shMo6F4Mchr41C
         w3Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775749597; x=1776354397;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=YZJdo90HWUjPh3Vc6O16+5ViS6QIpUqFTIjPUahm25o=;
        b=ARIOijDEyoiwOjVWHGWvrdYc9Qx/Wn1pFYxGhoHFEvEgMqJHsw4FlvbKQHjGnsVuVr
         nX3ePK0FNHDoAQDwZH+PWyYaG5FDEAXFWkEsvVMWk62BD82+iM18oFjcI0BzRLm9nDHw
         D1gVrYmxq8v0krFevTW9r+skjbMwPDSQD7dnInpNhk05ctMlQDt6A6/Tlwpj1hqUPf5p
         W1mtNeWBtSg5j7cGf2rUAJ+fRHz2rVmiSXfWn5/47sUMQAulD1I3dUX4kylubraMVXuP
         HOk9e9VsUVtSEf/AsHwMwwIDaqO5oCwjft7fkK3bABiAKHgzQc+fPTxwB3PGsOgSv2Qo
         hteA==
X-Gm-Message-State: AOJu0Yw/VME6jbJPDHb2tF/KWi+3u7IjTNgl7dHxG0s73F2XJEky2gW0
	AzeErVE132XlrdHTmhrAkBa6N53yidQhUWXAdjFhnZo9/DYxW6wKa0T9sgJOH8tu
X-Gm-Gg: AeBDies8L1F5tOTOWJiDBF2wjOPzV81mci6+xP3QG6aGCs9hQp/HRCjOjM9hdJMdkEw
	txxPGEtOraUW0SzaxUti8vW/F18kKL9ghG/DV4zl0eAe+W2CN2eU0CureMqL9ONR8guj5zL5JYC
	OJWJwVcPAWaWQpt01WlLkxPRbYWSE6jG8qDwZw94d5m1VFQVd+w3cKPicWdI28CVtydyqxEEPh9
	RYiwqGkLmMQWMaPVYvF0RwkjZu/rW2z4+MxoNIWSPmX810X0x3/aOIt105xvB+h0ktua3NO4HCT
	2MXsvaL8l5lVRF0v8jBrNnNpvc5WJA2DH7PtlHZiSox20Vnclwh+m5p1u++XAzUsjUI5i7mwGBZ
	Oi2FCjzgFzrvsIDroNorBXXy4eClIKJhXiQJqCzp238gnTd2bmvQnnopUvMdVetlPceERk6m9AS
	1ZzXbT+hVdigt9RXw71pCcFa51pEEjNkwTwNH9hVtlLlGRU3CyDZM3cxKWvj4YpPNmzFn8vZtzt
	hKJCiDrGMPQNaFbkXjde/y1cIohkMMbnWKQdVvX5Tik
X-Received: by 2002:a05:690e:1445:b0:650:895a:19c6 with SMTP id 956f58d0204a3-650895a1d56mr7799128d50.33.1775749596426;
        Thu, 09 Apr 2026 08:46:36 -0700 (PDT)
Received: from smtpclient.apple ([2605:a601:90fb:c300:6078:d96e:8f4:935d])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-6503a9d8c2fsm11194522d50.20.2026.04.09.08.46.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Apr 2026 08:46:35 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From: Ben Knoble <ben.knoble@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH] wrapper: properly handle MAX_IO_SIZE in `write_in_full()`
Date: Thu, 9 Apr 2026 11:46:24 -0400
Message-Id: <98E6F739-4ECA-44A4-8645-0B153C969E36@gmail.com>
References: <20260409-b4-pks-writev-max-io-size-v1-1-81730e8f35df@pks.im>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
 Jeff King <peff@peff.net>,
 "brian m. carlson" <sandals@crustytoothpaste.net>,
 "Randall S. Becker" <randall.becker@nexbridge.ca>,
 Phillip Wood <phillip.wood@dunelm.org.uk>,
 Randall Becker <randall.becker@nexbridge.ca>
In-Reply-To: <20260409-b4-pks-writev-max-io-size-v1-1-81730e8f35df@pks.im>
To: Patrick Steinhardt <ps@pks.im>
X-Mailer: iPhone Mail (23D8133)

Admitting I am out of my depth here=E2=80=A6

> Le 9 avr. 2026 =C3=A0 08:52, Patrick Steinhardt <ps@pks.im> a =C3=A9crit :=

>=20
> =EF=BB=BFSome systems like NonStop set a comparatively small `MAX_IO_SIZE`=
, which
> limits the maximum number of bytes we're allowed to write in a single
> call. We already handle this limit properly in `xwrite()`, but we have
> recently introduced wrappers for writev(3p) where we don't. This will
> cause the syscall to return EINVAL in case somebody passes an iovec
> entry to writev(3p) that is larger than `MAX_IO_SIZE`.
>=20
> Introduce a new function `xwritev()` that is similar to `xwrite()` in
> that it handles such platform-specific nuances. The logic is rather
> simple: we simply coalesce all iovecs that don't exceed `MAX_IO_SIZE`
> and pass those to writev(3p). If the first iovec already exceeds the
> limit, we'll instead pass it to `xwrite()`, which handles the limit for
> us.
>=20
> Adapt `writev_in_full()` to use this new wrapper. As this wrapper
> already knows to to call writev(3p) in a loop already it doesn't need
> any further adjustment.
>=20
> Reported-by: Randall Becker <randall.becker@nexbridge.ca>
> Helped-by: Jeff King <peff@peff.net>
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
> Hi,
>=20
> this fixes the issue reported by Randall in [1].
>=20
> I mostly wanted to get this patch out there so that we can discuss a
> proposed fix, but as said in the thread I'm also happy to revise course
> and instead set NO_WRITEV on NonStop for now. I think we'll want to
> eventually land a fix like the one proposed here though, and at that
> point the workaround would not be required anymore.
>=20
> Thanks!
>=20
> Patrick
>=20
> [1]: <00f401dcc6e6$7183c0f0$548b42d0$@nexbridge.com>
> ---
> wrapper.c | 51 +++++++++++++++++++++++++++++++++++++++++++++------
> wrapper.h |  1 +
> 2 files changed, 46 insertions(+), 6 deletions(-)
>=20
> diff --git a/wrapper.c b/wrapper.c
> index be8fa575e6..d989c78b4b 100644
> --- a/wrapper.c
> +++ b/wrapper.c
> @@ -323,21 +323,60 @@ ssize_t write_in_full(int fd, const void *buf, size_=
t count)
>    return total;
> }
>=20
> +ssize_t xwritev(int fd, struct iovec *iov, int iovcnt)
> +{
> +    ssize_t bytes_written;
> +    size_t total_length;
> +    int i;
> +
> +    /*
> +     * We need to make sure that writev(3p) call does not write more than=

> +     * `MAX_IO_SIZE` many bytes. If we do exceed that limit, we only pass=

> +     * those iovecs to writev(3p) that sum up to less than the limit.
> +     *
> +     * If on the other hand the first iovec entry already exceeds this
> +     * limit we'll instead use xwrite() to write it, which knows to handl=
e
> +     * `MAX_IO_SIZE` for us.
> +     */
> +    for (i =3D 0, total_length =3D 0; i < iovcnt; i++) {
> +        if (unsigned_add_overflows(total_length, iov[i].iov_len))
> +            break;
> +
> +        total_length +=3D iov[i].iov_len;
> +        if (total_length > MAX_IO_SIZE)
> +            break;
> +    }
> +
> +    if (i < iovcnt) {
> +        /*
> +         * The first entry exceeds MAX_IO_SIZE, so we pass it to
> +         * xwrite, which knows to handle this case.
> +         */
> +        if (!i)
> +            return xwrite(fd, iov->iov_base, iov->iov_len);

It took me starting to write this email wondering =E2=80=9Cbut i could be >=3D=
 1?=E2=80=9D to realize that this comment applies to the !i case below. Darn=
.

Still, I find the declaration (=E2=80=9Cthe first entry exceeds=E2=80=9D) be=
fore the check a bit confusing. Is that typical of our style (in which case l=
eave it be)?

> +        iovcnt =3D i;
> +    }
> +
> +    bytes_written =3D writev(fd, iov, iovcnt);
> +    if (!bytes_written) {
> +        errno =3D ENOSPC;
> +        return -1;
> +    }
> +
> +    return bytes_written;
> +}
> +
> ssize_t writev_in_full(int fd, struct iovec *iov, int iovcnt)
> {
>    ssize_t total_written =3D 0;
>=20
>    while (iovcnt) {
> -        ssize_t bytes_written =3D writev(fd, iov, iovcnt);
> -        if (bytes_written < 0) {
> +        ssize_t bytes_written =3D xwritev(fd, iov, iovcnt);
> +        if (bytes_written <=3D 0) {
>            if (errno =3D=3D EINTR || errno =3D=3D EAGAIN)
>                continue;
>            return -1;
>        }
> -        if (!bytes_written) {
> -            errno =3D ENOSPC;
> -            return -1;
> -        }
>=20
>        total_written +=3D bytes_written;
>=20
> diff --git a/wrapper.h b/wrapper.h
> index 27519b32d1..a6287d7f4d 100644
> --- a/wrapper.h
> +++ b/wrapper.h
> @@ -16,6 +16,7 @@ void *xmmap_gently(void *start, size_t length, int prot,=
 int flags, int fd, off_
> int xopen(const char *path, int flags, ...);
> ssize_t xread(int fd, void *buf, size_t len);
> ssize_t xwrite(int fd, const void *buf, size_t len);
> +ssize_t xwritev(int fd, struct iovec *iov, int iovcnt);
> ssize_t xpread(int fd, void *buf, size_t len, off_t offset);
> int xdup(int fd);
> FILE *xfopen(const char *path, const char *mode);
>=20
> ---
> base-commit: b15384c06f77bc2d34d0d3623a8a58218313a561
> change-id: 20260409-b4-pks-writev-max-io-size-e9b803439ae8
>=20
>=20
