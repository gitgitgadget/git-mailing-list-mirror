Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="W9Nyo+9G";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="C7cE9wxd"
Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D95F226A9
	for <git@vger.kernel.org>; Fri,  8 Dec 2023 06:53:44 -0800 (PST)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailout.west.internal (Postfix) with ESMTP id 25BD93200A26;
	Fri,  8 Dec 2023 09:53:44 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Fri, 08 Dec 2023 09:53:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:sender
	:subject:subject:to:to; s=fm1; t=1702047223; x=1702133623; bh=MR
	8/vdeKYlYQpksNgtUNJ5uwcpcroH1Gk4ksTnYEmuM=; b=W9Nyo+9GmALbV7PkKG
	tdsqY+QjR20tXmjDMjtX6Z+M/w9F0E/uYA2Wt5K6UTUtqgqKN5GdZPnVba+Fhtqf
	ABb5Qegx+XI1FnvNfgIwVg2zRpiynhooU2vobDlalb3obubMUY3oJismMvGxtQx/
	o9piGmuli744FdkiXkfWQpIE0Ox0WlO6x2hPfm4ey0J4Hkc9Hvalt1g0x5PU8cbf
	i6c84VFriHS++hXi+k1jon5/OtaNkwzZ9u+VgkWa3xbe/8mGzcakYicBkrKOMYBn
	g14QpnbmXXrZ3qiU6ZMiy5zjU1xFMG8MKhVGfj06Ql7f1Y6hXabsCxdqia+cu0/E
	N01w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:sender:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm1; t=1702047223; x=1702133623; bh=MR8/vdeKYlYQp
	ksNgtUNJ5uwcpcroH1Gk4ksTnYEmuM=; b=C7cE9wxdxCKFOZ/VDbMouxcCZ4So0
	yGQHOkygBNksb0tSMeoeW+drop9TL6RL7gBzXGe91L/QR9Bl4Yy6IgOVWlz6wR43
	nOVIU5RPH1oa7q2PickN1vgRyAoGr7wbH2QQ4sp9qP4qHCrDnfu5r97wtvdwEC5M
	BJEhYtDL7Ootese/DFnrmqCE3R/yq9NFwaUhVzzJgYNO/8AgJ5BjSy/mcGtRk0J6
	eS8W4dRGno2JYOwPeHkQsByMbbxgTqmoHFMq2PHv5d/Pu9qamDxHxGeo54Wnp1dg
	8kyBGjlnt0Y4r/s0gkL6YWsFSTqxuEjCFd8Iq5oR51W8ed/uNioJdMH5w==
X-ME-Sender: <xms:9y1zZdlfLQuzuU_KP-A20kO1V5YaP46G4BSCfxCAFVUBCG5-qgTNPw>
    <xme:9y1zZY3hcFiOFLc97ZWJBRsg85goovJDqhLxvew81p-WTa-rJZUlsZtZc-BmbdJQU
    nXXSJNjU_zdCcRAyQ>
X-ME-Received: <xmr:9y1zZToPET6LjFHgTk57DaKTWUJnOsiphhaaLAn-BjZZMvjkZffHInf90ln0APnlAR9gHsZMohDCfF3IIDL-RVN0rUzzgzRwA1GrGMjgUlMkw_s>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrudekiedgjedvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:9y1zZdkDTVtag2x7NiXTSEi5Y7_3ajr81JSvvZiQWi2XCbK_Hc6x0A>
    <xmx:9y1zZb1djwdIuFKSbKJzxzMAqv3H1Aur1tcHhWmevGIteUQWhWOL-Q>
    <xmx:9y1zZctTZddRQXz6LnwhcvDgd_fOhbEtK6T4-rwLZ-_vIf4EClWpNA>
    <xmx:9y1zZU9RBQsawg0xL7hD6QFGJYrPa-CHShU0eGRJFujTjWGCwp0MZQ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 8 Dec 2023 09:53:42 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id be602c60 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 8 Dec 2023 14:52:11 +0000 (UTC)
Date: Fri, 8 Dec 2023 15:53:40 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Han-Wen Nienhuys <hanwenn@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH v2 11/11] reftable/block: reuse buffer to compute record keys
Message-ID: <02b11f3a80608ba8748a0d0e2294f432e02464e5.1702047081.git.ps@pks.im>
References: <cover.1700549493.git.ps@pks.im>
 <cover.1702047081.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="rcSWnUvkTeCkS+1Q"
Content-Disposition: inline
In-Reply-To: <cover.1702047081.git.ps@pks.im>


--rcSWnUvkTeCkS+1Q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

When iterating over entries in the block iterator we compute the key of
each of the entries and write it into a buffer. We do not reuse the
buffer though and thus re-allocate it on every iteration, which is
wasteful.

Refactor the code to reuse the buffer.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 reftable/block.c | 19 ++++++++-----------
 reftable/block.h |  2 ++
 2 files changed, 10 insertions(+), 11 deletions(-)

diff --git a/reftable/block.c b/reftable/block.c
index 8c6a8c77fc..1df3d8a0f0 100644
--- a/reftable/block.c
+++ b/reftable/block.c
@@ -323,30 +323,28 @@ int block_iter_next(struct block_iter *it, struct ref=
table_record *rec)
 		.len =3D it->br->block_len - it->next_off,
 	};
 	struct string_view start =3D in;
-	struct strbuf key =3D STRBUF_INIT;
 	uint8_t extra =3D 0;
 	int n =3D 0;
=20
 	if (it->next_off >=3D it->br->block_len)
 		return 1;
=20
-	n =3D reftable_decode_key(&key, &extra, it->last_key, in);
+	n =3D reftable_decode_key(&it->key, &extra, it->last_key, in);
 	if (n < 0)
 		return -1;
=20
-	if (!key.len)
+	if (!it->key.len)
 		return REFTABLE_FORMAT_ERROR;
=20
 	string_view_consume(&in, n);
-	n =3D reftable_record_decode(rec, key, extra, in, it->br->hash_size);
+	n =3D reftable_record_decode(rec, it->key, extra, in, it->br->hash_size);
 	if (n < 0)
 		return -1;
 	string_view_consume(&in, n);
=20
 	strbuf_reset(&it->last_key);
-	strbuf_addbuf(&it->last_key, &key);
+	strbuf_addbuf(&it->last_key, &it->key);
 	it->next_off +=3D start.len - in.len;
-	strbuf_release(&key);
 	return 0;
 }
=20
@@ -377,6 +375,7 @@ int block_iter_seek(struct block_iter *it, struct strbu=
f *want)
 void block_iter_close(struct block_iter *it)
 {
 	strbuf_release(&it->last_key);
+	strbuf_release(&it->key);
 }
=20
 int block_reader_seek(struct block_reader *br, struct block_iter *it,
@@ -387,7 +386,6 @@ int block_reader_seek(struct block_reader *br, struct b=
lock_iter *it,
 		.r =3D br,
 	};
 	struct reftable_record rec =3D reftable_new_record(block_reader_type(br));
-	struct strbuf key =3D STRBUF_INIT;
 	int err =3D 0;
 	struct block_iter next =3D BLOCK_ITER_INIT;
=20
@@ -414,8 +412,8 @@ int block_reader_seek(struct block_reader *br, struct b=
lock_iter *it,
 		if (err < 0)
 			goto done;
=20
-		reftable_record_key(&rec, &key);
-		if (err > 0 || strbuf_cmp(&key, want) >=3D 0) {
+		reftable_record_key(&rec, &it->key);
+		if (err > 0 || strbuf_cmp(&it->key, want) >=3D 0) {
 			err =3D 0;
 			goto done;
 		}
@@ -424,8 +422,7 @@ int block_reader_seek(struct block_reader *br, struct b=
lock_iter *it,
 	}
=20
 done:
-	strbuf_release(&key);
-	strbuf_release(&next.last_key);
+	block_iter_close(&next);
 	reftable_record_release(&rec);
=20
 	return err;
diff --git a/reftable/block.h b/reftable/block.h
index 51699af233..17481e6331 100644
--- a/reftable/block.h
+++ b/reftable/block.h
@@ -84,10 +84,12 @@ struct block_iter {
=20
 	/* key for last entry we read. */
 	struct strbuf last_key;
+	struct strbuf key;
 };
=20
 #define BLOCK_ITER_INIT { \
 	.last_key =3D STRBUF_INIT, \
+	.key =3D STRBUF_INIT, \
 }
=20
 /* initializes a block reader. */
--=20
2.43.0


--rcSWnUvkTeCkS+1Q
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmVzLfMACgkQVbJhu7ck
PpRvlRAApdB5LW89+kk+HTReJ0QYMDrGOLgPNxn3/RwE6NJwD87N1yj1cEiJtmv7
u9TPCv7q1plAbyWfMowFZTPB+XBeFBb/iZKI76+oshDI2FYh5PTySz/y6MocTinU
MKQ1Nhd6RJnGW8oijBDnN7cxkeoJ+NALsKzeVFhBxIg/X2272pta0DtG2Hos8xaa
z0MnIfvzFxrcOznW7HMsLZcTmug1CMhKjJaUZyADTBHc94Bu0Wf9Sxe+AT1xoxVq
c4UB8+efGANp5twD7k2j8d/pi5fhbX6v5r+O2c3rADmiNQY0R4ekG6/2anxL/YX7
U1yxxtEPnxU2bks+vyL1B/7QtQiKPjZDKV+4c+Ln4HzOI/YDkMIS8MtQpt1Ve6f1
V/+xjVOtHovpZAzVmtav27MoJK7ArEjesbgoDuCarGWQ4Vnc6w3TU3S0ZyubtE5H
q/wrt/numUfwJiT8ofJpktEopK0ovr3Bu78x+BNXGoiyRAtaxpCX9GF8rumDsXVl
w1Bhb47fA4WH8Z2QBF4dlaPdKYUXawh2U4InEsqHwOSsoehLu1M5pVQ+rt09+1B2
aXCeCoLNEk0UWYUAtocAl/Uxi0adJL/C6NEq6TrZ5l4dQ5VOfQhfddisNAum4h2E
FaS2/n3L5pzp3+oESLHjS8D0k6VTSNemOmR3KCBye/biWb3bM4E=
=CaHN
-----END PGP SIGNATURE-----

--rcSWnUvkTeCkS+1Q--
