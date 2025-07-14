Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05CEE231A4D
	for <git@vger.kernel.org>; Mon, 14 Jul 2025 21:14:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752527663; cv=none; b=fGLsNb7LzI9gaIANNEFhh4DSmpkRfabcdYWn2XtWscfqU1VisvrO8ZXKlGXRWwWP+B8/Y6O1CCGm2UjKl/LTobGXgTAOmgJL61AWJfENiWUcENjqbmpIxgsQ9CI53tmpGnhRxzrRjZv9EhGrAqaKiQoi08/YXN+nfWPw3iNTr7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752527663; c=relaxed/simple;
	bh=AdELAxd/SsG8Fzm7CkzeFd0MAlCLYnJutGrcsy+iLic=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qLeIdzSObI5AOOJodkYrwXuFLPO2x+0USsgWOoEaVCVEU0SjcaCtXeT62VYvAjjEPKU4Z0srmjld3fFMuz8XqqSbkghLfJB7ndWzlZbRMgTUrpISn2GFJAtTMwZ5x4sQn16/YBWPcSDqcCGy8Hik2IuLZ2drwn3vjmUmffTROOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=wImQVU2Y; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="wImQVU2Y"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1752527653;
	bh=AdELAxd/SsG8Fzm7CkzeFd0MAlCLYnJutGrcsy+iLic=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=wImQVU2YaOoMh5G6TiSnoFGbQIWPdeRHNzwa8Qmt389KHl/8qylax7UfqvKhwuitj
	 7ZDDlxyfIIrPcUBUUosAyibkr2VRxCVUQ955S88jxWjgR7FiJ+rx7gEmHZ7+vSbrQS
	 +Q+J2AmbV5Msyrds/Jw0IFuR+8ZstN8ryu8KzX2cLwsRjJtkH1BZra1D5r1YdUpa9w
	 UN/3Lu+KWWd3CEUnqsOWfjDMRxlFXVlvma9BAOCQm1GeBMXs5GnJXw/Heq2L4jcBLk
	 Nwg9PIrPONeB9vttr8iogPW912hiCtlKYnQ+xeq+50gSF8FNhAGxApSY+1NHrjWd6O
	 l3M4leJnPtpjEGmvS+tmFR4/p9uHrfhFwViwzajQdPyb4Lr2Vt3AMmZ0wwTFNb8ktM
	 2Jhdn16hbR5jCn4Ybb9MoKqqhajBdwSSeu0+u7trKmVGcaXKsZh+tpRJItTgKjer+5
	 LhUJp6tFNgce5mmy8RIemY+LL11srUvTtXiaV7DjDWVQXosICIz
Received: from fruit.crustytoothpaste.net (unknown [IPv6:2607:f2c0:f00f:f901:828b:3227:a916:b7f5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id AA9072006F;
	Mon, 14 Jul 2025 21:14:13 +0000 (UTC)
Date: Mon, 14 Jul 2025 21:14:12 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: Elijah Newren <newren@gmail.com>
Cc: Phillip Wood <phillip.wood@dunelm.org.uk>, git@vger.kernel.org,
	=?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
	Phillip Wood <phillip.wood123@gmail.com>
Subject: Re: [PATCH 2/3] git-compat-util: convert string predicates to return
 bool
Message-ID: <aHVzJE9_xJAn5dOt@fruit.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Elijah Newren <newren@gmail.com>,
	Phillip Wood <phillip.wood@dunelm.org.uk>, git@vger.kernel.org,
	=?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
	Phillip Wood <phillip.wood123@gmail.com>
References: <cover.1752499610.git.phillip.wood@dunelm.org.uk>
 <a0f9182aa20d0f956072a3d185a2d1288f1bd842.1752499610.git.phillip.wood@dunelm.org.uk>
 <CABPp-BEH9rtdPcS9hEXSdCqwydcWbakT59OuQOFUU7DGjPzdVw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="xsrRYfs9G4XYiivX"
Content-Disposition: inline
In-Reply-To: <CABPp-BEH9rtdPcS9hEXSdCqwydcWbakT59OuQOFUU7DGjPzdVw@mail.gmail.com>
User-Agent: Mutt/2.2.13 (2024-03-09)


--xsrRYfs9G4XYiivX
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2025-07-14 at 17:20:08, Elijah Newren wrote:
> On Mon, Jul 14, 2025 at 6:32=E2=80=AFAM Phillip Wood <phillip.wood123@gma=
il.com> wrote:
> >
> > From: Phillip Wood <phillip.wood@dunelm.org.uk>
> >
> > Since 8277dbe987 (git-compat-util: convert skip_{prefix,suffix}{,_mem}
> > to bool, 2023-12-16) a number of our sting predicates have been
> > returning bool instead of int. Now we've declared that experiment
>=20
> Now we've -> Now that we've
>=20
> > a success lets convert the return type the case independent
>=20
> success lets -> success, let's
> type the -> type of the
>=20
> > skip_iprefix() and skip_iprefix_mem() functions to match the return
> > type of their case dependent equivalents. Returning bool instead of
>=20
> I wonder if case-independent and case-dependent should be hyphenated,
> or as separate words as you had them.  Anyone know?

I would hyphenate them.  The Chicago Manual of Style, 18th Edition, says
in =C2=A7 7.91, =E2=80=9CWhen compound modifiers (also called phrasal adjec=
tives)
such as _high-profile_ or _book-length_ precede a noun, hyphenation
usually lends clarity.  With the exception of proper nouns (such as
_United States_) and compounds formed by an adverb ending in _-ly_ plus
an adjective=E2=80=A6, it is never incorrect to hyphenate adjectival compou=
nds
before a noun.=E2=80=9D

They go on to state that hyphenation is usually omitted _after_ a noun.

I usually follow this rule in my writing and commit messages and I
haven't gotten any complaints or comments about it, for what it's worth.
--=20
brian m. carlson (they/them)
Toronto, Ontario, CA

--xsrRYfs9G4XYiivX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.4.7 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCaHVzIwAKCRB8DEliiIei
gcVvAQDHXp5CtCJnRIxECwA8W0oL9jf2GdUvNBXAUifjP2gN/wEA5DZxkd5/JD2U
5hLZarchJznxOL4P4XKj77VK1OBt7w4=
=BIiM
-----END PGP SIGNATURE-----

--xsrRYfs9G4XYiivX--
