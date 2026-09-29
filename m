Received: from mail-ed2-f34.google.com (mail-ed2-f34.google.com [74.125.228.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ACB53F6618
	for <git@vger.kernel.org>; Tue, 29 Sep 2026 18:35:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.228.98
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790706905; cv=pass; b=SWgVoKl7f2YV1qzAjv6P7L3E5KIALkt1N/SXXN+ZKO39NQgy7IeBPb4TrrtrxJ9dWVIvFS+7LpmAtHpOpYG2eHm9+YmQBXg4qx+ueCv/JgyHDIk8MJojKE0+NzVufukjWcyr0I7jQtBbXJOMUaUyj6FGTz8vZYsI7hQY1boPGPQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790706905; c=relaxed/simple;
	bh=0Y8MONIebP/NHqK6PLu8J618UF27y1livAB27IblfKU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qPzokSn1x273q/1EbSteKdV34SEt+jhImYP39cWOhXQuMnpejEVjbUKrErAarg74gfawj1UVvWMzPnoJ/QBCSjY9DFsgGW8/ex4dcfyThZSX/RO/1uXzMlBENpsHmUSRCdhztpvO1qIuT723WMKi1DJMTh2QPlxEYvVgIq6NzYc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Xdg6BgS+; arc=pass smtp.client-ip=74.125.228.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xdg6BgS+"
Received: by mail-ed2-f34.google.com with SMTP id 4fb4d7f45d1cf-6aaf688ebb0so5458843a12.0
        for <git@vger.kernel.org>; Tue, 29 Sep 2026 11:35:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790706902; cv=none;
        d=google.com; s=arc-20260327;
        b=pMP4biMBfIlJThe6f6RRgurhBfsD/IZl6YsC1n18wDAKOHVCUuOZCBFNOVYroJ7UCP
         bhDhKPqYytpOIh5ac/+zMvQNqA+3ciKVOzxrjbxN7Z3r9ZrxgCrz3klk/msCiLV/ELc/
         e10tPfJTWaclcJ0/2eOooUP5gfznpiMwB8bpPt3DnSusxdvjFEgtcFuDVSGtNAhgFZYj
         C0AI2nHXOG0sYxCmvU3AU0vY5y3iaDys0uM3IY9LnK42P1HqFCd6TbmoUdQoeJhtY7wn
         9C1SSpWRp6nsAsVsO7pw8eK+eNX8wvG5+zMPbw5RsdYKaYVTgRSGP6C4Ruo3gVI3m3Ht
         DTHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=jYlRknYmskmnVPCtpypGrOCSOKRrK+ItQbdAZ0Y2Fl0=;
        fh=6jUYtma6tjdYOlH52eLgJyi819CG6Ikd9xjHWcrlI3w=;
        b=FLUPD2gMTWJAeJTIctbAD8rapEzzsVKGzfNFTWana7+gN+Ki38robhZnFnoUoFRsqi
         1TYwMwG7S8BMfTsRj7HOkDKKXn1gWyC01Jex+2It8P1JY9MhkcXji2e7z1m49/5I3J3l
         7xWYv3s96Xk5X4UUF8JwtdcRl4v2PmWo2jzEEVp9b4qZseW3Lk9XhS7yBPr8BkogEvlJ
         5sFn45On16aK8L69xcjUaDzXkS5TVeLb0NPSIkKFLgMnkEp0OxBK79cTuyNJbypnC8PY
         4VicZOJ15ShD3037Aa2KXG7uiaoz5tF2JWBmWCQxktX4EU/TezkpbsjoZEGAo9fvweP4
         /3uA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790706902; x=1791311702; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=jYlRknYmskmnVPCtpypGrOCSOKRrK+ItQbdAZ0Y2Fl0=;
        b=Xdg6BgS+T9UrDHarigu2L+zOI7aC3ViyAo5Z4vNwvX+/P/8Bz83eJOAl2RbvVP9to3
         qCVwGQ43/xJMsrrFuruUiHiA1qbrjU0xmrlZwW4kD91Un/Rj5+ut2dGmwx3J5Z1vFWvK
         XWwWKLTbZcZsRydHBw0wEN+G4XbCSuNIt8LE4sJx8PFN9Oao72at58pWvmVumrtNrIJC
         /wGV6JcAn3+cc9F5PlWc7o0I+EvXE5FgMWo1CHrN7R873kEUqfIRZTOQvEWrCzRlW9SK
         wDUAB8+WuFslKMh70kEUkuRYTo2Bd3SrYH4bq6k/6MFYFKKes+0tfKTA2FJ6P7DdCMG0
         tK7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790706902; x=1791311702;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=jYlRknYmskmnVPCtpypGrOCSOKRrK+ItQbdAZ0Y2Fl0=;
        b=b5Ap3DiHa/PoInbrqA56zG38pwVRSXvTUFiZc/PYQF4VRID1E7gEy8HFsuRSUHkLEn
         rs7zHF+Rkr1sjyX1gkc4gBtTs47p5bbhgTnIbC2hV44xh6nAEjeBjoXnamw4+GP201li
         uCCKSeW3Vq/g/RaYQ2Zvtlfv2akfTjHvBF8gX1qaY7aE5SEe8My9k5uR87G/2XgZW1hL
         XfUYiNDko5mAe4VFh76MRizNpMSqqAkzwa86rFqus1ucOijfAdBhWRHWPUk7nn9g/qfZ
         ZZNIgMMnJDKGDsGjXLGDrSP/7bgJErAuPr7qrzerQx0DQfQ4GNc4RPjx3UB/lu12vdxN
         v6UA==
X-Forwarded-Encrypted: i=1; AKwUvBz4GK5Ws7rF6i/Ite+f816EPjxPdDFtPwpJ+I0vYyAHOd4mGXmWaqTFBw5dVY0U0Uygj2w=@vger.kernel.org
X-Gm-Message-State: AFq9FYLrHCwcTNFtJnJP2DIXnTanWQM7Fa4Mntl4HIWxmN76GZ9aou8u
	21PSC1kDFTFWbi2LPRX+udU2alg7R55i4Wem6Ykq9KygCp7JsfUiXjavESjRwusdf0K1qRGqZNR
	O9/djAoQV2QpkBRPYvr4xWiNsoFKlN4g=
X-Gm-Gg: AYBFou2gno8wemJaMvgIeaV9L7jfxn5XIAquQmL2H/k1rnfT/D/XuK5xK72gyjItpEE
	m0DGuT/yXKPzLG7dQgRONkZCUKLKyDUFw+s5cKOeGyPEwboudbAD3OQtIKTCo4bFSgeD/DhmNdT
	pC6TqVGuoJOSso+Mmpi70vKxXiG7/ysPIV8POKBCtm3vr97aoX2h+LBLXhGYKkSeWjV7kjj0A09
	UyLayt2jQYFx6QrAir/m2R+cVYFoRPk6+O6LwVRYNCe2sQl96o8Ib49/+cWstJZj3AKhKRr2XJK
	G2xi60cAZbYZkViF1RmxU/P3YUBLKjQIlMJU62pRacUldTVR+wPP6+M=
X-Received: by 2002:a05:6402:2350:b0:6ac:765e:def6 with SMTP id
 4fb4d7f45d1cf-6ac765ee1edmr5874936a12.2.1790706902114; Tue, 29 Sep 2026
 11:35:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2425.git.git.1790667030497.gitgitgadget@gmail.com>
 <CALnO6CBwWy3aafyDJPKFk5vuWy2EF1n1Oc=W7+RVAE3rxpXwiw@mail.gmail.com>
 <CAHwyqnXLAQgTen2nu6xX63ch7Z9V8kZ-c3zbZgw_xwEVYaz=oA@mail.gmail.com> <CALnO6CC4fS0LWe6ta7B-C3dQXSjfYhab-e=EHdneRRqfa9mAZw@mail.gmail.com>
In-Reply-To: <CALnO6CC4fS0LWe6ta7B-C3dQXSjfYhab-e=EHdneRRqfa9mAZw@mail.gmail.com>
From: Harald Nordgren <haraldnordgren@gmail.com>
Date: Tue, 29 Sep 2026 20:34:23 +0200
X-Gm-Features: AclHuK8mRXO1SYbPHl2fJUHll8KNHNqWtUQjHKMOey3D_IEDNoLHGb0LGiwY4WI
Message-ID: <CAHwyqnXA6kxktxNRPCbq0hTdH+G+3jSkCq5ghkS6QkJEgA1wkw@mail.gmail.com>
Subject: Re: [PATCH] branch: let --delete-merged find squash merged branches
To: "D. Ben Knoble" <ben.knoble@gmail.com>
Cc: Harald Nordgren via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

> > We might hide it behind a feature flag?
>
> I could imagine wanting a CSV-style value for the option, like
> "--delete-merged=3Dsquashed,rebased" vs. "--delete-merged=3Dmerged"
> (current default), or something. But I'd have to think about whether
> I'm suggesting that only to work around performance or to also support
> actual use cases. Mostly I think people just want to go "gah, delete
> merged branches" and not think about it further=E2=80=A6 hm.

For me, the only reason to hide this would be for performance.

Yes, I think most people (me included) would rather have the simplest
possible command. I'd rather not have to specify the pattern so that
these are to the same:

    git branch --delete-merged
    git branch --delete-merged '*/*'


Harald
