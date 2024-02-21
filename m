Received: from smtp2-g21.free.fr (smtp2-g21.free.fr [212.27.42.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED72783A1F
	for <git@vger.kernel.org>; Wed, 21 Feb 2024 21:52:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.27.42.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708552339; cv=none; b=XmDhisl9T4LyveNj0K2Jmfu4sRhjQ80DCLNC4X67lJPVcTDpMerH/n4bX5OZjEunGYbxXSvxN8RtEL0Ziq8KLxF2yNaQYgVe1qlOiS8HEBy57iTwMJKrjmgv3MZyg1dnVYa80DznV5JE7zSoOLtCCN4OpKEAipEaAr/qjVzum/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708552339; c=relaxed/simple;
	bh=l9h0k2h3x4syCvSmT+zzCF1WjO2T+r9fvLxHdBiyRtk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=H8pMHw9ObaGx+qs+Qq8U2gtHKL0+dl4m5u2Npl67ZZC4LNLqE0ELeppBObDejKwMfmqkXuSp6206SoiemlHteDDxsRiU3gt71VaDcpPaFFFUfaGFYkgU+fLkYmcgrAKIgOWgqWaXjw1SdhKyiaPgw62k5Pau6FERHWIv+h1wFgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=free.fr; spf=pass smtp.mailfrom=free.fr; dkim=pass (2048-bit key) header.d=free.fr header.i=@free.fr header.b=Lr0fq9C2; arc=none smtp.client-ip=212.27.42.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=free.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=free.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=free.fr header.i=@free.fr header.b="Lr0fq9C2"
Received: from cayenne.localnet (unknown [IPv6:2a01:e0a:d1:f360:9bca:a380:8169:3a3f])
	(Authenticated sender: jn.avila@free.fr)
	by smtp2-g21.free.fr (Postfix) with ESMTPSA id 53D552003AE;
	Wed, 21 Feb 2024 22:52:07 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
	s=smtp-20201208; t=1708552329;
	bh=l9h0k2h3x4syCvSmT+zzCF1WjO2T+r9fvLxHdBiyRtk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Lr0fq9C2WjHwGPyGyBmu7S5plQDJ4LfgBMmYVzLC+Ne/Mpg6o91cJSEQav/p5snMu
	 0wJkXNw92G98l/PJzHZU6ATtKIHx2POFge9eoF0icdkSUjickto/kZAhfKTBMiKkpF
	 yT/QLGAOftvAtYciOLNLKm0RN32YPGDRafNFg7TRcfL4GQfY0REoSRNan4NJd6Xns7
	 ELDJTGQeZQOt1t1F6CMWIaWilYej3xZBXAv4kTvlXcoDsIJlfSNr8NV4S0l1ixCmmU
	 +ZYGaHBSYn4/S8HzUDcSNxkseSQf8DLQWJ3USzPeBWkSwj9IWCAMDoQvIxQQkd+ysK
	 7UEpC1PdEacTQ==
From: =?ISO-8859-1?Q?Jean=2DNo=EBl?= AVILA <jn.avila@free.fr>
To: Junio C Hamano <gitster@pobox.com>
Cc:
 =?ISO-8859-1?Q?Jean=2DNo=EBl?= Avila via GitGitGadget
 <gitgitgadget@gmail.com>, git@vger.kernel.org
Subject:
 Re: [PATCH 1/3] doc: git-rev-parse: enforce command-line description syntax
Date: Wed, 21 Feb 2024 22:52:06 +0100
Message-ID: <5764785.DvuYhMxLoT@cayenne>
In-Reply-To: <xmqqfrxlpvv1.fsf@gitster.g>
References:
 <pull.1670.git.1708468374.gitgitgadget@gmail.com>
 <67dca173-3048-430b-88a1-d3b5d853f84b@free.fr> <xmqqfrxlpvv1.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"

On Wednesday, 21 February 2024 18:31:30 CET Junio C Hamano wrote:
> Jean-No=EBl Avila <jn.avila@free.fr> writes:
>=20
> >>> ---short[=3Dlength]::
> >>> +--short[=3D<length>]::
> >>>   	Same as `--verify` but shortens the object name to a unique
> >>>   	prefix with at least `length` characters. The minimum length
> >> This same comment applies throughout this patch, but in other places
> >> when we use <placeholder> in the option argument description, don't
> >> we use the same <placeholder> in text as well?  I am wondering if
> >> the `length` (typeset in fixed-width) should become <length>.  What
> >> do other recent[*] documentation pages commonly do?
> >
> > This is another part of the inconsistences in documentation that I'd
> > like to tackle (hopefully, not in another life).
> >
> > Using angle brackets for placeholders everywhere they appear is a
> > visual link to the preceding syntax description, but may feel a bit
> > heavy on some cases. Anyway, I'm all for applying the rule everywhere,
> > for the sake of consistency.
>=20
> I agree that if <placeholder> is not an appropriate way to spell
> them in the explanation text, we would want to change them
> consistently everywhere, and until then, using the angle-bracketted
> <placeholder> that is common would be better.  The text will be
> modified again when we decide to switch from <placeholder> to
> something else, so updating them now may be a wasted effort, but (1)
> we may decide that <placeholder> is good enough after all, or (2) it
> may make it easier to mechanically identify words whose mark-up
> should be converted if we consistently use <placeholder> now, even
> if we know it won't be the final mark-up.
>=20
> So I am inclined to say that we should first do `length` -> <length>
> in the body text in the short term.  But I also think we should
> *not* do so as part of this patch, whose focus is how the option
> enumeration header should mark up the option arguments.
>=20
> > Backticks and single quotes are used indistinctively (by the way,
> > asciidoctor does not process single quotes as markup) and are not used
> > everywhere they should. Using backticks is also a good hint for
> > translators to mean "verbatim, do not translate". Obviously, the
> > placeholders ask for translation, so the backtick rule should not
> > apply to them, even if another formating would be welcome :
> > _<placeholder>_ for instance?
>=20
> Yes.  The way AsciiDoc renders (at least HTML) an unadorned <placeholder>
> is not so great.
>=20
> In "git-add.html" manual page, we see these examples.  The first one
> (unadorned) does not make the placeholder word stand out enough; the
> second one that does `<file>` makes it stand out better, but as you
> said, the `verbatim` mark-up is semantically wrong.
>=20
> https://git.github.io/htmldocs/git-add.html#:~:text=3DFor%20more%20detail=
s%20about%20the%20%3Cpathspec%3E%20syntax
>=20
> https://git.github.io/htmldocs/git-add.html#:~:text=3DPathspec%20is%20pas=
sed%20in%20%3Cfile%3E%20instead%20of%20commandline%20args.%20If%20%3Cfile%3=
E%20is%20exactly%20%2D%20then%20standard%20input%20is%20used.%20Pathspec
>=20
> The last part of the Documentation/CodingGuidelines document talks
> about how to mark up placeholders but it does not go beyond saying
> that they are written as <hyphen-in-between-words-in-angle-braket>.
> Whatever mark-up rule we decide to use, we should document it there.
>=20
> Thanks.
>=20
>=20
>=20
>=20

Hi,

I just saw that you pushed this series to 'next'. That's embarrassing becau=
se I missed other spots in the file were the formating was not correct. I w=
as also preparing the changes of placeholders in paragraphs as suggested.

Should I prepare another PR?

Thanks



