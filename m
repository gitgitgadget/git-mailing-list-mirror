Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43B90D50C
	for <git@vger.kernel.org>; Wed,  8 Nov 2023 07:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="keJOmNkR";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Z33k1Ny8"
Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA1391AC
	for <git@vger.kernel.org>; Tue,  7 Nov 2023 23:30:04 -0800 (PST)
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
	by mailout.west.internal (Postfix) with ESMTP id 3C87832009FD
	for <git@vger.kernel.org>; Wed,  8 Nov 2023 02:30:04 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute7.internal (MEProxy); Wed, 08 Nov 2023 02:30:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:sender
	:subject:subject:to:to; s=fm3; t=1699428603; x=1699515003; bh=5F
	nSZPbfEN5Lu5dWGa6FbZG71c1gmmytDIasvKNNEs8=; b=keJOmNkR+H0+RrzkK9
	1s4EgKhYMQN4SiOry1cyodZMiZhTNnh9Ms6juFK0OYpKTiSWbafAQ697dQ7cgF/Q
	bj8qUUcrJloRW/BJ9BKQ2JFiCTllqxj4Zl2ZVfrst9S5lb77I7wHDvFRIKjoOsC9
	RGjjQqIinCvJJ+WgTC+Ndh5hLnG35LgeA7sbceZJ0YCi0fHyeG7rna0Hh2cs7MnX
	Dssz59Qlkxx1K+kA0azc0TiUKuBNVj31dcPm2uucGFQctRNL1npKnWeKn/KBz2x4
	ftXSN/aHgxKxzzv39s2b9a/0Lrg+0RKuZhsEWJ4Khfp2+o0nLhSzqrfeBgZG2NWh
	bXdw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:sender:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm3; t=1699428603; x=1699515003; bh=5FnSZPbfEN5Lu
	5dWGa6FbZG71c1gmmytDIasvKNNEs8=; b=Z33k1Ny8CkKral5/8yAbrYEvhm6xR
	s+arSvcfypimz7Br2IY+EZYLaRlx5FOzQ4sbZ+D+Cag5VOB9De1zXSxMo3LEbsm5
	783khMH19JDkz9tqwe96M16/thQj89kAkWqEqZpS7+SxqvEHtkfeFaH5w50MOCH+
	5Z8mbC//Y3E9VuSKR9G7a7uTaewUKN4xbfHAklQe59o0TGGv0JvxFQFRyRzSk1lh
	G6rLBvKy/hFBzQco+ddrgvNChA145ZhkIR1D2EsrC3MTqPl5e4jGQX4HKm4okwJ1
	W/SUglB5RWoFdVi1yMFnyykEvHAlsn0A1EIOvqUgzgljquCsOypaptdBg==
X-ME-Sender: <xms:-zhLZQ1odW2_F0qka6d4HeEU-e4ft1k5UgK0z_IOlDJiogRc8bEYig>
    <xme:-zhLZbEXa5Cig9bxEvZng5qiirrniYfJPZxh2ZNfXY4G-6CuJqHYwWXoFCRQEkHZ_
    ja1LKkz98zvlxd4BQ>
X-ME-Received: <xmr:-zhLZY50bgGxOO3cDHbwH64ku-1cKUU-WZvaGISWZLpcCAs9mPMsIplp2gJHi8Fi0Ue5WQi2bvyc6LOlmINvdQU2LjXcAtQgjjhDgipdHUmM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedruddukedguddtiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecunecujfgurhepfffhvffukfhfgggtuggjsehgtd
    erredttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshes
    phhkshdrihhmqeenucggtffrrghtthgvrhhnpeefheelkeeggedtgfeuheekhefgkeevie
    evjeejffeuteekudelheeuheffveffveenucffohhmrghinheprghprggthhgvrdhorhhg
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:-zhLZZ2girQAoXIu4cyJGQEdxIxESOiXyn9faVv1aY9KRG6jx4WEMA>
    <xmx:-zhLZTE1U940MLPHUScy_Cs3ax0YyHDIB4x9Tu-OMKWEFzVcJAt-UA>
    <xmx:-zhLZS9ISnNX4gTV-FFGHmDElNUcgokY0r7oQS8cYicWihY05kAAWw>
    <xmx:-zhLZawv3uxTAiU5vxU2CdYKAriGrzQnsSKM0EQ0d3U6878SNrliYA>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Wed, 8 Nov 2023 02:30:02 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id a03edc15 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Wed, 8 Nov 2023 07:29:38 +0000 (UTC)
Date: Wed, 8 Nov 2023 08:30:01 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Subject: [PATCH 2/3] t/lib-httpd: stop using legacy crypt(3) for
 authentication
Message-ID: <23835763002c5f5cd68db7bdc9e4c083dda3558f.1699428122.git.ps@pks.im>
References: <cover.1699428122.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="gwNv30ckdhIQct8X"
Content-Disposition: inline
In-Reply-To: <cover.1699428122.git.ps@pks.im>


--gwNv30ckdhIQct8X
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


--gwNv30ckdhIQct8X
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmVLOPgACgkQVbJhu7ck
PpStQQ/+LteLoIaiKTaicnS5sdMQaoeF+QrimzscVwxqkU6UsFYua8yU+x6zERYa
CBAso72y+r5VjSeRQaUrVNIO3GoAcsYL0jw+1MgHqRaoZIegRhk/gtix1Uywlvg3
kqjT0OjQcJEypldx3lg7j82o7wG/zD9LBDNnDfoDA6ihDTx4scCAJsThCWu70xds
KvyIKCxSZhxwU4b5qhwezTYVmhs/cNWW0rJRa+wv89WxGRwuWgH+urz2RPnTM40j
hP1Lclwwcj1oeY2gZumh6AFw+gFiN6/SWy4vcLMiT9Ps1AN+Y5t75+shr61wmkIr
f9VxMSJKAuceXVk7Q/KaivodWcuGc1AVgmc8t6p7hzepEko2o4d0IdLwPn+5EhUa
/ErrVdP9Tr3VtXAblVMwNUcoTGYvm65L2qoffwwm+hBokwNKUdYfymyVtiQ4UbUf
m9BlX3jbKCMwPPib8+WKQBjdUcnupSt1AgE+cu4kZsDxn2bYCVkTfz+2CByMMHln
0376mAARRA1jdEangmuKCC6kSkcXUfdXyR4+vFr98ZeSB085TIi92JSsJxu7CBaH
78yen7s8rWzdTkTdq+ZaXKqqt8MSNwiiXkMb+MjjH7XzsQ7lFQ426h167w6AEwo3
G5f8u1phHo+hd8+i38GlfHRkD2aN2V0ERLa8lRtzR8Bp1oattXY=
=caDh
-----END PGP SIGNATURE-----

--gwNv30ckdhIQct8X--
