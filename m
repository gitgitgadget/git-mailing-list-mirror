Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAB0F20B807
	for <git@vger.kernel.org>; Thu,  6 Mar 2025 15:10:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741273838; cv=none; b=WI9U/Hh5RZfnxhN6qEI/Co2gCtWuDpfEI4PdU8UnvhQjG3FqTaQUyPHb+NEfqr21PrwlQdfszxa3xQlQT3XuF8rjXxNEJqDfE66k+xLwQSeT8f/bUTssYK/BbGnSiE/AdPVS+v8oiS+U6NClPdZJUPATrlRzp4u4OwVYXlGTCXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741273838; c=relaxed/simple;
	bh=NUPkIfKcdY1+rP1MUn/O6u6IE9CKsTCDaAqTmZjojsY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=PQfOMK0ALdI6UERXNfIEasDJqIU6QYFtOW1CDNj+ya+LCRgDDKtAQJh6wQWA/2G8f4Hh+aqe/53mgD4WtlpLaX85BcshMiL21QfF6IrOebJe1spqOQafCoCRLWjQOESLvL+JyFPdRDiHJ5+cngdxIm5kZhaMeGY+vVFrmzj0qZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=IRq9MiJV; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Xj/K14TS; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="IRq9MiJV";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Xj/K14TS"
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfhigh.stl.internal (Postfix) with ESMTP id E002125401F4;
	Thu,  6 Mar 2025 10:10:35 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-12.internal (MEProxy); Thu, 06 Mar 2025 10:10:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1741273835;
	 x=1741360235; bh=GVZJV4s3dD5CuPfTB/7DxWlPVI525MWV5jUYW3VtRR4=; b=
	IRq9MiJVX7sE0gcFN3dQlj4+p4KWgIjenC4MNhqQJ8f35AJBT67xzejesHoJTZ00
	Dany+kwxhd6x0bnNc5ZUc6NVip7IsYPeZMTRC6iCFSJGYLz+xKAcv+gwrTctEu4a
	iPvwIf+x1rGHTUvgyXqbk8qrC0x+hTvxRk6Oki/SEp8g+4cgOCKVYry4KIbtZoZ9
	yR+kci9V2GbXreZL0Us5sDQ7QjbYQicHfkOgFaD6MDYVVasTroXiwe1oYRSOpApw
	g5uPl0M//+AjHK3TSGFUg7gprx92G+S3Yp3VsR7J9xZw1GdS5AdtJctRvOzF8qKZ
	RQlfroelaIjqrIu2jhY4pA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1741273835; x=
	1741360235; bh=GVZJV4s3dD5CuPfTB/7DxWlPVI525MWV5jUYW3VtRR4=; b=X
	j/K14TSwke0N3vGqeEWMFLMyP8mBkVNJFfHPKPZQWA60KAn8fE8w/bKoR4mvbxxQ
	cJgxoZwu5+OtqfhXJYdEGWeqGO1HqvDyKjyTbZjmCKfL/cDsqH8I7tO/6zFUmcdu
	1sWuSsB5lJ2zQ/UOwLpE5D8gQsh4PLWeOz6FjYTViivFPi+mufUHbC/3TywoTv2y
	6/ncy5V6rJzOj6MksiBv117MyI7yIa4duHsZxRmNLOFDtokUhtoujOqVI4c+zJZo
	B0LZIhmX/tss8+NuinUqT3Er+KXORYIaLcwEqJYD1uZkq5cD3ljvbTHyMEJiwuN0
	9VdVxNm5NIpwqYkKZoYGw==
X-ME-Sender: <xms:67rJZ8wIfLGJLU8wiO3UWT15zj7mcI6zx6Mmb5xiyXBgZ3Hw0rf4bA>
    <xme:67rJZwQjvU1ts2tsJ-4CarvfygARkifxqCg76wwR02kJ83xM1CkDey2r7ApVsaAlH
    t4LGhwQykNKNkBmkQ>
X-ME-Received: <xmr:67rJZ-XYDb7GdogfeZMXAAriIgZG6AT6Nms947iJD08nuvaDO4vnP15pZzGkt8qo71grd8MjTeaAbOv0TQGkuoAs0HTIOhpazUmqKFHPaoowCA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddutdektdekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertder
    tdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhksh
    drihhmqeenucggtffrrghtthgvrhhnpeffueeiudejvdekheeuvdekfeffiedvueelteek
    udehjeetkeegvddugfdtgfeileenucevlhhushhtvghrufhiiigvpeeinecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeefpdhmohgu
    vgepshhmthhpohhuthdprhgtphhtthhopehjlhhtohgslhgvrhesghhmrghilhdrtghomh
    dprhgtphhtthhopehkrghrthhhihhkrddukeeksehgmhgrihhlrdgtohhmpdhrtghpthht
    ohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:67rJZ6iDwirbGpPNCfpAu_dey9zGEMCkb_9P4ukZpZ_9HTeS3nPaog>
    <xmx:67rJZ-DCPkKUclcF1X8Sg3t7Ir6gkQs7nh4tXt4bH65QNJ9e55q5sg>
    <xmx:67rJZ7LVNP9ow0q_z8zj2lLZKP7-B_nQGv1vXtqdH326A6hpLuJktw>
    <xmx:67rJZ1B6MvB0-yQ0mnrxURRyYn68OItpwtHGI3pWrkb6bSg-TQ-IYA>
    <xmx:67rJZ5N_6wxERJJo97WGbXYGBHyHd3nsOJbV_YqLt5eF7TzUDoOIRo4X>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 6 Mar 2025 10:10:34 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 0ad68c87 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 6 Mar 2025 15:10:31 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 06 Mar 2025 16:10:27 +0100
Subject: [PATCH v2 03/12] pack-write: stop depending on `the_repository`
 and `the_hash_algo`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250306-b4-pks-objects-without-the-repository-v2-3-f3465327be69@pks.im>
References: <20250306-b4-pks-objects-without-the-repository-v2-0-f3465327be69@pks.im>
In-Reply-To: <20250306-b4-pks-objects-without-the-repository-v2-0-f3465327be69@pks.im>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, 
 Justin Tobler <jltobler@gmail.com>
X-Mailer: b4 0.14.2

There are a couple of functions in "pack-write.c" that implicitly depend
on `the_repository` or `the_hash_algo`. Remove this dependency by
injecting the repository via a parameter and adapt callers accordingly.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/fast-import.c  |  2 +-
 builtin/index-pack.c   |  4 ++--
 builtin/pack-objects.c |  4 ++--
 bulk-checkin.c         |  4 ++--
 midx-write.c           |  2 +-
 pack-write.c           | 55 +++++++++++++++++++++++++-------------------------
 pack.h                 | 11 +++++-----
 7 files changed, 41 insertions(+), 41 deletions(-)

diff --git a/builtin/fast-import.c b/builtin/fast-import.c
index 86e6e754816..e1758aa9514 100644
--- a/builtin/fast-import.c
+++ b/builtin/fast-import.c
@@ -798,7 +798,7 @@ static const char *create_index(void)
 	if (c != last)
 		die("internal consistency error creating the index");
 
-	tmpfile = write_idx_file(the_hash_algo, NULL, idx, object_count,
+	tmpfile = write_idx_file(the_repository, NULL, idx, object_count,
 				 &pack_idx_opts, pack_data->hash);
 	free(idx);
 	return tmpfile;
diff --git a/builtin/index-pack.c b/builtin/index-pack.c
index 1268032d769..174e03afa61 100644
--- a/builtin/index-pack.c
+++ b/builtin/index-pack.c
@@ -2088,10 +2088,10 @@ int cmd_index_pack(int argc,
 	ALLOC_ARRAY(idx_objects, nr_objects);
 	for (i = 0; i < nr_objects; i++)
 		idx_objects[i] = &objects[i].idx;
-	curr_index = write_idx_file(the_hash_algo, index_name, idx_objects,
+	curr_index = write_idx_file(the_repository, index_name, idx_objects,
 				    nr_objects, &opts, pack_hash);
 	if (rev_index)
-		curr_rev_index = write_rev_file(the_hash_algo, rev_index_name,
+		curr_rev_index = write_rev_file(the_repository, rev_index_name,
 						idx_objects, nr_objects,
 						pack_hash, opts.flags);
 	free(idx_objects);
diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index c3adbc94504..e05dfc4021e 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -1314,7 +1314,7 @@ static void write_pack_file(void)
 			f = hashfd_throughput(the_repository->hash_algo, 1,
 					      "<stdout>", progress_state);
 		else
-			f = create_tmp_packfile(&pack_tmp_name);
+			f = create_tmp_packfile(the_repository, &pack_tmp_name);
 
 		offset = write_pack_header(f, nr_remaining);
 
@@ -1407,7 +1407,7 @@ static void write_pack_file(void)
 			if (cruft)
 				pack_idx_opts.flags |= WRITE_MTIMES;
 
-			stage_tmp_packfiles(the_hash_algo, &tmpname,
+			stage_tmp_packfiles(the_repository, &tmpname,
 					    pack_tmp_name, written_list,
 					    nr_written, &to_pack,
 					    &pack_idx_opts, hash,
diff --git a/bulk-checkin.c b/bulk-checkin.c
index 20f2da67b93..23ac00ea0a6 100644
--- a/bulk-checkin.c
+++ b/bulk-checkin.c
@@ -44,7 +44,7 @@ static void finish_tmp_packfile(struct strbuf *basename,
 {
 	char *idx_tmp_name = NULL;
 
-	stage_tmp_packfiles(the_hash_algo, basename, pack_tmp_name,
+	stage_tmp_packfiles(the_repository, basename, pack_tmp_name,
 			    written_list, nr_written, NULL, pack_idx_opts, hash,
 			    &idx_tmp_name);
 	rename_tmp_packfile_idx(basename, &idx_tmp_name);
@@ -244,7 +244,7 @@ static void prepare_to_stream(struct bulk_checkin_packfile *state,
 	if (!(flags & HASH_WRITE_OBJECT) || state->f)
 		return;
 
-	state->f = create_tmp_packfile(&state->pack_tmp_name);
+	state->f = create_tmp_packfile(the_repository, &state->pack_tmp_name);
 	reset_pack_idx_option(&state->pack_idx_opts);
 
 	/* Pretend we are going to write only one object */
diff --git a/midx-write.c b/midx-write.c
index ac80a8298ed..a628ac24dcb 100644
--- a/midx-write.c
+++ b/midx-write.c
@@ -658,7 +658,7 @@ static void write_midx_reverse_index(char *midx_name, unsigned char *midx_hash,
 	strbuf_addf(&buf, "%s-%s.rev", midx_name, hash_to_hex_algop(midx_hash,
 								    ctx->repo->hash_algo));
 
-	tmp_file = write_rev_file_order(ctx->repo->hash_algo, NULL, ctx->pack_order,
+	tmp_file = write_rev_file_order(ctx->repo, NULL, ctx->pack_order,
 					ctx->entries_nr, midx_hash, WRITE_REV);
 
 	if (finalize_object_file(tmp_file, buf.buf))
diff --git a/pack-write.c b/pack-write.c
index 5eb89f44cf4..6b06315f80a 100644
--- a/pack-write.c
+++ b/pack-write.c
@@ -1,5 +1,3 @@
-#define USE_THE_REPOSITORY_VARIABLE
-
 #include "git-compat-util.h"
 #include "environment.h"
 #include "gettext.h"
@@ -56,7 +54,7 @@ static int need_large_offset(off_t offset, const struct pack_idx_option *opts)
  * The *sha1 contains the pack content SHA1 hash.
  * The objects array passed in will be sorted by SHA1 on exit.
  */
-const char *write_idx_file(const struct git_hash_algo *hash_algo,
+const char *write_idx_file(struct repository *repo,
 			   const char *index_name, struct pack_idx_entry **objects,
 			   int nr_objects, const struct pack_idx_option *opts,
 			   const unsigned char *sha1)
@@ -82,7 +80,7 @@ const char *write_idx_file(const struct git_hash_algo *hash_algo,
 
 	if (opts->flags & WRITE_IDX_VERIFY) {
 		assert(index_name);
-		f = hashfd_check(the_repository->hash_algo, index_name);
+		f = hashfd_check(repo->hash_algo, index_name);
 	} else {
 		if (!index_name) {
 			struct strbuf tmp_file = STRBUF_INIT;
@@ -92,7 +90,7 @@ const char *write_idx_file(const struct git_hash_algo *hash_algo,
 			unlink(index_name);
 			fd = xopen(index_name, O_CREAT|O_EXCL|O_WRONLY, 0600);
 		}
-		f = hashfd(the_repository->hash_algo, fd, index_name);
+		f = hashfd(repo->hash_algo, fd, index_name);
 	}
 
 	/* if last object's offset is >= 2^31 we should use index V2 */
@@ -131,7 +129,7 @@ const char *write_idx_file(const struct git_hash_algo *hash_algo,
 		struct pack_idx_entry *obj = *list++;
 		if (index_version < 2)
 			hashwrite_be32(f, obj->offset);
-		hashwrite(f, obj->oid.hash, hash_algo->rawsz);
+		hashwrite(f, obj->oid.hash, repo->hash_algo->rawsz);
 		if ((opts->flags & WRITE_IDX_STRICT) &&
 		    (i && oideq(&list[-2]->oid, &obj->oid)))
 			die("The same object %s appears twice in the pack",
@@ -173,7 +171,7 @@ const char *write_idx_file(const struct git_hash_algo *hash_algo,
 		}
 	}
 
-	hashwrite(f, sha1, hash_algo->rawsz);
+	hashwrite(f, sha1, repo->hash_algo->rawsz);
 	finalize_hashfile(f, NULL, FSYNC_COMPONENT_PACK_METADATA,
 			  CSUM_HASH_IN_STREAM | CSUM_CLOSE |
 			  ((opts->flags & WRITE_IDX_VERIFY) ? 0 : CSUM_FSYNC));
@@ -217,7 +215,7 @@ static void write_rev_trailer(const struct git_hash_algo *hash_algo,
 	hashwrite(f, hash, hash_algo->rawsz);
 }
 
-char *write_rev_file(const struct git_hash_algo *hash_algo,
+char *write_rev_file(struct repository *repo,
 		     const char *rev_name,
 		     struct pack_idx_entry **objects,
 		     uint32_t nr_objects,
@@ -236,7 +234,7 @@ char *write_rev_file(const struct git_hash_algo *hash_algo,
 		pack_order[i] = i;
 	QSORT_S(pack_order, nr_objects, pack_order_cmp, objects);
 
-	ret = write_rev_file_order(hash_algo, rev_name, pack_order, nr_objects,
+	ret = write_rev_file_order(repo, rev_name, pack_order, nr_objects,
 				   hash, flags);
 
 	free(pack_order);
@@ -244,7 +242,7 @@ char *write_rev_file(const struct git_hash_algo *hash_algo,
 	return ret;
 }
 
-char *write_rev_file_order(const struct git_hash_algo *hash_algo,
+char *write_rev_file_order(struct repository *repo,
 			   const char *rev_name,
 			   uint32_t *pack_order,
 			   uint32_t nr_objects,
@@ -268,7 +266,7 @@ char *write_rev_file_order(const struct git_hash_algo *hash_algo,
 			fd = xopen(rev_name, O_CREAT|O_EXCL|O_WRONLY, 0600);
 			path = xstrdup(rev_name);
 		}
-		f = hashfd(the_repository->hash_algo, fd, path);
+		f = hashfd(repo->hash_algo, fd, path);
 	} else if (flags & WRITE_REV_VERIFY) {
 		struct stat statbuf;
 		if (stat(rev_name, &statbuf)) {
@@ -278,18 +276,18 @@ char *write_rev_file_order(const struct git_hash_algo *hash_algo,
 			} else
 				die_errno(_("could not stat: %s"), rev_name);
 		}
-		f = hashfd_check(the_repository->hash_algo, rev_name);
+		f = hashfd_check(repo->hash_algo, rev_name);
 		path = xstrdup(rev_name);
 	} else {
 		return NULL;
 	}
 
-	write_rev_header(hash_algo, f);
+	write_rev_header(repo->hash_algo, f);
 
 	write_rev_index_positions(f, pack_order, nr_objects);
-	write_rev_trailer(hash_algo, f, hash);
+	write_rev_trailer(repo->hash_algo, f, hash);
 
-	if (adjust_shared_perm(the_repository, path) < 0)
+	if (adjust_shared_perm(repo, path) < 0)
 		die(_("failed to make %s readable"), path);
 
 	finalize_hashfile(f, NULL, FSYNC_COMPONENT_PACK_METADATA,
@@ -330,7 +328,7 @@ static void write_mtimes_trailer(const struct git_hash_algo *hash_algo,
 	hashwrite(f, hash, hash_algo->rawsz);
 }
 
-static char *write_mtimes_file(const struct git_hash_algo *hash_algo,
+static char *write_mtimes_file(struct repository *repo,
 			       struct packing_data *to_pack,
 			       struct pack_idx_entry **objects,
 			       uint32_t nr_objects,
@@ -346,13 +344,13 @@ static char *write_mtimes_file(const struct git_hash_algo *hash_algo,
 
 	fd = odb_mkstemp(&tmp_file, "pack/tmp_mtimes_XXXXXX");
 	mtimes_name = strbuf_detach(&tmp_file, NULL);
-	f = hashfd(the_repository->hash_algo, fd, mtimes_name);
+	f = hashfd(repo->hash_algo, fd, mtimes_name);
 
-	write_mtimes_header(hash_algo, f);
+	write_mtimes_header(repo->hash_algo, f);
 	write_mtimes_objects(f, to_pack, objects, nr_objects);
-	write_mtimes_trailer(hash_algo, f, hash);
+	write_mtimes_trailer(repo->hash_algo, f, hash);
 
-	if (adjust_shared_perm(the_repository, mtimes_name) < 0)
+	if (adjust_shared_perm(repo, mtimes_name) < 0)
 		die(_("failed to make %s readable"), mtimes_name);
 
 	finalize_hashfile(f, NULL, FSYNC_COMPONENT_PACK_METADATA,
@@ -527,14 +525,15 @@ int encode_in_pack_object_header(unsigned char *hdr, int hdr_len,
 	return n;
 }
 
-struct hashfile *create_tmp_packfile(char **pack_tmp_name)
+struct hashfile *create_tmp_packfile(struct repository *repo,
+				     char **pack_tmp_name)
 {
 	struct strbuf tmpname = STRBUF_INIT;
 	int fd;
 
 	fd = odb_mkstemp(&tmpname, "pack/tmp_pack_XXXXXX");
 	*pack_tmp_name = strbuf_detach(&tmpname, NULL);
-	return hashfd(the_repository->hash_algo, fd, *pack_tmp_name);
+	return hashfd(repo->hash_algo, fd, *pack_tmp_name);
 }
 
 static void rename_tmp_packfile(struct strbuf *name_prefix, const char *source,
@@ -555,7 +554,7 @@ void rename_tmp_packfile_idx(struct strbuf *name_buffer,
 	rename_tmp_packfile(name_buffer, *idx_tmp_name, "idx");
 }
 
-void stage_tmp_packfiles(const struct git_hash_algo *hash_algo,
+void stage_tmp_packfiles(struct repository *repo,
 			 struct strbuf *name_buffer,
 			 const char *pack_tmp_name,
 			 struct pack_idx_entry **written_list,
@@ -568,19 +567,19 @@ void stage_tmp_packfiles(const struct git_hash_algo *hash_algo,
 	char *rev_tmp_name = NULL;
 	char *mtimes_tmp_name = NULL;
 
-	if (adjust_shared_perm(the_repository, pack_tmp_name))
+	if (adjust_shared_perm(repo, pack_tmp_name))
 		die_errno("unable to make temporary pack file readable");
 
-	*idx_tmp_name = (char *)write_idx_file(hash_algo, NULL, written_list,
+	*idx_tmp_name = (char *)write_idx_file(repo, NULL, written_list,
 					       nr_written, pack_idx_opts, hash);
-	if (adjust_shared_perm(the_repository, *idx_tmp_name))
+	if (adjust_shared_perm(repo, *idx_tmp_name))
 		die_errno("unable to make temporary index file readable");
 
-	rev_tmp_name = write_rev_file(hash_algo, NULL, written_list, nr_written,
+	rev_tmp_name = write_rev_file(repo, NULL, written_list, nr_written,
 				      hash, pack_idx_opts->flags);
 
 	if (pack_idx_opts->flags & WRITE_MTIMES) {
-		mtimes_tmp_name = write_mtimes_file(hash_algo, to_pack,
+		mtimes_tmp_name = write_mtimes_file(repo, to_pack,
 						    written_list, nr_written,
 						    hash);
 	}
diff --git a/pack.h b/pack.h
index 9f1194ac13d..5d4393eaffe 100644
--- a/pack.h
+++ b/pack.h
@@ -87,7 +87,7 @@ struct progress;
 /* Note, the data argument could be NULL if object type is blob */
 typedef int (*verify_fn)(const struct object_id *, enum object_type, unsigned long, void*, int*);
 
-const char *write_idx_file(const struct git_hash_algo *hash_algo,
+const char *write_idx_file(struct repository *repo,
 			   const char *index_name,
 			   struct pack_idx_entry **objects,
 			   int nr_objects,
@@ -106,13 +106,13 @@ struct ref;
 
 void write_promisor_file(const char *promisor_name, struct ref **sought, int nr_sought);
 
-char *write_rev_file(const struct git_hash_algo *hash_algo,
+char *write_rev_file(struct repository *repo,
 		     const char *rev_name,
 		     struct pack_idx_entry **objects,
 		     uint32_t nr_objects,
 		     const unsigned char *hash,
 		     unsigned flags);
-char *write_rev_file_order(const struct git_hash_algo *hash_algo,
+char *write_rev_file_order(struct repository *repo,
 			   const char *rev_name,
 			   uint32_t *pack_order,
 			   uint32_t nr_objects,
@@ -134,8 +134,9 @@ int read_pack_header(int fd, struct pack_header *);
 
 struct packing_data;
 
-struct hashfile *create_tmp_packfile(char **pack_tmp_name);
-void stage_tmp_packfiles(const struct git_hash_algo *hash_algo,
+struct hashfile *create_tmp_packfile(struct repository *repo,
+				     char **pack_tmp_name);
+void stage_tmp_packfiles(struct repository *repo,
 			 struct strbuf *name_buffer,
 			 const char *pack_tmp_name,
 			 struct pack_idx_entry **written_list,

-- 
2.49.0.rc0.416.g627208d89d.dirty

