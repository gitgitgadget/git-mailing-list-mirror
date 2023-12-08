Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="CfzIsWhX";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="P60Pjz7h"
Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBD185251
	for <git@vger.kernel.org>; Fri,  8 Dec 2023 06:53:26 -0800 (PST)
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
	by mailout.west.internal (Postfix) with ESMTP id C86A73200A28;
	Fri,  8 Dec 2023 09:53:21 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute7.internal (MEProxy); Fri, 08 Dec 2023 09:53:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:sender
	:subject:subject:to:to; s=fm1; t=1702047201; x=1702133601; bh=0K
	B8yHQRfh7qieVzM8MgyP4GTYU6xovElQvFFjF5OmM=; b=CfzIsWhXiMpj+hQoKA
	aGyN/0yxn3fyZ40+2FcE0JykVV8uZ2XvYlngpERXNQufvjieFHde6tItBUe7ouuO
	ydm+pwHqH6cPgRMYiHD7Eb6UHM7DjwaR+g+YUY81VmVOEV6XfDbtUpgoz0Cd85qA
	hg+H9ZgxUqyMARC7wTsj9OEfYbQHmA6Jy7xWcTttFMxXDnEHdG50MBODK4e3OAGc
	2bLuKIDUHo7jNNyiFtkjylzUsogkJ4OxsuIZ8FcrHOqe7XxcFWcjv2buy4NXeOkj
	yCxiQeSXl/++fb5IuGOFBSnWrrEyiCsLs+z5LILTLRJkefqQlmxoSsf8t4KG4B5P
	S+UQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:sender:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm1; t=1702047201; x=1702133601; bh=0KB8yHQRfh7qi
	eVzM8MgyP4GTYU6xovElQvFFjF5OmM=; b=P60Pjz7h/03Sd5qEf7CvNi9zRPEMn
	S3xNgd87uMGtefCi2fKCK0jC8mZUwFvQedmbgeM+dmsP3mlz6+wUsFK0VznfC4w1
	YAcVygW3pPp3XAmCXb4l+fOUn5z4tMJMRl+hVLLMuCWfrd4Mq3pghx0gUkiaTAU5
	uDPsaZ2fYzTluF90N2GIOKhF/ZrJLTDn4aXGGg/R2RKlRNzZBd6w4O8AU8xgi6Bw
	H9B5pebumnqljaHKncLqenH9+fqEld4ToHKNua0+1CrkygOoC54J7oXJAZMwi3hk
	0250P5YjUr8d2SXfbctbhlRNQBpmWzF2agPOJl5fpruAoBhwsgGQ7oozg==
X-ME-Sender: <xms:4S1zZTa_OnaiJdSnd6HBFVO8IPiqTxEm-_EAnA6Ynl4E5CGuCMOIEQ>
    <xme:4S1zZSYKjIDeoJlufsfCeHaKLkAyiluNEr-nBoo_9SQewiQSHhrVEhl8iWf9RXJBP
    OltBHewuDrnYAhoeg>
X-ME-Received: <xmr:4S1zZV_OJtOOof3ixNiWY8KRb3jRFs6fEEzrfLUakgfBz3SOg2l4iUVsrfStPnjXXQ3DsG9DUGwuHHF8K8DnumsIRljmZ0AiTaECNFpT56bAeIE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrudekiedgjeduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:4S1zZZqkZqtNhGNCsicajePV8vW5KJv931A0Fcg7oC5bDnX7SHRcZQ>
    <xmx:4S1zZeo10riK9kpuz4YGdMa0ICN_Zy6uGkKWvAHw07lWQxBzLx1TlA>
    <xmx:4S1zZfTMj65DsA36f0F17ih-m5KGSqheAEzABNnVJE6x8ByyyTdn2g>
    <xmx:4S1zZTDpD2R3WqNnZci6_mDfbN2FwyGr7GwckLs7eoMPiI2bqt0SeQ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 8 Dec 2023 09:53:20 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 62057270 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 8 Dec 2023 14:51:50 +0000 (UTC)
Date: Fri, 8 Dec 2023 15:53:18 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Han-Wen Nienhuys <hanwenn@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH v2 06/11] reftable/stack: reuse buffers when reloading stack
Message-ID: <f797feff8dec383f1db9ae403cd89b80d1743432.1702047081.git.ps@pks.im>
References: <cover.1700549493.git.ps@pks.im>
 <cover.1702047081.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="jA6z04DpfdKYMfoC"
Content-Disposition: inline
In-Reply-To: <cover.1702047081.git.ps@pks.im>


--jA6z04DpfdKYMfoC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

In `reftable_stack_reload_once()` we iterate over all the tables added
to the stack in order to figure out whether any of the tables needs to
be reloaded. We use a set of buffers in this context to compute the
paths of these tables, but discard those buffers on every iteration.
This is quite wasteful given that we do not need to transfer ownership
of the allocated buffer outside of the loop.

Refactor the code to instead reuse the buffers to reduce the number of
allocations we need to do.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 reftable/stack.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/reftable/stack.c b/reftable/stack.c
index f5d18a842a..2dd2373360 100644
--- a/reftable/stack.c
+++ b/reftable/stack.c
@@ -204,6 +204,7 @@ static int reftable_stack_reload_once(struct reftable_s=
tack *st, char **names,
 		reftable_calloc(sizeof(struct reftable_table) * names_len);
 	int new_readers_len =3D 0;
 	struct reftable_merged_table *new_merged =3D NULL;
+	struct strbuf table_path =3D STRBUF_INIT;
 	int i;
=20
 	while (*names) {
@@ -223,13 +224,10 @@ static int reftable_stack_reload_once(struct reftable=
_stack *st, char **names,
=20
 		if (!rd) {
 			struct reftable_block_source src =3D { NULL };
-			struct strbuf table_path =3D STRBUF_INIT;
 			stack_filename(&table_path, st, name);
=20
 			err =3D reftable_block_source_from_file(&src,
 							      table_path.buf);
-			strbuf_release(&table_path);
-
 			if (err < 0)
 				goto done;
=20
@@ -267,16 +265,13 @@ static int reftable_stack_reload_once(struct reftable=
_stack *st, char **names,
 	for (i =3D 0; i < cur_len; i++) {
 		if (cur[i]) {
 			const char *name =3D reader_name(cur[i]);
-			struct strbuf filename =3D STRBUF_INIT;
-			stack_filename(&filename, st, name);
+			stack_filename(&table_path, st, name);
=20
 			reader_close(cur[i]);
 			reftable_reader_free(cur[i]);
=20
 			/* On Windows, can only unlink after closing. */
-			unlink(filename.buf);
-
-			strbuf_release(&filename);
+			unlink(table_path.buf);
 		}
 	}
=20
@@ -288,6 +283,7 @@ static int reftable_stack_reload_once(struct reftable_s=
tack *st, char **names,
 	reftable_free(new_readers);
 	reftable_free(new_tables);
 	reftable_free(cur);
+	strbuf_release(&table_path);
 	return err;
 }
=20
--=20
2.43.0


--jA6z04DpfdKYMfoC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmVzLd0ACgkQVbJhu7ck
PpTkKw/9FcLz9y+4/Xo1e0P4h41XtdFrbJ+R2Ke1gZqzhp8yxK02E8AoaykeEgBq
EdircPz5yJz2l0XLO56dM3wBsfeTNPwAzLi7TH3JCIAMWAZhIqLmw/lpSbyTCQOw
BYsNP1MLUR/YpJ8/l0f6ND5vZOa508bwVymWNECafd1rxnQrIV3QbW+iMoTxsm0t
w9inWTksW6IfIT3i4uZyxD3ypWTMdpS5Uppp3T5QG//Si2HaRHzkEXAm+JZJlyUU
OqvWqXkNwrukZrvfcVMWYPR8iMHNvD2vUFuHH7Y0uoGMUZXJNcqY9/0LqHxKYUlk
tR7kKc803aNGObTmwkCvCZrURGKIvyeHu4G60n1ZMd6jyzmxHpHShlE0Q58lGius
KAixd4XA/cep8y+xJcVx79Qu+AOjKKXh6QfmYxK7dilw5fG1bwzeMyc2T5f+N+ab
2AY//m5VqPxfQWaJxpWRoScVGbZW1l7cqiPdCyUXP+rXTPIz9g6rCQvSdyK1GIUd
k5z+UOLwpe/5ka+WpMyH6eqgC4AMZwwOMU+feIabPvy0mh4yolK1FCmwbJmrOlji
0eQYzdwWQZMZHJXS47Y9ixZYHzURVkVELMe3HaNUJKAMdW4Yqw7qKPogV0fiu1rw
SNzrUAGjlvHL8xg5Fv4EqciTxgfcAnwi9rUzyPU6Vcg82njBpts=
=8giz
-----END PGP SIGNATURE-----

--jA6z04DpfdKYMfoC--
