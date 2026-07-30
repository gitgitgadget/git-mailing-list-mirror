Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFB6125B08E
	for <git@vger.kernel.org>; Thu, 30 Jul 2026 17:42:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785433378; cv=none; b=flEOkz3US1kIbXgg+qU9MW3Nl1gVnzYwJ23nW5eMPZIjU0K1XmBur29d+uWcCHIYKslln9tymN3RnGHJGLwD84nmcokFCI2eBSCZI3oulTkdhBSeEjId/TR3ckYCyHXEjf78Dp6SaUHCLVHM8wmUiQrgnJGp+CFskYyb/JHD+j8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785433378; c=relaxed/simple;
	bh=VirNGcS8oaI6rKwE5WWFgA1mwcFlVtEntB+1WWkK5Bc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BfiiinbtghKTzUKwjXoPbVhsNfe6saTi7CayrS5zblKbnXpHdsE+aXE2SDEDsNRicB4fQqiSwby+fyREX+b9VFo7T3iaC+ylQeG9ZR5l6oJTDyfNYSFPGIKFmgIoEph/lDkv6wWd2WwJrih4oFq5Zfq8KjNhygg/SJDmPM+jFm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PDLFzg8j; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PDLFzg8j"
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-84862b0d5aeso205748b3a.2
        for <git@vger.kernel.org>; Thu, 30 Jul 2026 10:42:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785433376; x=1786038176; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=k5U1Aq5k5HvH2SqpX0EArPkuLFNSDoQ6r1SJ+4hkJ7I=;
        b=PDLFzg8jzEtGALaSL85vLi1t6XDO+z1Prm5wl/uC6jU4szB2c7D8H2f2kMhc19itUf
         SuAMhwFuPPaK5ngVAzGlVYWgoPI7k/esfUyUvJfsDmgbpkKpqmS/CtHgPAHGP/zYnDce
         TY97u03zY2DlHIgD+uHmXkucEICNpws1D4htHhiW+j0+r+Cf5yMvi6kpsPjAGQoC9qH4
         2L7FrnOM3OMDl0cP6ZkS33ycQf/1mPRqmmxOLCIGWqXLcp7rHB0ehSzzqDvqwZs6JSHg
         HUuFYLvoYk2sdwWttutfZTl66A8lBwSWEwkg9urd9Eshd7J1PbLzWpNIkUVkgj2CtiOG
         QpsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785433376; x=1786038176;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=k5U1Aq5k5HvH2SqpX0EArPkuLFNSDoQ6r1SJ+4hkJ7I=;
        b=hUxYItKWuJubi4tEtn0jCdik+uPa2EpPawRzfGqKhJpFgRDEx0HThLQ3n7P6DKOsdf
         Q3UNzAfQzXEkduWOg4Aju2A25Qv4YiHG2eWJ/1Lj6elCu1flmf+RusERvs/XEljzciw+
         HwPPCXhRralbjQV/WxsmAXDPeJROhfTQGj+yRfDZMItkLuwU0GXEKUkTaBz+4xuozx8o
         1opyc4eG7YBJHfDq3cyztzUvdNWjr5DodCwwV8okXEpygseuJpgGsOIK+VrhMEhObS0G
         qFQt6Pdh6Zc/Zh9A0XdiJpVkPTwYsgQMLHAuKOy/cVik20aHPgBzdS+etlBFDwKa6HsM
         5S/g==
X-Gm-Message-State: AOJu0YyJkFjQzm/9LMGkbqffepViqU4n3TUJ+MMxI1MsD2MG9/e6O7OH
	snhStkd/YTQd4rsV0+2IURJk+NAhghCc1LuU2v71331h7h+Fm2TCk8g3jD2G1g==
X-Gm-Gg: AR+sD13978PMdtWb41O8xW/reqCczpYrvS3sRs4wKbzk64269vt4nyqpLAUo7tqmNY7
	MHZjReBys/Z+q5KgRavMO6JTcjPr9iAyWMzPMEgovocFZx5IrQWcXT2RkGxUe0Jz9UaOl/OxEp9
	bgfYBRk+BTQuiEEsBDYu+DlYBUDXMwfwJvMEY4b+TRmXP/g9fnIvM5wYZ+ITv3ScKRtoo51Flq1
	5ZAF727tIrr5mG0D9IMFLOJDZdgHcKJmUS+qT0lBOialotnTkIAKQ2lI+ZSv73DdIrV4mR0YOJK
	vh9BNE24NZLwIb5z/0RNRhql02Te6b1IveYvWUW7Z1GQOakbQoOeim4p5wcLtupp70MhIPZvZ8Q
	0QBAC/U/Jgl4kYtGcyaD7HW258nRxKepc6SczeM+rxzWd5ArNN8mWouC0zf9/Pn4XhGj/IIeivN
	ScsDYAINIBL7yv5PDf/P6pqRmM0hNHPovU5A7DMJrIVMXn7ZEzHxk07133T2oWOA8vl2jogCv0S
	mtfwemnJVnF0qRC83wjDf/mofHmnr7bJsBxYDDhZg5dbiqjqDSnjjifu8xDFN/6KCaCFQXTiVJa
	ZRobR88cPOd/NrAkLN2Qph4BPOFM
X-Received: by 2002:a05:6300:670e:b0:3bf:735d:7fb8 with SMTP id adf61e73a8af0-3c9006712d5mr3404357637.27.1785433375830;
        Thu, 30 Jul 2026 10:42:55 -0700 (PDT)
Received: from localhost.localdomain ([2401:4900:5622:d88b:20c4:5444:d41a:b6c2])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-31504cc9dffsm25163964eec.14.2026.07.30.10.42.50
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 30 Jul 2026 10:42:55 -0700 (PDT)
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
Subject: [GSoC PATCH v2 6/7] builtin/repack: add safety guards for --drop-filtered
Date: Thu, 30 Jul 2026 23:11:52 +0530
Message-ID: <20260730174153.9949-7-r.siddharth.shrimali@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260730174153.9949-1-r.siddharth.shrimali@gmail.com>
References: <20260716132848.95982-1-r.siddharth.shrimali@gmail.com>
 <20260730174153.9949-1-r.siddharth.shrimali@gmail.com>
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
 builtin/repack.c                | 47 +++++++++++++++++++++++++++++++++
 t/t7706-repack-drop-filtered.sh | 36 +++++++++++++++++++++++++
 2 files changed, 83 insertions(+)

diff --git a/builtin/repack.c b/builtin/repack.c
index 9a15ab1f2a..2339bcaac4 100644
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
@@ -309,6 +311,28 @@ int cmd_repack(int argc,
 		if (!repo_has_promisor_remote(repo))
 			die(_("--drop-filtered requires a promisor remote"));
 
+		/*
+		 * refuse to drop objects while another operation is in
+		 * progress. the working tree and index are in an
+		 * intermediate state, and rewriting packs in a half-finished
+		 * merge/rebase/cherry-pick/revert/bisect is unsafe
+		 * bare repositories have no such state, so the check
+		 * is skipped there
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
@@ -324,6 +348,29 @@ int cmd_repack(int argc,
 		if (ret)
 			goto cleanup;
 
+		/*
+		 * refuse to drop blobs that the current index references.
+		 * dropping such a blob would cause the very next command
+		 * that touches the worktree to lazy-fetch it straight back, so
+		 * the drop would reclaim nothing. bare repositories have no
+		 * index, so the check is skipped there.
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
index b3e493e851..dabed97541 100755
--- a/t/t7706-repack-drop-filtered.sh
+++ b/t/t7706-repack-drop-filtered.sh
@@ -140,4 +140,40 @@ test_expect_success '--drop-filtered removes the promisor blob locally' '
 	grep -q "$SMALL" present
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

