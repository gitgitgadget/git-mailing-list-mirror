Received: from smtp2-g21.free.fr (smtp2-g21.free.fr [212.27.42.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D64A3C099
	for <git@vger.kernel.org>; Wed, 21 Feb 2024 22:06:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.27.42.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708553168; cv=none; b=koHOrjpDixKpOvOjltOGiS01+S/rLS9qmvqIdbCwaKtnwx6S2h1+QULuVxp6aFNaGK5boAiZmZGlhoA0lG5FqnLLGiUnJH1Mr103QQ8oTu2bbGy3Q/rvOFwAjOmCPSflG7XzbJID/hkhpFj5okBNywWDW4k65LhhwTcGnOY90Ts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708553168; c=relaxed/simple;
	bh=M2kYU4okqa+oCwScygnPRQuMmu/VlT0uLApiqs0P2Mw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YSGLko+EAqkn5ZiY9NFbvXgUtgtDuH1u5oZxjzOS4+M+9uWPyv4Gfx8OFlh6fDSjMAC6jIgb3RRNhgF3rgVhTr3Ll5DPtamLP5f2nxQ/7nJ2KYSZGP3Sbqec8dI905Cj4PfznJViARZa58vzyu3LnYEkXkABARAOHGst4cQg/cw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=free.fr; spf=pass smtp.mailfrom=free.fr; dkim=pass (2048-bit key) header.d=free.fr header.i=@free.fr header.b=sXjGjS3O; arc=none smtp.client-ip=212.27.42.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=free.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=free.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=free.fr header.i=@free.fr header.b="sXjGjS3O"
Received: from cayenne.localnet (unknown [IPv6:2a01:e0a:d1:f360:9bca:a380:8169:3a3f])
	(Authenticated sender: jn.avila@free.fr)
	by smtp2-g21.free.fr (Postfix) with ESMTPSA id 5BC522003CC;
	Wed, 21 Feb 2024 23:05:57 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
	s=smtp-20201208; t=1708553161;
	bh=M2kYU4okqa+oCwScygnPRQuMmu/VlT0uLApiqs0P2Mw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=sXjGjS3OookvANDX3v/SKJ/KdvyHD9hRZHeVVJEDyKf6bCWnDB+bXTCXJufNlLhA1
	 Jg2joDv5oNF+tHzGhJu9b20Z+WVl637Ru59D/C0JKTkJymIlRL1Sj+yZ3JTspegYaa
	 lN8TbsWLK40wkZrEbHUrsj86LVeYSihcei3+wT/37BBH2pUreCQ0qKzXjZvh6ZmIm8
	 ApgDyTHCgnNdGA6FMPdLFgU68nlMrmUWEjCaWCo3VSQQuVzT7yBsdL+Z5CgTP+b6jC
	 ondildLzin8BY5BxAGv2JeXi8unA2niR8gtjipA8n7TYHMVXHF/AMhxOgA/FTH+D9E
	 Z5+CcvmZqTB8w==
From: =?ISO-8859-1?Q?Jean=2DNo=EBl?= AVILA <jn.avila@free.fr>
To: Junio C Hamano <gitster@pobox.com>,
 Michal =?ISO-8859-1?Q?Such=E1nek?= <msuchanek@suse.de>
Cc: Harmen Stoppels via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org, Harmen Stoppels <me@harmenstoppels.nl>
Subject: Re: [PATCH] rebase: make warning less passive aggressive
Date: Wed, 21 Feb 2024 23:05:56 +0100
Message-ID: <2324063.ElGaqSPkdT@cayenne>
In-Reply-To: <20240221183018.GB9696@kitsune.suse.cz>
References:
 <pull.1669.git.1708442603395.gitgitgadget@gmail.com>
 <xmqqjzmxofvn.fsf@gitster.g> <20240221183018.GB9696@kitsune.suse.cz>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"

On Wednesday, 21 February 2024 19:30:18 CET Michal Such=C3=A1nek wrote:
> On Wed, Feb 21, 2024 at 10:02:04AM -0800, Junio C Hamano wrote:
> > Junio C Hamano <gitster@pobox.com> writes:
> >=20
> > > Michal Such=C3=A1nek <msuchanek@suse.de> writes:
> > >
> > >> Or if it does touch the po files it could as well update the
> > >> translations.
> > >>
> > >> There are changes that can be trivially translated without any=20
knowledge
> > >> of the target language.
> > >
> > > You need to know the target language before deciding it is OK and
> > > sufficient to just remove =CC=89=C2=BF? from around a sentence to mak=
e it from
> > > a question to a statement of a fact.  You may know enough, but
> > > reviewers may not be.  In addition, it would allow bypassing the
> > > language teams, which is the most serious problem I see in such an
> > > attitude.
> >=20
> > Oops, "attitude" -> "approach".
>=20
> That's certainly true that even if you know how to remove a question
> mark you may not find a reviewer who knows how to remove one.
>=20
> Nonetheless, if you do find both a patch author and a reviewer that know
> how to remove a question mark what is the problem with not involving
> several language teams to remove a question mark?
>=20
> Thanks
>=20
> Michal
>=20
>=20

As a translator, I'm less bothered by editing a sentence to remove a questi=
on=20
mark (maybe enforcing a language style and reformulating the sentence by th=
e=20
way), than by translating again and again similar sentences.

Thanks

JN



