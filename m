Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="oEf3zfjk";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="qhZNrB92"
Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com [64.147.123.25])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1DA7D9
	for <git@vger.kernel.org>; Mon, 11 Dec 2023 01:07:46 -0800 (PST)
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
	by mailout.west.internal (Postfix) with ESMTP id E92BE3202677;
	Mon, 11 Dec 2023 04:07:45 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute7.internal (MEProxy); Mon, 11 Dec 2023 04:07:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:sender
	:subject:subject:to:to; s=fm1; t=1702285665; x=1702372065; bh=8g
	bLZFvksjaSZCwzhiJWV1hMVJc7TCifkkebfE7qm+w=; b=oEf3zfjk0wMuSDDM2l
	D/J4Hzd3E9Y1J7kUT4+6YbJIXvNRZ68Kh5eZtPR/AkMzGjz5zkn/jsmyTIoC0wNZ
	sP2bWhCcv17wlKCEGXPcuYZ1jYbLQnlYOSDuYyrQQ6v5SdK/0ZohR+2gZGsTKRdu
	70SdL+JaLJYR+0/2aKXEjhbn/eso7geJ2Cnt2vLp3D/XndLsr8QJUTRFC7ko/GIf
	bZwwqgbfQz96LZmDfq6ebRj7eUR6ONFNH0yXqePp1oKJ8oHEZh0pzRRZVxH1CtmV
	vZdYpoxNnjUNI2kTUwTC9prAqD9UDfpuixkOjdZY70msh0I1pD5fXh1soTfuVYMg
	jEiA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:sender:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm1; t=1702285665; x=1702372065; bh=8gbLZFvksjaSZ
	CwzhiJWV1hMVJc7TCifkkebfE7qm+w=; b=qhZNrB92NMvJQawF2mb63GxYpjT9M
	/E3ifIbJik3MFSx+rKR8nz2LN/FWdc0TZtXe4bVpyukBtuZsTUC4YEoaVMocGcW+
	dTEEOMUjoC42WQvvVohCQ85F0dG8S91sooEuhI91tEM2vBSoPV4q3yb3iUE12CLS
	jDM2o7JZJvPUgvMt1n61JWpT7FZDOx3k32QmD9SmjOe5IOS9GxvD39rnEZyt6C1H
	vMQntFpSPociOorayC8FjUyBO4nfYFtUgvmfxqKmjvlG9xkydUmbNyWqNfzSk57+
	Kr59cQbbQBv73aKbtIgqtviq5aaqmzhSn8gsWZbduisByUzwgkRSqAG/w==
X-ME-Sender: <xms:YdF2ZcZ_c6qjfcVZqtZK2Pe8QXUCRKBEp1MaPXmskT-Kbm1n9sG20g>
    <xme:YdF2ZXZndx7JmO1LpBew5_KCz30uQK6CwtZCnLdrdedwyn1oabHKuG5iFDOwS73c8
    lFyIWyiYuyktUZOFQ>
X-ME-Received: <xmr:YdF2ZW9p8-ufpmMaA-Hf2u7dogoeiRR7I6-Pc_tTgvzEwcFHemD1ZSHJE83y786GHYPvtNG-GxnjXzfJ8-hCqXRDoYKsytSb_xtjDX_DxqDcHA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrudeluddguddvlecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrght
    rhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtth
    gvrhhnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeehgfeltddtheejleff
    teenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpsh
    esphhkshdrihhm
X-ME-Proxy: <xmx:YdF2ZWoKleCbx7n8sqC_-L6ec2Jz8fmin9zWW0apyRuvI2zP7j9o3w>
    <xmx:YdF2ZXpvzEgGzRmosUyt57ILda_ZvDIgCOOrr9ZwJe-ncIQuGzBT-Q>
    <xmx:YdF2ZUSvkbwhcML9Y_jGc9cEvDYRGclFml5QECitwn76K0DmgCvEqQ>
    <xmx:YdF2ZWU5H0HIf14OxrY1sfFhbFfxVJilVI_kpvL8lzo-WU5i92-ftA>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 11 Dec 2023 04:07:44 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 63b172e6 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 11 Dec 2023 09:06:07 +0000 (UTC)
Date: Mon, 11 Dec 2023 10:07:42 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Han-Wen Nienhuys <hanwenn@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>, Taylor Blau <me@ttaylorr.com>,
	Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v3 04/11] reftable/stack: verify that `reftable_stack_add()`
 uses auto-compaction
Message-ID: <5e27d0a5566d90969734e92984cfafe6048924f4.1702285387.git.ps@pks.im>
References: <cover.1700549493.git.ps@pks.im>
 <cover.1702285387.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="dtPs6pD4PmxySBvG"
Content-Disposition: inline
In-Reply-To: <cover.1702285387.git.ps@pks.im>


--dtPs6pD4PmxySBvG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

While we have several tests that check whether we correctly perform
auto-compaction when manually calling `reftable_stack_auto_compact()`,
we don't have any tests that verify whether `reftable_stack_add()` does
call it automatically. Add one.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 reftable/stack_test.c | 49 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 49 insertions(+)

diff --git a/reftable/stack_test.c b/reftable/stack_test.c
index 0644c8ad2e..52b4dc3b14 100644
--- a/reftable/stack_test.c
+++ b/reftable/stack_test.c
@@ -850,6 +850,54 @@ static void test_reftable_stack_auto_compaction(void)
 	clear_dir(dir);
 }
=20
+static void test_reftable_stack_add_performs_auto_compaction(void)
+{
+	struct reftable_write_options cfg =3D { 0 };
+	struct reftable_stack *st =3D NULL;
+	struct strbuf refname =3D STRBUF_INIT;
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
+
+		/*
+		 * Disable auto-compaction for all but the last runs. Like this
+		 * we can ensure that we indeed honor this setting and have
+		 * better control over when exactly auto compaction runs.
+		 */
+		st->disable_auto_compact =3D i !=3D n;
+
+		strbuf_reset(&refname);
+		strbuf_addf(&refname, "branch-%04d", i);
+		ref.refname =3D refname.buf;
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
+	strbuf_release(&refname);
+	clear_dir(dir);
+}
+
 static void test_reftable_stack_compaction_concurrent(void)
 {
 	struct reftable_write_options cfg =3D { 0 };
@@ -960,6 +1008,7 @@ int stack_test_main(int argc, const char *argv[])
 	RUN_TEST(test_reftable_stack_add);
 	RUN_TEST(test_reftable_stack_add_one);
 	RUN_TEST(test_reftable_stack_auto_compaction);
+	RUN_TEST(test_reftable_stack_add_performs_auto_compaction);
 	RUN_TEST(test_reftable_stack_compaction_concurrent);
 	RUN_TEST(test_reftable_stack_compaction_concurrent_clean);
 	RUN_TEST(test_reftable_stack_hash_id);
--=20
2.43.0


--dtPs6pD4PmxySBvG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmV20V0ACgkQVbJhu7ck
PpQkPQ//VfEzNL6VIA9RGYzv+Ej8I1y4dapSA6uxhnlC4m3PN7pCd9ndjgBPNx4V
OZuPSVkQVc7OSYxqE25wVXAxBkRWjuW7DMvVZPKWosfVkNUd8KshnDqbp+0FWXfc
+pTeWBLuGD6Jw61g6WqNemYuOslZrgDmVuj6JHaZRbinzW/pTYLUmYDDpAUibrdM
HCwTPE+OFvypgIJBYuNdIF58WYHj2ZaGEVwjbNXi77/jGQEYDf+o9a26tu36F+Hh
IHwtwpZPi7X9xsFE7S7F4Mkng60pYQM+7hGxfiBTSe71WzQh2tVPVYq9wVvbRYAj
EKtPFkrIXpOurlC+EYAJvZZvk5uLLUlFmgaaprRHQVzbsj+psmC468ke5s4FAd1N
XuloycTp7Y0PuI7Z1bi95T9OLeN+4vD7ACnn12xdJbZpgS2cLwZk/WDLQo0OcyeT
j7Fktg5EVVOTxLKZ9Qbp85bLsFuuZhB5iiVBg2PSVuTrZqp3e+YYSUkkLCb34GFg
Bip0mElSLzGL4DxkuGcKRGTXqCZHCjFMjF9F/m+NpYk+dnUPgoirhi0stuhuFw0R
QPy+Cx3toJGexUHjTILImlLMI0wXkv3Ccq34ifxxo/8/JlRMOiLHTOQ6sIFBMCYD
AMIWytamcA2CDZXge4TJjJ9/ePX0O2xTXBCPS3TXUruTkR3dU2U=
=EOyv
-----END PGP SIGNATURE-----

--dtPs6pD4PmxySBvG--
