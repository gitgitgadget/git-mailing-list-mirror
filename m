Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1CCF63AA
	for <git@vger.kernel.org>; Thu, 28 Dec 2023 08:56:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="GNWIVVP2";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="vA8MAd0j"
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailout.nyi.internal (Postfix) with ESMTP id 393065C009A;
	Thu, 28 Dec 2023 03:56:29 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Thu, 28 Dec 2023 03:56:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1703753789; x=1703840189; bh=hmFuXjQvUW
	qEmNU/1VHhxWYJ0vZ2jW7/6/OR3hEsH8w=; b=GNWIVVP2Ma5M6L5SSAubPpUJHG
	cJhxM0GXfgScypYOUpN2Gx4smBilk3NGBoLXki8xukqYMB+LjLQADolo+CGQZLTo
	PQmdcRm06KNXISs6L05+DgbnhOCgTLnUj0idKZxFtoYVz0pkadJpGafYXkGdHX/s
	yMKF4n4mIU4IgQLJrZKQU6WTYVjOE9ll2rTviN2JCbKAXa7KrM54g+wrnwcNP25u
	SQAgc2af078H/HwGG+ZZIiFHLxaiN7kLIuyq1FfwWCoTyai37zt5xM74mAa96HV0
	dUGkF8/J/oMNPexttWG2zNdSHHfK8njA8n/mC5Bqf2X5nS/z6Of+1KgcPf7g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1703753789; x=1703840189; bh=hmFuXjQvUWqEmNU/1VHhxWYJ0vZ2
	jW7/6/OR3hEsH8w=; b=vA8MAd0jjp/iGbjEaUry0T6kk9eg7R8EDFBiO5/sC2IK
	D8ai1lIkNs33bhZOUX5GfHgTqq7uex5JaHQryl86fA2pJ6EftIzasBhgM/2gVe0f
	xJyq+kX1/vX5g9nhRh+v+VTUKoYtSWE6pY45wQA/hPwPCOTXeUhEijsXvYUmn7Qz
	dERjxp2xAHnK4QCcNHTX3+UFXKXUvvcEaVD0pCDGaXgUO5THU5H+srv872S2yCrL
	oZnoE6KWI57fN5UFGViqjVTAAWRWRJyTsjh4NZjJzUJ7SFe0ENiQNd1dgCu0P6rs
	K29AjHzeaFHTTFkJjGLRVJJ/FB/My0oM1MOJ/AsFUQ==
X-ME-Sender: <xms:PTiNZegscAFAS8zVvuGmgz96CR-gj3j1GPmLWT5xVa2WmqfCxu17Xw>
    <xme:PTiNZfCq8UI1dNgjVZq_iLRItbviK3V5C_hPqYztrjbqlHW0GYp8Tdd6ynWIxRzZT
    8KLD_Obb06S9PZ79Q>
X-ME-Received: <xmr:PTiNZWHAGU2PfEfxJuQw-GlhpD-F54ofF8uWcFjKWZdE73sn1fEuIqxiXfVVOD9x_D4RWZqHDCbUVRwIIz6wD-jQeiQEQmjk398fz_aikDgbPw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvdeftddguddvjecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecunecujfgurhepfffhvfevuffkfhggtggujgesgh
    dtreertddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhs
    sehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepueektdevtdffveeljeetgfehheeige
    ekleduvdeffeeghefgledttdehjeelffetnecuvehluhhsthgvrhfuihiivgeptdenucfr
    rghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:PTiNZXR7HbP3pBs85qnuKxbOyLYtRHElwp_xLskEfsQwHi4t0V6yUw>
    <xmx:PTiNZbyMq2OYYOTJneJBWnNBKlGtt7cAAG00BNDHCY2h3FSk-uwFqQ>
    <xmx:PTiNZV5wstZSWjaDX1dC3morlmo6gOHLkEztNBfyFG1AhERycsP7Iw>
    <xmx:PTiNZZYoICQ_2QUtvN3lVC98aXjFONmiqjrNYR3P76j-2h_OSW1DkQ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 28 Dec 2023 03:56:28 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id f03a139b (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 28 Dec 2023 08:54:14 +0000 (UTC)
Date: Thu, 28 Dec 2023 09:56:26 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 04/12] setup: start tracking ref storage format when
Message-ID: <ZY04OlTNUEZs5T-T@tanuki>
References: <cover.1703067989.git.ps@pks.im>
 <6564659d403de098799ddb8101b74c2803a655d4.1703067989.git.ps@pks.im>
 <xmqqv88ssp4r.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="xk1DPiMW1zMGnZT9"
Content-Disposition: inline
In-Reply-To: <xmqqv88ssp4r.fsf@gitster.g>


--xk1DPiMW1zMGnZT9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 20, 2023 at 10:30:28AM -0800, Junio C Hamano wrote:
> There is a topic in-flight that introduces the .compat_hash_algo
> member to the repo_fmt structure.  Seeing a conflict resolution like
> the attached (there are many others that are similar in spirit), I
> have to wonder if we want to add repo_set_ref_storage_format()
> helper function.  There are many assignments to .ref_storage_format
> member after this series is applied.
>=20
> Note that I haven't read the series in full, so take the above with
> a grain of salt---it might turn out to be that direct assignment is
> more desirable, I dunno.
>=20
> Thanks.

Wrapping this in a `repo_set_ref_storage_format()` doesn't add much for
now, but on the other hand it also doesn't hurt and is more in line with
how we set the other formats. This could also be useful in the future to
have a central place for additional sanity checks, if required. So yeah,
let's do it.

Makes me wonder whether we should then also add the following diff to
"setup: set repository's format on init" when both topics are being
merged together:

diff --git a/setup.c b/setup.c
index 3d980814bc..3d35c78c68 100644
--- a/setup.c
+++ b/setup.c
@@ -2210,6 +2210,7 @@ int init_db(const char *git_dir, const char *real_git=
_dir,
 	 * format we can update the repository's settings accordingly.
 	 */
 	repo_set_hash_algo(the_repository, repo_fmt.hash_algo);
+	repo_set_compat_hash_algo(the_repository, repo_fmt.compat_hash_algo);
 	repo_set_ref_storage_format(the_repository, repo_fmt.ref_storage_format);
=20
 	if (!(flags & INIT_DB_SKIP_REFDB))

Patrick

--xk1DPiMW1zMGnZT9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmWNODkACgkQVbJhu7ck
PpRbpQ/9GFyqvfFVDxS67HM6VWHhk1eZXKOf5ED5+uJCnzoXrS8pspNYWHJZd1Jb
NQtp5USRP5fI8d/xLc7jhc1PBHCC/KRsFDk7RH+djf4jEXVTRVwyNkGOJY8OFftv
QwzJqjVn5u257TWr4d4/TsqseoIrNnBeLmIq19DS/Xkgz+NfsIPykeUUHdpnG7K1
4walNxfW2Ep/JAHvIH/U83NHA6k5+yc0Be+z+Fmf5lXPiqR3cPbwnXl/5JQq0mdr
98l5Et7cJaOLNs45il1LOzkmmX9spa+FeGR07x+rW/utKQ4gab9Qp9rKRnmwHjIj
D3v9sWFJSl48Sm0NL7hLARS5DZ4OjkB7qgk8vh9OcAhJaPYgys3frtJoiXKzLgFv
aFC6CIAOOr19lbDOftob2MYeNvJtdOJUEMX/TKcRnH61zxTpALiFTjQekvX9icDc
59kIs+7FyGRwyehawfk0ylnTGWlrEoK6l3aRXl2WQiN3sxfnGS5Iq+gHn2vt418R
nh1Ta5J4MAtmVXec6LLeocPYPnS2Nn6fP6BsfqVvBKcEgn2Hxvv2tzAr40np5j3r
X8AEaY6xj6p7LwjO/8TB4iaXV0sLGfSwn3zAU7bL2RPLl3IJ5sjDF/B3DXZ1YIvS
FbM7mcw8GTLIQINIVoClYqCZeRQm1VT69uv+jzfAsCk7ioOO6Mo=
=+U5i
-----END PGP SIGNATURE-----

--xk1DPiMW1zMGnZT9--
