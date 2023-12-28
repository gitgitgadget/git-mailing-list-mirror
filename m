Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23E3A256A
	for <git@vger.kernel.org>; Thu, 28 Dec 2023 06:27:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="vsr4ZZmH";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="GG0uBNC7"
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailout.nyi.internal (Postfix) with ESMTP id 4A9E25C00F1;
	Thu, 28 Dec 2023 01:27:53 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Thu, 28 Dec 2023 01:27:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1703744873; x=1703831273; bh=pJGuRR8HQw
	UNiZo4oxXE3ktiKiWu/VqFHcQYCTnifiU=; b=vsr4ZZmHzScEEgUcl9E6Y2In89
	T5shzz1+6mlCA7UUnMT3/XB2rIpoHhGqyvRUsLsz7ZbDvKLD1kFh1lO6pprtc0Qu
	B/xg5r00BDCc48TYoUYk1NtaqZClEfmQsHTRbFKc/+rfggAtoIt/iq26Yq5EXQA2
	9y2NU9Kx8NDj6qwty2Ybp9j4pSbbm7urqwBwp2dvnHhZr9ief2dD3dY/mUEJuOV1
	L1yotHLnSvKcvaHVU/hSKM5MkafOewqrZ3TgoEWLUZmxPeA+7qzwS/vvRdlpdKk3
	I1tRwFh5PDDNliJUMh8A/G8PzCtHVNaTjzkENjfgae0n5SfUfTfThTV5JHxQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1703744873; x=1703831273; bh=pJGuRR8HQwUNiZo4oxXE3ktiKiWu
	/VqFHcQYCTnifiU=; b=GG0uBNC7nkh5BkciV+ijPCWDmCgj/Tw0vlLVwvGXHEkF
	cmQcgkDV1riH6nr6A3zLSiTmipHrB61B5oZ2ZQ8Fgnd4qKwlwat7JztOKrQ61y5d
	ZbMTD7Eo6HSVhSwONS7cnflDevXWzIGDvVIHRnQqnkeK/S4YtefNks4xp1KRvtgW
	IOuLaYSDjzxS/PXlRlnTmZSB9lMctW/sd1xplGiVHB+/RCjCkkwrR9Y63fDJPXwd
	QpxuQNTgh5E0NrCP0sdCldIuHKPS6wfUltm6342WXz5O5xNPY98uua6YONWM8sva
	Yb5yxT7D6v0EF96o7RU30cfrQrzbvTYGmKW46mwUPw==
X-ME-Sender: <xms:aRWNZejB6x1gRBUtfw3QM0Xf3Kqss7CXVC849_Kry7rmJZSju7rwkA>
    <xme:aRWNZfAbbseW0AFh71Fqz26Q9wZrtrgB05moVyr4wwqriUOeDYuylEXarSI3gPhFU
    TWoxA8cSns8bPR-jg>
X-ME-Received: <xmr:aRWNZWHdm6-FKhiOdcjTfTFycXHS_5DAHymqdMP9xeotkHdtx8lhXkdONLnGlA4NWGAXySsHZgU0NClFwrXX_qy5aWbJSwA-Lf9b2BR5I_VnPA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvdeftddgleejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehgtd
    erredttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshes
    phhkshdrihhmqeenucggtffrrghtthgvrhhnpeeukedtvedtffevleejtefgheehieegke
    eluddvfeefgeehgfeltddtheejleffteenucevlhhushhtvghrufhiiigvpeefnecurfgr
    rhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:aRWNZXTUkUYtAzb6zAmsJMo6CS9OI_ATNu36rBeoUzm6kveLPoAHUw>
    <xmx:aRWNZbxxK8AOPbOUrlk0DwrRi9qRNPScuZmprUVHmpSF_h766qPpIw>
    <xmx:aRWNZV7x5DypkhmKdZzosGfLTAZACWOP9wG9Jthl1jnRZSGrYnHFUQ>
    <xmx:aRWNZUp624cza4u-R9eGivoLpLg7ZbjEBRcXGqTa_xqhgoGFscyzpg>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 28 Dec 2023 01:27:52 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 7328922d (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 28 Dec 2023 06:25:38 +0000 (UTC)
Date: Thu, 28 Dec 2023 07:27:50 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Han-Wen Nienhuys <hanwenn@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 4/8] reftable/record: constify some parts of the interface
Message-ID: <3416268087d474ce45b141105367d7f606bf36a8.1703743174.git.ps@pks.im>
References: <cover.1703063544.git.ps@pks.im>
 <cover.1703743174.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="OhytLHptO+9G2Adc"
Content-Disposition: inline
In-Reply-To: <cover.1703743174.git.ps@pks.im>


--OhytLHptO+9G2Adc
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


--OhytLHptO+9G2Adc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmWNFWUACgkQVbJhu7ck
PpSglQ/5Aat6ANfBdIw9reIaNK4acLuXGA0uRJaKgQ7UPRxDCyRs6x5uO8zP4gxw
ms6vGaIH7NjVuEa14k4g9g/n8G54781c49PGHs4hMp8GO8ZvJ39YDcjTlnSEV6Uh
YVNmgmeKBC1XECkzrjGFBba+qpIhO9WWpxC+olRgLBVfVG8y8ZzsO2ShjlFAOVI8
mdClj6jUQDk/5fYMN7BLgq1n6XiKWLzSRusVN3VXDUJtlHruXt2IQ6Rk5nyrueeV
eWMBftq26cU3+3l1ka62i7N1Jil3E8B5tMpMLbcKgISu13mq77ZmtP9gQzvxI4lg
UeS3Kaxaku3t5B3lsU9d76nl6NOmp3fm67uv+hZ+XbIBLlOSWMJHj0t3+6/WOTlD
6mP55Wzvz0m1K9VgyxrDRnEI3y0IdGLXoX2ntV74aNBpKEWuHh8TMMDrWw0GJlR5
wcgqtIjsP2iOo2XXuTzEf/SZn8Q6FTbf0kTJGgeaFQSnufSdXj7pO160/lVKxxSx
X9t+eO2shgPlOL4L+0a9ksgrx2OX1YqiM4PlkTO1mmhYIOGHIx3DlT0cDDEQGbFE
8RZhSeHqmI1L0JbdAkmI6VghmyvRxd7hqXu7Vh3af92ETQPK7EavcEfATspgvcgH
dbFpUjgvRkdHboy5LHktiBWxwB/1MzBFoNHsq2QP9hr3NuPUuaM=
=tbmH
-----END PGP SIGNATURE-----

--OhytLHptO+9G2Adc--
