Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="TgubDAcw";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="aYDw7/5c"
Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com [64.147.123.25])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BF66D9
	for <git@vger.kernel.org>; Mon, 11 Dec 2023 01:07:51 -0800 (PST)
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
	by mailout.west.internal (Postfix) with ESMTP id 66022320268D;
	Mon, 11 Dec 2023 04:07:50 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute7.internal (MEProxy); Mon, 11 Dec 2023 04:07:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:sender
	:subject:subject:to:to; s=fm1; t=1702285669; x=1702372069; bh=e8
	uVX+p/aIJqUt9uBvRrCYzrQgoLhUP0CGh3m2N1vDQ=; b=TgubDAcwRGKcvAXzOE
	/FbE7ppsShUi8prU0B4Ji6iBYnRwEHvna7t92Pk/bnYA1FggP0Ju9ZkQ26MR2h3M
	0tpDT+hhQX82JJNe6L2qha7fKv+GDERgDYUipAzVBapfVEO6kLUzNlqXktyzRpkK
	ELO09Dyt38eHuDbzp0+mTmE8MKhfc3Bp6zKA7W6kuyRnaUQzmpNiDNq7pjqyDU/K
	joZfpezRiQZxmiA55c9vaoPEIJx4/qieVhQFW9gYE0sLXywX+GeK11n9RUiBgdLz
	iluBWg3V87qYls9O2NEaeoDHqKRUvuaU5kP0WMm6buxEywN3SCBktOJVunv+ZdXS
	xBcw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:sender:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm1; t=1702285669; x=1702372069; bh=e8uVX+p/aIJqU
	t9uBvRrCYzrQgoLhUP0CGh3m2N1vDQ=; b=aYDw7/5c84889yEA7M+Eu+EY7nUZM
	jFRlqaEJ8Z6l3D5px4RlUIBmm6Y71UFeKvA/0khKlOeManUdrp4+Xee9Y9TzBAlL
	mRC0hBbXK7GadiqAV99CCm3uc635XglZELqH5pF2MDnPQnTnFQiqHbfMidTFLLql
	SIyEg5xnfBa7XiVp4mC09hojMjlcrHoTfkuL2G49wRnebB71xT963QtFzNHCyD2H
	VaIr1f+bR3xPr9NF0yZ9YlR89At71/oJ58R2N5t49NbQyr0hVdW41b1JgaovAeS9
	MS5z9SVK+kLw4zIKMNj8Zo0UpekQiwyMsTV6/8l9TRsZAx8OIImhTDiuA==
X-ME-Sender: <xms:ZdF2ZSn4oYdi6oWNNNGCjIdcc7YpV_Vz3zSZZK6iT9hhQDFIp7rq8A>
    <xme:ZdF2ZZ2breCiA5Dj8SrgT5VOpXBCPbfozVUbpy_qwEkE3VQrp4ks5ssfRsTmztEIj
    NtVCoV-Mqndy485lw>
X-ME-Received: <xmr:ZdF2ZQqo1jUu_juTDtYtCBnNUHgbtj_0oUHl2wP-YmM8sZs8yv4MvSau9MAu73zbBSxbY-7A44ntMHZVn2Zn4mmUBKVXXx-sBRQgm0Dl-5ShHQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrudeluddguddvlecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrght
    rhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtth
    gvrhhnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeehgfeltddtheejleff
    teenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpsh
    esphhkshdrihhm
X-ME-Proxy: <xmx:ZdF2ZWn0eaGUkGljNcyOL9PTS2P4jolOg5U-gdfy7tk__Q7lxv9P0Q>
    <xmx:ZdF2ZQ0rk-0PQVq-z-spDekR7pasp8Wovx1qIB9qvsI5f8rIMagJLg>
    <xmx:ZdF2ZdueOdcngnrqJ4h6bOlGls0y2U3cUfxHMX7AdeB1Qnfi5aq_iQ>
    <xmx:ZdF2ZdzkZmiJbVvoJHQaG3e7Cg0Ab_EdVH3Ifmt1DKW39WI-wIfDGQ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 11 Dec 2023 04:07:48 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 1d1e06ba (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 11 Dec 2023 09:06:12 +0000 (UTC)
Date: Mon, 11 Dec 2023 10:07:46 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Han-Wen Nienhuys <hanwenn@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>, Taylor Blau <me@ttaylorr.com>,
	Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v3 05/11] reftable/stack: perform auto-compaction with
 transactional interface
Message-ID: <dd180eba40d41e8b0ddf8b9422720c0883cc04b8.1702285387.git.ps@pks.im>
References: <cover.1700549493.git.ps@pks.im>
 <cover.1702285387.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="5in2knYdqNjKANlJ"
Content-Disposition: inline
In-Reply-To: <cover.1702285387.git.ps@pks.im>


--5in2knYdqNjKANlJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Whenever updating references or reflog entries in the reftable stack, we
need to add a new table to the stack, thus growing the stack's length by
one. The stack can grow to become quite long rather quickly, leading to
performance issues when trying to read records. But besides performance
issues, this can also lead to exhaustion of file descriptors very
rapidly as every single table requires a separate descriptor when
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
index 52b4dc3b14..14a3fc11ee 100644
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
@@ -1016,6 +1071,7 @@ int stack_test_main(int argc, const char *argv[])
 	RUN_TEST(test_reftable_stack_log_normalize);
 	RUN_TEST(test_reftable_stack_tombstone);
 	RUN_TEST(test_reftable_stack_transaction_api);
+	RUN_TEST(test_reftable_stack_transaction_api_performs_auto_compaction);
 	RUN_TEST(test_reftable_stack_update_index_check);
 	RUN_TEST(test_reftable_stack_uptodate);
 	RUN_TEST(test_reftable_stack_validate_refname);
--=20
2.43.0


--5in2knYdqNjKANlJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmV20WEACgkQVbJhu7ck
PpQGKRAAq0GRwBY5lpu6lQYS7jY5QhlMoF0K5iuoj5im4BQji4yDv1n4n+fDHVep
UKO8aYVlxWOGbvcn49/R2N+HHYIU4XpxVqr/lUtLDstoErIdKMSwIlFSaGYnNJBA
7PIAWq5G/iPAXhlse9jxAd/3p6RbwGl8yY30mXd7uwe/0gokGG5DxCSFWwSgR6kU
w+IljnYDUzk6BQFgWDRirFFS3jz82eGzREINb6kP/m8PhTKCvDws0buJyNdEDr4g
mA/Ns5snLHaESQdeuBT7Bb5DLLy6i17LSqKLoNV2q1Zw4Hx2BalyORI7be51EkiW
/xl3gGlPFuLS7cLwx0hlhW0uRwGmxh8dM65yPztz0JcwCVju9XCq9FR7JGORcyBQ
iAV3ETFiAnlht01YvIK/az03mMZDQw+rBYteaeDIvEFdIGMSMWeU7atgwoz+uaaa
WV1UGqMSIh6hJvd4w2TvoGFoUxJcTB2Q7rFLEjd2gQ9rEsYvSQMyLQQDDwDOr15C
1W25qRnBF/XjBpVuX5RwGhCJZ6SwZXr0V/MA0PN9CP51MvewkTcLcahZjW+oNaL1
jiuiieawHrYDhv1aRnzAJFpMNxDewNdtqUAd8rSXdpRFD5DIRFG11DTilFHh0g0L
fY7c2QuUqLPDIx0b37P83ovNn6bflT+v1vlAGGks7CjQpddqywc=
=H93t
-----END PGP SIGNATURE-----

--5in2knYdqNjKANlJ--
