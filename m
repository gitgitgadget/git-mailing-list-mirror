Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="EyUuc6S9";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="QcU0Tcjx"
Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com [64.147.123.25])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F10ED9
	for <git@vger.kernel.org>; Mon, 11 Dec 2023 01:07:59 -0800 (PST)
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
	by mailout.west.internal (Postfix) with ESMTP id 4A55432026C7;
	Mon, 11 Dec 2023 04:07:58 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute7.internal (MEProxy); Mon, 11 Dec 2023 04:07:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:sender
	:subject:subject:to:to; s=fm1; t=1702285677; x=1702372077; bh=d/
	YwCty6KaZpaJE88FLpSCs/ki97O1H3EcjRPj3V1Is=; b=EyUuc6S95TXVom1QAC
	P52O4JXTikl8quxagK/EFPEfSV+ike94UXBcg9aU4+vwuwoz6ekRN1myQN6AMuVs
	2wMfksFWVC0jle9pkXC25K1PKE2zFDMgmmlGSR/E5VsdKivHFXEqbExuLMhtnrrP
	dOqWCVnNS7Y0iYhGIl+C8IU9DfZpgvn6i5kB587bk8fXLfWb3Rc7m9Sawcp2yVJF
	kHKFanCH2NTOAdMMy5GYK2/qwXHA+PfqUkPvT2rM2VHl29/19wJgqjPXGqzFAFI6
	MwLqX4wSoxT6jQbRxfSVnULM5dvP0W4PFulH5LVIICtMFofMlv6q7QFojYW86zX/
	iFHg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:sender:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm1; t=1702285677; x=1702372077; bh=d/YwCty6KaZpa
	JE88FLpSCs/ki97O1H3EcjRPj3V1Is=; b=QcU0TcjxPuv+74APDyydch3uit1c4
	viJCnCirs+mJur62qn+YSsu9OEnjzKXY8m1O805XS11c9anK2CCvrr14UgsjqK0y
	HyhWt8nCBFMygHfeOkhzHCzCpHBqqx8ziVEk1MhP+gJZ9yMOw+UXTFnDLBZOKPV9
	JxlG+feQXGWqlxs7AvdHiPcwIxcDkyd0smXtdXzqzbaxlJ0AAStbd0Rn2OgziMHm
	uBBFQE2VkBw8ql++LnGgGxy7ctQi7Pc1Afku/fM3EJEgZyurUrIU3tO1ECcoirD4
	MM6IUOH/d03hKl2Q6f0wkEyZcV/qMu4J5S1S3bk/T5csFu+RyUasogz8g==
X-ME-Sender: <xms:bdF2ZQtaKcWpAUAOn-pdyPdNKPiopPew0jxNLxwAqCZVsvz2QE6jag>
    <xme:bdF2ZddUm-1LUHpnGPan3XL86YKz-cZ04pknpX82__ub424fH4O00jrIAEF2DWOdw
    YXMEMeCow6o1lZiZg>
X-ME-Received: <xmr:bdF2Zbyh8FhPrFdmnKD3ECjCWlGkjCPMfYh7IEURbjJHjpiun7hkVLBIT1quZWhGNnllj_R2AlzuFfSWqCbhUJErfJU7388NH6MRb3n45J-SCA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrudeluddguddvlecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrght
    rhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtth
    gvrhhnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeehgfeltddtheejleff
    teenucevlhhushhtvghrufhiiigvpedvnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpsh
    esphhkshdrihhm
X-ME-Proxy: <xmx:bdF2ZTMx93VZ8cM_omggbVwRmCHjvwyw1B9deFk19-L8VzTGe4l5cQ>
    <xmx:bdF2ZQ-JuyEWoibrMnZ7rn4mBie-Q7tlAWIxikk7mwbmcWAEfxvn7g>
    <xmx:bdF2ZbVxt7Yyac5H4mJoAxm1VcGDqPDcbH0Bk5C9kfnWP9RiMYsDYA>
    <xmx:bdF2ZfZ4Fj1DkLH7JeeHofPDIpQIHvU24ZVm05_A5H7kkgHJWFwseA>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 11 Dec 2023 04:07:56 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 688e2e20 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 11 Dec 2023 09:06:20 +0000 (UTC)
Date: Mon, 11 Dec 2023 10:07:54 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Han-Wen Nienhuys <hanwenn@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>, Taylor Blau <me@ttaylorr.com>,
	Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v3 07/11] reftable/stack: fix stale lock when dying
Message-ID: <fbd9efa56d96a8d1bf9d3f1f4070b85d2be5ad12.1702285387.git.ps@pks.im>
References: <cover.1700549493.git.ps@pks.im>
 <cover.1702285387.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="1eGFYaRaf6y1owt4"
Content-Disposition: inline
In-Reply-To: <cover.1702285387.git.ps@pks.im>


--1eGFYaRaf6y1owt4
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
index 2dd2373360..0c235724e2 100644
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
+		if (chmod(add->lock_file->filename.buf, st->config.default_permissions) =
< 0) {
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


--1eGFYaRaf6y1owt4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmV20WoACgkQVbJhu7ck
PpR3+xAAraTUVp6d+5alNJRyH6IiHLHCmkrqauUP8OWFqicND01dHE4gkar+qhIm
4c4BbKaWIk4MPz+oJPdVjuE9edyjKxw+uHaTOuQOVGQTvhS+DDNjTMbs1gnV7S0a
J0G2RWegEVh4lnus2zsla3TuOvLTrEaVhD+Uq7eXDuBZsqUc96OU9OwQBQUoEVsJ
dkvnifDiY+b8T9HBHbj3xb/dhbgKWZxhbUcVJY641ik5QoepzmKoTxEpLXNRTagb
29DL+qs6WUPmWqdYsdpx5EXDq39ravFJDXXxVMvFeChXrIqdRjyUHEThngOQzslK
fXc1lzq+sNX0DoQj08wi5G4HOJu/zLycvM10ELsvN9LohAHWdMnup7mnnfIqvCTE
RAQSbfvHEUBwhIlcqZm4p4fvad5zJ8MeNcOHH6iDoCgVYugK6wTnOMfwJw5sUQZw
NnroEUhxD1Sor/EzlF9HtIaXhV6eDj3k45fbdhlCLkFySScDFpx5S5wxNV9k0n5f
pFIw3N0+7xG8tmqzU0ZkuU8FThRTSrXUF46wZIQdhTuVe0oo5FS1LvjWxtNRBmve
fajR/H0BcokbFVwtxUdyICgGS9aowDhQ5Xma8WeyIa/gjaDDr6VcnDQXPL/DwTF3
CSK7KUdvSjdn+PhjQ/XlKmXt+7ccGoSsuxp4Hof5yitV0FpzLFE=
=j0s3
-----END PGP SIGNATURE-----

--1eGFYaRaf6y1owt4--
