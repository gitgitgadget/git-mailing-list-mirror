Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6702AB67E
	for <git@vger.kernel.org>; Mon, 30 Oct 2023 15:19:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="MsQHTTxL";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="dUjassHK"
Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com [64.147.123.19])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DEBDA9
	for <git@vger.kernel.org>; Mon, 30 Oct 2023 08:19:22 -0700 (PDT)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailout.west.internal (Postfix) with ESMTP id 8BDE032009D3;
	Mon, 30 Oct 2023 11:19:18 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Mon, 30 Oct 2023 11:19:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:sender
	:subject:subject:to:to; s=fm3; t=1698679158; x=1698765558; bh=yt
	NfwqF34jCZk9JwP89JPeyyZqMCNapzujX3x1xME2o=; b=MsQHTTxLxXzsCpLObV
	HLuxqzCo8A9LuY1WY9sloWQaAkf99+M8DOmL+0GqBfdhS+DG0SzUrD40Q1+ognRV
	mSWPS7Q5RPRUrlCSjl/lA1VDvZGSSUaePJjecETffmWQKJTxo/2tyyq/YNhKKvkO
	aFKR5gdB7JAtMrenY9zwqtHMsWE99Ls9ciTlOeUFXTjuQnfMdKJU5b/cfvGPmimx
	jXQecyawz0UDeTrQRULrYeTKY05IrDWVmcLeKKSKp2CPa2zUAV/i98e8/s6Ihf36
	PfG1ZhgYWZdqpZlmy0x9ZHhxs2VSzL3ZT4rwqIEfKtzEHt9PaKII9uKjIpAzvbTF
	9kIw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:sender:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm3; t=1698679158; x=1698765558; bh=ytNfwqF34jCZk
	9JwP89JPeyyZqMCNapzujX3x1xME2o=; b=dUjassHKWAUPJpIAFFptxOFaI29uV
	pKfs66dGM7VQAPiZUFaNzYFvFmGjjNaQzrzZgh9egExYcgKXo8LNx/PDsc+xrcqb
	jZcqhlfLd1M8uugYfSXy1tQn+oPBxx+kDmNi4tvcXCt1gMGkwcT/C8VW9woUCQyS
	KC5h3Iik6dq6mnGlO9mScK7s9YiBOB1BrDOUV0KGUl0+fPgowUmhHLyZina1WSCD
	PMJPiZvBBjFYdgW0cXISiDMO2SnTuJkS7luNDmCKcoyd8OJHDOXiarjHJOO3uITg
	/JUNwFpSfKiH1eECNOQOn78bM8qc/rHRWyEN5Mc7oLZRQcpNl7tNa3tgA==
X-ME-Sender: <xms:dck_ZV6Kyeh4c_RaKYOVrLxE2dAUVCY4TAatkiIRQ-L6thN8c7kjqw>
    <xme:dck_ZS56voor08sbWWNfVbRTKQ5zXQKctUe5yhzm7-hXjZSQ3TlHTAS3c-SSigJnP
    GxNNydf4x_xOojNsg>
X-ME-Received: <xmr:dck_Zcexp7JPTY1GnG4LO2scbmfqtEmcPROpMKqP3hWWC4MGaLqrEYrTRB4l46uDswbe4DVH4AqYlMXyJjoG_OWUBPy8z6xDAg76SGM8kWRkdA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedruddttddgjeegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:dck_ZeLndnU44oDqNzfxxiXt68zXsSxkjUEso51USJ79xWzMIxqYdg>
    <xmx:dck_ZZKLkdR468bM-swRprfoqSnHJr6Lu9iFINprkkVa-2OiADo6Sg>
    <xmx:dck_ZXw13AynXlGRDPm1BL55bs2b0cyiZsC5EVDvtWRWnki6kv24nA>
    <xmx:dsk_ZQW5V2OPb-xANEwH1m-oEOGFtdTWU0SdjzNwl3NrMhvnHLMkHQ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 30 Oct 2023 11:19:16 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id ac1c94ce (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 30 Oct 2023 15:19:08 +0000 (UTC)
Date: Mon, 30 Oct 2023 16:19:12 +0100
From: Patrick Steinhardt <ps@pks.im>
To: phillip.wood@dunelm.org.uk
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
Subject: Re: [PATCH v3 5/8] ci: unify setup of some environment variables
Message-ID: <ZT_JcNH79ncQhzPD@tanuki>
References: <cover.1698305961.git.ps@pks.im>
 <cover.1698667545.git.ps@pks.im>
 <6af0075fd875f176e7fdf6c219e7117dac5cd71c.1698667545.git.ps@pks.im>
 <87430c6c-91c0-4be1-b89d-bf442b3f018b@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="NaOj42E7fjjh0G3D"
Content-Disposition: inline
In-Reply-To: <87430c6c-91c0-4be1-b89d-bf442b3f018b@gmail.com>


--NaOj42E7fjjh0G3D
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 30, 2023 at 03:09:01PM +0000, Phillip Wood wrote:
> Hi Patrick
>=20
> On 30/10/2023 12:15, Patrick Steinhardt wrote:
> > Both GitHub Actions and Azue Pipelines set up the environment variables
> > GIT_TEST_OPTS, GIT_PROVE_OPTS and MAKEFLAGS. And while most values are
> > actually the same, the setup is completely duplicate. With the upcoming
> > support for GitLab CI this duplication would only extend even further.
> >=20
> > Unify the setup of those environment variables so that only the uncommon
> > parts are separated. While at it, we also perform some additional small
> > improvements:
> >=20
> >      - We use nproc instead of a hardcoded count of jobs for make and
> >        prove. This ensures that the number of concurrent processes adap=
ts
> >        to the host automatically.
>=20
> Sadly this makes the Windows and MacOS jobs fail on GitHub Actions as npr=
oc
> is not installed[1]. Perhaps we could do
>=20
> 	--jobs=3D"$(nproc || echo 2)"
>=20
> instead. (Maybe 2 is a bit low but the current value of 10 seems pretty h=
igh
> for the number of cores on the runners that we use)

Ugh, thanks. I'll update it to keep the hardcoded 10 jobs in place for
now for the other pipelines. Trying to do too many things at once is
only going to make it harder to get this landed, doubly so when you have
no easy way to verify what you're doing :)

> >      - We now always pass `--state=3Dfailed,slow,save` via GIT_PROVE_OP=
TS.
> >        It doesn't hurt on platforms where we don't persist the state, so
> >        this further reduces boilerplate.
> >=20
> >      - When running on Windows systems we set `--no-chain-lint` and
> >        `--no-bin-wrappers`. Interestingly though, we did so _after_
> >        already having exported the respective environment variables.
> > >      - We stop using `export VAR=3Dvalue` syntax, which is a Bashism.=
 It's
> >        not quite worth it as we still use this syntax all over the plac=
e,
> >        but it doesn't hurt readability either.
>=20
> I don't mind this change, but the 'export VAR=3Dvalue' syntax is in POSIX=
[2]

I don't quite mind it, either. The reason why I chose to use it is that
there was indeed a bug already with the order of exports and
modification of the vars after the export. So with that in mind it made
sense to me to adapt it accordingly.

> > Signed-off-by: Patrick Steinhardt <ps@pks.im>
> > ---
> >   ci/lib.sh | 24 ++++++++++++++----------
> >   1 file changed, 14 insertions(+), 10 deletions(-)
> >=20
> > diff --git a/ci/lib.sh b/ci/lib.sh
> > index 9ffdf743903..c7a716a6e3f 100755
> > --- a/ci/lib.sh
> > +++ b/ci/lib.sh
> > @@ -175,11 +175,7 @@ then
> >   	# among *all* phases)
> >   	cache_dir=3D"$HOME/test-cache/$SYSTEM_PHASENAME"
> > -	export GIT_PROVE_OPTS=3D"--timer --jobs 10 --state=3Dfailed,slow,save"
> > -	export GIT_TEST_OPTS=3D"--verbose-log -x --write-junit-xml"
> > -	MAKEFLAGS=3D"$MAKEFLAGS --jobs=3D10"
> > -	test windows_nt !=3D "$CI_OS_NAME" ||
> > -	GIT_TEST_OPTS=3D"--no-chain-lint --no-bin-wrappers $GIT_TEST_OPTS"
> > +	GIT_TEST_OPTS=3D"--write-junit-xml"
> >   elif test true =3D "$GITHUB_ACTIONS"
> >   then
> >   	CI_TYPE=3Dgithub-actions
> > @@ -198,17 +194,25 @@ then
> >   	cache_dir=3D"$HOME/none"
> > -	export GIT_PROVE_OPTS=3D"--timer --jobs 10"
> > -	export GIT_TEST_OPTS=3D"--verbose-log -x --github-workflow-markup"
> > -	MAKEFLAGS=3D"$MAKEFLAGS --jobs=3D10"
> > -	test windows !=3D "$CI_OS_NAME" ||
> > -	GIT_TEST_OPTS=3D"--no-chain-lint --no-bin-wrappers $GIT_TEST_OPTS"
> > +	GIT_TEST_OPTS=3D"--github-workflow-markup"
> >   else
> >   	echo "Could not identify CI type" >&2
> >   	env >&2
> >   	exit 1
> >   fi
> > +MAKEFLAGS=3D"$MAKEFLAGS --jobs=3D$(nproc)"
> > +GIT_PROVE_OPTS=3D"--timer --jobs $(nproc) --state=3Dfailed,slow,save"
> > +
> > +GIT_TEST_OPTS=3D"$GIT_TEST_OPTS --verbose-log -x"
> > +if test windows =3D "$CI_OS_NAME"
> > +then
> > +	GIT_TEST_OPTS=3D"$GIT_TEST_OPTS --no-chain-lint --no-bin-wrappers"
> > +fi
> >
> > +export GIT_TEST_OPTS
> > +export GIT_PROVE_OPTS
>=20
> I was wondering why we don't export MAKEFLAGS here but it is exported
> earlier on before we set it. Apart from the nproc issue this looks like a
> nice improvement

In fact, I also noticed later today that we adapt MAKEFLAGS at a later
point again without reexporting it, so it's got the same issue. I'll
adapt it in the same way.

Patrick

--NaOj42E7fjjh0G3D
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmU/yXAACgkQVbJhu7ck
PpSO5A//QrA8AvFea3shejopGjIYXpchAC/1W6hv9/6zRwj36ul/UvW353Z04xme
hN56k/UKkhoUQPR1TK5gLaR7pLU6I17EE6ZO4d+XBZ3ar+860J6x89KahwyhBZXd
EHP6esniMHew93M25qnttaX+DyV8oRuWVa9avPlWhw/Yxto3JOgTR7XeAbFOew/7
TnVUXVom2AdnBtUPvx6wfplW8KxkcP45s2U9ldYQxoCXgGbvbP+uv+aotMKhQC5u
iDWLcbjgcWd1rgxNQmlR1YyBd5nfYG6Re2BfXZykrzdmk7qEvYn4e/CqWaQdiK1x
BiqyElDH67w0cer2rizuJiu5jaPtkDPI0RgBpWjV9xX9w+kmGaL25smskA2fIDRh
CesmzpPHBOD0wRSp0RCWYx2rpTJnn9SSUq7cabriArSStOQmDD6nK1aM6FXjblI4
wHmmNI70AHccd9VlVGKw5gJo7eBV4E3sr26wpMznZQCtWYKcQm/fEgk921A2VO+E
eWhFYwhJXLbkAhCwCgqyjOCuPdpUQLwE2ilJ/8b2zpPAiWHF6VN2+ToiFInj3uID
d7CDVkFAaMLIgSNZhQspCIven2/Sp30GZPqtSuwWrKrOerHexee5M764+jwQNKy6
xfU69LzYfL7kb9s3UTWGOsJwJEQeesqR5i8szbtlODpc4GI9r1I=
=CSRE
-----END PGP SIGNATURE-----

--NaOj42E7fjjh0G3D--
