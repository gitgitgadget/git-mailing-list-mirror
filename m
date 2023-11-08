Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D23732FE3A
	for <git@vger.kernel.org>; Wed,  8 Nov 2023 14:57:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="ao/SyxmQ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="pqaWZMnr"
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com [64.147.123.20])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 707E31BE6
	for <git@vger.kernel.org>; Wed,  8 Nov 2023 06:57:23 -0800 (PST)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailout.west.internal (Postfix) with ESMTP id CA6703200937;
	Wed,  8 Nov 2023 09:57:22 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Wed, 08 Nov 2023 09:57:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:sender
	:subject:subject:to:to; s=fm3; t=1699455442; x=1699541842; bh=l+
	DRSY/ZWW1urDKB4UOjHfMLVbU9kLiCp9GF/3u8UGA=; b=ao/SyxmQ/tpFv57b92
	Rw+fFqA4UgBbugNVyPthmT3vEcZPKzRkk6VHA+t6wsOMFm6wb+WPgUCQ8lzPmHy6
	fFBDWM1RsCF5WCREg9wXJ3JRX8LzU0JV1woiR2npcTDBxIqL5y/Goj6KE1j6efnA
	3gSigBVBrdMEBbuEDuR1fPfpvn0bIZAULcnRJ8XG4FZTPc0EF29wySASvRIhS6yQ
	v8MoJ06hkQDert97Jpo7bkvkXHW9Pr1FzEZDy1KHB6YTSD8cwFsNZH0K5OvtSZzQ
	8yHZvJXF+2a3iZLd9HU13CF9Xv7SQ4GbAv8lqmH8LTbzSNt5mrBbbnPFq3Xi74vh
	hIIg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:sender:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm3; t=1699455442; x=1699541842; bh=l+DRSY/ZWW1ur
	DKB4UOjHfMLVbU9kLiCp9GF/3u8UGA=; b=pqaWZMnrK70KkJy2IUDo4fcejuvBX
	lMi7ygZGLDT1y6Zfvbl6RiBZ77JSB7oDAyeD+vf8aVQi3I7Kp58ljxk53sRWtyEt
	l89LF4+LiAAWjRaPhKcmlPIXtJPS7+1Ry1xMtLDS6gymxIWM/wJeIN6xbRdUfwB1
	OxIAewdkM36WJ+W0+d8DA1D3NbFnNCaD1pTas4IYrGFCXYQm4/plHx15AQ/21Qrn
	EXoRABe8cNIWT4+/QM93nJhnRnY7eGmDIZR+bkF7VN3QjqX5D1DmGxW3cXqD7a79
	l/ecxn9haPgIca1zcgP+pjp8S0rP6sF3V6NSVAVUdIdlOOc9kJXvjdW8g==
X-ME-Sender: <xms:0qFLZRRG85ZzClyDt1jteob5ww9MuCZH0sC3M5yY6szldCS8c2KZLg>
    <xme:0qFLZazq8BA1ZLdOOuGrXRHS_KzqRVBcD249zpobic_EwpJ_UnvG9NS4TApj5-dFV
    U9ZXvDsN1sZoSY8wA>
X-ME-Received: <xmr:0qFLZW3LWh8Ide56qL67FlVhLBfBQP1q6MGAYLk8qKqgmhAYpc5p62ZsCQuev2XI3FeL9tqF-5JwgtIcBpPP3LkA_f-JrpL8A897C2dFKfGl>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrudduledgjedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehgtd
    erredttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshes
    phhkshdrihhmqeenucggtffrrghtthgvrhhnpedvheetgefgveeuveehtdelleeviefgfe
    eiudeigfdvffefgedvieetgfetveevueenucffohhmrghinhephhhtthhpugdrshhhnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimh
X-ME-Proxy: <xmx:0qFLZZD3yz88F91JhOxvHS4XQXCQWygbysmgrRd2WpfgHxiRjv4qSA>
    <xmx:0qFLZaiMR78jbicRv6csiWf3A4_-V20fGtgQXeWKUmGpwWQB8pSVeg>
    <xmx:0qFLZdpvnJW1LxrXcWID8bSsYKAD-dBFI3dNBbSgSoJGtJORebWQnA>
    <xmx:0qFLZSIJG7GAA1qcXwGGqVlR-DiScx8RZOQSeFSNa4m2QALjE9EkRw>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 8 Nov 2023 09:57:21 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 852b662a (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 8 Nov 2023 14:56:56 +0000 (UTC)
Date: Wed, 8 Nov 2023 15:57:19 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 1/3] t/lib-httpd: dynamically detect httpd and modules path
Message-ID: <cee8fbebf84422f73c38d55b5730053121b74e0f.1699455383.git.ps@pks.im>
References: <cover.1699428122.git.ps@pks.im>
 <cover.1699455383.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="o/Tchw/yhpcqGQ2M"
Content-Disposition: inline
In-Reply-To: <cover.1699455383.git.ps@pks.im>


--o/Tchw/yhpcqGQ2M
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

In order to set up the Apache httpd server, we need to locate both the
httpd binary and its default module path. This is done with a hardcoded
list of locations that we scan. While this works okayish with distros
that more-or-less follow the Filesystem Hierarchy Standard, it falls
apart on others like NixOS that don't.

While it is possible to specify these paths via `LIB_HTTPD_PATH` and
`LIB_HTTPD_MODULE_PATH`, it is not a nice experience for the developer
to figure out how to set those up. And in fact we can do better by
dynamically detecting both httpd and its module path at runtime:

    - The httpd binary can be located via PATH.

    - The module directory can (in many cases) be derived via the
      `HTTPD_ROOT` compile-time variable.

Amend the code to do so. The new runtime-detected paths will only be
used in case none of the hardcoded paths are usable.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 t/lib-httpd.sh | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/t/lib-httpd.sh b/t/lib-httpd.sh
index 5fe3c8ab69d..26c1632ea9a 100644
--- a/t/lib-httpd.sh
+++ b/t/lib-httpd.sh
@@ -55,7 +55,7 @@ fi
=20
 HTTPD_PARA=3D""
=20
-for DEFAULT_HTTPD_PATH in '/usr/sbin/httpd' '/usr/sbin/apache2'
+for DEFAULT_HTTPD_PATH in '/usr/sbin/httpd' '/usr/sbin/apache2' "$(command=
 -v httpd)"
 do
 	if test -x "$DEFAULT_HTTPD_PATH"
 	then
@@ -63,11 +63,17 @@ do
 	fi
 done
=20
+if test -x "$DEFAULT_HTTPD_PATH"
+then
+	DETECTED_HTTPD_ROOT=3D"$("$DEFAULT_HTTPD_PATH" -V | sed -n 's/^ -D HTTPD_=
ROOT=3D"\(.*\)"$/\1/p')"
+fi
+
 for DEFAULT_HTTPD_MODULE_PATH in '/usr/libexec/apache2' \
 				 '/usr/lib/apache2/modules' \
 				 '/usr/lib64/httpd/modules' \
 				 '/usr/lib/httpd/modules' \
-				 '/usr/libexec/httpd'
+				 '/usr/libexec/httpd' \
+				 "${DETECTED_HTTPD_ROOT:+${DETECTED_HTTPD_ROOT}/modules}"
 do
 	if test -d "$DEFAULT_HTTPD_MODULE_PATH"
 	then
--=20
2.42.0


--o/Tchw/yhpcqGQ2M
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmVLoc4ACgkQVbJhu7ck
PpQQ9w//aB9MIcHxBqaQ9R4RjEcz6fTzqFSAKliZgDwliAkwUA8xrgTJ5f1D0Jpa
ag0Xq4irI4ef2Cu3dJyovlQ3xE18MylkmKCkHGDVpqmpKvf/l5PxP68d0JxFxbJn
7UNLiyc5WVxmXncuRynHvCr1juXjXLwJPozKgyxbWSIKa+f64you7KVi0j4YsQsg
0zGETSaPVhnTDx0eUgiZzWhaA7VnWLY6uvsLHY4/sisnAqinM/mfmaTy9aobo2im
WQG9rv04vNqWmr4/5NzyZxJK7yRPCOTdGpgJbAqcAPfl0rjw8wC8QqGQzF+/p7+t
NAWMFzsKDXC39lUxzU4Eth5YoodqwsbqScK5sHzRbC0H4UuE1q0dthX7qo5NnxqA
t/3n2L+kx2IvISAAOUs121Q1nIHRdlMMlMGvp5Whpp7cr2a2fzboUJ/abEDbQ8j8
tHmq4aJnjJ2M6bu1QAuz+dRpwAlV7Z/W2izAoGHwY43ynwOsQkdkxysYUgJfb2Uy
AIidV/l/K7JA/iSyrkmZpKXI//qpzk92UTkMMDiWTAmAxM1WV3JFE7TrcPa0BB3Q
UdLZZKWBee/ctBZUqXn+Yhy+4QSrJJX7N7L7vk3r6jdvosiuRSzV/d0e7ClMdIcY
R7jvrva/tvlasxOPi4fT9YnpuGhnsmY+z9184rhr1lo8aJdSW/o=
=N0SA
-----END PGP SIGNATURE-----

--o/Tchw/yhpcqGQ2M--
