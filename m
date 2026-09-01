Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FBF5363C74
	for <git@vger.kernel.org>; Tue,  1 Sep 2026 00:35:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788222935; cv=none; b=l3H0d48Sl1ClncYiSRBBeiJ/EgqJ7TjFP9E1q5X4sTW75D0sdCSy5G4jtZ0hi5oLB3o6zjD02/lG8RLItK29zz32Njhq2t76WOlOx7vOwnO1u2xPh8QomKeKzWFuz0rlQRFsyT5onHXy7HEfAK7rWdzK11nv6XxZeqIbQP6OQeU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788222935; c=relaxed/simple;
	bh=Mm/8Kphdkh++js41FyQX3f8mOatf+y035IrO+xOVkiU=;
	h=Content-Type:From:Mime-Version:Subject:Date:Message-Id:References:
	 Cc:In-Reply-To:To; b=HdOEYDQPjQOGLHX+q9mevXMGiZQEd8M7xYgSHL9FzYSAFpvYtorhepVJ8wjUAfQD8Kpc/39huxO4sNVc7ttZXoMLulbvkgT1V7DMf3i2fLo5+QO99NDKXpFpep+EimfWZul8HEa+KlBKQlE1tOOkHRIX7YX87AmTjmEg6PTzdyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PMhAHJ1m; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PMhAHJ1m"
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-86162c086f8so8677577b3.1
        for <git@vger.kernel.org>; Mon, 31 Aug 2026 17:35:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788222931; x=1788827731; darn=vger.kernel.org;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:content-type:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Mm/8Kphdkh++js41FyQX3f8mOatf+y035IrO+xOVkiU=;
        b=PMhAHJ1mppfupmONU412itestU9ZAj/G5AIRG/nwOIWpzuv5fRn47YkjY9K2erao48
         Gou87qeAmeGBJZPYXxoztCRjh38vb4TYUNEeeNa8M5jhDNxmRMIavuHZbuwUyR3QfwWM
         G2aIT9U/gQG4UUl62k3kmbEITWs1MKxMut/oieR2RoKrA5EhvQPkhDVv3qY+Dljf8mhs
         jvjVEcV6L+RhDkSVbbAmiUPy99hWebFJSXB3jdWpMlxrVyeLsaWTCMU8kLLrnJT14iW/
         0JLuz2DWiyYfjoH43m9pzcvN5QNVnUONWL0Cgon6EbSAsJalF7mb45YkAmr76iKKOGtR
         i3Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788222931; x=1788827731;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Mm/8Kphdkh++js41FyQX3f8mOatf+y035IrO+xOVkiU=;
        b=HtYJSK2bw9Uo++oeO7JcvjQGavgOrHbMBGo+1eIXMY7OABxyNDzv0fhdSUfGbMkbp8
         0esc9bnQKiAG7w/RzoMaIlA7FL/umHgyO9jjm/EO2isWxWCh/UFq5/lY6nv61APHY/BF
         u+kJ/Fj0+NJy+a7r1ukDRJL94E7tLKv/oZrJpQmBQdupcoDt/x0ELQUPgCyGxia6vj2X
         d44+9hVW5tG99fIFrywzqiEMD1ryTtx93Hjy+YxNIVf+oqC4R6DoAzfSbYIPr3L3AcRh
         0b4ufdt5SUF7Nd6m97SGAogkpJb1XAnNXZFp3Rz6p8VJtHyTJu8H2NCWuz3qEKfI/G1r
         lpng==
X-Forwarded-Encrypted: i=1; AKwUvByE1i5bEyhf2GBkFKCbkqE7KzYEN9Z9mbioHzMNJ/f2oFn3pe8903DFiNAwqTfPP1USzeM=@vger.kernel.org
X-Gm-Message-State: AFuF++ldnMru7vJmHLSgP0cu2nhjJGvSmqj08RzKkc2FhG4s7zT4lWtM
	WN0Im+Dtyn2OjCpmfWxCDUDSCq9kyc1Og1CHvmBOy01ppFfqeSyp7pJD2Pp2jKDJupI=
X-Gm-Gg: AYBFou16lGETxiOopN1ilMVD1+lUpxSgHu3LyOcgr+MEXfL2zljWWXWNB3Q+8/y2cAe
	Rg6SRfROAAbmT5H09WVJiRM7GDFv0H/nJ8944za3EfxLtuYcOPd8w/JHYC185HvRtXocVuuhrSF
	tdPE+3XXL+nSbo9l9v1gepyzLT/7Q+BUPin8JIDaKZBdcrD2BX4v/P4D48ERLVZrPmABToexB8M
	0W8hgK3lfZLfEaoVJCHuUDen5mZXeeTqAA894xGwIFtprYXc06EB4StJyIV3SToYsKhJIT0Oux1
	WayhyfTyLG78EMND1o/Jqq8ZRc00VcrzR0aSnFPQqKa1iLEm7mNg1HsNIPnUHWlGmGsDyTj3t9W
	YiD8knQQlddtQMtBvNytCcvIHbc5vLqAoCbmSZwXEgGyHlndwJiXa5lpq6c+QHbN+0G+kvLyd2F
	GsAPYcPr2W/PVhYCEocYKWmSS8rrzSV4qWtrIH1hgMIRi9CfpWu5pB1kdqcElwvzDmeT4+AWg0j
	xE7Sd8MF3rt09j/DQfk6DTS2srFZUoYlGWnbZEgiI8MPG6kfu/cKXrXAevzHkoy3k9MXWG9oHZh
	EVnis0a9NUOm0KE9UfUgA031IgHheuq5eeZtL2xqH+Tn4WXv
X-Received: by 2002:a05:690c:389:b0:853:fc17:6054 with SMTP id 00721157ae682-869487f6216mr9173127b3.3.1788222931269;
        Mon, 31 Aug 2026 17:35:31 -0700 (PDT)
Received: from smtpclient.apple ([2605:a601:9092:700:f45e:1544:1409:e870])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-869cca3c804sm2038057b3.6.2026.08.31.17.35.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Aug 2026 17:35:30 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From: Ben Knoble <ben.knoble@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH v5 3/3] core: convert build-time USE_NSEC into runtime core.useNanosec
Date: Mon, 31 Aug 2026 20:35:20 -0400
Message-Id: <B48D3D3E-E5C5-47DE-AD67-C8C6CB11E27C@gmail.com>
References: <apWUGfzQxx7vArpo@pks.im>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
 Olamide Caleb Bello <belkid98@gmail.com>, Todd Zullinger <tmz@pobox.com>,
 Yuchen Tian <cat@malon.dev>
In-Reply-To: <apWUGfzQxx7vArpo@pks.im>
To: Patrick Steinhardt <ps@pks.im>
X-Mailer: iPhone Mail (23D8133)


> Le 31 ao=C3=BBt 2026 =C3=A0 18:06, Patrick Steinhardt <ps@pks.im> a =C3=A9=
crit :
>=20
> =EF=BB=BFOn Mon, Aug 31, 2026 at 08:57:49AM -0400, D. Ben Knoble wrote:
>>> On Mon, Aug 31, 2026 at 5:27=E2=80=AFAM Patrick Steinhardt <ps@pks.im> w=
rote:
>>> On Sun, Aug 30, 2026 at 08:27:13PM -0400, D. Ben Knoble wrote:
>>>> On Sun, Aug 30, 2026 at 5:15=E2=80=AFPM Junio C Hamano <gitster@pobox.c=
om> wrote:
> [snip]
>>>> I would happily prove that at least none of our existing tests fail
>>>> with core.useNanosec=3Dtrue, but I'm not really sure how to shove
>>>> configuration into every test invocation of git. Even if we could, I'm
>>>> not sure we necessarily want to add another CI job for that (though
>>>> that's a separate matter).
>>>>=20
>>>> In particular, (among others) I have not received any concrete comments=

>>> for
>>>>=20
>>>>> Comments welcome: I haven't touched any tests; I saw a bunch of hits
>>> for
>>>>> "git grep racy t" but wasn't sure how to fit this particular change in=
,
>>>>> especially since it won't be equally valid on all systems? Advice
>>>>> welcome.
>>>>=20
>>>> so if there's at least a way to exercise this path on all the tests on
>>>> my system (which should support it), that would probably be a good
>>>> thing.
>>>=20
>>> Yeah, I simply don't have a good answer here. It's messy, and I'm not a
>>> fan of the current direction of `repo_config_values()` because nobody
>>> has yet stepped up to untangle it from `the_repository`. I gave it a
>>> quick shot at one point in time, but the result was messy at best
>>> because of how we populate it via `repo_config(git_default_config)`.
>>>=20
>>=20
>> I took a quick look (being unfamiliar), and yeah, it does seem pretty
>> tangled. I suppose one way to go about it would be to have repo_config()
>> forward the repository argument through configset_iter to the config_fn_t=

>> callback? I'm a bit surprised (leaving aside how pervasive the_repository=

>> is otherwise) to see it doesn't already do that :)
>>=20
>> Is that the approach you took? Or, where else did you feel hung up about
>> the resulting code? Just wondering.
>=20
> Yeah, that's what I did. I don't quite remember what was awkward about
> it though. It might've been that callers have to be aware whether a repo
> is initialized, and whether it has all info to be able to read its own
> configuration? Or I was trying to make it auto-lazy-load or something
> like that, but because our config subsystem is so fragile that led to
> lots of weird edge cases.
>=20
> Sometimes I really wonder whether that whole caching layer is even worth
> it. We already store the configuration as part of the configset, so
> caching the parsed values probably does not buy us a lot. For some very
> central aspects like the bareness of a repository or the location of the
> worktree it probably even makes sense, but for everything else... I
> dunno. By now I feel like it would make more sense there to find
> localized solutions specific to subsystems instead of having that one
> big global struct that has weird semantics.

Interesting, yeah. I can=E2=80=99t say I=E2=80=99m too motivated to look int=
o this further, personally, but the config system seems fairly complex=E2=80=
=A6

Maybe I=E2=80=99ll take a tour of it one day though, depending on the next i=
tch I scratch ;)

>>> In any case, if we see that your changes interact badly with some edge
>>> cases that we don't currently have on our radar then we can still
>>> refactor the series and move the value into `struct repo_settings`
>>> instead, as that structure works alright with different repositories.
>>=20
>> This sounds reasonable to me. If nothing else, this series might become
>> good motivation to untangle repo_config_values=E2=80=A6
>>=20
>> Sounds to me like we might be ready for 'next'?
>=20
> Works for me.
>=20
> Patrick

Thanks!=
