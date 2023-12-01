Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="fr2cj24H";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="mxvg9tDz"
Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com [64.147.123.24])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DA99131
	for <git@vger.kernel.org>; Thu, 30 Nov 2023 22:43:56 -0800 (PST)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailout.west.internal (Postfix) with ESMTP id D966D3200B50;
	Fri,  1 Dec 2023 01:43:53 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Fri, 01 Dec 2023 01:43:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:sender
	:subject:subject:to:to; s=fm1; t=1701413033; x=1701499433; bh=j4
	grmPtLXjYHAECp14bMB91PtGo3a/DCJeIGD0XQQ2M=; b=fr2cj24HKieGpuShk/
	kl8NDC1loTGT4GArvj9RuCF+MXO9bDl1QPHjUSQS7OsnYQ8Uyjm07foegz7QnHBj
	pOL74i0rgAE7i7qQ3czK9WHHwKJPUSIwYHxezTKkkuH0S78YoWVdwnaYGgz4qBhI
	uuM9duyKB1G8nbvLgxRATJuR+to7l0w5eSpxzU0MOypZmPsrimviOdE16dQgNQ4D
	kAU8iXN7bGe40BBTjlqXYLkIWur0WZQyKEXi4xFax5DwJCVOEvmkN5pZq4eCHdua
	Gt7xc5cr4q3HRzZu3/jPdijKt0c9iQqXeMawzB2vbmGLFhMoTjfFGpsSrG42LAiv
	yCow==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:sender:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm1; t=1701413033; x=1701499433; bh=j4grmPtLXjYHA
	ECp14bMB91PtGo3a/DCJeIGD0XQQ2M=; b=mxvg9tDzBHhQGhdeGNrBQBRZCcR+m
	mUb5dIJlv5jG2WNl1sASrhoLibCmIDQEVGuMD3x7Go3GNLfKM6ottyeJj5c0LfVw
	s6GEDgFu6/phV4Eq9Pj5xwUrM0CtDRuHTrwx+nbDsZDOULnyfEG0botNXZRiOaT5
	lOX/6BCUdD+UoHhQojqA/QGvyPQoCn2mDjlSikZ8ItiXl4i+yjnODlKxfPeFQ1/v
	sFhNxh3rW/7sVLXyjhzYcEJRtU2SA/BJmm/sPRKd1MeB6dcCuP+sWmSlTLpvBZMa
	5m7RlhxYCI4THzDKODJAGHAYO+1+ZS947Eyw90wsXiu65+o+AwUtuA2nw==
X-ME-Sender: <xms:pIBpZfzDQ1rbugI7vHu7o76TpnRY92lKEigG8Auf_66owchAiaURpg>
    <xme:pIBpZXT2NM39eyh4Xk6s0nVvhMnfkw_FDAxpmYykETvO5WICLQ6e5ZTlvVIT0of0c
    BHsiS53fjwwKVDcdg>
X-ME-Received: <xmr:pIBpZZV_Sbe8qrsZZ6svTWkyLKos2pP-Z9UJYylQRH39-JKQOJDalmx5XzdPY3u5HVX-A6EVU1LLlcnKaDADxtS9Xz1q2vmpsfuDNomJw-CuZrw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrudeikedgleeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehgtd
    erredttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshes
    phhkshdrihhmqeenucggtffrrghtthgvrhhnpeeukedtvedtffevleejtefgheehieegke
    eluddvfeefgeehgfeltddtheejleffteenucevlhhushhtvghrufhiiigvpedtnecurfgr
    rhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:pIBpZZicKisGZFomiOZ-VTqINaUBw5w4jWjMRI9t0YoZx-ivCmIjNw>
    <xmx:pIBpZRABORLQKM4dyN61g5aoV5Sbp0isnnz7v0zLf_6TX0HzdSRZhg>
    <xmx:pIBpZSJw4FTYY5kSFkL60aX3JX268EB6sirkGX1DoHpqYqbskvvV7A>
    <xmx:qYBpZe6iDy2SJWQzhqGrcXeYQ5v_u_QH1A2ZDO3969eaI78rVb4RTQ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 1 Dec 2023 01:43:47 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 9d804cac (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 1 Dec 2023 06:42:30 +0000 (UTC)
Date: Fri, 1 Dec 2023 07:43:43 +0100
From: Patrick Steinhardt <ps@pks.im>
To: phillip.wood@dunelm.org.uk
Cc: git@vger.kernel.org, hanwenn@gmail.com
Subject: Re: [PATCH 3/4] refs: complete list of special refs
Message-ID: <ZWmAn20UYWBo9i8C@tanuki>
References: <cover.1701243201.git.ps@pks.im>
 <0e38103114a206bedbbbd7ea97cb77fa05fd3c29.1701243201.git.ps@pks.im>
 <15f67e21-c05f-4a72-9557-2a09a1311f25@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="gX+5wrGGPPL0YJxR"
Content-Disposition: inline
In-Reply-To: <15f67e21-c05f-4a72-9557-2a09a1311f25@gmail.com>


--gX+5wrGGPPL0YJxR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 30, 2023 at 03:42:06PM +0000, Phillip Wood wrote:
> Hi Patrick
>=20
> Thanks for working on this. I've left a couple of thought below.
>=20
> On 29/11/2023 08:14, Patrick Steinhardt wrote:
> > +static int is_special_ref(const char *refname)
> > +{
> > +	/*
> > +	 * Special references get written and read directly via the filesystem
> > +	 * by the subsystems that create them. Thus, they must not go through
> > +	 * the reference backend but must instead be read directly. It is
> > +	 * arguable whether this behaviour is sensible, or whether it's simply
> > +	 * a leaky abstraction enabled by us only having a single reference
> > +	 * backend implementation. But at least for a subset of references it
> > +	 * indeed does make sense to treat them specially:
> > +	 *
> > +	 * - FETCH_HEAD may contain multiple object IDs, and each one of them
> > +	 *   carries additional metadata like where it came from.
> > +	 *
> > +	 * - MERGE_HEAD may contain multiple object IDs when merging multiple
> > +	 *   heads.
> > +	 *
> > +	 * - "rebase-apply/" and "rebase-merge/" contain all of the state for
> > +	 *   rebases, where keeping it closely together feels sensible.
>=20
> I'd really like to get away from treating these files as refs. I think th=
eir
> use as refs is purely historic and predates the reflog and possibly
> ORIG_HEAD. These days I'm not sure there is a good reason to be running
>=20
>     git rev-parse rebase-merge/orig-head
>=20
> One reason for not wanting to treat them as refs is that we do not handle
> multi-level refs that do not begin with "refs/" consistently.
>=20
>     git update-ref foo/bar HEAD
>=20
> succeeds and creates .git/foo/bar but
>=20
>     git update-ref -d foo/bar
>=20
> fails with
>=20
>     error: refusing to update ref with bad name 'foo/bar'
>=20
> To me it would make sense to refuse to create 'foo/bar' but allow an
> existing ref named 'foo/bar' to be deleted but the current behavior is the
> opposite of that.
>=20
> I'd be quite happy to see us refuse to treat anything that fails
>=20
>     if (starts_with(refname, "refs/") || refname_is_safe(refname))
>=20
> as a ref but I don't know how much pain that would cause.

Well, we already do use these internally as references, but I don't
disagree with you. I think the current state is extremely confusing,
which is why my first approach was to simply document what falls into
the category of these "special" references.

In my mind, this patch series here is a first step towards addressing
the problem more generally. For now it is more or less only documenting
_what_ is a special ref and why they are special, while also ensuring
that these refs are compatible with the reftable backend. But once this
lands, I'd certainly want to see us continue to iterate on this.

Most importantly, I'd love to see us address two issues:

  - Start to refuse writing these special refs via the refdb so that
    the rules I've now layed out are also enforced. This would also
    address your point about things being inconsistent.

  - Gradually reduce the list of special refs so that they are reduced
    to a bare minimum and so that most refs are simply that, a normal
    ref.

> > +	const char * const special_refs[] =3D {
> > +		"AUTO_MERGE",
>=20
> Is there any reason to treat this specially in the long term? It points t=
o a
> tree rather than a commit but unlike MERGE_HEAD and FETCH_HEAD it is
> effectively a "normal" ref.

No, I'd love to see this and others converted to become a normal ref
eventually. The goal of this patch series was mostly to document what we
already have, and address those cases which are inconsistent with the
new rules. But I'd be happy to convert more of these special refs to
become normal refs after it lands.

> > +		"BISECT_EXPECTED_REV",
> > +		"FETCH_HEAD",
> > +		"MERGE_AUTOSTASH",
>=20
> Should we be treating this as a ref? I thought it was written as an
> implementation detail of the autostash implementation rather than to prov=
ide
> a ref for users and scripts.

Yes, we have to in the context of the reftable backend. There's a bunch
of tests that exercise our ability to parse this as a ref, and they
would otherwise fail with the reftable backend.

Patrick

--gX+5wrGGPPL0YJxR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmVpgJkACgkQVbJhu7ck
PpScVhAAnmqW3moYjRLFGfO7kjpGZvFkLECo68u+TWSTIfxlTC87ZrEeqaPexbHa
zIjdZ7ohDoEkkTcnHnp5S8wxqdiogOduhM6wsfNehLIqvz6A7ZItkrl41ojAdnBv
44pjHabJYbYz3PK5N6yKto444zwRa5vmuQsVCWh+2uIY85S914ieae8hl8VUxHqo
NoNFRfDXcy4fvSkrKdUdt2MbqSm7elxmjWvzGja3Wjb7LUPJCrLshxflSrIPufqU
yJcyvKXQes1qV2yFc5KMEM27QxmoBmbUg7fZu5icdWuF5Ozpd12g+lX4FKbx9oN1
iSNEOTkgg9Gr1C3WX19WQdJln19L+i7AYE9Q8b+IORKuRTGOaWxt0qu0YmXJGtz1
ZY5qtGfQAopFFqMpazs2z1ZPD+mt2TbYyxCwDCsZGsFqQXqgpISGfhbjSWrSKKJh
s87frZHnKHgVI0dmiqHeEo1RNiAhZ4XGXtCfLwWTvUXJaaV4FC2m7t/MoX0YUiNt
/BcJY6WnckVAWgct8H/w2wWWEyJ/o8FDXMOr1Z7hXrmfkyIuiqzqEsSe33ZEc2s1
hMnnRBLh/f9pYTcIxuWQxWVIyDFgtBp7s6NRJ7JtZQAAk4df6dvxevNOmMQ3XVeU
a0AocGSlUGFbBhlyBN+hFkvudUzmq4FA2guzgji7O1UcasHpXO0=
=fnxf
-----END PGP SIGNATURE-----

--gX+5wrGGPPL0YJxR--
