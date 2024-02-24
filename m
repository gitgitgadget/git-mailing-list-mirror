Received: from smtp6-g21.free.fr (smtp6-g21.free.fr [212.27.42.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59B8814B820
	for <git@vger.kernel.org>; Sat, 24 Feb 2024 18:28:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.27.42.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708799337; cv=none; b=G+RmJxxXu0K05/juthmObmJ69nIXyzdyosy944JMdDXQxZdjZ+fYCsCqfymKovpqPZS82W/8d5d3VBgN0u6GOKcHvUO6IBN6UqbKcqP9/84QLjHOKT9nntZ9ttysguSAdTs4C3ocUQ4kI0+TFWwU512efNzSc2M7UsLFVwy60SY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708799337; c=relaxed/simple;
	bh=V9DJjqfvH0o6B0Q/9ism/ggyrxR9kIPKKeWFOUmEiTw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jpmqeyJYBgRvhlammaEVeH2xiAJ8do/uuFxgz3sBOpEFT+BLpMA3NIqUtJrUumlAmP0u0vJQFsyKSANDpBqwmFiMme3spJdxQdHoigNpeqebghzEioaffv5zSIAOhhdmBA1sZWyp5xDkOqSqAbvNphQQhReXyE8ADboA8FaAwIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=free.fr; spf=pass smtp.mailfrom=free.fr; dkim=pass (2048-bit key) header.d=free.fr header.i=@free.fr header.b=Q5QAyXsg; arc=none smtp.client-ip=212.27.42.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=free.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=free.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=free.fr header.i=@free.fr header.b="Q5QAyXsg"
Received: from cayenne.localnet (unknown [IPv6:2a01:e0a:d1:f360:7b3d:93cf:40c:f182])
	(Authenticated sender: jn.avila@free.fr)
	by smtp6-g21.free.fr (Postfix) with ESMTPSA id 4DB3978035B;
	Sat, 24 Feb 2024 19:28:46 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
	s=smtp-20201208; t=1708799328;
	bh=V9DJjqfvH0o6B0Q/9ism/ggyrxR9kIPKKeWFOUmEiTw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Q5QAyXsgPnC3BOzU5eW3Q4l65eejJbyL0t2zTwlGtLe8r3khRC6/1FcOSmUvl8orN
	 09rxJC2xErDtiiV4b5hQ/5ELr+Jc+mzUYc+Z/on6ZXwsGQjCBdCFD7aqA7na444KRF
	 OiI9ObAfwsTqGuNzaVeAE6dSLVnkD/JZSKdZttqGcqhEojloEOMGgyVCwFIHntgGFU
	 AfeJl0edz0J9ro9Sh0EmI4gYrHhf1Dh1HHVroA/BWT7vEXpYTF4aYbacbUOJkDafQv
	 CqPMTttmPHlxffnf2TFtbEW4p4+EQgFy1+WtRcckzrunhpklvTtdWfEDn685mW5dTD
	 f1cxZrbSTcY6Q==
From: =?ISO-8859-1?Q?Jean=2DNo=EBl?= AVILA <jn.avila@free.fr>
To: Junio C Hamano <gitster@pobox.com>
Cc:
 =?ISO-8859-1?Q?Jean=2DNo=EBl?= Avila via GitGitGadget
 <gitgitgadget@gmail.com>, git@vger.kernel.org
Subject:
 Re: [PATCH 1/3] doc: git-rev-parse: enforce command-line description syntax
Date: Sat, 24 Feb 2024 19:28:45 +0100
Message-ID: <6079595.lOV4Wx5bFT@cayenne>
In-Reply-To: <xmqqr0h4h2sz.fsf@gitster.g>
References:
 <pull.1670.git.1708468374.gitgitgadget@gmail.com>
 <2926790.e9J7NaK4W3@cayenne> <xmqqr0h4h2sz.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"

On Thursday, 22 February 2024 17:38:36 CET Junio C Hamano wrote:
> Jean-No=EBl AVILA <jn.avila@free.fr> writes:
>=20
> >> So, perhaps we do not have to do a lot of 'word' -> _word_
> >> replacements, hopefully?
>=20
> > ... At least, we=20
> > should try to stick as much as possible to the common markup _ for=20
emphasis.
>=20
> OK, that clears up my confusion.  Thanks.
>=20
> We do not want to rely on an external party indefinitely maintaining
> what they consider backward compatibility wart, so the mark-up migration
> would need to happen before it becomes too late.
>=20
> > This would have the added benefit of differentiating single quotes from=
=20
> > backticks, because single quotes would completely disappear in the end,=
=20
except=20
> > when a real single quote is needed.
>=20
> Given enough time, yes.  Or we can actively disable AsciiDoctor's
> compatibility mode and/or tweak asciidoc.conf to do the equivalent
> for AsciiDoc, to start early.  Until then, we cannot really use "a
> real single quote", right?

The logic for managing single quotes as markup is that there should be a wo=
rd=20
boundary at the quote <SPC>'<letter> for opening and <letter>'<SPC> for=20
closing, whereas for "real single quote" there's no space. This rule is=20
"natural" when writing in English and writers don't pay attention.

>=20
> > For the migration to "standard" asciidoc, I would also recommend using =
"=3D"=20
> > prefix for titles instead of underlines which require changing two line=
s=20
when=20
> > modifying  a title and are a pain for translators in languages with=20
variable=20
> > width characters.
>=20
> I personally strongly prefer the underline format because I care
> about readability of sources, but that is just me.  Is that also
> getting deprecated?
>=20

The underline format is bound to be deprecated. Right now, Asciidoctor dete=
cts=20
this formatting to infer a switch to compat-mode. That's why markup-quote=20
works as expected with Asciidoctor in current documents.

> Thanks.
>=20
>=20




