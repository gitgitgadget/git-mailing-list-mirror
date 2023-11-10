Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DEFA79E6
	for <git@vger.kernel.org>; Fri, 10 Nov 2023 08:17:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="apgB4r8c";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="U/9hgTJO"
Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 063AE93C5
	for <git@vger.kernel.org>; Fri, 10 Nov 2023 00:17:04 -0800 (PST)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailout.west.internal (Postfix) with ESMTP id 516253200A83;
	Fri, 10 Nov 2023 03:17:02 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Fri, 10 Nov 2023 03:17:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:sender
	:subject:subject:to:to; s=fm3; t=1699604221; x=1699690621; bh=tO
	eDZz9dW13kMcOKwwOhvKtwQh6GTkwELCDm+VkP3Pg=; b=apgB4r8cbT9M2ZLM/B
	EUTlPQLJOmVTQXdFgMCq/rZln9ymiNfxZNheMjOd7xMnkZD6mPRSLwSF5v7ofWCf
	E6q7F9/wy5dIr6eO8huBU75yw24Y3IwsSWwwtyB96zf2pNiJqlX/xz5ozUIE8xoE
	lmT9N5/xYtvZ11aIOypZaCO9Bfar1H34PNdila4W77o/uDz/CT2jL2IRDdhhKsQA
	2hlHwreM/SASJWbP853a6UxTirS8KG83Se4dDXZT/ILINKhGkf8uFFYF08ULww9k
	dXzsETgArgXaJIk7ZcZGMVmYDkJa1p1JqDeKLzuRGkQxpTInAi2h6AmVDxk+ioqG
	/DkQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:sender:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm3; t=1699604221; x=1699690621; bh=tOeDZz9dW13kM
	cOKwwOhvKtwQh6GTkwELCDm+VkP3Pg=; b=U/9hgTJO6XSLfeIsUOZZlNyRuzz1E
	51QuSgMWHKqYqtAyCgtN4WtepRD/uaf4fKnE0394EA9+NPbP4AioxKz/x5xZhGAi
	E0AeheHXJQZMlzUnB+eY+eBR3KIphPzSjDIfV3zSYfxV6Ze2X+ebqAROXo6nWunp
	47sLawBz5LRfFk8A2OBFp4vX0QbYgXW5PlI5jKCnyZnQOnqIIJGS7ZBb+Qwg3qi2
	XPl3EzyPJtqJ9iPJJrYAEr+xPmVwE3TESOYqIGyiCArEsCuavdy5qbcbZ5IzvnvB
	8d8HVVBuGhPD5IMrDQrrBfSlZVV2cA6Oy59+ngnfe/tzqmRFJ7Er/EiYg==
X-ME-Sender: <xms:_eZNZYwZz1MKudcmZ4esJt3jJMN9OgXX-V-vHgihCF9_U8GH1Lb5CA>
    <xme:_eZNZcTEJ_3xn3A0P_lw8rJBdYHD8clsi66NYDxGDMUxqOBdahJifHk6Ht3ZenFPO
    lw4gfxVQPXNeZxXIw>
X-ME-Received: <xmr:_eZNZaU3x9hmRhNGl1nSsDuNbOtgUnLIXXn9UMNZpsTLGEMFAEm4DUKT12Y1_hxVfKodbyWzlh8zXyXM8CkgCSWn9CjQ1WyYOPj-N4krQkda0UuV>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedruddvvddgudduhecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecunecujfgurhepfffhvfevuffkfhggtggujgesgh
    dtreertddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhs
    sehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepvdehteeggfevueevhedtleelveeigf
    efieduiefgvdfffeegvdeitefgteevveeunecuffhomhgrihhnpehhthhtphgurdhshhen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhm
X-ME-Proxy: <xmx:_eZNZWhb0O-pp5rxTd-P0MdAU6qowlcOFQg-RtbZFYfZhAIxKx0p5g>
    <xmx:_eZNZaAf-v1qhMk2cGhDEa6zLpuQZjvMUoiFwLAqj-rT5wYUASOFLA>
    <xmx:_eZNZXLTT0Scp_IBzLP-CT-3Uesybg5t5yG3jenjH0hZ5R2QE1_vGg>
    <xmx:_eZNZb5rADzCwCa0yXo-UBmwYohM8OzEbhFkJAqUAdJizxbkQquEWg>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 10 Nov 2023 03:17:00 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 275caccf (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 10 Nov 2023 08:16:29 +0000 (UTC)
Date: Fri, 10 Nov 2023 09:16:56 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v4 0/3] t: improve compatibility with NixOS
Message-ID: <cover.1699596457.git.ps@pks.im>
References: <cover.1699428122.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="nMdCVFr+PLDcaP8Z"
Content-Disposition: inline
In-Reply-To: <cover.1699428122.git.ps@pks.im>


--nMdCVFr+PLDcaP8Z
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

this is the fourth version of my patch series to improve compatibility
of our test suite with NixOS.

Three changes compared to v3:

    - Switched from `test <expr> -a <expr>` to `test <expr> && test
      <expr>`.

    - Improved the commit message to explain why the new
      runtime-detected paths are only used as a fallback.

    - Rebased on top of 0e3b67e2aa (ci: add support for GitLab CI,
      2023-11-09), which has been merged to `next` and caused conflicts.

Technically speaking this series also depends on 0763c3a2c4 (http:
update curl http/2 info matching for curl 8.3.0, 2023-09-15), without
which the tests will fail on NixOS machines with a recent libcurl.

Patrick

Patrick Steinhardt (3):
  t/lib-httpd: dynamically detect httpd and modules path
  t/lib-httpd: stop using legacy crypt(3) for authentication
  t9164: fix inability to find basename(1) in Subversion hooks

 t/lib-httpd.sh                        | 17 +++++++++++++----
 t/lib-httpd/passwd                    |  2 +-
 t/lib-httpd/proxy-passwd              |  2 +-
 t/t9164-git-svn-dcommit-concurrent.sh |  9 ++++++++-
 4 files changed, 23 insertions(+), 7 deletions(-)

Range-diff against v3:
1:  e4c75c492dd ! 1:  41b9dada2e0 t/lib-httpd: dynamically detect httpd and=
 modules path
    @@ Commit message
             - The module directory can (in many cases) be derived via the
               `HTTPD_ROOT` compile-time variable.
    =20
    -    Amend the code to do so. The new runtime-detected paths will only =
be
    -    used in case none of the hardcoded paths are usable.
    +    Amend the code to do so.
    +
    +    Note that the new runtime-detected paths will only be used as a fa=
llback
    +    in case none of the hardcoded paths are usable. For the PATH looku=
p this
    +    is because httpd is typically installed into "/usr/sbin", which is=
 often
    +    not included in the user's PATH variable. And the module path dete=
ction
    +    relies on a configured httpd installation and may thus not work in=
 all
    +    cases, either.
    =20
         Signed-off-by: Patrick Steinhardt <ps@pks.im>
    =20
    @@ t/lib-httpd.sh: fi
     +			  "$(command -v apache2)"
      do
     -	if test -x "$DEFAULT_HTTPD_PATH"
    -+	if test -n "$DEFAULT_HTTPD_PATH" -a -x "$DEFAULT_HTTPD_PATH"
    ++	if test -n "$DEFAULT_HTTPD_PATH" && test -x "$DEFAULT_HTTPD_PATH"
      	then
      		break
      	fi
    @@ t/lib-httpd.sh: fi
      				 '/usr/lib/apache2/modules' \
      				 '/usr/lib64/httpd/modules' \
      				 '/usr/lib/httpd/modules' \
    --				 '/usr/libexec/httpd'
    -+				 '/usr/libexec/httpd' \
    + 				 '/usr/libexec/httpd' \
    +-				 '/usr/lib/apache2'
    ++				 '/usr/lib/apache2' \
     +				 "${DETECTED_HTTPD_ROOT:+${DETECTED_HTTPD_ROOT}/modules}"
      do
     -	if test -d "$DEFAULT_HTTPD_MODULE_PATH"
    -+	if test -n "$DEFAULT_HTTPD_MODULE_PATH" -a -d "$DEFAULT_HTTPD_MODULE=
_PATH"
    ++	if test -n "$DEFAULT_HTTPD_MODULE_PATH" && test -d "$DEFAULT_HTTPD_M=
ODULE_PATH"
      	then
      		break
      	fi
2:  3dce76da477 =3D 2:  7d28c32feaa t/lib-httpd: stop using legacy crypt(3)=
 for authentication
3:  6891e254155 =3D 3:  6a7773aadba t9164: fix inability to find basename(1=
) in Subversion hooks

base-commit: 0e3b67e2aa25edb7e1a5c999c87b52a7b3a7649a
--=20
2.42.0


--nMdCVFr+PLDcaP8Z
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmVN5vMACgkQVbJhu7ck
PpQxtg/+I4j2gnUvn2VvtB71D1ZlecF1UrquxX0++QWCZDQehSdUFRLUCfWaUzWs
o7EQDzXt/VN8ZV9+F89kCE6rXQGf79/WS8JVZmueBifHq/sOyWtkwg+WoX3y8rii
PO8Tt4Tw3WRON+TDaUurfqCtEr6ZCJIpafN5JVXe1zMaRB9UcmdybDVNK7KV5lvX
cGQydZ9y7IpYpVVd9Cmcxmp4YVmbp8O+DmrqL7GEcDAgsuEf3uD/HAy3M481VaU4
rNGW7rcdLKKDXVTPShmY4p/ShpYZjHoN2efQ7ornxKviBjbKNZx2IZEzzaSMQ8Jv
1b/LDUbThL1YftNH7b4jxWz/BYBMLRK2GJHHNxeaNkpaS+DmX+hhmrweLLNRBR0Z
elO/CMTgC/garc0DjTRYiWM4itqV6L2jAkoT0y1yeAzmnqugGl47lVznlWdZMnA6
BotJHtH2xxbPTrBdT668n5pfwDVcdN9MadbOu4zC+MNGe0DrzhkZLHBp8I+wkcTN
yh7zFZVPLoTSFDaMDjXACon3DzKCusxzRJSXBDbuzh08VXRev1tJ5C4/4v/8X3H3
Gv9ADcCvXRrxZHKW90dqbE7R4uCELvrfrh1Hn4kEPDl/o4VVsb7vrXnIrpKIGJ7I
0t4g5kSjyd3K7MAp/u+DIlRWrCeLvfjrdCraT/dcd8aHwphYk4k=
=A0Ks
-----END PGP SIGNATURE-----

--nMdCVFr+PLDcaP8Z--
