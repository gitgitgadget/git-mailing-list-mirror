Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="FaVdEUf6";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="E3mVsa9u"
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA50610C
	for <git@vger.kernel.org>; Mon, 20 Nov 2023 23:04:29 -0800 (PST)
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
	by mailout.nyi.internal (Postfix) with ESMTP id 5D9735C1621;
	Tue, 21 Nov 2023 02:04:29 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute7.internal (MEProxy); Tue, 21 Nov 2023 02:04:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:sender
	:subject:subject:to:to; s=fm1; t=1700550269; x=1700636669; bh=CI
	KlOe25goD/oDdsM72nIPnSTgtgH2O4/cTCljUer/8=; b=FaVdEUf60a7GbIZTw/
	5S9USRsnDyivo/TDImNLkmA2BAO0e07h62bhAnHCxXOXgDkh+5DbqK62ZumenFV7
	ApMmvs0P7OR9mCf8/RIilpmWzh65PJeAOcjwXtzfDM0dRDAHfjnoCs71RQco8JaM
	Uns/vBhtliBkCo/+X/Sgn5L/DXaGPT8Xtd7nu0opn6bbCsPmqCx2g4TGzQrvcJGy
	2Buw1iiEOEdLX+++/Z2iCIeezIOcd9nFXv3ccaASqCUc3clijPj9x70hppoM/JJV
	4trQto33BqW8Mnzh6ENFTM9rV4Qzx34iu/LxmgYGf79GrjIKsE8rXpwhm6lotWFB
	7xJg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:sender:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm1; t=1700550269; x=1700636669; bh=CIKlOe25goD/o
	DdsM72nIPnSTgtgH2O4/cTCljUer/8=; b=E3mVsa9ucduZv/r+ptEcF9z1vUUkp
	U8qan1LJLNVQ4WH47F/E96ksynfP12ESUHzuZR1TPEasNmRraLvZ3Mysi+C3H2xM
	+uuX2dEbzpdu6g4xIu6gVXd3YOxK5HjrUL8joiQRPQEppK5v8cO44K0IVBUZrrYz
	9eRR45bEFAf221Bo4tysT+fY0eDLdFV2qsZLnsbaj6iCauZ6TTS9859sLNkcRovC
	yPUgOPw66uw7c+PmSP7bO4MAMo3EOlmar8nsUJCgDnCmxllxnQl07iv3QhBCNnYJ
	VQS4NvpqOyU613eJC4Z0R1/hSJE4HdNAEiZzlyVQxv1VTlSQJLrkLbjwQ==
X-ME-Sender: <xms:fVZcZRANRnKzSEUT8rVZXAyEnd7KcDm8aHfWTKjjMe9uDVOhFwPwzw>
    <xme:fVZcZfgLRsoDJhIc51dhZETHH_54wo2ZjcPtpWvMqnHsqXbBO0LT_u4HaKGQR5UGT
    KfowSEVGijGhi_KOQ>
X-ME-Received: <xmr:fVZcZclAlB78_MCtU0FnafCmWey0kVlyFn6FC3jYkZC6Rm5xtrBYuy1H6Az-6L77oDS5m8qajwc2ILRBwuvXh91tZtINWjsq-rTGwVDKVXgU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrudegkedguddtfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrght
    rhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtth
    gvrhhnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeehgfeltddtheejleff
    teenucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhepmhgrihhlfhhrohhmpehpsh
    esphhkshdrihhm
X-ME-Proxy: <xmx:fVZcZbyXg4NnoqnkE_yKk1yup7JHXxjVyAoiGpTSxixEp70vCc0sNQ>
    <xmx:fVZcZWRH7l6l-08-DKv6LvzDIycV5aqN4er7zi6yC7ehLIN_rdN1Mg>
    <xmx:fVZcZebZrogi87-RJIjlW6njTglaiHnQ894skbC1S6Zdzt-lLWsG5Q>
    <xmx:fVZcZZJet3zKTcyE80nxrEbZG1gtbfcdVWBav1M_3edrfaEbRAUZ2g>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 21 Nov 2023 02:04:28 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 12929a02 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 21 Nov 2023 07:03:36 +0000 (UTC)
Date: Tue, 21 Nov 2023 08:04:26 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Han-Wen Nienhuys <hanwenn@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 5/8] reftable/stack: perform auto-compaction with
 transactional interface
Message-ID: <25522b042cdc5986972cc7b62e6b88be0569d3cb.1700549493.git.ps@pks.im>
References: <cover.1700549493.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="SYweXmh/jTPv89ln"
Content-Disposition: inline
In-Reply-To: <cover.1700549493.git.ps@pks.im>


--SYweXmh/jTPv89ln
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Whenever updating references or reflog entries in the reftable stack, we
need to add a new table to the stack, thus growing the stack's length by
one. It can thus happen quite fast that the stack grows very long, which
results in performance issues when trying to read records. But besides
performance issues, this can also lead to exhaustion of file descriptors
very rapidly as every single table requires a separate descriptor when
opening the stack.

While git-pack-refs(1) fixes this issue for us by merging the tables, it
runs too irregularly to keep the length of the stack within reasonable
limits. This is why the reftable stack has an auto-compaction mechanism:
`reftable_stack_add()` will call `reftable_stack_auto_compact()` after
its added the new table, which will auto-compact the stack as required.

But while this logic works alright for `reftable_stack_add()`, we do not
do the same in `reftable_addition_commit()`, which is the transactional
equivalent to the former function that allows us to write multiple
updates to the stack atomically. Consequentially, we will easily run
into file descriptor exhaustion in code paths that use many separate
transactions like e.g. non-atomic fetches.

Fix this issue by calling `reftable_stack_auto_compact()`.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 reftable/stack.c      |  6 +++++
 reftable/stack_test.c | 56 +++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 62 insertions(+)

diff --git a/reftable/stack.c b/reftable/stack.c
index f0cadad490..f5d18a842a 100644
--- a/reftable/stack.c
+++ b/reftable/stack.c
@@ -584,6 +584,12 @@ int reftable_addition_commit(struct reftable_addition =
*add)
 	add->new_tables_len =3D 0;
=20
 	err =3D reftable_stack_reload(add->stack);
+	if (err)
+		goto done;
+
+	if (!add->stack->disable_auto_compact)
+		err =3D reftable_stack_auto_compact(add->stack);
+
 done:
 	reftable_addition_close(add);
 	return err;
diff --git a/reftable/stack_test.c b/reftable/stack_test.c
index c979d177c2..4c2f794c49 100644
--- a/reftable/stack_test.c
+++ b/reftable/stack_test.c
@@ -289,6 +289,61 @@ static void test_reftable_stack_transaction_api(void)
 	clear_dir(dir);
 }
=20
+static void test_reftable_stack_transaction_api_performs_auto_compaction(v=
oid)
+{
+	char *dir =3D get_tmp_dir(__LINE__);
+	struct reftable_write_options cfg =3D {0};
+	struct reftable_addition *add =3D NULL;
+	struct reftable_stack *st =3D NULL;
+	int i, n =3D 20, err;
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
+		snprintf(name, sizeof(name), "branch%04d", i);
+		ref.refname =3D name;
+
+		/*
+		 * Disable auto-compaction for all but the last runs. Like this
+		 * we can ensure that we indeed honor this setting and have
+		 * better control over when exactly auto compaction runs.
+		 */
+		st->disable_auto_compact =3D i !=3D n;
+
+		err =3D reftable_stack_new_addition(&add, st);
+		EXPECT_ERR(err);
+
+		err =3D reftable_addition_add(add, &write_test_ref, &ref);
+		EXPECT_ERR(err);
+
+		err =3D reftable_addition_commit(add);
+		EXPECT_ERR(err);
+
+		reftable_addition_destroy(add);
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
 static void test_reftable_stack_validate_refname(void)
 {
 	struct reftable_write_options cfg =3D { 0 };
@@ -1014,6 +1069,7 @@ int stack_test_main(int argc, const char *argv[])
 	RUN_TEST(test_reftable_stack_log_normalize);
 	RUN_TEST(test_reftable_stack_tombstone);
 	RUN_TEST(test_reftable_stack_transaction_api);
+	RUN_TEST(test_reftable_stack_transaction_api_performs_auto_compaction);
 	RUN_TEST(test_reftable_stack_update_index_check);
 	RUN_TEST(test_reftable_stack_uptodate);
 	RUN_TEST(test_reftable_stack_validate_refname);
--=20
2.42.0


--SYweXmh/jTPv89ln
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmVcVnkACgkQVbJhu7ck
PpQC0w//YQblT7Eux88snWVSsFIU/BjL8K1e+rhq+zPFfjY3fdqP1Edx8vl3o3LQ
Q7Mwhfmp9IQ7183WV4IBPx+uD051hNmekgpkh9X8iF8AVSfAlmhljT+F08d5mxyy
UNJNp0A+/GotsD9Hpp974JPAS0OSvFzAVK+AGiya2k5RZeGTm4qFQd3t0SY32x7F
brhlAHDkLB5VkklQBqgSsQDlEF7mKgw6DPM1Y99aFMA+z4y2a7593eUWya1mxY/7
ILd+ymW5duxhv/wBx1s6WdfSf2vSIysqfo2P0f194zIXHV104fn0+qPgmBFLOHpc
1KWRgBDglj1xmasggeRVHay8BZ9j04AoZ7Govv1+UYAFrNWDYgTTIdk1UOrGRtDp
fCtN84wNi4WBYdE1xucR/Dx/oLQeleznbbBX51gtuCPKsrr7QRX66D5FgGzdBvAO
lPuE3TbFxJv6cFhfUqCdNvhYgZU1pStEFKYPPtrOdTtHT+rc9kCkN8317aIctCVe
BDTPy1Ft+W2wU+v8FmJ3a+EpwN22qzb/WFKyOJRKz15Y5XdnURIfqsVkSt/gTYIF
jRr8pVWlTjhE2VNUQMGeQgy4YV6y6vfzUIaK8nb4q9oUcSGWXs0e/FKg/9V7lmNQ
C/VJ0KDqcgfvtE2z6CZMi1jZDlJlnYEaaIhXaKMxuhNOIe5bkKc=
=mN1i
-----END PGP SIGNATURE-----

--SYweXmh/jTPv89ln--
