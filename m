Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A52C200CD
	for <git@vger.kernel.org>; Wed, 20 Dec 2023 09:17:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="tfOUe7EY";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ARoPZ730"
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailout.nyi.internal (Postfix) with ESMTP id 3A4B95C01E2
	for <git@vger.kernel.org>; Wed, 20 Dec 2023 04:17:16 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Wed, 20 Dec 2023 04:17:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1703063836; x=1703150236; bh=sTI8hiXSak
	S5gsZAiu+ASBpkk2qb2jMOHHdNmIf5/HM=; b=tfOUe7EY4cgcdfcHzlGYi40bHS
	VQWqh7qDjgTvOrB6/qgBUnRR44TDQRO3IBukWSAHS1ZL9qRAglkBtHmR0yZj8HjA
	w4LSHxIYrHD/vXcvKQodqHeMYJZnp+TIzmaw3864ofdPfXkOOKZuPA2L9zywUk7v
	t4DMvOcqR60KKwqt17AB+1sihYpm7MU+2OEqu/u88VYUlsNZ+bba7Y/94QlvbG3K
	PWO9oYeakZ503BqixIy8rABA8khVkt2E9ujuEA5p8CvOQ+RAMIkwuPfCLEOyUZdV
	5b/leWi9ayWOUMqR4BwxJQMoP5xe7SoI1bZhGkAHbsJPuF4/PaMf3Osa4+Cg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1703063836; x=1703150236; bh=sTI8hiXSakS5gsZAiu+ASBpkk2qb
	2jMOHHdNmIf5/HM=; b=ARoPZ730EWlMX6HDMmYuVu7vAIDh8So5Vg4MmRn1CrZG
	7jHdzpFhlzp1mXcmqVGDaUZrH/WOTOIR6V2SeiiIt754T5wVPBoAcwqoj+Ef17n7
	x91J/MMjN8a6i4P913pRPvx9CW8envtnBfOBxZiszr2S6bEocV1GRmx/BePyzV2z
	QukN8v04UYnP0WhONiPEACKDW8TLh6JtpCb2uxAebHc+N12dorPnRpTbi3X8jwIK
	v72Dh5CZQAJ+SRYWG5eH/RSGntwRZhDtSe4gty+8L2YXbSwRIAIDJbY8JWeUET/o
	w7QcevNx/SOMSvdkEuZSNqFZvBBt8Hkdwj9nKXtagg==
X-ME-Sender: <xms:HLGCZfkrbe5uTRdrCtQkWraYw-N7KopN9mCt7xWXUYVaqPdD0CUEgQ>
    <xme:HLGCZS2Lf1mr3M6lHFxVVm4ryeEnzYn-z5wsDoiAQQEEvpIx5FqjlTHnqJCsPSJl0
    I_5B9ZcuvIqf9nTsw>
X-ME-Received: <xmr:HLGCZVoINf15QyqsV7AKC2zh49Ez7hn3BZPK0yeVzi2rB77neMJRv1qZvfAuVewEBoT_2VWsyzIfNMA6DUKTTsqaCbEEVnqOSpHk1_T41-tgJg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvdduvddgtdefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvuffkfhggtggujgesghdtre
    ertddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepheeghfdtfeeuffehkefgffduleffjedthf
    dvjeektdfhhedvlefgtefgvdettdfhnecuvehluhhsthgvrhfuihiivgeptdenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:HLGCZXnW8HhZ7ZjuY8iXDx8MhW6NhYcfnV4L7VySWh3XEVLEUH_CkA>
    <xmx:HLGCZd3LC8F3D51QtIdOgHoNjf2ZcYiEx9UeWQJpZvrgaAmKLdOMig>
    <xmx:HLGCZWv30OHuGl8HaouruPU0eSY8lVqDSiHJhSO4-uIk3Sq6bv5KBw>
    <xmx:HLGCZagWJ0FPd68GWAPZMraT-93O8OUFbi_ulba5Ae_SFhnGT2JBVw>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Wed, 20 Dec 2023 04:17:15 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 896d9411 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Wed, 20 Dec 2023 09:15:20 +0000 (UTC)
Date: Wed, 20 Dec 2023 10:17:13 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Subject: [PATCH 3/7] reftable/record: constify some parts of the interface
Message-ID: <3ad4a0e5b9afd7ef841c2671ac4a8dd23b315e4b.1703063544.git.ps@pks.im>
References: <cover.1703063544.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="WMjm1hwRzb4tbl+x"
Content-Disposition: inline
In-Reply-To: <cover.1703063544.git.ps@pks.im>


--WMjm1hwRzb4tbl+x
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

We're about to convert reftable records to stop storing their object IDs
as allocated hashes. Prepare for this refactoring by constifying some
parts of the interface that will be impacted by this.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 reftable/record.c          | 8 ++++----
 reftable/reftable-record.h | 4 ++--
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/reftable/record.c b/reftable/record.c
index fbaa1fbef5..5e258c734b 100644
--- a/reftable/record.c
+++ b/reftable/record.c
@@ -76,7 +76,7 @@ int reftable_is_block_type(uint8_t typ)
 	return 0;
 }
=20
-uint8_t *reftable_ref_record_val1(const struct reftable_ref_record *rec)
+const unsigned char *reftable_ref_record_val1(const struct reftable_ref_re=
cord *rec)
 {
 	switch (rec->value_type) {
 	case REFTABLE_REF_VAL1:
@@ -88,7 +88,7 @@ uint8_t *reftable_ref_record_val1(const struct reftable_r=
ef_record *rec)
 	}
 }
=20
-uint8_t *reftable_ref_record_val2(const struct reftable_ref_record *rec)
+const unsigned char *reftable_ref_record_val2(const struct reftable_ref_re=
cord *rec)
 {
 	switch (rec->value_type) {
 	case REFTABLE_REF_VAL2:
@@ -242,7 +242,7 @@ static char hexdigit(int c)
 	return 'a' + (c - 10);
 }
=20
-static void hex_format(char *dest, uint8_t *src, int hash_size)
+static void hex_format(char *dest, const unsigned char *src, int hash_size)
 {
 	assert(hash_size > 0);
 	if (src) {
@@ -1164,7 +1164,7 @@ int reftable_record_equal(struct reftable_record *a, =
struct reftable_record *b,
 		reftable_record_data(a), reftable_record_data(b), hash_size);
 }
=20
-static int hash_equal(uint8_t *a, uint8_t *b, int hash_size)
+static int hash_equal(const unsigned char *a, const unsigned char *b, int =
hash_size)
 {
 	if (a && b)
 		return !memcmp(a, b, hash_size);
diff --git a/reftable/reftable-record.h b/reftable/reftable-record.h
index 67104f8fbf..f7eb2d6015 100644
--- a/reftable/reftable-record.h
+++ b/reftable/reftable-record.h
@@ -49,11 +49,11 @@ struct reftable_ref_record {
=20
 /* Returns the first hash, or NULL if `rec` is not of type
  * REFTABLE_REF_VAL1 or REFTABLE_REF_VAL2. */
-uint8_t *reftable_ref_record_val1(const struct reftable_ref_record *rec);
+const unsigned char *reftable_ref_record_val1(const struct reftable_ref_re=
cord *rec);
=20
 /* Returns the second hash, or NULL if `rec` is not of type
  * REFTABLE_REF_VAL2. */
-uint8_t *reftable_ref_record_val2(const struct reftable_ref_record *rec);
+const unsigned char *reftable_ref_record_val2(const struct reftable_ref_re=
cord *rec);
=20
 /* returns whether 'ref' represents a deletion */
 int reftable_ref_record_is_deletion(const struct reftable_ref_record *ref);
--=20
2.43.GIT


--WMjm1hwRzb4tbl+x
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmWCsRgACgkQVbJhu7ck
PpSW0hAAjPGiZ+/DDwQKrmc5kpwa3zGBcdYL2ZWKppfE71B53uF2pDFAVmxMTyx4
MyKbdxH88mnJPBKdj1dEc35ofxEvULVcW2pTwI9QbbRs3JKSDpgKgtfKdLBjg8dz
4rApI+tgzZ082srTBT4qw7KflNUt2ovlss++ca1NS0TqKAenkSNeIs9uqCCbJQn+
e6JrgX0WVTigkbljzHSsWlmcYlQFLd5LEJtUKHev+NWX8pPAU4gbvA3sm+ha+lfv
QJ65v4y+juBuxG4fpbDvmNrvfB5Zsz3wes9iwPykSb9Lz4j+n3Q9ArI2nlWphkCI
kAwvzqqnCC3YWgEBZN+KGTNnmRhyVHUvy9hgXVDnUZdMaTRpz9jZhWBIetUzRETG
6BoyPVAW8S5aICIFtM0Ncf6WDJjMBim1GwWBvAG9SIRUMTtNyuGnL/pO64N1Hk0v
Prh9e32Pm7jb4UyMKLhWRE5T9615KOGHqkckiShFDNOvburnH3gQwiEKuya9AeTw
fkdPVTlgPRonzl0v+xYzTUOVgnB97q1O9rnxIPUeI1O7Uu7FzpORPwqV/ImHWTSj
wxZzzaGIszjh+6NJ688odzw3cdlcqeOULhxLGrcK3PThhxtcfGO+YbRFnQhhAtqg
cx4rQl8PaEume1fK/cI7PqP8k1U+XvCdiCglLTkkZjrPmKIYAG4=
=fJLN
-----END PGP SIGNATURE-----

--WMjm1hwRzb4tbl+x--
