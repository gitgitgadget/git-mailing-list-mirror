Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2D8326AF4
	for <git@vger.kernel.org>; Tue,  4 Aug 2026 03:15:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785813330; cv=pass; b=Nz/V5uJK8lDQ8Z9Ja5cLFzAiptwv0iE2F0c5JdeMkkj+WgfaNPy9XDWiveKr2Zge4QctNv01d0jfQ2Y4r2MeaU+f6age41UKUSvuDgZRNrRuXSZgeyIHELIyOGvjfbqta3U6ZsBAo96Bs8CMJJRUpztZiWIcxrIPjdgozSwDkoo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785813330; c=relaxed/simple;
	bh=SJnOfErtbdFXBUjC5KdzymH4RzokDazXh7P6zW6Magk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nbUdj5JjoJ975U7zVS9OvPSyCSq1zteCEVTqbr9MzkFaB99gpAgimTPK2ljjp/unJeubBQQK0EobpwL0qK+YOcHuTfz6zkBEXy6OSPTX/aIQ6R864mAkEibmcoWYbESmwxDPNrpIA94cB9U9a0C0lCeYvmfNnUVGiifaMF9dYHI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q2L3RCRq; arc=pass smtp.client-ip=209.85.210.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q2L3RCRq"
Received: by mail-ot1-f50.google.com with SMTP id 46e09a7af769-7ec58fa3e01so1949391a34.1
        for <git@vger.kernel.org>; Mon, 03 Aug 2026 20:15:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785813328; cv=none;
        d=google.com; s=arc-20260327;
        b=kU5SNAcmDYYyh/Uje9JWLybQhoLpO6zdbpMcD8rU5csBn/VgFsuXN+9M1+4A+kDZ77
         61X7ybkDn19qNCGjYMVQyFuJ/i4KrREKyyxZ10IRtWi5pLHaXAbT668FcUXAGRNv3RCx
         XmQC9pm7XUBLwPstR4VRLGJW7EINJvbFhGm6FXPcAcl2gYS1sOX2TnNn4raXYA0fHoda
         AfSnO3fT11MtwSTVf8/FABIKLSqHl6BZND70KjP5g3cos0VDoS8JIOrYKs6k5ZxDvxoC
         yHy87ri0/eUl99AiVnS95g8FEG9MLxdqtthUHfmJHJ9q/VRVHfUgf5RyLEGE0jW4Qj9e
         eR0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=LBDYUQWb1l0BQDszMY7VbmG2/0TjPlpfp7W/p/bJ9S4=;
        fh=IVGEz1OY2FLCd/VFfFv5hNHv0THxOHDjSY5jvQzW2Lw=;
        b=MhTZDM1AAynaMV3ACR+U3DCZbu/y1et82Gn1+fBP8JaWKiAZ++Dw4d8YumS5qnkcGU
         uR47S+2OgjonPxfOFQ9N4/frzGSQlll4zbsxgj8/VKlpB2cX4NswtSIiU5PZ9kxT4kV9
         4EmfBuRPIsqTOtreEl/ZFmFS3rXdEpX7WiripzD9kRNj+Y2nmUfauMVbOIbq0V56rdSW
         0boywizeMTcnBE/HsVd4v+SfvCLB3yZF5i+Be5dR+I5wxAfwnhxuQRYtD4iFZ+akZxqj
         wEx46AxN5f7riHWWDoS5bTe+LickyKmtC/ObwXixMtUJlI/4JrK3DTahcOEQRNHC3Khw
         9xHQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785813328; x=1786418128; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=LBDYUQWb1l0BQDszMY7VbmG2/0TjPlpfp7W/p/bJ9S4=;
        b=Q2L3RCRqs6SngLw+9ok/jb7LrKMtvouXzdiMIURLaPsOAcwUBA7gdjpAR6qOyZfR44
         p0gcWYOXty0+rWJC3Ejb2HnCDh8d8L8HZPldTXrnvYCxrBIPyhA1zSTHfz/layd1ZhjL
         +GJjRyLXH+pu2bWt7Bsar7fxW/UmjuvihwPBLvpcQQfX4om5ANSwlLkQk9WmUDpJbEFq
         LHHYWDxEIy9gDMptkzRTJ0/CRiFYkYf1NcYU49u5Y6UiRby7mZH9tt1Vee9ngLnyHxJm
         T8KwD1LaYGtHA+bESWJ966n+CsfmGUGOgtQx2vKuXS+iMuIVETBodDzK7jNOKvzWl77y
         xqAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785813328; x=1786418128;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=LBDYUQWb1l0BQDszMY7VbmG2/0TjPlpfp7W/p/bJ9S4=;
        b=UZM8AqqlZ047s6KYDcPPmoRlW+qNp+S0YwV/EMsoEjmRc9IgxfeLa4UL2W7iED72dK
         yjXFOcjreHbtAbdQZZ/IbroincqVlnuofGGY0A7JFbxmvwSoaG8glwlrdjo1xBlx/59Z
         jFJknpYjxg22uLdIqAU/obSVgmamN5gm2L9TGTCuzuzmE25SRIGtWVbN6w04pXDZ/ROD
         U423ekmvqnj4VFSaa9H9Fc4Fenpg/7JE6ibTRT5xqWfgyPbP1GgNOLhawChyZ2s/1Um1
         Cljv4LKeDeIVDHl9mIg3NJyJqlld64CT//AR0Y582/GsHGaesSJMIQyx4tl9iKeM3f/p
         GShA==
X-Gm-Message-State: AOJu0YwOn7KsfcBLX3NjCREnYs0Ae12L6YV9MbFpKg/qJpcRTWcr2CMt
	cVAlg0eqeicW96IrIwlOf0du6rOGOCER419AFCIOsfYWAlty1ZGUeG3rilKfxFD9qIb2WSS5S/n
	aCPRJTAnunJMmmm4U1feTwbEv6luv9qFe3ebe
X-Gm-Gg: AR+sD10gCSXZSjG4O3AxTuq0A2hCKjFVsfVHNiMSfbvofgTIbIyJlMqjZohUblLVNca
	HR4kdMO3I0Mq/gBESnm5nwNQHQ/qTvY3+dsbS/QKShLQtrnaM8bfm3H72LYcEon/bVeGsm036B9
	Ndm+XOpo64GI6DqLpAESZhNGDaKfmQV7zIIFp9fkyFXYuciJqphPSPs2Pf/YroerlnYpOwS7Lhy
	j/mPHetJ+zR6taU2x8kpnb0DgFU8YbH5jCnm3xzow6VTZ+ZZzwbY7ey1qSdIcFrJp+FcPrjputh
	Eby7dA/BAWuJbnJvSkqZkulpTg7ELHEYUlV8nRDTrWevyFKiy/3y8D6JCO0TRmboB2mQb8Tt6xP
	UIY00wHjTrAEKdFIw5eQ0prQRZpJNrOKtJ67VQkKKcFxgDt/uQ6nNEagY7hXl1PU=
X-Received: by 2002:a05:6830:61ce:b0:7dc:3db6:f02 with SMTP id
 46e09a7af769-7f196d51885mr22612244a34.9.1785813327763; Mon, 03 Aug 2026
 20:15:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2120.v6.git.1785091889.gitgitgadget@gmail.com>
 <20260801174156.2998808-1-mmontalbo@gmail.com> <20260801174156.2998808-11-mmontalbo@gmail.com>
In-Reply-To: <20260801174156.2998808-11-mmontalbo@gmail.com>
From: Michael Montalbo <mmontalbo@gmail.com>
Date: Mon, 3 Aug 2026 20:15:16 -0700
X-Gm-Features: AUfX_mz6Fcb6neuIBnsMUaeUhHaXh0nCAL4qcEUPrfcmA2wttA_0mqY7EB9pWG8
Message-ID: <CAC2QwmJbkh023AZe7fHxRVwzyVmFghvs8fuBHEAg5tdD52F0-A@mail.gmail.com>
Subject: Re: [RFC PATCH v7 10/10] diff: consult oid-only hunk providers via diff.<driver>.process
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Johannes Schindelin <johannes.schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Aug 1, 2026 at 10:42=E2=80=AFAM Michael Montalbo <mmontalbo@gmail.c=
om> wrote:
>
> +static long blob_line_cap(struct repository *r, const struct object_id *=
oid)
> +{
> +       unsigned long size;
> +       struct object_info oi =3D OBJECT_INFO_INIT;
> +
> +       oi.sizep =3D &size;
> +       if (odb_read_object_info_extended(r->objects, oid, &oi,
> +                                         OBJECT_INFO_SKIP_FETCH_OBJECT) =
< 0)
> +               return -1;
> +       if (size > INT32_MAX)
> +               return INT32_MAX;
> +       return (long)size;
> +}

"unsigned long" for size breaks the build wherever size_t differs from
unsigned long (32-bit platforms and 64-bit Windows):

  diff-process.c:331:18: assignment to 'size_t *' {aka 'long long
unsigned int *'} from incompatible pointer type 'long unsigned int *'
[-Wincompatible-pointer-types]
    331 |         oi.sizep =3D &size;

I'll fold this into a re-roll; in the meantime, squashing the following
into "diff: consult oid-only hunk providers via diff.<driver>.process" on
mm/diff-process-hunks resolves it.

-- >8 --

diff --git a/diff-process.c b/diff-process.c
index 121903a6c8..d28f9cf973 100644
--- a/diff-process.c
+++ b/diff-process.c
@@ -325,7 +325,7 @@ static int validate_external_hunks(const struct
xdl_hunk *hunks, size_t nr,
  */
 static long blob_line_cap(struct repository *r, const struct object_id *oi=
d)
 {
-    unsigned long size;
+    size_t size;
     struct object_info oi =3D OBJECT_INFO_INIT;

     oi.sizep =3D &size;
