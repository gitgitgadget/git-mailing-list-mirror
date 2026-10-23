Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792740384;
	b=kcc2dUERTazP4fsi5oVMub+lF6dMKjRXUF23xqxmYrU/rB+efqqSf2/v30YDv7ndTrII
	 PSPDkZUEB3z0jl3Wkpcrp/uHxmYwbO27wHOtSwOnC3KhsSF/Um4c+3PP3luMHMQcEcsge
	 qfnFwiqfCqeI8d8tp2pQ7PAkGH6ixAJYo6CwJbYuSeCDXldOoinrj6wmRdm8/b2eGBLQ3
	 zLbWUllrYnx+cTi0FxgN0bkGgiwFOClQhXQlIuBUTbQnj+D2fiCmw74PsTVCZwJe86NYD
	 trgjp6b8MIW2UZWhIyNoQmoXMwDCQNhhhpI+NzMsdTkB9Vu3aNFUBa2/f8+5m43UdVQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792740384;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=18n/60G5UEDa0C6MjWfXpEqGEqrbjjWZh6b5p0dIK7E=;
	b=4iV2vE3TwrdWgAhCO7uY2T2BT33k2iChrvaJR8QGTyNwUPpeqnDKNN2LZ75m8PJEKDda
	 ALMYNjlniz3urC7AlRjXQ0u28zMry0O1QGtYJ4iyuekVzHXa486cV5fHifmoTj099V/DS
	 4qdXusONRx0BvCNE8yd5nfoU2m0oh8Shx9yJfGukOQdBbFdVkbdgeWz1wZus3pqAARftO
	 QuXLLTXTnNbjpkaAdNfsGaEoTM7zABPKsYDlRjU3cqvD/HtH2oMNoTA1LQvO5nEFd8H6q
	 SCMBBcvLMZlQ2ruB+LA4ofXXX9yxbZ7dDlly1se1c1zhuby+Po9W6W7oOj9i7puG8Hg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=ry4dWjBu;
	arc=none smtp.remote-ip=209.85.221.42
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9664606A320
	for <git@vger.kernel.org>; Fri, 23 Oct 2026 07:26:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D9664606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=ry4dWjBu
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-48e09aa5264so281190f8f.2
        for <git@vger.kernel.org>; Fri, 23 Oct 2026 00:26:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792740382; x=1793345182; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=18n/60G5UEDa0C6MjWfXpEqGEqrbjjWZh6b5p0dIK7E=;
        b=ry4dWjBuzD39to7SiolXFEwVk76isgaBFI4CH0JOXJdsFcByQ1w/POJo7eTd8Q+2/p
         xlwgFto3q205TMZ6rwgZQ9QhlzF4FqKASDII074/dyqpJEpwiXk4mD1+zWrJK/IUePvu
         JDQgs0NrbzO1mgCYD/lVfAIhfg5p8+mCMirFYICNUC9tTc/xgK2gdPNGFUPSsLwEV6Cr
         YqfBXH/KqxO9baezNj5xeJAeksycrISv6awx8iQVW5ocY9neiskQecQpYZtYPkktF/th
         qw2UmOhi6wj/0R/YiV8XJdP6CcCBx/U1F87/zDQojLoa1aNc64OioBNEgHvi+N2HsOyG
         ZUAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792740382; x=1793345182;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=18n/60G5UEDa0C6MjWfXpEqGEqrbjjWZh6b5p0dIK7E=;
        b=Z0RcWC2ic8pG36VMAeChEOtVtoh486E303rGdt5LaUPIFnzKY6H2HC0E8KboFh0Q1d
         qqaKt3FJFEAI5zEavb32gZIcENgP4IZeaWAyJKlIh4KFbmAAq/I6JS1+IYrMO6B5rvF0
         vV7ggUFMw65DWRKp784rob4ZqFZCcbeKerEWq2K0fosPkCRQvHmDbd6UhgdvNRAeRMLE
         JL8URuJvp4Co+EXfjiOwyz0jnX9kB0J3sRJGw3slXYoL0WERoHAgceUv/abEf7Av/76V
         /j4FLDgHCvE+fcW57nDdXs5QvoAGwPiXwCmcyh98yBVqp6ct+bvw3OPCvaRPIvYVwGMR
         4VnQ==
X-Gm-Message-State: AFq9FYK3l9EjTB5jkClOVnACu8RNc/YiONCJ4U9HGhMlGfI41X5XZwI1
	pF2W28sT8ujwE5RXJRoSNayXbHskRfYVvhPhXU+ZedPcMFweZ4WBYbjESCV2mA==
X-Gm-Gg: AYBFou1iskH0f6aQQBYH4j6eOqRX2nj6uARx2TV63oL3mrwFqFL8aQzC87XPOZtVgR8
	9yXcxMVW23u7exEiNS+8HkyFv0LNneGrJNHIY9zYwyWoGXSd/6gXPvvXAe4KtLY2EyTlXr2YwFo
	DaMsrB9wmN4C+571QME0cnmgacGKhf2vjNqAV3wcG2ai130KWcpXyrHToBeGIY9eYKJ1DKn/u/K
	yjUh+8Wle1MF3L9KF/QglLXbsg8pyI2OuVh6z3DXeTod1Tey/crxfQLIwn3LP3+5rOeSu3eQEEh
	zFOzG82752PwjBgCDchR0Tm7m1A8BWntMM0VJhoeGSHnNwjCfZpI/skpAbDtxPkLdOPkoUcZLqH
	DSMdWBlQCtlq3H89mhTfNQqPoFXwQxir6/wGDdu+0i3ZCz1dZgdC7jNqEiaYRnF7Cquq9H2WF55
	75DjPIRR5tcQgs7VURf/DXs8x8LdfPByT0ZWONnLH1zNZMfExWs6J2ZqTpcJjGLiqIefz8C9Rtq
	DVofAxL1azS4wr5f4tztRV9r/rzgJdDIsHONDKQ5OOff+3BkHbKenQPMBBDBgzms0yIt8BgUeRC
	ZcNM28byT6lo+EFoVk4mJMp66HiJMSWB5gZuQUAulHgwCkiuxYvr2DLnTEBRDb5q5CpF9N4ZJ80
	DIo7w2Kvjt2yMemFcELSqIMRHvc8sWOa8Mks9Dbv0y7Z8oOet11POKPOHfp2U81uQTw==
X-Received: by 2002:a05:6000:2906:b0:48e:3647:c35d with SMTP id ffacd0b85a97d-48e385ab10dmr1777764f8f.21.1792740382101;
        Fri, 23 Oct 2026 00:26:22 -0700 (PDT)
Received: from christian--20230123--2G7D3 ([62.35.114.108])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e38055da4sm3228024f8f.43.2026.10.23.00.26.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2026 00:26:20 -0700 (PDT)
From: Christian Couder <christian.couder@gmail.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	"brian m . carlson" <sandals@crustytoothpaste.net>,
	Patrick Steinhardt <ps@pks.im>,
	Elijah Newren <newren@gmail.com>,
	Jeff King <peff@peff.net>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Christian Couder <christian.couder@gmail.com>
Subject: [PATCH v2 04/13] odb: implement interoperability functions
Date: Fri, 23 Oct 2026 09:25:49 +0200
Message-ID: <20261023072559.3204273-5-christian.couder@gmail.com>
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

