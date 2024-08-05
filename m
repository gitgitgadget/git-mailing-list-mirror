Received: from smtp5-g21.free.fr (smtp5-g21.free.fr [212.27.42.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6201716B388
	for <git@vger.kernel.org>; Mon,  5 Aug 2024 20:12:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.27.42.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722888735; cv=none; b=X9o72jJ8wKk7P95WA8XBqi+ArKZeQ1HgAxU3vbvVoF9DpS2Qhtlw9w1D50z1Ur9PNlqaAiuSAjx4WH0iECTeoJnFnO68zTAvMTzbsHRYCkrzGBhl6MiLQpRMjKdkkpiKUj8Xg3jP0KPN02b/obkge9SjRNaOnRmck25AtHSpdA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722888735; c=relaxed/simple;
	bh=ICZAJXImxxnDj4VW0h4PMiioGZA784cpUH21wR8eU+E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fGGz27Wsc/gbSZxMuWYPu77+YA8IoIcaKWB1LDU2eV8nYpfpH8dz2nOQfQ3xNyWEArHWfsU6fk9fYFoxQTTo/nUC8hcfzqRXlN/AJoT5B7IMycrhn0ci1yQ3IB2XKoavn8eyqgiKcR/rP/NnKzSBcGNlC/xcFI6ScUO7bWlUWx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=free.fr; spf=pass smtp.mailfrom=free.fr; dkim=pass (2048-bit key) header.d=free.fr header.i=@free.fr header.b=r/jVa3PH; arc=none smtp.client-ip=212.27.42.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=free.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=free.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=free.fr header.i=@free.fr header.b="r/jVa3PH"
Received: from cayenne.localnet (unknown [IPv6:2a01:e0a:d1:f360:30d3:2eb8:e210:da4b])
	(Authenticated sender: jn.avila@free.fr)
	by smtp5-g21.free.fr (Postfix) with ESMTPSA id 95FC860149;
	Mon,  5 Aug 2024 22:12:08 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
	s=smtp-20201208; t=1722888730;
	bh=ICZAJXImxxnDj4VW0h4PMiioGZA784cpUH21wR8eU+E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=r/jVa3PHZT5HZ34M5TyLsFuqy3lH1+/FPpLotXC2JA4AmrzVdeL3iNn7DdD69WW8H
	 WHOruwzLd9V4pwLubApJIZKKE5CP+Cl0sCC64niP9QQe54MHxPV2dO8SV/3whohaR9
	 by1m3hntQxKzhicCT8HVu8SHBeaaQGAiPqkqKdiIP/GnA2XxxCNHtgwAkwFmtRfPe4
	 XpTPgVxQXXak8wyxed8QWWCuuKF55ZFUoctqX6B/hEO/MU4pBM1RZfonR/PivTXfds
	 ZGe03elBOr8xNo4Fyv5lQnoiZkUpnMAy0m4tfOCDe4VocJhpi1TTZiUDo+nwqYUfCO
	 8qo5vCG9+yqAQ==
From: =?ISO-8859-1?Q?Jean=2DNo=EBl?= AVILA <jn.avila@free.fr>
To: Johannes Sixt <j6t@kdbg.org>
Cc:
 =?ISO-8859-1?Q?Jean=2DNo=EBl?= Avila via GitGitGadget
 <gitgitgadget@gmail.com>, git@vger.kernel.org
Subject:
 Re: [PATCH 4/5] doc: git-diff: apply format changes to diff-generate-patch
Date: Mon, 05 Aug 2024 22:12:08 +0200
Message-ID: <8448316.NyiUUSuA9g@cayenne>
In-Reply-To: <5ef4a7bd-3b9f-4e71-9a22-e22012f815ce@kdbg.org>
References:
 <pull.1769.git.1722801936.gitgitgadget@gmail.com>
 <3c475a2ee4ecfb79a1174fa693b592ebafdbf5f9.1722801936.git.gitgitgadget@gmail.com>
 <5ef4a7bd-3b9f-4e71-9a22-e22012f815ce@kdbg.org>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"

On Monday, 5 August 2024 07:53:19 CEST Johannes Sixt wrote:
> Am 04.08.24 um 22:05 schrieb Jean-No=EBl Avila via GitGitGadget:
> > @@ -134,17 +135,18 @@ or like this (when the `--cc` option is used):
> > =20
> >  2.   It is followed by one or more extended header lines
> >       (this example shows a merge with two parents):
> > -
> > -       index <hash>,<hash>..<hash>
> > -       mode <mode>,<mode>..<mode>
> > -       new file mode <mode>
> > -       deleted file mode <mode>,<mode>
> >  +
> > -The `mode <mode>,<mode>..<mode>` line appears only if at least one of
> > -the <mode> is different from the rest. Extended headers with
> > +[synopsis]
> > +index <hash>,<hash>`..`<hash>
> > +mode <mode>,<mode>`..`<mode>
> > +new file mode <mode>
> > +deleted file mode <mode>,<mode>
> > ++
> > +The `mode` __<mode>__++,++__<mode>__++..++__<mode>__ line appears only=
 if=20
at least one of
> > +the _<mode>_ is different from the rest. Extended headers with
>=20
> I've a strong aversion to the formatting that this series applies,
> because it introduces many (IMHO) unnecessary punctuation that
> vandalizes the perfectly readable plain text. And this hunk now shows
> where it goes too far. These lines under the new [synopsis] header just
> aren't syopsis; they are comamnd output. The updated version abuses a
> semantic token to achieve syntactic highlighting.
>=20
> To me this series looks too much like "we must adapt to the tool" when
> the correct stance should be "the tool must adapt to us". If the tool
> (one of asciidoc and asciidoctor, I presume) does not cooperate well
> with out documents, then it is the tool that must be changed, not our
> documents.
>=20
> I understand that some compromises are needed, but with this extent of
> changes we give in to a sub-par tool too far.
>=20
> Just my 2c.
>=20
> -- Hannes
>=20
>=20

Hello,

I was half expecting this kind of reactions. First there are some remarks o=
n=20
your remarks.
=20
 * You think the markup is unnecessary. To me, it is critical in order to m=
ake=20
the documentation output a little more meaningful. My experience as a=20
translator is that there's a great lack of consistency in the vocabulary, t=
he=20
grammar styles, the typesetting and the cross-references of the pages. On t=
op=20
of that, they are clearly not user-oriented. Overall, the joke about how=20
cryptic the man-pages of Git are is not coming from nowhere. There's no one=
 to=20
blame: we are all developers doing our best, but we are not technical write=
rs=20
dedicated to this project.
 * The fact that the source of the pages should be "perfectly readable" is =
a=20
moot argument. Fair enough, it is not the objective to make it impossible t=
o=20
understand, but in the end, this is not what is consumed: these pages are=20
compiled into other formats where the markup has been translated into styli=
ng.=20
I suspect some writers are not thinking when quoting text, that this is not=
 a=20
quotation but an inline formatting command. But this is markup, and sometim=
es,=20
it cannot  be removed of the way.
 * I converted the lines to synopsis because there are placeholders in them=
=2E=20
These lines are presented as an example but they are neither. This is anoth=
er=20
example of communication impedance,  where the presented text is not what i=
t=20
is described as, and requires from the reader to interpret what the writer =
was=20
thinking and forgot to make clear to a newcomer.


As for the "need to adapt to the tool", for block formatting, I tried to ge=
t=20
something bearable (the synopis style); I'd really like something similar f=
or=20
inline formatting but my asciidoc/asciidoctor Fu requires an upgrade in ord=
er=20
to make it happen. As it seems to be too epidermic, I'll try to cook someth=
ing=20
anyway and keep being open to any proposition.

In the mean time, a proper editor setup (syntax highlighting and fontificat=
ion=20
, two panels with one showing the compiled output) can alleviate your pain.=
=20

JN


