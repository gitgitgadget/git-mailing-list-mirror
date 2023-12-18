Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C1C3F9D1
	for <git@vger.kernel.org>; Mon, 18 Dec 2023 08:46:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="DnLKEUJ/";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="l7c+Vqud"
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailout.nyi.internal (Postfix) with ESMTP id 2B06F5C008E;
	Mon, 18 Dec 2023 03:46:04 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Mon, 18 Dec 2023 03:46:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1702889164; x=1702975564; bh=dlVX8Kec1H
	2ac0FpS935wJhH4KMExuTdps/esz4p1BQ=; b=DnLKEUJ/pvoT7wVE5gLMNo8Ih9
	ntufm9EsVahqO+UdmwwpRNukq0Z0n9Q4PltmjnbgmBT5aD6HqxocvQbjINvl+HZm
	ax7qOjPU2czNcoZcdpJ5a6vtuCN//LCWFxQhUX32m+U7NEA1mB2Eg4riUPH/fei1
	BqBJcrtPHmzKufzHizExJA6wPVyCL5/kXGorLN962rnvadkF3XlB6GDdPyVMIPfK
	BQPDNlBkn00Fon8uihdoklNjejQ6m67XW7vNi2bnQ8vvQnZ+IpiMCqlfJ4X4BXkG
	RnLmehhB/p+a+jsozs6j9AU4kY1eqxlJZlS7vI1N89PXhVrcsIQQJkLiFc5w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1702889164; x=1702975564; bh=dlVX8Kec1H2ac0FpS935wJhH4KME
	xuTdps/esz4p1BQ=; b=l7c+Vqud5O9cJQ7f5ExWxPY3kH4UFj/Wjt/m9bbEi4Er
	IZQrJC4tjpC1RSjbaaTxIWf90UmaXbbIyPAdIXF7Fj/ZdvxBOqdw48ipjutimA20
	rOJK8Oh3CWLLsyKnGWcGlk7cFiQEut2RkLjMtOpZXxkU6mRt9SMxsb8jYYG0Ji9n
	2mLV7UvYc0myWjdHzOI9DiLqHlMfvEaQW/ImukX/GGpoaYC41J+RCT9BmLsFBR71
	snTln9klxA1RjFWqGLKBVPQ+zKlYhX0+Ct8PrjRXw2lmgVGYbsPC2xpIzDK4ouzB
	Vym9HhuJMIaWqd/50wwZw+/bk+GhrTTcB78QPI5Aeg==
X-ME-Sender: <xms:ywaAZS80UCIlx8vCFavnaJKs06RWLBsq7N6rfPIy6_dF2EJMBOXcWA>
    <xme:ywaAZSuOUtDJbckzHEwExNuqVZqoZPavOBaiQ050HswGSR2Qo7EOG-HzUdNud8Zfa
    wkuJdbysb4sNuk6TQ>
X-ME-Received: <xmr:ywaAZYCC5S-X0uxKV6_3VdzWZXeoEfZu4er0hZnU5uhrr6MpXBez3gg5gigtIJEfVJdSWMU5FjDHsU6PWDlldgIkXKsBgUWywqcO7S3NuWSWm-A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvddtjedguddvgecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecunecujfgurhepfffhvfevuffkfhggtggujgesgh
    dtreertddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhs
    sehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepueektdevtdffveeljeetgfehheeige
    ekleduvdeffeeghefgledttdehjeelffetnecuvehluhhsthgvrhfuihiivgeptdenucfr
    rghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:zAaAZaf82iq_qV3xr_S3Mi8eiTDi6TlC9te0-7elfLsSlBCdQiIxtA>
    <xmx:zAaAZXNhc_Z27IKIQ5v6mZLPUaVu_ZuWXf7u75ilPPCJNiu89Ihwbw>
    <xmx:zAaAZUlsmKkprR2CDibdfjrsBpNbIDLv85U0P8eFWqR_3pSaf00hjw>
    <xmx:zAaAZZVvcD1hn7C9mI2VgJwr7RFpSwDJ0AB8VZpHhGL79Qg_58K5QQ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 18 Dec 2023 03:46:03 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id ad46fb63 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 18 Dec 2023 08:44:12 +0000 (UTC)
Date: Mon, 18 Dec 2023 09:46:00 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 1/5] git.txt: HEAD is not that special
Message-ID: <ZYAGyLH4nm4TebA_@tanuki>
References: <20231215203245.3622299-1-gitster@pobox.com>
 <20231215203245.3622299-2-gitster@pobox.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="76hIK4E59uift2hq"
Content-Disposition: inline
In-Reply-To: <20231215203245.3622299-2-gitster@pobox.com>


--76hIK4E59uift2hq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 15, 2023 at 12:32:41PM -0800, Junio C Hamano wrote:
> The introductory text in "git help git" that describes HEAD called
> it "a special ref".  It is special compared to the more regular refs
> like refs/heads/master and refs/tags/v1.0.0, but not that special,
> unlike truly special ones like FETCH_HEAD.
>=20
> Rewrite a few sentences to also introduce the distinction between a
> regular ref that contain the object name and a symbolic ref that
> contain the name of another ref.  Update the description of HEAD
> that point at the current branch to use the more correct term, a
> "symbolic ref".
>=20
> This was found as part of auditing the documentation and in-code
> comments for uses of "special ref" that refer merely a "pseudo ref".
>=20
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
>  Documentation/git.txt | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
>=20
> diff --git a/Documentation/git.txt b/Documentation/git.txt
> index 2535a30194..880cdc5d7f 100644
> --- a/Documentation/git.txt
> +++ b/Documentation/git.txt
> @@ -1025,10 +1025,11 @@ When first created, objects are stored in individ=
ual files, but for
>  efficiency may later be compressed together into "pack files".
> =20
>  Named pointers called refs mark interesting points in history.  A ref
> -may contain the SHA-1 name of an object or the name of another ref.  Refs
> -with names beginning `ref/head/` contain the SHA-1 name of the most
> +may contain the SHA-1 name of an object or the name of another ref (the
> +latter is called a "symbolic ref").

On a tangent: While we have a name for symbolic refs, do we also have a
name for non-symbolic refs? I often use the term "direct ref" to clearly
distinguish them from symbolic refs, but it's of course not defined in
our glossary.

> +Refs with names beginning `ref/head/` contain the SHA-1 name of the most
>  recent commit (or "head") of a branch under development.  SHA-1 names of
> -tags of interest are stored under `ref/tags/`.  A special ref named
> +tags of interest are stored under `ref/tags/`.  A symbolic ref named
>  `HEAD` contains the name of the currently checked-out branch.

I was briefly wondering whether we also want to replace SHA-1 with
"object hash" while at it, but it's certainly out of the scope of this
patch series.

Patrick

--76hIK4E59uift2hq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmWABsgACgkQVbJhu7ck
PpQ/iA//fkZqOpW4ipGArhD+l9QszBpswdoJQcnU0803CxN1mZy30b1jhZIPew1V
umEddcfhNBeHydJAkr+lGpD0B38UabtTL0kTc0auvOAz8Cu1IHOnQnJgW6QYTOiY
scvrMBRwHgi9sgha4KeFdsy6/X0IzEvtTzBRoswkYrK9Vi9CD+T7fRa4EiTUld7F
T8wMWvdOrZs3WEQhkRMIjsaMWdARG6Hlf4Sex+KkerK5WDBoPEijqLPZBKdV5QUL
0Plj2rj1nXnsYuZAIAAUKfIZw351DI3hbDFLS0qBjVAKlWeDkhXvZJSZUiKZr2d2
tfQs/WGo/6NlcMEZS1JbcMu/9XSEsQUJS0x7PN8k3ZT81vp6T2SSCpsQzRQVjPf2
l80bPDNRj3ASjqXLVmV5NTY2TYafba3gUNhx3NbkoaZNiC8kT89uE2gFHkK8Emq1
BXMmuQ2mCtO7OzNpg3fJZzyCsmW8Cx8GA68FUtkmyzSsDRvjHsL1ZeotfdwtegbJ
Mjn0JHE6ODsNR0hMPltdTaHVv0opO1vwAKKuVH4Axg9Cb+8Du6lUiZaBWCDKUUAB
jw0iTtUCg7bxHbINwbh96Xy4MN/X7e0BxRHQbJ4Qg2XJiCod4ByuWG534KitkZss
50le3j3J3kcU4hdkHv+ZUKXFSC2Kz5zKvyBZKnNnwXPlzAw/FEQ=
=NDFG
-----END PGP SIGNATURE-----

--76hIK4E59uift2hq--
