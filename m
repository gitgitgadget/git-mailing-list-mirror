Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEFE8366052
	for <git@vger.kernel.org>; Fri, 29 May 2026 17:56:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780077375; cv=none; b=uLT45hM2Cp7v+6aKnXf6jIw/rqeSoU/fVJ/or0w0Y6rg+eyYFXG8sRYz4/iOXhVWXxLU2uoQ0xTVoILP3hW7U7GUyOaB4YK7gr/uYRb0vFcHKQMaMB5nI07UJttjKrAAtxFsysTfc1djhd/79FZ99nqn0c82BbmtYKRF791Gi0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780077375; c=relaxed/simple;
	bh=vt+F5cSjRVuNV9hehzBy1gqMcU+Op6fX4Ob5833iw9s=;
	h=Content-Type:From:Mime-Version:Subject:Date:Message-Id:References:
	 Cc:In-Reply-To:To; b=ejFSUtfo08EoFq5x1tup4gzmYhylGUmGHdg+JlqMQbsGMy9fIpYBZnfYSVZEmmpAkSO2Ck4H90DZa7S2t2Iq89KWKQLJVtSsRwmU32VfuPbU8DdxVCk63XmzElNWd09JGvJpQ0qwiBo00fsKrqtZmAlv7lvLEYK8r73wCVvWFgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pPE1q67k; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pPE1q67k"
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-7e0743942f8so463907b3.3
        for <git@vger.kernel.org>; Fri, 29 May 2026 10:56:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780077373; x=1780682173; darn=vger.kernel.org;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:from:to:cc:subject:date:message-id
         :reply-to;
        bh=G5KPcTPL5f1eWjh0LFUAS//ME92h+ghd5pfJC8fb1Yw=;
        b=pPE1q67ksKBFPzBe4ZxZpussKrcs5zZOOhnUYtBl52BMbSQquMcLihucSCYkEB52Zu
         q2rLRv9Df36hmFmTLK7SJU0AHG6wGxajW4qEvkVQfGVA9Fi/Ip4rtoNQqmeNuF/XRF5I
         X+Q/1cDg4oma8j4+0jICTdJNVq5LplZt0cKLBviAebF6ur57Amn4QAj5uSItIIvBfNyW
         2kr9OXJ1FKIy3nsWhqp5zoFzuoW+08/aXwClEcbX9r3Ar8YPVRALOoWjqw4N67mN5MEy
         g8qtaD2by1MFbzNBnVWGgqNb5MPN8ukiZVpXiztLDSa+GJ5YpJVRFIt3RP9Yrp0z2vhb
         +hvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780077373; x=1780682173;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=G5KPcTPL5f1eWjh0LFUAS//ME92h+ghd5pfJC8fb1Yw=;
        b=pI3mgzowkwnO4xhcDHy1N0z2HJXxfSd0riWOFD28Lly4Ee4F9lfwPBmpuVAe0HFk57
         tU2VP8tnBt0ZMm70qdehMwAIIiZ7WP2iQk4GrwWj+2oOLna9AZgx3Ibu2/T+d9+ZJkSN
         10t/Dq0Dx0+AR3cafWTGUg7n4Etm6PIFim1YVv8dmfxe+AeCjsXix0xOn4c0IjOt5Nyu
         ocfGnUgDlPsdBk2FSt92gZCuDxDe8y5y7xoJ68aEOzkB4T3Cnd0ZIYM8QCnN8L271e/A
         9out55GoiPAxvPzgjkJu1/5psG0oOdWVBmJule4BV9ZScjHLwhgivaDorJ9a3oUerkgp
         wncA==
X-Gm-Message-State: AOJu0YyLO89kyoLDPqEPo3o47B9d1ZZ6s3JUKfyQ2cnXA/rn66SLxDQr
	IYH9JCdrIUXqE1oCTjdViklL1RHUgoCQ1pHIG16z+e7fiEy2mYtQ4lrhAhs6BRNL
X-Gm-Gg: Acq92OHH7Qdzb02pwQGDLxzpriondVtku1o+bP/m1n5tp81E19c+1PJNBXVLctVd1sE
	ny58yP+rpKxykl/rQSPv33DYIm1Hcy5V2VQQsuGh58F+cT+hIix1vn1raGHlkw+0B81DXkoBSjO
	tuR60OhyjoLErSeWeIDS7X3maluXW/KODoqjRyR7aaiI5irnM64pbsRvmJFUvW3dN5RXDYQ1J8H
	ocvVECH3xXmzR3nVoKz/uVgZ9uHhFqs1o9AwDKURqjRSSw8IJxb1RF71ZvYNgC/3Nqrk1x6NB6m
	jM/QHCgmjR+idapzYtHhRlcQ0brWvegWpGwdUCJ5YDK15ofjVvGnAjm1mYHXx2ePnlVEoJRax8H
	h12PKqVtc5w4Jxi4R9PZBovi1RgxO8pzWRMirJ7DCunJ73u6hpu6PQWMf/Smgorth2dp/iSk9jf
	dz6nS3eheXuz1cRiKPVMX3KxRpV48qx+moHSgIuH/7yydpx8/Ba9rYAtFUnS5UDElT09u29IYY1
	KRAneWaK6aZNhGMVsioBBlK5Hwr4iIE7T2VDFl5KjFB3J54YEkO/t0T
X-Received: by 2002:a05:690c:6011:b0:7bd:577f:56bf with SMTP id 00721157ae682-7e05d3f99d5mr3991797b3.33.1780077372968;
        Fri, 29 May 2026 10:56:12 -0700 (PDT)
Received: from smtpclient.apple ([2605:a601:90fb:c300:ec65:a111:cab6:a60d])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7de6ea5d99csm8560177b3.48.2026.05.29.10.56.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 May 2026 10:56:12 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From: Ben Knoble <ben.knoble@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (1.0)
Subject: Re: Suggetsions for collaboration workflows in large repos
Date: Fri, 29 May 2026 13:56:02 -0400
Message-Id: <82F556A1-A5C6-414E-8EFB-13F83FA30E44@gmail.com>
References: <20260529163117.z2auhbg4sdxxgmis@archP14s>
Cc: git@vger.kernel.org
In-Reply-To: <20260529163117.z2auhbg4sdxxgmis@archP14s>
To: Matthew Hughes <matthewhughes934@gmail.com>
X-Mailer: iPhone Mail (23D8133)


> Le 29 mai 2026 =C3=A0 12:47, Matthew Hughes <matthewhughes934@gmail.com> a=
 =C3=A9crit :
>=20
> =EF=BB=BFHi,
>=20
> I'm looking for some git workflow suggestions to help cut down on unnecess=
ary
> fetching when working in a large repo with many (hundreds) of other devs a=
nd
> thousands of branches. Specifically, if in this repo I use the common conf=
ig to
> just fetch all the remote heads:
>=20
>    $ git config set remote.origin.fetch '+refs/heads/*:refs/remotes/origin=
/*'
>=20
> Then I find I get a lot of noise from the all the branches being
> created/updated/deleted as well as an increase in the size of my local rep=
o due
> to all the objects I need to fetch across all those branches.
>=20
> To clarify the general performance of git in this repo is reasonable (shou=
tout
> to `scalar`) but I am interested in cutting down on this fetching since wh=
en
> working in this repo I'm generally only interested in a tiny subset of all=

> branches:
>=20
> 1. The `main` branch (that everyone merges into)
> 2. Any of _my_ branches
> 3. Occasionally, one of my colleagues branches, so e.g. I can check out th=
eir
>   code locally to review (most reviewing I do in the web UI, this is
>   GitHub)
>=20
> I have a prefix for all my branches: `mhughes-`, so to sort out just the
> first two points I can configure git to fetch `main` and references with t=
hat
> prefix:
>=20
>    $ git config set --comment 'fetch main' remote.origin.fetch '+refs/head=
s/main:refs/remotes/origin/main'
>    $ git config set --append --comment 'fetch my branches' remote.origin.f=
etch '+refs/heads/mhughes-*:refs/remotes/origin/mhughes-*'
>=20
> But then when I do want to check out a colleague's branch I need to explic=
itly
> fetch the exact ref like:
>=20
>    $ git fetch origin some-colleague-branch
>    $ git checkout FETCH_HEAD -b some-colleague-branch
>=20
> Which is ok (it's my current workflow), but it means I have to re-fetch th=
e
> exact ref if I want to bring in changes that they make after my initial fe=
tch
>=20
> I could add an explicit fetch of their branch like:
>=20
>    $ git config set --append remote.origin.fetch '+refs/heads/some-colleag=
ue-branch:refs/remotes/origin/some-colleague-branch'
>=20
> So that each `git fetch` also brings in updates to that branch, but in the=

> remote we delete branches once their changes are merged, so if I leave tha=
t
> config I'll eventually (once they merge their change and delete the branch=
) run
> into errors when fetching like:
>=20
>    fatal: couldn't find remote ref refs/heads/some-colleague-branch
>=20
> Does anyone have suggestions to make this smoother? Or alternative workflo=
ws
> for achieving this goal? I'd also be curious to hear about other approache=
s
> people take went working in large repos with lots of other collaborators.
> Or am I just using git wrong in a repo like this, and should adopt another=

> approach?
>=20
> I thought about doing something like tracking
> `refs/heads*/some-colleague-branch` from the remote, since with the wildca=
rd
> `*` I at least won't the fatal error on the missing reference during fetch=
, but
> that risks my config containing an ever growing list of such wildcards, or=
 a
> bunch of manual work occasionally cleaning up old ones (or maybe that coul=
d be
> automated).
>=20
> Thanks,
> Matt

My current advice is to enable git-maintenance on such a repo, where prefetc=
hes and commit graphs and so on will give you a nice perf boost. Then I keep=
 the default fetch all heads config and don=E2=80=99t mind the noise too muc=
h.=
