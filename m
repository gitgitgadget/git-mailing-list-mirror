Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Zm+NYHBC";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Eiz4Fblj"
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE638111
	for <git@vger.kernel.org>; Thu, 14 Dec 2023 05:37:06 -0800 (PST)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailout.nyi.internal (Postfix) with ESMTP id 22F205C0163;
	Thu, 14 Dec 2023 08:37:06 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Thu, 14 Dec 2023 08:37:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1702561026; x=1702647426; bh=IlRA5wR2O/
	/F2fNfr00UfjVZHFHDvVtJMlc/L+cUd8M=; b=Zm+NYHBCGuSsNqXArvn9y+4pjD
	4ovrYIqY6SRieJAnApWjnLFotg2dTv0PGKylxhIWko7DKW1BRj7UjupfvOIho9x7
	LgKPLgogS4MkyBRCzBv/FKk4XEx/13oQDR35qlBpL5+P5N8Ee5Y9iyHGtfVqCvej
	kK4A+sJwl5htAEpmOc/gB0CQCKOwbGLUYSXRxzt+70L/yUOI2dGtKd3LLPig+VWc
	V9Fgbw9yC7uGSgAlv0fTtsymDJGQ+9rZccsfBke7zI1QudAB4AafzC4Ph5cg1K4/
	LNWlKqwZkdxEe8wPgPtOv1WMYW/SCR8ozSUfkDmX89mpY/6GheN0FzTgRKQQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1702561026; x=1702647426; bh=IlRA5wR2O//F2fNfr00UfjVZHFHD
	vVtJMlc/L+cUd8M=; b=Eiz4Fblj1TTv2AKZcIz8q9N5lwBxYBQbZxvQRLSiWkQ8
	lsC6+HCfQqiiUr9dQoEt6AwiyYspgEDSXRg0bPhIwCDsldF+sfZpPY/hBbllJXS6
	7Gay8eXte+5A4pe54m92oL7l+njkvhQ1qIkmDq1Ww66o96K4uu4v8A4se5obt+eM
	A4PlIdn+Awaw77NB1qciu6dU1B/tqR052KOQ+u6odh9oug5K1uZxNi/EaB/4n6PZ
	69AuIwPrEQUIqrCpgyQwckKkwAUi08m8SXS4k0yTMDUiEodtiOPIac8T4frO4PAn
	nCpHNvEut2rjitywl1XuomTAnY8TOUDiLix1++OHVw==
X-ME-Sender: <xms:AQV7ZVcvdhV1SvS9-4hZkd9o1nagmahqTgyNgxK0DoR2PtPt1T9q3Q>
    <xme:AQV7ZTNuBLCZzw5Iygv4dgvcCatQ5AJi8iqXNd07uDb9UQtOjPGJmRrVfTcy5fG8S
    hsV2kdaBk8EKbo34A>
X-ME-Received: <xmr:AQV7ZegVSbWYmF3ehSRRLK57eKxPyYNAK6i_CH0waQV1RMKOzHLnh6kNllb9soI-8zLXmcil-XNumuVdaHeZkdRcN7aa0u310Ocn82TuR0ZlAyo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrudelledgheefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:AQV7Ze8vkIARrw9u73X_eV8F2oO61jj0CkxTjYq7bfzhkTOic5VB5Q>
    <xmx:AQV7ZRvnDPfJjb8Qt8sQw04WoXblPUfsempjmwTwyB35bqZcJvLPeA>
    <xmx:AQV7ZdFE67-ZteTIqpT8zhsBCZxqKV9FHJ0uhFAzT9xeXL1UoHGvFw>
    <xmx:AgV7Za6c5cReMXDQGFhqBs8xxg1ll770f0hs7lMe2o4fIGq1sfe_Fg>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 14 Dec 2023 08:37:04 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id f2fc1b14 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 14 Dec 2023 13:35:21 +0000 (UTC)
Date: Thu, 14 Dec 2023 14:37:02 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Taylor Blau <me@ttaylorr.com>, Phillip Wood <phillip.wood123@gmail.com>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: [PATCH v3 2/4] refs: propagate errno when reading special refs fails
Message-ID: <455ab69177586370b809b4a790ae99ce5e97dafa.1702560829.git.ps@pks.im>
References: <cover.1701243201.git.ps@pks.im>
 <cover.1702560829.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Vj8WFFC77RbnawBf"
Content-Disposition: inline
In-Reply-To: <cover.1702560829.git.ps@pks.im>


--Vj8WFFC77RbnawBf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Some refs in Git are more special than others due to reasons explained
in the next commit. These refs are read via `refs_read_special_head()`,
but this function doesn't behave the same as when we try to read a
normal ref. Most importantly, we do not propagate `failure_errno` in the
case where the reference does not exist, which is behaviour that we rely
on in many parts of Git.

Fix this bug by propagating errno when `strbuf_read_file()` fails.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 refs.c              |  4 +++-
 t/t1403-show-ref.sh | 10 ++++++++++
 2 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/refs.c b/refs.c
index fcae5dddc6..00e72a2abf 100644
--- a/refs.c
+++ b/refs.c
@@ -1806,8 +1806,10 @@ static int refs_read_special_head(struct ref_store *=
ref_store,
 	int result =3D -1;
 	strbuf_addf(&full_path, "%s/%s", ref_store->gitdir, refname);
=20
-	if (strbuf_read_file(&content, full_path.buf, 0) < 0)
+	if (strbuf_read_file(&content, full_path.buf, 0) < 0) {
+		*failure_errno =3D errno;
 		goto done;
+	}
=20
 	result =3D parse_loose_ref_contents(content.buf, oid, referent, type,
 					  failure_errno);
diff --git a/t/t1403-show-ref.sh b/t/t1403-show-ref.sh
index b50ae6fcf1..66e6e77fa9 100755
--- a/t/t1403-show-ref.sh
+++ b/t/t1403-show-ref.sh
@@ -266,4 +266,14 @@ test_expect_success '--exists with directory fails wit=
h generic error' '
 	test_cmp expect err
 '
=20
+test_expect_success '--exists with non-existent special ref' '
+	test_expect_code 2 git show-ref --exists FETCH_HEAD
+'
+
+test_expect_success '--exists with existing special ref' '
+	test_when_finished "rm .git/FETCH_HEAD" &&
+	git rev-parse HEAD >.git/FETCH_HEAD &&
+	git show-ref --exists FETCH_HEAD
+'
+
 test_done
--=20
2.43.GIT


--Vj8WFFC77RbnawBf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmV7BP0ACgkQVbJhu7ck
PpSdsA//XhdOMsk2YLPzA2uNnhaC5W5iHNVlG3sguubRPRfd47mFr7fYJ0XKHkLo
PjyhgvVFvyW5OM0txm9YIqwNPD18rIcvi+r5jm5PaQYVkRM9r1OcADRTDfyWTkIL
QD5RxmWmzhqDA+WCMs02wJEnAM4Ste+xHbJJpNQ7GxNJd18iX/y0umduUAdXGvJE
rVonw5QeWEsXco5/lR3zasM7tV6tfgR0RcHCjm2Ipuwti9rnC/QZkrSbXfUlToZp
YO3OJaXLc/U8HRFsWp4GLpScs3H9QQ8GKJWKuewseiZNriHVjMZTbXnOLu6WpJeh
YZyRE7Um+qrVs3FTrqG8ScD1+8HuUwORSvYFuCyLhHVo5r0+voXOtS+2TDO7z7cK
3LgRKq0XT2fcaGCr2xCwO7lU6SBvTwd3qi0E9o8ntwSDKhWwTy8gIPoorr9H5WEw
l7GjlKujefz+5KhHLTsSGMC1P7F/vh/RtSWLPP6nDRoLEs+TkeTnBlgocThq4tje
EBdEvZEPBkizbCUaIJj72UUROC0TucKQtG/IadrtaP8/u+T78WG1z+uaQTHVBq58
wu/xL+ySD7oKDa20GqBC/NdwTxe0zrft0Om83iKAkkSRw9JgRJJFhHn38wv5ubsP
xO/QvN5SA1mhkkdXjEu7Tdf2e5/tgQzKQi+g2Osv/uYV38i/Q/4=
=KQZB
-----END PGP SIGNATURE-----

--Vj8WFFC77RbnawBf--
