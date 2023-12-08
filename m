Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="vKrLDiEU";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="pnOXc4gZ"
Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23A15199E
	for <git@vger.kernel.org>; Fri,  8 Dec 2023 06:53:14 -0800 (PST)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailout.west.internal (Postfix) with ESMTP id 7B0B03200A44;
	Fri,  8 Dec 2023 09:53:13 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Fri, 08 Dec 2023 09:53:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:sender
	:subject:subject:to:to; s=fm1; t=1702047193; x=1702133593; bh=Eq
	lcaFpix6RMcFAN5cvFjMyS3zs/JYMwp4Q9eTiC1Wc=; b=vKrLDiEUyhTShc+9tr
	AcNWDMMfSFZkvys8yfHv8oOh/6Vd3teQpw4C06C9e+PNlrJATHoZfj9oenGhgyJ9
	GFkNDgTuLLTMmeTPpqc6f+pE0Mva9GShHmNUbNUHACJDmGwSjbXRlntEsVmGRxxS
	Q/ymyokQuvUNrC5bZG8sWfhc1p73KMCMg2mCdR7gkx6rbmZJIJN7CsAN2fsEEUyg
	y16qvn/xu7tJbnRMSlo3PZtZyhUhArGWB/8bLRIJkQ/ayTHHikdWQ0iTAUPfDtJK
	PxFleVWkQ9HJu9kR2+k27O1AEqoEWg107mOW+Vg1XaNJ8HngC+Fka2uvU27jmOZs
	/sDQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:sender:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm1; t=1702047193; x=1702133593; bh=EqlcaFpix6RMc
	FAN5cvFjMyS3zs/JYMwp4Q9eTiC1Wc=; b=pnOXc4gZmuqnIjwvCr34D4fuZvkv9
	/MCRaT7d3WIPDCe30qzU4xlk0+nBUUYYOEh/c6AAtbvdjdDb9us0vQqE9eQyAAde
	KjJQ7oiLt4bkJLZvNK79rkLTbtBZVuqez4vdF4EkvYpTcJqWL/cMEMTtamoZUNl7
	P4sNMhnuspwHeoBuowwCSX/zPo/3yrAp0hjZ+AahB+DazNfnyS1Iu+kNdPqHvXJG
	e89iBsaEXIbqAaAuzoGkrTuALOn/j0MaHYNLsIIjm9XxLO78BodRtP7753U2KBBO
	fz6V4romn0lCHp9Z4zhTFn3lWvk1dzdMW6WzeUfopTLiGABOYvQrkUQFQ==
X-ME-Sender: <xms:2C1zZeZqSa9XT6cWf5pILGWpwAXYwte55fAArca31mLcRh37GzXPHQ>
    <xme:2C1zZRZES-Da2JdkUl4THc1IBMFQ8R26PiSVwFBM5-3xyrQNn4lB8UA8OgNA4eWH5
    Ee6Q4FCaQm5GL1Dpg>
X-ME-Received: <xmr:2C1zZY8Z4O7pA3RM800zebWhT0jof9-OlxmY8gchbRveLPckcNhB2SzLKzmafKTCJxcks5KS6Ew0EMBj8EQ7cLzUhdBgLxzCy2k0AWHk5iRjEj4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrudekiedgjeduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:2C1zZQrIGOMO3jjfAwNNE7aMbHd7Ug-kc8qH5tEMYgC7ed4JbqR-Og>
    <xmx:2C1zZZrswUY1RhW6bjW1NsA1LmOxh0YnylU8md846O2_iKyHGPxoZg>
    <xmx:2C1zZeS1AobBSdZ1m1JEoqqIBjIt3ycVinuqF9FfsiSZKqpL2Au44Q>
    <xmx:2S1zZaAKOeU5zLVvOxodk1iuSudpDeb32g-063ok8RWQx6Gno8UeTQ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 8 Dec 2023 09:53:11 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 7f64b4ff (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 8 Dec 2023 14:51:41 +0000 (UTC)
Date: Fri, 8 Dec 2023 15:53:10 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Han-Wen Nienhuys <hanwenn@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH v2 04/11] reftable/stack: verify that `reftable_stack_add()`
 uses auto-compaction
Message-ID: <8061b9d2fcb3e8c3d1fd641e705b9a8879e452f4.1702047081.git.ps@pks.im>
References: <cover.1700549493.git.ps@pks.im>
 <cover.1702047081.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="aC9fZnrGco+DiIaR"
Content-Disposition: inline
In-Reply-To: <cover.1702047081.git.ps@pks.im>


--aC9fZnrGco+DiIaR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

While we have several tests that check whether we correctly perform
auto-compaction when manually calling `reftable_stack_auto_compact()`,
we don't have any tests that verify whether `reftable_stack_add()` does
call it automatically. Add one.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 reftable/stack_test.c | 47 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 47 insertions(+)

diff --git a/reftable/stack_test.c b/reftable/stack_test.c
index 0644c8ad2e..c979d177c2 100644
--- a/reftable/stack_test.c
+++ b/reftable/stack_test.c
@@ -850,6 +850,52 @@ static void test_reftable_stack_auto_compaction(void)
 	clear_dir(dir);
 }
=20
+static void test_reftable_stack_add_performs_auto_compaction(void)
+{
+	struct reftable_write_options cfg =3D { 0 };
+	struct reftable_stack *st =3D NULL;
+	char *dir =3D get_tmp_dir(__LINE__);
+	int err, i, n =3D 20;
+
+	err =3D reftable_new_stack(&st, dir, cfg);
+	EXPECT_ERR(err);
+
+	for (i =3D 0; i <=3D n; i++) {
+		struct reftable_ref_record ref =3D {
+			.update_index =3D reftable_stack_next_update_index(st),
+			.value_type =3D REFTABLE_REF_SYMREF,
+			.value.symref =3D "master",
+		};
+		char name[100];
+
+		/*
+		 * Disable auto-compaction for all but the last runs. Like this
+		 * we can ensure that we indeed honor this setting and have
+		 * better control over when exactly auto compaction runs.
+		 */
+		st->disable_auto_compact =3D i !=3D n;
+
+		snprintf(name, sizeof(name), "branch%04d", i);
+		ref.refname =3D name;
+
+		err =3D reftable_stack_add(st, &write_test_ref, &ref);
+		EXPECT_ERR(err);
+
+		/*
+		 * The stack length should grow continuously for all runs where
+		 * auto compaction is disabled. When enabled, we should merge
+		 * all tables in the stack.
+		 */
+		if (i !=3D n)
+			EXPECT(st->merged->stack_len =3D=3D i + 1);
+		else
+			EXPECT(st->merged->stack_len =3D=3D 1);
+	}
+
+	reftable_stack_destroy(st);
+	clear_dir(dir);
+}
+
 static void test_reftable_stack_compaction_concurrent(void)
 {
 	struct reftable_write_options cfg =3D { 0 };
@@ -960,6 +1006,7 @@ int stack_test_main(int argc, const char *argv[])
 	RUN_TEST(test_reftable_stack_add);
 	RUN_TEST(test_reftable_stack_add_one);
 	RUN_TEST(test_reftable_stack_auto_compaction);
+	RUN_TEST(test_reftable_stack_add_performs_auto_compaction);
 	RUN_TEST(test_reftable_stack_compaction_concurrent);
 	RUN_TEST(test_reftable_stack_compaction_concurrent_clean);
 	RUN_TEST(test_reftable_stack_hash_id);
--=20
2.43.0


--aC9fZnrGco+DiIaR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmVzLdUACgkQVbJhu7ck
PpRYixAAoZIHqyzksvmG5r/wV8U9vETIPAA4S2ooQqHDpWKzkjXVR4eKu7OS9vSM
rHea8YaqUXAlL4u7qFv6T6TmPfuBeDfNbpiSSRVj33mTv66RzSXToUWpA7BzGEMj
2T6PpLQNRYrnDAUVVRwBYcYWUrBsAklmpUKL2X3ApkNrmh8B0qpG9EjfONmulRhv
jkOfu5kYD6AswAXjolk4KSqVQYSTNj3x1NHipotle3QORfA5Xd5TuPXoYYqgyqFJ
V69WDbnt7nstK89FG9kXJS+JzMxdM14XaqaGFE0z1/a88zvPQsKrDBKM3ZhFpW7r
1susWszKouE1SpAbGbcgn7GMWEX5qHUbHMGNLrd9wdSGYH+LfTYGkgrI5OjKy8MD
6Y+9byN2HyCZvo8wnE8oQuDR1X8nLu6igj/jd5bvBGlq400zRyB1AjhJJgDY23vU
aineAz4QueLP5k4GGztegVm/abIg0mdaB4F+teCr4Hfbooa3W+Z0/tDeZhqo5hMT
FnHuH+SnQFBJ5/JE6Drei8+oyTuC4G5Ca6+QoyrVh9dZq3cSWWNa3EZotBkHyKUY
n16dEFK0V1LyPEOXJv3I+e6b29RTtpzKa3sOBmEj83Y0mkq0w7SsZNiHN8L+F5Ob
GrYrS/XDjp/+l3OpMuwLZ0D6AQKwPr5RZ8iLCoHH/yRkXIGt2/M=
=5bJg
-----END PGP SIGNATURE-----

--aC9fZnrGco+DiIaR--
