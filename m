Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0A373716F
	for <git@vger.kernel.org>; Wed, 10 Jan 2024 07:15:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="NHisGcYS";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="QUvOZ1bc"
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailout.west.internal (Postfix) with ESMTP id 98D6B3200B69;
	Wed, 10 Jan 2024 02:15:23 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Wed, 10 Jan 2024 02:15:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1704870923; x=1704957323; bh=kBNPAQY3Uk
	/HL8SiMYIsM+9Qhnx7MN40713v4WgqZGE=; b=NHisGcYSMzE7DP7P/Peu+MYScc
	83MWkDkUWp0k7t/OhGplIWM3lYU6OV6pRUVvICX5tTURV7GlH4GpmCpfswp3DcZA
	2FTT+abnUaCbAiiUhjaHYsu+V7PGqnZpPtEdG/GKQ1Tr5zJmJu7yHa/gU1BkQ/q0
	31w2wBUIHIbiOO7gipzE/k6c/c/T2YCRbWmTCvgcK074PUF/3DNxJDQHrDAXLPDi
	CDaBBdG1xPVdkvxkAyTqj6ErpiRvsJxqeWVQFGocQXzW9juRsmPFN0H1EimFVOqq
	kCPP+RvSxrQBdWqW8HUhQPH/cZ/EXCK9OjCYv4XnSXUtG/1vUFSNgYTpUE3w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1704870923; x=1704957323; bh=kBNPAQY3Uk/HL8SiMYIsM+9Qhnx7
	MN40713v4WgqZGE=; b=QUvOZ1bcJ7KXObSIkKNJrK0q2D8ZlDN/TM6UXsvqmrU+
	xNxYuRA0PZszjY+yWMbOvoqeLi1E4fuY4vYQHAxsfzoMgilmQynSz5vvnKsWXF+B
	BCmP9S4gC4a0aLjbKeOboPKjEm7NHVj590sMELdLWrhxhKg/wfjYO9tiQTA2UoSs
	6wsU7SC7er1/T9SFDO0txry64LNcGmDjXaO4Huy3sHMSoHnGnCzxg/SjNmqMtRjM
	08ApHIdnsGHRJwzP5lS/6r2aAz8ZmU5QPQUKJEun/pjwUhmU1EhLMhx/LdIjFcQl
	qrR8/IpRYgmylyaTOVQUi3L7pKMmiMCe2wKGAleiqg==
X-ME-Sender: <xms:CkSeZRn5xVHqmBMDgOSOXuOAKcMKsdxn03AjmNiLmIcCMm3KtPKbFQ>
    <xme:CkSeZc2hGUiXPUq6KK80E8t7jSgWwEoRLDdbnIf3HVF_-JE6osZFamE9Jz2wVc-53
    QZ6cezkZ8Nra_s6Gg>
X-ME-Received: <xmr:CkSeZXpqpKDa_pL8TFNa4Fg7gnKSfU8dzOHyF_uMTfvAHqCvYGfVXe9ZJxRoWXUORZVzDTnO7sV_fXCvNVZAKpSykG3XqimGCdnWPfe52Oa6vNc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvdeitddguddthecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecunecujfgurhepfffhvfevuffkfhggtggujgesgh
    dtreertddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhs
    sehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepueektdevtdffveeljeetgfehheeige
    ekleduvdeffeeghefgledttdehjeelffetnecuvehluhhsthgvrhfuihiivgeptdenucfr
    rghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:CkSeZRleBldJpo3VXy8_7aiDOx9toGoHO0H9yciEPCcVcTOVUcHumA>
    <xmx:CkSeZf1KkG_v7KQabIiPyfduzeBIcQ-AgGP3hntGWIu1HJp3Tmi8Jg>
    <xmx:CkSeZQvY8Su10hc5HLarhcwcejPEHy_rjvr_1644o6Tb5y6CLSAu0Q>
    <xmx:C0SeZc-cQiWVRFoG8JTInfH46ECddyzDnQqytSmT9IJ5ejytbMx-yQ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 10 Jan 2024 02:15:22 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id ee9a648c (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 10 Jan 2024 07:12:40 +0000 (UTC)
Date: Wed, 10 Jan 2024 08:15:18 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 1/6] t1300: mark tests to require default repo format
Message-ID: <ZZ5EBojTbQ4pyGx-@tanuki>
References: <cover.1704802213.git.ps@pks.im>
 <ec1b5bdd176e6a3f093b76b732fd9e960a7880ca.1704802213.git.ps@pks.im>
 <ZZ2TdYlcrLN9zckR@nand.local>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="TGxVJ9FiKJE61I3c"
Content-Disposition: inline
In-Reply-To: <ZZ2TdYlcrLN9zckR@nand.local>


--TGxVJ9FiKJE61I3c
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 09, 2024 at 01:41:57PM -0500, Taylor Blau wrote:
> On Tue, Jan 09, 2024 at 01:17:04PM +0100, Patrick Steinhardt wrote:
> > The t1300 test suite exercises the git-config(1) tool. To do so we
> > overwrite ".git/config" to contain custom contents. While this is easy
> > enough to do, it may create problems when using a non-default repository
> > format because we also overwrite the repository format version as well
> > as any potential extensions.
> >
> > Mark these tests with the DEFAULT_REPO_FORMAT prerequisite to avoid the
> > problem. An alternative would be to carry over mandatory config keys
> > into the rewritten config file. But the effort does not seem worth it
> > given that the system under test is git-config(1), which is at a lower
> > level than the repository format.
>=20
> I think I am missing something obvious here ;-).
>=20
> > Signed-off-by: Patrick Steinhardt <ps@pks.im>
> > ---
> >  t/t1300-config.sh | 8 ++++----
> >  1 file changed, 4 insertions(+), 4 deletions(-)
> >
> > diff --git a/t/t1300-config.sh b/t/t1300-config.sh
> > index f4e2752134..1e953a0fc2 100755
> > --- a/t/t1300-config.sh
> > +++ b/t/t1300-config.sh
> > @@ -1098,7 +1098,7 @@ test_expect_success SYMLINKS 'symlink to nonexist=
ent configuration' '
> >  	test_must_fail git config --file=3Dlinktolinktonada --list
> >  '
> >
> > -test_expect_success 'check split_cmdline return' "
> > +test_expect_success DEFAULT_REPO_FORMAT 'check split_cmdline return' "
> >  	git config alias.split-cmdline-fix 'echo \"' &&
> >  	test_must_fail git split-cmdline-fix &&
> >  	echo foo > foo &&
> > @@ -1156,7 +1156,7 @@ test_expect_success 'git -c works with aliases of=
 builtins' '
> >  	test_cmp expect actual
> >  '
>=20
> Looking at this first test, for example, I see two places where we
> modify the configuration file:
>=20
>   - git config alias.split-cmdline-fix 'echo \"'
>   - git config branch.main.mergeoptions 'echo \"'
>=20
> I think I am missing some detail about why we can't do this when we have
> extensions enabled?

The issue is not directly visible in the tests I'm amending here, but
happens in the setup code. What we do is to overwrite the repository's
config like this:

```
cat > .git/config << EOF
[beta] ; silly comment # another comment
noIndent=3D sillyValue ; 'nother silly comment

# empty line
		; comment
		haha   =3D"beta" # last silly comment
haha =3D hello
	haha =3D bello
[nextSection] noNewline =3D ouch
EOF
```

The problem here is that we drop any extensions that the repository has
been initialized with originally. This seems to work alright in the
context of SHA256 repositories. But with the reftable backend this
pattern will cause test failures because the discarded "refStorage"
extension will make us assume that the repostiory uses the "files"
backend instead of the "reftable" backend. And that starts to go
downhill quite fast when trying to read or write refs.

A "proper" fix for this issue would be to rewrite tests such that we
know to retain those extensions. But I'm just not sure whether that is
really worth it, mostly because the system under test is at a lower
level and thus shouldn't care about repository extensions. After all,
extensions build on top of our config code.

Patrick

--TGxVJ9FiKJE61I3c
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmWeRAUACgkQVbJhu7ck
PpTrSxAAjuraiStJjkK/Y5hWVXZaBO/wQ6aFdlx+mm9sqQqtNKpbMUpseKGP9QMD
pF20rC1B/MVR7zfAQ81dV1+PSih8E9fWY8pRIcnnNdYSek/1CIoxJvB3BThuR8ku
2FgkRh/Xfj05PBNdQ/Ts7sslpXH/3TKJCzOLmddIYzphlQ2nOM4TFfZxNxB148Ab
QQmDkC6oQ+19SESz2moEO82wD26O9FKJod85J2LDYZJITzpi3/p6g9xOI97a7inu
/PRkp0S00qTjyX89BU10Aw52ZmT8zKJl41DtoYR9IOo/beQlFkoumKaWSBIc6J7O
ZCdKiuLKjga1T8JN5aGoY/pmoNc4sOy7sFOlfz1E/g7uzL02QNdAtDsSIDvnPi6j
TUSv+irD7uGFL9tDaObRIqlqeBdt5ZZ6QIZMdvb4PjO/tEfo5t+vZ6v5LfQSobjp
LFLqc0oN+tAXuks4ujokbNHEY9H5LONHnoOgqVw4nu3WXDBtxOVcAACM/vDPDdzE
XCMostCz6ruXQtgrK7AX8AYngJJ9/UKFLIV3Htu4wWtBLxbEGUmONTL04pIxkWA4
0ANu4FEKwAdUJbNa6KeGuEgjbJFkRdr0rn6jvBkYSjxq/ObKT8fEOVXj7HWHJxVV
GEGDp+9YOyUFSw2N/4JIJ7q3Xx7LAsZ0afzi7uyTpoURoxDs1bY=
=5eoM
-----END PGP SIGNATURE-----

--TGxVJ9FiKJE61I3c--
