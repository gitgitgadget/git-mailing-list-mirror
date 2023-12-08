Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="SckDeTvG";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="1mP+V/22"
Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4ED621FF6
	for <git@vger.kernel.org>; Fri,  8 Dec 2023 06:53:31 -0800 (PST)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailout.west.internal (Postfix) with ESMTP id E600B3200A02;
	Fri,  8 Dec 2023 09:53:25 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Fri, 08 Dec 2023 09:53:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:sender
	:subject:subject:to:to; s=fm1; t=1702047205; x=1702133605; bh=2o
	QjgDlEqnI3GqOz/Huo1YNbwyRyQBA3lZvTIdOsB/E=; b=SckDeTvG4zes/JdfSY
	FcyMpoV8RtZlmMmdYnlvXeqvgyeLmswN1goBEwCX+QzEZt+j9aeFbjog4MA7jKif
	ECXdt1OyIIdDnKB9OSy0duGybxweHEW3EIsapX4KZ3dRbWya/wAPnuzoImwYFTaV
	XvJyHa8npaUaaRe1hsdNu1FjIe4xksNgVWyZtk/sSHr3S8+H/BVYOCWTr4yWgoAh
	g3F5uqXPmwgnRitq4HPvCSk3XphtYumHnpws1bQJEarCmLrTlzSpbGyFKN2q0bUl
	ZC5GAfLZjkFck0rgaRGmuoJnNaiDXQhch8sEGoMD9Fv9FGHu6R7mfFup73LfGKz/
	V8VA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:sender:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm1; t=1702047205; x=1702133605; bh=2oQjgDlEqnI3G
	qOz/Huo1YNbwyRyQBA3lZvTIdOsB/E=; b=1mP+V/22V9I4QvJyQshPSxAWodwBi
	QdoHODykpV3k96G0yDwOy/5pBchKjG+/cDsa3z7DZQ96WRmqpHcNPkkp+0Sb/PE6
	EesObAYZ/M1qNrLDTDG9rVnk/5LMJiaXgypqPVblkil613lGqO6+R8W/xnR+6zEv
	uszOPh8Q7CYGTiV2TXy42eyQsN37uQIyA3FHMJSTus1qhTMsxwzN8dSn6giBYhQn
	EI+OkkSmMTVRhllAiQEPD2OqsTuX/S9Lh+6lqa2Saev7RP8WBE/bO5IlqTEv2h0N
	ai3+yRTFL6/b95Baog2m1ZEcwkkjTvKiP0TFO14mTGzGVyG73JAMtLzuA==
X-ME-Sender: <xms:5S1zZfcpfIsGHnFGbts7LMoFFAlqNL9r3w8c8X6ZNiZ3KmJFSZ5lew>
    <xme:5S1zZVPkOxuukqAM2LkCmJG3MQez8mJCIeuBM2frLrFM4Q_ReObm2urIFLmKJ6jth
    6H5r3hDwidpHXkOzA>
X-ME-Received: <xmr:5S1zZYghh9X6eTe7LLj_1Gb4H3Tqmv76816aoHC6IWf4AWFxqvauRQzJwuF__maZ2-hQBTeFtiH2_-CuWFTvhM84E29wTxtljCDXhiZkrTksXR4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrudekiedgjeduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:5S1zZQ_j7HA6SrujBOxCVifT_Z6UGMYNOzRnxnvRvUqCR9ZSPmfh0g>
    <xmx:5S1zZbvr83j40AAidsQ87JppXSJseZPmhHI01WX7UY9Zy5u83-vtXA>
    <xmx:5S1zZfH876CRLBLb6IZhqDCF3UBDQT8H92T2vFSX2b_L-F8XaCFOzw>
    <xmx:5S1zZUWhEe0QQpHbsVn_xjcJF_UkMMey5vmUXJIAndo7lsEtwHDPVw>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 8 Dec 2023 09:53:24 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 07a6a2da (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 8 Dec 2023 14:51:54 +0000 (UTC)
Date: Fri, 8 Dec 2023 15:53:23 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Han-Wen Nienhuys <hanwenn@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH v2 07/11] reftable/stack: fix stale lock when dying
Message-ID: <e82a68aecd0a1179df3a59755864c71995e979d3.1702047081.git.ps@pks.im>
References: <cover.1700549493.git.ps@pks.im>
 <cover.1702047081.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="wsJCdLgwdnXY42FR"
Content-Disposition: inline
In-Reply-To: <cover.1702047081.git.ps@pks.im>


--wsJCdLgwdnXY42FR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

When starting a transaction via `reftable_stack_init_addition()`, we
create a lockfile for the reftable stack itself which we'll write the
new list of tables to. But if we terminate abnormally e.g. via a call to
`die()`, then we do not remove the lockfile. Subsequent executions of
Git which try to modify references will thus fail with an out-of-date
error.

Fix this bug by registering the lock as a `struct tempfile`, which
ensures automatic cleanup for us.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 reftable/stack.c | 47 +++++++++++++++--------------------------------
 1 file changed, 15 insertions(+), 32 deletions(-)

diff --git a/reftable/stack.c b/reftable/stack.c
index 2dd2373360..2f1494aef2 100644
--- a/reftable/stack.c
+++ b/reftable/stack.c
@@ -17,6 +17,8 @@ license that can be found in the LICENSE file or at
 #include "reftable-merged.h"
 #include "writer.h"
=20
+#include "tempfile.h"
+
 static int stack_try_add(struct reftable_stack *st,
 			 int (*write_table)(struct reftable_writer *wr,
 					    void *arg),
@@ -440,8 +442,7 @@ static void format_name(struct strbuf *dest, uint64_t m=
in, uint64_t max)
 }
=20
 struct reftable_addition {
-	int lock_file_fd;
-	struct strbuf lock_file_name;
+	struct tempfile *lock_file;
 	struct reftable_stack *stack;
=20
 	char **new_tables;
@@ -449,24 +450,19 @@ struct reftable_addition {
 	uint64_t next_update_index;
 };
=20
-#define REFTABLE_ADDITION_INIT                \
-	{                                     \
-		.lock_file_name =3D STRBUF_INIT \
-	}
+#define REFTABLE_ADDITION_INIT {0}
=20
 static int reftable_stack_init_addition(struct reftable_addition *add,
 					struct reftable_stack *st)
 {
+	struct strbuf lock_file_name =3D STRBUF_INIT;
 	int err =3D 0;
 	add->stack =3D st;
=20
-	strbuf_reset(&add->lock_file_name);
-	strbuf_addstr(&add->lock_file_name, st->list_file);
-	strbuf_addstr(&add->lock_file_name, ".lock");
+	strbuf_addf(&lock_file_name, "%s.lock", st->list_file);
=20
-	add->lock_file_fd =3D open(add->lock_file_name.buf,
-				 O_EXCL | O_CREAT | O_WRONLY, 0666);
-	if (add->lock_file_fd < 0) {
+	add->lock_file =3D create_tempfile(lock_file_name.buf);
+	if (!add->lock_file) {
 		if (errno =3D=3D EEXIST) {
 			err =3D REFTABLE_LOCK_ERROR;
 		} else {
@@ -475,7 +471,7 @@ static int reftable_stack_init_addition(struct reftable=
_addition *add,
 		goto done;
 	}
 	if (st->config.default_permissions) {
-		if (chmod(add->lock_file_name.buf, st->config.default_permissions) < 0) {
+		if (chmod(lock_file_name.buf, st->config.default_permissions) < 0) {
 			err =3D REFTABLE_IO_ERROR;
 			goto done;
 		}
@@ -495,6 +491,7 @@ static int reftable_stack_init_addition(struct reftable=
_addition *add,
 	if (err) {
 		reftable_addition_close(add);
 	}
+	strbuf_release(&lock_file_name);
 	return err;
 }
=20
@@ -512,15 +509,7 @@ static void reftable_addition_close(struct reftable_ad=
dition *add)
 	add->new_tables =3D NULL;
 	add->new_tables_len =3D 0;
=20
-	if (add->lock_file_fd > 0) {
-		close(add->lock_file_fd);
-		add->lock_file_fd =3D 0;
-	}
-	if (add->lock_file_name.len > 0) {
-		unlink(add->lock_file_name.buf);
-		strbuf_release(&add->lock_file_name);
-	}
-
+	delete_tempfile(&add->lock_file);
 	strbuf_release(&nm);
 }
=20
@@ -536,8 +525,10 @@ void reftable_addition_destroy(struct reftable_additio=
n *add)
 int reftable_addition_commit(struct reftable_addition *add)
 {
 	struct strbuf table_list =3D STRBUF_INIT;
+	int lock_file_fd =3D get_tempfile_fd(add->lock_file);
 	int i =3D 0;
 	int err =3D 0;
+
 	if (add->new_tables_len =3D=3D 0)
 		goto done;
=20
@@ -550,28 +541,20 @@ int reftable_addition_commit(struct reftable_addition=
 *add)
 		strbuf_addstr(&table_list, "\n");
 	}
=20
-	err =3D write_in_full(add->lock_file_fd, table_list.buf, table_list.len);
+	err =3D write_in_full(lock_file_fd, table_list.buf, table_list.len);
 	strbuf_release(&table_list);
 	if (err < 0) {
 		err =3D REFTABLE_IO_ERROR;
 		goto done;
 	}
=20
-	err =3D close(add->lock_file_fd);
-	add->lock_file_fd =3D 0;
-	if (err < 0) {
-		err =3D REFTABLE_IO_ERROR;
-		goto done;
-	}
-
-	err =3D rename(add->lock_file_name.buf, add->stack->list_file);
+	err =3D rename_tempfile(&add->lock_file, add->stack->list_file);
 	if (err < 0) {
 		err =3D REFTABLE_IO_ERROR;
 		goto done;
 	}
=20
 	/* success, no more state to clean up. */
-	strbuf_release(&add->lock_file_name);
 	for (i =3D 0; i < add->new_tables_len; i++) {
 		reftable_free(add->new_tables[i]);
 	}
--=20
2.43.0


--wsJCdLgwdnXY42FR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmVzLeIACgkQVbJhu7ck
PpTxVBAApwLetHfbSabf4smXoyrgnZijJ2gmisGMt/RtB99WHk3fYefuQJ7ZSyU2
exxmINJUOaHSsDeYh3OcFBsmlywuyeYKvHPeF10yorOuQnXVphNpwZdr6UJZacGg
MUlJdmbZTlCkKdvLWq3Q4lkmFJTapQMn1JQM7lq3oaLTDdSIrLUOFS1tGFZrKuUw
E1iGybA3CTKdGrzpMSNxWT9vUdINjsGHOFgEWQYjE9JTytacUWr2/zY0vJsCsWCj
NNdMkjEOQSqkkXqPE9/cSBPxC96exfLxuTLfBcG3BlJdgp3PX0r7EKzZboNrHawI
6Xl6b1oyquYT/wByOjkSX7DL9Cpn76Eg2Ly+SOIWqrMq8+0PxArRluJbiYDjZmfj
vQG1YMfDbCixg9SelBAGrz7BfWmwhPvoX/1FfX4dVCptBIYKamLJBzwWsLEtPVX7
sTa7WSugtcYhNoYNacAC/K7x/LDR1KbJ3qxn9qxFMhnc5LXaANmkUKlwWiwts+57
sXNrR9AJ9wZxuJqvX8LEsCPeTuR1XhKzn4/aQuIgUNHE/yU8lo9GMhQi/4dq2nBq
0kJHiJpLegAyS+BArlS2RaoeNYKjOB0GkLQWtjMiz8roemwkMVLLqUx9iTGbaAJd
8I+ETdt7AoUdmFFLs/Iou2om2f54lsQA6VZEyjx7UdNVsvrcIlQ=
=NuaG
-----END PGP SIGNATURE-----

--wsJCdLgwdnXY42FR--
