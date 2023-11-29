Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="jPb5vwhL";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="QNtwC28+"
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8916A172E
	for <git@vger.kernel.org>; Wed, 29 Nov 2023 00:14:23 -0800 (PST)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailout.nyi.internal (Postfix) with ESMTP id F2E585C01AE;
	Wed, 29 Nov 2023 03:14:22 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Wed, 29 Nov 2023 03:14:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:sender
	:subject:subject:to:to; s=fm1; t=1701245662; x=1701332062; bh=Bb
	az9GX2PTrsL8sHfTccE7ciBH5Int2MjztiUxPJEc4=; b=jPb5vwhLTGQZXr1Dhz
	6N/mpkTP7I96X25opE6lNOP6x03QWq+48gcGtqxeD/iJndPIUtCqn6PlcjFndi8T
	mWLYTu6cLFI5bnBwmrKpCWA96trNgZ3Dc6VYV2o250dDXPsnUCmZ+tJRVkQRClY5
	rvt0pbFQdgSyNocB4SYnBq4aSr4rPGy1MS5hVK2j1S4PfuPEuimG42zwegGibKLU
	zpurP1RNsyJdvU4+eNg/SDdQovkjaOVwoTgzuGPqBMuh+Jv7BcFBLsYPbOcJGnc0
	WQbNT7K/lbkOi7pkp+3QJCvtNWSqyw58td2WmWfE5N7K2lnEcxQF0aq4N8vyBY1O
	eIpQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:sender:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm1; t=1701245662; x=1701332062; bh=Bbaz9GX2PTrsL
	8sHfTccE7ciBH5Int2MjztiUxPJEc4=; b=QNtwC28+6HwyEHt9JTVDRgQNRVcgT
	z/u9I910AkEBgMYceMytcU5n2U4G5B6jmJCXtuMq0XJwJcaFcmQ4OENZfqZu8bVa
	L4IrjejqmRQtvFndvebHgRgaB53x1Zz54GZm5e3cOj/SqoYq//7vkLE9mlBtp75P
	Pq0wpJSyq5Yid3UwIZvJIS3my8OLXeZf82h8as5lqflXl4RjXEB2MOutvLDdKv3b
	4IXf73ZABf0+tylOe4BCl0CeZNgrBCs6k/3t9UBSJTU0PyKlsBv1bAeKB8TaW11o
	QSlBKFQIgOQOSsebGnpNuBLvlIwOwZnbp1cK5UQNorkBCftNh0oGTq9iA==
X-ME-Sender: <xms:3vJmZdgTs21t1KtlSXXL0N8qvWDSwGxZF7PbaRfJ646JZ1tODBMbPg>
    <xme:3vJmZSCfKXy31PzcDchF2QhZGFauLiW9XHGCBK3C7MgpvKTGARRthhL_UFnuDTLtY
    awGEPHutOvPIlzhNg>
X-ME-Received: <xmr:3vJmZdHYj6s1TmWsrFGDrxGu2qGPvBhkXwNYTI6FIzrL8vjjBA10ICW5r48PQwBdO0c7tIQk3LXyquxlbDa99QQI-W_0x5SX8Us_s1kq2kaAaA2Y>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrudeigedgudduiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecunecujfgurhepfffhvfevuffkfhggtggujgesgh
    dtreertddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhs
    sehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepueektdevtdffveeljeetgfehheeige
    ekleduvdeffeeghefgledttdehjeelffetnecuvehluhhsthgvrhfuihiivgeptdenucfr
    rghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:3vJmZSSDmqyxP-JQC4ajoau64Hz82LZ9O160vvceUVt8q7cjw68G7g>
    <xmx:3vJmZazyD6lcp4X2zWRHSI_rBww-uqGUzlW7XDsTbrtTKkvkZ8uiDA>
    <xmx:3vJmZY53R6-VULnl48_aKvqUrOYcRq4yxQZHU9TlFhLfj0EdrkRLlg>
    <xmx:3vJmZQbftsJQSffAxRz8bUsh-OUqcQvC3fQq3x_RLtNyBAZUNtznVw>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 29 Nov 2023 03:14:22 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 68b3d92c (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 29 Nov 2023 08:13:11 +0000 (UTC)
Date: Wed, 29 Nov 2023 09:14:20 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: hanwenn@gmail.com
Subject: [PATCH 3/4] refs: complete list of special refs
Message-ID: <0e38103114a206bedbbbd7ea97cb77fa05fd3c29.1701243201.git.ps@pks.im>
References: <cover.1701243201.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="+diNWSUyvonf6Vpm"
Content-Disposition: inline
In-Reply-To: <cover.1701243201.git.ps@pks.im>


--+diNWSUyvonf6Vpm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

We have some references that are more special than others. The reason
for them being special is that they either do not follow the usual
format of references, or that they are written to the filesystem
directly by the respective owning subsystem and thus circumvent the
reference backend.

This works perfectly fine right now because the reffiles backend will
know how to read those refs just fine. But with the prospect of gaining
a new reference backend implementation we need to be a lot more careful
here:

  - We need to make sure that we are consistent about how those refs are
    written. They must either always be written via the filesystem, or
    they must always be written via the reference backend. Any mixture
    will lead to inconsistent state.

  - We need to make sure that such special refs are always handled
    specially when reading them.

We're already mostly good with regard to the first item, except for
`BISECT_EXPECTED_REV` which will be addressed in a subsequent commit.
But the current list of special refs is missing a lot of refs that
really should be treated specially. Right now, we only treat
`FETCH_HEAD` and `MERGE_HEAD` specially here.

Introduce a new function `is_special_ref()` that contains all current
instances of special refs to fix the reading path.

Based-on-patch-by: Han-Wen Nienhuys <hanwenn@gmail.com>
Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 refs.c | 58 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 56 insertions(+), 2 deletions(-)

diff --git a/refs.c b/refs.c
index 7d4a057f36..2d39d3fe80 100644
--- a/refs.c
+++ b/refs.c
@@ -1822,15 +1822,69 @@ static int refs_read_special_head(struct ref_store =
*ref_store,
 	return result;
 }
=20
+static int is_special_ref(const char *refname)
+{
+	/*
+	 * Special references get written and read directly via the filesystem
+	 * by the subsystems that create them. Thus, they must not go through
+	 * the reference backend but must instead be read directly. It is
+	 * arguable whether this behaviour is sensible, or whether it's simply
+	 * a leaky abstraction enabled by us only having a single reference
+	 * backend implementation. But at least for a subset of references it
+	 * indeed does make sense to treat them specially:
+	 *
+	 * - FETCH_HEAD may contain multiple object IDs, and each one of them
+	 *   carries additional metadata like where it came from.
+	 *
+	 * - MERGE_HEAD may contain multiple object IDs when merging multiple
+	 *   heads.
+	 *
+	 * - "rebase-apply/" and "rebase-merge/" contain all of the state for
+	 *   rebases, where keeping it closely together feels sensible.
+	 *
+	 * There are some exceptions that you might expect to see on this list
+	 * but which are handled exclusively via the reference backend:
+	 *
+	 * - CHERRY_PICK_HEAD
+	 * - HEAD
+	 * - ORIG_HEAD
+	 *
+	 * Writing or deleting references must consistently go either through
+	 * the filesystem (special refs) or through the reference backend
+	 * (normal ones).
+	 */
+	const char * const special_refs[] =3D {
+		"AUTO_MERGE",
+		"BISECT_EXPECTED_REV",
+		"FETCH_HEAD",
+		"MERGE_AUTOSTASH",
+		"MERGE_HEAD",
+	};
+	int i;
+
+	for (i =3D 0; i < ARRAY_SIZE(special_refs); i++)
+		if (!strcmp(refname, special_refs[i]))
+			return 1;
+
+	/*
+	 * git-rebase(1) stores its state in `rebase-apply/` or
+	 * `rebase-merge/`, including various reference-like bits.
+	 */
+	if (starts_with(refname, "rebase-apply/") ||
+	    starts_with(refname, "rebase-merge/"))
+		return 1;
+
+	return 0;
+}
+
 int refs_read_raw_ref(struct ref_store *ref_store, const char *refname,
 		      struct object_id *oid, struct strbuf *referent,
 		      unsigned int *type, int *failure_errno)
 {
 	assert(failure_errno);
-	if (!strcmp(refname, "FETCH_HEAD") || !strcmp(refname, "MERGE_HEAD")) {
+	if (is_special_ref(refname))
 		return refs_read_special_head(ref_store, refname, oid, referent,
 					      type, failure_errno);
-	}
=20
 	return ref_store->be->read_raw_ref(ref_store, refname, oid, referent,
 					   type, failure_errno);
--=20
2.43.0


--+diNWSUyvonf6Vpm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmVm8tsACgkQVbJhu7ck
PpQD6xAAk1tOfVMElTqb8bQ9Y4exFg0d+djoJmaG/uy43RxzK+vSWqezmimZokdj
Zvi6ViIereSrpC/1rZy051kYr25qN/tmOI1JO+M32Na3yuH/T4h50O+FPzxnSOGi
jnhbRhbIwKrZGXvgLyky/ZQm/EXUNbxyJzvc9FQ5YULi4wKx4TfV9+tUfw+lNi9z
397uZuQS3QkhsM1AJQKuwWZcZ/k443APgoVFtxmTBaDBsy9+wPsh7PCV9s3eaKRx
/gInZOMj4RuE0L6r4IK5mv33AM9H/TE7OpUZyEbwJf5xGaV+aatOMGAdRPOAonSa
kqrHJRQ+04L6/sfzccJJtUjqZtgOKQrlCOjlRM9uQbgX/0CGUbcnJPY9KNbS55Ye
eau8G/Q0Z0ZK6HVNbHhrgWyzPDBS6gxYaZuDBqIvf2IbGd8GwdAZol0thH+GGQ6Z
+WyeU7oTNIePlXLw1fEk8SZhmkPMJFXS9gBCbQ+Pew1wf5Ns1zxcSuzbqS71mWWJ
ni1ejllyLE4yKxUPaPN1x1GftdUBFmXfjccSZs6Xw6y7BQo/sjn8TbzVAOyWxivw
dIigc1ye8Ix4HQRsrT+aiD9o6nmU4k7hPBkD0Fu/sgFMcUrMfKnCc1FWDwVTbfmd
dOUC3UOiSp7GSB72by26YQHKvJPk2y8RwjNzaOTRfCHMBQoGf5I=
=uQPn
-----END PGP SIGNATURE-----

--+diNWSUyvonf6Vpm--
