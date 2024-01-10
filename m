Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com [64.147.123.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 436C83B18A
	for <git@vger.kernel.org>; Wed, 10 Jan 2024 09:01:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="nAwWHAJP";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="SDheBZET"
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailout.west.internal (Postfix) with ESMTP id E6CE43200B5B;
	Wed, 10 Jan 2024 04:01:42 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Wed, 10 Jan 2024 04:01:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1704877302; x=1704963702; bh=Y6HLE5aSm9
	NwAcCLWMhOaAx/cwlxZcrNkxEkJu+qppg=; b=nAwWHAJP/cMLCWLNk78Wys0QOs
	UjeKfIUVzDe4HqsVi1/390qDLebcUoXmp+ILPSUOmS4d6ihOVm2Z2d5SKDq5/oHe
	hlAN++teJQ0nLL0fyAop4iL22HxSmZ40Exe3gTDKUn+y1msDfqny/pfRuW/5vV7S
	oXxKd8FdDtgejZvHKjHVAtZwSrs4hrSDLZS4D3iJCjhTdqj6VXjwUsbuHXLOY9gT
	qs2o3ttV0k3GfyWvPf96ISczr4lEOMY8JCKUxcj3Y1dgoBb92F7Vn+Oqprxzn5Sr
	KJaENC8J1cEs57e0BT/ozOxW+j0iQRpfD/aCJv1RRvwAK2fJ//ADeDJgNwWA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1704877302; x=1704963702; bh=Y6HLE5aSm9NwAcCLWMhOaAx/cwlx
	ZcrNkxEkJu+qppg=; b=SDheBZETHH1AUIHhFo1NVGQNoahPTWQlTb8iUJ6eZkKn
	2rvqFa1MmvkrEEX3w279yeStQGHtj2rKoqxs1gL82LgpbMuNPfbMkUTw0LUSVSac
	LibBFF6MfixvX0TnjhVUpF3SY56y6dzptxVLxZB3nAbp1STjhser/0atcKcdsZYv
	6sSLI8+fGeXpV/mCNqketmfU/luJiUyI5aq2qjpMFnKcJo7Uo0T9wzRP4jbPJU+W
	/t1FllEAKpc0xMx+HU1DrGV5aSRMy4p30tHIfTQ4/1FW/BpzNydgSq8ds8AJgR0E
	RHsJiCNSTrMoMHcr0MaG1cRkawEklu9scn0D4ysUwg==
X-ME-Sender: <xms:9lyeZbjm2QU8yces_a2ee2_ql4rYuEO1Ea__9WwlJBAbOEPRy7dCEg>
    <xme:9lyeZYCopsxYMeK8lldJNFWdqXv_Tw1yugXHbP7yam_byzn1Jvty93TGoLI9tEESN
    HwCz7MNRz4coM9pqA>
X-ME-Received: <xmr:9lyeZbEWuSuJXlwIDIkbg79RXHT_rYriTwh2GPrii6DlwNBw1Fay9BZ2GVWIPi0WGr6XSFGcU5SvQGB_qS6d1hrxGJIVOqL8wLNyszBEQ9fVwcQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvdeitddguddviecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrght
    rhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtth
    gvrhhnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeehgfeltddtheejleff
    teenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpsh
    esphhkshdrihhm
X-ME-Proxy: <xmx:9lyeZYQbQZb75S-Groa1Mfd94dq7svJnj1dISD5fJ6veFwCaU6omdA>
    <xmx:9lyeZYwTZYreR-T_PieJqRIpneZHIo_4Mfpdr23bK6jMqZqW24KRig>
    <xmx:9lyeZe62j6pJ3nbP-gqih7s_BpRezOJtwlzpjadjzmicYM3zjkZwug>
    <xmx:9lyeZVqT5t_pTOzWENU4wMgUsgS4GolLrBvPENH1JXgI0PjOcfFFBw>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 10 Jan 2024 04:01:41 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id e7b444cb (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 10 Jan 2024 08:59:00 +0000 (UTC)
Date: Wed, 10 Jan 2024 10:01:39 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Taylor Blau <me@ttaylorr.com>, Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v2 1/6] t1300: make tests more robust with non-default ref
 backends
Message-ID: <0552123fa30243d6d8d6b378991651dd6ade7de3.1704877233.git.ps@pks.im>
References: <cover.1704802213.git.ps@pks.im>
 <cover.1704877233.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="9+1LzZeG7huNcN/N"
Content-Disposition: inline
In-Reply-To: <cover.1704877233.git.ps@pks.im>


--9+1LzZeG7huNcN/N
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The t1300 test suite exercises the git-config(1) tool. To do so we
overwrite ".git/config" to contain custom contents. While this is easy
enough to do, it may create problems when using a non-default repository
format because we also overwrite the repository format version as well
as any potential extensions. With the upcoming "reftable" ref backend
the result is that we may try to access refs via the "files" backend
even though the repository has been initialized with the "reftable"
backend.

Refactor tests which access the refdb to be more robust by using their
own separate repositories, which allows us to be more careful and not
discard required extensions.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 t/t1300-config.sh | 74 ++++++++++++++++++++++++++++++-----------------
 1 file changed, 48 insertions(+), 26 deletions(-)

diff --git a/t/t1300-config.sh b/t/t1300-config.sh
index f4e2752134..53c3d65823 100755
--- a/t/t1300-config.sh
+++ b/t/t1300-config.sh
@@ -1099,13 +1099,18 @@ test_expect_success SYMLINKS 'symlink to nonexisten=
t configuration' '
 '
=20
 test_expect_success 'check split_cmdline return' "
-	git config alias.split-cmdline-fix 'echo \"' &&
-	test_must_fail git split-cmdline-fix &&
-	echo foo > foo &&
-	git add foo &&
-	git commit -m 'initial commit' &&
-	git config branch.main.mergeoptions 'echo \"' &&
-	test_must_fail git merge main
+	test_when_finished 'rm -rf repo' &&
+	git init repo &&
+	(
+		cd repo &&
+		git config alias.split-cmdline-fix 'echo \"' &&
+		test_must_fail git split-cmdline-fix &&
+		echo foo >foo &&
+		git add foo &&
+		git commit -m 'initial commit' &&
+		git config branch.main.mergeoptions 'echo \"' &&
+		test_must_fail git merge main
+	)
 "
=20
 test_expect_success 'git -c "key=3Dvalue" support' '
@@ -1157,10 +1162,16 @@ test_expect_success 'git -c works with aliases of b=
uiltins' '
 '
=20
 test_expect_success 'aliases can be CamelCased' '
-	test_config alias.CamelCased "rev-parse HEAD" &&
-	git CamelCased >out &&
-	git rev-parse HEAD >expect &&
-	test_cmp expect out
+	test_when_finished "rm -rf repo" &&
+	git init repo &&
+	(
+		cd repo &&
+		test_commit A &&
+		git config alias.CamelCased "rev-parse HEAD" &&
+		git CamelCased >out &&
+		git rev-parse HEAD >expect &&
+		test_cmp expect out
+	)
 '
=20
 test_expect_success 'git -c does not split values on equals' '
@@ -2009,11 +2020,11 @@ test_expect_success '--show-origin getting a single=
 key' '
 '
=20
 test_expect_success 'set up custom config file' '
-	CUSTOM_CONFIG_FILE=3D"custom.conf" &&
-	cat >"$CUSTOM_CONFIG_FILE" <<-\EOF
+	cat >"custom.conf" <<-\EOF &&
 	[user]
 		custom =3D true
 	EOF
+	CUSTOM_CONFIG_FILE=3D"$(test-tool path-utils real_path custom.conf)"
 '
=20
 test_expect_success !MINGW 'set up custom config file with special name ch=
aracters' '
@@ -2052,22 +2063,33 @@ test_expect_success '--show-origin stdin with file =
include' '
 '
=20
 test_expect_success '--show-origin blob' '
-	blob=3D$(git hash-object -w "$CUSTOM_CONFIG_FILE") &&
-	cat >expect <<-EOF &&
-	blob:$blob	user.custom=3Dtrue
-	EOF
-	git config --blob=3D$blob --show-origin --list >output &&
-	test_cmp expect output
+	test_when_finished "rm -rf repo" &&
+	git init repo &&
+	(
+		cd repo &&
+		blob=3D$(git hash-object -w "$CUSTOM_CONFIG_FILE") &&
+		cat >expect <<-EOF &&
+		blob:$blob	user.custom=3Dtrue
+		EOF
+		git config --blob=3D$blob --show-origin --list >output &&
+		test_cmp expect output
+	)
 '
=20
 test_expect_success '--show-origin blob ref' '
-	cat >expect <<-\EOF &&
-	blob:main:custom.conf	user.custom=3Dtrue
-	EOF
-	git add "$CUSTOM_CONFIG_FILE" &&
-	git commit -m "new config file" &&
-	git config --blob=3Dmain:"$CUSTOM_CONFIG_FILE" --show-origin --list >outp=
ut &&
-	test_cmp expect output
+	test_when_finished "rm -rf repo" &&
+	git init repo &&
+	(
+		cd repo &&
+		cat >expect <<-\EOF &&
+		blob:main:custom.conf	user.custom=3Dtrue
+		EOF
+		cp "$CUSTOM_CONFIG_FILE" custom.conf &&
+		git add custom.conf &&
+		git commit -m "new config file" &&
+		git config --blob=3Dmain:custom.conf --show-origin --list >output &&
+		test_cmp expect output
+	)
 '
=20
 test_expect_success '--show-origin with --default' '
--=20
2.43.GIT


--9+1LzZeG7huNcN/N
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmWeXPIACgkQVbJhu7ck
PpRSQRAAjoMjiFkBy145wtXvJb+8+JavnfTiKBqpSa9wdGYDnQKCNK3Z+4QRQbHY
Jbp64ENA3Lusar7C2ocygQsHcuCYl1Fj38tpVnJnZRacwcfNgHZB5+LFX9UMzdvY
axooxPOw495+bQe+2F5xKAUr17dAlZTlLvE+de6POgllu8fnMw69S/zuR9xsjIYW
75XuY1Jn047XJrlw1lRviSyJDJaK93F1lClRhIex6DqzHtr2DwFSUZfzYy67sZLJ
z18xwoYF8gmRV5tJ+srLIMfvzkfbale2k1YBJRfQhBCbaGmcLQ36gj2EPwQKKPzF
JHiGEppTZPtrpy+mjgpjwCVOKxhLuC+2ZLMOYqyiwUVJiwb/RfPJMEyZA1J90x/d
I+jZ3l3EwLeQSvGTrGiQQDjfzBgcAEAZ0NmOqbDM9JS5zcr+RsRj0GUf29695Uog
TmHqODUnenAJZHKyGhumdP+17HqFMln8Ozw2uTqmZOmo5ZTIwXmVkWrSecZudL9w
+jxC+PsalYA9t9Xd4Frwyajto6anDiaD0bmlaD/upBS/O3Nrlskb7RguEhI55tPI
AEmSIQeWq11gDSIuYN9vhhELV5ajlUB7e4MG7I8tbQ3vkzEy02P3ernxw+Be/DrU
wdZXpTIpoQAkXKrFdEF0ZLEcSpgoJTZnYHhTCupkAl+a1Pdyrb4=
=JCq4
-----END PGP SIGNATURE-----

--9+1LzZeG7huNcN/N--
