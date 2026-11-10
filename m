Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.181
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794330934;
	b=oNCgrlYcy8jpgZQDlCbSQIGqsK1hxdhkr+bF1am2Y/iUxXyoOXpApgWvV3UREBGO9FLF
	 5uB9zA1Pe2rD4AAlJqFxOjA0jgS+sGod0MsHNxtcLGCRxqHkQz3n8gMJ4ktZ+NLInOCxW
	 ep/ZhsDv0A9jye4EgVmYu5ifj5weH9QAQ+v2XM487cL21LFNRO/r/zabAEX9znLXwYVlR
	 bj4xXiB3KYM5ji8gGSMJerNaZ7aFGEWyyNbHfX0PmD2rsJNNu980M5bFAixiUD/BiCCaH
	 jZa/ZKZRufusjqHgIa4CqYUnN/ui9BuqExvPhzw+r2tS7T9mwoe6oOwLmpsjYjo9C+w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794330934;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Content-Type:Content-Transfer-Encoding:From:Mime-Version:Subject:Date:
	 Message-Id:References:Cc:In-Reply-To:To:X-Mailer;
	bh=7+kanJGBKg1ujDrL2xJHyGTz1TgAY/zHFthRiOHLlt4=;
	b=C9f41LwO+Zz1rcI8lmN28WobUBwBN8XC3zTQfAp7eoqjqnTBRIGJFdWm7ZpIxsbOlNTc
	 dHtxG9yD9TZm5cJGrFRIdLYJ7Yp1UpEPnDzu2iLBbVHdzD/iAn9m7JeCu9U3Qwz3mVRt+
	 R8WFdOXTn81XoLSeYrigKCEuCHWlx1WnNlwI+IV2ObKcVRyJqBBodDLmAWvgglSvgLXAd
	 mteIybMGFj7k72EZJUmH1GHMbA+Ih9uYOaJgqDbkV36yrBEaTC4hZUE78LnSfqXvhiZsZ
	 r085OF48CJOTqVDW1/yoNWr6BD2knio4ig7yvtZGtPnmWwoJtD53nEaIogbyivEwU6g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=sD0pR0W5;
	arc=none smtp.remote-ip=209.85.128.181
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A461E606A31C
	for <git@vger.kernel.org>; Tue, 10 Nov 2026 17:15:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A461E606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=sD0pR0W5
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-8b31261e8a9so17389377b3.0
        for <git@vger.kernel.org>; Tue, 10 Nov 2026 09:15:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794330932; x=1794935732; darn=vger.kernel.org;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:content-type:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=7+kanJGBKg1ujDrL2xJHyGTz1TgAY/zHFthRiOHLlt4=;
        b=sD0pR0W5j0OI1RHDDZ/FZf6zOe4vCuX6OERjVc8zv1u5hQRYPPwOl6toK541FjX3aG
         Xkv+oeaq70OM33cs3+G7ylQUGQaGKldnbsIK4CnMrLnSlN7Et2k0SeaVIuIyVyKZ4IJU
         HghqdHBkX1bTQfxLA4yqX9W81dN2Nwv4lTl7xTdg8ackz68CRc5pAh2jPvXgq+Pe7Qc0
         /Ro8zYP46bFEkBki9FmIYamRPP2bT3Z+TUOwXAFCwywWlYAXQT/6fLtpdpz+GWekoM7n
         ehkShvviIibU+e3yIBXPs6Pgf5E4WHk5ikga2OXK8S2Q3CWMRlaN6M1SqmCGAZrlClFf
         Zamg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794330932; x=1794935732;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7+kanJGBKg1ujDrL2xJHyGTz1TgAY/zHFthRiOHLlt4=;
        b=iiXhq2Nk47z/eKTVRMYRk/RlS4YH3GXsOp4IXuCO4HLOJXMd9p6KbG2RijFAMxDq4L
         xj8v2oh7inYBE9w+d+WrPDIVrz8+/64Pq2QFUU3x8GW4hdJLiVwOjeYvxqQ/kdqMNnVg
         QpaaC/AVdXzuZXReTMHQ5i33dpxEsFbGhJOPrIGOM5WpBqAa9GjXXaWJbJkAkVkK4jbA
         f2ADW9XSOCi43UU2WEt/sRPSzqy8fqjujFSNq5AE4NA7q5QV2QE2471mmyKXX0u0BmNk
         My/iJO40i3M+fk0WAkAn3ZxxBNeBMDQ+NuikOH1t8cp77IWUhztpJbgDyS5kmrLyGLBS
         ZGOw==
X-Forwarded-Encrypted: i=1; AL+hErEpcbqE5oT5AZcKZDn1FHG9JI3ZJvgkeYh/yZn60cnPFlKsZzK5rM2QayQrmEfdWoHjv4g=@vger.kernel.org
X-Gm-Message-State: APuU4Z/ZPXGl7o1KAA+SCkNHmmdMXTGXSqfbKYctkK3/KZ42LvzCoey3
	ndqfVTg2j/Q8sQ3hz+oX8sayEQjdHt3RThY7gzNepNtbitNKIQA5xEXX
X-Gm-Gg: AYBFou0onDemXw2IZEXXNlQog3GHWJ6b+I2kZfqmRmHg7WbW4ML60eH3VGyXkhJhQiM
	q2cjwQhsv4OHj3QFQza0UsYyThbgpXfV1cr3b+JMGWe1o9lMhvyvC3thVYOC0yxpagpKq16W7TM
	hdDmWH/sFiBkHX/J5+riCnnoycjMm9uOR8By8sB/qsZ/LzvzU5NdRdAIv0A6A2EiimLbo5vATxY
	l9dnhhNjSudmYNtWciCO9Jk2tmzgK0bkgYlDtioigGL6y3yEilCaqcJdfFEk3TSSD1ufGhoHpyQ
	0gzkaehFCpQumGVC6DZ8y0W5nrP11r5KD5MNlnIAbNPLrPzUefdoabtn2Y3DeAHJcvW4X6AdZGy
	Gjn7zbMA9gSqX2af6b7qkKtySG7LJMXTUSoohQomo4viLBhKiPwFQLikhLIIPLI3qDIXq+IKI5+
	kAJ6D0vnMxS2++E5CTcb1Ng1quptOCpExGzd8yQj85vzq4LoPfCmQ8QrA6XJ7xz0TW7P9y02JRA
	kaRGFFDxjqwAsahvdqks/CsgLP/4kDpGylHEllplx6Sh6wK9sK12Q19vf+GCOuwWV5jgDmpn3Ip
	OMEmNZmYlxDLwajY+8VDiUlVojDqP55aVlcB6bYfxirFRLzMqMBy2iqtb9gvxuqN0FXcUwuPROr
	F3nS492bciWo5Vv2o+LdcBSyJgjtZelUpSWHsNjqj93A0xO+3njdzoLi6XGplrF+MIEmOQlSPho
	95Sf9mtmFk+g0svwygIy/e31M=
X-Received: by 2002:a05:690c:4:b0:873:5bb2:6c06 with SMTP id 00721157ae682-8b392a3cc5dmr24493437b3.48.1794330932438;
        Tue, 10 Nov 2026 09:15:32 -0800 (PST)
Received: from smtpclient.apple ([2605:a601:9d46:600:f493:878f:a4da:aca])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8b393b2e455sm23080817b3.41.2026.11.10.09.15.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2026 09:15:31 -0800 (PST)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From: Ben Knoble <ben.knoble@gmail.com>
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0 (1.0)
Subject: Re: [RFC PATCH 0/2] Support --verbose in git history
Date: Tue, 10 Nov 2026 12:15:20 -0500
Message-Id: <53CA2747-58F6-4A7C-81EC-33EABF0000FC@gmail.com>
References: <CAOLa=ZQowi+fepj+RNegTZhK_Jy4G8VLE_Af2UdsO8-rCdviJQ@mail.gmail.com>
Cc: Phillip Wood <phillip.wood123@gmail.com>,
 Jelle van der Waa <jelle@vdwaa.nl>, git@vger.kernel.org,
 Patrick Steinhardt <ps@pks.im>, Junio C Hamano <gitster@pobox.com>,
 Phillip Wood <phillip.wood@dunelm.org.uk>,
 Harald Nordgren <haraldnordgren@gmail.com>,
 =?utf-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <CAOLa=ZQowi+fepj+RNegTZhK_Jy4G8VLE_Af2UdsO8-rCdviJQ@mail.gmail.com>
To: Karthik Nayak <karthik.188@gmail.com>
X-Mailer: iPhone Mail (23D8133)



> Le 10 nov. 2026 =C3=A0 08:13, Karthik Nayak <karthik.188@gmail.com> a =C3=A9=
crit :
>=20
> =EF=BB=BFPhillip Wood <phillip.wood123@gmail.com> writes:
>=20
>>> On 09/11/2026 12:43, D. Ben Knoble wrote:
>>> On Mon, Nov 9, 2026 at 7:06=E2=80=AFAM Karthik Nayak <karthik.188@gmail.=
com> wrote:
>>>>=20
>>>> My preference would be to make this (current patch) default behavior an=
d
>>>> not even have an option. I don't see a disadvantage of having the diff
>>>> always being shown and it definitely is a better default to have.
>>>=20
>>> When the diff is extremely long, or if the user has other means of
>>> obtaining it and wants the editor to open quickly, it may not be
>>> desired. So I'd prefer to still have it optional, personally.
>>=20
>> Another case where we might not want the diff is scripted editing as it
>> is much easier if the script does not have to worry about the diff
>> getting in the way of its edits. Personally I'd be happy to see this on
>> by default - the history command is marked as experimental so if having
>> it on by default rather than following "commit.verbose" proves to be
>> problematic we can always change it in the future. If we were staring
>> again I'd also make "commit.verbose" on by default as well so maybe I'm
>> biased.
>>=20
>> Thanks
>>=20
>> Phillip
>=20
> I'm on board with this suggestion. Plus, I see 'git history' to be more
> user facing and it's always nicer to have better defaults for users.
> Showing diffs and verbose information seems to be inline with that. We
> could add an option to disable such output for scripts (but that can be
> done later as you suggested).
> <signature.asc>

I can live with opt-out as long as I can turn it off via config.=
