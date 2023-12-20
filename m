Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F4B820DDD
	for <git@vger.kernel.org>; Wed, 20 Dec 2023 10:55:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="grShClPs";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="MpCh7vjr"
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailout.nyi.internal (Postfix) with ESMTP id 7E9D05C01B1
	for <git@vger.kernel.org>; Wed, 20 Dec 2023 05:55:14 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Wed, 20 Dec 2023 05:55:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1703069714; x=1703156114; bh=6n5GM0qSrG
	X9GdxD+Nh+HfSEClbOzmwHb3Re/FqzL70=; b=grShClPseUmn+t1gafSKay8WRs
	5uYSDERSwsm8PxhYYY4/6hGzu7w9N+FEZCzfLEc75StJPaP8KR2rsWAHSk1BD7ee
	M0iW1C5YK+Mkm95vbqw6wcewan6k1juLMcuXYqOkxUUOhs2Wq/31T6FBsJSAnxOv
	uFpA31SHXTp7UwuO0at+3KL7KwhvyuKsshZJRtFCjydKVTt4l9aaz3WtOLVbWpZm
	qoX9qP5dfa1eMrb9VKfiXUNxkxye27TzJTVwNLk1TAytuK/4YAmxwBpnkNr7Lk2q
	rSd76mj1t9Efu/BsAIJXDtu9aIdJK3kkd3tvCpz4qQPcqHz51AZtwzPMN41A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1703069714; x=1703156114; bh=6n5GM0qSrGX9GdxD+Nh+HfSEClbO
	zmwHb3Re/FqzL70=; b=MpCh7vjr1IGlnAEJC5EAsWVHVfhARw9536yrthFciVk3
	KO6BsJpLJA6wAPrqsreR/gtqVagVNW+I+Sc57lhDBHBtwRkVNx5t7jdcMcvKBwxj
	+M8GAIbHvrAHjOdNKsvHSgfr+4p9RjiQ9A6yB4Mhtb+/ISNrWeg4YA2LQfzP04Hc
	QhMdKAuohZuBMU9ciBevK4GDd3mrvItPEikwq+fvXAFvFmjNVNNm8YLDRPJaSjCJ
	u9ng7jl+TZFzTEro1jBrApk+0bFnm+6oSB+teEhMc+uwPPVPbpUq9a15k7O6B2O+
	dBM2x2fWumncoQpM3XlWNAyTmEmcG9g/QEvpO3lrsQ==
X-ME-Sender: <xms:EsiCZUalyGKkGvapK0r7lQAuGJb9KJZmq_EdzkczG3G_5PyGPHvVCw>
    <xme:EsiCZfZeaazpiLR9VF1ETEcnSpNa1lQZ-8xMLnyVa7yFMqCjKzwDxnObiQnbowkrm
    XHnVhmWDlP53Y1Uqw>
X-ME-Received: <xmr:EsiCZe_KVurACYbnA8ZpaXQ5-g9KNaTzcSrQpuXS7_g67k0JvLeUd7bWT6wqQMMi_xhwsgtDplrdrHkXr1C6nM3uz-q4Qf8XqkrnafO6YCXXzg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvdduvddgvddvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvuffkfhggtggujgesghdtre
    ertddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepheeghfdtfeeuffehkefgffduleffjedthf
    dvjeektdfhhedvlefgtefgvdettdfhnecuvehluhhsthgvrhfuihiivgepvdenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:EsiCZeqNflzK9XSTc6EtWaxdLrvAQsfGR6u536g6jWJTtCtrIV46QQ>
    <xmx:EsiCZfpsXhHCOlFEST2hwCX28_ZNK7RtVYvcVN3U14zQVnhuKkwQWg>
    <xmx:EsiCZcSee_791NF9XTOjpaDeiuk_LiETLPkbxyhRfSk3lJR_rD-dXg>
    <xmx:EsiCZZE64p5iAOYcuSK0dbDdBXmogRKIIP9X63MbTZZQUCJBWDQ4BA>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Wed, 20 Dec 2023 05:55:13 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id ab7df0e1 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Wed, 20 Dec 2023 10:53:18 +0000 (UTC)
Date: Wed, 20 Dec 2023 11:55:12 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Subject: [PATCH 05/12] setup: set repository's formats on init
Message-ID: <f90a63d63cfa2f0b9e19cdec4790a77d6a4b9b3b.1703067989.git.ps@pks.im>
References: <cover.1703067989.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="tiaDBcPMf4TsRnDe"
Content-Disposition: inline
In-Reply-To: <cover.1703067989.git.ps@pks.im>


--tiaDBcPMf4TsRnDe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The proper hash algorithm and ref storage format that will be used for a
newly initialized repository will be figured out in `init_db()` via
`validate_hash_algorithm()` and `validate_ref_storage_format()`. Until
now though, we never set up the hash algorithm or ref storage format of
`the_repository` accordingly.

There are only two callsites of `init_db()`, one in git-init(1) and one
in git-clone(1). The former function doesn't care for the formats to be
set up properly because it never access the repository after calling the
function in the first place.

For git-clone(1) it's a different story though, as we call `init_db()`
before listing remote refs. While we do indeed have the wrong hash
function in `the_repository` when `init_db()` sets up a non-default
object format for the repository, it never mattered because we adjust
the hash after learning about the remote's hash function via the listed
refs.

So the current state is correct for the hash algo, but it's not for the
ref storage format because git-clone(1) wouldn't know to set it up
properly. But instead of adjusting only the `ref_storage_format`, set
both the hash algo and the ref storage format so that `the_repository`
is in the correct state when `init_db()` exits. This is fine as we will
adjust the hash later on anyway and makes it easier to reason about the
end state of `the_repository`.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 setup.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/setup.c b/setup.c
index c1bf106379..5dffea6e2f 100644
--- a/setup.c
+++ b/setup.c
@@ -2203,6 +2203,13 @@ int init_db(const char *git_dir, const char *real_gi=
t_dir,
 				      &repo_fmt, prev_bare_repository,
 				      init_shared_repository);
=20
+	/*
+	 * Now that we have set up both the hash algorithm and the ref storage
+	 * format we can update the repository's settings accordingly.
+	 */
+	the_repository->hash_algo =3D &hash_algos[repo_fmt.hash_algo];
+	the_repository->ref_storage_format =3D repo_fmt.ref_storage_format;
+
 	if (!(flags & INIT_DB_SKIP_REFDB))
 		create_reference_database(repo_fmt.ref_storage_format,
 					  initial_branch, flags & INIT_DB_QUIET);
--=20
2.43.GIT


--tiaDBcPMf4TsRnDe
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmWCyA8ACgkQVbJhu7ck
PpRGahAAoDLs3tSGTeKda05mIJqdC3RUSMoTgUKXvap8A7bAi4KRQ2HD3G83G36e
LDzUgyqDz2g91DRtlF1/uGAUx8JD0P5iolPvNPVddq2iaxqKpKh0v8/MSuV0PCCV
LFe4jDPzekNKjFRkf+6nvkuPgobn6L7C6w73R1DvSAexnaVPgsTrzE96HFe0lYDI
ktM0acNcF/UX2w/ywb7SiKmReFoSnwuA43TLKtj0oJiYA6BJGuL5YbaQipTKCwMh
6bpT5jQjOLd6t3/9LId1kv3AoAi/G4sDBv2lGiOERAPez+GjkwCms1nMZkg0astd
0WDR13Pd1onJa0VpetGMOxjBdXwwMZxgheb+lfuigYAJpLTvi8yfVIMHy6tbABC2
N6y4Uhj6+iY/XmpN0pIlMKapTs65JHfJhf5GqzPjKyIg91/7L6aqDzn6K/VYxeFr
S6IrWbb26ptwlrhEMaGbUmJJl2jbyhccYeMZk9PDBfcpdYZ6B1MiA5XxXLI7xHMZ
shm6jLK6qOBiPTemsZknEzRKNiRAGz3N6kOMJdV59+RxmXDqCZrU5TCO1s2TNNDY
9PMQAebvPCK5IFcQD2lOddRIP0DxFtQWFmLu/dNcEky2J5Y8a3ScUfLd1HMNUYKf
Dl+zkY5dPLlsq4ukmGZfYPA57y0se1v18sRLIRqOQ8XmfkEu9RQ=
=9nE7
-----END PGP SIGNATURE-----

--tiaDBcPMf4TsRnDe--
