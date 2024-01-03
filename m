Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC686182AB
	for <git@vger.kernel.org>; Wed,  3 Jan 2024 06:22:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="wsGXED8c";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="nyfcYIe1"
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailout.nyi.internal (Postfix) with ESMTP id E13515C019A;
	Wed,  3 Jan 2024 01:22:23 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Wed, 03 Jan 2024 01:22:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1704262943; x=1704349343; bh=mYs4vHIgO/
	0zSHx3I0dlaP7G/uteq0iLRfRgKMzBe1g=; b=wsGXED8ck82yxrngS/Du9u2TZ/
	ORYQTvoPeUh+rDBO23TgXXtj4R5Wpkidduih2WxRmWcilShulTKak06HYiGQcOVs
	7KaqJRECP+1ajwqDfO2d9s8aIXxhhmb3SKhMhmu0ScWgLME0qQ6iJXgHV1GbjTf8
	Nxu1fWGUWxmIdCx057XKvn1MhgUUCdaiVStfljUvbHMnKh+7LQcC/f7rHWifuSeY
	8I/HLivUeSxoXIFxiOCYFqIJ4qboZ284YEnwBtNoRZGkkwk0qXFUTqj1OiIeuR0H
	BDiCmr08brkZ858aCAmFDj7O2BnIqjcqzn78P6SufcFc5O4WHzvedqY5Y3fw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1704262943; x=1704349343; bh=mYs4vHIgO/0zSHx3I0dlaP7G/ute
	q0iLRfRgKMzBe1g=; b=nyfcYIe1wFAvrteSrluBTO0M0EfBvsd49q92WgHMVQ0l
	NIqvZTrFC6YI43r8ibYoAIcDLYnuBNsf95ZUZ5gd0h8yz+qiiRbH5A16t5K6pleY
	Di0L2/8QlYul7cUM31UigabPYWNKStHqHC7wYkY4+hmIhMeXx8KGmMVeLk7Tjy8O
	mTC2sl6fou5c6Yp2KLM5IRrp4SENjvUbfTuLuqiqEu0Hx4LU2uhp++GH2czT1HbR
	ue+eqhKjnURIXmZ8ymL8QuzFdXBjBi3FJYo+jvODAhMn2CsQfVPKYCna4WavIXmR
	e/qnHbSVOiiYxcpl9b74kl61PvxVIrP0ooRqpQ88yw==
X-ME-Sender: <xms:H_2UZVb-owO8qGbv-7XbKmyU_BD6evxHsR4_OIiCiYmCuX5_kQfkjg>
    <xme:H_2UZcaqkjacwmDcKbmzSc5FIN34iHb_wZfpIamsl3kIOpemnSCOhGSse-2n4GizI
    flFH8-GmWsk183xBA>
X-ME-Received: <xmr:H_2UZX_yyBs68THsJwq1D4mr66SghlAL30CGQQsIgoCHYi4xY9tr7Eii0X8q-1JbS4CU3MQ48lreErM2O2hPlmpnYts44sRDfXLiYA3PzyMnjg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvdeggedgleeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehgtd
    erredttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshes
    phhkshdrihhmqeenucggtffrrghtthgvrhhnpeeukedtvedtffevleejtefgheehieegke
    eluddvfeefgeehgfeltddtheejleffteenucevlhhushhtvghrufhiiigvpedtnecurfgr
    rhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:H_2UZTrGZFKKKOqOQAHykKK9sEffsXSWls-Y_xTUNgpv4hyUbhvwTw>
    <xmx:H_2UZQpHvOT9qhhWgKzIa1Q8rMgJ9LHL3W6YBQ1zpX9GcU0NqovzqQ>
    <xmx:H_2UZZTXGzanF8X3i0feBvo7t9Mrf-LUV5yG9o4kuws0lC6nDhmS3w>
    <xmx:H_2UZdCe1P2SZJfpVlpRMbuuXzUzjjk3XaNPpX7bG6V3kzNc1V-b_g>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 3 Jan 2024 01:22:22 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 6fbe14de (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 3 Jan 2024 06:19:57 +0000 (UTC)
Date: Wed, 3 Jan 2024 07:22:21 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Han-Wen Nienhuys <hanwenn@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 3/8] reftable/writer: fix index corruption when writing
 multiple indices
Message-ID: <15e12b8f2904cc879498c344945f3f6380c0aa86.1704262787.git.ps@pks.im>
References: <cover.1703063544.git.ps@pks.im>
 <cover.1704262787.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="pD5ftKTD8kiLuKDu"
Content-Disposition: inline
In-Reply-To: <cover.1704262787.git.ps@pks.im>


--pD5ftKTD8kiLuKDu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Each reftable may contain multiple types of blocks for refs, objects and
reflog records, where each of these may have an index that makes it more
efficient to find the records. It was observed that the index for log
records can become corrupted under certain circumstances, where the
first entry of the index points into the object index instead of to the
log records.

As it turns out, this corruption can occur whenever we write a log index
as well as at least one additional index. Writing records and their index
is basically a two-step process:

  1. We write all blocks for the corresponding record. Each block that
     gets written is added to a list of blocks to index.

  2. Once all blocks were written we finish the section. If at least two
     blocks have been added to the list of blocks to index then we will
     now write the index for those blocks and flush it, as well.

When we have a very large number of blocks then we may decide to write a
multi-level index, which is why we also keep track of the list of the
index blocks in the same way as we previously kept track of the blocks
to index.

Now when we have finished writing all index blocks we clear the index
and flush the last block to disk. This is done in the wrong order though
because flushing the block to disk will re-add it to the list of blocks
to be indexed. The result is that the next section we are about to write
will have an entry in the list of blocks to index that points to the
last block of the preceding section's index, which will corrupt the log
index.

Fix this corruption by clearing the index after having written the last
block.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 reftable/readwrite_test.c | 80 +++++++++++++++++++++++++++++++++++++++
 reftable/writer.c         |  4 +-
 2 files changed, 82 insertions(+), 2 deletions(-)

diff --git a/reftable/readwrite_test.c b/reftable/readwrite_test.c
index 278663f22d..9c16e0504e 100644
--- a/reftable/readwrite_test.c
+++ b/reftable/readwrite_test.c
@@ -798,6 +798,85 @@ static void test_write_key_order(void)
 	strbuf_release(&buf);
 }
=20
+static void test_write_multiple_indices(void)
+{
+	struct reftable_write_options opts =3D {
+		.block_size =3D 100,
+	};
+	struct strbuf writer_buf =3D STRBUF_INIT, buf =3D STRBUF_INIT;
+	struct reftable_block_source source =3D { 0 };
+	struct reftable_iterator it =3D { 0 };
+	const struct reftable_stats *stats;
+	struct reftable_writer *writer;
+	struct reftable_reader *reader;
+	int err, i;
+
+	writer =3D reftable_new_writer(&strbuf_add_void, &writer_buf, &opts);
+	reftable_writer_set_limits(writer, 1, 1);
+	for (i =3D 0; i < 100; i++) {
+		unsigned char hash[GIT_SHA1_RAWSZ] =3D {i};
+		struct reftable_ref_record ref =3D {
+			.update_index =3D 1,
+			.value_type =3D REFTABLE_REF_VAL1,
+			.value.val1 =3D hash,
+		};
+
+		strbuf_reset(&buf);
+		strbuf_addf(&buf, "refs/heads/%04d", i);
+		ref.refname =3D buf.buf,
+
+		err =3D reftable_writer_add_ref(writer, &ref);
+		EXPECT_ERR(err);
+	}
+
+	for (i =3D 0; i < 100; i++) {
+		unsigned char hash[GIT_SHA1_RAWSZ] =3D {i};
+		struct reftable_log_record log =3D {
+			.update_index =3D 1,
+			.value_type =3D REFTABLE_LOG_UPDATE,
+			.value.update =3D {
+				.old_hash =3D hash,
+				.new_hash =3D hash,
+			},
+		};
+
+		strbuf_reset(&buf);
+		strbuf_addf(&buf, "refs/heads/%04d", i);
+		log.refname =3D buf.buf,
+
+		err =3D reftable_writer_add_log(writer, &log);
+		EXPECT_ERR(err);
+	}
+
+	reftable_writer_close(writer);
+
+	/*
+	 * The written data should be sufficiently large to result in indices
+	 * for each of the block types.
+	 */
+	stats =3D reftable_writer_stats(writer);
+	EXPECT(stats->ref_stats.index_offset > 0);
+	EXPECT(stats->obj_stats.index_offset > 0);
+	EXPECT(stats->log_stats.index_offset > 0);
+
+	block_source_from_strbuf(&source, &writer_buf);
+	err =3D reftable_new_reader(&reader, &source, "filename");
+	EXPECT_ERR(err);
+
+	/*
+	 * Seeking the log uses the log index now. In case there is any
+	 * confusion regarding indices we would notice here.
+	 */
+	err =3D reftable_reader_seek_log(reader, &it, "");
+	EXPECT_ERR(err);
+
+	reftable_iterator_destroy(&it);
+	reftable_writer_free(writer);
+	reftable_reader_free(reader);
+	strbuf_release(&writer_buf);
+	strbuf_release(&buf);
+}
+
 static void test_corrupt_table_empty(void)
 {
 	struct strbuf buf =3D STRBUF_INIT;
@@ -847,5 +926,6 @@ int readwrite_test_main(int argc, const char *argv[])
 	RUN_TEST(test_log_overflow);
 	RUN_TEST(test_write_object_id_length);
 	RUN_TEST(test_write_object_id_min_length);
+	RUN_TEST(test_write_multiple_indices);
 	return 0;
 }
diff --git a/reftable/writer.c b/reftable/writer.c
index 2e322a5683..ee4590e20f 100644
--- a/reftable/writer.c
+++ b/reftable/writer.c
@@ -432,12 +432,12 @@ static int writer_finish_section(struct reftable_writ=
er *w)
 		reftable_free(idx);
 	}
=20
-	writer_clear_index(w);
-
 	err =3D writer_flush_block(w);
 	if (err < 0)
 		return err;
=20
+	writer_clear_index(w);
+
 	bstats =3D writer_reftable_block_stats(w, typ);
 	bstats->index_blocks =3D w->stats.idx_stats.blocks - before_blocks;
 	bstats->index_offset =3D index_start;
--=20
2.43.GIT


--pD5ftKTD8kiLuKDu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmWU/RwACgkQVbJhu7ck
PpTcYA/8C4Q2J/KNNd0AGXyIIaWVqUkLWFSrrgtdsDogy0WVU8l/ZhYJXjG7pzMA
zJDsziUL65d70/6LPzxLudKlzxHpFSO3TfxKBYY+a0AMbbvewVwys3P0o8YwX8yW
i45i3AeWqxJKu7VtxPqCOeMGo7+xInAUIzoO+Px2EF0+joc2fxKx8aB0mkY5CZYI
2jMc+AsPZOfO4sriQfjfRQHWbOZc62/xbr6mQuRc2DuIPyuCAzW0+JIwrw/ekNUY
wlQBYHwoqt7n3yjPWWYojXIkmZthSFp04JyHnKOq3aZjwQZGZjCOKsDIf7oL/L7+
CBf7oymcPOESHSVjiayJTIi/jHS5gqUwno6+CpvRIj+Zm3r2ApjxHbZyXaTdxckh
WqKLGH/BwQVrDvFciHPObSPNcv8ORdHvthKr1YFUIFWeWv0IrGkpfJx12DWEE/Vx
3Y+7pwl3CYO9lHz44SDGC7jfE2iFmJrJ69VoCMUwn70EY5IJx+FwhCyAxBvfxVZ4
TOjC+WiOnQvNd0ms01Nl9Hv5mgd5iRxZrSHJthTmg58wFZqFSzdc7g4+/sWDMEhe
3e1+8k6f4R/qSZy9197+bNpvdoaNZYT75uKUd1HZvKPw+YDBhrGWMc2niK5wDQC8
IxqoI2mHrm0RWnAZXj9SW3vjaAxyMjscoxzdzrFETq7aYPVC7w4=
=obSr
-----END PGP SIGNATURE-----

--pD5ftKTD8kiLuKDu--
