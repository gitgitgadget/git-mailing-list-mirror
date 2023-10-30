Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1CFCCA77
	for <git@vger.kernel.org>; Mon, 30 Oct 2023 10:46:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="flSj2xWD";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="CQzMYlb6"
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com [64.147.123.20])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE69DB4
	for <git@vger.kernel.org>; Mon, 30 Oct 2023 03:45:57 -0700 (PDT)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailout.west.internal (Postfix) with ESMTP id 77A4F320098D;
	Mon, 30 Oct 2023 06:45:54 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Mon, 30 Oct 2023 06:45:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:sender
	:subject:subject:to:to; s=fm3; t=1698662753; x=1698749153; bh=uO
	13b6aFTVnhHpmgOEgRm/K0krMgTHDDmyE0U4jeOa8=; b=flSj2xWDl6hm2Wx/8M
	rWBpJKgToDIKekcFYvLw1hjxC924CtI3YVky08+iPuSwYwuNtT9sfltiMAUUf7Ul
	1b0bDk7vC5A+zg+1Tlh//qYe5SiBSTSzfffBJaHnx5qR4g110tR1SpSJ9LYLwwy7
	TWjkGZa6NMt2h4fOKhZYphVZ3GH2fr9QhnW48dk6Ceu7PjerGYZ6whHTBMojXTKX
	7hd4BY6ZYvzNWxo/XGuGFW2pRCazpfUbFiEvpDMxesyWT7kT/y7Xxb77PMcpCaL3
	8tNEESAXfBD/wchloDIwOQYo7JQMNJ+SFqUwUqLfQ7akaHqnHJParyVZBRi6B4AL
	zE6g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:sender:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm3; t=1698662753; x=1698749153; bh=uO13b6aFTVnhH
	pmgOEgRm/K0krMgTHDDmyE0U4jeOa8=; b=CQzMYlb6STJnpaCLt0CEcwMZb9C48
	P/of+i6cI9r2LNEcZ7osEWOCWMvc0ly32/QQN47CwhnJPHJqFgIqwKKgCIgCzxl0
	ZgggyEB8fy8MueGDfxWifzlHNgFdYef7cKetaJ9KUMZEvCMHBu7BViJ1CiWWKkpN
	k64BdkovHSj+fUq2ttOs6p/7fNYLGLUMuxNzoITFaSG9vX9dWVafvfoTABFNfG6k
	3LqjDlVVdBrQ6aMxf0j037eCMwLVBrb8yTjsKypBkfwnLWz0Hh//AKCHWPz9oZz6
	T6W8QnRQpyMY/txJndkpfLe+sjcDH75D13L4PaHylod0SuOV8ot7USmag==
X-ME-Sender: <xms:X4k_ZSr00fljht3g_KRwy8nN5-DSIcPGPCAvLCIbT9You03Hpy8ZFQ>
    <xme:X4k_ZQrOcMoGBQnZhsctxDve_U9fRkWYRwwKaNBgibpw92feOckOc7v8JLA2zoxO1
    Hjdu4igQJ7ftxsJ6Q>
X-ME-Received: <xmr:X4k_ZXMOvR-fUA3ZEmMl7jtEdbtrgkSUwPN4oJA7uPzKCFUEPVMJ7MOUr6o4xoHa26gO3LDjfNpkKjFon2B3zRczl7J2cw9rJMikyt0fmW2vWA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedruddttddgudekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnheplefgiedtffekvdetffegudeuvdfftdffheetfeelffevvdffhedvffegleeggeei
    necuffhomhgrihhnpehgihhtlhgrsgdrtghomhenucevlhhushhtvghrufhiiigvpedtne
    curfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:X4k_ZR7lYa8Kt1yOuMffmiOdqoBpq2btHJKWiOcf4GDyyLdaTUx9rA>
    <xmx:X4k_ZR5Gcxg4RrYJ0IjKrUWITadGsIBKexz8OWCgvRHSFPLmRjQzEA>
    <xmx:X4k_ZRhroiLRpoxJBZBqpT7VTBtzEGnwdLkGtc6Yn_ZGn2jJ72PorQ>
    <xmx:YYk_ZTQ2mUOF4Yt_TJNOIhag6A0sXoTVwqJ1Rn98HJTxufjNOs17Tw>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 30 Oct 2023 06:45:50 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 4239d7e0 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 30 Oct 2023 10:45:42 +0000 (UTC)
Date: Mon, 30 Oct 2023 11:45:46 +0100
From: Patrick Steinhardt <ps@pks.im>
To: phillip.wood@dunelm.org.uk
Cc: git@vger.kernel.org, Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
Subject: Re: [PATCH v2 5/5] ci: add support for GitLab CI
Message-ID: <ZT-JWtD_bf0RLAYR@tanuki>
References: <cover.1698305961.git.ps@pks.im>
 <cover.1698398590.git.ps@pks.im>
 <37a507e9b255dd40c0536438dfe3fa05b067f08f.1698398590.git.ps@pks.im>
 <0d889da1-7fd8-4e21-965f-6222e4433ecf@gmail.com>
 <ZTucxlBR1VrJPuSK@tanuki>
 <a165fd76-a44b-45c7-b02c-e9b90fda3db3@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="E6YxArteJt5z6ZYN"
Content-Disposition: inline
In-Reply-To: <a165fd76-a44b-45c7-b02c-e9b90fda3db3@gmail.com>


--E6YxArteJt5z6ZYN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Oct 29, 2023 at 04:27:44PM +0000, Phillip Wood wrote:
> Hi Patrick
>=20
> On 27/10/2023 12:19, Patrick Steinhardt wrote:
> > On Fri, Oct 27, 2023 at 11:19:04AM +0100, Phillip Wood wrote:
> > > On 27/10/2023 10:25, Patrick Steinhardt wrote:
> > > > +  parallel:
> > > > +    matrix:
> > > > +      - jobname: linux-sha256
> > > > +        image: ubuntu:latest
> > > > +        CC: clang
> > > > +      - jobname: linux-gcc
> > > > +        image: ubuntu:20.04
> > > > +        CC: gcc
> > > > +        CC_PACKAGE: gcc-8
> > > > +      - jobname: linux-TEST-vars
> > > > +        image: ubuntu:20.04
> > > > +        CC: gcc
> > > > +        CC_PACKAGE: gcc-8
> > > > +      - jobname: linux-gcc-default
> > > > +        image: ubuntu:latest
> > > > +        CC: gcc
> > > > +      - jobname: linux-leaks
> > > > +        image: ubuntu:latest
> > > > +        CC: gcc
> > > > +      - jobname: linux-asan-ubsan
> > > > +        image: ubuntu:latest
> > > > +        CC: clang
> > > > +      - jobname: linux-musl
> > > > +        image: alpine:latest
>=20
> I assume you've chosen the configurations from the existing GitHub Actions
> that give the best coverage of the various options. One thing I noticed is
> that the is no equivalent of the "pedantic" job that builds git with
> "DEVELOPER=3D1 DEVOPTS=3Dpedantic"

Yeah, indeed. The list for sure isn't complete, and I also want to
iterate in the future to add support for macOS and Windows. But adding
the pedantic job is easy enough, so I'll include it.

> > > > diff --git a/ci/install-docker-dependencies.sh b/ci/install-docker-=
dependencies.sh
> > > > index d0bc19d3bb3..1cd92db1876 100755
> > > > --- a/ci/install-docker-dependencies.sh
> > > > +++ b/ci/install-docker-dependencies.sh
> > > > @@ -16,9 +19,13 @@ linux32)
> > > >    	'
> > > >    	;;
> > > >    linux-musl)
> > > > -	apk add --update build-base curl-dev openssl-dev expat-dev gettex=
t \
> > > > +	apk add --update git shadow sudo build-base curl-dev openssl-dev =
expat-dev gettext \
> > > >    		pcre2-dev python3 musl-libintl perl-utils ncurses >/dev/null
> > >=20
> > > It would be helpful to explain the new dependencies in the commit mes=
sage. I
> > > can see why you're adding sudo, but how were we getting away without
> > > installing the other packages for GitHub Actions?

I've dropped the "git" dependency for now. It doesn't do anything useful
anyway for our Docker-based jobs. Instead, I've added a preparatory
commit that makes the relevant CI library functions more robust by
detecting the case where we either don't have Git available or don't use
a repository.

> > True, that part is missing.
> >=20
> > - Both sudo and shadow are now required because of `useradd` that we use
> >    to set up the unprivileged build.
> >=20
> > - Git has been required all along, I think. `save_good_tree ()` is used
> >    in our CI scripts, and Toon (fellow GitLabber from my team) has
> >    noticed that the CI job warned about missing Git. The warning was
> >    mostly benign as it seems, but still, doesn't hurt to fix it while at
> >    it.
>=20
> Oh I had a look at this and the docker based jobs on GitHub do not have a
> git repository so installing git means we now get a repository not found
> error from save_good_tree() instead. We should probably make
> save_good_tree() and check_unignored_build_artifacts() return early if th=
ere
> isn't a repository but that's orthogonal to this series.

Yup, done now.

> Looking at the test output from the link in your cover letter we should we
> should also install apache2[1] and gnupg[2]

True. Also missing are Bash, CVS, the Perl CGI module, Subversion and
Perforce. I'll add them as available in the respective distro's
repositories.

Patrick

> [1] https://gitlab.com/gitlab-org/git/-/jobs/5349205374#L1444
> [2] https://gitlab.com/gitlab-org/git/-/jobs/5349205374#L1167
>=20
> Best Wishes
>=20
> Phillip

--E6YxArteJt5z6ZYN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmU/iVUACgkQVbJhu7ck
PpRvBQ//VFlFDkvi7/w8QDcVR3ijFXHQ/k8uR8YeJ1xCNy+7cPnrOIeNSM0gI2YE
7rY9F/Z2QEFg01L18xUCGGy5Bz4wFWI2X0vm0cJi4nvBWgb/w6hD5duYztwI4nkB
fAotwtT9vlpAVgMZAcntmNWWbY5Q3XNIu1zZh22cS9gXAnrfUA000pwx5mA2aE71
v5bocuwerZ5PD4nq5IXK7x0Q1Yj47WOvhhv8V6BwydWETLOLSJ22M5QqyPkjw0JS
BJQ6j/fwPQoRBsLGJ/10u9zg7MvVMrIVGEzq3zXeGfDTz5wB4F33JZ7G6DA1sRS/
U8/pu+1Dq5sJejYUMwZR8wV6uCDBc+U0nIVvyWJCMAG0TLEYoBeKtDWUmMjzxiU4
FS0gdVSX3hXtVKHxW2q2yrynV6DpL4RB82U2uVgqRXCzI0foc+xSrOgM60Ype7XS
431tz5A11ls0idHQiARSHzVYVluPdEbs7heLcJPWdyUFgwIR3/dFkaxoQXrjFpYI
mH/u4EnCnpNrcVTryQ5L7FnacZyP+SHXDKnGOQVQnT4rUrYq0kHqYVBA/7wh1S1+
/mRtWD0DwnMouyTFtyY0ox1vFAvfHxna6k/AECjKTI+aeR/+O4aqxKaQYwcAW7m1
Bvmmcoco7Bi1manQQvlTIbDfFzQEGgjIKcDpG7y6LWR9biQM0jc=
=92mz
-----END PGP SIGNATURE-----

--E6YxArteJt5z6ZYN--
