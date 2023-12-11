Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="k/OCUC71";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="IQDpcH9y"
Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com [64.147.123.25])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12DDCD9
	for <git@vger.kernel.org>; Mon, 11 Dec 2023 01:08:08 -0800 (PST)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailout.west.internal (Postfix) with ESMTP id 2FC8A3202709;
	Mon, 11 Dec 2023 04:08:07 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Mon, 11 Dec 2023 04:08:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:sender
	:subject:subject:to:to; s=fm1; t=1702285686; x=1702372086; bh=gU
	91c3tl+qRFFG28uKLIsZD1PebJPVL/SEfpBfQIq2U=; b=k/OCUC719EmKlSae0n
	ZKpqxhj7iz9iMCZwFevjxWHxpAg3mwH0YHSQw/kuKborHgZHTJYQIGpVSD+SDtP4
	rOJgRMT35rQVb+M0SC70cDzrG8mZaC/hGzQoZyqdBilXRd3B8FvtBEGU3hr0VibN
	ZEBOZsOx7g+7NRXvidBxA2GGwKeQ7nWIJOvyvt5S7AADy0j/g359hRollHeEFHrH
	w1H4MmR9+nBwvwbxqgz/126MbuMqpF7NQ2IjhDyE/rBQrrSuBc19UxjjEv8jcF/Z
	ffraxbA0nQrs/4uall7dbAtQK4b3GxjsVV4yblA9gMHRXEnJu5WAY8YhD3gqJsTG
	BX2g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:sender:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm1; t=1702285686; x=1702372086; bh=gU91c3tl+qRFF
	G28uKLIsZD1PebJPVL/SEfpBfQIq2U=; b=IQDpcH9yW0LNYcgbtHtBVgNysmwF/
	vxxdq9iHOUHkyS5C5+3bNQegjN74bG0fizmHT87bnZJUv2rU/KJDQhRmBVvb5GDm
	hFp+HueoKPzFSeW1KT3xaKongO7UAxFeTtEpmcY3aKGLxZbeyd8M8rPpVO+ImgOf
	ieNtp46ZbM1k4ubCOaaqZan2FQISpAnzododcxZk4K14SPjGCoflQ/NvW4dyyp85
	+LKS2A1FlYEUk5dxRd2sb4uNFyrZsN4LOk8jGzxa8rDsm20dYBV00mrqxwD2nIW4
	mVJ7rZcyEwkd9X6Q6GHplos1WQRfpup8jSWSujCsi7XCxnQ4Md2TXIIpA==
X-ME-Sender: <xms:dtF2ZfCrTvMT4YXDIoe1TzoPAndISnJFz-uKHoBIUn9ZIkSNDWYMaw>
    <xme:dtF2ZVjxLjDIUQBlKGPVrh7WVHmMHbwiq-07F52iCIvAaWmojtDTRWNiBUCOmxdrI
    f0zwAO4qiVIvEvx8Q>
X-ME-Received: <xmr:dtF2ZakqUnU_2U2MZtbqcdjKnfI78QVLLgL7UBl7poXZM4wqdV6e3Tf2Qkybo2if1ieTtfFEydzM5rnd7XTA2XbIceMUALitUcLzyc-LFTLR4w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrudeluddguddvlecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrght
    rhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtth
    gvrhhnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeehgfeltddtheejleff
    teenucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhepmhgrihhlfhhrohhmpehpsh
    esphhkshdrihhm
X-ME-Proxy: <xmx:dtF2ZRxs_-yP4ZAT-Oc9XBw3PTHitBW5qm9Qn5_GHZ9Ys3CXFk6mOg>
    <xmx:dtF2ZUT09ZGupFrVC-61LJus6tIMTmAnOSa6xYnTmEtSDgwN2ok8mQ>
    <xmx:dtF2ZUa1xMbsM9IBYxg2SFLSyxnxcZ_F1bRbiSLd43DzAYpMtNOJoA>
    <xmx:dtF2Zac9uF43-J0kC5G352TllR01V6LsrgU8NPy35xXuek_C9oK4mQ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 11 Dec 2023 04:08:05 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 8573ddf0 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 11 Dec 2023 09:06:29 +0000 (UTC)
Date: Mon, 11 Dec 2023 10:08:03 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Han-Wen Nienhuys <hanwenn@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>, Taylor Blau <me@ttaylorr.com>,
	Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v3 09/11] reftable/merged: reuse buffer to compute record keys
Message-ID: <79e03826039e9b91e456e4c7d2c5a2367a082736.1702285387.git.ps@pks.im>
References: <cover.1700549493.git.ps@pks.im>
 <cover.1702285387.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="4JHHRU3R8HVo824a"
Content-Disposition: inline
In-Reply-To: <cover.1702285387.git.ps@pks.im>


--4JHHRU3R8HVo824a
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

When iterating over entries in the merged iterator's queue, we compute
the key of each of the entries and write it into a buffer. We do not
reuse the buffer though and thus re-allocate it on every iteration,
which is wasteful given that we never transfer ownership of the
allocated bytes outside of the loop.

Refactor the code to reuse the buffer. This also fixes a potential
memory leak when `merged_iter_advance_subiter()` returns an error.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 reftable/merged.c | 31 ++++++++++++++++---------------
 reftable/merged.h |  2 ++
 2 files changed, 18 insertions(+), 15 deletions(-)

diff --git a/reftable/merged.c b/reftable/merged.c
index 5ded470c08..556bb5c556 100644
--- a/reftable/merged.c
+++ b/reftable/merged.c
@@ -52,6 +52,8 @@ static void merged_iter_close(void *p)
 		reftable_iterator_destroy(&mi->stack[i]);
 	}
 	reftable_free(mi->stack);
+	strbuf_release(&mi->key);
+	strbuf_release(&mi->entry_key);
 }
=20
 static int merged_iter_advance_nonnull_subiter(struct merged_iter *mi,
@@ -85,7 +87,6 @@ static int merged_iter_advance_subiter(struct merged_iter=
 *mi, size_t idx)
 static int merged_iter_next_entry(struct merged_iter *mi,
 				  struct reftable_record *rec)
 {
-	struct strbuf entry_key =3D STRBUF_INIT;
 	struct pq_entry entry =3D { 0 };
 	int err =3D 0;
=20
@@ -105,33 +106,31 @@ static int merged_iter_next_entry(struct merged_iter =
*mi,
 	  such a deployment, the loop below must be changed to collect all
 	  entries for the same key, and return new the newest one.
 	*/
-	reftable_record_key(&entry.rec, &entry_key);
+	reftable_record_key(&entry.rec, &mi->entry_key);
 	while (!merged_iter_pqueue_is_empty(mi->pq)) {
 		struct pq_entry top =3D merged_iter_pqueue_top(mi->pq);
-		struct strbuf k =3D STRBUF_INIT;
-		int err =3D 0, cmp =3D 0;
+		int cmp =3D 0;
=20
-		reftable_record_key(&top.rec, &k);
+		reftable_record_key(&top.rec, &mi->key);
=20
-		cmp =3D strbuf_cmp(&k, &entry_key);
-		strbuf_release(&k);
-
-		if (cmp > 0) {
+		cmp =3D strbuf_cmp(&mi->key, &mi->entry_key);
+		if (cmp > 0)
 			break;
-		}
=20
 		merged_iter_pqueue_remove(&mi->pq);
 		err =3D merged_iter_advance_subiter(mi, top.index);
-		if (err < 0) {
-			return err;
-		}
+		if (err < 0)
+			goto done;
 		reftable_record_release(&top.rec);
 	}
=20
 	reftable_record_copy_from(rec, &entry.rec, hash_size(mi->hash_id));
+
+done:
 	reftable_record_release(&entry.rec);
-	strbuf_release(&entry_key);
-	return 0;
+	strbuf_release(&mi->entry_key);
+	strbuf_release(&mi->key);
+	return err;
 }
=20
 static int merged_iter_next(struct merged_iter *mi, struct reftable_record=
 *rec)
@@ -248,6 +247,8 @@ static int merged_table_seek_record(struct reftable_mer=
ged_table *mt,
 		.typ =3D reftable_record_type(rec),
 		.hash_id =3D mt->hash_id,
 		.suppress_deletions =3D mt->suppress_deletions,
+		.key =3D STRBUF_INIT,
+		.entry_key =3D STRBUF_INIT,
 	};
 	int n =3D 0;
 	int err =3D 0;
diff --git a/reftable/merged.h b/reftable/merged.h
index 7d9f95d27e..d5b39dfe7f 100644
--- a/reftable/merged.h
+++ b/reftable/merged.h
@@ -31,6 +31,8 @@ struct merged_iter {
 	uint8_t typ;
 	int suppress_deletions;
 	struct merged_iter_pqueue pq;
+	struct strbuf key;
+	struct strbuf entry_key;
 };
=20
 void merged_table_release(struct reftable_merged_table *mt);
--=20
2.43.0


--4JHHRU3R8HVo824a
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmV20XIACgkQVbJhu7ck
PpSGMRAAnd4WTdVVyVqLyHdLv7DKMuROfEx6WrO8ZEHattrPyq4JJvxrGdU2gAFg
Hy7jaZ82yILROpNBLxKzNRKWArY6Ucj/wypVSoPi60kMwmhmR3F1iDXzSUt4c/hW
16WbEsLAco8TrOhFwDl3cb+UcQ+LsPc/ow9rgy5IAJK98s5Cda+lDkW+La1a11YR
f0XCtXOZZNfxpXOGHeQZaJOLv+ilotdK398BKCu/q7JTrziR0NzNOayyT+C+pDJ5
pC6vNAHrjiHa9jb7XYU4uxfgYM9aVKXhrnoJyXhFg2ZKt1T0hTlr0k1VOzG88QDT
qNZP6r5jTLl/9jkO5omWl/G2OZWjjcqBzLI/KIvEtWErKsogrJEtiG75ac0ooG+Q
4YMwYWo6E3FUskf0LiY97x3a3okgp3JsGvaNhNQ71jwkgEG+5JthozuXlI9Tp3ht
En9DHmdPoqQyoeHTxLk0wfcK6Oq1OTGs0zgdPTOlF8yf80V65UtBa3UoFvV7OJzm
zTlewG9VP0RR8XGpf6td2vm7gziIEzXIIzEdyA7pcsC107QmnWyLhd/9RR8MLzj+
QCRr+1oWqs/BtzEb5lXhXPQq/i7qYLujDePI2QJTEVbJEKYGyWQFAqPff0H+vldw
YxkUaZT8wiIZ1iV+dZ8fq7gJLJAHtYoKGvzrME+AApRMQgNCK6Y=
=Z1Un
-----END PGP SIGNATURE-----

--4JHHRU3R8HVo824a--
