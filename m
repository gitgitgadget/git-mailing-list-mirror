Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.182
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792721677;
	b=sqYNDFUhNQsy/J5GBFyEoMK3CizCSbsr8hK6wU7IGEv1RcC8eflY8PFk7QC7D2edf7SH
	 dX6g0cHrq67Pi4z7nCOMx88vQ66btsdMfEfXNBupjJMnaap6n7O3w469PSMPMstko1K2F
	 l1WmT5TQv/lOYXdVa/alyU1BX3wF/wPCgSCHckeNfOlsqU8CbUjWdysPw7X5XvmbIDVta
	 HGEfCvGliU3Sl8gBRAhlFrHQ8UeU1wPZLsScPt0zNcmeWqGncBC1Z4Wh5pXCRVkRcHv3o
	 xkNxalopGk5QdCfP7nT4KQyZu5yszsn7zlJvJ8tzmdSCLkCsN5wMGmCxXf0H1cqvfuA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792721677;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=ngmId72Z/h/tPoKiLHVKHHSwkakj6C96idUxzEVYeBY=;
	b=JtOUMqkVypzkcstkNenlIaZhvuE1uiYyhK1EeAh/oE29moIyEBdHyqsVt6Z4+O6d8vJT
	 xq+bqfDrRi2NGatHsfOEUey+mVtdi2iCp9jSNVK+iclzBlvAf2xwB0rNksy/uoBQz6R9J
	 orKTaf8sMLTpNBCliPdvfVM61vEBtoX/V/CesJiHVZ6sayZxXudyZ42+t9VFldE4ViKCe
	 U1cn9SBpCRwjYIPsyFEeC+n8RV9Sml4lxhoetlfGQA2B+BAS+g/XAj1H3eztf1aFWmbut
	 J4hUTrL9E0he3i36pf/RtDOxVyt05qL2vKsGRgQZcPw2se+XsMPiVn5jBLOXoFOrT2A==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=O0qDGLUB;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.182
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58179606A31B
	for <git@vger.kernel.org>; Fri, 23 Oct 2026 02:14:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 58179606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=O0qDGLUB
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-3a75f960be3so2574201fa.2
        for <git@vger.kernel.org>; Thu, 22 Oct 2026 19:14:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792721675; cv=none;
        d=google.com; s=arc-20260327;
        b=pPOIcW07kyXxIHq/XJ8ZgRDYtuO4V8+OcXXtE53qzXMIrCAgglXCmUSdn7FxuiuTPT
         DPM8E95yLKMl68opk9SRKKtWjeN+pSFnDOYaN9NvR/sO2CbkJmulwDDZHp9fIxBuSejr
         ElsqI0GCMeRSJsExs40QlzxpOIf0x9d9hvszRNfVdykh8Wu+huFdcfxfA9gW+/WbEJT0
         wFZSvSSo5mcn+DK4uwLpD8cZgSmphVGEhLxhmUipanvcPt010h0ljIq6Ho+s53dHx20u
         nZFcSGBopNtBrmCQaTLDWSm0Y+XR0Ij5r8weQAjO8mSS7OJXI6A80wbnK05GLmiOikSX
         1Zfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ngmId72Z/h/tPoKiLHVKHHSwkakj6C96idUxzEVYeBY=;
        fh=pNs4IBjBuO+kIV+regci3LQoc0ab22JoL1gF1c1CCgY=;
        b=kV6/Dff3Waj49DOfqp/visX0BI/fUOZeX/smRX53vOt29Ir/IGaupcOOBVgMylC5rm
         cdsvSVkzzT5njfJIaXRdyCLj6K0XNgiRb6WisODeLJpOhfDIc609HoLGj2M0zXnoaTZb
         TdJrvSDjLQNeoSRsu9so4ldPd3iUGWDeQsYlyt/OdlUhfV/YXm3txaQWwmMAEBz2x73I
         kSz0/YAqkL175aRhmHUjejrA4V+MhsW2MTBqIYAJwkL+tvXJenQkOkCpySgREELVL2Ej
         87o7gkgViLmZItSnc/y/ablmE2/Ebym6Dp56vQtO1WZqktJ9ETrwc8HfMTjkxvaLItiK
         9Qzw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792721675; x=1793326475; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ngmId72Z/h/tPoKiLHVKHHSwkakj6C96idUxzEVYeBY=;
        b=O0qDGLUBbYbptBTx7VRg9UIYw8VCgCBZTayu3gmYfKWxuReJK2smqzGC9vW2xaEWNU
         OlRXFyGWwKkqLPT16iKrBYD0uZwJb4mJgOuFdN03/Uh8jGlLffit09jUMRB3eJpYNerw
         z6DUVFhxmPlreyDP/YwE2pO6nhWT0/7k17LIy5SRekpDCaVonfMLwNzeIxhLDmG2qJhF
         b+XmMHhBToGqKzvnx/J4xzXm02ON5qZPD0KReU9VHLqn3KDDTZKL1fRrlJlgBHNk4q1H
         e0eE2MWYo5VPBWXr7t6floi7U0uWAtLmCelqWc2hK32SzhJf6jVVt0ARpxaSXWDOZCcQ
         ArQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792721675; x=1793326475;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ngmId72Z/h/tPoKiLHVKHHSwkakj6C96idUxzEVYeBY=;
        b=YV2i+Mox8+hJnKXtrsmbvJIUrUGHOg6tzxTmxp61csjY+F57GqNTFCxf7f2EpmKjg5
         Pz9FUcFYlMxEHVW+0Loz6eX3sXe63Gfapl2bqPt+gtzI0arP4AXIBU7TURRnQ8MQ5F3+
         LB01PGDqLrFr/bppZS4xCBGWlCVBzg3BPnsTaTem8aOQ/gEQihEAQlg7sRHlGQT4O47A
         xrtm9d2byGEmdm+Y4Eh0hlSvycZQMkRvtiDZARW6l06ly+Lj6P9t3l8a+oJ1RLayYghC
         nwTVtPLP5iiRVSp45Vho52fa55Y1r12/dQNLTsWwv2XOhR8552sr7Qs1C0u6dtILXVlI
         Pi3w==
X-Gm-Message-State: AFq9FYKrvLexF/K35JyAYEQXMPPyQncD2ojWkc0S1JoGRYPTyWw7ngS3
	4VfeOeWEq6ivJFP/z/uuYwJmQdd09hRZgWJpwLtyYpH0DdQuYWwD29gJ7KCmmbOISCo2di40eXz
	KmdV6eBQgAsp8XJ/657NKUnj5zOEMrJxb9L/C
X-Gm-Gg: AYBFou3VZGJQ7GJ7vCx+sDNtzkfWHY2o0UWTDx20Eg2sVh5CO5721kJKJaKAyvQpfDJ
	8n2H/T6I6XIUtcdLP+87w3xDgU2S0tpjPLV36i2IDnOTYBbmtXjj6qUEROyWqOjScNBZxIPd6I4
	wpxV5tEQhdRn3q4kTmclcrkkZyAFupgASwIk0bIwP6r3axSvjNB7TkXYX1FpdMpaLWGDkzULKDf
	FdYZ/52teOJPiCKceDwH08n1ycP6xQ10a1g/jpsyNCTFFN4F5XQRoaIi/yhC949s50p2qH4d+Tx
	jS0zRgwviVvxnlUSwtQHcBB2SI/QD2Gej2l3FSRE2EtBBFxTeDiv9uYLxm6MCVHEQHkBEIGoVQe
	y66RAy0p1+xL9/ktZpB7opS++aNBohytWyUm/NIIMMlBwBNT37H6SFWAxpDJ3hS7sfnqyRdg+/3
	Yi7CZi2Y3CDNsEspCTgdqMC+93oBy8C7Kh+9eMyFKJa4cOsK1x
X-Received: by 2002:a05:651c:1b95:b0:3a9:7f90:9506 with SMTP id
 38308e7fff4ca-3ac66390e04mr1338921fa.26.1792721675399; Thu, 22 Oct 2026
 19:14:35 -0700 (PDT)
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20260923-ls-files-untracked-cache-v1-0-08db4cc1efdb@gmail.com> <20260923-ls-files-untracked-cache-v2-0-d7ee33476eb8@gmail.com>
In-Reply-To: <20260923-ls-files-untracked-cache-v2-0-d7ee33476eb8@gmail.com>
From: Tamir Duberstein <tamird@gmail.com>
Date: Thu, 22 Oct 2026 22:13:58 -0400
X-Gm-Features: AclHuK-S_mFoS8yYaKkc5AesJn-JES6xmeNIkbh7ctcoP4bFbpBarF_rFyPfzrE
Message-ID: <CAJ-ks9nTce-gU0xEMAXR8e18u+18RdRH3r2JH4ZignO+YDjq4Q@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] ls-files: reuse and update the untracked cache
To: git@vger.kernel.org
Cc: Tao Klerks <tao@klerks.biz>, Junio C Hamano <gitster@pobox.com>, Elijah Newren <newren@gmail.com>, 
	Jeff King <peff@peff.net>, =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 23, 2026 at 6:27=E2=80=AFPM Tamir Duberstein <tamird@gmail.com>=
 wrote:
>
> Repeated queries such as
>
>   git ls-files --cached --others --exclude-standard -z -- "**/pyproject.t=
oml"
>
> walk the working tree even when status has populated an untracked cache.
> This series lets ls-files reuse those listings and save the work for late=
r
> commands through Git's existing optional index writes.
>
> The first patch fixes inconsistent ignore-file hashes that invalidate an
> unchanged cache. The second lets 'git status -unormal' and
> 'git status -uall' reuse the same cache. 'git status -unormal' still stop=
s
> scanning an untracked directory after finding an untracked file; a later
> command requesting all untracked files completes the listing as needed.
> The third lets ls-files use the cache and write pending untracked cache
> and fsmonitor updates back to the index. --no-optional-locks suppresses
> those writes.
>
> For wildcard pathspecs without a fixed prefix, apply the pathspec after
> reading complete directory listings. A first query can therefore scan
> directories that its pathspec would otherwise skip. Fixed-prefix,
> attribute and exclude pathspecs retain their existing traversal.
>
> A new dir_flags value makes older versions of Git rebuild the cache befor=
e
> using it to list untracked files. Changes invalidate cached entries in
> parent directories as well, so updates can reopen more directories than
> a cache populated with --untracked-files=3Dall before this series.
>
> On macOS, with 100,000 files in 5,000 leaf directories, half tracked.
> Each group of 100 leaf directories has 50 tracked and 50 untracked.
> Each binary populated its own cache using the indicated status mode.
>
> hyperfine --warmup 3 --runs 7 (mean =C2=B1 standard deviation, millisecon=
ds):
>
>   cache   fsmonitor  command          upstream        v1             v2
>   normal  off        query            241.3 =C2=B1 14.8    132.7 =C2=B1 2=
0.0   33.3 =C2=B1 2.4
>   normal  off        query + status   292.7 =C2=B1 11.2    187.0 =C2=B1 1=
0.8   92.6 =C2=B1 3.3
>   all     off        query            231.3 =C2=B1 14.6    29.3 =C2=B1 1.=
3     34.7 =C2=B1 2.0
>   normal  on         query            223.1 =C2=B1 17.8    111.0 =C2=B1 1=
3.4   33.8 =C2=B1 1.5
>   all     on         query            216.6 =C2=B1 12.0    28.0 =C2=B1 5.=
1     34.6 =C2=B1 0.8
>
> "query" is the ls-files command above; "status" is
> "git status -unormal --porcelain". These are repeated queries with warm
> filesystem and untracked caches.
>
> Assisted-by: LLM
> Signed-off-by: Tamir Duberstein <tamird@gmail.com>

Hi folks, gentle nudge on this series.

Thanks.
Tamir
