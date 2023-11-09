Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7A59FC0E
	for <git@vger.kernel.org>; Thu,  9 Nov 2023 07:57:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="kq+JZBMk";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="mhpL13dg"
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4A602712
	for <git@vger.kernel.org>; Wed,  8 Nov 2023 23:57:44 -0800 (PST)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailout.nyi.internal (Postfix) with ESMTP id 382F55C0330;
	Thu,  9 Nov 2023 02:57:44 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Thu, 09 Nov 2023 02:57:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:sender
	:subject:subject:to:to; s=fm3; t=1699516664; x=1699603064; bh=lT
	3nK7M/kNAFCc4BOTQLprfwIf+JSD9chYAOffBWGno=; b=kq+JZBMkBy3i2/vW8b
	6wvssDEhHgp7N6Ie1rTz8g1MU6xJ1ei2Oma1cxoHlAHhtPJX4/Jo64wbUhn/U3ey
	2cyFp6YzxhhYY0x5d4uiwqpdCBCNNnkUbYGOn9iYOIyrCpOKHcBbVRCW2vSjRraw
	36/xb/WfzL6/6gVpzu2mLYNLMm1myWmGSiNw0Ec3gAqFFuHJmc7mvZhNtS3mz92d
	G6wn+0CZeFC6VNY2vMlNe/OXQyLbsjv05jpLAlKHwFjsvn/cmqbdFRlHJB3JHIxH
	wPl2i4XFZm3Pwz44ZdjN/rbd/5Hi9OGl4TNU5MJXgvWTL3hm8ilBiL62G0AfAv+h
	vxng==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:sender:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm3; t=1699516664; x=1699603064; bh=lT3nK7M/kNAFC
	c4BOTQLprfwIf+JSD9chYAOffBWGno=; b=mhpL13dgMWD5lsKY7lPMYQcsyMUBs
	o9sPSgoTI97HEr9AEG55JmENaj+dlLuVhxhWMPMjM0Oghd9KjXtpiCuea6pllUEl
	pGCYxg6qTvWkYTIDZsLAbp3mpL2clzwnmszRwI+fJFJLJPmjtPdKqiLy9iBjCeLx
	8FN9fa4GvLGjpg1Qg4gTgha+QssCTUJ7CSSM2Q9+59ikqZRSJotes/JeqrPaG489
	oYcb+NAHEziiKtC4+G6TOiyMQUf1Hdys+ftLWBTObwIL1MT3+A1S3wbh536TjMQo
	+BgNWRuYGOBdnb/7RZhgAJHQsWUrRTdv1nnP4v4R/ofRtc0X9qQQUm3qQ==
X-ME-Sender: <xms:-JBMZfCxyltXtlxaKAZYIN0ZYrLTkL8LcTpaU61cCfP86b9KO1ANLw>
    <xme:-JBMZVh_YaKP_APgQCKi-1vbh8iRr8cE_rwbeKp6YQDQd6L-PYK5RAwEjWYlvsW_T
    8VM7BNggzc8U6sYFQ>
X-ME-Received: <xmr:-JBMZamgbGgT-Gp55_q3ZZbWMSsn448649tXWugTmwx_0fGM-5k2BZBvmODi0x8n89F_boH8DSBtMRJ5V6CM1KkQEQu41e7Lk_H8ohc03sasHkne>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedruddvtddgudduudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecunecujfgurhepfffhvfevuffkfhggtggujgesgh
    dtreertddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhs
    sehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepvdehteeggfevueevhedtleelveeigf
    efieduiefgvdfffeegvdeitefgteevveeunecuffhomhgrihhnpehhthhtphgurdhshhen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhm
X-ME-Proxy: <xmx:-JBMZRyqR_2kdFqs38hN_-ekPz2VJu2e7Z2H_n2Zgv9wAmYIpIzMBA>
    <xmx:-JBMZURabJDSco7azEpuM5fQnxWIL9sEWVv_jYVZMhXj2EaSP90uhg>
    <xmx:-JBMZUYj0oYkMdeE5olg_dbB0FAUazHP-j-9a9wMMJb7IDYhEjWhPA>
    <xmx:-JBMZfJcRz5W-nvxJ6daQ_55EgX4mIwEq0mYUbLLqdYAh9LD3AvWMw>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 9 Nov 2023 02:57:43 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 3f36c396 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 9 Nov 2023 07:57:15 +0000 (UTC)
Date: Thu, 9 Nov 2023 08:57:40 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
Subject: Re: [PATCH v3 1/3] t/lib-httpd: dynamically detect httpd and modules
 path
Message-ID: <ZUyQ9DOLccTeJElf@tanuki>
References: <cover.1699428122.git.ps@pks.im>
 <cover.1699513524.git.ps@pks.im>
 <e4c75c492dd89fd7464db2b3028b2bb9e6addbf8.1699513524.git.ps@pks.im>
 <20231109073250.GA2698227@coredump.intra.peff.net>
 <ZUyMFZ7c9_rlu5lk@tanuki>
 <xmqqzfzn1i9u.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="OWxjWq/UyzCEhbXO"
Content-Disposition: inline
In-Reply-To: <xmqqzfzn1i9u.fsf@gitster.g>


--OWxjWq/UyzCEhbXO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 09, 2023 at 04:46:05PM +0900, Junio C Hamano wrote:
> Patrick Steinhardt <ps@pks.im> writes:
>=20
> > Yeah, I was grepping for it in our codebase and saw other occurrences,
> > so I assumed it was fair game. If we're going to convert it to the
> > below, how about I send another patch on top that also converts the
> > preexisting instances so that the next one grepping for it isn't going
> > to repeat the same mistake?
>=20
> Yup, an independent clean-up would be fine.  Now we need to find a
> way to give better visibility to CodingGuidelines, which already
> says this:

Okay, I'll send one in. Do you want me to send a v4 of this patch series
or will you squash in below changes into patch 1/3?

>  - We do not write our "test" command with "-a" and "-o" and use "&&"
>    or "||" to concatenate multiple "test" commands instead, because
>    the use of "-a/-o" is often error-prone.  E.g.
>=20
>      test -n "$x" -a "$a" =3D "$b"
>=20
>    is buggy and breaks when $x is "=3D", but
>=20
>      test -n "$x" && test "$a" =3D "$b"
>=20
>    does not have such a problem.

I did indeed spot this part of our coding style now. I didn't bother to
look farther when I found other examples where we used `-a` and `-o`,
but that issue will be gone once we've dropped all of these usages.

Patrick

-- >8 --

diff --git a/t/lib-httpd.sh b/t/lib-httpd.sh
index 6ab8f273a3..0a74922d7f 100644
--- a/t/lib-httpd.sh
+++ b/t/lib-httpd.sh
@@ -60,7 +60,7 @@ for DEFAULT_HTTPD_PATH in '/usr/sbin/httpd' \
 			  "$(command -v httpd)" \
 			  "$(command -v apache2)"
 do
-	if test -n "$DEFAULT_HTTPD_PATH" -a -x "$DEFAULT_HTTPD_PATH"
+	if test -n "$DEFAULT_HTTPD_PATH" && test -x "$DEFAULT_HTTPD_PATH"
 	then
 		break
 	fi
@@ -78,7 +78,7 @@ for DEFAULT_HTTPD_MODULE_PATH in '/usr/libexec/apache2' \
 				 '/usr/libexec/httpd' \
 				 "${DETECTED_HTTPD_ROOT:+${DETECTED_HTTPD_ROOT}/modules}"
 do
-	if test -n "$DEFAULT_HTTPD_MODULE_PATH" -a -d "$DEFAULT_HTTPD_MODULE_PATH"
+	if test -n "$DEFAULT_HTTPD_MODULE_PATH" && test -d "$DEFAULT_HTTPD_MODULE=
_PATH"
 	then
 		break
 	fi


--OWxjWq/UyzCEhbXO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmVMkPMACgkQVbJhu7ck
PpTbXQ/+LPvpBqLFIbFjez6LJXMxKoDnEMGeZEW2CIaQYbA0MghVPJ1yFZknYRkS
/MARwyt+63LPPwOZm1BINpu9z1nMyTxgBKSk+0sx+UpQv2GSz4wjV6T686Yztxul
3rUReeJboiHiloZq0nTaBZXxdWyP9TAkjsdHrbo50o8blNz9/g51FQOkbBiEv4Qk
afVpt5nVBHZbDHuBchAWB2QqlnfEhxk/3KLFE3vJW700EKeoyNtk0ZIqRV0HLxkt
4c7CnEzSQ+qFiH8KsikFp0MHEtlaoLAdb429V2SAsoOd1hoEgewS28ZuSUmJNiHh
x0Uzt3B8B9aUholIU5oP/PX3/x/jeTu+jkJ91lna75wwjoQRc8CJfz/2e6Sdd24F
zmFowo51MxzdJvhzj6xL1zxOKc4Ms+rPYyPWTK+UORmcHxSNBWC86zVLysZK+NUP
eDhogO8c7quVXczeC317jEjfKfxI22tVkx/OUxftUuz43wNUNoLR7Dw3ZooOgsxI
zMO6zjyJeUXFl0VQPXxLR8fbp1vQKAGDASLZRurp6yOuGTf0oD1Yn1iLl8c4lR2q
LdDtGTm28gEbGl8W6cf6TuZbwvEhiBtwVjp2BmK2rFNt+c+FNk1G420ujMLGLq3r
DPMBJL8gH6oYlwpZ057QjBM+Nr32cc/+JJ9NgMDxa76JfMM4pNs=
=Wfdj
-----END PGP SIGNATURE-----

--OWxjWq/UyzCEhbXO--
