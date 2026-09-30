Received: from mail-vs2-f12.google.com (mail-vs2-f12.google.com [74.125.227.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE5204CDDC5
	for <git@vger.kernel.org>; Wed, 30 Sep 2026 12:00:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.227.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790769655; cv=pass; b=LfOyZ6bnLRu49lhfF3yqTokgRsAZy+0u9HvSM/GYIXBhIvDvVqDnGTzQUCdESLqSDJk0TgSue4Ecs69Mhf6tKOvrRRX1A9L02EXWxkxO+k010YN/h7gVcrzGuNioZV3BWfR2XGmhGWf46OhdnA84IGIWPLx4CEKPHmcnP9IceoE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790769655; c=relaxed/simple;
	bh=VFzQwJcAM5oLu/6UAa64Gg8DvEQIp4QUNVJCDaUYRYo=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bnKY80pugMCng+2GEmTWi7c4jUc3ayMELjAno4aE+YfK6M57Ew9C3u0uYXjtl1I2rohX7/kMYuHybOtIM2OELcL4V1mhoXstuZ1PXEEe6jA39tTGOkmd6szGREJ47tZZ8CaCXTXCTwcp182t4THqtcR8YAu+6fmGarITtfPBtaM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NYNV+wDV; arc=pass smtp.client-ip=74.125.227.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NYNV+wDV"
Received: by mail-vs2-f12.google.com with SMTP id 71dfb90a1353d-5c67e5059f8so1660711e0c.1
        for <git@vger.kernel.org>; Wed, 30 Sep 2026 05:00:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790769651; cv=none;
        d=google.com; s=arc-20260327;
        b=L/SDHr0j6iTTLC9HSb3S1LB4fr6bybxRaxUbKOtQ/sEUzuvEKznr+NF9K9Cg8q2hWt
         ZZ41If7abr8U3Zg9eWLdPeRWV6bOvzefIpnDGcT7TcF9V6WH5POjJM3y4brRh7pMnHVG
         /mHEQds4SU8MdhquHoxCsqP1Zn4yhRotRfe6PVowJOhk3dHNbpCGjKFYE4G0413EmVgH
         z28pLWo7MFTHXtu3WX34Bw5GQktfSmNbJZqEso8dRfa9mIlBJeV0knD/9lMNce0j9b1D
         1ZUENTlH6GvDPRBDuQVfuR02msrr0v+P0drCmPkc0z6s14vL6jVFVvFCGorYwADn5fZ+
         OcAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=EUpbiHeCr3zgz/pwcBKykreEzDFQ2Tif9PwS1vSQwVI=;
        fh=BX5MrFx7i87Lq0pvJX37c/Z0HlXFPvk5is/hQPy3jw8=;
        b=BHp4huVWRB83BpwnTMzyn8t2jOzHDPns+n3Sjfx0rN+xl4QicFb2d/6A2Y7tEAiwO6
         wlFlzBbTL+gq7BjSQ2TYLN9Ei/FR3Vr01EvBdBFH1xRrwraaX13QMobapz2S376HA8nS
         Mlc4uGk/nrsPXptRLlqoTAh43W0Q1PQj1eV/ZVKrBssxTnOK7sxq6leny+2k3XsGBPPD
         RbWLgUxeYQnrL5JDa/CpxbOrBybkkb/ZjcjlD5MWZJAPNIdttB+d/y2jAbGd8XE4fB9B
         tbUdKgzTYhKz6TQwk6RG1manpYk1Foa24q7zqeX8ZiLLCv8QzLf3DmndEocW0mu5lI5b
         QpaA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790769651; x=1791374451; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=EUpbiHeCr3zgz/pwcBKykreEzDFQ2Tif9PwS1vSQwVI=;
        b=NYNV+wDVUCEEoSZ3WVy1uvPhzSkX7eN9twjEZKZzgxEuLqyGmBy9USrgdQmDI/Olow
         RdH+D+koBjwidFbJ0M7RXo5bERWrpX/Pc3GWqhFFDsP3VUtIeWM6vFqMoB1nqpzDcZcx
         /UAN9/U4LBAnPTmmDclccer4Gjs28Dh7Md8hDa6yndg8S8ZnBFfoSh3eGjxkrym2UwZf
         njj/g7e42D8BpG47anO+CSXCt7ABoC33hQkrUsfVnzen86vWTCbkmdtOiSHNOcJfsg1b
         E/ZwU0IkcZepSZ7VDV/JzNnB/ufqGYaEn0LEG2mn6ibQJXQMpVFUwHg4o6AyG6QJ88fp
         WeWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790769651; x=1791374451;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=EUpbiHeCr3zgz/pwcBKykreEzDFQ2Tif9PwS1vSQwVI=;
        b=C7Qq2DtfoGy9NveTllMUduYAlu+UwT3xjQS9TJHOmcIZXFh3yLNfqZKiXgDFwTJ9ZO
         5yfdPodClz1CRvGTmtA6XtKpFhdIMi8HxEgSMYEIOdz148rjBfSmJR9pjbYnL4h7Kn8P
         2CujjdfIOma6lqoMXNAcDD/sgWjx5J3+qABlzFvmRcICi/Mr0DnaHc43eQ7JGSj6eJOr
         K8uzWp2HZd6qrdMOAkjLFY1gHeV5PXPXDlfcaDdiQHc9pNTPobFjAliIAK2mCqmulYPd
         uTFWE7HN4jnJeHPpZHK1twwAdnROyyvP2QXjNr6UiyDI+3psGP4u6/B+nKzKzr2l1Ys6
         4vPA==
X-Forwarded-Encrypted: i=1; AKwUvByAUd6wDBApHrr39TJLKABskbAenwX+zgUg1n1DNGaCP8fJi6CYP4P/4oUmsNfHeX23wnM=@vger.kernel.org
X-Gm-Message-State: AFq9FYLZkOjqG/zOXZ+827DFgZR9fCsBOpVpMALNFLbSyaTginHi7Hkb
	SIOEc5yKW+T24o4ZeKRAQUOqyFmCe4+4sAj6WIp0YviMY0TNAulDpuvE2eIwyAIAZP4P81vTekr
	WcDDz0rI6gtfjJ0uXxqw/NqElz+ZHkRk=
X-Gm-Gg: AYBFou3wxcUJUU4qAuTprB1/yp+SZBKg0dSGHQ/KYub8UB04POsws8WgFepU6NgUVxb
	YTZxP6n9Hr6wCZ0Z9foLjzKh/vNjCMHN6mNsdd5wHqqLWilN0J+Flu3HpjRtgsSZHVwCziY/UvJ
	SNSIkvJll6sQaZoY1RtI5X6bfNfj57zyQTZt1hqCJyNcUSD0pJvoGRIIBCIDN10BbxKAOQeR1rT
	0xxcKPXQKuLV2lao/cIVwx9uYeQEMMuhy4xCl60xmzRkdH4vqXnCXVV6iOBDJAE53A9JJWGpAF4
	gBzMWJrHN5ES7Ri6grwzqDYlQ2A9oBbYXa7q3tOQW5CVxRWKh5K+B+9+fuGrua7r6/9wAcOlNAm
	1vqjIQEQfO71OSao2lKIEJx8KL7S7f/JCwzBBT4DGztQ3XQ==
X-Received: by 2002:a05:6102:8097:b0:79c:99ea:2c9a with SMTP id
 ada2fe7eead31-7be72ab7b3emr193464137.11.1790769650907; Wed, 30 Sep 2026
 05:00:50 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 30 Sep 2026 05:00:48 -0700
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 30 Sep 2026 05:00:48 -0700
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <20260924-pks-meson-improvements-v1-1-90b7f79f1c4e@pks.im>
References: <20260924-pks-meson-improvements-v1-0-90b7f79f1c4e@pks.im> <20260924-pks-meson-improvements-v1-1-90b7f79f1c4e@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 30 Sep 2026 05:00:48 -0700
X-Gm-Features: AclHuK8EL3mCmXsfD1q6gI169rfnxZ85utrJiN5Mv4YXIme95YPXI9kynvmXIUw
Message-ID: <CAOLa=ZQ0qVCS2Bi3QrDokBRfgtTFH9bqudYiFozHtmEzKgRVeA@mail.gmail.com>
Subject: Re: [PATCH 1/7] meson: avoid recompiling HTTP sources several times
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Type: multipart/mixed; boundary="000000000000eae18a065cb20ce9"

--000000000000eae18a065cb20ce9
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Patrick Steinhardt <ps@pks.im> writes:

> We only link curl into a subset of our subcommands. Consequently, as
> both "http.c" and "http-walker.c" depend on curl, we don't compile these
> into "libgit.a" but instead only link those into the commands that
> depend on curl.
>
> In Meson, we wire these dependencies into the target executables by
> using the `sources:` keyword. But this has the consequence that we're
> recompiling those multiple several times, once for every different
> command they are linked into. In fact, each of these sources is compiled
> seven times, which of course has an impact on compilation speed.
>
> Fix this issue by instead linking these into a static library so that
> they only need to be compiled once. This gives us an almost 10% speedup
> in a clean build:
>
>   Benchmark 1: meson compile (version =3D HEAD~)
>     Time (mean =C2=B1 =CF=83):      6.781 s =C2=B1  0.052 s    [User: 100=
.775 s, System: 22.954 s]
>     Range (min =E2=80=A6 max):    6.709 s =E2=80=A6  6.867 s    10 runs
>
>   Benchmark 2: meson compile (version =3D HEAD)
>     Time (mean =C2=B1 =CF=83):      6.274 s =C2=B1  0.021 s    [User: 91.=
882 s, System: 22.092 s]
>     Range (min =E2=80=A6 max):    6.242 s =E2=80=A6  6.306 s    10 runs
>
>   Summary
>     meson compile (version =3D HEAD) ran
>       1.08 =C2=B1 0.01 times faster than meson compile (version =3D HEAD~=
)
>
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  meson.build | 11 +++++++----
>  1 file changed, 7 insertions(+), 4 deletions(-)
>
> diff --git a/meson.build b/meson.build
> index 0a95d90d21..4fdb4c5405 100644
> --- a/meson.build
> +++ b/meson.build
> @@ -1925,10 +1925,13 @@ bin_wrappers +=3D executable('scalar',
>
>  if curl.found()
>    libgit_curl =3D declare_dependency(
> -    sources: [
> -      'http.c',
> -      'http-walker.c',
> -    ],
> +    link_with: static_library('git-curl',
> +      sources: [
> +        'http.c',
> +        'http-walker.c',
> +      ],
> +      dependencies: [libgit_commonmain, curl],
> +    ),

So there are 7 locations which mark `libgit_curl` as a dependency,
earlier this would have recompiled the two sources here each time for
each of the 7 locations.

Now we build a static library and declare the dependency to be linked
with the static library. Looks good.

>      dependencies: [libgit_commonmain, curl],
>    )
>
>
> --
> 2.56.0.rc2.329.gd58861e689.dirty

--000000000000eae18a065cb20ce9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 7c4f7b4638c6b9a1_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1xOCtlOFdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mMzhmQy85NjRYM1pPT0krSThqQ0hhUERLMStQSDY2UQp5amo0SkJ0TmYw
YWpKeUV2V0I2OW85TmVVWWV1cGRaVHJWSTV0TnkrYXVwTFo1YWNqRHdUc1Q4MEl6dTZZMUh6CnRk
c1JuOFJWTndCTndLc20rRkdrczFGbW9NK015K05DZUxtQVdaSHlLRFE5VW92dmtxL2sxcEloTmI2
cVE3eisKQmd5MkZHRHBja2xrVWZMeWhjWWpmVmF5dDNiM1NIVmVubkE4TlV6cFBCVFRETHFxRE5X
K2FST1lHcXFnV1kzVApSS1FWZmhPVmVWcm14ZHpZTkJPNU1GSkl6S21uSnQyYXd3a1JBS3pKVm5R
VnV6UHZJZG9QUVJDc0sxT1M5bk9qCk9qQlBEeEFGQjV6YVU1S25tMlROVWhuNlpIdzA5SzM5M1Rz
QnkyS3ZYZFZMS2l1L0tZN1VWUnhIV3hmcms3Z2sKazJUb3QycUp0bkpGdElvM1Jncm9adGlnM2la
LzhBSCs2SEozMlpMNEJNcDAvWDlNaVU1K2JJZGsxTkZpOWpyNQpla2VCZU9EOUp5a25JRmROYjNW
cE8ySldmMzN6WnU1ZFBDYW40ayt2QUxmUld3NTNkbWlTNy9pOHlzdEZ1L090ClREMlhCd1ZsVWZh
TFUvM25FdnZjcVJGVGZYeEtlMUNQM2cvbTRIYz0KPThPN00KLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000eae18a065cb20ce9--
