Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67A6213DDA0
	for <git@vger.kernel.org>; Thu,  6 Jun 2024 23:05:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717715115; cv=none; b=E4pNk4epMhOCze7WTI6im8a2WvloRKEbL584FSk6IcQRORCUobj9oBqttP+rHSp451TuSk86I2U40tfbmtP/a7+qvgWDz2ZivCi2WqjSauA2oS4dqqddgWWgHAGGOEuvRvdIzkx5J0rYyFLsIlXZEPiQUgPBmcX59x2QDdndrLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717715115; c=relaxed/simple;
	bh=JNOhloDyWt/qlRsBrqDVt8pYwr49wjr1RN5gg0EfUis=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PPoJE7LCQiMRQplY22M9K/tGlOP++T9lYP8uWYetaJ2kzR1SHIsWbvVgqdhgX6C0dPWaR982DGCK/vB0q70OOyWmWKntogQRujJ2cmapirn0+XwE5AuuVtDv2YLzUDfXrqosgwqbJP0n4gl4peYM7ZnRSpsjNdhrAU45ifZvYLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=none smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=eRL05wiT; arc=none smtp.client-ip=209.85.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="eRL05wiT"
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-6b04bacd1e1so8627296d6.0
        for <git@vger.kernel.org>; Thu, 06 Jun 2024 16:05:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1717715112; x=1718319912; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=QUBLukhQJGmKY3hKB7d8XLffYxaP3qSjJueq/wpsCXY=;
        b=eRL05wiTqCoH1aQygMmXr207UTE5lXxkKKmZzsBxqr24S8tl7qBxYnaib2W2ZG9HR9
         fiz+Lnm8eHNc3bgZoELVg2BBDXBbqcd90TkImaSp6W65DdKgaqxaxsDyR57XnCOcDJAj
         GcOoAcSVUI64D1Kp+VDirsXuwId34PgtfedOwPmLKmtzao2mpJugZgiDyiHdQzUOv4iZ
         +AUIq9cnx2YsJTozlt2yH/5Wmw7I5LkEKhVVQtaC9wuQXSMb99jbhfo+nXXzF7x0ztuo
         wSzUJezsgReYu1Avd3dU82Q0dXfV+GP4vOmVVCzIdTLpCh7/Z0pTkBSeyBgqLckeUl67
         RUCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717715112; x=1718319912;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QUBLukhQJGmKY3hKB7d8XLffYxaP3qSjJueq/wpsCXY=;
        b=bLVuWse6hLTUOVm7lDyZtNPcMIPKjPs+6JGm6QBirp6cLMtzB+P4zf9jy//b3N0ZK0
         mYBZdnPYMAs0jZ4zc3EcceY5V4V1bCydokdgv4vjXYDL695l+uJyLUMzJP40DvF9TOIT
         1q03ZeRdjDiga8kOMqFaFvqYc/0NOlHKzuMHOd454eg16PdcNgUG/IXM5Gi4by1866GN
         koGMOJL4SeGOFj/ZQF2LOI/qV1B4CWXM5Gp7UZQMCs+qo89q9AwIuXnmIuS2UtAaH/9o
         CBturF6ZwRKr8pEqxco4W5ruVjVv4d7bnkCOO740L+9kwC+ZF4eUDDmAUW4hAzpuuiB9
         0Iaw==
X-Gm-Message-State: AOJu0YwXIbLzCXMt1fCLTFUE0ZImbIM/0rYJnog5CuA2O7xhOrpQ8hyA
	bjdTTBv18vPCXdhLOcudmXrrWSRA7Q1HVL4fjmuOzDuJ07lZWNPrFJk2gHnjsel7m/z6XUTNLpD
	o0g8=
X-Google-Smtp-Source: AGHT+IFCd3aoBImaceulvWDcL+Jin6H5yNv1HsFEZYiuWiBlEmjATe5rdOXz3fvIrCSyOPZ5bXJa+w==
X-Received: by 2002:a05:6214:424d:b0:6b0:5aa6:9996 with SMTP id 6a1803df08f44-6b05aa6999amr6519076d6.24.1717715111899;
        Thu, 06 Jun 2024 16:05:11 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6b04fa3ad64sm10266736d6.142.2024.06.06.16.05.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jun 2024 16:05:11 -0700 (PDT)
Date: Thu, 6 Jun 2024 19:05:10 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Elijah Newren <newren@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 15/19] midx: support reading incremental MIDX chains
Message-ID: <28579fa29266b65c7c6b915678dff35f50cc051d.1717715060.git.me@ttaylorr.com>
References: <cover.1717715060.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1717715060.git.me@ttaylorr.com>

Now that the MIDX machinery's internals have been taught to understand
incremental MIDXs over the previous handful of commits, the MIDX
machinery itself can begin reading incremental MIDXs.

(Note that while the on-disk format for incremental MIDXs has been
defined, the writing end has not been implemented. This will take place
in the commit after next.)

The core of this change involves following the order specified in the
MIDX chain and opening up MIDXs in the chain one-by-one, adding them to
the previous layer's `->base_midx` pointer at each step.

In order to implement this, the `load_multi_pack_index()` function is
taught to call a new `load_multi_pack_index_chain()` function if loading
a non-incremental MIDX failed via `load_multi_pack_index_one()`.

When loading a MIDX chain, `load_midx_chain_fd_st()` reads each line in
the file one-by-one and dispatches calls to
`load_multi_pack_index_one()` to read each layer of the MIDX chain. When
a layer was successfully read, it is added to the MIDX chain by calling
`add_midx_to_chain()` which validates the contents of the `BASE` chunk,
performs some bounds checks on the number of combined packs and objects,
and attaches the new MIDX by assigning its `base_midx` pointer to the
existing part of the chain.

As a supplement to this, introduce a new mode in the test-read-midx
test-tool which allows us to read the information for a specific MIDX in
the chain by specifying its trailing checksum via the command-line
arguments like so:

    $ test-tool read-midx .git/objects [checksum]

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 midx.c                    | 184 +++++++++++++++++++++++++++++++++++---
 midx.h                    |   7 ++
 packfile.c                |   5 +-
 t/helper/test-read-midx.c |  24 +++--
 4 files changed, 201 insertions(+), 19 deletions(-)

diff --git a/midx.c b/midx.c
index cb7b623b5d..ac44fcefc2 100644
--- a/midx.c
+++ b/midx.c
@@ -89,7 +89,9 @@ static int midx_read_object_offsets(const unsigned char *chunk_start,
 
 #define MIDX_MIN_SIZE (MIDX_HEADER_SIZE + the_hash_algo->rawsz)
 
-struct multi_pack_index *load_multi_pack_index(const char *object_dir, int local)
+static struct multi_pack_index *load_multi_pack_index_one(const char *object_dir,
+							  const char *midx_name,
+							  int local)
 {
 	struct multi_pack_index *m = NULL;
 	int fd;
@@ -97,31 +99,26 @@ struct multi_pack_index *load_multi_pack_index(const char *object_dir, int local
 	size_t midx_size;
 	void *midx_map = NULL;
 	uint32_t hash_version;
-	struct strbuf midx_name = STRBUF_INIT;
 	uint32_t i;
 	const char *cur_pack_name;
 	struct chunkfile *cf = NULL;
 
-	get_midx_filename(&midx_name, object_dir);
-
-	fd = git_open(midx_name.buf);
+	fd = git_open(midx_name);
 
 	if (fd < 0)
 		goto cleanup_fail;
 	if (fstat(fd, &st)) {
-		error_errno(_("failed to read %s"), midx_name.buf);
+		error_errno(_("failed to read %s"), midx_name);
 		goto cleanup_fail;
 	}
 
 	midx_size = xsize_t(st.st_size);
 
 	if (midx_size < MIDX_MIN_SIZE) {
-		error(_("multi-pack-index file %s is too small"), midx_name.buf);
+		error(_("multi-pack-index file %s is too small"), midx_name);
 		goto cleanup_fail;
 	}
 
-	strbuf_release(&midx_name);
-
 	midx_map = xmmap(NULL, midx_size, PROT_READ, MAP_PRIVATE, fd, 0);
 	close(fd);
 
@@ -211,7 +208,6 @@ struct multi_pack_index *load_multi_pack_index(const char *object_dir, int local
 
 cleanup_fail:
 	free(m);
-	strbuf_release(&midx_name);
 	free_chunkfile(cf);
 	if (midx_map)
 		munmap(midx_map, midx_size);
@@ -220,6 +216,173 @@ struct multi_pack_index *load_multi_pack_index(const char *object_dir, int local
 	return NULL;
 }
 
+void get_midx_chain_dirname(struct strbuf *buf, const char *object_dir)
+{
+	strbuf_addf(buf, "%s/pack/multi-pack-index.d", object_dir);
+}
+
+void get_midx_chain_filename(struct strbuf *buf, const char *object_dir)
+{
+	get_midx_chain_dirname(buf, object_dir);
+	strbuf_addstr(buf, "/multi-pack-index-chain");
+}
+
+void get_split_midx_filename_ext(struct strbuf *buf, const char *object_dir,
+				 const unsigned char *hash, const char *ext)
+{
+	get_midx_chain_dirname(buf, object_dir);
+	strbuf_addf(buf, "/multi-pack-index-%s.%s", hash_to_hex(hash), ext);
+}
+
+static int open_multi_pack_index_chain(const char *chain_file,
+				       int *fd, struct stat *st)
+{
+	*fd = git_open(chain_file);
+	if (*fd < 0)
+		return 0;
+	if (fstat(*fd, st)) {
+		close(*fd);
+		return 0;
+	}
+	if (st->st_size < the_hash_algo->hexsz) {
+		close(*fd);
+		if (!st->st_size) {
+			/* treat empty files the same as missing */
+			errno = ENOENT;
+		} else {
+			warning(_("multi-pack-index chain file too small"));
+			errno = EINVAL;
+		}
+		return 0;
+	}
+	return 1;
+}
+
+static int add_midx_to_chain(struct multi_pack_index *midx,
+			     struct multi_pack_index *midx_chain,
+			     struct object_id *oids,
+			     int n)
+{
+	if (midx_chain) {
+		if (unsigned_add_overflows(midx_chain->num_packs,
+					   midx_chain->num_packs_in_base)) {
+			warning(_("pack count in base MIDX too high: %"PRIuMAX),
+				(uintmax_t)midx_chain->num_packs_in_base);
+			return 0;
+		}
+		if (unsigned_add_overflows(midx_chain->num_objects,
+					   midx_chain->num_objects_in_base)) {
+			warning(_("object count in base MIDX too high: %"PRIuMAX),
+				(uintmax_t)midx_chain->num_objects_in_base);
+			return 0;
+		}
+		midx->num_packs_in_base = midx_chain->num_packs +
+			midx_chain->num_packs_in_base;
+		midx->num_objects_in_base = midx_chain->num_objects +
+			midx_chain->num_objects_in_base;
+	}
+
+	midx->base_midx = midx_chain;
+	midx->has_chain = 1;
+
+	return 1;
+}
+
+static struct multi_pack_index *load_midx_chain_fd_st(const char *object_dir,
+						      int local,
+						      int fd, struct stat *st,
+						      int *incomplete_chain)
+{
+	struct multi_pack_index *midx_chain = NULL;
+	struct strbuf buf = STRBUF_INIT;
+	struct object_id *layers = NULL;
+	int valid = 1;
+	uint32_t i, count;
+	FILE *fp = xfdopen(fd, "r");
+
+	count = st->st_size / (the_hash_algo->hexsz + 1);
+	CALLOC_ARRAY(layers, count);
+
+	for (i = 0; i < count; i++) {
+		struct multi_pack_index *m;
+
+		if (strbuf_getline_lf(&buf, fp) == EOF)
+			break;
+
+		if (get_oid_hex(buf.buf, &layers[i])) {
+			warning(_("invalid multi-pack-index chain: line '%s' "
+				  "not a hash"),
+				buf.buf);
+			valid = 0;
+			break;
+		}
+
+		valid = 0;
+
+		strbuf_reset(&buf);
+		get_split_midx_filename_ext(&buf, object_dir, layers[i].hash,
+					    MIDX_EXT_MIDX);
+		m = load_multi_pack_index_one(object_dir, buf.buf, local);
+
+		if (m) {
+			if (add_midx_to_chain(m, midx_chain, layers, i)) {
+				midx_chain = m;
+				valid = 1;
+			} else {
+				close_midx(m);
+			}
+		}
+		if (!valid) {
+			warning(_("unable to find all multi-pack index files"));
+			break;
+		}
+	}
+
+	free(layers);
+	fclose(fp);
+	strbuf_release(&buf);
+
+	*incomplete_chain = !valid;
+	return midx_chain;
+}
+
+static struct multi_pack_index *load_multi_pack_index_chain(const char *object_dir,
+							    int local)
+{
+	struct strbuf chain_file = STRBUF_INIT;
+	struct stat st;
+	int fd;
+	struct multi_pack_index *m = NULL;
+
+	get_midx_chain_filename(&chain_file, object_dir);
+	if (open_multi_pack_index_chain(chain_file.buf, &fd, &st)) {
+		int incomplete;
+		/* ownership of fd is taken over by load function */
+		m = load_midx_chain_fd_st(object_dir, local, fd, &st,
+					  &incomplete);
+	}
+
+	strbuf_release(&chain_file);
+	return m;
+}
+
+struct multi_pack_index *load_multi_pack_index(const char *object_dir,
+					       int local)
+{
+	struct strbuf midx_name = STRBUF_INIT;
+	struct multi_pack_index *m;
+
+	get_midx_filename(&midx_name, object_dir);
+
+	m = load_multi_pack_index_one(object_dir, midx_name.buf, local);
+	if (!m)
+		m = load_multi_pack_index_chain(object_dir, local);
+
+	strbuf_release(&midx_name);
+
+	return m;
+}
+
 void close_midx(struct multi_pack_index *m)
 {
 	uint32_t i;
@@ -228,6 +391,7 @@ void close_midx(struct multi_pack_index *m)
 		return;
 
 	close_midx(m->next);
+	close_midx(m->base_midx);
 
 	munmap((unsigned char *)m->data, m->data_len);
 
diff --git a/midx.h b/midx.h
index 86af7dfc5e..94de16a8c4 100644
--- a/midx.h
+++ b/midx.h
@@ -24,6 +24,7 @@ struct bitmapped_pack;
 #define MIDX_CHUNKID_OBJECTOFFSETS 0x4f4f4646 /* "OOFF" */
 #define MIDX_CHUNKID_LARGEOFFSETS 0x4c4f4646 /* "LOFF" */
 #define MIDX_CHUNKID_REVINDEX 0x52494458 /* "RIDX" */
+#define MIDX_CHUNKID_BASE 0x42415345 /* "BASE" */
 #define MIDX_CHUNK_OFFSET_WIDTH (2 * sizeof(uint32_t))
 #define MIDX_LARGE_OFFSET_NEEDED 0x80000000
 
@@ -50,6 +51,7 @@ struct multi_pack_index {
 	int preferred_pack_idx;
 
 	int local;
+	int has_chain;
 
 	const unsigned char *chunk_pack_names;
 	size_t chunk_pack_names_len;
@@ -80,11 +82,16 @@ struct multi_pack_index {
 
 #define MIDX_EXT_REV "rev"
 #define MIDX_EXT_BITMAP "bitmap"
+#define MIDX_EXT_MIDX "midx"
 
 const unsigned char *get_midx_checksum(struct multi_pack_index *m);
 void get_midx_filename(struct strbuf *out, const char *object_dir);
 void get_midx_filename_ext(struct strbuf *out, const char *object_dir,
 			   const unsigned char *hash, const char *ext);
+void get_midx_chain_dirname(struct strbuf *buf, const char *object_dir);
+void get_midx_chain_filename(struct strbuf *buf, const char *object_dir);
+void get_split_midx_filename_ext(struct strbuf *buf, const char *object_dir,
+				 const unsigned char *hash, const char *ext);
 
 struct multi_pack_index *load_multi_pack_index(const char *object_dir, int local);
 int prepare_midx_pack(struct repository *r, struct multi_pack_index *m, uint32_t pack_int_id);
diff --git a/packfile.c b/packfile.c
index d4df7fdeea..85f0345435 100644
--- a/packfile.c
+++ b/packfile.c
@@ -878,7 +878,8 @@ static void prepare_pack(const char *full_name, size_t full_name_len,
 	if (!report_garbage)
 		return;
 
-	if (!strcmp(file_name, "multi-pack-index"))
+	if (!strcmp(file_name, "multi-pack-index") ||
+	    !strcmp(file_name, "multi-pack-index.d"))
 		return;
 	if (starts_with(file_name, "multi-pack-index") &&
 	    (ends_with(file_name, ".bitmap") || ends_with(file_name, ".rev")))
@@ -1062,7 +1063,7 @@ struct packed_git *get_all_packs(struct repository *r)
 	prepare_packed_git(r);
 	for (m = r->objects->multi_pack_index; m; m = m->next) {
 		uint32_t i;
-		for (i = 0; i < m->num_packs; i++)
+		for (i = 0; i < m->num_packs + m->num_packs_in_base; i++)
 			prepare_midx_pack(r, m, i);
 	}
 
diff --git a/t/helper/test-read-midx.c b/t/helper/test-read-midx.c
index 4acae41bb9..f9148328e3 100644
--- a/t/helper/test-read-midx.c
+++ b/t/helper/test-read-midx.c
@@ -7,8 +7,10 @@
 #include "packfile.h"
 #include "setup.h"
 #include "gettext.h"
+#include "pack-revindex.h"
 
-static int read_midx_file(const char *object_dir, int show_objects)
+static int read_midx_file(const char *object_dir, const char *checksum,
+			  int show_objects)
 {
 	uint32_t i;
 	struct multi_pack_index *m;
@@ -19,6 +21,13 @@ static int read_midx_file(const char *object_dir, int show_objects)
 	if (!m)
 		return 1;
 
+	if (checksum) {
+		while (m && strcmp(hash_to_hex(get_midx_checksum(m)), checksum))
+			m = m->base_midx;
+		if (!m)
+			return 1;
+	}
+
 	printf("header: %08x %d %d %d %d\n",
 	       m->signature,
 	       m->version,
@@ -52,7 +61,8 @@ static int read_midx_file(const char *object_dir, int show_objects)
 		struct pack_entry e;
 
 		for (i = 0; i < m->num_objects; i++) {
-			nth_midxed_object_oid(&oid, m, i);
+			nth_midxed_object_oid(&oid, m,
+					      i + m->num_objects_in_base);
 			fill_midx_entry(the_repository, &oid, &e, m);
 
 			printf("%s %"PRIu64"\t%s\n",
@@ -109,7 +119,7 @@ static int read_midx_bitmapped_packs(const char *object_dir)
 	if (!midx)
 		return 1;
 
-	for (i = 0; i < midx->num_packs; i++) {
+	for (i = 0; i < midx->num_packs + midx->num_packs_in_base; i++) {
 		if (nth_bitmapped_pack(the_repository, midx, &pack, i) < 0)
 			return 1;
 
@@ -125,16 +135,16 @@ static int read_midx_bitmapped_packs(const char *object_dir)
 
 int cmd__read_midx(int argc, const char **argv)
 {
-	if (!(argc == 2 || argc == 3))
-		usage("read-midx [--show-objects|--checksum|--preferred-pack|--bitmap] <object-dir>");
+	if (!(argc == 2 || argc == 3 || argc == 4))
+		usage("read-midx [--show-objects|--checksum|--preferred-pack|--bitmap] <object-dir> <checksum>");
 
 	if (!strcmp(argv[1], "--show-objects"))
-		return read_midx_file(argv[2], 1);
+		return read_midx_file(argv[2], argv[3], 1);
 	else if (!strcmp(argv[1], "--checksum"))
 		return read_midx_checksum(argv[2]);
 	else if (!strcmp(argv[1], "--preferred-pack"))
 		return read_midx_preferred_pack(argv[2]);
 	else if (!strcmp(argv[1], "--bitmap"))
 		return read_midx_bitmapped_packs(argv[2]);
-	return read_midx_file(argv[1], 0);
+	return read_midx_file(argv[1], argv[2], 0);
 }
-- 
2.45.2.437.gecb9450a0e

