Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59CAD1F92D
	for <git@vger.kernel.org>; Wed, 20 Dec 2023 09:17:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="IzZu8hpr";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="HNeAKkh1"
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailout.nyi.internal (Postfix) with ESMTP id 51CDE5C01DA
	for <git@vger.kernel.org>; Wed, 20 Dec 2023 04:17:12 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Wed, 20 Dec 2023 04:17:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1703063832; x=1703150232; bh=OwTrUkx6cu
	yCXOZbOedIuYeuZU8XX5iKo9cFe0omCTM=; b=IzZu8hprIcwwPTTrNIqKhUjhD7
	z3OhnByca6AUiWh8cp1jxV8ThVDMMDURQYjl/xitrRVSmDHGGMMwVBPAN9P9j6H/
	Y/b2r6YJGhTqBchtYeFPauEE/F2xYXBId+4jowBszjofNCPc/fB9S1mozpxwhR1B
	sQ6cZsAXErUcuR2Xko2Gbqv7qPPYuEeBTd2pHOfPbhg9pqyxhpmdI654MNcmpGXJ
	lnzsGE+4UDrCpAVP1gkIJS4CkMqlKKKNivheX++S8KUNhASL1etAdEbBsaNryLMw
	GzNVXeAoO7HIHgIo1MuMp2/nlIs/UfFT56atfG0HOpnS9Bo6S5VDuVm0+92g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1703063832; x=1703150232; bh=OwTrUkx6cuyCXOZbOedIuYeuZU8X
	X5iKo9cFe0omCTM=; b=HNeAKkh1jmhaj08LB6rUK8uFJK5ycq6JYD4hCbfniMjJ
	t5MD3GUtr6DsTNLgxCo+E6BmgbRH4dhtQ+cnLLyLQPpwlY2OzaXNVLnHcI8wj5zJ
	GQbXXK6z0yftUy3rBFZAwfB3EaTz525UivI/WaKfELiN684FERsjW0YwV/3B5MUR
	iTl6R17sSJyoWN8KdO9hlTDOqMEqcC8B9YOEB14aBwOoNpuyztHCxNi9lfKkin03
	tD5MQw9eFbhtbfw3FfqPChnCdSKrqShM3vHgkMxqaogL4FrDF2IkG7xtD7BMtQJG
	KRZVWAnlr9AI86Q6y29ZEHOLyeDzVNG398TXgpETsw==
X-ME-Sender: <xms:GLGCZVBN2nUDzooN_kWJE4hlapfvhQEUNAa9nWlOMzSVB-a9bJUuag>
    <xme:GLGCZTjnHj1okwQ9UL3oIKjspjVKCnZp4Mw5gh63HcsxMVsCcJLhevDkR04ohmekO
    YOFrhNtPg8lx2-Kpg>
X-ME-Received: <xmr:GLGCZQkb5Xjk7hPOkSkd88m3mdixn5W1MsffiMk0rTwfQ6NGSOpgpeOpsFTZ1_sJKHNkWihN0I06X-z2YFcbypy_qjpJ6m6x6osBT9JMIC6pjQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvdduvddgtdefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvuffkfhggtggujgesghdtre
    ertddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepheeghfdtfeeuffehkefgffduleffjedthf
    dvjeektdfhhedvlefgtefgvdettdfhnecuvehluhhsthgvrhfuihiivgeptdenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:GLGCZfwEBk8HXvDQCUDzGap3MY4l_DebQB8TVmvq3vO89v_ZmpxuwQ>
    <xmx:GLGCZaRLnmrp5oYD2P7GwQTVm7Bbq0FPxhXcNbDHNrIEde5AE0IsrA>
    <xmx:GLGCZSYpchFwWjEk_hA3vJ-qqQJOclTHe5mMiqLoUJSBqUMeyb2vYg>
    <xmx:GLGCZRPJc7XQ9ge4rd67coTVkYC0Bzfm1bKc9Gi8cITvbXz8Ujez2w>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Wed, 20 Dec 2023 04:17:11 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id c884e674 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Wed, 20 Dec 2023 09:15:16 +0000 (UTC)
Date: Wed, 20 Dec 2023 10:17:09 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Subject: [PATCH 2/7] reftable/writer: fix index corruption when writing
 multiple indices
Message-ID: <86ee79c48d599fee5e85bf88a17a59929ae1ecab.1703063544.git.ps@pks.im>
References: <cover.1703063544.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="YvqrZoMoxiF6jrMN"
Content-Disposition: inline
In-Reply-To: <cover.1703063544.git.ps@pks.im>


--YvqrZoMoxiF6jrMN
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


--YvqrZoMoxiF6jrMN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmWCsRQACgkQVbJhu7ck
PpSKRA/8CPny1zql86TMwnIFa1mR1btlOzbvaGmFvRquYdVGRvBsRbH5m4OMnpoC
g5DzERx/QhriYntSu8yUZEjqHz067s0zichmTi/UZBOxUMpUJsGjK6fz/2GCHWFl
X5lzCWn+NSRaowoLWlXJmsSx3Cbh2T9WURzp5lA9JUmz3/JZxbr6Bns2igw4ZI2w
Jzce63bRqk7Uk5mQ/RRCEK+HDqbXaVy48IhicUYXKqRk/eRDbfTsJ1ZjwekI4I0Y
CKST4VkeZ+qNkVSQf/wqieKwitxT1wbpPz1lGjVjYfwM16OW109gvUUqE4e3az23
CgShl+mlpksjX/+XlgY+nyoZHsbO1ByaxsOh2wZk8BAbne8QVRHLT8lDIMZ74CNc
erhW4WzviuCP/oEF0C3apSAiUK3oHQapli4gMMkhufAC8t+xaLN2movDtNqUOaRn
HA8KdXs4RKHQk6glxeopiHNjmQsdnwV7pmfi43DZTqxo7m+7ocbFTnKfw2Mjthf4
Iz9EUk2dJzrayLW8TR34GIqOI1wQIcjZqK60zcetgonm4wZrHUAcIkRg9bU/3A2w
pfvgWDBz4EcR0Aig91WXIBhr+wrRnSvHgSehT4K33Ym2LXdVO/ef6ZoNdNToAA7v
Qvyhx8dKwPZtO6AfITj20COTcQGQ9VntgzusgvB9cjto4KQwWiw=
=ysIZ
-----END PGP SIGNATURE-----

--YvqrZoMoxiF6jrMN--
