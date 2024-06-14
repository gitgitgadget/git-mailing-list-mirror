Received: from fhigh8-smtp.messagingengine.com (fhigh8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FAFB1487DA
	for <git@vger.kernel.org>; Fri, 14 Jun 2024 06:51:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718347881; cv=none; b=gsCFrxjXgih1N4avb+TTkLpp2HOXUZo1tQJWUKqiE1tcMtcwFFa8dD4gmpAB+IsyCSHHnzjnFzgRCTsSsv/ukkZ2zrx4TP6hocYx1hPgxHMvb+Ku8/DHrBQ3uXYwFNPokNnqj9M1MbquEd2YRfhZwP8GwP9VMYYKcCRbZbTwbNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718347881; c=relaxed/simple;
	bh=6v2R8RfShcL+tzrlOebJJy9txFKLKES1Ay6WQT0lk04=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SgwRbpHAZ68gBPcja9BHFI8uFxGpb2tfGbR/iZlL5C2zvT9Qvtrg6h3VfeKdpH2d19l5AaeCZweazlq7AXuE4rCCrj9A2saP0ifVW4RDzoq3ZrozAYThCD+BQ+DnM+8GhxT9yaFEJpQDrsUTCwbi88er+DBEaE0dwMY+nM9Qr9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=pYtA5PCC; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=GtUEL8Pm; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="pYtA5PCC";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="GtUEL8Pm"
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 97E3C1140259;
	Fri, 14 Jun 2024 02:51:18 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Fri, 14 Jun 2024 02:51:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1718347878; x=1718434278; bh=qWqzKZkh2w
	3iA5TDca/pl0kLcBMqWZy9wPl9PFr0mj0=; b=pYtA5PCCTTBczfalShxpCE2xvR
	JkwtSpfs/KJmhi5LkCjrgiYhLh30KfZpeC3iUJyEfEkIcg4pfwnWPW1P9aK+s6ir
	wU91NgLZ7lSftLfICftTUoE7Ej5PL6cKsfefgwwIfsopZ4eQnOJrZITD/vxkgC6R
	bS3zPW93hHn2K3TNGO5il9o3Bs8Tv+UVsvH0NYrrOqw3OJDaEsdWqcBcEPzaFyFa
	oq8JFIQKbmbrcl+5bCunBGr7axzP8Y613plUw4NZtWXe/d2+EwAKzqbaGbat2pB5
	W29uETzxGLCxY9jBxc9vGPq+YpYNQffz5WXT1Qppmn+KO9Cgput2AoSHixXg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1718347878; x=1718434278; bh=qWqzKZkh2w3iA5TDca/pl0kLcBMq
	WZy9wPl9PFr0mj0=; b=GtUEL8PmGru+ETD4Wq+RgI91jL0sj3pkhrmV8MbBpBYd
	R+57SaJjoy3W6Mqf9fsZ4Yw7N3QXWXd9XJsIDtupQQbLT53Dy6aiHrS0xhCoDNe8
	I1KAdcNTKJGkT1ya/YDSjTkPCV2145D7zjeDYdxYAGz673dWFjxrdcIk+CyE+mhw
	FEa2GQLtcEc3Zk0hFsuBAp7y3+2VnlVsivrUpxALAU8BfTyr5GsK1w0tLtpbQjdQ
	oXYyf2105Om5XywD4PkmoDwVPcN4Q+L8kl+0yyhwvx47q4HKbFSM7Osk9W8O95qN
	KuwkgDZr7ipnJ5JdjYpRtUypxZ4x5pSWX4JMgTFKFA==
X-ME-Sender: <xms:ZuhrZou-o4-g-9AdcWyeaKO0zCbI0Ws5nk7mdDcFXY6W1pDSaY24Ng>
    <xme:ZuhrZlcfA8D5ww8En4yWUL7Pj7_SDU1PPfx-yvT9zWNCBWPdcsqMuETl6x432gdpa
    yPgVgpXymGBQ0CiPw>
X-ME-Received: <xmr:ZuhrZjzaEN0HWRgQX7dQ_rMDVqtf75mNdTWZN_kjb1MclENqCZawEyu3KWWiLPTPNU08NdI7RDsQ-H1ZZoYxGPtv47FFs_mU3BlCoCGQ4qpABg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrfedukedguddtfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrght
    rhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtth
    gvrhhnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeehgfeltddtheejleff
    teenucevlhhushhtvghrufhiiigvpeeknecurfgrrhgrmhepmhgrihhlfhhrohhmpehpsh
    esphhkshdrihhm
X-ME-Proxy: <xmx:ZuhrZrM_csAPS0zGjBS0MQ24hEcHmpHtMkGIQHJGkLTnXAGMeIePQw>
    <xmx:ZuhrZo-1J8UwF1eRRp31hdKlxrfOyv-iQeKyRk5e2Nkd8yk63J0SJw>
    <xmx:ZuhrZjVkwYF1p_LDp9CQ-x1q-7w6mV9hnarZ0qABXp1pxEKz4-fO1Q>
    <xmx:ZuhrZhfa2MiI5HUVDpG8Fr7ti2ADaKIzyOdYe_MabAHm1Ukbzjlzfg>
    <xmx:ZuhrZnkSX7pnZVGJbUF1DjgHUd6eATo2gm28w4gL3Of0ZvY442luC5i9>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 14 Jun 2024 02:51:17 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 393e5ed5 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 14 Jun 2024 06:51:02 +0000 (UTC)
Date: Fri, 14 Jun 2024 08:51:14 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Ghanshyam Thakkar <shyamthakkar001@gmail.com>,
	"brian m. carlson" <sandals@crustytoothpaste.net>,
	Phillip Wood <phillip.wood123@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 20/20] hex: guard declarations with
 `USE_THE_REPOSITORY_VARIABLE`
Message-ID: <436ffc05701845e1e3bb19ea46d017d5b9b4114f.1718347699.git.ps@pks.im>
References: <cover.1718106284.git.ps@pks.im>
 <cover.1718347699.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="kWTL7F45AESNNKnR"
Content-Disposition: inline
In-Reply-To: <cover.1718347699.git.ps@pks.im>


--kWTL7F45AESNNKnR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Guard declarations of functions that implicitly use `the_repository`
with `USE_THE_REPOSITORY_VARIABLE` such that callers don't accidentally
rely on that global variable.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 hex.h | 26 ++++++++++++++++----------
 1 file changed, 16 insertions(+), 10 deletions(-)

diff --git a/hex.h b/hex.h
index 9809667f33..e9ccb54065 100644
--- a/hex.h
+++ b/hex.h
@@ -13,10 +13,6 @@
  * input, so it is safe to pass this function an arbitrary
  * null-terminated string.
  */
-int get_hash_hex(const char *hex, unsigned char *hash);
-int get_oid_hex(const char *hex, struct object_id *oid);
-
-/* Like get_oid_hex, but for an arbitrary hash algorithm. */
 int get_oid_hex_algop(const char *hex, struct object_id *oid, const struct=
 git_hash_algo *algop);
=20
 /*
@@ -35,7 +31,6 @@ int get_oid_hex_algop(const char *hex, struct object_id *=
oid, const struct git_h
 char *hash_to_hex_algop_r(char *buffer, const unsigned char *hash, const s=
truct git_hash_algo *);
 char *oid_to_hex_r(char *out, const struct object_id *oid);
 char *hash_to_hex_algop(const unsigned char *hash, const struct git_hash_a=
lgo *);	/* static buffer result! */
-char *hash_to_hex(const unsigned char *hash);						/* same static buffer */
 char *oid_to_hex(const struct object_id *oid);						/* same static buffer =
*/
=20
 /*
@@ -45,13 +40,9 @@ char *oid_to_hex(const struct object_id *oid);						/* s=
ame static buffer */
  * other invalid character.  end is only updated on success; otherwise, it=
 is
  * unmodified.
  */
-int parse_oid_hex(const char *hex, struct object_id *oid, const char **end=
);
-
-/* Like parse_oid_hex, but for an arbitrary hash algorithm. */
 int parse_oid_hex_algop(const char *hex, struct object_id *oid, const char=
 **end,
 			const struct git_hash_algo *algo);
=20
-
 /*
  * These functions work like get_oid_hex and parse_oid_hex, but they will =
parse
  * a hex value for any algorithm. The algorithm is detected based on the l=
ength
@@ -61,4 +52,19 @@ int parse_oid_hex_algop(const char *hex, struct object_i=
d *oid, const char **end
 int get_oid_hex_any(const char *hex, struct object_id *oid);
 int parse_oid_hex_any(const char *hex, struct object_id *oid, const char *=
*end);
=20
-#endif
+#ifdef USE_THE_REPOSITORY_VARIABLE
+
+/* Like get_oid_hex_algop, but for `the_hash_algo`. */
+int get_hash_hex(const char *hex, unsigned char *hash);
+int get_oid_hex(const char *hex, struct object_id *oid);
+
+/* Like parse_oid_hex_algop, but uses `the_hash_algo`. */
+int parse_oid_hex(const char *hex, struct object_id *oid, const char **end=
);
+
+/*
+ * Same as `hash_to_hex_algop()`, but uses `the_hash_algo`.
+ */
+char *hash_to_hex(const unsigned char *hash);
+
+#endif /* USE_THE_REPOSITORY_VARIABLE */
+#endif /* HEX_H */
--=20
2.45.2.457.g8d94cfb545.dirty


--kWTL7F45AESNNKnR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZr6GEACgkQVbJhu7ck
PpRr1hAAkApDLc/UhtdjKeQEyTFHRALixrE18aPxU2s2oC9uFOSLakqqo7Rp8m3b
/aRfwLnZNWgOH5a1cN9shPXW5+AGwDn1+RFigosart/ED7Jk+Fu1ncKRYgaAWJtV
Kvk1gYyGRBT9nA1XqMkUo8zZfSaMKEERjIABoKZjO3nI4jxxCDy8YYI730yLFBCI
7Zmn1sZoCsNg9cVCGH9YBt/ICptD/mu6W5omp7U2sEx347ybYO8KIIYaZe4/AZah
kxpAgMdLJsAqggJrg8Bo8oGentijrbm1t1s0byvCkKXoYgeHi2rIDoyly5BQkhbm
4gsH/RywWWl1o45wXKAxqNC3z4NHdcP1NTkQVtiiMxIkhwU7Mt/9sraoHFpNAp3v
glJdMVp6pGBnBRjtezKLVxTIa7F9uNz+0aSjLPiaQpdwrUsCuF2uRtOtVKWvkrkq
fEx2SSpd1OlOZGM6pUSsYhx930ZqW6+pooINQjdN0ZOeviDyYqqehmeoLClLuhtL
uFjzVssLPEBPryDnLwE/fRl91q0MjnWeZAzMnLaeCrpEJG8j3V+STP4/TADQGmP1
0HkMt0RSrPGEtlFovGzdeTJ/SY3+s6kMnMopotZNCKfedxHJDs35fjh+iYKGhn4P
9As+T1CdMSF+/WV+YZh4CvvXI69p2WvhtVlAQIYOnE788q+NSrg=
=jQ/P
-----END PGP SIGNATURE-----

--kWTL7F45AESNNKnR--
