Received: from smtp3-g21.free.fr (smtp3-g21.free.fr [212.27.42.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 271EF1E7C05
	for <git@vger.kernel.org>; Wed, 20 Aug 2025 21:00:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.27.42.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755723622; cv=none; b=RY3KaWea5uyZMPxHZxBJzy7QZLee6VG5xCV/RkK9Vd2UQFuOKgKJiXD6f6aExhacWHF/C2EPOGjwFOas2QYXLrH9+5UCnCnFjZnTt2Axt9gAoi8tIEv8dqfuM48dDVbiY+kuDwkTE7kYaBISL0RHhJkAbxcj7LejkvW7ZVieoQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755723622; c=relaxed/simple;
	bh=xbJaTZIYvrkQkSxzZN86Ak7JBEVDH1+g+i0Cp1sxTYY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=U76L08RnLhA1BEEomzv4H2LU05dE7ep0hrQnWtgSdg8A0f5falIUCMp8wGRL4DjhFlp4NcqDAsiv+ryInaoI9xkprP2c5S5be4hvbMXMuAsG4uudhlsx9qjdlksHm1rbPAaW5SAM6uGrNo8oLEDpImY9Wv8RdggmcN/4iTwuH68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=free.fr; spf=pass smtp.mailfrom=free.fr; dkim=pass (2048-bit key) header.d=free.fr header.i=@free.fr header.b=ULXGxF9w; arc=none smtp.client-ip=212.27.42.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=free.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=free.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=free.fr header.i=@free.fr header.b="ULXGxF9w"
Received: from cayenne.localnet (unknown [IPv6:2a01:e0a:d1:f360:76fa:3ccb:8c02:b888])
	(Authenticated sender: jn.avila@free.fr)
	by smtp3-g21.free.fr (Postfix) with ESMTPSA id 4310813F879;
	Wed, 20 Aug 2025 23:00:14 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
	s=smtp-20201208; t=1755723617;
	bh=xbJaTZIYvrkQkSxzZN86Ak7JBEVDH1+g+i0Cp1sxTYY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ULXGxF9wOYq1vmLcuMhafBe73Sv994vas/hGTEukNuCcfCMwa9Bkc54i0vUJn+1Gh
	 bM7sDM0Wz/qHtEswyFS+n+ovBeSKezKzQz4MK/DtDox2hGUWwfVmxSTVyV0LlzyauJ
	 J7Wiiol86cq7mtGMupsgEL9WcuNGuRlbop3ao1Pzv8aZCoz3oHtq+OS9Nm612wUGG4
	 vI6f3jzwjSv846lZF6D02JJY9WJh3tGbpwZgTyxnPILp2Fz9SgmmefFzdyywyhTCai
	 WjT5Nz7Hv61r0mNUKw7A+Q8F0eR3YkGjnA3oKcFGsEbv/aSI1Ij5Q1q0lfWhA431uz
	 IKbtAtmlOLNQA==
From: =?UTF-8?B?SmVhbi1Ob8OrbA==?= AVILA <jn.avila@free.fr>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org,
 Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
 SZEDER =?UTF-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
Subject:
 Re: [PATCH] doc: fix asciidoc format compatibility in pretty-formats.adoc
Date: Wed, 20 Aug 2025 23:00:13 +0200
Message-ID: <4673610.LvFx2qVVIh@cayenne>
In-Reply-To: <xmqqa53vc77z.fsf@gitster.g>
References:
 <aKJJs7OkBIg7Y9J0@szeder.dev> <20250819212340.73886-1-jn.avila@free.fr>
 <xmqqa53vc77z.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

On Tuesday, 19 August 2025 23:49:36 CEST Junio C Hamano wrote:
> Jean-No=C3=ABl Avila <jn.avila@free.fr> writes:
> > Asciidoc.py and Asciidoctor do not process the same '+' verbatim syntax=
 in
> > the same way. For most usages, Asciidoctor requires a double '+'.
>=20
> The word "same" on the first line is probably unwanted?
>=20

Definitely. Rerolled in V2.

> > Unfortunately, the postprocessing of verbatim synopsis in asciidoctor=20
cannot
> > be bypassed and formatting of the parentheses is forced in syntax sign
> > instead of keywords, unless a proper grammar analyzer is used.
>=20
> Sorry, I've read the above three times, but it would not explain why
> the change is needed for the "prefix" line, but no change is needed
> for the "suffix" line or for the "separator" line, even though they
> look quite similar.  Is open-parenthesis somehow special?  And '>'
> also special in the same way?

The detection of opening of spans in Asciidoc is driven by a span markup=20
character (here '+') preceded by a non-word character. The condition is=20
symmetrical for closing of spans. I haven't dug into the source code, but i=
t=20
seems that asciidoc.py considers '{nbsp}' as a non-word character, whereas=
=20
Asciidoctor does not.

Using double markup characters creates 'unconstrained' spans, which do not=
=20
need the non-word character condition.

Note also that this "feature" is very centric on roman based languages (lik=
e=20
many of light markup design decisions) and is a pain in other writing syste=
ms=20
which do not require space between words.

>=20
> > Signed-off-by: Jean-No=C3=ABl Avila <jn.avila@free.fr>
> > ---
> >=20
> >  Documentation/pretty-formats.adoc | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >=20
> > diff --git a/Documentation/pretty-formats.adoc
> > b/Documentation/pretty-formats.adoc
> > index 9ed0417fc8..618ddc4a0c 100644
> > --- a/Documentation/pretty-formats.adoc
> > +++ b/Documentation/pretty-formats.adoc
> > @@ -233,11 +233,11 @@ colon and zero or more comma-separated options.=20
Option
> > values may contain>=20
> >  literal formatting codes. These must be used for commas (`%x2C`) and=20
closing
> >  parentheses (`%x29`), due to their role in the option syntax.
> >  +
> >=20
> > -** `prefix=3D<value>`: Shown before the list of ref names.  Defaults to
> > "{nbsp}+(+". +** `prefix=3D<value>`: Shown before the list of ref names=
=2E =20
Defaults
> > to "{nbsp}++(++".>=20
> >  ** `suffix=3D<value>`: Shown after the list of ref names.  Defaults to=
 "+)
+".
> >  ** `separator=3D<value>`: Shown between ref names.  Defaults to "+,+
{nbsp}".
> >  ** `pointer=3D<value>`: Shown between HEAD and the branch it points to=
, if=20
any.
> >=20
> > -		      Defaults to "{nbsp}+->+{nbsp}".
> > +		      Defaults to "{nbsp}++->++{nbsp}".
> >=20
> >  ** `tag=3D<value>`: Shown before tag names. Defaults to "`tag:`{nbsp}".
> > =20
> >  +




