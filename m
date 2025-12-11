Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98CA92BE7AB
	for <git@vger.kernel.org>; Thu, 11 Dec 2025 04:00:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765425605; cv=none; b=M1+VHbCIkupr8UXTZQlKInjHofO+jtilyc73JVVKeM/FYfMjbdE+ZgkrDSDN8euzXmMKnoKkAeuuCc603t0OAppSDkcGlGN3c4BnK60DGvUnvI8gkHY4yn2aCStzp60mfm2EkChw9PUkonjPLqSiye2QKVr/40hZSR0jkQeFD0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765425605; c=relaxed/simple;
	bh=uEgBe0lA9f+wUe9hKPdkJ0K4Lx3FtldTU6EZGmWyiyw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Xb81vP/Af4SAMbk9t9livtfBC/FaEbYT/mZ5XDRiVs4u6DoFIdyzkyLJ7N50WXLgYAJg4fpUVHZs+UN7oCMz/FJSd2+fhkzP9qMXnsJ+Ee+efZecC9NgZH185nz7ub9AFAgYT92UOwtQxL6INrDdgI9mw2zI8cxI27+hINa8bOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=sunshineco.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=sunshineco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-8b2da4fb076so11057585a.2
        for <git@vger.kernel.org>; Wed, 10 Dec 2025 20:00:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765425602; x=1766030402;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=6+03v1Rh8ofuNd97SAbfeXsdX7N7x+nz5ycIAxUxdZg=;
        b=Bt0s1+zC4kkrfKyyEIqv9WVQh0dqm2XLe8i5cTDZDKFpcs17LgxesqlEyJRGdvNmUg
         teGxYzPdgotQHLegzC4hAmbHipqy5UR1+rJ6HLVCCfsTNGDBfdJE7x/CbbThNA0tzbm0
         nBzv3dBN5nyBwsIpl/Cyt3LXb70sNPv15jzKsHv/owftgUy3RqDMuVSbvMUV3Ya9b0hC
         uwBLNGxn6EL/BP9q7Gl7UI2oxmHvOTRniapQdDv+KP2+LEp6NcB2IkfKEcQDmfArWx/0
         q+JvKf+RxuARoWcOuTXLjbupNTIljK9CO12gVoQXa3H5tE1y/OEqqT7gtN5MgL1x5CdA
         K4lQ==
X-Forwarded-Encrypted: i=1; AJvYcCX8HE8ECvrYZSJDNeG2SFuTQU0l49j17tnEjUf45/vh7PtB8ixV27InwMEJIlxHEOCI9QA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxHY4A+Rl2n6xeLVqOuPJgjm2vVM3kC4j7C6FiARKi84Q3pQDOb
	t4NXchdWDsNmyZh8vX/WfPeMh+BhzltH6iFKDE0dmdVQAbuTVwgY94vFoggHj/yRc6sUPjSNaKb
	EeOfj5NnSlS4VaFAG7/0H1F3VRbs/Qr8=
X-Gm-Gg: AY/fxX5n+pxQTGgtsFKXKm6JnI+W8xM5qYABlLzQ+c9vQEzqCMpZjkDFclvV3FKqwgV
	FQI4MuQM1dBuLaI3VEawzv0haZ/BGbWesSTQ8t9EIm7pxbovOQ1GUfo4+YBGPKVkQLfSm+aXYTQ
	B3fRpxh2gwnpaelQIOuG4ZZVSAwph1BZKv7WSbW4i9IMxpGOpS+OkM318jKkYR9tI+YSg/2vwF1
	tahlQTv14s+91T1xlWz/go0at09Uq00+wjhKtRccP5EzbCOWIvwpteML0nJKkaqlnbdb5Con1Cz
	uVZ0IGqBFfOyfaJ6z+65Mlh2w6k=
X-Google-Smtp-Source: AGHT+IGjbddpJlv+WRAI4mv+XvSky/Uqt4gb0XUIGsrWKYu+vUG4vNj+dcvbehvBUPn8gkoETE0kmOBqslOC1Gsnu+w=
X-Received: by 2002:ad4:5ba2:0:b0:87d:c7db:7897 with SMTP id
 6a1803df08f44-88870288d5cmr15601936d6.2.1765425602128; Wed, 10 Dec 2025
 20:00:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <a5wKtD6Tn0gzcba1IEUhukYnXPHxMwPq6puQKIPywmjNufi5vc6vX-v5BpPJ7qj_zZsuXF5FiS2gbpsurWmVjoWHtMm8A-kAbaZyjMfrTcs=@proton.me>
 <xmqqldj9g0pj.fsf@gitster.g>
In-Reply-To: <xmqqldj9g0pj.fsf@gitster.g>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Wed, 10 Dec 2025 22:59:51 -0500
X-Gm-Features: AQt7F2oeXjoQUmxJKTVhHeNLZ7HnZF4drC4f--P89T48NuQ7RK0SKtJcBv45wtU
Message-ID: <CAPig+cSep7+i2R-DDK+B6p6c3gy2Ehvm4U5N_PwSR-yZF3n1hA@mail.gmail.com>
Subject: Re: [RFC] reset --hard: warn before discarding staged content with no
 commit history
To: Junio C Hamano <gitster@pobox.com>
Cc: Koutsouflakis Stefanos <koutsouflakis.stefanos@proton.me>, 
	"git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 10, 2025 at 10:24=E2=80=AFPM Junio C Hamano <gitster@pobox.com>=
 wrote:
> Koutsouflakis Stefanos <koutsouflakis.stefanos@proton.me> writes:
> > When running "git reset --hard" in a repository where staged
> > content has never been committed, the staged files are lost. This
> > seems like a case where requiring --force could be helpful.
>
> The thinking has always been "'--hard' means what it says!  HARD
> removes things harder than other modes---there is need to add
> '--force' to it".

Presumably, you meant "there is *no* need" rather than "there is need".
