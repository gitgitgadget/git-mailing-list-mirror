Received: from mail-pf1-f193.google.com (mail-pf1-f193.google.com [209.85.210.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5465277CBB
	for <git@vger.kernel.org>; Sat,  9 Aug 2025 07:40:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754725239; cv=none; b=FSqnaBbzVCoM59/v/65rgawshKRjvIxrqLHtEkKaGMM5VSfkBxj4ZWuJVv6PBsNdAGs9+tMunjhZMiwfEiL0LxcI/IxYq8PO4uLNzNvCPr8p6/C9KEPpKcLu7w/dx39M54HxIFLhVh3aBf0CZ8dOES3BXop0959WAMXoEOWps1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754725239; c=relaxed/simple;
	bh=ZRMMZVbhp99UVtjsjb178ILXURZWfxK5adnZ2gRNyB0=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=aTaNtubf++BXDmkYfs13j7rHI88mqzUMyxhqmVk84cshF1h3HiPpBsiYSbW1oGGD+5AAJ2IDPawYKLOCy6eGPa9uLY4essXLmW0iPRTSHM0IofZwZhxpH0BVAgmxgeJGSdWv+5wSZR6jFfx6VJ34x36i4j+xWYLKnBGcmd6m7Ng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nfG0gO4M; arc=none smtp.client-ip=209.85.210.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nfG0gO4M"
Received: by mail-pf1-f193.google.com with SMTP id d2e1a72fcca58-76aea119891so3922838b3a.1
        for <git@vger.kernel.org>; Sat, 09 Aug 2025 00:40:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754725237; x=1755330037; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kEfsLpS24qKn7JIwOL5ATfLEYBlkl2YhOQquJWpxLxI=;
        b=nfG0gO4My6puTMow3OIcUjqHiVGz4NKQZAY10xWpagTeClQ/mOH3SMsPf6RBjDHIeO
         /KZeFHHsErQYIeGxrGotFedZQAS38IFhIu+Wd296Nai1gQ1lrinPeWeo6Bh9D+FOiIAP
         /CwuSK1Y44XalobvN23UOoUVcD0fkypsj0Pxzxerhsh2whAclhF8+SRt5GwPSE02fz9d
         Jdm9wWa8AN1eIxIctVpuA0uFKy3w2Vplu0Y4bV+Hl2FCijpcwVxx8Ch1dZJ2CKqaptXg
         1ITp4SyO/B8pcn8mCVgP65ScQjdQmPReICIH3vsT2dBcVvgCwLgNIT8/rpzIVv4oY99o
         qzIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754725237; x=1755330037;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kEfsLpS24qKn7JIwOL5ATfLEYBlkl2YhOQquJWpxLxI=;
        b=J4vU8G6WzRULXeLNbs1rdHn0gXQfJcg5SMWelwBlN7nFUBHVefsq7QOIjgCJZ0tDOA
         N6SNtqDtBMH/aIAYuwRwgAwRAfVfkmw2ITUfhx/eeDtvWIb43FELbFQc/rE5QDHWBG7M
         L+7T/ZXUhHiQcsjR2jtbilf6+h9/eSy97SKO+zY0pCMNNG9pH8aW1rqRRLwA1QeTWqdy
         cN9/7Fdpd/gu0nKPWzsCcZ+B+vh1Rfkhzi0H1qziBxSMhphJf0MKrxRHK9IqCgTchZV/
         ub0Kx16vdPDV4n1+zeNnZudMzi1sISaUak9lsDL6mhZdzUHUuwtcASz+8chGm6ktkJO3
         hVqg==
X-Gm-Message-State: AOJu0YzvUnihYHItqm4VNZA3Z5Vl9fki70xXREd/9xffiv7Hetz7FI57
	OynEH6GAVZQqhIC2H6dHboEyvX72Jq8Cgsiffs6jVsEa1scvt4F6T3QAeLdLVUN7wmMTiQ==
X-Gm-Gg: ASbGncuazADpUnCaGLdz1NfP36u+VNNWeU9GGK0tS1k0LVBaTdtGA07dmFfSvVlpQwq
	vyuMl354d728lyQdZ/9wpPoj4dB9YolnWL10qZJRKwUkb0G3gBM0M6K9LpgTwg1jVyDTv6jeh4U
	tBllfcwI1pjAmHJNRbEw/5+MDRvLUcrtpb0qXFwMxe3Nmf6tp+3rQRz+ZLmbLEcvh3zpizsBtb8
	aQrr5FmErK9zGUtY1L685Xyz3YP7OkkiYtCIVE40Fw7qSWHyBgeM1RpTOSKKwIob6NoE9AeBhrK
	NtJ5upEHmbDMUHIBvBeGQ2yVdxi/q44kv6YIXKc2VMiN3t5v1MIPSDnCQnDJRGO+mPgEAR4wzzp
	tqKu69u/FmMIXE0pT5hwa7SrgPpA6RpclDGeOTZUthncmlEYfiiTn2Cd9mh0=
X-Google-Smtp-Source: AGHT+IHFRqpjdQ2Yh0+JibcmKONP6E9njGrUZpFhb9jtbsXUlYToRRbe/9PYekG6VPdj9/yrNdVaXw==
X-Received: by 2002:a17:903:187:b0:240:8381:45b9 with SMTP id d9443c01a7336-242c2afb941mr100540525ad.8.1754725236746;
        Sat, 09 Aug 2025 00:40:36 -0700 (PDT)
Received: from smtpclient.apple (n058152022194.netvigator.com. [58.152.22.194])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-241e899b5bbsm223030365ad.128.2025.08.09.00.40.33
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 09 Aug 2025 00:40:36 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81\))
Subject: Re: [PATCH v4] bloom: enable bloom filter with wildcard pathspec in
 revision traversal
From: Lidong Yan <yldhome2d2@gmail.com>
In-Reply-To: <20250809042236.72695-1-yldhome2d2@gmail.com>
Date: Sat, 9 Aug 2025 15:40:20 +0800
Cc: git@vger.kernel.org,
 gitster@pobox.com,
 stolee@gmail.com,
 ttaylorr@github.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <4CA97F18-6B0D-4CD9-AE3A-6232A8E775FC@gmail.com>
References: <20250809021642.22195-1-yldhome2d2@gmail.com>
 <20250809042236.72695-1-yldhome2d2@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-Mailer: Apple Mail (2.3826.700.81)

Lidong Yan <yldhome2d2@gmail.com> writes:
>=20
> When traversing commits, a pathspec item can be used to limit the
> traversal to commits that modify the specified paths. And the
> commit-graph includes a Bloom filter to exclude commits that =
definitely
> did not modify a given pathspec item. During commit traversal, the
> Bloom filter can significantly improve performance. However, it is
> disabled if the specified pathspec item contains wildcard characters
> or magic signatures.
>=20
> For performance reason, enable Bloom filter even if a pathspec item
> contains wildcard characters by filtering only the non-wildcard part =
of
> the pathspec item.
>=20
> The function of pathspec magic signature is generally to narrow down
> the path specified by the pathspecs. So, enable Bloom filter when
> the magic signature is "top", "glob", "attr", "--depth" or "literal".
> "exclude" is used to select paths other than the specified path, =
rather
> than serving as a filtering function, so it cannot be used together =
with
> the Bloom filter. Since Bloom filter is not case insensitive even in
> case insensitive system (e.g. MacOS), it cannot be used together with
> "icase" magic.
>=20
> With this optimization, we get some improvements for pathspecs with
> wildcards or magic signatures. First, in the Git repository we see =
these
> modest results:
>=20
> git log -100 -- "t/*"
>=20
> Benchmark 1: new
>  Time (mean =C2=B1 =CF=83):      20.4 ms =C2=B1   0.6 ms
>  Range (min =E2=80=A6 max):    19.3 ms =E2=80=A6  24.4 ms
>=20
> Benchmark 2: old
>  Time (mean =C2=B1 =CF=83):      23.4 ms =C2=B1   0.5 ms
>  Range (min =E2=80=A6 max):    22.5 ms =E2=80=A6  24.7 ms
>=20
> git log -100 -- ":(top)t"
>=20
> Benchmark 1: new
>  Time (mean =C2=B1 =CF=83):      16.2 ms =C2=B1   0.4 ms
>  Range (min =E2=80=A6 max):    15.3 ms =E2=80=A6  17.2 ms
>=20
> Benchmark 2: old
>  Time (mean =C2=B1 =CF=83):      18.6 ms =C2=B1   0.5 ms
>  Range (min =E2=80=A6 max):    17.6 ms =E2=80=A6  20.4 ms
>=20
> But in a larger repo, such as the LLVM project repo below, we get even
> better results:
>=20
> git log -100 -- "libc/*"
>=20
> Benchmark 1: new
>  Time (mean =C2=B1 =CF=83):      16.0 ms =C2=B1   0.6 ms
>  Range (min =E2=80=A6 max):    14.7 ms =E2=80=A6  17.8 ms
>=20
> Benchmark 2: old
>  Time (mean =C2=B1 =CF=83):      26.7 ms =C2=B1   0.5 ms
>  Range (min =E2=80=A6 max):    25.4 ms =E2=80=A6  27.8 ms
>=20
> git log -100 -- ":(top)libc"
>=20
> Benchmark 1: new
>  Time (mean =C2=B1 =CF=83):      15.6 ms =C2=B1   0.6 ms
>  Range (min =E2=80=A6 max):    14.4 ms =E2=80=A6  17.7 ms
>=20
> Benchmark 2: old
>  Time (mean =C2=B1 =CF=83):      19.6 ms =C2=B1   0.5 ms
>  Range (min =E2=80=A6 max):    18.6 ms =E2=80=A6  20.6 ms
>=20
> Signed-off-by: Lidong Yan <yldhome2d2@gmail.com>
> [jc: avoid allocating zero length path in
> convert_pathspec_to_bloom_keyvec()]
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
> revision.c           | 45 +++++++++++++++++++++++++++-----------------
> t/t4216-log-bloom.sh | 31 ++++++++++++++++++++++++++----
> 2 files changed, 55 insertions(+), 21 deletions(-)
>=20
> diff --git a/revision.c b/revision.c
> index 18f300d455..79372fd483 100644
> --- a/revision.c
> +++ b/revision.c
> @@ -671,12 +671,17 @@ static void =
trace2_bloom_filter_statistics_atexit(void)
>=20
> static int forbid_bloom_filters(struct pathspec *spec)
> {
> - if (spec->has_wildcard)
> - return 1;
> - if (spec->magic & ~PATHSPEC_LITERAL)
> + unsigned int allowed_magic =3D
> + PATHSPEC_FROMTOP |
> + PATHSPEC_MAXDEPTH |
> + PATHSPEC_LITERAL |
> + PATHSPEC_GLOB |
> + PATHSPEC_ATTR;
> +
> + if (spec->magic & ~allowed_magic)
> return 1;
> for (size_t nr =3D 0; nr < spec->nr; nr++)
> - if (spec->items[nr].magic & ~PATHSPEC_LITERAL)
> + if (spec->items[nr].magic & ~allowed_magic)
> return 1;
>=20
> return 0;
> @@ -691,26 +696,32 @@ static int =
convert_pathspec_to_bloom_keyvec(struct bloom_keyvec **out,
> char *path_alloc =3D NULL;
> const char *path;
> size_t len;
> - int res =3D 0;
>=20
> + len =3D pi->nowildcard_len;
> + if (len !=3D pi->len) {
> + /*
> + * for path like "dir/file*", nowildcard part would be
> + * "dir/file", but only "dir" should be used for the
> + * bloom filter
> + */
> + while (len > 0 && pi->match[len - 1] !=3D '/')
> + len--;
> + }
> /* remove single trailing slash from path, if needed */
> - if (pi->len > 0 && pi->match[pi->len - 1] =3D=3D '/') {
> - path_alloc =3D xmemdupz(pi->match, pi->len - 1);
> + if (len > 0 && pi->match[len - 1] =3D=3D '/')
> + len--;
> +
> + if (!len)
> + return -1;
> +
> + if (len !=3D pi->len) {
> + path_alloc =3D xmemdupz(pi->match, len);
> path =3D path_alloc;
> } else
> path =3D pi->match;
>=20
> - len =3D strlen(path);
> - if (!len) {
> - res =3D -1;
> - goto cleanup;
> - }
> -
> *out =3D bloom_keyvec_new(path, len, settings);
> -
> -cleanup:
> - free(path_alloc);
> - return res;
> + return 0;
> }

I realized that I shouldn=E2=80=99t delete free(path_alloc) part in the =
patch. I wonder if
Junio could help remove that part from the patch.

Thanks,
Lidong=
