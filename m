Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31244424D65
	for <git@vger.kernel.org>; Mon, 10 Aug 2026 17:41:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786383701; cv=none; b=Ycv20Tfu7tEUyt7aXp1uNpnTifm5/xgX28czAlN3fYc13qgtw1vE3fJgVS690QfYTXhzgB038LInirqglkSQSK3VzsH2UE17MTpD/zxxBf69dUElwSRMfYwZsBs0X8dqPk16ZXDvp3czs594CH7YkP77QAdClSXPUtWnvBYZp5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786383701; c=relaxed/simple;
	bh=w2Etn8n9MMa0gY9GpNjZ3z+BQb+6jP+u70f0Rl4lfGE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nf+B43BLmd/gDlrBKuqUbxRubgCHbEF1oqBzQ9HU3tTbCoToibGZOqQ3XVmRYQxmAVZ4819Qye7NuQ9s1JZQOXLZpf/Z/JO8XTo0UEvkdVinplrJHYsU97ZyOZBs9mb4N0sx1qqoY7DW4ZIIazMvmBjIi76cxJDnv+xdLvaFR9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iD3NCWTD; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iD3NCWTD"
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-38a0c7e841fso2787250a91.2
        for <git@vger.kernel.org>; Mon, 10 Aug 2026 10:41:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786383699; x=1786988499; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=0fJW469RKRDzqft4Wns+rgn+GUqzC7cWrje4bYTvyP0=;
        b=iD3NCWTDcgb0kyQW/BgTk0ZG7o8G4T4DPkXKIWQQKfxH1DYTemWrX4c4gQto8STJKV
         Yo9sT6YA8znthUUnHm5Qz5sP595QZf6kgROxcfCysfZQrfXqC5SwTAbE2b/yzcST+vLg
         VhUZ/eC2s1Crs3hViEPhlV5rX7/EpeubzOzURtRefAEoqqe1O8jGD/XP/AgcYBfTlX/t
         Mz3dPsn4XwAUAu6GsnmlXu2kvtAf0+bRtkXknxmegI9+BoXSWkoJYn6C273areY6054L
         Fc4O1M5Peb71zDZh+/cNEbvgiTilF9vUd3Guc6pCslMIo8iCPzVHtwi66KXtLXV1PxhZ
         KoGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786383699; x=1786988499;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=0fJW469RKRDzqft4Wns+rgn+GUqzC7cWrje4bYTvyP0=;
        b=KXZSLsu3mI2g8eGv0nd8gU0mjSgnIrNHXNwa0BdgJRn5T4Vbg6CVkNv4vtcCXw8lz7
         S9G+UtNjay7hp4worotDwwxO4oTYX1GD7DrbFqTZHTK1j1ggb+VM1Cr2OVIv1dgXkjBD
         CbGuEQfQhQAExDERhEN9A1SWwX7l5i2YxWefINDymUntM+uI5bY5NjMc/i2oALke69Sd
         46JIptGyeltQ0PlzbiuMKXuf0W56NFch8CmAi8aVLn4AT9aLjNyrk4KidSSUi6JvEMJk
         dXahkOMudQG1SlosFu0KB9MmGtO530g9uvJqe1WrhUcskrBuOIMJBFh225FwQ7LGk4vL
         /j5g==
X-Gm-Message-State: AOJu0YzO8RgfiUCCiW1RsLvfD7mYo0/Iccu5arQ+iOEhR86LG78Ahc+h
	TctKNgoP2TA/Ux/6Bue7G0yDZMsjy256C3ZE5AnlxcnhAeonphgVuxtWPPGywDV3
X-Gm-Gg: AR+sD13FGOFUewcXV1CcuSGq7fFPH9EAwj9DuXyOrkUsismn1UEnHKrv+RzCENgWlxg
	5VGIY6bGmrzoDc3YSLN5bqb4vwLpN932dOlnYwg1Xi8bkOqqFJOGFdONClYlCtyZ1TrveHpiYR9
	SjcCEPHKiF9gP+TO61A7NFh+9m/ryn0eD8YNFHsMVDF60souA9xuC6JFoCM9BVZOQgNXRlLZd9r
	PKH/ZbWbPNrC0wpqkXhX7e5MBesxd+Uw/v81F5Tj9Wf28LFhEyRT8A9bnGrCU2vgW/9iQpf42IO
	Nq7i5M9c5mVJ32dDwI08C1gtVaf9GlcVQBrYSKIcyxsDfz1FtEMCQ4Y8FzXPkS2elH3e5Ra70PP
	IPKj9Cq/Rs53Lur1K36RPz2vcN7KRTiRKqLxKbAvHyU/TbWZaDKbEMQC03FknP2a2fqQLW+dWKS
	m3H4V0+aOTcwqheadY9cHuiqRyVcojA3TTlNhvvV/WUyQBmun1c8i/HRdAl3G4c7my+P227u9Ug
	mLlvTWwU4zmAFjQ6ba9bC6HWLfbh8SoE3MRLxw50wy4i7uoiKsrIXfqQKt/VLxl+76tfsvIGCBu
	ztT889+9Uc4PSUX5Acq2Vg==
X-Received: by 2002:a17:90b:35c3:b0:390:b41a:b92b with SMTP id 98e67ed59e1d1-39261f71c58mr27467505a91.4.1786383699402;
        Mon, 10 Aug 2026 10:41:39 -0700 (PDT)
Received: from localhost.localdomain ([2401:4900:5026:8db8:20aa:c615:9a47:206a])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-14101b7b39bsm36865585c88.14.2026.08.10.10.41.34
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 10 Aug 2026 10:41:38 -0700 (PDT)
From: Siddharth Shrimali <r.siddharth.shrimali@gmail.com>
To: git@vger.kernel.org
Cc: gitster@pobox.com,
	christian.couder@gmail.com,
	siddharthasthana31@gmail.com,
	ttaylorr@openai.com,
	ps@pks.im,
	johannes.schindelin@gmx.de,
	l.s.r@web.de,
	r.siddharth.shrimali@gmail.com
Subject: [GSoC PATCH v4 6/7] builtin/repack: add guards for --drop-filtered
Date: Mon, 10 Aug 2026 23:10:46 +0530
Message-ID: <20260810174047.6524-7-r.siddharth.shrimali@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260810174047.6524-1-r.siddharth.shrimali@gmail.com>
References: <20260806112202.75067-1-r.siddharth.shrimali@gmail.com>
 <20260810174047.6524-1-r.siddharth.shrimali@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

--drop-filtered removes local promisor blobs. That is only safe when the
repository is not mid-operation and when the blobs are not actively in
use, so add two guards, both skipped for bare repositories which have
neither a worktree nor an index.

First, refuse to run while a merge, rebase, am, cherry-pick, revert, or
bisect is in progress. During these operations the working tree and
index are in an intermediate state, and rewriting packs and deleting
objects underneath a half-finished operation is unsafe.

Second, refuse to drop a blob that the current index references. Such a
blob is needed by the working tree, so dropping it would only cause the
next command that touches the worktree to lazy-fetch it straight back,
reclaiming nothing. The offending path is reported so the user can see
why the drop was refused.

Mentored-by: Christian Couder <christian.couder@gmail.com>
Mentored-by: Siddharth Asthana <siddharthasthana31@gmail.com>
Signed-off-by: Siddharth Shrimali <r.siddharth.shrimali@gmail.com>
---
 builtin/repack.c                | 49 +++++++++++++++++++++++++++++++++
 t/t7706-repack-drop-filtered.sh | 36 ++++++++++++++++++++++++
 2 files changed, 85 insertions(+)

diff --git a/builtin/repack.c b/builtin/repack.c
index e90016a33e..6ef4973038 100644
--- a/builtin/repack.c
+++ b/builtin/repack.c
@@ -17,6 +17,8 @@
 #include "list-objects-filter-options.h"
 #include "oidset.h"
 #include "hex.h"
+#include "wt-status.h"
+#include "read-cache-ll.h"
 
 #define ALL_INTO_ONE 1
 #define LOOSEN_UNREACHABLE 2
@@ -317,6 +319,30 @@ int cmd_repack(int argc,
 		if (!repo_has_promisor_remote(repo))
 			die(_("--drop-filtered requires a promisor remote"));
 
+		/*
+ 		 * refuse to run while another operation is in progress. A
+		 * dropped object would just be lazily re-fetched when the
+		 * operation resumes, but triggering a network fetch in the
+		 * middle of a half-finished
+		 * merge/rebase/cherry-pick/revert/bisect is a poor
+		 * experience, so this is a UX convenience rather than a
+		 * safety measure. Bare repositories have no such state, so
+		 * the check is skipped there.
+		 */
+		if (!is_bare_repository(repo)) {
+			struct wt_status_state state = { 0 };
+
+			wt_status_get_state(repo, &state, 0);
+			if (state.merge_in_progress || state.revert_in_progress ||
+			    state.rebase_in_progress ||state.bisect_in_progress ||
+			    state.cherry_pick_in_progress ||state.am_in_progress||
+			    state.rebase_interactive_in_progress) {
+				wt_status_state_free_buffers(&state);
+				die(_("--drop-filtered cannot be used while another operation is in progress"));
+			}
+			wt_status_state_free_buffers(&state);
+		}
+
 		write_bitmaps = 0;
 
 		/*
@@ -332,6 +358,29 @@ int cmd_repack(int argc,
 		if (ret)
 			goto cleanup;
 
+		/*
+ 		 * refuse to drop blobs that the current index references.
+		 * such a blob would only be lazily re-fetched by the next
+		 * command that touches the worktree, so dropping it reclaims
+		 * nothing. This guard just avoids that churn. bare
+		 * repositories have no index, so the check is skipped there.
+		 */
+		if (!is_bare_repository(repo) && oidset_size(&drop_oids)) {
+			struct index_state *istate = repo->index;
+			unsigned int i;
+
+			if (repo_read_index(repo) < 0)
+				die(_("could not read the index"));
+
+			for (i = 0; i < istate->cache_nr; i++) {
+				const struct cache_entry *ce = istate->cache[i];
+
+				if (oidset_contains(&drop_oids, &ce->oid))
+					die(_("cannot drop '%s' (%s): it is referenced by the current index"),
+						ce->name, oid_to_hex(&ce->oid));
+			}
+		}
+
 		if (dry_run) {
 			struct oidset_iter iter;
 			const struct object_id *oid;
diff --git a/t/t7706-repack-drop-filtered.sh b/t/t7706-repack-drop-filtered.sh
index ba00239c9d..05d58fa456 100755
--- a/t/t7706-repack-drop-filtered.sh
+++ b/t/t7706-repack-drop-filtered.sh
@@ -146,4 +146,40 @@ test_expect_success '--drop-filtered removes the promisor blob locally' '
 	test_grep "$SMALL" present
 '
 
+test_expect_success '--drop-filtered refuses when a merge is in progress' '
+	test_when_finished "git -C repo merge --abort || :" &&
+
+	# creat a conflicting merge so wt_status reports it
+	git -C repo checkout -B mergebase base &&
+	echo one >repo/conflict.txt &&
+	git -C repo add conflict.txt &&
+	git -C repo commit -m one &&
+
+	git -C repo checkout -B mergeother base &&
+	echo two >repo/conflict.txt &&
+	git -C repo add conflict.txt &&
+	git -C repo commit -m two &&
+
+	test_must_fail git -C repo merge mergebase &&
+
+	test_must_fail git -C repo -c repack.writeBitmaps=false \
+		repack --drop-filtered --filter=blob:limit=1k --dry-run -a 2>err &&
+	test_grep "in progress" err
+'
+
+
+test_expect_success '--drop-filtered refuses to drop an index-referenced blob' '
+	# create a large blob, add it to the index and make it a promisor object
+	# so the index references it and enumeration picks it up
+	test-tool genrandom idx 4096 >repo/tracked-big.bin &&
+	git -C repo add tracked-big.bin &&
+	OID=$(git -C repo rev-parse :tracked-big.bin) &&
+	printf "%s\n" "$OID" | pack_as_from_promisor >/dev/null &&
+	delete_object repo "$OID" &&
+
+	test_must_fail git -C repo -c repack.writeBitmaps=false \
+		repack --drop-filtered --filter=blob:limit=1k --dry-run -a 2>err &&
+	test_grep "referenced by the current index" err
+'
+
 test_done
-- 
2.54.0

