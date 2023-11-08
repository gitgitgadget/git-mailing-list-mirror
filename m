Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC8CE3032E
	for <git@vger.kernel.org>; Wed,  8 Nov 2023 14:57:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="mCTBxaZ9";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="IC4yAzf1"
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com [64.147.123.20])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 601A31FD4
	for <git@vger.kernel.org>; Wed,  8 Nov 2023 06:57:27 -0800 (PST)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailout.west.internal (Postfix) with ESMTP id B91A932002E2;
	Wed,  8 Nov 2023 09:57:26 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Wed, 08 Nov 2023 09:57:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:sender
	:subject:subject:to:to; s=fm3; t=1699455446; x=1699541846; bh=Rb
	c/Z+ioamJNZEGS9DFXX6X+CdB/s9Tm2y3ggzrZujA=; b=mCTBxaZ9Eh6S/mPc8b
	dHYgaTwnUNg1e3cYywS537dNV3GR6tDeeuVYnSmh1vCtiqHm/TXmKh+//JfTpKwO
	LM1msIEXevNPcmso1LPbIfZ2kVwt+wBufpVZMNbe36LxOGuYX0IkkA8yfQgpYV5n
	mppgSrqIAFsEJFawtEV2rmiUubsWjC7Hj0oqNRvl2FW/1zZhjMzYrchQKBfeFF6X
	kPDVWGKb5OTc+Thm9vKiPUxDD+cFFzm2XDZQSvfuWKEHtyiQkzNh7IcDkgfLBcr3
	YCfC5hGJA40wm+gq8i/dRDJvd3LXQ27gGEuByRge9vntlx3oUYz+i//oQN/at4/X
	grcg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:sender:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm3; t=1699455446; x=1699541846; bh=Rbc/Z+ioamJNZ
	EGS9DFXX6X+CdB/s9Tm2y3ggzrZujA=; b=IC4yAzf1vUYSNJX8vu3zB59L2LTBh
	rikh5TNxYyaOZFBBOubw5OjU5hHJgksAjsf1DCOOBb68I6XVkulJXThOluW/DkxD
	h9TwhE1xlQ5ei8PV2Da3jn1YJjxEkL6858gafleX2H7OBm43m0OSr0/3GIT7QFax
	GJYcMfiinSQsyigtykDC0H3I/C6NXAd4sNWTwGYSte6gEt52p0EIe8LWWs46IlUn
	WiB6AHx/7U0tE8a6pqczPmjmssMiRAJ7phMxv5GRe93hlES/fhIoG7LvjDFtsYob
	NLbDwOYImyt/xzzy/0QMdssYhf31WtayulJ3rDJ/XbfCeOcokFd14hxcw==
X-ME-Sender: <xms:1qFLZckcSBzuZJ0wWfVDj6S0sUEHN_2w8VTsboMdhrA2ucAEIg0fDA>
    <xme:1qFLZb3z0vMuZ6Rsdt0mPqulmxiYfCeFZWrlWKuvw_EaGPKn7jIgM2IuLeup0NmSl
    4Q8b8Cj8Rbbfp5jqw>
X-ME-Received: <xmr:1qFLZartaedCwEackxoOBi7tftLqb47zaUEAoYwNdHPcJGYk6QlnTnQWp7M99AuCISrhOkHQ8mvyzOVnNGIe97rRMdytkiuq4Ep5maJ1PYaz>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrudduledgjedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehgtd
    erredttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshes
    phhkshdrihhmqeenucggtffrrghtthgvrhhnpeffkeduvdegkedvffejffeiueeutddvje
    egueejudegffdtgffhueetiedvteeiveenucffohhmrghinheprghprggthhgvrdhorhhg
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:1qFLZYlZPH2_ZsuqodUi1kCA6f6lblPfdFSGWQw-QsNY68RrLd3G9g>
    <xmx:1qFLZa35sh9ZnjAje6U84y_sYOSrbF5JaxwTkNUb7wau_uTc_O4Wsg>
    <xmx:1qFLZftY6P1ncQSJHnjlEOVCDWBrPdPwHxbrvlYR8RSSbLavqO4Fag>
    <xmx:1qFLZf9VI7dkd1EtRan3O2Hn0qFMZ3ZU31GssxpzLoUuxm_ouYGZNA>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 8 Nov 2023 09:57:25 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 8cbed36b (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 8 Nov 2023 14:57:00 +0000 (UTC)
Date: Wed, 8 Nov 2023 15:57:23 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 2/3] t/lib-httpd: stop using legacy crypt(3) for
 authentication
Message-ID: <f4c6c754f1e519b655d45572bd7566183d98138b.1699455383.git.ps@pks.im>
References: <cover.1699428122.git.ps@pks.im>
 <cover.1699455383.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="S3fJzgY5dJz04Ugi"
Content-Disposition: inline
In-Reply-To: <cover.1699455383.git.ps@pks.im>


--S3fJzgY5dJz04Ugi
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


--S3fJzgY5dJz04Ugi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmVLodIACgkQVbJhu7ck
PpTmTw//cZPSTDUBNYgN1Xzjq38WaWs9I9TpcXuEcD9sqVUA2M8wNjy1eN9PwAAx
JbIcdh3TFDKx/NVNuk1WfNcBUFkMWuHKPxinrCVPQZYwEyaFZo7Vbu2UtqIqGVhW
387o3/BSLrKmUzkNB8wjXgamnZQyLDDOSwp8V/MPp+Jm4IuYn+HrmnnEgNU1GIeZ
1xIdwxAVfBUaiE6BzGamz6ReugGJs842wMYi3wuFZF48iqTKnqc1yiF4SW6xUShh
7nRxSl/NZ+INv8PShZ0S0NpxO0M4Oq5u6QTb2D91U8LmgBytyI0usNTduM8NRsYq
Boe3SbkrRSupNChdNDyMROgtZds0Tovupd3KYhk98jPGAA1lJT437mw4dWDPRuCb
cLLzqHDw8u+1/MiCUifzFIZwCdcUGusTwrV/d15QukTVdKotK2iS/o52abULDoAd
9QFLjVcQy26cNK3jROJtEn/CabrWxQ4Xtym3XvR6LtUW3vS5gaP7SLdPeqEbWy1J
PdBxPdlnW05oYtmVfYyEil5TGjiKpcHu4pgFPeprUJuZvP73Svv4w+KhUljvrey/
ZOruyJpDCnWppJaVXsyFqFuM2ZB9B5vu/m1XQMORPRsaol9FnTewADtR7m5d4oQk
hygxl/O0sTEo1aithbFHspYXufv1GxM15cb/bj6+wx4Lvl+FtJY=
=8/Kl
-----END PGP SIGNATURE-----

--S3fJzgY5dJz04Ugi--
