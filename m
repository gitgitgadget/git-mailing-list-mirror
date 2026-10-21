Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792564391;
	b=3F3pHQxaRqFHow705IW8JkcXAJsHVCZVf4XCQhpgtcqD3hqx6tNpQc/CvLR2sZeSXirk
	 jiR1uub5ptjleBtjYeyWXbxXrWReEavgkoXelkaspUKP6XUdMiSnAh5QQhKgSIyJ0AYZS
	 YRg7zTprUCpx5TVelfWLrxZSXK5SdCFk6xl+dyrtPBP8WDRhHzp5gGBwr4rLVS+T04H94
	 BwFNXT9wZegO3XJDJEWoGTX1GztOKpBkkLXDOq+4YYg1LUCCeEBJh8YV4bUzmbte8GSF7
	 xS5NcOm4676U3wD81++6EMEtzw1fZwvEnZkV/BkosRqzuDXOpAVzK9pGurf8jC/WrWA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792564391;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=18n/60G5UEDa0C6MjWfXpEqGEqrbjjWZh6b5p0dIK7E=;
	b=D0/4nmdqxPiZlxX1f8A3dVAC5EPg4drGwIj5rk+7voVwjxeShbIGDInDBe7bojTzvEcF
	 4kz3nBugczbueTAlqf5xxojJxc6YiOGHJTDW48DfRtlLF7QJBiQWwjkeMxBnb6gJT94rV
	 jRBh6FdesalVJS9NU2n4HP+RJBMzGJAF9fSW2adxuZ8UbIBILWPeowqEn3oVr0buJw6kA
	 p+td3b2i3Tax98AZeTG59yf7JCJDrrUv9/5XioV5E/x0VNUm7JD81UatCazjKz6ew4vWr
	 TL+7S/rni5VbRVfzeKUxBmjeHUOAxAFvi+l8urBQKFbaMY866bh4AqbCEOU46EQrqEQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=BQCF+O4l;
	arc=none smtp.remote-ip=209.85.221.53
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32128606A332
	for <git@vger.kernel.org>; Wed, 21 Oct 2026 06:33:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 32128606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=BQCF+O4l
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-48e00eee27dso201204f8f.0
        for <git@vger.kernel.org>; Tue, 20 Oct 2026 23:33:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792564389; x=1793169189; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=18n/60G5UEDa0C6MjWfXpEqGEqrbjjWZh6b5p0dIK7E=;
        b=BQCF+O4lZjbiJ/HgMwKMRvqmeqbYJKYbKzTP+qj5RSDRkw5hNSjXYmtg+jR47cG29s
         /eJSdvMGfLclp1pNnqyDnVUX5cwV89FprMRwp9AAfPlBbCDaXQJyPRKgM4QGtzH1xWZN
         UONZi1HdjhtG0nFp1GaH9HcPtpN7JAEvv5ySSD2gB/pn4DqHRLzHHBov0vK2yejCF5/C
         xJzc/wupIDchO0kZqEHp5HgNqMxbcOyQC2AypsK2OQgi9Qx5/FmyiefeKU1wNm+jNeDO
         a+aCOlnlJtSu1ekmS4eSh4DBS9kt0r3Fi2ikDsik/rHPdxWVNDZckepJ2HYDO7MoTnmL
         fnoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792564389; x=1793169189;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=18n/60G5UEDa0C6MjWfXpEqGEqrbjjWZh6b5p0dIK7E=;
        b=l2j8AyZZ0AfvvXjRL8JtVRlVIJu4VnGFjaw+PrJS5hvqEP6gAFsdOtsZ8DczqFPrj5
         Sewa/u4AaYWXbDKrdSLdMFxoX2sQJksgym5tbOL28Lq91QOvwG4vMihUMboeP4FxOVBD
         atVPqLYHPh95Z7jw9/rtsobAYcORJbZK774U5yp7UOU5uAW88rzjKdUKW4eK94/le/RE
         Fig3Sb5BHa6gSkAxY8i+LijcFcr1M0pXrwikW2CBNQu8fNRLIFJQapHNUPhgPRJBpE43
         q9GiTUWSTzcA9Tho7Ge9pVWQKny5H31ujvnUmzaJEbsYWtgmR5WTIMdEh5H0N319ASkW
         7K3g==
X-Gm-Message-State: AFq9FYIvP57yMBzGRpz9vv7K8axUdo7i/eLqDAX8PzZr3gqlsOk+hdGi
	HOtN0I/CW71PLGmxoUrwaEIs3d//kIXWy7rpxKd+ihYgzEdecsxbQgKrME0Q6A==
X-Gm-Gg: AYBFou1LoMVgQy9FfO/85uu+JIBUXGTXWxSbPvTU1dCXfgWuM0x9nm3EfSyIUTkGZva
	g6KOuSrWTF8f5xZBKavKaXo/0nBcfXvpZOeymA5TlcCBu/fSdeCuNjUeWEAP4pueYAzXRMOoha1
	gQpxOimoAcuH0yhQKKm0JMvCtiZ8TE9Mf3mbfkgLARfB+ptkzH6tPWyHocurLYrw1L5jaRCttk2
	xJWSzpcc36J96BqNjtizT7xOSuA8eODYSCFl8l903tUMFkI8d3cg2i199ddPaUB0MakNP+Q0ZBw
	GiLZPiUFmMWtEgoHiUn5wLXpit+Ub2ExkiqaGG3l2DwTPzql4V60v+1zLbRC6dCu72CRGkZLfPf
	+oS+nG1av6ZdDPSJyVGBHqUG8XTz37vLGN3pbdCxgnIhT8UI7ls3V8VgHcyPdHe+TRxaL6KoEqn
	D8yHAmJdOxVWGUYQ1I2DJSQXDmd249UiwFGc+HJgY0hA/a16eg6OnB5EEN071tF4nBnMIPeLqIe
	jNDm7tMx+s8zAMfy+cDyk1LZKcEFmVEmFLYxhk90mdEMur/h6OzR/IqXiVDn5csLelp3q/huCsg
	/lL9VzBNBuCjklxFX4jn06e/XgzcCiBDn5EWrd3jN/ad8stDsdsgvqTetapzuDucTEpZnd4R0dg
	b2eQLlLYIZg6Ch0lgBC5WyDWWNZayWzATbiVtMedT5kOtvGddeCHCggDNGgnPeo8tEA==
X-Received: by 2002:a05:6000:1841:b0:48a:f320:dba0 with SMTP id ffacd0b85a97d-48e264e0550mr1758811f8f.45.1792564389118;
        Tue, 20 Oct 2026 23:33:09 -0700 (PDT)
Received: from christian--20230123--2G7D3 ([62.35.114.108])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e2581eedesm3130790f8f.14.2026.10.20.23.33.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2026 23:33:08 -0700 (PDT)
From: Christian Couder <christian.couder@gmail.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	"brian m . carlson" <sandals@crustytoothpaste.net>,
	Patrick Steinhardt <ps@pks.im>,
	Elijah Newren <newren@gmail.com>,
	Jeff King <peff@peff.net>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Christian Couder <christian.couder@gmail.com>
Subject: [PATCH 04/13] odb: implement interoperability functions
Date: Wed, 21 Oct 2026 08:32:36 +0200
Message-ID: <20261021063245.2917625-5-christian.couder@gmail.com>
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

An object database running with a compatibility algorithm needs a way
to map object IDs from one algorithm to another and to write mappings
into the repository.  Add these functions and implement them for the
"files" backend and for the "loose" and "packed" sources it is made of,
so that we can use them in the future.

Like when reading objects, the "files" backend looks up mappings in all
of its object directories. It starts with the main one and continues
with alternates, which is what the loose object map code already does.

If a mapping is not found in a directory, the loose object map of that
directory is reloaded and checked again, as another process may have
written new mappings in the meantime. New mappings are only written
into the main object directory, which is also where new objects are
written.

Note that the "packed" sources don't write any information, since that
will be written when we index the pack, and they don't currently read
any information, since we don't yet have support for pack index v3,
which we'll need to read this properly.  This functionality will come
in a future commit.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
Signed-off-by: Christian Couder <christian.couder@gmail.com>
---
 odb.c               | 17 ++++++++++++
 odb.h               | 24 +++++++++++++++++
 odb/source-files.c  | 38 ++++++++++++++++++++++++++
 odb/source-loose.c  | 27 +++++++++++++++++++
 odb/source-packed.c | 19 +++++++++++++
 odb/source.h        | 65 +++++++++++++++++++++++++++++++++++++++++++++
 6 files changed, 190 insertions(+)

diff --git a/odb.c b/odb.c
index 98c5c862f5..a0a1be7c7e 100644
--- a/odb.c
+++ b/odb.c
@@ -590,6 +590,23 @@ int odb_count_objects(struct object_database *odb,
 	return ret;
 }
 
+int odb_map_oid(struct object_database *odb,
+		const struct object_id *src,
+		const struct git_hash_algo *to,
+		struct object_id *dest,
+		enum odb_map_oid_flags flags)
+{
+	return odb_source_map_oid(odb->source, src, to, dest, flags);
+}
+
+int odb_write_oid_map(struct object_database *odb,
+		      const struct object_id *oid,
+		      const struct object_id *compat_oid,
+		      enum odb_write_oid_map_flags flags)
+{
+	return odb_source_write_oid_map(odb->source, oid, compat_oid, flags);
+}
+
 /*
  * Return the slot of the most-significant bit set in "val". There are various
  * ways to do this quickly with fls() or __builtin_clzl(), but speed is
diff --git a/odb.h b/odb.h
index 0ccc47ee73..70af2c7c78 100644
--- a/odb.h
+++ b/odb.h
@@ -2,6 +2,7 @@
 #define ODB_H
 
 #include "hashmap.h"
+#include "loose.h"
 #include "object.h"
 #include "oid-array.h"
 #include "oidset.h"
@@ -649,6 +650,29 @@ static inline int odb_write_object(struct object_database *odb,
 
 struct odb_stream;
 
+enum odb_map_oid_flags {
+	/* Reload this source to obtain any new information. */
+	ODB_MAP_OID_RELOAD = (1 << 0),
+};
+
+int odb_map_oid(struct object_database *odb,
+		const struct object_id *src,
+		const struct git_hash_algo *to,
+		struct object_id *dest,
+		enum odb_map_oid_flags flags);
+
+enum odb_write_oid_map_flags {
+	/*
+	 * Serialize this data to disk instead of persisting it only in memory.
+	 */
+	ODB_WRITE_OID_MAP_WRITE = OBJ_MAP_WRITE,
+};
+
+int odb_write_oid_map(struct object_database *odb,
+		      const struct object_id *oid,
+		      const struct object_id *compat_oid,
+		      enum odb_write_oid_map_flags flags);
+
 int odb_write_object_stream(struct object_database *odb,
 			    struct odb_stream *stream,
 			    struct object_id *oid);
diff --git a/odb/source-files.c b/odb/source-files.c
index 455f409db0..4f4f7f1f87 100644
--- a/odb/source-files.c
+++ b/odb/source-files.c
@@ -6,6 +6,7 @@
 #include "gettext.h"
 #include "hex.h"
 #include "lockfile.h"
+#include "loose.h"
 #include "object-file.h"
 #include "odb.h"
 #include "odb/source.h"
@@ -1234,6 +1235,41 @@ struct odb_files_dir *odb_source_files_find_dir(struct object_database *odb, con
 	return dir;
 }
 
+static int odb_source_files_map_oid(struct odb_source *source,
+				    const struct object_id *src,
+				    const struct git_hash_algo *to,
+				    struct object_id *dest,
+				    enum odb_map_oid_flags flags)
+{
+	struct odb_source_files *files = odb_source_files_downcast(source);
+
+	for (struct odb_files_dir *dir = files->dirs; dir; dir = dir->next) {
+		int ret;
+
+		ret = odb_source_map_oid(&dir->loose->base, src, to, dest, flags);
+		if (ret != -1)
+			return ret;
+		ret = odb_source_map_oid(&dir->packed->base, src, to, dest, flags);
+		if (ret != -1)
+			return ret;
+		ret = odb_source_map_oid(&dir->loose->base, src, to, dest,
+					 flags | ODB_MAP_OID_RELOAD);
+		if (ret != -1)
+			return ret;
+	}
+
+	return -1;
+}
+
+static inline int odb_source_files_write_oid_map(struct odb_source *source,
+						 const struct object_id *oid,
+						 const struct object_id *compat_oid,
+						 enum odb_write_oid_map_flags flags)
+{
+	struct odb_source_files *files = odb_source_files_downcast(source);
+	return odb_source_write_oid_map(&files->dirs->loose->base, oid, compat_oid, flags);
+}
+
 struct odb_source_files *odb_source_files_new(struct object_database *odb,
 					      enum odb_new_flags flags)
 {
@@ -1271,6 +1307,8 @@ struct odb_source_files *odb_source_files_new(struct object_database *odb,
 	files->base.write_object = odb_source_files_write_object;
 	files->base.write_object_stream = odb_source_files_write_object_stream;
 	files->base.begin_transaction = odb_source_files_begin_transaction;
+	files->base.map_oid = odb_source_files_map_oid;
+	files->base.write_oid_map = odb_source_files_write_oid_map;
 	files->base.optimize = odb_source_files_optimize;
 	files->base.optimize_required = odb_source_files_optimize_required;
 	files->base.generate_pack = odb_source_files_generate_pack;
diff --git a/odb/source-loose.c b/odb/source-loose.c
index b58184f31d..22c46bd64a 100644
--- a/odb/source-loose.c
+++ b/odb/source-loose.c
@@ -1017,6 +1017,31 @@ static void odb_source_loose_reparent(const char *old_cwd,
 	loose->base.path = path;
 }
 
+static int odb_source_loose_map_oid(struct odb_source *source, const struct object_id *src,
+				    const struct git_hash_algo *to, struct object_id *dest,
+				    enum odb_map_oid_flags flags)
+{
+	struct odb_source_loose *loose = odb_source_loose_downcast(source);
+	/*
+	 * We may have loaded the object map at repo initialization but
+	 * another process (perhaps upstream of a pipe from us) may have
+	 * written a new object into the map.  If the object is missing,
+	 * let's reload the map to see if the object has appeared.
+	 */
+	if (flags & ODB_MAP_OID_RELOAD)
+		loose_object_map_load(loose);
+	return source_loose_object_map_oid(loose, src, to, dest);
+}
+
+static inline int odb_source_loose_write_oid_map(struct odb_source *source,
+						 const struct object_id *oid,
+						 const struct object_id *compat_oid,
+						 enum odb_write_oid_map_flags flags)
+{
+	struct odb_source_loose *loose = odb_source_loose_downcast(source);
+	return source_add_loose_object_map(loose, oid, compat_oid, flags);
+}
+
 static void odb_source_loose_free(struct odb_source *source)
 {
 	struct odb_source_loose *loose = odb_source_loose_downcast(source);
@@ -1139,6 +1164,8 @@ struct odb_source_loose *odb_source_loose_new(struct object_database *odb,
 	loose->base.write_object = odb_source_loose_write_object;
 	loose->base.write_object_stream = odb_source_loose_write_object_stream;
 	loose->base.begin_transaction = odb_source_loose_begin_transaction;
+	loose->base.map_oid = odb_source_loose_map_oid;
+	loose->base.write_oid_map = odb_source_loose_write_oid_map;
 
 	if (!is_absolute_path(loose->base.path))
 		chdir_notify_register(odb_source_loose_reparent, loose);
diff --git a/odb/source-packed.c b/odb/source-packed.c
index 2226fbd313..ee1edfdb2b 100644
--- a/odb/source-packed.c
+++ b/odb/source-packed.c
@@ -863,6 +863,23 @@ static void odb_source_packed_close(struct odb_source *source)
 	packed->midx = NULL;
 }
 
+static int odb_source_packed_map_oid(struct odb_source *source UNUSED,
+				     const struct object_id *src UNUSED,
+				     const struct git_hash_algo *to UNUSED,
+				     struct object_id *dest UNUSED,
+				     enum odb_map_oid_flags flags UNUSED)
+{
+	return -1;
+}
+
+static inline int odb_source_packed_write_oid_map(struct odb_source *source UNUSED,
+						  const struct object_id *oid UNUSED,
+						  const struct object_id *compat_oid UNUSED,
+						  enum odb_write_oid_map_flags flags UNUSED)
+{
+	return -1;
+}
+
 static void odb_source_packed_free(struct odb_source *source)
 {
 	struct odb_source_packed *packed = odb_source_packed_downcast(source);
@@ -1013,6 +1030,8 @@ struct odb_source_packed *odb_source_packed_new(struct object_database *odb,
 	packed->base.write_object = odb_source_packed_write_object;
 	packed->base.write_object_stream = odb_source_packed_write_object_stream;
 	packed->base.begin_transaction = odb_source_packed_begin_transaction;
+	packed->base.map_oid = odb_source_packed_map_oid;
+	packed->base.write_oid_map = odb_source_packed_write_oid_map;
 
 	if (!is_absolute_path(path))
 		chdir_notify_register(odb_source_packed_reparent, packed);
diff --git a/odb/source.h b/odb/source.h
index 1867347dfc..e1f01359ce 100644
--- a/odb/source.h
+++ b/odb/source.h
@@ -300,6 +300,42 @@ struct odb_source {
 	 */
 	int (*fsck)(struct odb_source *source,
 		    struct odb_fsck_options *options);
+
+	/*
+	 * This callback is expected to provide the mapping of an object from
+	 * the algorithm specified in src to the algorithm specified in to,
+	 * leaving the result in dest.  flags is a combination of `enum
+	 * odb_map_oid_flags` values: with ODB_MAP_OID_RELOAD, the source should
+	 * reload its mapping data before the lookup, as another process may
+	 * have written new mappings in the meantime.
+	 *
+	 * The algo field in src must point to a valid algorithm (specifically,
+	 * it must not be zero).  to must likewise point to a valid algorithm;
+	 * it must be non-NULL.
+	 *
+	 * The callback is expected to return 0 on success, -1 if the object is
+	 * not found, and a different negative error code on error.
+	 */
+	int (*map_oid)(struct odb_source *source, const struct object_id *src,
+		       const struct git_hash_algo *to, struct object_id *dest,
+		       enum odb_map_oid_flags flags);
+
+	/*
+	 * This callback is expected to write a mapping of an object between oid
+	 * and compat_oid.  flags is a combination of `enum
+	 * odb_write_oid_map_flags` values: with ODB_WRITE_OID_MAP_WRITE, the
+	 * mapping should be persisted to disk; otherwise it may only be kept in
+	 * memory.
+	 *
+	 * The algo fields in oid and compat_oid must point to valid algorithms
+	 * (specifically, they must not be zero).
+	 *
+	 * The callback is expected to return 0 on success, and a negative
+	 * error code on error.
+	 */
+	int (*write_oid_map)(struct odb_source *source, const struct object_id *oid,
+			     const struct object_id *compat_oid,
+			     enum odb_write_oid_map_flags flags);
 };
 
 /*
@@ -555,4 +591,33 @@ static inline int odb_source_fsck(struct odb_source *source,
 	return source->fsck(source, opts);
 }
 
+/*
+ * Map the specified object ID into the specified algorithm.
+ *
+ * Returns 0 on success, -1 if the object is not found, and a different negative
+ * error code otherwise.
+ */
+static inline int odb_source_map_oid(struct odb_source *source,
+				    const struct object_id *src,
+				    const struct git_hash_algo *to,
+				    struct object_id *dest,
+				    int flags)
+{
+	return source->map_oid(source, src, to, dest, flags);
+}
+
+/*
+ * Create a mapping between the two object IDs, which should be in the main and
+ * compatibility hash algorithms.
+ *
+ * Returns 0 on success, a negative error otherwise.
+ */
+static inline int odb_source_write_oid_map(struct odb_source *source,
+					   const struct object_id *oid,
+					   const struct object_id *compat_oid,
+					   int flags)
+{
+	return source->write_oid_map(source, oid, compat_oid, flags);
+}
+
 #endif
-- 
2.56.0.215.g47fdf2208c

