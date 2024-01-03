Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 256D8182C6
	for <git@vger.kernel.org>; Wed,  3 Jan 2024 06:22:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="UplzA90S";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="1lL2BaFD"
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
	by mailout.nyi.internal (Postfix) with ESMTP id 1F9ED5C01E3;
	Wed,  3 Jan 2024 01:22:29 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute7.internal (MEProxy); Wed, 03 Jan 2024 01:22:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1704262949; x=1704349349; bh=tUcaSsK13l
	ZbfrDLNbP66sBapQF9wLtTHjI2MWtsVxM=; b=UplzA90SkZMvH84QxndYigAydo
	qua6j7m9i0uvzPml7vzlIq+K+hw80gWlDPk7K48hIY5u02EN90FeToaBnR0qWAuh
	Q4+S0WoPRF60N05IFCKu5I4cDNFamrmPVxUYLv8MhP7e3ANZa3tDXPxFz2gqg5QN
	BzLLFkXG7Ip2NOU6UxDP7BdU/rKVHAa99/c7eIHQnYYsu2khea1mprB5w2PuOdAd
	c4tQxNlkLJiIhOsnGN4FjsrbzBjxUV6qVKs/Mpgr7J7B3kiFWF10Xg7Mmg90sBXA
	PcRp9n+2/zeBOTp4O+11TYMx1wSy4KHhbIt/njQFAQVk+vuSvRmVQH71gZfA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1704262949; x=1704349349; bh=tUcaSsK13lZbfrDLNbP66sBapQF9
	wLtTHjI2MWtsVxM=; b=1lL2BaFDJpF8VRbJX871M53x0I66QPFltuReYAQG50R/
	VgNtIAUdxXpTiXXumI44LykYeF0Iua4vNXfMP+4znRioa5aTzduR3LapAiVdX8Pe
	r3/xag0Au9NOAnbimWNBe42hLGhd38QKvRMoTgCBBCDVwQylvqlRp/A6EGGsG03P
	bAcmP72CEHHiLqr5WCqDVM8zD0DjfmHGrtiwYFZjqx5hI6qtu/jYNlB4hA3VAQuL
	1ZgsAWfj7deaYS8MC50boqyCayZBDO2+5e7aj3OxRIHLgjFJoiZeRK6Q2cLXBhXQ
	DRMEh6XRqK8+E+uBh9y/ubznU29p4kDkZcOsvDl3Eg==
X-ME-Sender: <xms:JP2UZbWTgOxubyuOfmOxSBlpHZGTgGH3VbvuMsBlaZlMFf2euEak8g>
    <xme:JP2UZTmeRaCGeLTH1mWX18PaWSqg9d6hoDXuANcc6SJREDmhng32oXycgz2DvURLh
    VsIPMUjzOdSignEIA>
X-ME-Received: <xmr:JP2UZXbstwtVKZWUCPPqhi4j5_p6KzEY3q8Tp4ZjY1cveOyH1UyS3SgmERjkUsL_kFT5BsJuoq50xfZPI5dyhDpifRU5TlpvKpoPFEpvdORZIA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvdeggedgleeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehgtd
    erredttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshes
    phhkshdrihhmqeenucggtffrrghtthgvrhhnpeeukedtvedtffevleejtefgheehieegke
    eluddvfeefgeehgfeltddtheejleffteenucevlhhushhtvghrufhiiigvpedtnecurfgr
    rhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:JP2UZWUebdG8Fz_wh7eCGbxV5ymtOb6B9PO8WyganR4uHpKDECUmCQ>
    <xmx:JP2UZVlzJAxzHAYdRA6TbwfgNWKeD45n_b-2k6T6m0pKNZjhQkM9ag>
    <xmx:JP2UZTevGfBN5b26IKNpVfO0GybcH6s4Oi3UXJAcixDZhEfRd73FMQ>
    <xmx:Jf2UZVux4f95SKo9mOzkERDuFB8Jj03DzXGd-z2F0cTxGLYg-1oMGw>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 3 Jan 2024 01:22:28 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id faf4a90b (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 3 Jan 2024 06:20:02 +0000 (UTC)
Date: Wed, 3 Jan 2024 07:22:26 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Han-Wen Nienhuys <hanwenn@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 4/8] reftable/record: constify some parts of the interface
Message-ID: <017e8943c7b0b735d0252ad368f52443601da716.1704262787.git.ps@pks.im>
References: <cover.1703063544.git.ps@pks.im>
 <cover.1704262787.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="+C1yAjrH0zG0yAm3"
Content-Disposition: inline
In-Reply-To: <cover.1704262787.git.ps@pks.im>


--+C1yAjrH0zG0yAm3
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


--+C1yAjrH0zG0yAm3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmWU/SEACgkQVbJhu7ck
PpQeWBAAql3/QJBxsxlT9Awxsw5iR1Pw3/2WIODb4CDyFIIwqtrT9PuLyFmV1pJ9
eKgBDbMLLZl5RaAo+7P65pmMlMJamr9w7wCqIEd7moQPSX6g4WxpFgnrTMXnnIYT
REoRbzcVLvVyzzXfmYWRhPqKOoZm0CVRxt1tISRFWLTp5MSVso3iIBdFPywGxGBM
k9wPxP9tZOLCUpHxPeRmj3aeTNS+dlp9CxBpgJ5yw00PipYlYdPx1VsAN/SoDMg6
UvsMw0hcmQVwNWYyqKjN6NfWb1zmthGeQBt3ps+nukuRmjoxUouG/vrMAUdANQ9G
R+Ir9PDgkIF0hMUD+he9i1i2Wi6ilVkiDja1/9Qh23T5sbutX3wSFQny0unCeOFD
tVsQEyM0UXpIvIdU2ZVJRt5g8b0rFKLyIIl101Fjtg604s+8n6tyaxc6f9mrYHEu
SOG8JLLy4ehM7rEZDKnxi2f+UpJjFKW+9zh0xpanlORGUXMxRf44djK+QYs245bK
ldV+vykT2OwroIuSZjudm/0/bMTYotcK+BRqTRgU0iyhqtuTuTURvu0Gz6g6frYr
L+LOfcAeuXw3gyJXtyel0PKqxVYVbH38zQghM+HuhbnkYPnmDjBli7WIn7rJ5XDh
2B2YO+4nk/6OcUbiB5fT4IATKOsD4o1Ma8mfwIr5Qv6g04NGUFQ=
=B3L3
-----END PGP SIGNATURE-----

--+C1yAjrH0zG0yAm3--
