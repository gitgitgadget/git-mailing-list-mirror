Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="mXySXk++";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="noXh2FS3"
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AE2A90
	for <git@vger.kernel.org>; Mon, 20 Nov 2023 23:04:38 -0800 (PST)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailout.nyi.internal (Postfix) with ESMTP id 7A6B35C16B0;
	Tue, 21 Nov 2023 02:04:37 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Tue, 21 Nov 2023 02:04:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:sender
	:subject:subject:to:to; s=fm1; t=1700550277; x=1700636677; bh=OY
	rVHvJw9rPBjDo146T+1ZsiZSRz31wEIj7NrpAnM5Y=; b=mXySXk++4W0hMEoKDA
	bVXazZ8mL2nJ4DLfDrxGGOQvEjp0fx5XXkiNEIEQOKjxm06zwTorrusXD5G3xQIF
	5GRO255Llrcw8xCeajGChL0hqCMXqjiwvlplSLTvZFHneFnd5rtUdi2iKLZziAqZ
	9jsQAt8sxJEdC0ZIEGhK64acyYdfFwcVsNbPxtOR3SZJH/O7HENIDYQM8LKukp+e
	I5NU5AxYX5YIJKIvgcvZiAgyxhFF5mHOaygw7nULX+i2DhQNCDXRsGvDhKxyRfFO
	L9n/Rbt8bp9Wb5K13xxeQQk3kz700lu/EQ5eR1G2x9EFT1bNRTK7XyDX7bsdjhHw
	5xcA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:sender:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm1; t=1700550277; x=1700636677; bh=OYrVHvJw9rPBj
	Do146T+1ZsiZSRz31wEIj7NrpAnM5Y=; b=noXh2FS3mCbYtIqtoTq0od4nOUy9e
	yknb5jZICGYQketZbWflXiGNBpkl9fuKs1uu913OgNYOslk6Y8sAvM7j3Y7baj/A
	6eKR4DZzLttLJCCtmnJLf/U8roi67fAqm3hhw2ifFLldkSQVoPPzMU8yRNgDmwA5
	f/G8ycEq1nJUX4Ut0i5fkpnNJpLuOSujUphs2LYBDORYvyEwcUSRsjFWLU7R/jFw
	LIrzQ8JTir2YNy0A1ySaCsSZou9X8mXWJSu4m+ofKPvyByhpC70CRJkYn9HZDzTl
	4jWuDfWiKRCkGxyxtLOr8TjTu8YG8ORENd9fvv4JsBX1F9XXor/zj3ZMQ==
X-ME-Sender: <xms:hVZcZV4vwBG0i0jMcgtKqkIhUjnaHwBkvp9q4TkMpkzbmXYRUtIcUw>
    <xme:hVZcZS67ALBMbBM9S_cBoFjmBk-ZFdZ5p7rUZIUwoN8aif0wnGQG5wMDYUskY6xdh
    YlIEANPBbn8e2Bzvw>
X-ME-Received: <xmr:hVZcZcdeQwIOs-uMo74Si6R1dr0m2Ac9PDbSgRmtlO45ashYggas5L4IFQl2UWty1QEznweJF1MlVjdda2dcOY2J2EN7mO4JzIc7lSojdU4D>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrudegkedguddtfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrght
    rhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtth
    gvrhhnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeehgfeltddtheejleff
    teenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpsh
    esphhkshdrihhm
X-ME-Proxy: <xmx:hVZcZeKQLbQ5uCP4R_GLmjASg-axVfMnXvYjnBM1KbcmHMdoAxVu1g>
    <xmx:hVZcZZKALXCuAX6PzLcSErWnHcl6hYVN0vWRsmRAX4FAd2c6c9bB_g>
    <xmx:hVZcZXyGYUiAadlJ0A0GwApnpDt6l1D4g6vmNNzCv6VxV-bUKZkD2w>
    <xmx:hVZcZXgW3fDXZjt4Agd-Ude9KNEwZ5BkykDvb0UORNvg94T42QLxSQ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 21 Nov 2023 02:04:36 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 6737a536 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 21 Nov 2023 07:03:44 +0000 (UTC)
Date: Tue, 21 Nov 2023 08:04:35 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Han-Wen Nienhuys <hanwenn@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 7/8] reftable/merged: reuse buffer to compute record keys
Message-ID: <23c060d1e21573581ca6c5db50ca756b61078e3e.1700549493.git.ps@pks.im>
References: <cover.1700549493.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="fQCZfEIeKmcLEGYV"
Content-Disposition: inline
In-Reply-To: <cover.1700549493.git.ps@pks.im>


--fQCZfEIeKmcLEGYV
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
 reftable/merged.c | 20 +++++++++-----------
 1 file changed, 9 insertions(+), 11 deletions(-)

diff --git a/reftable/merged.c b/reftable/merged.c
index 5ded470c08..cd03f6da13 100644
--- a/reftable/merged.c
+++ b/reftable/merged.c
@@ -85,7 +85,7 @@ static int merged_iter_advance_subiter(struct merged_iter=
 *mi, size_t idx)
 static int merged_iter_next_entry(struct merged_iter *mi,
 				  struct reftable_record *rec)
 {
-	struct strbuf entry_key =3D STRBUF_INIT;
+	struct strbuf entry_key =3D STRBUF_INIT, k =3D STRBUF_INIT;
 	struct pq_entry entry =3D { 0 };
 	int err =3D 0;
=20
@@ -108,30 +108,28 @@ static int merged_iter_next_entry(struct merged_iter =
*mi,
 	reftable_record_key(&entry.rec, &entry_key);
 	while (!merged_iter_pqueue_is_empty(mi->pq)) {
 		struct pq_entry top =3D merged_iter_pqueue_top(mi->pq);
-		struct strbuf k =3D STRBUF_INIT;
-		int err =3D 0, cmp =3D 0;
+		int cmp =3D 0;
=20
 		reftable_record_key(&top.rec, &k);
=20
 		cmp =3D strbuf_cmp(&k, &entry_key);
-		strbuf_release(&k);
-
-		if (cmp > 0) {
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
 	strbuf_release(&entry_key);
-	return 0;
+	strbuf_release(&k);
+	return err;
 }
=20
 static int merged_iter_next(struct merged_iter *mi, struct reftable_record=
 *rec)
--=20
2.42.0


--fQCZfEIeKmcLEGYV
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmVcVoIACgkQVbJhu7ck
PpQyYw/+LQm/G6cZfpX1Q/e+SdwvNx8aqJuJE7V0aWNXcrTOBxJQc5IgtA1vyVVv
KXpnQqoqHaiimfwtI0yf5Vz3OcQMxpAmO4vWgEckp8IGtwb4CJ9M/0u1LKjtP4PX
GWjldopyjKyhKeU0OHtZnVMb1i0zXFFNN1xmeTJx6vQVMH5XEZ7modXrrFsUJWdM
FjS6KVPtQEwqb8ZXdnZsfOrvLO15Pz/07zH31HxlzIA7d8P3pcBlpwwjZqPVBffv
+zRbAyZRq6FsVtFEkOwZeHPhmMTb5+LUlIZsLxNdjPg2dQ6tJt838wOvLQe+nLaE
4AOe3XNox4UojaHYFnUWuq1BRq4NsmddkwGQNTccQ1L5ZKnYxbn+RAOW+XhNzdF6
EKvIOSdyDfZDO7ZZwwq93jJddzmSj0FHwXZ1yl1zZbU579/g2qzYOZQsQcqeMmzW
nxlUtagTybaDSp3jbp7IUsKu71YF2203YmRS82NO2G8haT57Ko5GWV0Ib9HAllra
MvqATDrQZyfOH6ka6/aiLNI2tYlzZ1zkO4BZ/nTE33SDIC5CfFEHu0O/6JYe4Vfo
x7LxZmw4MaPmYNJ9oisgfjoRePBqyYsBJg+yBeB2WUISn3ayL/R21O4EZiQPCtBF
x9JF3QrJTg5TBQJkqNKf99UzyGxTkWH63aockBAjobsPvwL9SXg=
=zBbF
-----END PGP SIGNATURE-----

--fQCZfEIeKmcLEGYV--
