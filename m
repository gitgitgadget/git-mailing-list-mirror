Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="fkVevCv6";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="F8BCiqqu"
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0A50DA
	for <git@vger.kernel.org>; Tue, 28 Nov 2023 23:25:00 -0800 (PST)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailout.nyi.internal (Postfix) with ESMTP id 155BC5C018E
	for <git@vger.kernel.org>; Wed, 29 Nov 2023 02:25:00 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Wed, 29 Nov 2023 02:25:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:sender
	:subject:subject:to:to; s=fm1; t=1701242700; x=1701329100; bh=e0
	unbxZeIu3Vdj3nxPoEQ2FFfhVT9+Rpqx5U9BzFeqc=; b=fkVevCv6YM+GFLIjfC
	iGmlogchWT5iMBpZ5YilCG8prLHqGKTz3IAOPNjH0KsBA+iBlErWfp/IxE4si33q
	A3/w5hPpUl3K6bE6cak235nvAPwlcbQcxqVAhseoE777r0zmQBK+xZMp6l5PiTyT
	nSHRZV1aocvOzBR6h9DWO6knOupNEMVqR8EO6zZ0+q/wf5pJwvfEvlGgR44FwJG4
	SEpi8pX3nfjx53SilZver6eLuayZzOhOk0QAD0usUyft1UsOYx3R3bWqMcD/KNYQ
	Qti5FXOBgpifjRrfkkjzGrXhCpLLCtPdkN85YMSpa0InEzmUvVZUgy5VwwSbUZPO
	fCfQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:sender:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm1; t=1701242700; x=1701329100; bh=e0unbxZeIu3Vd
	j3nxPoEQ2FFfhVT9+Rpqx5U9BzFeqc=; b=F8BCiqqu4OP9ASpqxV96JBMkq3gum
	SJlwLtP6o+ce4IaZ9DR1TYcIF/TxXafP02cAsGFP8+DZJqLF0TxqbFqnmJ2u7wWc
	aY8lkC8LI7Pd3H+BCarDe71cGsBc4ZyFyRZonl23m0sY/DpEYx7fYporpMHtmPdd
	g4K0FXPcatMX9FG7C9d2uj1+eHt9hFlrg1UbWhxo18hWU7FDnm859j7FuZi8kbGJ
	LwZC9lyxuBz4E7ErAGoniTA2rP5FXKwQYoI3X4WLvN0NAJRdAPHqRZ3/xZf3Kr7E
	xA0oInDG5Xi8mWjgdc79O3389guZNAq/YwkOALplMVangl8NkFcuxZtCQ==
X-ME-Sender: <xms:S-dmZevZJ5cqMKzOM1wyvAj9SGtn4JoPa2sju8pxxPW3uwtlBDhe2A>
    <xme:S-dmZTcHWyBoFEItXL0HMgnvJufgjWb9MU9JJOeUYcjOLGAtnjQ1-_IhpD-GBiMXa
    mPHDyLGZmIBRih2Gw>
X-ME-Received: <xmr:S-dmZZzUUd9ouRTRml6Ri0xWUr1HcKpRkrS5Sh2ZbIUB71HEB32gHQcuU4KFd_ZU42LumwrCQpDhTB1wzbSMMsb6mNORsDBqPLn5oHE15ZZEPshR>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrudeigedguddtiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecunecujfgurhepfffhvffukfhfgggtuggjsehgtd
    erredttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshes
    phhkshdrihhmqeenucggtffrrghtthgvrhhnpeehgefhtdefueffheekgfffudelffejtd
    fhvdejkedthfehvdelgfetgfdvtedthfenucevlhhushhtvghrufhiiigvpedtnecurfgr
    rhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:S-dmZZMajych-m11ExaubOqZsAclefsBnwKYduqcBOkgEKMP4qsqIQ>
    <xmx:S-dmZe8mlp_J15urAta-0hdT0vWWgqjptV4pKHNCot2eqjDhlwjxiw>
    <xmx:S-dmZRXqI4FigFxjqAmgcPJI1rf-14mkJB6YnDaY1_OxJ3_SszuQRA>
    <xmx:TOdmZfJJ7lj5-HbA6vaQRMn4mJMzwprRWBFLcKe2G_oZuT-XwW_5QA>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Wed, 29 Nov 2023 02:24:59 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id a7a1b41b (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Wed, 29 Nov 2023 07:23:48 +0000 (UTC)
Date: Wed, 29 Nov 2023 08:24:57 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Subject: [PATCH 05/10] t1417: make `reflog --updateref` tests backend agnostic
Message-ID: <6db2f07045ae424d3b4eeb482d9608f38ef4c956.1701242407.git.ps@pks.im>
References: <cover.1701242407.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="eDtwHbjqH4x0G1h7"
Content-Disposition: inline
In-Reply-To: <cover.1701242407.git.ps@pks.im>


--eDtwHbjqH4x0G1h7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The tests for `git reflog delete --updateref` are currently marked to
only run with the reffiles backend. There is no inherent reason that
this should be the case other than the fact that the setup messes with
the on-disk reflogs directly.

Refactor the test to stop doing so and drop the REFFILES prerequisite.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 t/t1417-reflog-updateref.sh | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/t/t1417-reflog-updateref.sh b/t/t1417-reflog-updateref.sh
index 14f13b57c6..0eb5e674bc 100755
--- a/t/t1417-reflog-updateref.sh
+++ b/t/t1417-reflog-updateref.sh
@@ -14,9 +14,13 @@ test_expect_success 'setup' '
 		test_commit B &&
 		test_commit C &&
=20
-		cp .git/logs/HEAD HEAD.old &&
+		git reflog HEAD >expect &&
 		git reset --hard HEAD~ &&
-		cp HEAD.old .git/logs/HEAD
+		# Make sure that the reflog does not point to the same commit
+		# as HEAD.
+		git reflog delete HEAD@{0} &&
+		git reflog HEAD >actual &&
+		test_cmp expect actual
 	)
 '
=20
@@ -25,7 +29,7 @@ test_reflog_updateref () {
 	shift
 	args=3D"$@"
=20
-	test_expect_success REFFILES "get '$exp' with '$args'"  '
+	test_expect_success "get '$exp' with '$args'"  '
 		test_when_finished "rm -rf copy" &&
 		cp -R repo copy &&
=20
--=20
2.43.0


--eDtwHbjqH4x0G1h7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmVm50gACgkQVbJhu7ck
PpQPJw/9E5spJPh7CsOjMoYFW9IFjXXjMeOAHXBT6dHJFFmiIAK6cJTcabkTq/3a
PbdVuUB+cRUSke6pu8F9ZfM+pVuQvFIlzrHVrvRfHScBnBd9w1CfwQgyjDDh395R
VSMdnbfDIFTgTLIJLv5AY0un9YYKmwnEyzQMLnJ980LUpDs8ezvJdh6TaH4LnBTT
HlJWyMmKhN1QdRqJ/lfti2K5cMGDKrX3S1q6jrVbkotD9MR5cJHgfSw7LsBeySJk
wCX3Kp3Fwm2VhReZN3NXf6feeuCEbuHqEJUSCdSYPiWVYFdhOlbxBVWkvaUlKEVf
umXpaGCy1QNirZ3gbJmxuhe8ZbPo+/l+oe2oK3i2GAO5SUQ9DtnZ59939QW1A0Cp
KhNpPh2rg6uYcSM8xmd3h3M3OaECiTJKqqHEtaIN3qCNk61UGHStzl6L27UTRKvV
YhRxPrrmrgAqGDelhANq5UhHusFIfS1cjYug91+1gCI6qhGuRjLyK0oMT2iRM7dW
VcuBFh27SgMx4yo6a3m0VJ6mH83wQYqWXXEcKrokeDOc+KjgrJLgU4wogewPmlLy
pae7sIlEEf0zbz1GxrngxszaUaUH3asZVYyjfkD2gKbiK3D4YX/XZrlhqLyCuxSn
WJSURUvP1YZ87yAaRkOvleyrcbbIcBQ9pnNh66zLbA7dQllUBsE=
=U1wX
-----END PGP SIGNATURE-----

--eDtwHbjqH4x0G1h7--
