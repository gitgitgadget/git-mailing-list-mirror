Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792564395;
	b=KU6btUHjZxuLNTnxdHBWKOlxcT4oTc4hql6K1SuOd+U8ga21Xix096LzvWEvC3Pp0Pjo
	 0+o9r4+qUgy/6wl6XCNmnmIbquIR54hCOqSmq2TWv6VaYy6LP0SJ2TMl7PjwWvdM8h3oQ
	 Is/CIQymikpOFmYex67LEM9dujuet0zf/tT+p1OxOif2du3WasF9/Nzg9umd4uu19bZ/5
	 wEUOemgaUreyW6CnaYdKscICKPHej4HZugn6PokwvjesXYuufBaTHuN0c3NGWUaGgL16V
	 ky+c0dQguxHVHu53mp1Ej1VtpJYJ0pIuM9UQVCagooG99qAkwvSt7XYi9g1Eeti0LqQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792564395;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=jkod9LJZonhizZdisM+QLENUWHTSgWS7O/ISEvlogFk=;
	b=G1n6ltNK/n1NOUo7wshHp2upru+6yCMSCKUmawHkJbJfkKeZ7BCBG/go/yrHeBS7+uck
	 Df0oG+TJ1kI6BUopOx9nSAluUy8B2VRXj0SsqQXaRDI5+5oSlPbwtb1hkerndYKSDH9dm
	 pf3W99UOmZpo5r5C8b/j+9ZgpyXg6s7fu/yu0ACtVKELuQEJaXNuHgmAtu/I8rP5wcZ4u
	 pXvz8D8Omg1yjn/0MA3gI26dM9vCdQwcHPs52CER40HjR9jfUXwWTxBgfOwCQNEegyKh0
	 vM8bcSIchek5Rqpjo9mHIehRi4xYH9ewETiDk85lP+UnVyTvpusus9d0IvBnUX+GELg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=VhJmlfGb;
	arc=none smtp.remote-ip=209.85.221.53
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AE0C606A33A
	for <git@vger.kernel.org>; Wed, 21 Oct 2026 06:33:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3AE0C606A33A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=VhJmlfGb
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-48e10a70540so164759f8f.1
        for <git@vger.kernel.org>; Tue, 20 Oct 2026 23:33:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792564393; x=1793169193; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=jkod9LJZonhizZdisM+QLENUWHTSgWS7O/ISEvlogFk=;
        b=VhJmlfGbMHiw/1XATy8xR/1uwp14WxNvH5JKb3oq6ceGKDFMD2czMxV6QoP7avUJZh
         KfQULsIDZn7MDukx3CBf59oY2Qwpko63NNT/eZNEZCqlRoUHzRm8DLYl5+vh2aXXTdp3
         erEYITg3yvKgM9xgKq02g/GRrCzOFRfkYxup2pO7ckmTZ6tpAqSCiUcLRp+hT8dEeLvx
         9LvnNREiRAIsiPWlPRRXdsejcS/TCYBeDPfOIIQt1BTFa4rRdAIeOHl4bHrCsi+9fyqE
         d1+w1X2+FNNHNY9ObEICBtCZM2E0N5xn/D0MK9IfYm9++LcnP/0uKSrgk4E7RgHRv5WD
         sfmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792564393; x=1793169193;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=jkod9LJZonhizZdisM+QLENUWHTSgWS7O/ISEvlogFk=;
        b=L8UqVYrSuw4ZIqEOTi8xInYnkXTah6PMpsBuAYEjrHDb91yGaqMw0X53JRTi++Vyb3
         BhkEII+jNPBoHO5n+PEP++WAlZgS8bqn00rdF5ZXDTj8Y/AfcUSRwzVYfJGCzXVth8oF
         xCnsemHzFFjchnC8/lAL/xvIdp1QSszcxr5YaQ9ve0SvbP23jUYiW0S6zaCn+ShxRVAg
         +RfUPlwvhI69nl0ylRTKA3y3KtSI1dxG674Wl909IGBjpOxs4jUMFik8UDB6YURqngOF
         Ss3N2JtTK8L5Qgvs3wnB70aXJZcDRQv1uP9L9gC/hvC62cl6sTcNtz+pXgwglYGkdrIa
         qjRA==
X-Gm-Message-State: AFq9FYJ8ZPWP9oxZK85/3btkznA2F66gbDeA3xXGdoiMzCerFQsv9hj5
	+liqeDrgTH6X/bjiwNe+ddEI8rCSxReipAsYG4XS2O9Xn6LlsCTHV9Imj7DjgQ==
X-Gm-Gg: AYBFou0pfd81ulu3WcwcdN8rHdlDoTdLjpwRtulNU2m+xgN04S46IxEpbaBij0+sfAi
	2CjgsPQOLxYSO7zTzutHDqF8mlgZsNc4JbIkmiHfrTlHRhBoZ5bfMUxVyRCj0tA6652nzaOcWrh
	ZGKnn76DOJgWm04GJsDD5en7puQJuYoFLHFn+w/veEKpBQT5t3GxoGYMom0ZwidXFQMp4pppQVL
	nRyczoug6x6EWiF+/ZcUioNE4jmfCzC6JTGP3Gzt8G6L1Rb+dQ0WNr7Rpv7viMLRUO2MUGIQ53g
	k9uQ7Qc7+aPsPNL2lMQfWYu06btGe48BJGkJQ5gCBiw7FvOwLpSqjKN9B26yVeTpm+QsWxfCsqk
	X1EvFUG0L2CtMm028Lm+jMTK0lOZ0+Aq7BMYjJOCxuVOtJnpYNK4DLQMXrUJ5gZdeRAaUNsqK25
	r9pVizXaLeLvDYIxQxfTwwp0tAJtCiq4/LNMZmGJmfVsk3YDfN/M/AlvjqMTA8NhNs1RtuPLMMb
	9rPpvhDkizK5vyU+cszEjRbq4drYe1b3Qw7FHNFfZkBPk1/2n/bIjyzn095vsrtM5YXs6sT4W81
	2qXY3Eqm5doATXehloRpun2yOg0tLJ8u+DZNJFOAKWFIJYXA2rWEqSl70BG4ida+Ox893HWeTeA
	MQIMhK+U4xvVtg2OUmD/9Z8HtVzgrpyhjFtmMgMoQlKNKoiWmMYV140lI2DZMzUU9RA==
X-Received: by 2002:a05:6000:46dc:b0:48d:f7af:be35 with SMTP id ffacd0b85a97d-48e264b2968mr1169654f8f.29.1792564393238;
        Tue, 20 Oct 2026 23:33:13 -0700 (PDT)
Received: from christian--20230123--2G7D3 ([62.35.114.108])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e2581eedesm3130790f8f.14.2026.10.20.23.33.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2026 23:33:12 -0700 (PDT)
From: Christian Couder <christian.couder@gmail.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	"brian m . carlson" <sandals@crustytoothpaste.net>,
	Patrick Steinhardt <ps@pks.im>,
	Elijah Newren <newren@gmail.com>,
	Jeff King <peff@peff.net>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Christian Couder <christian.couder@gmail.com>
Subject: [PATCH 07/13] builtin: populate pack index v3 fields when indexing
Date: Wed, 21 Oct 2026 08:32:39 +0200
Message-ID: <20261021063245.2917625-8-christian.couder@gmail.com>
X-Mailer: git-send-email 2.56.0.215.g47fdf2208c
In-Reply-To: <20261021063245.2917625-1-christian.couder@gmail.com>
References: <20261021063245.2917625-1-christian.couder@gmail.com>
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "brian m. carlson" <sandals@crustytoothpaste.net>

Right now, we have support for writing pack index v3.  However, we need
to populate the compatibility object ID in order to write it into the
repository.  Let's do so by converting the objects from SHA-256 to SHA-1
as part of our indexing process.

Take advantage of the fact that a SHA-256 blob and its corresponding
SHA-1 blob are identical by always hashing them at the same time.  For
non-blobs, we convert the objects from SHA-256 to SHA-1 before hashing.

Since, when converting an object, we may need to know about the
compatibility object IDs of objects earlier in the pack, on which they
depend, store the compatibility object IDs we generate in the loose
object map, but don't write them to disk.  This is the simplest way to
store these objects and have them properly looked up by the same process
without polluting the loose object index on disk with all of these
objects.

Because these operations may be threaded and modifying the loose object
map isn't thread safe, add a mutex and use it to protect this structure.
Note that the object conversion routines use this structure.  Acquire
and release the mutex between the conversion and writing to the map
because hashing may be slow.

Add a test in t1016 to check that index-pack can write a v3 index in a
repository with a compatibility algorithm, and a test that it rejects
packs with duplicate objects when writing a v3 index with `--strict`.

Also add a create_compat_repo() helper in t1016 to refactor common
code.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
Signed-off-by: Christian Couder <christian.couder@gmail.com>
---
 builtin/index-pack.c              | 105 +++++++++++++++++++++++++++---
 builtin/pack-objects.c            |   8 ++-
 t/t1016-compatObjectFormat.sh     |  29 ++++++++-
 t/t5308-pack-detect-duplicates.sh |   7 ++
 4 files changed, 137 insertions(+), 12 deletions(-)

diff --git a/builtin/index-pack.c b/builtin/index-pack.c
index 0264c18c5f..723595ae03 100644
--- a/builtin/index-pack.c
+++ b/builtin/index-pack.c
@@ -31,6 +31,8 @@
 #include "run-command.h"
 #include "setup.h"
 #include "strvec.h"
+#include "loose.h"
+#include "object-file-convert.h"
 
 static const char index_pack_usage[] =
 "git index-pack [-v] [-o <index-file>] [--keep | --keep=<msg>] [--[no-]rev-index] [--verify] [--strict[=<msg-id>=<severity>...]] [--fsck-objects[=<msg-id>=<severity>...]] (<pack-file> | --stdin [--fix-thin] [<pack-file>])";
@@ -182,6 +184,10 @@ static pthread_mutex_t deepest_delta_mutex;
 #define deepest_delta_lock()	lock_mutex(&deepest_delta_mutex)
 #define deepest_delta_unlock()	unlock_mutex(&deepest_delta_mutex)
 
+static pthread_mutex_t repo_mutex;
+#define repo_lock()	lock_mutex(&repo_mutex)
+#define repo_unlock()	unlock_mutex(&repo_mutex)
+
 static pthread_key_t key;
 
 static inline void lock_mutex(pthread_mutex_t *mutex)
@@ -205,6 +211,7 @@ static void init_thread(void)
 	init_recursive_mutex(&read_mutex);
 	pthread_mutex_init(&counter_mutex, NULL);
 	pthread_mutex_init(&work_mutex, NULL);
+	pthread_mutex_init(&repo_mutex, NULL);
 	if (show_stat)
 		pthread_mutex_init(&deepest_delta_mutex, NULL);
 	pthread_key_create(&key, NULL);
@@ -225,6 +232,7 @@ static void cleanup_thread(void)
 	pthread_mutex_destroy(&read_mutex);
 	pthread_mutex_destroy(&counter_mutex);
 	pthread_mutex_destroy(&work_mutex);
+	pthread_mutex_destroy(&repo_mutex);
 	if (show_stat)
 		pthread_mutex_destroy(&deepest_delta_mutex);
 	for (i = 0; i < nr_threads; i++)
@@ -469,13 +477,15 @@ static int is_delta_type(enum object_type type)
 }
 
 static void *unpack_entry_data(off_t offset, size_t size,
-			       enum object_type type, struct object_id *oid)
+			       enum object_type type, struct object_id *oid,
+			       struct object_id *compat_oid)
 {
 	static char fixed_buf[8192];
 	int status;
 	git_zstream stream;
 	void *buf;
-	struct git_hash_ctx c;
+	struct git_hash_ctx c, c_compat;
+	const struct git_hash_algo *compat = the_repository->compat_hash_algo;
 	char hdr[32];
 	int hdrlen;
 
@@ -483,8 +493,15 @@ static void *unpack_entry_data(off_t offset, size_t size,
 		hdrlen = format_object_header(hdr, sizeof(hdr), type, size);
 		git_hash_init(&c, the_hash_algo);
 		git_hash_update(&c, hdr, hdrlen);
-	} else
+		if (compat && compat_oid) {
+			git_hash_init(&c_compat, compat);
+			if (type == OBJ_BLOB)
+				git_hash_update(&c_compat, hdr, hdrlen);
+		}
+	} else {
 		oid = NULL;
+		compat_oid = NULL;
+	}
 	if (type == OBJ_BLOB &&
 	    size > repo_settings_get_big_file_threshold(the_repository))
 		buf = fixed_buf;
@@ -504,6 +521,8 @@ static void *unpack_entry_data(off_t offset, size_t size,
 		use(input_len - stream.avail_in);
 		if (oid)
 			git_hash_update(&c, last_out, stream.next_out - last_out);
+		if (compat && compat_oid && type == OBJ_BLOB)
+			git_hash_update(&c_compat, last_out, stream.next_out - last_out);
 		if (buf == fixed_buf) {
 			stream.next_out = buf;
 			stream.avail_out = sizeof(fixed_buf);
@@ -514,13 +533,43 @@ static void *unpack_entry_data(off_t offset, size_t size,
 	git_inflate_end(&stream);
 	if (oid)
 		git_hash_final_oid(oid, &c);
+	if (compat && compat_oid) {
+		if (type != OBJ_BLOB) {
+			/*
+			 * This is not a blob.  Let's remap it to the proper
+			 * algorithm.
+			 */
+			struct strbuf outbuf = STRBUF_INIT;
+			int ret;
+			repo_lock();
+			ret = convert_object_file(the_repository, &outbuf,
+						  the_repository->hash_algo,
+						  compat,
+						  buf, size, type, 0);
+			repo_unlock();
+			if (ret < 0)
+				bad_object(offset, _("could not convert object"));
+
+			hdrlen = xsnprintf(hdr, sizeof(hdr), "%s %"PRIuMAX,
+					   type_name(type),(uintmax_t)outbuf.len) + 1;
+
+			git_hash_update(&c_compat, hdr, hdrlen);
+			git_hash_update(&c_compat, outbuf.buf, outbuf.len);
+			strbuf_release(&outbuf);
+		}
+		git_hash_final_oid(compat_oid, &c_compat);
+		repo_lock();
+		odb_write_oid_map(the_repository->objects, oid, compat_oid, 0);
+		repo_unlock();
+	}
 	return buf == fixed_buf ? NULL : buf;
 }
 
 static void *unpack_raw_entry(struct object_entry *obj,
 			      off_t *ofs_offset,
 			      struct object_id *ref_oid,
-			      struct object_id *oid)
+			      struct object_id *oid,
+			      struct object_id *compat_oid)
 {
 	unsigned char *p;
 	size_t size, c;
@@ -582,7 +631,7 @@ static void *unpack_raw_entry(struct object_entry *obj,
 	}
 	obj->hdr_size = consumed_bytes - obj->idx.offset;
 
-	data = unpack_entry_data(obj->idx.offset, obj->size, obj->type, oid);
+	data = unpack_entry_data(obj->idx.offset, obj->size, obj->type, oid, compat_oid);
 	obj->idx.crc32 = input_crc32;
 	return data;
 }
@@ -1069,6 +1118,45 @@ static struct base_data *resolve_delta(struct object_entry *delta_obj,
 		bad_object(delta_obj->idx.offset, _("failed to apply delta"));
 	hash_object_file(the_hash_algo, result_data, result_size,
 			 delta_obj->real_type, &delta_obj->idx.oid);
+	if (the_repository->compat_hash_algo) {
+		struct strbuf outbuf = STRBUF_INIT;
+		int ret = 0;
+		char *buf;
+		size_t len;
+
+		if (delta_obj->real_type != OBJ_BLOB) {
+			repo_lock();
+			ret = convert_object_file(the_repository, &outbuf,
+						  the_repository->hash_algo,
+						  the_repository->compat_hash_algo,
+						  result_data, result_size,
+						  delta_obj->real_type, 0);
+			repo_unlock();
+			buf = outbuf.buf;
+			len = outbuf.len;
+		} else {
+			buf = result_data;
+			len = result_size;
+		}
+		if (ret < 0)
+			bad_object(delta_obj->idx.offset,
+				   _("could not convert object from delta"));
+
+		hash_object_file(the_repository->compat_hash_algo, buf, len,
+				 delta_obj->real_type, &delta_obj->idx.compat_oid);
+		/*
+		 * We add this entry to the loose object map but do not write it
+		 * to disk because we may need it available when mapping other
+		 * objects.  Storing it temporarily in the loose object map lets
+		 * us keep it around for that purpose.
+		 */
+		repo_lock();
+		odb_write_oid_map(the_repository->objects,
+				  &delta_obj->idx.oid,
+				  &delta_obj->idx.compat_oid, 0);
+		repo_unlock();
+		strbuf_release(&outbuf);
+	}
 	sha1_object(result_data, NULL, result_size, delta_obj->real_type,
 		    &delta_obj->idx.oid);
 
@@ -1265,7 +1353,8 @@ static void parse_pack_objects(unsigned char *hash)
 		struct object_entry *obj = &objects[i];
 		void *data = unpack_raw_entry(obj, &ofs_delta->offset,
 					      &ref_delta_oid,
-					      &obj->idx.oid);
+					      &obj->idx.oid,
+					      &obj->idx.compat_oid);
 		obj->real_type = obj->type;
 		if (obj->type == OBJ_OFS_DELTA) {
 			nr_ofs_deltas++;
@@ -1669,7 +1758,7 @@ static int git_index_pack_config(const char *k, const char *v,
 
 	if (!strcmp(k, "pack.indexversion")) {
 		opts->version = git_config_int(k, v, ctx->kvi);
-		if (opts->version > 2)
+		if (opts->version > 3)
 			die(_("bad pack.indexVersion=%"PRIu32), opts->version);
 		return 0;
 	}
@@ -1991,7 +2080,7 @@ int cmd_index_pack(int argc,
 			} else if (starts_with(arg, "--index-version=")) {
 				char *c;
 				opts.version = strtoul(arg + 16, &c, 10);
-				if (opts.version > 2)
+				if (opts.version > 3)
 					die(_("bad %s"), arg);
 				if (*c == ',')
 					opts.off32_limit = strtoul(c+1, &c, 0);
diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index ca3a891dfb..fc4adb6877 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -47,6 +47,9 @@
 #include "blob.h"
 #include "tree.h"
 #include "path-walk.h"
+#include "trace2.h"
+#include "loose.h"
+#include "object-file-convert.h"
 
 /*
  * Objects we are going to pack are collected in the `to_pack` structure.
@@ -1847,6 +1850,9 @@ static struct object_entry *create_object_entry(const struct object_id *oid,
 
 	entry = packlist_alloc(&to_pack, oid);
 	entry->hash = hash;
+	if (repo_oid_to_algop(the_repository, &entry->idx.oid,
+			      the_repository->compat_hash_algo, &entry->idx.compat_oid) < 0)
+		die(_("can't map object %s while writing pack"), oid_to_hex(oid));
 	oe_set_type(entry, type);
 	if (exclude)
 		entry->preferred_base = 1;
@@ -5039,7 +5045,7 @@ static int option_parse_index_version(const struct option *opt,
 	BUG_ON_OPT_NEG(unset);
 
 	popts->version = strtoul(val, &c, 10);
-	if (popts->version > 2)
+	if (popts->version > 3)
 		die(_("unsupported index version %s"), val);
 	if (*c == ',' && c[1])
 		popts->off32_limit = strtoul(c+1, &c, 0);
diff --git a/t/t1016-compatObjectFormat.sh b/t/t1016-compatObjectFormat.sh
index 9cafcee509..1560b6a2e2 100755
--- a/t/t1016-compatObjectFormat.sh
+++ b/t/t1016-compatObjectFormat.sh
@@ -45,6 +45,15 @@ compat_hash () {
 	esac
 }
 
+create_compat_repo () {
+	local hash="$1"
+	local repo="$2"
+
+	git init --object-format="$hash" "$repo" &&
+	git -C "$repo" config set core.repositoryformatversion 1 &&
+	git -C "$repo" config set extensions.compatObjectFormat $(compat_hash "$hash")
+}
+
 hello_oid () {
 	case "$1" in
 	"sha1")
@@ -192,9 +201,7 @@ do
 		for repo in alt borrow
 		do
 			test_when_finished "rm -rf $repo" &&
-			git init --object-format=$hash $repo &&
-			git -C $repo config set core.repositoryformatversion 1 &&
-			git -C $repo config set extensions.compatObjectFormat $(compat_hash $hash) || exit 1
+			create_compat_repo $hash $repo || exit 1
 		done &&
 
 		git -C alt commit --allow-empty --message A &&
@@ -205,6 +212,22 @@ do
 		git -C borrow rev-parse --output-object-format=$(compat_hash $hash) "$oid" >actual &&
 		test_cmp expect actual
 	'
+
+	test_expect_success 'index-pack writes pack index v3' '
+		test_when_finished "rm -rf v3-repo v3.idx" &&
+		create_compat_repo $hash v3-repo &&
+		echo content >v3-repo/file &&
+		git -C v3-repo add file &&
+		git -C v3-repo commit --message A &&
+		git -C v3-repo commit --allow-empty --message B &&
+		git -C v3-repo repack -a -d &&
+		pack=$(echo v3-repo/.git/objects/pack/pack-*.pack) &&
+		git -C v3-repo index-pack --index-version=3 \
+			-o "$(pwd)/v3.idx" "$(pwd)/$pack" &&
+		echo "ff 74 4f 63 00 00 00 03 " >expect &&
+		test_copy_bytes 8 <v3.idx | test-tool hexdump >actual &&
+		test_cmp expect actual
+	'
 done
 cd "$base"
 
diff --git a/t/t5308-pack-detect-duplicates.sh b/t/t5308-pack-detect-duplicates.sh
index 0f84137867..7b43db870a 100755
--- a/t/t5308-pack-detect-duplicates.sh
+++ b/t/t5308-pack-detect-duplicates.sh
@@ -79,4 +79,11 @@ test_expect_success 'index-pack can reject packs with duplicates' '
 	test_expect_code 1 git cat-file -e $LO_SHA1
 '
 
+test_expect_success 'index-pack can reject packs with duplicates with index v3' '
+	clear_packs &&
+	create_pack dups.pack 2 &&
+	test_must_fail git index-pack --strict --index-version=3 --stdin <dups.pack &&
+	test_expect_code 1 git cat-file -e $LO_SHA1
+'
+
 test_done
-- 
2.56.0.215.g47fdf2208c

