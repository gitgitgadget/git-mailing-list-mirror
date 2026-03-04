Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D5D6373C16
	for <git@vger.kernel.org>; Wed,  4 Mar 2026 09:50:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772617801; cv=none; b=sKMFv2L/7O7zGPIT4vz0nsh5wxcn4aLu0d98UmI091d+hDO9u2s+q1Y1lRhZEfhZW8o7MlgerAVirUhN2K7I1zgSCrjh6z4Up+MN1Tf7iXhS9NtyC+Fml3iIXbIy7Rf01xo0iVsPK4M1CPvaAOa8u4AOxyZzDOtV/zyFeUb4Hv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772617801; c=relaxed/simple;
	bh=EFCmE6LL71dyRTLh1/C1LyaL8KRT4tk5qg0Anr1WoDI=;
	h=Content-Type:From:Mime-Version:Subject:Date:Message-Id:References:
	 Cc:In-Reply-To:To; b=rChFn8jRQccAhN6wnXZOavkSBk3WTHYY0YKdFQNDzPrY7fsfqx52MmVcP9WC00kyE/GxhS9eyvf+LSvrQHxRg7uSx8SM/Z4TfQZPvjOJAMddDj7g5yUZVBwwDwROgyzdtSZ0GkvnvvCBodvMhvPs8uptPrVIUXkx1w8NANAwpS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H6of2L/5; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H6of2L/5"
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-797ab169454so65383057b3.3
        for <git@vger.kernel.org>; Wed, 04 Mar 2026 01:50:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772617799; x=1773222599; darn=vger.kernel.org;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fAtyVv3fFzwZVxsynh/38FI/gugP0ZorxiloyNtQZpk=;
        b=H6of2L/58PvRJjMdlOZmSgBkgT4yfYhFDLKoZlr1fYSaS3FQfZusWDFuHebc0bUWae
         qKU4B5T+NXvjwIrxkrWgHV4e2mSiPJErhjgbNjR+u1KGljXAkLontCK4/ApRH9QU6imP
         4A0AfxmFjyj4eFYq3dpzmWHmxxMfDCH/D6x4nNRDLPbAXfADjLyhGm5Dghfh5ofF4ySt
         CHfCPtyynwf6xiEIhMS5jihcuRzvcuOLFV4F5Z5aJX23S6pjyYspXNnSLxZ5wNx7et0+
         MU90muhl1SiOGwhwOOOwejZW8gQg4jFup2xs6uEyvXZGzn9mZpfXBYnrl4W2HLxyiGaV
         oIfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772617799; x=1773222599;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=fAtyVv3fFzwZVxsynh/38FI/gugP0ZorxiloyNtQZpk=;
        b=TF2fTiQxgM94aUT030/PSD6AZU/P5928FZW1sHnPiid0havBnjl+Ai/0G3j2YmHxDI
         wmfVvalNiC3F+h1dn9auejPpfbEoy5sC2/jEz5c4hvH5FJlW+LeNQVmtgylMiTSCwBLu
         DyHuqX+m0JaKowDkkaiUGfPdvaNvseRRFQcJpPsHRm9/zNTlchYB1JhhdqmwBF+4V2JR
         2zNoxzw1tkY/JrM/M2slc/uQSQAWtwxgMR1ZS2bmwlZgv4UZa9hG6qtUlb3c7Hkx+qxK
         4RRIppiEtUkS1e5XYS1VJpRjt3sWmu5tuwN6z1N/H0EkT5rpiJOfxTxxhWRxsd6Ym2nC
         KB1A==
X-Forwarded-Encrypted: i=1; AJvYcCUwjSdUhjjdc7FBZ+O79vlGJzu0xID+sIsTwQ/XFMj4oy8W1xBA9qWdJS4xTCz0WxicuJQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyokbypiA8NllqHoSrGxy+71w5YKQO24tZkeBjKG+LqDWyooktU
	W0MkHxjZ/zpKg6vZORCXXDIReNFcAiYFGkTgRXiRVl/NL2hl135Wwnykc/ufVQ==
X-Gm-Gg: ATEYQzxgBQs5r8TymK/HqUvM5wOd+B/IfW01Eg9M8zPX7iL5YmsojCeCAvbMvgoB1/l
	09u73ZHSAYk7GNBZPihHQUQRCskzYdNLT7DUqjjPZLpAdm7uyQv0e+VrfH3fWy7mkT2floOPxw3
	y7OO6l9howLE9yoIUjxw/IS9csletLn3GzSTTRH3CZr0y7CfDom6U7oRbD+x80nSl6XOFarQ2gH
	9NLls3Ft2+3qTOhGHWBe7X0OTyL9U89zXURO9WZ8Kwui6I1Q3DCEeeqHjkfpr5mKXOorD5XKjzs
	PxKwnj1ThsaKbRfdOh0IRTfyhiOYDUm647sMLxTUXDnfoM68kuOI4W2O4YlAdGrftN7Ihmhi6Yj
	0+qwpXO9MJFlCfC2goCpm96l3C4U6lZh8Jqou1wSv/4p243kOsn8NEpB1Z1fpaHMk2M8Zt4ByR0
	xeNegqTSXncMgNvRMPn0u/OMOyhPjYEfMAJJLrX+fTgqZvNEj22e2LG5cFKlF0u9sgIT3znz2GY
	GtmJBdPbxrrj4NG3HaLoRzsYG/YDb2TDmQ8jHlBmKm6Cw==
X-Received: by 2002:a81:a607:0:b0:798:6542:30f6 with SMTP id 00721157ae682-798c6ca5609mr8616017b3.37.1772617799311;
        Wed, 04 Mar 2026 01:49:59 -0800 (PST)
Received: from smtpclient.apple ([2605:a601:90eb:5600:9d3d:68c9:abaa:c459])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-79876bf8103sm73907207b3.27.2026.03.04.01.49.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Mar 2026 01:49:58 -0800 (PST)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From: Ben Knoble <ben.knoble@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH v3] add: support pre-add hook
Date: Wed, 4 Mar 2026 04:49:47 -0500
Message-Id: <33EBA399-2D24-48C7-AA1B-EBADF5E520D4@gmail.com>
References: <xmqqy0k8a4xo.fsf@gitster.g>
Cc: Chandra Kethi-Reddy via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org, Chandra Kethi-Reddy <chandrakr@pm.me>
In-Reply-To: <xmqqy0k8a4xo.fsf@gitster.g>
To: Junio C Hamano <gitster@pobox.com>
X-Mailer: iPhone Mail (21F90)


> Le 3 mars 2026 =C3=A0 18:06, Junio C Hamano <gitster@pobox.com> a =C3=A9cr=
it :
>=20
> =EF=BB=BF"Chandra Kethi-Reddy via GitGitGadget" <gitgitgadget@gmail.com>
> writes:
>=20
>> "git add" has no hook that lets users inspect what is about to be
>> staged. Users who want to reject certain paths or content must
>> wrap the command in a shell alias or wait for pre-commit, which
>> fires too late to prevent staging.
>=20
> I do not think the above would convince readers that "preventing to
> add" is a worthy goal in the first place.  If you "git add foo" by
> mistake and wish you had this hook to prevent 'foo' from getting
> added ever, you can easily "git reset foo" to undo it.

It=E2=80=99s also not clear to me how the proposed hook could inspect =E2=80=
=9Cgit add A B=E2=80=9D and reject A but permit B, but maybe that=E2=80=99s a=
 non-goals.=20

>> diff --git a/Documentation/githooks.adoc b/Documentation/githooks.adoc
>> index 056553788d..657e14d306 100644
>> --- a/Documentation/githooks.adoc
>> +++ b/Documentation/githooks.adoc
>> @@ -94,6 +94,36 @@ and is invoked after the patch is applied and a commit=
 is made.
>> This hook is meant primarily for notification, and cannot affect
>> the outcome of `git am`.
>>=20
>> +pre-add
>> +~~~~~~~
>> +
>> +This hook is invoked by linkgit:git-add[1], and can be bypassed with the=

>> +`--no-verify` option. It is not invoked for `--interactive`, `--patch`,
>> +`--edit`, or `--dry-run`.
>> +
>> +It takes two parameters: the path to the index file for this invocation
>=20
> Elsewhere you called these two files "arguments" but here you say
> "parameters".  Let's be consistent.
>=20
>> +of `git add`, and the path to the lockfile containing the proposed
>> +index after staging. It does not read from standard input. If no index
>> +exists yet, the first parameter names a path that does not exist and
>> +should be treated as an empty index.

Saying =E2=80=9Cit [the hook] does not read from standard in=E2=80=9D feels p=
roscriptive rather than descriptive. Why couldn=E2=80=99t I write a short sc=
ript that asked for confirmation of the paths being added via stdin?

Or perhaps we mean that Git does not write anything to the hook=E2=80=99s st=
din=E2=80=A6 at which point I wonder if Junio=E2=80=99s =E2=80=9Clet=E2=80=99=
s not mention that we don=E2=80=99t do this unusual thing=E2=80=9D applies? I=
 haven=E2=80=99t looked at how the rest of our documentation describes hooks=
 that aren=E2=80=99t fed input via stdin.=20=
