Received: from mail-4317.proton.ch (mail-4317.proton.ch [185.70.43.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6710F6AA7
	for <git@vger.kernel.org>; Sun, 20 Oct 2024 17:19:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729444745; cv=none; b=j+yxHsnHfkrQjSRStrTd9bgbi56jLFoOIVxg85lPC6KXpY4/W/cm6+npC+GWwsf9bIl+ajKkpzSA4dM1ji+vAGfFdJ7f3P0m7EWqkBujQTTjXJyKsT0s0K+H9ulemWbklYlBrDdfOgSKYaDgejctTfQgs8DlkdnGNkTpkttOIHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729444745; c=relaxed/simple;
	bh=yjR1oh5QaqADPytNJ+9/5ef7J0hzGyGbTOlq/j0xzFc=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=M57128WqDyCJWDbRW0C3nzMU6ZESTjncwghZQRGIy4nO8MhBoGdRWMhOhR+xP9DuILmO9wrtvLNjLMqESLp3A8myIV2H5icU0fzR7egAcNHi+R4YmoIblwPUhOInROsnHvbAIWcsdC/w0z2S31AxBfTgw5JzMzkRtoLGj2nuTsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kmatsui.me; spf=pass smtp.mailfrom=kmatsui.me; dkim=pass (2048-bit key) header.d=kmatsui.me header.i=@kmatsui.me header.b=FXvA+ik/; arc=none smtp.client-ip=185.70.43.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kmatsui.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kmatsui.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kmatsui.me header.i=@kmatsui.me header.b="FXvA+ik/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kmatsui.me;
	s=protonmail2; t=1729444734; x=1729703934;
	bh=LrDly34yPIgEbd71+c2wWaY1xrrDivGD0UPwCBpGnrw=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=FXvA+ik/jsvsm0jMffRQ9uNUL7jsxGXnMuffMYGKpm74v7DtyL9T2ilriI8zdhGEm
	 2bkuobWt2PhM7bQxLkIiZ/csv4w6iVe45PLVTgrI/DCZEDX2j99yn22PuGFHA+qnkD
	 UVTd4O8UEFEfIlZW/Bkc/ROTiEeq9tNMXYm+WbYuqap38EuyptsA23rKc/GYPrDtAT
	 7/N87juIl3klKG81jlYW4kk41wTDEgu9J5i2yc8ntozLa+sia80VHTpruAetAr7EOi
	 KUra4T83vrWF0hwdsZRnNUW/l6D3xboC+qAF+qLpL9W/z9R5jBhjowSTxue6F/vdei
	 k6aZSTMMZkTDg==
Date: Sun, 20 Oct 2024 17:18:51 +0000
To: Ramsay Jones <ramsay@ramsayjones.plus.com>
From: Ken Matsui <ken@kmatsui.me>
Cc: git@vger.kernel.org, Matheus Tavares <matheus.tavb@gmail.com>, Glen Choo <glencbz@gmail.com>, Elijah Newren <newren@gmail.com>, Jonathan Tan <jonathantanmy@google.com>, =?utf-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>, Victoria Dye <vdye@github.com>, Patrick Steinhardt <ps@pks.im>, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] config: support remote name in includeIf.hasconfig condition
Message-ID: <EEsVJheBDeI0kEJr8KABt7dw0F14feUrMlvzJsmzrGmUBwt19aSJd4iWClSlzQ1GSoIe6qMQ5OcoiWYF9LQDPu-26QWmDy57efnYaZX6ZSo=@kmatsui.me>
In-Reply-To: <086ff955-bcdf-4aba-b6d4-c87f6fc6a724@ramsayjones.plus.com>
References: <20241020152323.90543-1-ken@kmatsui.me> <20241020160143.92382-2-ken@kmatsui.me> <086ff955-bcdf-4aba-b6d4-c87f6fc6a724@ramsayjones.plus.com>
Feedback-ID: 103884984:user:proton
X-Pm-Message-ID: ffccf80d83b62acb01001f39b1df0b9ae9f311a5
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Sunday, October 20th, 2024 at 12:21 PM, Ramsay Jones <ramsay@ramsayjones=
.plus.com> wrote:

>=20
>=20
>=20
>=20
> On 20/10/2024 17:01, Ken Matsui wrote:
>=20
> > Changes in v2:
> >=20
> > * Updated the description based on Kristoffer's review.
> >=20
> > -- >8 --
> >=20
> > includeIf.hasconfig only accepts remote.*.url, making it difficult to
> > apply configuration based on a specific remote, especially in projects
> > with multiple remotes (e.g., GitHub and non-GitHub hosting). This often
> > leads to undesired application of multiple config files.
> >=20
> > For example, the following configuration:
> >=20
> > [remote "origin"]
> > url =3D https://git.kernel.org/pub/scm/git/git.git
> > [remote "github"]
> > url =3D https://github.com/myfork/git.git
> >=20
> > [includeIf "hasconfig:remote..url:https://github.com/**"]
> > path =3D github.inc
> > [includeIf "hasconfig:remote..url:https://git.kernel.org/**"]
> > path =3D git.inc
> >=20
> > would apply both github.inc and git.inc, even when only one config is
> > intended for the repository.
> >=20
> > Introduce support for specifying a remote name (e.g., origin) to enable
> > more precise configuration management:
> >=20
> > [includeIf "hasconfig:remote.origin.url:https://github.com/**"]
>=20
>=20
> s/remote.origin.url/remote.github.url/ ?
>=20
> I haven't actually read the patch, so take with a pinch of salt. :)

Actually, this should be as-is.  The configuration means only if
the GitHub URL is used for origin, we include github.inc.  In this
repo, we won't include github.inc and only include git.inc for
whatever reason.

Thank you!

>=20
> > path =3D github.inc
> > [includeIf "hasconfig:remote.origin.url:https://git.kernel.org/**"]
> > path =3D git.inc
> >=20
> > This ensures that only the intended config file is applied based on the
> > specific remote.
>=20
>=20
> ATB,
> Ramsay Jones
