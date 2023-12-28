Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C32926FAD
	for <git@vger.kernel.org>; Thu, 28 Dec 2023 06:27:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="dJHQ6f7d";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="261B/Fwi"
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailout.nyi.internal (Postfix) with ESMTP id 1C9F25C00F1;
	Thu, 28 Dec 2023 01:27:48 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Thu, 28 Dec 2023 01:27:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1703744868; x=1703831268; bh=nb3MQ5PZNp
	AiksuxTFVWdTlCNoJbEoQ2XuX6vLeWoG8=; b=dJHQ6f7dkw+QNIWmgBinxEvrEQ
	gI+fBp/02o5QU4X/5FJi3CfBzlcaiZsFbzoLbiLRgxBbwzsMuTEoWR0tUMg7gY9q
	kC+17KUMc39qZ25rdurSRQ0VEcBb6jwWXh2AA+aDIapUT7MKsjFkGcoiwSxrO6Y0
	NBQrxrbJGnoauVHbTSZKcC4NjuKRXy2G0CQMgKCnj1OWItg+A4vFGdqFTOJs8QKo
	2TJe4Itxj7h0mUnEAPqKdSUfvSvup6yQCv3HbSpbDu7JCj+FOs3fg0OTSwowET1i
	ZoGVG9Jd+SJ/NrmZ7EXhvDQnp+j5EmHiRexY++4nbE46EMdkm5PxjUiFRuzQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1703744868; x=1703831268; bh=nb3MQ5PZNpAiksuxTFVWdTlCNoJb
	EoQ2XuX6vLeWoG8=; b=261B/FwitKOPzDsjWAD63l9xQaLJfHSc5ksCFEXDf3QL
	/E/h8t0bZ2NF47c3scO0E0GpSbqtV6smGxFvtNPfRF0UJPK/KaaaafsyMGsSy0Wk
	S5RgdGmEpWiUqw2TbcpoyC6Bqgo7SAH2sKH4icdoEYKucJ5L7gheIZ/rj843PbKs
	zNNTAY+9dVkQL46yiuUcLsVwCIwmjD6mgGfwIwBPZuyrXitVJqne368BrKKaWPgY
	vlSXo5iLHG7zQjims/aovOLNr/zFRC8+v5X+rjSIqSN/DTIevl5ust2QiuYSdRgX
	anbDP/epwHeSeQH3LBskaN6uXS+3nBnZmuhnOHji/A==
X-ME-Sender: <xms:YxWNZYhrgEwHnxB5Eox-yDlevxr0_KOGdzaoqHEjT88_zkGJmW36Pg>
    <xme:YxWNZRAVoEzsIjA2gzzY58ebafWhpf5UFD38RCY1pRkACXnZGN6YWLjYODT94BN3B
    KbqLub4UdkejYGczA>
X-ME-Received: <xmr:YxWNZQGwNbUWmzCGBIvFI2yXNF2yXXPW9DxmokSA9b-k2ZNHyvR5evsTglCJRvtaDSy1OXnqo7w1fqh7g5yNyJ0LVbiQzYP-KIR-dFdzvg5qIw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvdeftddgleejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehgtd
    erredttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshes
    phhkshdrihhmqeenucggtffrrghtthgvrhhnpeeukedtvedtffevleejtefgheehieegke
    eluddvfeefgeehgfeltddtheejleffteenucevlhhushhtvghrufhiiigvpedvnecurfgr
    rhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:YxWNZZRCzMeUr_PE_VKmVUCVqT842TcKuefF_08S5yUr8te_Kr8HXg>
    <xmx:YxWNZVwVfYpWMBZspGRiOqQ80pleFeF6oKneN4DlbL9r-DCftlbdYg>
    <xmx:YxWNZX5cKVIFnVA6V2qVKwkmKm29E4S93z6kceY2HsOMWN4QfWM9oA>
    <xmx:ZBWNZWqMaUVM33J934e42bS8-hKlytbJYKaBcQOyceNOmXGsR9C5nQ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 28 Dec 2023 01:27:47 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id c6224cac (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 28 Dec 2023 06:25:33 +0000 (UTC)
Date: Thu, 28 Dec 2023 07:27:45 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Han-Wen Nienhuys <hanwenn@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 3/8] reftable/writer: fix index corruption when writing
 multiple indices
Message-ID: <c00e08d97fc71f0c879082291899ec0d47e885e3.1703743174.git.ps@pks.im>
References: <cover.1703063544.git.ps@pks.im>
 <cover.1703743174.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="x9K6mwFCjhGykAnb"
Content-Disposition: inline
In-Reply-To: <cover.1703743174.git.ps@pks.im>


--x9K6mwFCjhGykAnb
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


--x9K6mwFCjhGykAnb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmWNFWAACgkQVbJhu7ck
PpTkvhAAmaF42yqAI9vIagEbN99itTUri2gFaEAIKdC0FYAQcaO7/aQBckboxTEy
oaPNxpNZzgmgRYZpsK8yzHVOcXBVZx4M2Bkxmftz/bkMxn5bEVfOTOQaqKozmh3J
8X5aUOG9KbZ47Wut04lHSSXQ1Cd2vwYBh7od3jUIw091cas9zELdriujA3rXjcJg
s1y+JwtO6vNzg5K01yGtuYfBf46QLTC2Uflo8wNsnWl7VUsTXv19yTeNgyw8Nhgu
I/659SInXvUgiN1Faj9NrWjDHgw3TaxWhLQLcPsYXYwSjpqJ85DI0h4v2ciX+tCD
I6eGsSFj09Yu/1l78csgaNmTVC7jJa/m7kXRjz8fW7rsA0BCSgij5PP+wUYBArWS
03Peala0pGFNXXweo4sTE3kmF1EInu9D9x8rQd5EOqwnik4zwjmrP2/66pADnNQk
IxNRVnWHdOwHOfZig0W7G/QKaW2Z/nuLpK9SS3RcD0aM2Pr2H41SZP2bm9NqXXfS
Op+SM5/JUuwf4oFQyEtptPeuJHrmyIxkAzvrRqJIOJWWaDgwSagBY0u0LRfQ2fwN
SgCpm9QuqaKnTYsK6/32Y+OXAB3eHWTon0DNmpL+7K0jxLuILsez2CWYt6upJ6DK
4Kdt/B+M45ld+1go/Qov+gvBxVdZCUuBNFB3XdpsclcvsIFoHVI=
=axfy
-----END PGP SIGNATURE-----

--x9K6mwFCjhGykAnb--
