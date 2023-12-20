Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A83321352
	for <git@vger.kernel.org>; Wed, 20 Dec 2023 10:55:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="hy5YpZTS";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="mmoQqJQo"
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailout.nyi.internal (Postfix) with ESMTP id BEFC65C01E1
	for <git@vger.kernel.org>; Wed, 20 Dec 2023 05:55:30 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Wed, 20 Dec 2023 05:55:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1703069730; x=1703156130; bh=W2MlkgtCWX
	z61dPKmc1cNbUXpZ64KwuRmQxTU2CnuKE=; b=hy5YpZTSF7HjYRSebusPpJYE9z
	Jq3m1mpiTmAoIJtS/pTPCJ7y28jQWCcsF7xfzVX9JuviPjcev2srMDU8JG8lru+x
	Oy6WgjXZ8YNlpLjWJrqOue0YUE3mjjG4aKABjAM+Qm90wJwg7tGn61dIYF0gHNa/
	G8bcagGvQFaZx4+y66pJO7itBqkf0s6si/oL3VSoTZwWdHlY8cc/PEdJTf5o4bjc
	Lfa6S9gzngepYpw85e/UAZ/rXuXm3ayDgw762NimKDbyj5l+NPN4ujmKj2gn0Z1T
	hJv2+quFOgbgO8rUcbQpPCVr/Wk9pv4fcjqSwdop5Rz2AAPi5miCX/zbtLLg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1703069730; x=1703156130; bh=W2MlkgtCWXz61dPKmc1cNbUXpZ64
	KwuRmQxTU2CnuKE=; b=mmoQqJQoS51P5i9cYAhHJC2XRs6m+DluAeOB1XYjPu8M
	8IH8XkZpU3oS/Va5+OVnIDXUoJpZ70B7wV+n/2KipAv0Ob0SrMcyQnW0qk/YTFoY
	dFwwB6ap5A2B9sdkaWq27ub6hOL1E3phzo1SBs7bLPCC7Ytpm0ggGwHHzqSBjCFm
	oU2xKa6Ei6AJlJr1oHC1EPQC+gVAx+Hj8+atG8imzKY8njsNMRAvDQoiPHaKDyF1
	Yi5rNPq6lrXnzwiojrkW7d7B64RZuxrF+y9dk3mI1++3FsUzRqyVhE2sWWzOpbom
	g+Ftzbxl778BsHtdyCSWHX214hVVEc/kN/BCX6CTwg==
X-ME-Sender: <xms:IsiCZQGp08IdiDmxasOf2MyzpsunOC1Jh88QJIWtRG0xegehDs8maQ>
    <xme:IsiCZZX31xDjwsrjHlmuNf1puH0bSXgMG06DfwQD1HTl62Ux6TUd8IGvfTYsfyT8M
    U6espst_ttvEI2ZBQ>
X-ME-Received: <xmr:IsiCZaKgIJ_Bf4NWtx-Cng3ANmk5Acg-egjgtLyU6M5xJi1U6DPMkP_yLytwCQlPhccy_asNbRdMInzsp9V4WdFq2a_RxMVY1dBc4m4Fy8PGww>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvdduvddgvddvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvuffkfhggtggujgesghdtre
    ertddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepheeghfdtfeeuffehkefgffduleffjedthf
    dvjeektdfhhedvlefgtefgvdettdfhnecuvehluhhsthgvrhfuihiivgepheenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:IsiCZSFdcecwUIiCHkCeUtidAMO9qQJsiwCOdbYgjQu4vijmLYhbhw>
    <xmx:IsiCZWURoBk8LiRfOhQtsvSlQ-8XqkXAUrkesc5qD1MZ_Jd0ctBi2w>
    <xmx:IsiCZVPCythHpCsTL7cwW5n4xWRojcxMKy5i-jsNEikaLu-9ZQK1xQ>
    <xmx:IsiCZRCo6RGVmMuJ-8Xel85Prw-qtvGMhYt55W7l2IxV12AeHpJ0og>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Wed, 20 Dec 2023 05:55:30 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id d80e0a26 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Wed, 20 Dec 2023 10:53:35 +0000 (UTC)
Date: Wed, 20 Dec 2023 11:55:28 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Subject: [PATCH 09/12] builtin/rev-parse: introduce `--show-ref-format` flag
Message-ID: <8a3d950d692e6c86f980b79768719b3f0f622403.1703067989.git.ps@pks.im>
References: <cover.1703067989.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="PyNj3/AjeH52CtWH"
Content-Disposition: inline
In-Reply-To: <cover.1703067989.git.ps@pks.im>


--PyNj3/AjeH52CtWH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Introduce a new `--show-ref-format` to git-rev-parse(1) that causes it
to print the ref format used by a repository.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 Documentation/git-rev-parse.txt |  3 +++
 builtin/rev-parse.c             |  4 ++++
 t/t1500-rev-parse.sh            | 17 +++++++++++++++++
 3 files changed, 24 insertions(+)

diff --git a/Documentation/git-rev-parse.txt b/Documentation/git-rev-parse.=
txt
index 912fab9f5e..546faf9017 100644
--- a/Documentation/git-rev-parse.txt
+++ b/Documentation/git-rev-parse.txt
@@ -307,6 +307,9 @@ The following options are unaffected by `--path-format`:
 	input, multiple algorithms may be printed, space-separated.
 	If not specified, the default is "storage".
=20
+--show-ref-format::
+	Show the reference storage format used for the repository.
+
=20
 Other Options
 ~~~~~~~~~~~~~
diff --git a/builtin/rev-parse.c b/builtin/rev-parse.c
index fde8861ca4..99725a6ff1 100644
--- a/builtin/rev-parse.c
+++ b/builtin/rev-parse.c
@@ -1059,6 +1059,10 @@ int cmd_rev_parse(int argc, const char **argv, const=
 char *prefix)
 				puts(the_hash_algo->name);
 				continue;
 			}
+			if (!strcmp(arg, "--show-ref-format")) {
+				puts(ref_storage_format_to_name(the_repository->ref_storage_format));
+				continue;
+			}
 			if (!strcmp(arg, "--end-of-options")) {
 				seen_end_of_options =3D 1;
 				if (filter & (DO_FLAGS | DO_REVS))
diff --git a/t/t1500-rev-parse.sh b/t/t1500-rev-parse.sh
index 3f9e7f62e4..a669e592f1 100755
--- a/t/t1500-rev-parse.sh
+++ b/t/t1500-rev-parse.sh
@@ -208,6 +208,23 @@ test_expect_success 'rev-parse --show-object-format in=
 repo' '
 	grep "unknown mode for --show-object-format: squeamish-ossifrage" err
 '
=20
+test_expect_success 'rev-parse --show-ref-format' '
+	test_detect_ref_format >expect &&
+	git rev-parse --show-ref-format >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'rev-parse --show-ref-format with invalid storage' '
+	test_when_finished "rm -rf repo" &&
+	git init repo &&
+	(
+		cd repo &&
+		git config extensions.refstorage broken &&
+		test_must_fail git rev-parse --show-ref-format 2>err &&
+		grep "error: invalid value for ${SQ}extensions.refstorage${SQ}: ${SQ}bro=
ken${SQ}" err
+	)
+'
+
 test_expect_success '--show-toplevel from subdir of working tree' '
 	pwd >expect &&
 	git -C sub/dir rev-parse --show-toplevel >actual &&
--=20
2.43.GIT


--PyNj3/AjeH52CtWH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIyBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmWCyB8ACgkQVbJhu7ck
PpR6Bg/4xjqrCx7clvs8a0fIIgbFywqOjERZrhLK0XfQ+kksLsGuv8QDvbhb2Jhp
NjKMN8S6efm36n6GSUu2nuAhHiBA73k2YtXq0IRcQXYkywtAOheV/JUmnSa5MZS0
23TnTFQDYlVulX/Xl8v6ZAucZEvSfag3iHzT3zL2BI4dNS3h2raZ60mNAidFgg3x
Z/8D/P+Gi4ubuEm7mt7loQzHrY5i4iPQwIcfBaqn9GQ1EJ63cjlAXYNve2zei7/4
RHBAaFCwbR6wOEExTbzPcyajCKpjfOTPERLM182i+v2Veh113ufJ5UTNsPEkSXdf
obFK/W3FtrLx9+oEsSCdQinInkinaIaOelBcHlYKXXl+6oIdExsa/RQKpKybRJ46
XL4xPfbrZXkz/i+eAM6LENY1Ho3fEKumNUvSa/EJxFjCXJ6z/3RUuluqYnb8XPcr
1+K/G5bgF4x9qLnotsGCf3tBvf5IaXDCNIxWHFuv5uqE9c0ZmVu/+bDCeskNQCq0
wo9pUYpXtl9PfdAP/sJ/IBHdADtuTEgN43OzEfx30QkbNTXwramfq1baGjqecQ78
d0cZpDdX88Sm0Nj2XymneSvc4x34/D3rZqEww+5kjWuZZUslyAMIPfiMGrDWSZ0+
y6df5PCfyv6GuXym+I7gyFUKeQZKCK+Tc0jA7kXaCFhJ17f7ag==
=M2lZ
-----END PGP SIGNATURE-----

--PyNj3/AjeH52CtWH--
