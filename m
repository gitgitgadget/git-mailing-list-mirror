Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795282176;
	b=nHQlEzPG21/L+KtcAtHXKiVZyEI164xUabmc7txT5oIrYsH+aOPZVkk9e6X/wdNb5ews
	 vRw5JpbqlLwWf3GMdMLFigCqt0byGrRkRoXo4J1vtWxNxB1sQU3hl2vP1efA001NQcQET
	 gwdomb7bXp2enMCx7S0+8rOnfBbBLFpfYC8vxsOh96RyHqeYTL77qp5bISQNKKtnxw0Bb
	 3bpGsPxZ8eX0t5Wy4GESgL6KkcuE1Bo2v4fBTfqg5igHnCL+nONAeYOXa6sV2g99FasWt
	 cQvIz2yQawaPmCxOOQzpcZ9w3r9UROQbEPkpvnn7r4AYcbbGJU+YUP+Ein2QGXyPgng==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795282176;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Content-Transfer-Encoding:Message-Id:References:To:X-Mailer;
	bh=uC2hx5H7HzaXs4Z9Vl4gIEvZGFMTpzSl2HOUdZw0rgU=;
	b=2qIribTUV/aBS+B64Cez8Q3TfL1Sb5+ylntblZwCWgXzalMvApBZpJOw+nIRmuiWqFT4
	 aznC2cqx9GaHz/1E3EMUm7Dri66X1FzsgSpnJ7rWbgP3iLu5qTMCFNiNc2epJhFLf5ZRq
	 NBaGq9n6tXOVjvnVUIBPvg1J2jE292sBWRGYMaxMiJXIeAyPS+fTZ6qZ3WZfcW7boBGOx
	 oE68V03tHrd9fDZ6C+S/pKmvSoou4RTHOuRueVzV/XbNRxN2RMeJHvoTJk7bSc1/ltxr1
	 WNm6TGGCXFM+84f/uuxiXhytVmyNds2EBtg5UNjOAvmtUcY/Gtv1ct+ByPn4adQc5oQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=DkVgHlCe;
	arc=none smtp.remote-ip=209.85.128.49
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89ABE606A32A
	for <git@vger.kernel.org>; Sat, 21 Nov 2026 17:29:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 89ABE606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=DkVgHlCe
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4b79502c27aso16509905e9.1
        for <git@vger.kernel.org>; Sat, 21 Nov 2026 09:29:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795282175; x=1795886975; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:content-type:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=uC2hx5H7HzaXs4Z9Vl4gIEvZGFMTpzSl2HOUdZw0rgU=;
        b=DkVgHlCeWMXSLqnNvZ38FT9P1H2UrrAobE9g07CKGtJ/z0BAz3ipzxiU8nPDV5H8NW
         CKL/kDtWPTD2wQJqYO0r7BpLESIw2BSDvdQU/duAVFuCesEgAyNTXlAGsPl+crsPLXuN
         m09EEKzlmSy3bcaZFGPrkMKLAkq+WprqZaYWcQ7nqG8eh0+d2rzmVnDcmOGKSG3DzuGS
         7yB1LeHdeSUguIvrx9b1pCW3nXLLp9hHuYDJAtc008XsFkqFmP5/LjijKQYn8koztCDz
         HAfSD28KjKO+dMYBXbck6L4Jmfid+TH7Fuv+LE4gXc79BJ1fVTpOzQWD93mxudp9NiBb
         05hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795282175; x=1795886975;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=uC2hx5H7HzaXs4Z9Vl4gIEvZGFMTpzSl2HOUdZw0rgU=;
        b=e7PV9Xe6pqzk/RKGgixF2bGWJ3vXzv51J0r2bDzm3HeZ++0lzD1UMM3SGhOonPdGv0
         /aF6fE81QFuXnDCHCDgrYpQPt9eQdLP093v3c43NQ7hBRozH73Rphnu6eLhElS/rRReX
         yNFsLIheM96mOJO9iy2bzCQA6bG/BYv+nHiayL7R4bucL7ysA5b2I6Js51Jqjh/yJQNR
         N/k5AHYkWzaGKhYp1cISynyIvyNYpM4x12nJB2NdUsVPWKRsjyH+e6S52ly7iVCEc9R0
         vyN9gBakMe82lZAfXEtrhczZcyNKFpCM/LnXMDVvawWGelC+UQZFT/vO2NBof3i09pMn
         KQ1Q==
X-Forwarded-Encrypted: i=1; AL+hErFDsT0RmgBWPkI5E5NpLg0vE7ip2FbA69RC+VpM5Et3vjvxs0jcilxIbqft/9ChKyNhLyM=@vger.kernel.org
X-Gm-Message-State: APuU4Z8LNwAu9iBxCSXJrnXpRGKTUoJ5pvKpSgN/iCS6ybeYfyAEHCUX
	2yaeVKx8AbV/WlXyGT8R91Zd5o3rNm0ygGSEnrR1EErD0Fz66f6aMPuP
X-Gm-Gg: AZFdTZfqQnowtPtmDn0VHf2/5WqdQ1oHee6ZzUn8Ys+HC3zVk9ur0fignEL+Qn+KIzf
	uFMserWYAkmVL9MvOZV4HksllVHIUw9RGshnTZ8mRmygFo/vmAzfENNmg/k1WDgXXTouBbJtTif
	PhPKJqFyDLRzUh+cd73tXPCz8sh8cMWERn7WeozICm9WZZXEgrc+ETyksLGF7ar1sBda7yfvle6
	pfUe8T3n0qdV0cMbX6jjjRivkYl+MxObk0tRh/2m8ol+OH/g4sq2y2a7W1nM5qye9h3dmbYj7YN
	o9rTv8bGCxixIovBmV4OD6vpQZzr0P66VMrCxtsBYg3UQ0pK+U/A4WxnnWTpBf4njdfxJvPIgAC
	i3YR5CVxhkAjvC47+WH4y4kK7ipPfLaobXA7Xr++ch9SU48r7iaKQ5PI/a/t/8anT6ShQ9+1LZ+
	+7pJWv0r6f7YHZFGQRCRWJJai+RFeMQvs33MiVG4JlAdEvNfrjM4ouK1cHoErOALrWDYLZH3UFC
	WimKbg0RBV/a33IzoD+dkALp08dPWOs2KDtz3y1Uxx8BWZRm7pv9iI/7fN58mDJ+Rvn7Ej/stE2
	PKzaTccmFvg6FPqfTYo6UC+fJNMD/POISUmG9HBswdkQrKd8mcbXmjtyIe8JsZfRXXYsZxLfZrA
	EnCQ=
X-Received: by 2002:a05:600c:1d86:b0:4a1:fa27:df7c with SMTP id 5b1f17b1804b1-4bb88922972mr145907005e9.34.1795282174731;
        Sat, 21 Nov 2026 09:29:34 -0800 (PST)
Received: from smtpclient.apple ([87.68.137.101])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4ab658e2d55sm12370903f8f.5.2026.11.21.09.29.33
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 21 Nov 2026 09:29:34 -0800 (PST)
Content-Type: text/plain;
	charset=utf-8
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3901.300.60\))
Subject: Re: [PATCH] setup: fix grammar in code comment
From: Ophir Bleicher <ophirble@gmail.com>
In-Reply-To: <CALnO6CCJO67E+QA6U4b_p6X9TRwFncc_S6vTs_f6YOX11m0YXA@mail.gmail.com>
Date: Sat, 21 Nov 2026 19:29:22 +0200
Cc: Ophir Bleicher via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <DCB2D90D-09E5-4D19-99F9-7E268434952B@gmail.com>
References: <pull.2500.git.git.1795279741855.gitgitgadget@gmail.com>
 <CALnO6CCJO67E+QA6U4b_p6X9TRwFncc_S6vTs_f6YOX11m0YXA@mail.gmail.com>
To: "D. Ben Knoble" <ben.knoble@gmail.com>
X-Mailer: Apple Mail (2.3901.300.60)

OK, I=E2=80=99ll submit another patch...

> On 21 Nov 2026, at 19:27, D. Ben Knoble <ben.knoble@gmail.com> wrote:
>=20
> On Sat, Nov 21, 2026 at 11:49=E2=80=AFAM Ophir Bleicher via =
GitGitGadget
> <gitgitgadget@gmail.com> wrote:
>>=20
>> From: Ophir Bleicher <ophirble@gmail.com>
>>=20
>> Fix a grammar problem in line 271 of setup.c:
>=20
> Is it a grammatical error? I think it's simply the wrong word.
>=20
>> will only complain about an inexisting file.
>=20
> What a strange little word: it comes from "inexist", which does *not*
> mean "does not exist" but rather "exist within"!
>=20
> https://en.wiktionary.org/wiki/inexist#English
>=20
>> Change it to 'non-existing'.
>=20
> I think "non-existent" (or "missing" or "not found") would be more =
common here.
>=20
>> Signed-off-by: Ophir Bleicher <ophirble@gmail.com>
>> ---
>>    setup: fix grammar in code comment
>>=20
>> Published-As: =
https://github.com/gitgitgadget/git/releases/tag/pr-git-2500%2FOphirBleich=
er%2Fsetup-code-typo-v1
>> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git =
pr-git-2500/OphirBleicher/setup-code-typo-v1
>> Pull-Request: https://github.com/git/git/pull/2500
>>=20
>> setup.c | 2 +-
>> 1 file changed, 1 insertion(+), 1 deletion(-)
>>=20
>> diff --git a/setup.c b/setup.c
>> index cedc031c54..140f1926c4 100644
>> --- a/setup.c
>> +++ b/setup.c
>> @@ -268,7 +268,7 @@ static int looks_like_pathspec(const char *arg)
>>  * diagnosis when dying upon finding that "name" is not a pathname.
>>  * If set to 1, the diagnosis will try to diagnose "name" as an
>>  * invalid object name (e.g. HEAD:foo). If set to 0, the diagnosis
>> - * will only complain about an inexisting file.
>> + * will only complain about a non-existing file.
>>  *
>>  * This function is typically called to check that a "file or rev"
>>  * argument is unambiguous. In this case, the caller will want
>>=20
>> base-commit: f7de81456940dd6f3274e461149bba12965de609
>> --
>> gitgitgadget
>>=20
>=20
>=20
> --=20
> D. Ben Knoble

