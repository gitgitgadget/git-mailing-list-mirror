Received: from mail-0301.mail-europe.com (mail-0301.mail-europe.com [188.165.51.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 919EE1C27
	for <git@vger.kernel.org>; Sun, 20 Oct 2024 17:30:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.165.51.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729445445; cv=none; b=Utv3+DN06BibEOH5J4VH/M9gkC2sWt1TBNc748ucBpb7pihOwDlvmiTmx6LVZY4vRryRWI+AxcR3r0iTUyFYKkWTVOEk7DfdR7wIhQTafaXhmiSEm6Zw/+WISaYFNs1yMoAwe5DrXoBVaVfNCCDvwtRzU80MBj0OZgAv5W45Lrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729445445; c=relaxed/simple;
	bh=hmWgnoQTajUvW5DGflh3F3PUTbkUh8HYVrKEIrj/Lb8=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=C7hRnA7YxuptLti871eVASshVTPt19iT5mVRyOGlmZvJGAOtxC8x4Q3RpPjKZ3vVXNh4O8UQVghM2+uvsTZWQZgLHrB+2I4EtCtD/u0OX8avyZLrhj4t0nKXn+en79HiTRf0+2hjdTWDFLcF6a4bHZiSXc9llD2W/BO2e/7PPrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kmatsui.me; spf=pass smtp.mailfrom=kmatsui.me; dkim=pass (2048-bit key) header.d=kmatsui.me header.i=@kmatsui.me header.b=N566+1DC; arc=none smtp.client-ip=188.165.51.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kmatsui.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kmatsui.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kmatsui.me header.i=@kmatsui.me header.b="N566+1DC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kmatsui.me;
	s=protonmail2; t=1729445433; x=1729704633;
	bh=hmWgnoQTajUvW5DGflh3F3PUTbkUh8HYVrKEIrj/Lb8=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=N566+1DCKd/Vy9JbDEuoditwI+7Ea9ALNf1hGpa1rLZNceslBs7hx0coBU3BePgCg
	 uFSZjdO4SnUGNlBzhThIjPXBBoDN366dQ5DQc08sSMdXUx3m5VbCVFkRXw/y4BmkuP
	 tIti9p/K06OB+a6O0eifbSfbwRpzswtRD9+40GGmLYjHDWDmdqCwqqnOrJ+bqpdJNO
	 QJrkKlMx+T4klT4ynCl4qqtLXTE9fcFlvyEm2Sp/KuQMkagIFDZo7dgfjOEJWPHXpG
	 i802ybTtl8epZjJAT6jb5k9HTqnGntvu2LsK8v7syMczLBfnwVAUKvmAtpxYDQzxJm
	 Yo/tkJVo85pwA==
Date: Sun, 20 Oct 2024 17:30:28 +0000
To: Ramsay Jones <ramsay@ramsayjones.plus.com>
From: Ken Matsui <ken@kmatsui.me>
Cc: git@vger.kernel.org, Matheus Tavares <matheus.tavb@gmail.com>, Glen Choo <glencbz@gmail.com>, Elijah Newren <newren@gmail.com>, Jonathan Tan <jonathantanmy@google.com>, =?utf-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>, Victoria Dye <vdye@github.com>, Patrick Steinhardt <ps@pks.im>, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] config: support remote name in includeIf.hasconfig condition
Message-ID: <3QE-ZkcELIkznxtQD_EXgNaoyGwIe26lO2RJ8S2qnqcD1T1tcKWuvxgVaV_WxLooZMVld4wEJdkhbQD1HK494wbc52rrqzkbvPKHaosr8v0=@kmatsui.me>
In-Reply-To: <EEsVJheBDeI0kEJr8KABt7dw0F14feUrMlvzJsmzrGmUBwt19aSJd4iWClSlzQ1GSoIe6qMQ5OcoiWYF9LQDPu-26QWmDy57efnYaZX6ZSo=@kmatsui.me>
References: <20241020152323.90543-1-ken@kmatsui.me> <20241020160143.92382-2-ken@kmatsui.me> <086ff955-bcdf-4aba-b6d4-c87f6fc6a724@ramsayjones.plus.com> <EEsVJheBDeI0kEJr8KABt7dw0F14feUrMlvzJsmzrGmUBwt19aSJd4iWClSlzQ1GSoIe6qMQ5OcoiWYF9LQDPu-26QWmDy57efnYaZX6ZSo=@kmatsui.me>
Feedback-ID: 103884984:user:proton
X-Pm-Message-ID: 6037f23d12a8be9a3b5baed6a58043a3d58080cc
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Sunday, October 20th, 2024 at 1:18 PM, Ken Matsui <ken@kmatsui.me> wrote=
:

>=20
>=20
> On Sunday, October 20th, 2024 at 12:21 PM, Ramsay Jones ramsay@ramsayjone=
s.plus.com wrote:
>=20
> > On 20/10/2024 17:01, Ken Matsui wrote:
> >=20
> > > Changes in v2:
> > >=20
> > > * Updated the description based on Kristoffer's review.
> > >=20
> > > -- >8 --
> > >=20
> > > includeIf.hasconfig only accepts remote.*.url, making it difficult to
> > > apply configuration based on a specific remote, especially in project=
s
> > > with multiple remotes (e.g., GitHub and non-GitHub hosting). This oft=
en
> > > leads to undesired application of multiple config files.
> > >=20
> > > For example, the following configuration:
> > >=20
> > > [remote "origin"]
> > > url =3D https://git.kernel.org/pub/scm/git/git.git
> > > [remote "github"]
> > > url =3D https://github.com/myfork/git.git
> > >=20
> > > [includeIf "hasconfig:remote..url:https://github.com/"]
> > > path =3D github.inc
> > > [includeIf "hasconfig:remote..url:https://git.kernel.org/"]
> > > path =3D git.inc
> > >=20
> > > would apply both github.inc and git.inc, even when only one config is
> > > intended for the repository.
> > >=20
> > > Introduce support for specifying a remote name (e.g., origin) to enab=
le
> > > more precise configuration management:
> > >=20
> > > [includeIf "hasconfig:remote.origin.url:https://github.com/**"]
> >=20
> > s/remote.origin.url/remote.github.url/ ?
> >=20
> > I haven't actually read the patch, so take with a pinch of salt. :)
>=20
>=20
> Actually, this should be as-is. The configuration means only if
> the GitHub URL is used for origin, we include github.inc. In this
> repo, we won't include github.inc and only include git.inc for
> whatever reason.
>=20
> Thank you!

I will soon update this patch's description and add more tests to avoid thi=
s kind of confusion.

>=20
> > > path =3D github.inc
> > > [includeIf "hasconfig:remote.origin.url:https://git.kernel.org/**"]
> > > path =3D git.inc
> > >=20
> > > This ensures that only the intended config file is applied based on t=
he
> > > specific remote.
> >=20
> > ATB,
> > Ramsay Jones
