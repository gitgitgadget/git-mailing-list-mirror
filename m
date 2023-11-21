Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="qDruGn10";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="gB7PJR7T"
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B0B990
	for <git@vger.kernel.org>; Mon, 20 Nov 2023 23:04:42 -0800 (PST)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailout.nyi.internal (Postfix) with ESMTP id 789015C16F6;
	Tue, 21 Nov 2023 02:04:41 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Tue, 21 Nov 2023 02:04:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:sender
	:subject:subject:to:to; s=fm1; t=1700550281; x=1700636681; bh=q4
	lEyws93ZJX6pimXEwvcwRWXb7+dfvNrihseQkQfm4=; b=qDruGn10inPacAyDji
	MUtm8lti/rAm4JSLwrnHVHc5Zq6yY4zbXz6uuFQuT7RowSeAzIGG5enLZZK8rv5U
	yKWBgyuTH1hTCxVWknJbFbRNVKbIP/EDOlEgQWmD1wXd4DOZvGcd6+d/rP412Ski
	Fvz+fsV/HWG5BgVDQqz18atNBlm7g2VLY4xu9Axf+/w+TxCH+RZYcUXB3F3PnkxX
	QCzJYFN5xGQUCzxnbQ7Pw6bwiaXAES7PmoZbHt8cIB/XPct0h2nG7w7GBZf3FXEK
	aNQ+tvJNBP0zbxNB8PQCJMS7dhcv+oSQ0ElbBrH7U9L7RKcjmc+Bef/bdnQCRckQ
	/wxg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:sender:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm1; t=1700550281; x=1700636681; bh=q4lEyws93ZJX6
	pimXEwvcwRWXb7+dfvNrihseQkQfm4=; b=gB7PJR7TIdnG3zEZoW5gGDJXuIheN
	NkWk1Oy76fBMn433Krif9WhmKJuZFBbYDSdGR6OFfljade0rzYEoO/YdzPTOxlnM
	lbvCOe92oBiqifYk2B6ID9+fUaVhLt2sLzPI9DxtgvLhKlb9GA5XbtDXUcWslPjC
	YgP6ZyE4sw7TurPKaGfqtrr58KQgBarWBIy0JRO1BODMxJmo2ffwaU1bZFzTzIJf
	rANm6JyW7+4E8cbR7AVjw04rRoQcLv+rSsiwCnQwNF195MS9+/OJ9hC/VNIplOj8
	0Qxn18WljugH7QQJ2T5okz8IXy7foPjPjT7kBn+/PZaLF3DSxCob7OaiA==
X-ME-Sender: <xms:iVZcZUUW3GtFiZjrOHmKP9-QcQWgOVFg149E2P4khzvpu0I1TUFpVw>
    <xme:iVZcZYmVSU4u4wwQS2oazVsPDmmUsLV61DcW_mETjmBU1oWkClYpeEggPmDJfAZc7
    Z55wV1zK0UqZvfCKQ>
X-ME-Received: <xmr:iVZcZYYZWhGKvLBUdykxjm8S_mB01WTnZqE1knNhONQyNSewJFraJjLv4fLCcy7BtJPl_HMcjiJaKeMk-yajTPeCNwM8qXm1ZuhZfyA77X2j>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrudegkedguddtfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrght
    rhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtth
    gvrhhnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeehgfeltddtheejleff
    teenucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhepmhgrihhlfhhrohhmpehpsh
    esphhkshdrihhm
X-ME-Proxy: <xmx:iVZcZTWutla6EWi2UdvZdtdZ7IwwFxpJ6wELHrJJH1HiMX4vyzTFPw>
    <xmx:iVZcZemOa9eR-HDcsWjfOMjXZckdTbVdkTP1WOg9PkWqUvsheNftBQ>
    <xmx:iVZcZYfL46gdEgkYuZKtAOQYO7HSLz4vo-uds2kvU2KTXlXjzwRZ4g>
    <xmx:iVZcZStrv9ehV22qEAr1zfOPNG4NVtwZwC75HSEpi0BW8Ct5eNgl9w>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 21 Nov 2023 02:04:40 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 6524aec5 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 21 Nov 2023 07:03:48 +0000 (UTC)
Date: Tue, 21 Nov 2023 08:04:39 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Han-Wen Nienhuys <hanwenn@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 8/8] reftable/stack: fix stale lock when dying
Message-ID: <065c8803ac18633313af264f70c83717c4f6e10c.1700549493.git.ps@pks.im>
References: <cover.1700549493.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="YFSkH5v+AcoGLgLT"
Content-Disposition: inline
In-Reply-To: <cover.1700549493.git.ps@pks.im>


--YFSkH5v+AcoGLgLT
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
2.42.0


--YFSkH5v+AcoGLgLT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmVcVoYACgkQVbJhu7ck
PpQPsg/9H/pWflCiShhaPJjrelp3ve8NUMnmPwluK2QatZRreZqRpa1/3NyPmagr
+6G6shZBwNF9eDEzB3jFbcHLreEN5RUA0JiKlwE6MK1tP3nk4p5wM/1qQTqQ7GKF
23tCvaDUB9q6mxS7BAvMXrXNoTgkJ+rRhFjhF9L74eEcncxh19HomgGHgMChV9mR
+ssFnbh45KsGfdMzRp30Wv5X4ZMLL0uxGLwG+0J+ucKJYvPb9p7KWOB1ZNM/2keM
B98R4dmiwOVhoF6Gsc8qB+Qc8idnMk0UFsI05m2Lk3QDX6FKYvM4mgQY7V5yBYGC
ynVdRb/yCfMRcNV0y/6Sdnj4GhIqUmBtq+I/ryk6UkyTFO6NoAiQYBPMSCBBHA/c
wX66BpJ5SuKPD/EyiyAvWL9GoKD5ybHsWkpSl+Ekfpb9AGiHxbuEqxXnFlj3jDd1
m1rB9CIwN7Uq50B/c2Jj/l9gitQCsl7uKu0XMz+CMWXhdbc9VVIBJnripPQROiJ3
TCic6e0RyHtEhIiyP2tM1EnUi5yn+JzUR6BU6SgAp4U+zYs5CrE4g33NMqyj4qC5
otf5MT/TC180ffr3fGxQbqskTZzHBkn/Q24MKRQb9tBSGAviykWgHKkAsO7fkBBJ
6GYjcH43/QYwVpy0qTXvvGAClvHRe2sTE/BJhLeql+E6Co+t6eA=
=KSTy
-----END PGP SIGNATURE-----

--YFSkH5v+AcoGLgLT--
