Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A304C468C22
	for <git@vger.kernel.org>; Thu, 13 Aug 2026 11:13:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786619584; cv=none; b=Ivn+TJrmS4tZ94gKpLGRDVlduu6Te8IPjigH3krf3au0+qTiztI/sReHAA8HsoLU4RgyG/RNteLJp7LmrUC5M4euUiCf9ClzSEXv6TsDFaCVi66YN2NbIyogVVXOepxq7j9OTm7FlC6haXoYTpRtjVwk1iIM4CXMqsfUcu+lAJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786619584; c=relaxed/simple;
	bh=Wccf/wER/OiZ2gdZBtNXD9RmB65tkuDwxp5g+1yZzkU=;
	h=Content-Type:From:Mime-Version:Subject:Date:Message-Id:References:
	 Cc:In-Reply-To:To; b=l9wPuyLfQ/gcAabqFkv5bgOIv0o7ojGeZjxbx1JkXxqLF/XGygpJJByLiTE4q95toiDz+TqT2W7AAUj5nKgmg8yuFVjecvoKpjCUhGnqEto35hhsprvw2QvWRy7nP/MHBRH7cN06FMpCOAEpgRtYV5kEjg5mgV4EDmGeFNqxV/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l8LoN15T; arc=none smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l8LoN15T"
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-7ff05e5d009so21685107b3.1
        for <git@vger.kernel.org>; Thu, 13 Aug 2026 04:13:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786619580; x=1787224380; darn=vger.kernel.org;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:content-type:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=4igMOec4izcYerP8pss9YXUrXLZfffPkfAGF78OoCIs=;
        b=l8LoN15TQI5ChNkaMyqbCInWuo5WKabEGdXcBPF0HQFvY2RwGNQZaLPX6w4jTbEvE6
         mQRdYvu2SG98bST1jdqoAJZed79JUtEcyzSBhfXJJFxRF6qe5MmOeBEnzyzcvoFpnHPV
         QjP2CsQw/jQMX8Es5glaYdJBYh57VGo84PdllP5qUTR4jJ//7Ry/vgVgvbryVFupHLBf
         PnBJe4pVNKW6YEOYy001QbrVqfXyTeo3UYqymnRHmgP12/mo+XrPj8fAcoTjyCjRsqvL
         rThELcfvcjeIilOk1rkWcXayqnEiaXKFQEQWKdyV+1XxOeqsc6RJQW94c6zDlsBobdS+
         4dyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786619580; x=1787224380;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=4igMOec4izcYerP8pss9YXUrXLZfffPkfAGF78OoCIs=;
        b=MJ0nNj20zSO8VR8NQheOpiysZH18u0WO5ZBRPAV+IMft+wXc0F+ruvWojz2qZLDaRC
         jDN4rrky+bsQfOSewdDl8vjYA7Jd7ks/cd0cbbTNug2ckOu2jTza9yyNLCx+Zr+XeG9R
         IqzIiwishyK+ocxxST1ngGIiqyDRK0zDwhDTOfHX3Q9hBOPRy3dJivZ0hR5DYLKOKKvj
         UJciNmzaf6i8mbH88nmWPvrIS1fVuGhSH79JxMFb5rgsec9sd0p+oATvccyLWDQ8InRp
         wgDFo3AvYl+bsQoT7YSuFDZx5DmFUkC3TajBeD935oht5YJ2A/75rdAWLKlZaEiNBYDN
         E5kw==
X-Gm-Message-State: AOJu0YxytenR1p9NpLkD799w4lLp/ZT4EwSox4QCT26PBP0xAauZ0GK/
	C4RBG2NcyBa4RnsSa02qnynnf/vH65bY1DFbm+czwAcODm5ERKh3i3xbNAsSwAWaJfs=
X-Gm-Gg: AR+sD12U0OmWgAmFjeKMOHGW99BQXiUQhTXkOSHZ1YnIQ1RtOzn75TbWsX96UiYaRcY
	wA9cWAFqwfcDid6F+wHJsr4ruNYo1RSJlDIXpuG4zhcOi/pVFCoaI7w78Py1CEfO3M7ZEt5d65Y
	ULR9A9qBvDcvPSXB78Epee9vuPvdfptaK5e4g3cUhbrz1FfoeJWTprLPeF9iDfW0/AX+9JsrchS
	GJ4n3CcuxYWp0paFvwdwHR+pnAMAMkKRJSvBWnnw2XddA8o2jgCdcI85f8a/cGFShBojiPLVPo2
	uJ199yyHHC0ADyZmq/cYdaGm+pTl0BmbY/FEmJrZniGkfOfqfmPysF3L87NLoujQx3C1rOUKEBW
	mzrZxbCl8CJ+Jh91Gu0CPeqebPYDub8elnQuOvaWGPKirklNYJTEEnXGqTtfvn2WKxYokGr7Nb4
	RwwKzfhNdiV8vkTBfxoVUAz/InuyNGjRRDkoUBAUp2fTgGYYAhLOJvrMEjn7+SjoCLaFBm2fMoj
	nwmj6KgncjulR6bdFTkxRK+zm9ZlybOQfMhukdSnmY+z4zdQcBu1CokfOQSV6yzJCo+CIQ6NQrb
	UVPx3216b/qrwMaWfPy2KfiLSBlIwlC+QLwFBs0DdNeW5YAE
X-Received: by 2002:a05:690c:e197:10b0:7ff:1399:9317 with SMTP id 00721157ae682-83471a170a4mr20110047b3.11.1786619579762;
        Thu, 13 Aug 2026 04:12:59 -0700 (PDT)
Received: from smtpclient.apple ([2605:a601:9092:700:40d:fe73:73b0:d337])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-83465b0806dsm8927067b3.8.2026.08.13.04.12.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Aug 2026 04:12:59 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From: Ben Knoble <ben.knoble@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH v2 2/4] completion: complete 'git history --empty' values
Date: Thu, 13 Aug 2026 07:12:48 -0400
Message-Id: <00E5CBDB-7D2A-4117-9A52-FD5C64A9838C@gmail.com>
References: <CAMZ6RqLAYMSwNK=w=Xh+O==46eQCS=wFgBoUEOtQoBbLrBqd_A@mail.gmail.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
 Philippe Blain <levraiphilippeblain@gmail.com>,
 Patrick Steinhardt <ps@pks.im>
In-Reply-To: <CAMZ6RqLAYMSwNK=w=Xh+O==46eQCS=wFgBoUEOtQoBbLrBqd_A@mail.gmail.com>
To: Vincent Mailhol <mailhol@kernel.org>
X-Mailer: iPhone Mail (23D8133)


> Le 13 ao=C3=BBt 2026 =C3=A0 04:20, Vincent Mailhol <mailhol@kernel.org> a =C3=
=A9crit :
>=20
> =EF=BB=BFOn Mon. 10 Aug. 2026 at 14:50, D. Ben Knoble <ben.knoble@gmail.co=
m> wrote:
>> One other thing, sorry
>>=20
>>> On Thu, Aug 6, 2026 at 4:36=E2=80=AFPM Vincent Mailhol <mailhol@kernel.o=
rg> wrote:
>>>=20
>>> diff --git a/contrib/completion/git-completion.bash b/contrib/completion=
/git-completion.bash
>>> index 7372e2919b..fe5223b8ec 100644
>>> --- a/contrib/completion/git-completion.bash
>>> +++ b/contrib/completion/git-completion.bash
>>> @@ -2171,8 +2171,17 @@ _git_history ()
>>>        fi
>>>=20
>>>        if ! __git_has_doubledash; then
>>> -               case "$cur" in
>>> -               --*)
>>> +               case "$prev,$cur" in
>>> +               --empty,*|*,--empty=3D*)
>>> +                       case "$subcommand" in
>>> +                       drop|fixup)
>>=20
>> This feels a bit "inside out" to me, especially when reading the other
>> completions. I think the usual pattern is to check the subcommand
>> first and dispatch if necessary. Thoughts?
>=20
> The motivation is to have a single:
>=20
>  case "$cur" in
>=20
> statement.

I now suspect this is why some use the =C2=AB case "$subcommand,$cur" =C2=BB=
 variant ? Apologies for not thinking of that previously.=20=
