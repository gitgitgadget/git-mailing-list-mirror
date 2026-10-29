Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.161.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793233463;
	b=O3iMjZm2jDFrgy2M58WfbI2FhRpJjfdcQs2QmuqwQczMoAT8hDdGYE7fx1YVhB7e+PrG
	 4qP1UqjiZA1VWynPfP7mfILNSK2B1Biw5+18KL1prdFztQeR9CSuiwRpMqC067QyxDCu5
	 +bkXScdONmuyFurOKaLufyptpqSL4dd8aZ/opp+XSIwVEOfRU2+EbNIKTPVzPF3J1F7+s
	 nHcOS5gcjs7btNGK7M1CQYhra3oTJPuq5iIE4LFaS3nAjpUbG5lVhQ92UW+V+m/g29PDb
	 rNUWPehPkhBEn1oCSs2wXvwJHexLqsqasiuevXzsbw/4Is2xXsEbHFIFvGM5gjWReZw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793233463;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=cC8Lqz3CnsZVQVYva5XOb6xrWvEyc3oGUeiKfeNK1xw=;
	b=PIJ5qswrCFSGP/IhqAB0hlhlMPkBRS1BwERhnEsOkQU2vnw2l8fFKaVB33PybHxt91uQ
	 OnfN4Yotf0zOSNpZv7AaRMVH57Tlma9T8pUsxHLC34YWp/IfLC0f70GsH6oJC2gsrB9AE
	 3hWWRO2XW8AFvtfo93c183mhn4E9+bnLniQ7YRyPEQpTJgNm/efWFHLy7lcwb+N4HBRBr
	 HKzvG7oQAXZ4h3+n9IdJF09W905rvLhcYdfx0fJZZLL61vT3RnUXIPvFHpCC5mngc1Cgm
	 ypmmkyfJEG6434m1uG5AqOwyOsfDBVKjmsgTGfK70DHDaGWZtHR/K/15vKMRO+Su70A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=tAVNJjiB;
	arc=none smtp.remote-ip=209.85.161.46
Received: from mail-oo1-f46.google.com (mail-oo1-f46.google.com [209.85.161.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D16D60A2603
	for <git@vger.kernel.org>; Thu, 29 Oct 2026 00:24:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6D16D60A2603
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=tAVNJjiB
Received: by mail-oo1-f46.google.com with SMTP id 006d021491bc7-702fd86d674so1094795eaf.2
        for <git@vger.kernel.org>; Wed, 28 Oct 2026 17:24:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793233462; x=1793838262; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=cC8Lqz3CnsZVQVYva5XOb6xrWvEyc3oGUeiKfeNK1xw=;
        b=tAVNJjiBm1QPo2xqDnw0rpBJzy6xq3+zcgBZrumZGCTjnan0BmuL2M1NCdGGqF3Q/M
         C7PtMVrtXeR0vj5aygUfiH0NePc9luDjE5VMF+KqbF/oERljo2gpQGCyLMJmeXlVZxOD
         2laOQWOI992vwVNxe0c9AD8Dmle4Wvwe8bmu53kvPfnTQaxzAhYpmoJc/CsLZC1RRGUO
         rsuwvSNfE4HtCDIPFbbG/QBWIgGMErhso83i+i1v2zZoMXMLHn5Uy0MDKk6Jk1+WnIJb
         6/W7Nprarp/WKRiYtO0IPtVmyzGS/4YozdPPeIsRJt4pPhX4lxY1QCxUm0PPyvg1m/7B
         DG6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793233462; x=1793838262;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=cC8Lqz3CnsZVQVYva5XOb6xrWvEyc3oGUeiKfeNK1xw=;
        b=ydWNDZVOKlOS7KbuzPayHbS0VY+2Lyzb3ptMOU5nohN6eLAaCJjpA2qbDqZyG4LK2i
         3t5t30CdH0OIC/jhtJAswvounEqrfB9uI8phGI70nXdIWpl/UrTCKsmoIXrvGToo+/ky
         VkwVF/zOlb3XNUYuGdaJgYP+OPWX82SCefFr+sohomALQHT10Kr/HmMOEM2jjxZBNJEZ
         J0MWeu4o7lIpPqGgj2/WP/kvzGfRj+TmrTyCHBXxN/kH1cmU3pEO8JNjOXIb5RuNtheq
         9ZL6UOjbND2O6LDILmmygkTdOdtZvSag8mr6lgecv11uFGfPIml7mZHM3+r6ABZCOHZT
         YOfQ==
X-Gm-Message-State: AFq9FYLrtosb4gWcLRCWWMhxuymAlEw8hRme19ofbwyHUyadXWuFjoVd
	B02wDKqArH6/TXmNGLBQUn4acew4ArWHioLVjrHmPMMhnSxQ9jSe6oVcuZmslQ==
X-Gm-Gg: AYBFou3HZqNKQnzVfKskbjAJrRvUBTbOInz8deJNub3OwoOGda0BtwDHComTUCGh64T
	GgFXiWThoB5+3FcKtIbmmNZeVbxeF/YVLlTaMCWviQh4p+fxzajtZsabBLYgbF2mR7EOiKxM/oN
	9rvZILbpn3jkcaZcquJIHMH6WVdjkCOyOismyD4AQgdZPdl5onz28RRypXZ2iwbcTUcLljsDlVq
	luq/ycTkMgOQdm0qi02ixH+Nq2pCRV8PqMtVptC8v1nJsZMr+EC2PWDP5DLA+B1seee9NfaeAAn
	lkweSfJyAQ+eMy5j3LHJo2NVsU+6lcQ/LODfILe3v+2Fn9jAX9V7O3j1ZhP7AnOUCI7pcHYESx/
	KaePt/WdCexnu/wji7DORN6+zRXlag95begA7P2xjjhGl+GFYY/4MGaXp8d40aqrxV1HRXMo4Vc
	NKSzVYfvwTK6ZT0E13ENYoOTKNQqBe5njdytY4+ki6BrMKnUZRA7HLLvKUO83Rzj6kJqiUhJIWo
	HGlKmsEpqgR8CXZLpjN9296XHFv2OuGdhWRuH2ZzlXXY9alL2r3se3jgGxStobKauWk1SzfnGV8
	7xS7hdT4r7x2RkrnX74VJlOJJPeLOI79DdCwXei+o6A46nuZ43Bwq+Au9KDIanPwq3kh9U0cXb4
	zrqdWL39Bf/sTog==
X-Received: by 2002:a05:6820:a513:10b0:6cd:3ffc:e339 with SMTP id 006d021491bc7-713f06cfe2emr1667309eaf.87.1793233462123;
        Wed, 28 Oct 2026 17:24:22 -0700 (PDT)
Received: from denethor.localdomain ([136.51.44.64])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-7142bb7942fsm2976439eaf.5.2026.10.28.17.24.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2026 17:24:21 -0700 (PDT)
From: Justin Tobler <jltobler@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im,
	Justin Tobler <jltobler@gmail.com>
Subject: [PATCH v2 4/4] tmp-objdir: merge loose object index when migrating tmpdir
Date: Wed, 28 Oct 2026 19:24:13 -0500
Message-ID: <20261029002413.3291184-5-jltobler@gmail.com>
X-Mailer: git-send-email 2.56.0.173.gf57c9a7388
In-Reply-To: <20261029002413.3291184-1-jltobler@gmail.com>
References: <20261022234007.3081825-1-jltobler@gmail.com>
 <20261029002413.3291184-1-jltobler@gmail.com>
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

When a repository is configured with a compatibility hash, each loose
object write also records a mapping between the object and its
compatibility hash in a "loose-object-idx" file. This mapping file is
located in the same object directory the object is written to. If batch
fsync of loose objects is also enabled, the loose objects and mapping
file are instead written to a temporary object directory and expected to
be migrated to the primary object directory when the batch transaction
commits.

While migrating the loose objects works, the "loose-object-idx" file is
unable to be migrated if a mapping file already exists in the primary
object directory. This occurs because `finalize_object_file_flags()`
expects an already existing file to have the same contents. Otherwise,
the following error is returned:

  error: files '.git/objects/tmp_objdir-bulk-fsync-XXXXXX/loose-object-idx' and '.git/objects/loose-object-idx' differ in contents
  error: unable to migrate temporary objects

Furthermore, it is not sufficient to just replace the preexisting
mapping file with the new one as the new file only contains mapping
entries for the newly written objects.

Update the temporary directory migration logic to handle
"loose-object-idx" files explicitly by merging new entries and
atomically writing the resulting mapping file.

Signed-off-by: Justin Tobler <jltobler@gmail.com>
---
 loose.c                       | 47 +++++++++++++++++++++++++++++++++++
 loose.h                       |  2 ++
 t/t1016-compatObjectFormat.sh | 27 ++++++++++++++++++++
 tmp-objdir.c                  | 11 +++++++-
 4 files changed, 86 insertions(+), 1 deletion(-)

diff --git a/loose.c b/loose.c
index f2e111c25e..36da63684f 100644
--- a/loose.c
+++ b/loose.c
@@ -311,3 +311,50 @@ void loose_object_map_clear(struct loose_object_map **map)
 	free(m);
 	*map = NULL;
 }
+
+int loose_object_idx_merge(struct repository *repo, const char *src,
+			   const char *dst)
+{
+	struct lock_file lock = LOCK_INIT;
+	struct loose_object_map *map;
+	int ret;
+	int fd;
+
+	loose_object_map_init(&map);
+
+	fd = repo_hold_lock_file_for_update_timeout(repo, &lock, dst, 0,
+						    LOOSE_OBJECT_IDX_LOCK_TIMEOUT_MS);
+	if (fd < 0) {
+		ret = error_errno(_("unable to lock %s"), dst);
+		goto out;
+	}
+
+	if (loose_object_map_read(repo, dst, map, NULL) < 0) {
+		ret = error(_("unable to read loose object index %s"), dst);
+		goto out;
+	}
+
+	if (loose_object_map_read(repo, src, map, NULL) < 0) {
+		ret = error(_("unable to read loose object index %s"), src);
+		goto out;
+	}
+
+	if (loose_object_map_write(repo, map, fd) < 0) {
+		ret = error_errno(_("unable to write %s"),
+				  get_lock_file_path(&lock));
+		goto out;
+	}
+
+	if (commit_lock_file(&lock) < 0) {
+		ret = error_errno(_("unable to write %s"), dst);
+		goto out;
+	}
+
+	ret = 0;
+
+out:
+	loose_object_map_clear(&map);
+	rollback_lock_file(&lock);
+
+	return ret;
+}
diff --git a/loose.h b/loose.h
index ed663ac550..35b46f4be5 100644
--- a/loose.h
+++ b/loose.h
@@ -23,5 +23,7 @@ int repo_add_loose_object_map(struct odb_source_loose *loose,
 			      const struct object_id *compat_oid);
 int repo_read_loose_object_map(struct repository *repo);
 int repo_write_loose_object_map(struct repository *repo);
+int loose_object_idx_merge(struct repository *repo, const char *src,
+			   const char *dst);
 
 #endif
diff --git a/t/t1016-compatObjectFormat.sh b/t/t1016-compatObjectFormat.sh
index 9cafcee509..6d0f48226f 100755
--- a/t/t1016-compatObjectFormat.sh
+++ b/t/t1016-compatObjectFormat.sh
@@ -305,4 +305,31 @@ compare_oids GPG2 'commit' signedcommit4 "$signedcommit4_sha1_oid" "$signedcommi
 compare_oids GPG2 'tag' signedtag3 "$signedtag3_sha1_oid" "$signedtag3_sha256_oid"
 compare_oids GPG2 'tag' signedtag4 "$signedtag4_sha1_oid" "$signedtag4_sha256_oid"
 
+test_expect_success 'batched fsync migrates loose object index' '
+	test_when_finished "rm -rf batch-fsync" &&
+	git init --object-format=sha1 batch-fsync &&
+	(
+		cd batch-fsync &&
+		git config core.repositoryFormatVersion 1 &&
+		git config extensions.compatObjectFormat sha256 &&
+		git config core.fsync loose-object &&
+		git config core.fsyncMethod batch &&
+
+		# Write object to generate initial loose object index.
+		echo foo >foo &&
+		git add foo &&
+		test_grep "$(git rev-parse :foo)" .git/objects/loose-object-idx &&
+
+		# Write some additional objects and ensure the corresponding
+		# temporary loose object index entries stored in the transaction
+		# are merged into the primary object directory.
+		echo bar >bar &&
+		echo baz >baz &&
+		git add bar baz &&
+		test_grep "$(git rev-parse :foo)" .git/objects/loose-object-idx &&
+		test_grep "$(git rev-parse :bar)" .git/objects/loose-object-idx &&
+		test_grep "$(git rev-parse :baz)" .git/objects/loose-object-idx
+	)
+'
+
 test_done
diff --git a/tmp-objdir.c b/tmp-objdir.c
index 3debb60270..5307717354 100644
--- a/tmp-objdir.c
+++ b/tmp-objdir.c
@@ -4,6 +4,7 @@
 #include "chdir-notify.h"
 #include "dir.h"
 #include "environment.h"
+#include "loose.h"
 #include "object-file.h"
 #include "path.h"
 #include "string-list.h"
@@ -294,6 +295,11 @@ static int is_loose_object_shard(const char *name)
 	return strlen(name) == 2 && isxdigit(name[0]) && isxdigit(name[1]);
 }
 
+static int is_loose_object_idx(const char *name)
+{
+	return !strcmp(name, "loose-object-idx");
+}
+
 static int migrate_paths(struct tmp_objdir *t,
 			 struct strbuf *src, struct strbuf *dst,
 			 enum finalize_object_file_flags flags)
@@ -317,7 +323,10 @@ static int migrate_paths(struct tmp_objdir *t,
 		if (is_loose_object_shard(name))
 			flags_copy |= FOF_SKIP_COLLISION_CHECK;
 
-		ret |= migrate_one(t, src, dst, flags_copy);
+		if (is_loose_object_idx(name))
+			ret |= loose_object_idx_merge(t->repo, src->buf, dst->buf);
+		else
+			ret |= migrate_one(t, src, dst, flags_copy);
 
 		strbuf_setlen(src, src_len);
 		strbuf_setlen(dst, dst_len);
-- 
2.56.0.173.gf57c9a7388

