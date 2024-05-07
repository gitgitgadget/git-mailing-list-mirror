Received: from fhigh1-smtp.messagingengine.com (fhigh1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2EEB6BB2F
	for <git@vger.kernel.org>; Tue,  7 May 2024 04:53:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715057588; cv=none; b=GphzAxzWBqW8V0WLU4vro0HNjP1GEMGOEvPgwFXLHUahFkTKGpdv2+E8IiWfJUDx9ZZ3j3eqxhSQd3Z+vVMplVxZ28j40564Vc5tS7XM67DWg1/9O/dsgTrl8Ot2wph5EtEEn3DVmW9/snPvIxkR09bI2ZXIS8zKDbnZNYGnWj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715057588; c=relaxed/simple;
	bh=QIxnVT7TP1Z7LKljBJOvXZM0iuHhAxLnkCjJBdWOThQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QjcjMcGVPDPetME1Q0BSJQ2GdjOs3qa/kc4kG9cLwjBXfl3o8d1OuQ7EOLoNNWr0pjRIscQCGFgmP7M0wKaMfjQ42gjrdI3A2Q080iEtO9JEGinTegwMBZhi7Ijsw3ran7vTb1m0zK8Qg59NtaBL8qMhoJULdBsz2hLkTmG3lJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=jKPwLF5U; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=GqCiez30; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="jKPwLF5U";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="GqCiez30"
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 4F8421140166;
	Tue,  7 May 2024 00:53:04 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Tue, 07 May 2024 00:53:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1715057584; x=1715143984; bh=epubhXTdMf
	A7w1nIBQEwMEwgpug5cUbu5JXxBDQ3XNc=; b=jKPwLF5UitXmoN5qsIhE5/amC5
	18UOqYX++/bW9KPGQWLLoBkqRkQCKWASAQ3LbkTXE0iu3aurWlXXa96QkCZshSri
	yf1ujVuKQdEtG6HtMx985Jq16W53HvAvzL1Kb2pvutjWur9cJHKd5ys+nZOy4wpv
	fTmYy6MhvyLrFx3RhX9vu4RttV+DSRq/dBgFyxh2Vr9mvd9ssvNZJu91BmBrvYhS
	k5XEVHzCU+P9NRYHxUq5qtKsTKjy6Ut4paOKVPRxsvmShFnIj4gW5BJ04t1wAN1+
	pn6P+9x9wAzX3yAUkZoHuW+LGDBHK3xubXWNFjjtKfpbzQE4WyJ03V8QxfUg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1715057584; x=1715143984; bh=epubhXTdMfA7w1nIBQEwMEwgpug5
	cUbu5JXxBDQ3XNc=; b=GqCiez30lOkLQD0e+t/ytkleWRHQ14Z0tZ1K5AV2DTbe
	gUObDRqBx1x74YEVeGtLg03YxPmDuSinrOydGaUWM1Al87cHbn8dvZRcPo1H6ags
	UFssuE2oF0mP2xE4IKyEGrX9lAlQ2Df+matwmW33iEzjRsZHeFNKot4J8Abpkfsf
	mZMgaGoPl6ZgYLeau7LTiFRJeZdiH5+KqlwlOk14uv6NNlRlgU+mTRdh4TX0aNsp
	30X9APOSgm51fLkbPOTfrHxinJYWVAHobvmC83r3TY0ksiOCcPVJShzGk2REB5S3
	sjh0ovgQm6wizkXNvflj6ek4P3Mh4qg1bsFFdIT1sg==
X-ME-Sender: <xms:sLM5Zm9J7rDEzjEh8txAupvg4teiqzu78QwTldsPTf4Z1tN5w6cdfA>
    <xme:sLM5ZmsauafBrQkVzjVXkLVxnZzo7yxev6t5YL-NReuPCIh3z4z_4SNZcwJSF3OsG
    bAHo6ExdEnxeaj1jw>
X-ME-Received: <xmr:sLM5ZsC5kNPLo-5My7XwOEQXswD73J-i82He0NZND2OGed0j_yRsADEVnOIoaKgbgylDzJbpWT6qLNDnyDW0bRdbclYdSfhZ_l8viasPCQGcdRFEgw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvddvjedgkeefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:sLM5ZucCZR0To4rl0pn2G3DxoIPJ6tsubZzB2NKUwwvVFeaE8z4CzA>
    <xmx:sLM5ZrOK1X-B5y0VzCbl28lgEj5GKyPU8zzIfe9NfWOa9g0pyo3ihA>
    <xmx:sLM5Zol8c-AM7_BglR9kqHrubCvTHx-a4S2ssERQUdizW8PPAyynIg>
    <xmx:sLM5Ztut-GGcH-Snvx4QAyCXtsf-v6lAZApsk9HE2XC6hLgiS3uvoA>
    <xmx:sLM5Zgr9oY-ZIfXC1a3wR3Hfh43914S-rern-AIOanSGwZqbzVYpfM0M>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 7 May 2024 00:53:03 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id de05801a (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 7 May 2024 04:52:56 +0000 (UTC)
Date: Tue, 7 May 2024 06:53:01 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	"brian m. carlson" <sandals@crustytoothpaste.net>,
	Justin Tobler <jltobler@gmail.com>
Subject: [PATCH v4 04/13] attr: don't recompute default attribute source
Message-ID: <1204a342161235c38273981874add59031cb554e.1715057362.git.ps@pks.im>
References: <cover.1713519789.git.ps@pks.im>
 <cover.1715057362.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="IAxmqyNo4bwY3LKY"
Content-Disposition: inline
In-Reply-To: <cover.1715057362.git.ps@pks.im>


--IAxmqyNo4bwY3LKY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The `default_attr_source()` function lazily computes the attr source
supposedly once, only. This is done via a static variable `attr_source`
that contains the resolved object ID of the attr source's tree. If the
variable is the null object ID then we try to look up the attr source,
otherwise we skip over it.

This approach is flawed though: the variable will never be set to
anything else but the null object ID in case there is no attr source.
Consequently, we re-compute the information on every call. And in the
worst case, when we silently ignore bad trees, this will cause us to try
and look up the treeish every single time.

Improve this by introducing a separate variable `has_attr_source` to
track whether we already computed the attr source and, if so, whether we
have an attr source or not.

This also allows us to convert the `ignore_bad_attr_tree` to not be
static anymore as the code will only be executed once anyway.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 attr.c | 25 ++++++++++++++++---------
 1 file changed, 16 insertions(+), 9 deletions(-)

diff --git a/attr.c b/attr.c
index 6af7151088..a5b717e4ce 100644
--- a/attr.c
+++ b/attr.c
@@ -1205,41 +1205,48 @@ static void collect_some_attrs(struct index_state *=
istate,
 	fill(path, pathlen, basename_offset, check->stack, check->all_attrs, rem);
 }
=20
 static const char *default_attr_source_tree_object_name;
-static int ignore_bad_attr_tree;
=20
 void set_git_attr_source(const char *tree_object_name)
 {
 	default_attr_source_tree_object_name =3D xstrdup(tree_object_name);
 }
=20
-static void compute_default_attr_source(struct object_id *attr_source)
+static int compute_default_attr_source(struct object_id *attr_source)
 {
+	int ignore_bad_attr_tree =3D 0;
+
 	if (!default_attr_source_tree_object_name)
 		default_attr_source_tree_object_name =3D getenv(GIT_ATTR_SOURCE_ENVIRONM=
ENT);
=20
 	if (!default_attr_source_tree_object_name && git_attr_tree) {
 		default_attr_source_tree_object_name =3D git_attr_tree;
 		ignore_bad_attr_tree =3D 1;
 	}
=20
-	if (!default_attr_source_tree_object_name || !is_null_oid(attr_source))
-		return;
+	if (!default_attr_source_tree_object_name)
+		return 0;
=20
 	if (repo_get_oid_treeish(the_repository,
 				 default_attr_source_tree_object_name,
-				 attr_source) && !ignore_bad_attr_tree)
-		die(_("bad --attr-source or GIT_ATTR_SOURCE"));
+				 attr_source)) {
+		if (!ignore_bad_attr_tree)
+			die(_("bad --attr-source or GIT_ATTR_SOURCE"));
+		return 0;
+	}
+
+	return 1;
 }
=20
 static struct object_id *default_attr_source(void)
 {
 	static struct object_id attr_source;
+	static int has_attr_source =3D -1;
=20
-	if (is_null_oid(&attr_source))
-		compute_default_attr_source(&attr_source);
-	if (is_null_oid(&attr_source))
+	if (has_attr_source < 0)
+		has_attr_source =3D compute_default_attr_source(&attr_source);
+	if (!has_attr_source)
 		return NULL;
 	return &attr_source;
 }
=20
--=20
2.45.0


--IAxmqyNo4bwY3LKY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmY5s6wACgkQVbJhu7ck
PpTSfA/7BZLrJ+pfA1G39JTkcCcSi1lZ1aD0orEs/ZZQ/HugdgZMKkLShx5Zcaad
1+E4VP+tODA9KocW0arrLAGiRZacXvpLr7xFM7awt6V75wqjdRDK8LnkCcYAb0Yl
Mc1CdCIOZZdDBwT8om4WX+efpDlzMs1pJ3TnvDXFoHq+2rVIGnpOkeI6ng+y8RRN
KwdumaSywq1NFu2abme/0Fft6i6+7VaRvKrcOaSHXWNvh8WsZRpvSRjy0ro9xGjC
2OZzwSquCg+mAIWp/uu6cKR+sLuk2XTLghVYxgTfFbHTBivWJhb+M/tF6+cyYgDl
JUJPAudapclzF/lkTrNqU54hlQylT0y6+F5O1nVWZJYN5Y1HzLEeaNnfwuodYxCh
Ju0o3fLDTPbimctM81kVoHTC0QMSMhV3MGgqxG0s1Axen62ozghrW6zQzfyAFDPs
dEDxzIN7gDypE3bsLEcb/PR0EmxaY1H5e3urZYHd9BHfLEFPYwKofhJTjb02ThTA
MkXAw2F0E/dAlJcNNG9+U3CgsI4l93F1K1kZKSoDU2vRolGtImHVEqOyIrYpkJLb
IpoKoGJyWKgTaw93eDmtQxq51eccxKhGg0roxqpgNhYQEyI0Syf4Qua3oNiiQa5X
16mR8RcEA0qX11rny3WXk8zx0Xr6UnLefXnpgiu4ysaM77Pbam8=
=2nMj
-----END PGP SIGNATURE-----

--IAxmqyNo4bwY3LKY--
