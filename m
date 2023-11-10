Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B30D79FF
	for <git@vger.kernel.org>; Fri, 10 Nov 2023 08:17:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="buvqq3xs";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="F3mD8wWc"
Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27AB693C4
	for <git@vger.kernel.org>; Fri, 10 Nov 2023 00:17:09 -0800 (PST)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailout.west.internal (Postfix) with ESMTP id 70BC13200A83;
	Fri, 10 Nov 2023 03:17:08 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Fri, 10 Nov 2023 03:17:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:sender
	:subject:subject:to:to; s=fm3; t=1699604227; x=1699690627; bh=7N
	Zc08l3uZvvuvd30pAEjU81YOg6+gul6Yv/JXF6DIQ=; b=buvqq3xsOcCOyMlnXu
	A15CdNX2CJzudbg9hgjd5CoYtZBsf3u46yCT5yXSRwX0VBcdlxep12E+rgZcPL6k
	zLFZPwdYDji9kMWNhHaGvRxWOnHdtvmcrq700UQCZzBfS/6jaoOtTRI8tshviPz8
	+K+qqPnDhD4/VVkj1+QMPHjNEwxO/yn7sph+7a5mY4IGB7ABYGhcoQXMOW8e0vXC
	rwk0i0ZtYMh999D+AIach+iw3PB08gHYraaXhGrt0cb5/Q5ZBo/K4fS+lEJ5TfuD
	82EQdDnot7eeId3Q8lxBvkZglHv292xUIpz64spS0vWcYBblBpid7I7qYmWsVMSc
	dPVQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:sender:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm3; t=1699604227; x=1699690627; bh=7NZc08l3uZvvu
	vd30pAEjU81YOg6+gul6Yv/JXF6DIQ=; b=F3mD8wWcM85/cl0I3sadnsAbGtnFY
	5UvfS0ItUMVyQe5ulNC/HX6BcfqSUUVMBQKmObaPjF1c0GOBpjD2GRKoRd1fN+Ij
	FO08zuhwRcQizWTKAKuh6Ap4U85i5iOM56ZIs1P7YEG3aMnYPNlfO5VGAzVtq42o
	coEpcgCEqvu4FzGJei6/VdVAT/u1WVE2+XD/XmURkjfaAeB00OtWniuDLVHAwdme
	XQe+PDIBReN07yZPTble7LoZZ9GkDpXri/J/G250Y+F/MW5agevLofEKq6jReVO7
	/A2932c3RkrEFhNsjffxy+QYozexB5iZQQBZ/4HdzoQSbebkXMCrG2Jnw==
X-ME-Sender: <xms:A-dNZb-6v1pJyWuKtFd41I86wEp2JpnpJ3yzxTFSXXH-QaRSlkEqfw>
    <xme:A-dNZXs5dPciBiW2ev6O55vpcLeifw6UgDpWdBDP3jAtSXMmBNmCtzfuQ585SKl0e
    DiTwn-So7m-mjawmQ>
X-ME-Received: <xmr:A-dNZZBT5WZvQlrI2ExDM7Jn-9S-CuS4GEjCtjZ1gKIvZBfdsOU_lj215PnZtVegE0e49oq-0pcFTpmltrBGJAEXJoZ6xZW1JdhDBFvxEBeHEAUD>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedruddvvddgudduhecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecunecujfgurhepfffhvfevuffkfhggtggujgesgh
    dtreertddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhs
    sehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepffekuddvgeekvdffjeffieeuuedtvd
    ejgeeujedugefftdfghfeuteeivdetieevnecuffhomhgrihhnpegrphgrtghhvgdrohhr
    ghenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpsh
    esphhkshdrihhm
X-ME-Proxy: <xmx:A-dNZXdgWwbYXbsdTL5LlBilkOEbSznizKG6oX0WsmZH4bS1u11TXg>
    <xmx:A-dNZQPBiimCrpMH7gLri2mDZzBBco-LaIcZclxX6mwDyBTZGauOMA>
    <xmx:A-dNZZl8J2MF1PGB9aYTNr1ggGT4bTmSSp90y2GeITBONVHg807x2A>
    <xmx:A-dNZa1jO4jl7WVEZaJl44oKtQPsf1JUE4rJiDrZkxrQpjrbFfeasw>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 10 Nov 2023 03:17:06 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id b2d92871 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 10 Nov 2023 08:16:37 +0000 (UTC)
Date: Fri, 10 Nov 2023 09:17:04 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v4 2/3] t/lib-httpd: stop using legacy crypt(3) for
 authentication
Message-ID: <7d28c32feaaadb411f4d2b0f37b38acdab9e4a58.1699596457.git.ps@pks.im>
References: <cover.1699428122.git.ps@pks.im>
 <cover.1699596457.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="2YudmTmLAG2hJXAb"
Content-Disposition: inline
In-Reply-To: <cover.1699596457.git.ps@pks.im>


--2YudmTmLAG2hJXAb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

When setting up httpd for our tests, we also install a passwd and
proxy-passwd file that contain the test user's credentials. These
credentials currently use crypt(3) as the password encryption schema.

This schema can be considered deprecated nowadays as it is not safe
anymore. Quoting Apache httpd's documentation [1]:

> Unix only. Uses the traditional Unix crypt(3) function with a
> randomly-generated 32-bit salt (only 12 bits used) and the first 8
> characters of the password. Insecure.

This is starting to cause issues in modern Linux distributions. glibc
has deprecated its libcrypt library that used to provide crypt(3) in
favor of the libxcrypt library. This newer replacement provides a
compile time switch to disable insecure password encryption schemata,
which causes crypt(3) to always return `EINVAL`. The end result is that
httpd tests that exercise authentication will fail on distros that use
libxcrypt without these insecure encryption schematas.

Regenerate the passwd files to instead use the default password
encryption schema, which is md5. While it feels kind of funny that an
MD5-based encryption schema should be more secure than anything else, it
is the current default and supported by all platforms. Furthermore, it
really doesn't matter all that much given that these files are only used
for testing purposes anyway.

[1]: https://httpd.apache.org/docs/2.4/misc/password_encryptions.html

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 t/lib-httpd/passwd       | 2 +-
 t/lib-httpd/proxy-passwd | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/t/lib-httpd/passwd b/t/lib-httpd/passwd
index 99a34d64874..d9c122f3482 100644
--- a/t/lib-httpd/passwd
+++ b/t/lib-httpd/passwd
@@ -1 +1 @@
-user@host:xb4E8pqD81KQs
+user@host:$apr1$LGPmCZWj$9vxEwj5Z5GzQLBMxp3mCx1
diff --git a/t/lib-httpd/proxy-passwd b/t/lib-httpd/proxy-passwd
index 77c25138e07..2ad7705d9a3 100644
--- a/t/lib-httpd/proxy-passwd
+++ b/t/lib-httpd/proxy-passwd
@@ -1 +1 @@
-proxuser:2x7tAukjAED5M
+proxuser:$apr1$RxS6MLkD$DYsqQdflheq4GPNxzJpx5.
--=20
2.42.0


--2YudmTmLAG2hJXAb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmVN5wAACgkQVbJhu7ck
PpSjaQ/9FNWG8OhZCv3m3RBZS2TicnXCGMTqzh1t3V8GtzF1ANXa0WL06fEnHtKH
spjm3Gr9GJygQnNJ69SQlDZVl7t9ai1upmOG+Ii9ls/tfec5whfSPgAB79aX4axM
/pq6qGR/bpJET98QqN/3X6sb6gAtLVwCb3suuT6adzgK+CqgZ1BW+e+ZTxrZPzhz
44u+sUYnPjme2sc9A9o9f4sWtU5P8N7GnDlP5IghAluRJtBD2HvaT33wa08Fo17A
5J7Kff6vTpjKRugbNuyliaaeoI1BMFmf2aPqqftC5E+Wbdc05hkxxVfFYcD+IWwC
g75ukYdDjZoa5g9z6K6ckltpUT1KTtuHOptUfJCZFn2JWCpAySH40TSlDb0B5giQ
JISefCPPSZqyJN931CxgoEvtG5b6J9NuTOGNBkmMkrMKoWwn+L1Jw9rwLcMkzUuu
IExe3MtqiIUsoW+rvFrDVj6drYAfgjVyS/Fm+XOLnM4rVdcOG3ChpN2K45byH7/1
QQy3axOtFpp7HUn3hVgEqmOytHWgs+sKjkc+5FvGjMg3i4mniGmP31DhM5E8zNdB
zaW7GxEk303nHYGxkUcU8Hute8fSqR80LMDYfw3PW8kz61wjJid0m6FHGwA2c6Cu
aleLMIvHOpT16swYMn1HIPD3NJvrY3jNdekceniTpJjUFQsRMwc=
=Aq4Q
-----END PGP SIGNATURE-----

--2YudmTmLAG2hJXAb--
