Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E07B1FC7
	for <git@vger.kernel.org>; Thu, 21 May 2026 21:18:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779398315; cv=none; b=fXysYNYYbk1oFcU7UvLLhKshE37KDIQfgPtH6LImUrJ2SR+a7r3QM7ntSzmCHZmwhthLGYDH8s68kT4Q//W6oODXk8g1z+ep2zyLMF+Gb6tJA7mtYGLkNSkYlj19fo+RqYDVSSAAMxvIscVZUhpuXYRwz6ffCcLE0Cuk11/LHE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779398315; c=relaxed/simple;
	bh=wihn01Ri7QeuOBRvqMqjSxc2jJmhK4qoxf8xyoThx9Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CWJoSI7CmT6IHFEbpzXnzMLDQ+J8zqCj+t9L2yT9Lz0tbtgxiCKkvur78DIneFlxgrS3777fcZTMMZ1T6roQiOV8vnngl/pakdiPYNm1smPDHqaQv3Lgue+xppjKJJCgSLXQkdvUJ8kQ9w9hzpiajF8JaO7d708x32W+JrEoCNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=zg+YlHzO; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="zg+YlHzO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1779398312;
	bh=wihn01Ri7QeuOBRvqMqjSxc2jJmhK4qoxf8xyoThx9Y=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=zg+YlHzO99LV3mtSPeJawQCTse30ziqkL8+jEMNPXpZ007d9Se5o1ojHPhwgN/YmU
	 ruDOaf/lZVPaZX8zU2IDFOR9MyqZgCJn6GiIdzKhDHl5M+a/9gIydxUp0ji6tD8gwP
	 UP6eJR2icgXQtu+M94PIru5ES9J8sj1/AEzwIIUf55L5qmtk6nTiiEof3+LQzcFJEB
	 C9HpEKbxbH3G/CTsNNSyPxKZlx16K7FwMqoBusEjT/muVscuMmAVKCaW1xLSjtg457
	 N9rpKM+zfmXgm6sgXF7/MFMm7mvSuNwl/ZLviHdpMBgB28LNqhVOALR2RRGq84ppdt
	 mgEeLg92QAwG5t0rPxH3MdF0Z+nr2mCfTB9j9Qi5PqgU/Uj+iYqdaSWuP9dLeG1MMt
	 Zar83peGFkKeFdbfH3O2bkZkX0n31EOQPrtqPGFQI4v4e+o76WNp5j++zPvLitKKC1
	 fuZPJsnBvmHeOedMt3kg/CL9bg5S4xXGm6y7nZ6Efko2CZRwErz
Received: from fruit.crustytoothpaste.net (unknown [IPv6:2607:f2c0:f00f:f901:3194:a876:8e20:f33])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id 3614320123;
	Thu, 21 May 2026 21:18:32 +0000 (UTC)
Date: Thu, 21 May 2026 21:18:30 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: Siddh Raman Pant <siddh.raman.pant@oracle.com>
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	"gitster@pobox.com" <gitster@pobox.com>,
	"newren@gmail.com" <newren@gmail.com>, "ps@pks.im" <ps@pks.im>,
	"code@khaugsbakk.name" <code@khaugsbakk.name>
Subject: Re: [PATCH 7/9] notes: support an external command to display notes
Message-ID: <ag92poA7U6ZefRv3@fruit.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Siddh Raman Pant <siddh.raman.pant@oracle.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	"gitster@pobox.com" <gitster@pobox.com>,
	"newren@gmail.com" <newren@gmail.com>, "ps@pks.im" <ps@pks.im>,
	"code@khaugsbakk.name" <code@khaugsbakk.name>
References: <cover.1779207350.git.siddh.raman.pant@oracle.com>
 <9619077369f1a567bd505b1de1e4f672a5cd1950.1779207350.git.siddh.raman.pant@oracle.com>
 <ag5b4O7-k-3QBR4W@fruit.crustytoothpaste.net>
 <4086055f59eec99f94847a1b37c684a084f08e0b.camel@oracle.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="qbyzH2sQOhw08CYF"
Content-Disposition: inline
In-Reply-To: <4086055f59eec99f94847a1b37c684a084f08e0b.camel@oracle.com>
User-Agent: Mutt/2.2.13 (2024-03-09)


--qbyzH2sQOhw08CYF
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2026-05-21 at 04:12:41, Siddh Raman Pant wrote:
> On Thu, May 21 2026 at 06:42:00 +0530, brian m. carlson wrote:
> > > Assisted-by: Codex:gpt-5.5-xhigh-fast
> >=20
> > Just a question here: was this written in whole or in part by Codex, or
> > was it just used as a reference to ask questions?  I ask because the
> > style of notes-external.c differs quite a bit from the style we use (for
> > one, the horizontal rule comments) and we have this in
>=20
> AI tools typically don't generate comments in code like in this series,
> you can see by trying out for yourself. Each comment is hand-written by
> me. Sorry, I'll remove those lines in v2 after this discussion.

I've actually seen AI tools do things very similar to what you've
written.

> > SubmittingPatches:
> >=20
> >     The Developer's Certificate of Origin requires contributors to cert=
ify
> >     that they know the origin of their contributions to the project and
> >     that they have the right to submit it under the project's license.
> >     It's not yet clear that this can be legally satisfied when submitti=
ng
> >     significant amount of content that has been generated by AI tools.
> >=20
> >     [...]
> >=20
> >     To avoid these issues, we will reject anything that looks AI
> >     generated, that sounds overly formal or bloated, that looks like AI
> >     slop, that looks good on the surface but makes no sense, or that
> >     senders don=E2=80=99t understand or cannot explain.
>=20
> Please tell me why this change is a slop and doesn't make sense.

I didn't say this was slop and didn't make sense.  I quoted the portion
that says that we don't accept anything AI generated, including for
license reasons.  There's still very little clarity about whether AI
code is a derivative work of the training set or whether it can be
copyrightable at all, very especially on a worldwide basis.  We don't
want to end up with a legal or license problem that the DCO was intended
to solve.

> If I wanted to mislead here, I would not have used the "Assisted-by"
> trailer, which is now being used in kernel land:
>=20
> https://www.kernel.org/doc/html/latest/process/submitting-patches.html#us=
ing-assisted-by

The kernel and Git do different things.  Linux generally allows AI and
we generally restrict its use quite heavily.  Linux tries to never break
dependent projects and we don't have that policy.

I appreciate the header being included and agree that it should be, but
it's important we ask questions about the provenance of the code when AI
is used because many people do not read SubmittingPatches (or
contributing documentation in general).

> > I'll note that it also has a lot of global variables, which are common
> > in the codebase but we're trying to move away from,=C2=A0
>=20
> Is there a new facility to store the config without a global variable?
>=20
> If the issue is the number, I can make a housing struct if you want.

We'd typically use repo_config_get_string or such to fetch the
configuration these days.  If you don't want to fetch it multiple times,
we'd generally read all the config and put it in a struct that we'd
initialize with a function at a suitable time.

There's effort to avoid the global variables because they don't work
well in libraries and we want to allow libgit.a to be used more
generally.  In addition, Rust considers static mutable variables to be
unsafe, so as we add more Rust, we'll need to minimize the use of any
globals.

> I added comments to explain the code clearly as it's being followed,
> especially since this is a new feature and I wanted the intent to be
> clear.
>=20
> If you could tell me which comments to remove, that would be great.

I don't think it's necessarily a problem to have the comments, but it is
uncommon in our codebase, which is what drew my attention.
--=20
brian m. carlson (they/them)
Toronto, Ontario, CA

--qbyzH2sQOhw08CYF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

wr0EABYKAG8FgmoPdqYJEHwMSWKIh6KBRxQAAAAAAB4AIHNhbHRAbm90YXRpb25z
LnNlcXVvaWEtcGdwLm9yZwUp9kjtw828lMAG4xtj/GONhKgKkurCd8nIvkItzaDB
FiEECCzmip28ZfuD0cORfAxJYoiHooEAAGyXAP0cI+LCH50ceUF8KnwbMJbbmD/P
dl3C+J/1E+FHNTI+IwEA6j0l4GqND2lZdDbYB7bd0UmORNMefWl2Pb12IjL2Ww4=
=DHax
-----END PGP SIGNATURE-----

--qbyzH2sQOhw08CYF--
