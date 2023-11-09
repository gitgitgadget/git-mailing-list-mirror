Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50D1ADF6A
	for <git@vger.kernel.org>; Thu,  9 Nov 2023 07:10:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="b+DNJo3C";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="IEgGNkRO"
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF869211D
	for <git@vger.kernel.org>; Wed,  8 Nov 2023 23:09:59 -0800 (PST)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailout.nyi.internal (Postfix) with ESMTP id 560AB5C01E1;
	Thu,  9 Nov 2023 02:09:59 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Thu, 09 Nov 2023 02:09:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:sender
	:subject:subject:to:to; s=fm3; t=1699513799; x=1699600199; bh=7i
	UB4LD0Egj0oYF5BX8i9B/D7m1WEovjLQoLhzaCSH8=; b=b+DNJo3CQ0XaM+WZas
	ZQVt9PfUDeMd2ufUWYDfKu14sZAplF13wkNzSRTqn6wLEnO44hXdFOj3quV03yQm
	Q0LCWNLjciYNJceAiWfZLlGGo9EsTNZOZgQnDYrTisEbX9hD6TmwO+s0BowTGGC3
	o/5cc+MbvTc7TqNPntcAtyoXsYvFAn0u4tHWp6yc3o0iVu2qQ+kj8UheODnrJA5h
	ZGQ5J2o3rxT5pESzIESeXJTIfdCKSX2isv8UN2YTlPIYSC0JrZ72WA2W6psPBTqJ
	wOqYbGaLCBDi0HMj9p42hJ4h6d9QHNriRua23UjzdOUNah+CZp5m8woXEpcPiF5k
	FUEA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:sender:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm3; t=1699513799; x=1699600199; bh=7iUB4LD0Egj0o
	YF5BX8i9B/D7m1WEovjLQoLhzaCSH8=; b=IEgGNkROMbxzFmaLKYg2BaR4B5/Mc
	+O4K7yT1GbkmbBq6GLR4LRyyNCTHHd7WNTiyUrFw6Qph+WydhmjMzBahGdFG4rfu
	Gtzi3Lrgwy2j+zdHtQJkHWvRhf6t5Rptb3tfK9veHfXk80GpxuhnEFZaOmbQaPGp
	V+9f8TpFfW/ej022Uo0O+rgolnoCQiFskQNlnFa9lXY38Mowc+V8WRm5rGN/FjRC
	zCWy7JNDVaqklmaIYVNStJ6hot/dSEYvURL3ivFH+JcJaXkrJYOBmHwlIeDID67f
	xE8akXbBIZpTCudDHZrk7mVlrehFEk9yBGnb1UKva3cW0ebTeB82zLhnA==
X-ME-Sender: <xms:x4VMZYYfUEw-AYyiSMU64v90eiW6hzqY6cp8Y4MMpTIW7SF30abIyg>
    <xme:x4VMZTbs7QWu9Sij833jDZF7r1uRa-Iv_MbatqAul0ke34V2BVOOCdSdSqg2qbIt2
    uW1MmAXZuKgMz-lgQ>
X-ME-Received: <xmr:x4VMZS9vrtU3XOs6rJqSB9XvEwen3x_ukqPOZu9ERtBqxMI-TLyywfTU2iH5wQZlhMnSYMjOsJiL4I8OnbES4Mm4hHubJxKRcq5thchYheke7VI7>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedruddvtddguddtudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecunecujfgurhepfffhvfevuffkfhggtggujgesgh
    dtreertddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhs
    sehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepffekuddvgeekvdffjeffieeuuedtvd
    ejgeeujedugefftdfghfeuteeivdetieevnecuffhomhgrihhnpegrphgrtghhvgdrohhr
    ghenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpsh
    esphhkshdrihhm
X-ME-Proxy: <xmx:x4VMZSr9YDktWoVUEqPMl9pzB_GdfFSqiVC3DQ6j8XapPkMb6yT9rA>
    <xmx:x4VMZTpLu5yiRDf-G-p944efu3QE7iua4ugnnkq4tYgUViy9-IWYXQ>
    <xmx:x4VMZQTAsyd6WHH6tYod2k4uBgI_AT81tU1qH8-R0jmY0ALVpJYhQQ>
    <xmx:x4VMZcDDJmvFKcd06Ov3CA_zhsAaCdo8xOh5VVXtYDwkufnGuUkq0Q>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 9 Nov 2023 02:09:58 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id a83fba48 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 9 Nov 2023 07:09:31 +0000 (UTC)
Date: Thu, 9 Nov 2023 08:09:56 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 2/3] t/lib-httpd: stop using legacy crypt(3) for
 authentication
Message-ID: <3dce76da477852e5e6964ea20cad2bfe2788a96f.1699513524.git.ps@pks.im>
References: <cover.1699428122.git.ps@pks.im>
 <cover.1699513524.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="tLVFCOf/N+LoiBqF"
Content-Disposition: inline
In-Reply-To: <cover.1699513524.git.ps@pks.im>


--tLVFCOf/N+LoiBqF
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


--tLVFCOf/N+LoiBqF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmVMhcMACgkQVbJhu7ck
PpRrew/9GY1icuuyjQLWNwCSinf7Iyo9hBd3h92pQhdXeEOGtZqtgiqB4vdf+KX4
MCOd1UlzYJDpHrG9GpRz35y4w6MWWAbol90ru11T3JXfXfqIiBbTGCZQZIYo1oZD
5wDWZQjKFVgugY4q/N6HtO8yzSds2b+vHxLV4MqU2J/b53hT3ioRIvaAdyaaGDO/
q9sPMFt0a+Wyc0tStdppey++6g4z8nlNTjaDr6lEaqG9Td/3Z/ZCFUbVR1B+CAta
jiwR7cq8dFkJ9uTmC5koVUzuiKnBGFoYgAbafqQHWdhWf/laJrnTQO288Kac9bHY
zj0e/5JGx7F69FvV9T+kNyN84YwAA4hxbqb7XqjLdVeyLYM9pYw77dFnfm1i/L8n
XKujvIKsSj7MOaZPsoD58uZqJU0jLsZLW7bgLLaZ3hlTLzvkuy01xm2XTwQtZqXt
9E4r4OHLShINdPgYyX4CtF5z+S3RtaiGs6Vq1LvT+iBeHU4jyapwQeXTNj3dZ5TU
axwyz3ShnL4fd6NDJlKQqpkQWnZWE60uzt9vbxUOJhlbG+xRXWQdv7O86vseguKu
l9d1a93z5RDyA5pEk1NWb9ljyCVSZsCmXeboGE9r1ykGIGb8X1Kmd/p181dvjutR
NuImr+/w/3jCqN1woiWTNPnim5E0SKu6S+aqHFkgr7UGCON9Ez8=
=cq2t
-----END PGP SIGNATURE-----

--tLVFCOf/N+LoiBqF--
