Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="ib6OYtQa";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="mZX1L/Na"
Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBB96524F
	for <git@vger.kernel.org>; Fri,  8 Dec 2023 06:53:26 -0800 (PST)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailout.west.internal (Postfix) with ESMTP id A183E3200A26;
	Fri,  8 Dec 2023 09:53:17 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Fri, 08 Dec 2023 09:53:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:sender
	:subject:subject:to:to; s=fm1; t=1702047197; x=1702133597; bh=Sq
	A5850dZkMlElWI0onK5+fB8eDH3K5LlGb6P48nI0E=; b=ib6OYtQaPGqR2c3LCa
	8BKF6Wne48NGDdQdhFQjoLBAFBBiIvJ4zKp9CDnH9ILzxJD4Cl55ty8Pscn6v6vr
	mT2l9Wh0Cg6tqOwFSU4/zaI+fVsf6RCL6bsk70q1+bKaDmxiKp0HRSBcHye61k0m
	KIoZmXARbCZI8gJYDOzm3mbrUbfoVmsLMOBI2dXRdL7HARdjVFc85hjfikXySocR
	p3rAVhodXoL2KyQHeeSz9Ag1cQo3BlXpQy9tC5i43ZmK9SK5AZd98IZDgWE7tNeZ
	AgpN0ZgekqsxveYCGVtBEMH+UJe3MoObPI/3kNxCPj9B50hDAR1cUaYUvnrnjXpv
	dfvA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:sender:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm1; t=1702047197; x=1702133597; bh=SqA5850dZkMlE
	lWI0onK5+fB8eDH3K5LlGb6P48nI0E=; b=mZX1L/NaYOwgU/b7GOaQRzw+Ds/M7
	u9u6A0uMKxemnQM1f4rOaW1df/4L4SZeaJw1b4QvfYpvopUJWjFWAvVbgMtdnJ9d
	OjL/s+L+1IrJz6SF4zDZjv4I4OuQKkCcd2fYIIyRgDQkdwF5olYg1oKqZ8H7cV7+
	9KpRFK7Hohai2NlVv1WjT5qZPeg0pnOwvMzPIo69Dr3FqqnATUoZS0sc49Pb0emH
	CEfY2niBS2ktW4TCO/xupqbIGzbimiZJkDoGe32dDdiDu1mScQxMlGcDc5JsOsZy
	rZdpM89N48D3zIroto16WRLbDcKSpJDqxa73m4/xrJwFoRCqT83MWiGQA==
X-ME-Sender: <xms:3C1zZbzQVTCa-MfuofJ5Ev9xr6c5mnbGUChQMSfTnbpxgqgDEa9krg>
    <xme:3C1zZTTkWGvFJypd2Sg1AeW-TSfQMpTk0ixSfnE-m2DL1beiv_yZcWNEBbl3uXaZj
    o7bbMhpNmuZ7Zo4KQ>
X-ME-Received: <xmr:3C1zZVU6MAGUw13HT2pR4qoCvgcR6K29iomSSPgoEs6n0v4IiJIu_MzHfkepXX9tai-upw6IfASMnZDRH2WdheDHUAE-txjX6J3bqDwO-5d1E_s>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrudekiedgjeduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgepvdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:3S1zZVigMJcg_wRM2MIiucHKUzDmPq-PfnzJWWeHNO8vCU4BmLb9wQ>
    <xmx:3S1zZdAZJ23mDOHqkJ5eXuUH7IynMH7QtkMpY-TmeT4PiMfo2F5q9A>
    <xmx:3S1zZeJ5fUfqbZ_6jAVJ_8xGm5xdh6RtelEjHD7AidkZhxCJ7Ln43Q>
    <xmx:3S1zZa5e6qB0j__cLxaIDFhcq5udW2LQ6Oo3yO1MdnDDykBYXYA0Bw>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 8 Dec 2023 09:53:16 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 82264f47 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 8 Dec 2023 14:51:46 +0000 (UTC)
Date: Fri, 8 Dec 2023 15:53:14 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Han-Wen Nienhuys <hanwenn@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH v2 05/11] reftable/stack: perform auto-compaction with
 transactional interface
Message-ID: <77b9ae8aa675dd96dd10f4a5369f1f994fa59939.1702047081.git.ps@pks.im>
References: <cover.1700549493.git.ps@pks.im>
 <cover.1702047081.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="7bh7UMaugUfgLV3k"
Content-Disposition: inline
In-Reply-To: <cover.1702047081.git.ps@pks.im>


--7bh7UMaugUfgLV3k
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
2.43.0


--7bh7UMaugUfgLV3k
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmVzLdkACgkQVbJhu7ck
PpQGEw//RqPIX9ZPNPsS1V21aBILjsiXPPqYHDOlytqocERG0GacHZi+G7Zpp+zj
nKmEZk4Brr3UgFG1AkwN/whjT3tzN7rxPjJHblyGI+8pjxyJ3ccxV3fClGi1r8yy
ldsJvcBw4u9+fVdjmj9gy+eQEMFoAPko43GP6AKPufwrCkKMgUL/ZJ9U/H8NZ/ow
osVQWWxmE6WfMI4jVrt1GhCv+/J3T9AckEB1WsSg2aTkwAJNDBJhEn63S2501djJ
1GDrQcg7DA9HVPXQ+nH9fKCJmMuRaPxbu5TPivbkIggAM4OxgF64Ni4tB0Ur7oma
Sgwr2c0eejCrMRqKerITyW2LuiUUQOJDpAxBhhZNZns4JRpVuYtmEYdkpn6fMFQ4
SGO4643C/AWEB2eg6ABe4N672rkYsgHe4rKPbdYyfPxam4m2wrry+1D5jIHgo9SQ
H5O+DzY1A3Liht/qQ4szSlCOc0YusbM1ICZvwS696lo76sby7sflY7wgcQD4bDUs
Xv3o/mrpqIW1bn/6DS6wF2CHlmqXxZKuM+jX5kQhuLzIRMZ45GG8vfNq//fQP77H
VDNOlYMSbCZLPgshbLdv8TjG5PgQuXEK/ZLiJ4TdZgWSkHGx7XozhM/bqC4NL0Gv
V533/BtFMYao6B/CXABVk+n5XDwLhQq7Ap8jcKqeUBKv9IvyUsg=
=O6j+
-----END PGP SIGNATURE-----

--7bh7UMaugUfgLV3k--
