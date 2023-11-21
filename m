Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="ozDE+463";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="FrnIQt3o"
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D014610C
	for <git@vger.kernel.org>; Mon, 20 Nov 2023 23:04:25 -0800 (PST)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailout.nyi.internal (Postfix) with ESMTP id 4B34F5C1597;
	Tue, 21 Nov 2023 02:04:25 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Tue, 21 Nov 2023 02:04:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:sender
	:subject:subject:to:to; s=fm1; t=1700550265; x=1700636665; bh=1Y
	6wB9dBN5gumrqePPI6bOSR9DQiT3zAXzCTHMYcbpg=; b=ozDE+4633WuGAou1G7
	RTSr94FEhlakqjZPzCK5xJS+yPS9/dgXSvkybZOaB3hjeHFbQGKK8mtNFytkTaYT
	MBIByuJWl1WUguA0e5pKEP8tE5XyutjZ5GoeIpfrk+1QnjsvO394ZzDDB3T/xq0R
	Zr9tXmLj3xHDF/wIQo88wMpYp+giKR7+MwGxKl9MpjoYW7N4y6u/owSB8xt1Tbl9
	7l/g5+8EH/68G9/BsVkScv0KMkRYwfbUUZoTKq9ek2VvJU0V/Lcu0Rni/xzQ/IOw
	+QmHmaPMra3T49oYpjyhB9NasFI/Bfo9T61HghmaRNT3yNixlbPg6ij9F2GGkKmO
	AjEQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:sender:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm1; t=1700550265; x=1700636665; bh=1Y6wB9dBN5gum
	rqePPI6bOSR9DQiT3zAXzCTHMYcbpg=; b=FrnIQt3oKFIHmiuWsfmmV9mTonIr6
	vyLqMVzvklm5yXBfg+8LBNW9/sonTbmqRuWNJ7EUF9VH0MJUppjqhE/+YQCXMmwD
	zwpk4FW9lTYF7ANkcR5oQTyYjL58oM3zHy7yvD71NrvS1fVDgAkYQpbf4/8h7qLK
	LIP/LnUAwIQMNIfWzOij1Q/pr/zWVxNAZrrxk2QYB7PXgZIo7tfqnEGm8FD8HbH4
	TBfZ3Tb9yGvzyAavQ/1PWt6IPYqrah2IRpmFopqtX54dEu7ENug5Et3Wsfe2Olq/
	BdVY877rXcRH+gadH4HseQZOTMMtuASzre2hO/auRbkjN9gwnuKLX8+bQ==
X-ME-Sender: <xms:eVZcZUbkcyLwUOR-8s0i6jL38NqGTQevjtCUNDxO2kR2iWw32Ltu2A>
    <xme:eVZcZfYx7TYEYLCL8-Bw4McF4jR_uNlDzHf4gsrOTE3faFeMbueKgCcpOE7_RRFas
    KJ54LzPS5KwvWcssA>
X-ME-Received: <xmr:eVZcZe-hCdiZUrYwPd0nouJKNx97LLdujdSRbycsnJI5cKfpLE9Kak8bcq3wIkADGjOrpl6cxqi3KCOpeDLatSiSP8-vkwWnfZVAQLEDkj-t>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrudegkedguddtfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrght
    rhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtth
    gvrhhnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeehgfeltddtheejleff
    teenucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhepmhgrihhlfhhrohhmpehpsh
    esphhkshdrihhm
X-ME-Proxy: <xmx:eVZcZeoYznLBjT3SySjVzcEEuvhrgdmGNi7MW777D5FedGke9Sg_rQ>
    <xmx:eVZcZfqbHixOnNPoRdaAGMLKKq5grjO0v4mD3lqcxP3IHKzXrki80Q>
    <xmx:eVZcZcShiWAh-zEwl-5Tm1JatX34kqTi0BpuWdS1Q8hcqWTbXc5K6w>
    <xmx:eVZcZYCXM9lPzSvAmzcebmzVWlDhqStYgTnh3-SDsqXrSs7_QYRlag>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 21 Nov 2023 02:04:24 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id fa1e6ac6 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 21 Nov 2023 07:03:32 +0000 (UTC)
Date: Tue, 21 Nov 2023 08:04:22 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Han-Wen Nienhuys <hanwenn@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 4/8] reftable/stack: verify that `reftable_stack_add()` uses
 auto-compaction
Message-ID: <c9b4ac7916d1ee2474ad37eaa21073adcd54fc5d.1700549493.git.ps@pks.im>
References: <cover.1700549493.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="i4Y0m4xXi0ovtP2W"
Content-Disposition: inline
In-Reply-To: <cover.1700549493.git.ps@pks.im>


--i4Y0m4xXi0ovtP2W
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
2.42.0


--i4Y0m4xXi0ovtP2W
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmVcVnUACgkQVbJhu7ck
PpTHnw//X6jt9A6eaWWJ6zPlhRCZJ9NrbIdTBRYzmEeCTcr+2EV9/sOTmh84lT3O
wXX0yRqI2pnfFc3rCOXzjPes54/HSkrxqe+MIxphX7KXdpE4DYJ7rqilKcboynoO
FbYB3tHeMrhhANx+/cX4+gRybTbGREO73fT+M98u1jA623S14yaXoQCM4Dc0hOaS
uxxQTQQACY34/Y9YVR2TKRr/FtPh5fCFSxbxqDTPazpehbUuEJHp8be7VFv4dhIT
+1mH013PXYB8ZaP6/XH8UEgZusGucBpNj1aE2yCOXtPVmzuMybAfN1WYxx+UN4C2
j7FYUYVOtXoh0EgQDLyZrt/qiVBJrJQHMApbzQ+JlqvINLb/hKUSZQsqpnepgVOW
sCpbdR2pQBrdIeBMu+IC6/JgnMEH61wl2tizIS6Iz/R/3mvzOeactNv6EDKvy44A
2d6M4vCvMvJfElba8FpdhKyf8+5rU1hMNJsI9nHmUgECQzBGs+2IRk8Zd5AYjvom
DC+br9E2Vsrggl2xRmTBF7+ev8EBU2FXID02eHcJHKYsedKrj1HdHbftSVj8LYQN
Ruug1iqdTRDe0MHUsjtCyOi8b4Nxc2JInuEOi1UUz4IRwCFiyaYHdDBb1L3arW5p
Txpf55lkKmD+VEAdZGag+RNsEs5VEMJJDfNrgdkAaBGrgGKghtM=
=E7Ca
-----END PGP SIGNATURE-----

--i4Y0m4xXi0ovtP2W--
