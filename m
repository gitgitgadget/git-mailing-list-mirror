Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01D4D1DE4E0
	for <git@vger.kernel.org>; Thu,  3 Sep 2026 01:00:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788397250; cv=none; b=SKq14ENCvU4NexOfoleEhJslmZcAYPJ7x/WR0tpCRbRxNhV2AxAUcFafqqnUeIndGdd9Zm1SVjMxUQFJjSt8v5RY/9lTjyRiCkJCFF0I4QrgYbz6qWtMpHxxibi92NfFcTmud7aoJorAQ9Aum803sNDoM8444+yrlvxB/lDm+tw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788397250; c=relaxed/simple;
	bh=+eQvkOmieS8xC34phx9f+NXJqvqt/7Wx5BZd5S1C35E=;
	h=Content-Type:From:Mime-Version:Subject:Date:Message-Id:References:
	 Cc:In-Reply-To:To; b=oGDdSFaoclFFrfgJrGfpibHqZ3TuLGqcNwtzy1ZwJfaWPgrGl5WtnhFb6OPIBrLFMP/Wb4gHwehu0ZNL7KYIqy6s/awnsUMROX0Wfkp+0Bv1UOtuGpugPCplksTByewE0zj/AeoeIsr4GlU/K8EjA9WzfNsFlcfMnag8X+HeCR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YZNj0EEL; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YZNj0EEL"
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-86162c086f8so7731527b3.1
        for <git@vger.kernel.org>; Wed, 02 Sep 2026 18:00:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788397247; x=1789002047; darn=vger.kernel.org;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:content-type:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=9m/HA3RhUVmbRgaQkyRfs+Hm7Pif+6w73jp4/vd8WSM=;
        b=YZNj0EELgNPa1r09CNxl4b6t3XXmOaNfuzPQa7xLXQpdrHAwQH9z1nkjilz2PWhjqY
         sxbalxyfZN8EqBVT0l7yAOKPcynMYruDhsqzz06pQ6fFbwWlQ5oUEN3BKjyEDmtbOW5p
         Nx7J3IN7C8DxrpFBHPOYe14lmFUXz9SlBokW2k3JTGoRbX1921ax2F5fL1ckj9/5iZYm
         FCw4/XujtiCZJgSTeqQe1ww4A7lzTXRG5r8f6WUX80Gkp6jkEGhmk4FuVBNWFxy99Bah
         A7eN3gsRM6ogAePVb76Z0HxOP0Yqnjpn0IexmEiBeF8RlvJfoptix9rZplH3WcD6i3eq
         g5rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788397247; x=1789002047;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9m/HA3RhUVmbRgaQkyRfs+Hm7Pif+6w73jp4/vd8WSM=;
        b=YHeJWgTw5Y7G0sZL0UknXSkx/SqTEyLG3no2GWl1Muae6zJ55g9sB3heX7w6zdztLY
         UpkxVRm69cKI1V8MXT9rPJXLHY6N8HsQx99ShNpNbbahU2lfgntueuxlf5f1wMM3QXnq
         /v08NujgiQRyxfEBBPVJSEruCC1GNfhVU/Ok688Io+v0Q4ryAt3Ad0iQTrdy7U/qT5JL
         xdakrscvWOxcpn9zhiihnmPdZ+Ym+FgTtCNJ39VboTrVZaVWQmy96cyyWvQYcuWlTiOl
         fG5vYmxPN3dQarUDGKDLrz+FOqEOfn3PjXuVOH79kUmK6dOFn1DZhUl0/gNspF2PPc6+
         UD4g==
X-Forwarded-Encrypted: i=1; AKwUvBxoB1rT7hvRKzJsn1a/0ds5fEJXndlv04mF30ZWNtXtB2THYHYcXLtRLS26WwAntvKIxV4=@vger.kernel.org
X-Gm-Message-State: AFuF++mMHOB1EITT+9IJtla8XIr9H2n5fOfbN0xcaVY5oOPgCz2E7cwg
	uHS9eiabornnTH42GDjm+YiP/3FpGhlWHDV9C3odPrQAPDuEMMbnmb1k
X-Gm-Gg: AYBFou18V8R+9Aw76Dq/0hqVPg7DA7y6vFixn2aOAF11Jh3PVzJp1rInsOzIPkHqlZ8
	sovYje4ezaJmpf14SUTjXDcXRJwlpmo1J9WSx5UhkloHRTQMaltuGeRGwvwEF2N4/CB8Mp2UkrJ
	qLc7KrF4748EzgNCwNAoQ++qEBOOkqqQPDZfnLm31DFdYR2EcpteiG+BVuYupAHpeCLxeQf1RGT
	PaYCQFOB9qSOudPXjAWMW/TRj9sO4HEIOjLAUZo1F7UHADd4jd44n+XoyzuXMsShT/jjAK4UhgH
	i4kx7FnE2z2UZGJmud7rBTPiRErMykGNWG7WNQxQZaXcy9xo5lgoFbzOp4zWDbdA0cnFEK2Kkf5
	bMU7rvJ4dhnkxkGvSxcqHudZmE2IvjcMyrOuvBE3iap4Cihs1R7pjdfRJ7EZYTfpTn3XfEXQul0
	diIGCFV9QxhXuKpdq2NbnpTbL2oQWCOmvMsBFiNhyORkSjhdgM7F8MCQzBvcB4yh+pKioLhDQgu
	AImYHb77+XDKnjBI9maBgbn68CrZPE8D2fHNuF9xCSfXMwp1UL5It9vYxT0o70JZd8OczzjCE3T
	oxIuYojCkgezP+HeGtHioytSi+F++PItMIb9hQ==
X-Received: by 2002:a05:690c:10d:b0:80e:dc2:873b with SMTP id 00721157ae682-86e70fe5dd7mr13459467b3.16.1788397246791;
        Wed, 02 Sep 2026 18:00:46 -0700 (PDT)
Received: from smtpclient.apple ([2605:a601:9092:700:494e:2119:a9dd:edd9])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-86c1784191csm29793267b3.32.2026.09.02.18.00.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Sep 2026 18:00:46 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From: Ben Knoble <ben.knoble@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH v6 3/3] core: convert build-time USE_NSEC into runtime core.useNanosec
Date: Wed, 2 Sep 2026 21:00:35 -0400
Message-Id: <842F2470-F158-4E77-AD98-DEA530FC4460@gmail.com>
References: <xmqqh5k7gy9k.fsf@gitster.g>
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org,
 Patrick Steinhardt <ps@pks.im>, Todd Zullinger <tmz@pobox.com>,
 Olamide Caleb Bello <belkid98@gmail.com>, Yuchen Tian <cat@malon.dev>
In-Reply-To: <xmqqh5k7gy9k.fsf@gitster.g>
To: Junio C Hamano <gitster@pobox.com>
X-Mailer: iPhone Mail (23D8133)


> Le 2 sept. 2026 =C3=A0 17:05, Junio C Hamano <gitster@pobox.com> a =C3=A9c=
rit :
>=20
> =EF=BB=BFBen Knoble <ben.knoble@gmail.com> writes:
>=20
>>> My suggestion wasn't really about supporting more cases, but just about
>>> making the code simpler by having one less #ifdef. But like I said
>>> earlier, we can't get rid of the NO_NSEC knob entirely, so it's probably=

>>> not worth worrying about the one #ifdef either way.
>>>=20
>>> -Peff
>>=20
>> Right on. Always good to find myself nodding along with your explanations=
 :)
>=20
> OK.  So will we see a hopefully small and final reroll that takes
> advantage of the fact that ST_XTIME_NSEC(st) would usefully hide the
> NO_NSEC build-time differences?

Ah, no: I wasn=E2=80=99t planning on removing this ifdef, as I think Peff an=
d I agree that it=E2=80=99s not worth the hassle (at least for now).

> I still am worried that something that sits this deep in the
> callchain can easily BUG() when working on a repository that is not
> the_repository due to the use of repo_config_values(), and we might
> be better off adopting safe default when istate->repo is different
> from the_repository, but other than that, I think the series is in
> great shape.
>=20
> Thanks.

Yea. See previous messages re: convincing the test apparatus to set this glo=
bally. If I could run it that way at least locally, it would go a little way=
s towards scaring those BUGs out into the light.

Absent suggestions, though, I=E2=80=99m afraid my time is limited to explore=
 the guts of yet another subsystem ;)=
