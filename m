Received: from mail-ua2-f42.google.com (mail-ua2-f42.google.com [74.125.226.234])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3376B3BB100
	for <git@vger.kernel.org>; Wed, 30 Sep 2026 12:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.226.234
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790770805; cv=pass; b=jwSTjvjglDhqzSUkw2AiQ5lTjcycU5HlwMjIewhiQTUnBvmTq8PgcQd+9yxg2QYOkCOqiH7yGiLFT2G1ylwDCpfEdq4dqya80ehNvbU1c2UskgMA9yS3HyBAp0MLpmHRw4Tjh3r8K/GTOkUJoUSkLDBKt9HZqns0FKtmI0bAzVE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790770805; c=relaxed/simple;
	bh=pZ/4n4x8VZOkAp18seu0/Yi/7hy0BeC/Iy8TZK3GMao=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rKn/NmiYUcDaodR3KvE1coOdtbtCbHUwBoHVhKjwQSLCLEnd8jg+XyjKDA+Y333nlTLpp8ko7lz62O6OJXRunYJDp9uXjoVsxiXo7JNPxakrwfUP7B/yDDBo0ZKr8LH28eXP8iyJlmCKKUCBEPiIXQyO3en1NDRYL4QCDujaRUc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AlXVs0Qo; arc=pass smtp.client-ip=74.125.226.234
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AlXVs0Qo"
Received: by mail-ua2-f42.google.com with SMTP id a1e0cc1a2514c-988cdfb288fso432513241.1
        for <git@vger.kernel.org>; Wed, 30 Sep 2026 05:20:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790770803; cv=none;
        d=google.com; s=arc-20260327;
        b=Gzufd/UScKpWmngodG6YZeCcLGvcNj9Vxx6PEiG6VKBMnX1LSJp6d6OiTqQ6XGJetw
         JQVWwbvlXY6/QEufwIoN/FbFz6swjX4AID12+j541H0yiA7ir8JPR15T8BtGzIy1EnEI
         D42R1x3wdz1UnfL7YRhS6viigC2BkKAvCVXAuL2D+K36gxFgzqOe3hR8cDEnbPt89L24
         rNeY8bAXE8bsW7dlslrmYvcENAbA0fNgkEVCREG/51QHvHnXWqMKmcJvnuArPwVgjGCM
         0iMvPzgHoUwdgLUoURZTwUYgqm11V3SuJAxTjMWNilFZhsfvI05fY+oKk3aaQl/Ub017
         KIPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=rTH97pzpgh6OlEvtzvosVY1YvqXx/2OaSRX4+241m10=;
        fh=JRWpwaAbuY5dMYn8kCo+1eXy33udvkblGqDehzZFB8Q=;
        b=oBCyBSIvkwXSCqfYGiWukfqbghC7sdLMDpawq/YCAUbBsZLHJsSKgHhZMhK9E9nRDL
         r9Np7kaBlttWl0cFkTWiPsPFfRIWTYnt3XQPLQhZhaJllW+GV4iB2t4oLYBhqa+5d2r8
         l+yNPRowz3HJ9Yijxcuh2zUhr9bIVDcQrwApPrCTq3C61G2M6yqVt8yKP91rfDRHgBb5
         rQVQFbxKpUZo7Nc6xXo0W+bsngHjV5gY4vzFRuI6bz7mehR6GkQvwt+YZ2HC46szykyt
         1pvP9DZhgtlagzO+Jn405j3frKbFt4HUEyTzagTMvx6wcagSN1noj6KpDgnLLkmIKTSr
         bWSQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790770803; x=1791375603; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=rTH97pzpgh6OlEvtzvosVY1YvqXx/2OaSRX4+241m10=;
        b=AlXVs0Qo22sCAuOH93r53XXkoq/Hblh8ufjkoFDErvwR7b9MJoTqeqKyJzqCVanMft
         J8GMTIfNB2fhBsLNPfy6fNiJ5Vowbb4+bbg2B4Gfbk7WJGRZLChKYHmIJCeRTB51IFxN
         H5rkoNbHfI6GZzQxP86c2qFOC9647rmR9J5/oau1jVMPFMFJXvDeTNn4V0qp0VGExWlX
         Nk/bOq1NHEzphLpm+ku+VgYYT8hbpdzux+X04ICYMrs7iAqwP7r/dkp5R5rZRj1mTlhk
         zZZyzj8g3viT8YmXe/gs1imlyshWzl4FBK6QTSGIl/zBVYOOUjanTrwnz5dGA6xjQDH5
         VYtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790770803; x=1791375603;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=rTH97pzpgh6OlEvtzvosVY1YvqXx/2OaSRX4+241m10=;
        b=Cz/rTcPhhUJ4+06dnQcPZOirKdro4ZHW/o9eOXI5YnbZexloJKkU5uxWZHwwDic9nh
         U9KVL99ko57HhnIXaXizJ2HFVO8oMrwI3uLSld/QFeZbjGDBlk5wMYGloDKpPYSobnIS
         Z9pxeACrWyMnA5FlkheEhexNXFUb6aG0EP+SbPUpNL+ZyUafqVULzvPymMQqjHcwaDz9
         cTe7HoCWAPJdvJiYAi5Cj9hKqpCZmBRRmE3Mw7uQ2vccAeSl+tQh1hNLwt2g+QjYpN9h
         CFD5mBcNiNXTdwPBWYFEGxM4EK6hPy29Tq312QAHmVDACTTuYU8io6zLh6CqIvu7Pe5c
         2IEA==
X-Forwarded-Encrypted: i=1; AKwUvBz78OH+hNIo1Na9Rx90//SpoBhy7Y2PXAhUG0Nhh+NKhVRrZbJXGXAtvi4o9N5Dfnr/TLM=@vger.kernel.org
X-Gm-Message-State: AFq9FYJ2/w0c/Kpf3i7rLv4jq8Y3VAMjGtvHaskRPqrZ/DE+kHr8vu9H
	8DAoswj4Ox8fzEt2Osxt1qTeg9zf7escKsQ+9gV6N4Opbvf3E5BJTHkb4KxELfQFhisGYdD8Chb
	Sy7/OYAGmMc5mdku2eOuO/MsTkccQonA=
X-Gm-Gg: AYBFou2RLbg9h59ADVAq2uy3EIMQQTuvn6psUibm7DbsFv7+o3r2RSIiK1zrzYU7y4L
	ovZpXiHKTxhKzXscYN7VCsOY/Yx8JiI9HXWrSuRp9zSeY8cPuukHEV4xGzs7H+3XMyQEg5Rmhhe
	5lScgKDjlhlE8ej8Rx8kNhCfds6FEtXdWu4DP9zGGquIkIt9yWo6xW7W6dMcoEVnfbvA28+qlgS
	YglArsLwgHl2GZXikkh/Ma0YCYhnS6EDMqoL/oIzoLAOMJ2PMY8BfxVTuKxVf5GW5jyLwSFZDSL
	cSadsiC+i76ZX4ovlmPdpTPgjw9LPm4AAlJv6kdrjdv8N3ic9YPb6LA0VwiSd3CMKFRzJVRRTcL
	UidXrKw2OtkDEpGG0wJKkgY5ARSw4aRlpGlOkg68El4zHaZ6Uv1nOBj4X
X-Received: by 2002:a05:6102:5344:b0:7b2:7aac:8ccb with SMTP id
 ada2fe7eead31-7be7309d5c2mr179527137.17.1790770802948; Wed, 30 Sep 2026
 05:20:02 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 30 Sep 2026 05:20:00 -0700
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 30 Sep 2026 05:20:00 -0700
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <20260924-pks-meson-improvements-v1-3-90b7f79f1c4e@pks.im>
References: <20260924-pks-meson-improvements-v1-0-90b7f79f1c4e@pks.im> <20260924-pks-meson-improvements-v1-3-90b7f79f1c4e@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 30 Sep 2026 05:20:00 -0700
X-Gm-Features: AclHuK8GS7I6AmlvM7UWfYjmDDVwgam8xEYainSr1irh-FejeMMOHcWfWFF7USw
Message-ID: <CAOLa=ZRdeuYTv4f-1EEJmF+Dp76kDvz5+dWNkmnuMDjipDyV5w@mail.gmail.com>
Subject: Re: [PATCH 3/7] meson: use precompiled headers for our test-helper
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Type: multipart/mixed; boundary="00000000000095a436065cb251c9"

--00000000000095a436065cb251c9
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Patrick Steinhardt <ps@pks.im> writes:

> In 671df48df8 (meson: precompile "git-compat-util.h", 2026-03-19) we
> have introduced support for precompiled headers into Meson. At that time
> though we only converted "libgit.a" to make use of those.
>
> Nowadays though, our test-helper also consists of a bunch of code files,
> and all of these include "git-compat-util.h" via "test-tool.h" as the
> first header. So they're a natural target to also use precompiled
> headers.
>
> Adapt the test-tool executable to make use of them, which results in a
> surprisingly large speedup for clean builds:
>
>   Benchmark 1: meson compile (version =3D HEAD~)
>     Time (mean =C2=B1 =CF=83):      6.363 s =C2=B1  0.033 s    [User: 92.=
858 s, System: 22.500 s]
>     Range (min =E2=80=A6 max):    6.311 s =E2=80=A6  6.418 s    10 runs
>
>   Benchmark 2: meson compile (version =3D HEAD)
>     Time (mean =C2=B1 =CF=83):      5.327 s =C2=B1  0.021 s    [User: 75.=
135 s, System: 20.373 s]
>     Range (min =E2=80=A6 max):    5.299 s =E2=80=A6  5.362 s    10 runs
>
>   Summary
>     meson compile (version =3D HEAD) ran
>       1.19 =C2=B1 0.01 times faster than meson compile (version =3D HEAD~=
)
>
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  t/helper/meson.build | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/t/helper/meson.build b/t/helper/meson.build
> index 3235f10ab8..ae513b4cdc 100644
> --- a/t/helper/meson.build
> +++ b/t/helper/meson.build
> @@ -83,6 +83,7 @@ test_tool_sources =3D [
>
>  test_tool =3D executable('test-tool',
>    sources: test_tool_sources,
> +  c_pch: '../../tools/precompiled.h',
>    dependencies: [libgit_commonmain],
>  )
>  bin_wrappers +=3D test_tool
>

Seems like a straightforward win. Nice to see.

> --
> 2.56.0.rc2.329.gd58861e689.dirty

--00000000000095a436065cb251c9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: d0c8e82980601227_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1xOC9tOFdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mMmc3REFDR3BJSDJ0NjlkRGdNNzdaWHQ5TC9vdzVobgpIWnBkVHFhcmFt
T0FZOTNXeTk5Mkl5S2JMelpKb2RxQ3AzSm1iTUgra1dwc2ZaSFluSG9vM0xFb0RnMy9qQlIyCmpa
cEtQUlFkTVBNL0ZiMzVYYzJTcGZxTEkrQTlUWUs0WlMveUdnNkpTVEY0OUpnOWl0VHFGamtac1F5
bXJYMnMKNEVBb0RUMmY5c2RFc3ZZOUwvcVBVTG9nWGIvbUthN3ppd0ZTdWd6UFdBbWZoVm1nT0dp
Q1FTaCtmZUlxd3pNMgp4ODc5NFd1TWFnaGNYUUdQa2xLdmhQTDk4eDFkN3RSRDZFaVAzZzJrQ2dR
WWVHR1dCVFpNOWxTbjFZNlZnRTRWCm5xSU5rOG1pbGMrMFdxSDUwL0k5Ti9RK3NWRW9jUk5lZ2NW
TzZzK1BIWFl5UWZuVi9zMWViYy9KTEU3VEtBZ2MKbm45NU8xZVV4ZHNTY0lIQVFXcnhtbFRwL2N0
QklZWFcvT2hRUFBKRzZwcklWUVhlQjl1b09lY2h4VEptRVZmLwpGR0hxcFBaOEZ4SHV6b05MMmdT
blpQMUliR1ljUkVoUjRMUm9HbmhyaTlndjRteEpmMEg0bFhsem1OV2VVME80CitlcmRmaiszTFg4
REMvcTM0WTNHSTVldDljWDlDZ0FEa1YvMGxkdz0KPUJBSTgKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--00000000000095a436065cb251c9--
