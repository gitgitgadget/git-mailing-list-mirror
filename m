Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792740389;
	b=xgdMF0QcBXy6UruI3zDc4PmjCBaJSl9KMlyIP5Z1YmX1tpTmbgn3Ap0H5ZspTrnfEqQZ
	 mqa9DKjJdAD1DSb9StaMQKMgBUaI+pzbLjOoM9H69yUQoFD0akZr5YM89eMTnXRbAgSXQ
	 3ShopO4xorGWsxSNrOBzyH2TBaTN1AeQIUzN8wKzJHaw+kgIl/ZG0Rn2fzIZOxYzeEvms
	 HfiOAeCP7ZOm1F+MqQefNuK3oCZCFN9vybuuVJS23ExNZPTAAeUWLrGvTW2LWhFPZaB2z
	 JzGh0yYQflYtvLJSJpJHFkyAbC351oPflKOgZFSPNBtZ6Lu7toVTsp4JE077ho8HtDA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792740389;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=jkod9LJZonhizZdisM+QLENUWHTSgWS7O/ISEvlogFk=;
	b=o/B7LUyhJ3OBzDnGBQ0egXAG6fZOEdQSHVo4Vw8lNqNNidnrlyA/SLStrTWEzB0CoFbe
	 qOVDr03hRa491SEYWkyaYAjG0ZLLBK4N2qp8tfoHUJ4lagjPVPKiD7Nwx2VVsn+VSxtdR
	 2VO8CWGz96JDUGW3HhRbN7uKadUCKnDsxgAn8afjzNiOAvXoPin2JT5BMpxzC5p33pHx2
	 yH0MaWpW/EDuElpK+b6/BpOORSAy5QKHaEHHO/of9sCO8cjlHO2uAT1GB+ZaZF9T94mqN
	 bw8DvgdPqePxufJzLhlTuYZ9yFe6I8E+diwC496/V/NipynWPCbSWc9E8buyzHMYeEQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=cIAuosve;
	arc=none smtp.remote-ip=209.85.128.53
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59BE8606A32A
	for <git@vger.kernel.org>; Fri, 23 Oct 2026 07:26:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 59BE8606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=cIAuosve
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4a0286c981dso5608995e9.2
        for <git@vger.kernel.org>; Fri, 23 Oct 2026 00:26:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792740388; x=1793345188; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=jkod9LJZonhizZdisM+QLENUWHTSgWS7O/ISEvlogFk=;
        b=cIAuosveYvORYBKfndfoYH2wjc8xVJsb87yEf6keBFvPwiPFtTXQ76e2od42a6wLD+
         1Sm/KEGWzh6gaYaQFGJNpTkDv7K/iOdzZFbahGwse8M4TEGP1cHhdb2oHUOKoBN3at0g
         kdX2O41DUCrjx4pM3rWcSsVmaU9GWeXIWvOCLJkbKLJKhkxAMepO7b56Phq0vI0pICK7
         6Q22I393iGjaT9GaN9y0ZDFKj5t98clKjcZudZuAIbFk4QWLZTezo6co2ASm7K5K1yln
         1X26LFJnOk4EUdsstUeGIwX2PzfjYeguQHESMS2k0ufpG64ds5SDWMpCpthKRCYi4LCc
         U0CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792740388; x=1793345188;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=jkod9LJZonhizZdisM+QLENUWHTSgWS7O/ISEvlogFk=;
        b=BCaVt5MBmQJqNvwFlf5KMqZYvAJxfYo8ORJuROScyIlggyxH7PxOPw/Go/LEZIIbJR
         5sfUoRxduntdQ+T2+5uKTFqBkDOBnxCw/yvi01VxhTPfHLfLH9qL4gIYCMbdwFybEM69
         1Sf3QajwVilNLiwrBgp06mKJ9ogMgrfT86wSk7LDzY0wQ/E4dzERydLSUqjHzhvyKRcX
         YntJ/v6idWVl4xuR5zj+rfjtZJFyQZ87FXqV0J3jGwYZWktU2c2O4QZl9zJRPIp6qOIr
         T/VD7WKaMnpOpyjwJw9Q3OrB1QCZ7X/4U2LMuKYuyJAfEv95H786c/fb3SYEOw3a7B9p
         ZwaA==
X-Gm-Message-State: AFq9FYITQu5BTNsLMt1k5a31y/JRKMtJ6wV4VrX7cAe7NqIU544yjEqc
	MeuEmtK9ZJKCn57fJ2js833X3gJ4JVP/joRLX3vSKhVlrGdvhHWCnHr3eWqkgA==
X-Gm-Gg: AYBFou2LFw4JL2LRmR+wwChomxjgUiO70J2kOAoFthTEAF97kdihiJB9mIShI9YsZyr
	ZgVcgVs2c1KwUoSqb/yhC++s1aQg4NX+vGbKeLgU4/+aYlbEH8EJxU8+PdfZE3zN7RxPYDi0yOQ
	+hOkXQiNpgYXnRkN6rcC1c7uO76OrfT48zR2QxqcvssLIjyd4jLNDQGxJNQ2o9zgnBJup9sta3b
	q+O72nUMHC0gaVx0pW2V8tmCEklm1G7e59kaixlFBh8PEyDEhMMaq2sBnlPDEe1Ig7R1FB+QSGB
	oOpmb38Dc++WaewqDhbLonPAWABrXbN1ccy1frjTiCLPCS0TJRITrRW9PVgJ2QkqkhsK/EpUj/6
	MfsilJ0tRH39gIUjOxxQItClRqXB9mtUzQETSTQvm7WIQOQvLBH3rg2tzufxYy73HNhbdTQl4R2
	WAp+7yC64wuDA+YLk9UirfxMDCOGL3lOP7TS8u3nkPZwPblB3hrDcVy6PsKjCkwsNw5Wyjuz+nD
	K5W+TWLHMSy4V2PsbjAWo5eAquEd7ZFi1o3XrMXYYHHS9ec/03EagIJE+8rQA7kTtDyiUoWJZtY
	kvuGbk2kLv6WRLPbfBvF1mGCtXAFCCobbPrWQ6IL/Th2R//7jvGjdIhFGDz4j5Kzh3uqyvX9t8O
	ZTdasxOIVUsNIGOvtQpkLijQ131ddQv4Jvt/xR1Ezc9ZNeCS5LZH4PnL5KCUZBh60Gw==
X-Received: by 2002:a05:600c:a00b:b0:4a1:706f:b40d with SMTP id 5b1f17b1804b1-4a211c9c5cdmr19167085e9.7.1792740387276;
        Fri, 23 Oct 2026 00:26:27 -0700 (PDT)
Received: from christian--20230123--2G7D3 ([62.35.114.108])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e38055da4sm3228024f8f.43.2026.10.23.00.26.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2026 00:26:26 -0700 (PDT)
From: Christian Couder <christian.couder@gmail.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	"brian m . carlson" <sandals@crustytoothpaste.net>,
	Patrick Steinhardt <ps@pks.im>,
	Elijah Newren <newren@gmail.com>,
	Jeff King <peff@peff.net>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Christian Couder <christian.couder@gmail.com>
Subject: [PATCH v2 07/13] builtin: populate pack index v3 fields when indexing
Date: Fri, 23 Oct 2026 09:25:52 +0200
Message-ID: <20261023072559.3204273-8-christian.couder@gmail.com>
X-Mailer: git-send-email 2.56.0.215.g47fdf2208c
In-Reply-To: <20261023072559.3204273-1-christian.couder@gmail.com>
References: <20261023072559.3204273-1-christian.couder@gmail.com>
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

