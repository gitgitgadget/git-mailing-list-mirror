Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793316170;
	b=QSes18dEA5PW4H1YOntegJlnYqdv95GsxQV2YzBbIL5L8d8bBgJAkrNsyJZOX/fZbFxw
	 DjppkjUUTAFym16b3ahWr8rqRn8QyEd2a2InTOUsv97RsXjo9wpdjILQpdU1riLTuRy8N
	 WIaKHU8Pav1KJAP6KDK2OC8YYzzuRrUS4R76uv8yswF8ivLhI1aCskUnhMoWTRxaGVlu1
	 xE8ctGlAiiQVJt1YvRKrPl5dyGyuWDT5N0kWR9qDGy7x1fzbvBZOgJXoiU9yj3awmK9o5
	 Uh1QnbtdYHDMIX2ZZwrFrzc3F0YL1HAVDPbIxixjVHoFjcH6koVZoc8YRJrUHzYzNrw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793316170;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=i4aMT8SxvP1z1bsTkpsXtjweXGIc4nwVtTI0CVr21Lg=;
	b=EmXDIYeebmLvQbUZLe608ATjmcCKEhVBWEMi07Z+lMCP2VFWg2fQtG4edulIryG+dxCf
	 kg65qMafJX6K9JQ2V3z/ZrhjtYV3LrDlCDl68O4kGDg1zJvEPRCdy0ITQuM045Rn5Rmqg
	 vov6Bg2QV6g3DScwD87svq+PvMIx+pMGSrq9sgdgp2SA805ysTlHl1S8pPLjXnz3WsQ8X
	 56mVhjH1vKwhxa3Y2Mov/JVLo3Zd87GDIG//b+1PmzT2y1e0Ei7fHFE3n6JguUwciTXJ1
	 TxUsgM8/nD2lpzx8a4j4ZLMa8s76X+N+tniYPscDIud/thBnJ7wbH7avGpFOQjG5e6g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=wIddIZBm;
	arc=none smtp.remote-ip=209.85.210.42
Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com [209.85.210.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D5FD606A32A
	for <git@vger.kernel.org>; Thu, 29 Oct 2026 23:22:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0D5FD606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=wIddIZBm
Received: by mail-ot1-f42.google.com with SMTP id 46e09a7af769-8490a7d6696so129885a34.3
        for <git@vger.kernel.org>; Thu, 29 Oct 2026 16:22:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793316169; x=1793920969; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=i4aMT8SxvP1z1bsTkpsXtjweXGIc4nwVtTI0CVr21Lg=;
        b=wIddIZBmtD4/UPZGugL6LhqF2pc+qy3j4VQVQv5Q6h4kJ0cwb/3qkMxlO9EkHd1/5N
         raAhMqG7Er3zdkS24qc8kbXrAjLZDPw34zQXw873MR3d2q06nImEN+EG77jjG86tp+Iy
         TQToN/WsqsApmaq8GeNDEh06PnCrF2mxQPiZjXmpRTyIANosD52NXlWJqUIEgo+94X0k
         fjhrq9jc/u9mN2j6X7nnUMhVTCgCES0KROZE/rC1qTAcj+zefjdA3adRaistlMx2geuF
         TBc1Q/HxcHZGZ62BJKgsDGULHfxRcI1BrrczAHdJIOt5h0iomRQQt5TJlYTjFVlNuqOG
         kzhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793316169; x=1793920969;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=i4aMT8SxvP1z1bsTkpsXtjweXGIc4nwVtTI0CVr21Lg=;
        b=KFlEuFHpn3hd9y899U8sliOeJeuJGFtbvtWWfXB/HqmVN+stPCkkbZ+sV7n5UFxf4n
         Qu28KSy43Jlc7+CQWrYtoEffHAvQ7VUgme8RYxWGczagUA21mIFYmFbBtwQIppHl7QtA
         QM9kqE4fvDG06h0mLtp3LqkIWT5XLfVRWXzZyD+CK7MqYvuK5SVWey9cVPZT9UBrpV6E
         Lw/bfUuiDpheVmz+23XPQQTB2cSkhBD1amOCUCKIuI6cVAKZ6TGYX7NTZ0f6z2zpHrTY
         zn5UjrNHJ6+izCNK7r1IZ9s4bZNU0w2ci++dTFUuVkVtGdPBCMLsp7XAguEM2c25G/SR
         WitQ==
X-Gm-Message-State: AFq9FYKKYlK0XLQ38RCwkxj2P8ybUfcXa2ANCNVxK0SN2lwy4wPGGHNd
	tlBGbJEbnTXiG8gtkbVyZ8DrmN0WvnGHRZhKrSNt/P4ZiViDFiNuHQAN13yZQg==
X-Gm-Gg: AYBFou3PK540eZKi+hFhWsaVq7mbLx21rL2zPt4iufaPW+4n5+mlMKH2M3BpQXA9Chk
	fK0KgHtWjlt40YDAmir8cjcY+So4xZcOfPymNsa183EOlUQxZsRkLDcq9PVlHtYzO+SLlXttiwb
	1CFQmMHEMEfroM8Qz+KxG9Kw+pdgN7lv033ViKUXQmXbeS3pV2YrljbnbM1aiEJJcm8WB186pac
	xf2hBLeBzhnWb3iM0q79Luu3BpUCqwJ+3e/Rj0rf/VcBael2UjwOcWzmHwNuvub+agKZTk/xc6g
	aNBldtYNq0Y5EkEjhodO+CO593A8OtcgP6k04pejEBmPfly6VCOunRKV9aEYAtpVeAmh8Qd2niu
	6ed+ev4lKweVB1VM73Osg0kZ4Uloh/C30JQ1f5taEsQRMluoez4j9NDOBv2UbwIAmCkcWRMSpMV
	W8+4VF1mbwWzZWOLozHQoBBHfALRGfsEFAH91obOVLtsQ0zmZTTYDcfzMqW0wQ/MsXlNrRA1KGW
	J9iO96czv3JyFNFgSMsW32d3wsoOXhA8kNAV3iJRfba8PpSP8Fa4Qcb00PCYraZW6XD4iGwqojO
	G5tJtNpdSE5+qu4zEVHNz5twyY0di/8VIwSzOVIipw87hCQaTFqNz/CyVonvzkr85H+D
X-Received: by 2002:a05:6830:2e06:b0:843:98dd:84e4 with SMTP id 46e09a7af769-85d362e11c8mr725303a34.3.1793316168926;
        Thu, 29 Oct 2026 16:22:48 -0700 (PDT)
Received: from denethor.localdomain ([136.51.44.64])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-85d354d05e0sm694924a34.15.2026.10.29.16.22.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2026 16:22:48 -0700 (PDT)
From: Justin Tobler <jltobler@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im,
	Justin Tobler <jltobler@gmail.com>
Subject: [PATCH v3 4/4] tmp-objdir: merge loose object index when migrating tmpdir
Date: Thu, 29 Oct 2026 18:22:20 -0500
Message-ID: <20261029232220.1245827-5-jltobler@gmail.com>
X-Mailer: git-send-email 2.56.0.173.gf57c9a7388
In-Reply-To: <20261029232220.1245827-1-jltobler@gmail.com>
References: <20261029002413.3291184-1-jltobler@gmail.com>
 <20261029232220.1245827-1-jltobler@gmail.com>
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
 loose.h                       |  9 +++++++
 t/t1016-compatObjectFormat.sh | 27 ++++++++++++++++++++
 tmp-objdir.c                  | 11 +++++++-
 4 files changed, 93 insertions(+), 1 deletion(-)

diff --git a/loose.c b/loose.c
index f2e111c25e..0ce9c7486e 100644
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
+	if (loose_object_map_read(repo, src, map, NULL) < 0) {
+		ret = error(_("unable to read loose object index %s"), src);
+		goto out;
+	}
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
index ed663ac550..6ad82dc0bb 100644
--- a/loose.h
+++ b/loose.h
@@ -24,4 +24,13 @@ int repo_add_loose_object_map(struct odb_source_loose *loose,
 int repo_read_loose_object_map(struct repository *repo);
 int repo_write_loose_object_map(struct repository *repo);
 
+/*
+ * Merge the mapping entries of the loose object index at `src` into the one at
+ * `dst`. The resulting mapping file is written atomically.
+ *
+ * Returns 0 on success, a negative error code otherwise.
+ */
+int loose_object_idx_merge(struct repository *repo, const char *src,
+			   const char *dst);
+
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

