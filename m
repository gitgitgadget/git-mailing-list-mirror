Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 031F2424641
	for <git@vger.kernel.org>; Thu, 16 Jul 2026 13:29:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784208590; cv=none; b=jgFfp1W7MHqAD/VbuAo8payp6GoFsyDq6PLupCbHtn6/U4eppqBuv+MZqROoZ3NQeP5q/wN4ix7ck6W2w/ycTKPxs2OrrqealmdUpqaT8Q7+RpLvmWcgPxd8auqTMLlIa9OmZ8BnpMZXIkybeAAa/P62202Oecl6JySCMKsAlSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784208590; c=relaxed/simple;
	bh=k5raMSvrQaXofF00ELxlndCPuAod0cN5/GBmfwi3tiY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Efg6IT807Bb1ykD2HhHKoTcM2hEiDiWFCDQHob0vU5fL1vfmj9OikJeegE9+oQ7iWugCxibEL/HUd+icdnIJQUbNQ0lRrF/bw4Q1a85tCM0iljTFAyuTIuHL1QZSV52ryMZMoOas0vNsl9+dKSE76YWV28k50G0GRNrmS7rvpgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IxLyT/tn; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IxLyT/tn"
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-c95d0a54ea5so4887659a12.0
        for <git@vger.kernel.org>; Thu, 16 Jul 2026 06:29:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784208588; x=1784813388; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=n0lqwp4hu7KJYbp+SgIL+qQuugoDkz3TLIfYnx0OYTI=;
        b=IxLyT/tnNGpY6rTGgeKHJxgVnHOxUG4gNMkThQxvuBomtNRXxTJALpXNWamtxmpNGc
         R+P2B/XMHNtL6Mekd0aZS3o7Vody0Uxq9BmAHpvMnwg/K7qm5xzYGjOukYv/5hlwKqQt
         2t4VuSTpSK4pnePhSPDbaAUuIi0V17gceCb4vqHbQH+qQbvpUXsjJkADHuiIlCnaZMxA
         j+mG5/1aD4SDwI5iF+zEOGy5KuyvwWnwvkPG5zYNU0aBmJqrA7FqYkqbsDGtkXSU/ePS
         Ev8409ecFS9uYX1uWti7jNBdZWRYPDxqKZbWgMs5oP0CzwRfSkddOwa9ufv6hIjP/tO8
         90nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784208588; x=1784813388;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=n0lqwp4hu7KJYbp+SgIL+qQuugoDkz3TLIfYnx0OYTI=;
        b=bnIAqeyCRcLrxafX0J3FtGtq0wQtNbrpafTWNJTk9x0GT+KzEt5cIjqQeTzh+sbf34
         AnULmAgv5+2l1fKN2NiH6OT8SzABUqeUGb3qyJRTT64wwcNOHjj6gyyakNdnTTrczG6G
         PU0CmuUhHT8QUy9yi/huq2v4p7mYU5zS7iBh/2OcTYSX4W122yfONyvWiJAHbp7671CX
         CRWvfwpbV4BnJofWHSaoEDc+1RwwQFM+bnLqFGrOfB7VqagFoanYS5e8LLfDmGL38n6G
         27XRv4lM0fYNMibe8F4uSLbdm3hCvB6wh2XC2o6Z1ef7tOX+U1BDmz/IMKFA8L6nrJvP
         BN7g==
X-Gm-Message-State: AOJu0YwgC8s0OckKDPH29wj7Kf9T8UvoUQrzuV6BfQoGKnn97q+T3CVL
	TRjyopkUIcDrzQp/PSHVPWqetgYHW6oR/zY6Wr4NkSJ9inhyovoIxn6/I9btSEXP
X-Gm-Gg: AfdE7ckxqDC995pppiivUlXr4HUCDJeTWScdtWwKktcCxsO/KFsG1qXv1CMuaABAaXU
	hk6HMrM8uko56tN9VQ6am3T8g8grxx/DeRfRbdHAwonAAPixIQPiYKC/HQUIBsKUOEA7aPhzybi
	eJzNM/etzNUrHdMHrSLPFU3F4UVSEU/WEcrH046lGX7jqmGUIaX/PdFPkfNSnzol91qtOosi04P
	FxHm22Aoc2RpH0JuN7+2O5avV3CQosw8y/uNFr5fTy02WOhHDYs3Fhxhmm+oRxWFFN61l9pcezf
	kOydHEqHyUMwO3bubB30EcpjEfwi1pZLR8XPt244EHHnZZDU9cg50apzjBpMWb9BhU1hMcQAVXw
	+2kpguhZEdXDf0YVypEWdRg3LrvGhBURue+s8lr3wi3paCjihvHjOV+sI/EPw7kuDRcC40Ygy/5
	hcRbE67SkMJLeKgacqVj2Ou5oN2q7LWwK0nPVcaPqndtf+KodqVwTE7mnOO35ovKR8BIUNRhkzy
	QudjzXfhBa6IdwP/t+4ag7LTSXZNXXhIZF9pYpJGCmw
X-Received: by 2002:a05:6a20:394e:b0:3bf:6c05:ab with SMTP id adf61e73a8af0-3c34d8935e6mr13055146637.58.1784208588030;
        Thu, 16 Jul 2026 06:29:48 -0700 (PDT)
Received: from localhost.localdomain ([2401:4900:88fb:4543:3010:936c:4da8:7aa1])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3140e4fcd31sm13291188eec.4.2026.07.16.06.29.44
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 16 Jul 2026 06:29:47 -0700 (PDT)
From: Siddharth Shrimali <r.siddharth.shrimali@gmail.com>
To: git@vger.kernel.org
Cc: gitster@pobox.com,
	christian.couder@gmail.com,
	siddharthasthana31@gmail.com,
	me@ttaylorr.com,
	ps@pks.im,
	johannes.schindelin@gmx.de,
	l.s.r@web.de,
	r.siddharth.shrimali@gmail.com
Subject: [RFC PATCH 6/7] builtin/repack: actually drop filtered promisor blobs
Date: Thu, 16 Jul 2026 18:58:47 +0530
Message-ID: <20260716132848.95982-7-r.siddharth.shrimali@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260716132848.95982-1-r.siddharth.shrimali@gmail.com>
References: <20260716132848.95982-1-r.siddharth.shrimali@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Make --drop-filtered remove the enumerated promisor blobs instead of
only listing them.

The drop set is computed before repack_promisor_objects() runs, and on
a real run it is passed in so the rebuilt promisor pack omits those
blobs. --drop-filtered implies -d so the old promisor packs, which
still contain the dropped blobs, are removed. Without this the blobs
would survive in the redundant packs. The existing repack machinery
performs the write-before-delete and fsync, so the drop is crash-safe.

The dropped blobs become absent locally but remain recoverable from the
promisor remote, so a later access lazy-fetches them back
transparently. --dry-run keeps its previous behavior, i.e. it lists the
candidates and changes nothing.

Mentored-by: Christian Couder <christian.couder@gmail.com>
Mentored-by: Siddharth Asthana <siddharthasthana31@gmail.com>
Signed-off-by: Siddharth Shrimali <r.siddharth.shrimali@gmail.com>
---
 builtin/repack.c                | 75 ++++++++++++++++++---------------
 repack-filtered.c               | 17 ++------
 repack.h                        |  4 +-
 t/t7706-repack-drop-filtered.sh | 18 +++++---
 4 files changed, 59 insertions(+), 55 deletions(-)

diff --git a/builtin/repack.c b/builtin/repack.c
index c2b07477d2..aa3257a98a 100644
--- a/builtin/repack.c
+++ b/builtin/repack.c
@@ -15,6 +15,8 @@
 #include "repack.h"
 #include "shallow.h"
 #include "list-objects-filter-options.h"
+#include "oidset.h"
+#include "hex.h"
 
 #define ALL_INTO_ONE 1
 #define LOOSEN_UNREACHABLE 2
@@ -143,6 +145,7 @@ int cmd_repack(int argc,
 	struct string_list_item *item;
 	struct string_list names = STRING_LIST_INIT_DUP;
 	struct existing_packs existing = EXISTING_PACKS_INIT;
+	struct oidset drop_oids = OIDSET_INIT;
 	struct pack_geometry geometry = { 0 };
 	struct tempfile *refs_snapshot = NULL;
 	int i, ret;
@@ -269,9 +272,6 @@ int cmd_repack(int argc,
 		die(_("--dry-run only takes effect with --drop-filtered"));
 
 	if (drop_filtered) {
-		if (!dry_run)
-			die(_("--drop-filtered doesn't work without --dry-run yet"));
-
 		if (!po_args.filter_options.choice)
 			die(_("--drop-filtered requires --filter"));
 
@@ -294,6 +294,28 @@ int cmd_repack(int argc,
 			die(_("--drop-filtered requires a promisor remote"));
 
 		write_bitmaps = 0;
+
+		/*
+		 * Dropping objects means rebuilding the promisor packs
+		 * without them and then removing the old packs, so the
+		 * redundant packs must be deleted. Imply -d on a real run.
+		 */
+		if (!dry_run)
+			delete_redundant = 1;
+
+		ret = enumerate_promisor_blobs(repo, &po_args.filter_options, &drop_oids);
+
+		if (ret)
+			goto cleanup;
+
+		if (dry_run) {
+			struct oidset_iter iter;
+			const struct object_id *oid;
+
+			oidset_iter_init(&drop_oids, &iter);
+			while ((oid = oidset_iter_next(&iter)))
+				printf("%s\n", oid_to_hex(oid));
+		}
 	}
 
 	if (delete_redundant && repo->repository_format_precious_objects)
@@ -406,7 +428,8 @@ int cmd_repack(int argc,
 		strvec_push(&cmd.args, "--delta-islands");
 
 	if (pack_everything & ALL_INTO_ONE) {
-		repack_promisor_objects(repo, &po_args, &names, packtmp, NULL);
+		repack_promisor_objects(repo, &po_args, &names, packtmp,
+			(drop_filtered && !dry_run) ? &drop_oids : NULL);
 
 		if (existing_packs_has_non_kept(&existing) &&
 		    delete_redundant &&
@@ -589,35 +612,20 @@ int cmd_repack(int argc,
 		}
 	}
 
-	if (po_args.filter_options.choice) {
-		if (drop_filtered) {
-			/*
-			 * Enumerate promisor objects directly rather than
-			 * going through write_filtered_pack(). The filter
-			 * machinery cannot see promisor objects because
-			 * repack_promisor_objects() handles them separately
-			 * before the filter runs.
-			 */
-			ret = enumerate_promisor_blobs(repo,
-					&po_args.filter_options,
-					dry_run);
-			if (ret)
-				goto cleanup;
-		} else {
-			struct write_pack_opts opts = {
-				.po_args = &po_args,
-				.destination = filter_to,
-				.packdir = packdir,
-				.packtmp = packtmp,
-			};
-
-			if (!opts.destination)
-				opts.destination = packtmp;
-
-			ret = write_filtered_pack(&opts, &existing, &names);
-			if (ret)
-				goto cleanup;
-		}
+	if (po_args.filter_options.choice && !drop_filtered) {
+		struct write_pack_opts opts = {
+			.po_args = &po_args,
+			.destination = filter_to,
+			.packdir = packdir,
+			.packtmp = packtmp,
+		};
+
+		if (!opts.destination)
+			opts.destination = packtmp;
+
+		ret = write_filtered_pack(&opts, &existing, &names);
+		if (ret)
+			goto cleanup;
 	}
 
 	string_list_sort(&names);
@@ -697,6 +705,7 @@ int cmd_repack(int argc,
 cleanup:
 	string_list_clear(&keep_pack_list, 0);
 	string_list_clear(&names, 1);
+	oidset_clear(&drop_oids);
 	existing_packs_release(&existing);
 	pack_geometry_release(&geometry);
 	pack_objects_args_release(&po_args);
diff --git a/repack-filtered.c b/repack-filtered.c
index f5a1dae5b1..6f0cecca9b 100644
--- a/repack-filtered.c
+++ b/repack-filtered.c
@@ -87,16 +87,13 @@ static int collect_promisor_blob(const struct object_id *oid,
 
 int enumerate_promisor_blobs(struct repository *repo,
 			const struct list_objects_filter_options *filter,
-			int dry_run)
+			struct oidset *to_drop)
 {
 	struct oidset all_promisor_blobs = OIDSET_INIT;
-	struct oidset to_drop = OIDSET_INIT;
 	struct collect_cb_data cb = {
 		.repo = repo,
 		.set = &all_promisor_blobs
 	};
-	struct oidset_iter iter;
-	const struct object_id *oid;
 	int ret = 0;
 
 	/*
@@ -122,22 +119,14 @@ int enumerate_promisor_blobs(struct repository *repo,
 
 	/*
 	 * Apply the filter to find which blobs exceed the threshold.
+	 * The caller has to_drop and is responsible for clearing it.
 	 */
 	ret = list_objects_filter__filter_oidset(repo,
 		(struct list_objects_filter_options *)filter,
 		&all_promisor_blobs,
-		&to_drop);
-	if (ret)
-		goto cleanup;
-
-	if (dry_run) {
-		oidset_iter_init(&to_drop, &iter);
-		while ((oid = oidset_iter_next(&iter)))
-			printf("%s\n", oid_to_hex(oid));
-	}
+		to_drop);
 
 cleanup:
 	oidset_clear(&all_promisor_blobs);
-	oidset_clear(&to_drop);
 	return ret;
 }
diff --git a/repack.h b/repack.h
index d08e25b852..61e554e4ed 100644
--- a/repack.h
+++ b/repack.h
@@ -168,8 +168,8 @@ int write_filtered_pack(const struct write_pack_opts *opts,
 			struct string_list *names);
 
 int enumerate_promisor_blobs(struct repository *repo,
-			       const struct list_objects_filter_options *filter,
-			       int dry_run);
+			     const struct list_objects_filter_options *filter,
+			     struct oidset *to_drop);
 
 int write_cruft_pack(const struct write_pack_opts *opts,
 		     const char *cruft_expiration,
diff --git a/t/t7706-repack-drop-filtered.sh b/t/t7706-repack-drop-filtered.sh
index b558807847..41e7941799 100755
--- a/t/t7706-repack-drop-filtered.sh
+++ b/t/t7706-repack-drop-filtered.sh
@@ -56,12 +56,6 @@ test_expect_success '--dry-run only takes effect with --drop-filtered' '
 	test_grep "dry-run only takes effect with --drop-filtered" err
 '
 
-test_expect_success '--drop-filtered without --dry-run is rejected' '
-	test_must_fail git -C plain.git repack --drop-filtered \
-		--filter=blob:limit=1k -a 2>err &&
-	test_grep "drop-filtered doesn.t work without --dry-run yet" err
-'
-
 test_expect_success '--drop-filtered requires -a' '
 	test_must_fail git -C plain.git repack --drop-filtered \
 		--filter=blob:limit=1k --dry-run 2>err &&
@@ -136,4 +130,16 @@ test_expect_success '--dry-run does not remove the filtered objects' '
 	git -C repo cat-file -e "$BIG"
 '
 
+test_expect_success '--drop-filtered removes the promisor blob locally' '
+	BIG=$(cat big_oid) &&
+	SMALL=$(cat small_oid) &&
+
+	git -C repo -c repack.writeBitmaps=false \
+		repack --drop-filtered --filter=blob:limit=1k -a &&
+
+	git -C repo cat-file --batch-all-objects --batch-check="%(objectname)" >present &&
+	! grep -q "$BIG" present &&
+	grep -q "$SMALL" present
+'
+
 test_done
-- 
2.54.0

