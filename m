Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D23F43672BA
	for <git@vger.kernel.org>; Mon, 10 Aug 2026 08:06:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786349195; cv=pass; b=BbdTW8BqJRxkQMJriJ5876Khq8DfNfbDtX5Y1wfEskbYErUJdX4+cISiYH7+NJWNxgssg1Gdprq5JN9VvQfFWgX/5pG703y4N0sycuEWiT8PFAReBgIB0ks8fNMz61Ar1B0ELefusZ7wNKe65k2O5y+GZPz0xtnANdrU7q7u5bs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786349195; c=relaxed/simple;
	bh=CgX/0k8nZNMr8tQjFW3B+Dc6RBWdqHtH8olyrmG6AKw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gV33jcN9JnRm7rqJejB7mWV3lsQ4oxXBkUpSt0sMM1ufL2crkIWmPPLhpxl8oXA1l7PkIrOM36Z4FJB+4ZaHl3G9Yi4J7FBZWxx5BtAb77OZ0tVIb8RD3jUq+r77SqQZHHRFbl4GRRlD5kpf/NLhNU/WRm7YFDut+Luooq4AR/k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WeUWKLzU; arc=pass smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WeUWKLzU"
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-38e347638adso1688457a91.0
        for <git@vger.kernel.org>; Mon, 10 Aug 2026 01:06:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786349193; cv=none;
        d=google.com; s=arc-20260327;
        b=FRfMilrZOgc5G3VV/9yn7PLVM7+KvIHH7HYw1B7kW9b3rLGMibUOJ01YtBpHq+NR5j
         ZGEX3dJtT0KBwuoATjU+uQJ+EhyfPJDMdWqvojJ4dtpFUPAjzxqyzqLbrP2vFRkAvYJj
         IHKiJG2b1z5n/eCUZXvbWENufnrY7f64nqCSZBBZehgxDAs5MShc0gA6GNDU4NWbg7qt
         DhDqDaq+TTWVtaeQoiZnBKuWIEWrX8bNg8Litr02tmdzLuT7Mwo7ADUt7eeQ4c5iktZP
         vR42XoDshIdJeslsSQVvd2noSKRPeM+1zT3pOrQDlFMGOMcgVfXQdGB4piKiGKqWcgvp
         9rFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=vkycP8u9l6vmE3KtVqoHMsDNThOfF3txbXdbiX22u0o=;
        fh=5nZn0HRpP9ZszniLRQU6Iy8lvPX91CYXGnNouZ7Jmpo=;
        b=V4DHucFBOr23Dl3Nv40qy4YckUI1+VDt+Nc2RcEsLmlLP8ntQIpALv+RtjKQED6lcL
         j6OdXojwJUAauUp7eHgPwczLPAMC7GDh3FaB3c5YATV7ZQmTitSTIDt+10OP7MkEytGA
         lmyQyxYkelW2fDI239+OfiFVwnpHR6mY9rqoSVO33vOPXBzp30Dp4JivcyJiHQroH/EP
         3/KWl8f8Iw+Fp7G0QaabD5GB8X0uik2DfQxfszT3gRur1FDllSBNqAjxNEg9DzhGRaXN
         bGKFDHHlFYkC6OJ6HbgCF7KWRU/6Ik20nRIlYbfBI21DYUqbtHqxjAlCp7EnbrQIEn8X
         I3nw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786349193; x=1786953993; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=vkycP8u9l6vmE3KtVqoHMsDNThOfF3txbXdbiX22u0o=;
        b=WeUWKLzUVDf20lqZdAojFFbFUA8l/1uhWfgV5WrQQuzoXPcJNsyiY9VrnkGUq9a6EP
         DOzkigO6RIJQqcxeImpBJX8TUP1bBF/osLR+/oErzt0Gf056CdtFqW14dc6JzFZ90y8s
         alupAwKRFdoqzSEqZ8JHMR2O2tSRYDvu810CTpI5kE8+v0yrNuCg+hZoQO/V+tsrR86d
         ZoNC78v7n+tjVHzvP5qPpSrVyk9ysUhcWOl16kFP6KxHTH0MuQsXj+b8+ZrbSLen3OOu
         dfyBCFF+K6WceifE3aeWa8fMN9/cwKeZSWGeKEODIQHp2ZCalQg9PsZ/QlNiHRz5RnlD
         TIlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786349193; x=1786953993;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=vkycP8u9l6vmE3KtVqoHMsDNThOfF3txbXdbiX22u0o=;
        b=kVF/4vdOzz6WiS70ZK+pz+uGl0zSXqOFD1WCTNP493EeBXokEZU8Zs0MSet44LI+cK
         Xv+6fGQ+rBZr9mho5sq7mF0iGCo+F4KcZ4B2szPTbDlVrjYczQ8tTWTeVChhpyS5PsUU
         7kfemBC9pgs+M3+VW2AKETzVgUsWNHdLlBAjcM8tQ7uZRr81FRqXDwsi4vHwE+NtCdMH
         kabRZL3LQYwp0YHtUobjz9wkQCKHxu5+PAndgG+vkpRqDyel/Nd/DoHpA6l4lZ0nvA11
         1ejR3mn1YKoSWeKYUfMWPJqNW7gG3UW6uWEH64RRTuip33vpAcUlGU5ok1VoreKxnFLa
         R7rA==
X-Gm-Message-State: AOJu0YzKFgIZ2AAf8Aa9+qR1euOD/hODfIA298SyG29cXzQL97ip4sXM
	FvA2fRC9IAwTkb94KrpTA8CP3Hgqk/8L05qUfWy4+V+NOCZTrpz4XacMoDOXDojzqTs3wERblfc
	pDyYYvSt5UXOlD1fIx2NGJRDqnoX37TQ=
X-Gm-Gg: AR+sD13P1tRw0XwsNACiB45m3e7AZnqa42Hr6/RERUodHgdW+dYAMIPzzeNNBP9rgkI
	DqqKNZLatt7Fp7S3yDcRe/RnbTx2sxexOawsx6EfLMBmOK4OKJ8HAcG8G5i8hs3b6vmsX+YwZY/
	WJ4tFl5eEWJypFMxniMVkaf+m/nSp/jqFGlkV1ImFkbVWg7ikozc8hlU7gxPFRhSWG4EwZIBMSo
	3T0wMNI3JAOCnrAtCX8TdrIOHyYViKx7sOCEF6La2MGPB+PnS8I5d8NYdE+aLk3X8L5n8/nPy20
	xCjvVXHnhqF4Vmsyg+yCZK02eb2KSNAEJM9eoz2AO/+bwRzJgY3vpqRoqAUu/e1XcYFWgwQPkox
	nEFU6piZdczsVj+XR8lq4zVVeYdjDJHImuUddBJygPqyb6t7uaC0VmZuV5zld
X-Received: by 2002:a17:90b:5824:b0:38f:dec8:f7e9 with SMTP id
 98e67ed59e1d1-392824321admr18675960a91.12.1786349193043; Mon, 10 Aug 2026
 01:06:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260710085137.4171240-1-christian.couder@gmail.com>
 <20260807135511.1818458-1-christian.couder@gmail.com> <xmqqjyq1eqah.fsf@gitster.g>
In-Reply-To: <xmqqjyq1eqah.fsf@gitster.g>
From: Christian Couder <christian.couder@gmail.com>
Date: Mon, 10 Aug 2026 10:06:21 +0200
X-Gm-Features: AUfX_mz4BlbANZw4k_QyVFzo8c2lDXD5dHQvRUzccRQjCpI3nWGK9Vwoa6G3o2E
Message-ID: <CAP8UFD1LxM1s-MJuffhVks6JfBXoMzKii4YU4iQRNzXJZCQkfQ@mail.gmail.com>
Subject: Re: [PATCH 0/5] Introduce 'uploadpack.lazyFetchTrusted'
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, "brian m . carlson" <sandals@crustytoothpaste.net>, 
	Patrick Steinhardt <ps@pks.im>, Karthik Nayak <karthik.188@gmail.com>, Jeff King <peff@peff.net>, 
	Elijah Newren <newren@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 7, 2026 at 8:31=E2=80=AFPM Junio C Hamano <gitster@pobox.com> w=
rote:

> >  Documentation/config/uploadpack.adoc  |  42 ++++++++++
> >  Documentation/git-upload-pack.adoc    |   5 ++
> >  Documentation/git.adoc                |   4 +-
> >  builtin/upload-pack.c                 |  11 +++
> >  promisor-remote.c                     |  76 ++++++++++--------
> >  setup.c                               | 108 ++++++++++++++------------
> >  setup.h                               |  28 +++++++
> >  t/t5710-promisor-remote-capability.sh |  70 +++++++++++++++++
> >  upload-pack.c                         |  37 +++++++++
> >  upload-pack.h                         |   3 +
> >  10 files changed, 304 insertions(+), 80 deletions(-)
>
> What's missing is the information on the base.  I tried applying
> these patches to 'v2.55.0' and the recent tips of 'master':
>
>     2c78326f81 The 11th batch
>     5b2471720c The 10th batch
>     a97fcc37c2 The 9th batch
>     13c7afec21 The 8th batch
>     9a0c4701dc The 7th batch
>     5d2e770923 The 6th batch
>     48bbf81c29 The 5th batch
>     41365c2a9b The 4th batch for Git 2.56
>     d35c5399e3 The 3rd batch for Git 2.56
>     55526a1826 The 2nd batch for Git 2.56
>
> but the series did not apply to any of them.
>
> It turns out the reason has nothing to do with your choice of
> base.  It is because the series structure is not understood by 'b4'.
>
> The cover letter I am responding to is a reply to another series,
> but the patches in this round are not marked as 'v2'.  This seems
> to cause 'b4' to grab patches from both series and smash them
> together, resulting in an inapplicable mess.  It seems you cannot
> have your cake and eat it, too =F0=9F=98=A0.

I guess b4 should have, or grow, an option for that, because it's not
uncommon that someone would post an alternative patch or patch series
in reply to some patch(es).

> Next time, please do not thread the two topics together unless you
> are marking the newer iteration with a higher 'vN' number.

Ok, I will not do that. I will start a separate thread. Now I hope it
will work if I send a v2 in reply to the latest series.

Thanks.
