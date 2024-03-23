Received: from smtp4-g21.free.fr (smtp4-g21.free.fr [212.27.42.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35D442E410
	for <git@vger.kernel.org>; Sat, 23 Mar 2024 19:58:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.27.42.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711223926; cv=none; b=Ks+lEzeREc8J9e8PkPmPhGRdXHVnnwvKEBCWl6xrWc+hi1O9GZ1PQE4+SHQn71sKo6RT/788UDASDhEwv4d1qNKcrs4jsgpeq8eF4q5tUXNKG5CNNDDsFTMrOaQ5Ofq33XfxOLbPcWL6VrpR9lvrfzrmeY5OSFuUBLwlvnZ45eU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711223926; c=relaxed/simple;
	bh=42umCI2w+xVaP4uqLDnpSdPN25SxObptMI233exQ0LE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lhAhbLUFP569vU6zUMWiUZIi4KxiKIFdesBL8k7+pDpy+lWiNaFdfytgsxe/pbBP4mI2++r1Njkk7BZw5DrjHmlbYYHUXv399IZiQZtwgIIaIN37E8oo8GtHUCQyRTFBq6epazt3uNSQn4+IgGjaP7D856UWl2YbTyRzUS9gwpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=fail smtp.mailfrom=gmail.com; arc=none smtp.client-ip=212.27.42.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=gmail.com
Received: from cayenne.localnet (unknown [IPv6:2a01:e0a:d1:f360:3559:5be6:8fac:2a78])
	(Authenticated sender: jn.avila@free.fr)
	by smtp4-g21.free.fr (Postfix) with ESMTPSA id 3D2F419F593;
	Sat, 23 Mar 2024 20:58:40 +0100 (CET)
From: =?ISO-8859-1?Q?Jean=2DNo=EBl?= AVILA <avila.jn@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
Subject: Re: [PATCH] doc/gitremote-helpers: fix more missing single-quotes
Date: Sat, 23 Mar 2024 20:58:39 +0100
Message-ID: <22254967.EfDdHjke4D@cayenne>
In-Reply-To: <xmqq7chvblgr.fsf@gitster.g>
References:
 <20240320091748.GA2444639@coredump.intra.peff.net>
 <519698f1-1daf-4085-9aec-380f44492e72@gmail.com> <xmqq7chvblgr.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"

Le jeudi 21 mars 2024, 17:25:56 CET Junio C Hamano a =E9crit :
> Jean-No=EBl Avila <avila.jn@gmail.com> writes:
>=20
> >> -'option deepen-relative {'true'|'false'}::
> >> +'option deepen-relative' {'true'|'false'}::
> >>  	Deepens the history of a shallow repository relative to
> >>  	current boundary. Only valid when used with "option depth".
> >
> > The syntax for describing alternatives is specified as (true|false).
>=20
> Hmmmm, here, true and false are to be given verbatim.

In such case, it's (`true`|`false`) . As well as the command before.

>=20
> > Also, in my reworks of syntax, I chose to remove all formatting from the
> > term parts of the description lists.
>=20
> I know we added the _<placeholder>_ thing, but have we added these
> to Documentation/CodingGuidelines yet?
>=20
> Thanks.
>=20
>=20

No, we haven't.=20

I skimmed over different documentation projects and there's no real consens=
us=20
on what the formatting should be in detail, except for some common rules.
man-pages(7) gives some good hints that we should adhere to, which are echo=
ed=20
in the guide of asciidoc: https://docs.asciidoctor.org/asciidoctor/latest/
manpage-backend/ . Basically, verbatim are in bold, and variables are in=20
italic.

In our man pages, the asciidoc verbatim are rendered as bold and asciidoc=20
emphasis are rendered as underlined, just like italics,  which adheres to t=
he=20
principles,

Note that bold/verbatim are usually also used in terms of description lists.

I'm totally ok to change the CodingGuidelines and reroll git-clone and git-
init with these new rules.


