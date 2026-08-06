Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 491D53B1B3
	for <git@vger.kernel.org>; Thu,  6 Aug 2026 11:22:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786015366; cv=none; b=UPPQChG7g5HfO4u4gOEsxrwI6B0Hk7waSW3/RUPGFIRMLd4VBhyMSS0Pzc/O+9bUMyK5nbPrRkXr4Xyyb2Bwd7JU11Q7XnsBDTmMLX/h6i5Q7RokbLIwY0NBZuLlvTVlRAb7aMtaSGYtmv8KUfsIy3Wd314dTbDjoDnW71QGUQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786015366; c=relaxed/simple;
	bh=dOFhEMFBSjKPeK64dYDGDSvbYso1nTRV0fbXHPLYWmY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=b9X5O2y0K97dn2Xwv1CCOR5ghCnCpsZ8DqaFj/AE9Lv4uMTEsmn+C8T+NpNQxnYg5EDN77qkNSWIWAEpsrUpSvYJcNjP0DNLbDaZuKHliCkNEAw1Ovt/kMsTHFTqusk9wqxp931egt7nTyA6dgYEzyMdze+fSOPLTLeGIQmol9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A4IhwxvL; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A4IhwxvL"
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-c9b373d5af0so1680044a12.2
        for <git@vger.kernel.org>; Thu, 06 Aug 2026 04:22:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786015365; x=1786620165; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=fX0IwxDxt4yopWbHeN8bWKSSAIGUVPdNnRaPFzqLnlk=;
        b=A4IhwxvLYlUuWWKR5fYFawNJD6S25xZ5hdBJ/CL3AXuAHk1d5rwTQk8GG1Txp30Wbx
         33E1lgBPeM4XbF5MQX+TiN4DAkVRVIW1TFLKZHOOd/JvYoDEY4VnptvWBOXg0f87Yj7E
         sF71F4jrmOE7U4qVsoj8yIFisDSP6lKOUjhHlwlgfAwDzhdmUHvlmhM1GRFl6zDwJARo
         Hz7wG03YUPMHzWX5CC4l8KFn3+f6T+k0B9ARbA5mcYTs3UCp43fOw820tRscn9tAmoKZ
         4nOUUNsLA9spvVfjPpw/naRI03LRhEg3fZH3Dz0FkeHwZZDBNr/rl3Oa9NhvL14dIriQ
         C8Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786015365; x=1786620165;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=fX0IwxDxt4yopWbHeN8bWKSSAIGUVPdNnRaPFzqLnlk=;
        b=aKdpMB4h9fb3WKOg+qyKsCMxMAInLleLUewkuFlwxy3iQWMkJ0giJ3ghsOGLv9KRCg
         f7cTkyfMtFHzfXLljanVPcJgj4eNZvMvNUaNxDA68wnW8rTiI/0u6uWiQ7l+jfN/jG4j
         MqNLLx4P70w3lfw01fuf1FNRctgss0YmxYthP4L2wyFdDoKzAqzzWXubmTF6Jpw3bTfj
         hapselHKkVLQJf4Ox5sjKPhLFRxl9V3C9TSfsdN8LLaMHxZkQS4WKbNjBeGVlHC632X5
         s2V3IODWJX5Qqamb2MUHWbXQcInnF9Jn6yStwcecV555fbBGQ5rrFeh6KdaCQTwsF9Pf
         0ldg==
X-Gm-Message-State: AOJu0YzdeFfFEDINZVw2BoMh0zmDJm5oGed2M7Utj49Kpmop/Vt7SzgL
	pwq5BtrzNcyXMQlbuueJdzpeYqq3Sv2MoCfnYgYXiYa/ARDiAhr8etlYST7LCf6A
X-Gm-Gg: AR+sD11kDxCWICvKGg0bI/qhl6cZULNXgMZZjFCYGxGzRLXiCs2d3t1cDBm4Zwl5Tmn
	oD3QFJdilmn6x9KqIh+lHash/dsOiTUAGFPaTQJTx4KSOEF2rmsGpJ5Sq7Nq4fJPri4kVStaN2y
	x+rQoq8UA02zyWZdns/q7scUvjDVm0zPO16Kb2w6v4bYglrH4hZPnXyPSThV2L5l32VubHZfhXq
	tN8ylQIZ2vpPjkP0fOn/9I2XKyNKQvynAZd+fE6hOwuOrcfiNsWL0oIllImSNnXWohoAR0WXkDy
	edgcEfSjI+g10vEsY7J0mEfs1q7qMMzvAtD0y7YmxEk5Q5ch9ixFlhSMcxYP7MmMzp1VhBG/t8a
	eMVNSENXyr34NS+fVb9Ovbfbqi18EDHyuzuUYCiQNb2iJvk1NdeH2PSFU8z6WnxywyojTUd+8TA
	36xecgmIALz/7CTFkzzGk1Jc06HSsLrDQ4c4LFNq529nIsJcBGiCu2LIi1v8Iilr1+LF2yxWWrt
	Q5htz9daEBJVot+FQVI4XloA1LtNQCFSXwpi/cXpEyRWmE8Ty1zVNV3rJg5rDZvHQoU09x16vry
	J3JaJq+xORId
X-Received: by 2002:a05:6a20:9392:b0:3c3:a140:9380 with SMTP id adf61e73a8af0-3cb85e469d1mr15364697637.16.1786015364484;
        Thu, 06 Aug 2026 04:22:44 -0700 (PDT)
Received: from localhost.localdomain ([123.252.204.197])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13fca8df89asm42490376c88.9.2026.08.06.04.22.40
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 06 Aug 2026 04:22:44 -0700 (PDT)
From: Siddharth Shrimali <r.siddharth.shrimali@gmail.com>
To: git@vger.kernel.org
Cc: gitster@pobox.com,
	christian.couder@gmail.com,
	siddharthasthana31@gmail.com,
	ttaylorr@openai.com,
	me@ttaylorr.com,
	ps@pks.im,
	johannes.schindelin@gmx.de,
	l.s.r@web.de,
	r.siddharth.shrimali@gmail.com
Subject: [GSoC PATCH v3 6/7] builtin/repack: add guards for --drop-filtered
Date: Thu,  6 Aug 2026 16:52:01 +0530
Message-ID: <20260806112202.75067-7-r.siddharth.shrimali@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260806112202.75067-1-r.siddharth.shrimali@gmail.com>
References: <20260730174153.9949-1-r.siddharth.shrimali@gmail.com>
 <20260806112202.75067-1-r.siddharth.shrimali@gmail.com>
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
index a20589a7ae..170e94f8bd 100644
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
@@ -316,6 +318,30 @@ int cmd_repack(int argc,
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
@@ -331,6 +357,29 @@ int cmd_repack(int argc,
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
index 88c2bb0857..6774886f1e 100755
--- a/t/t7706-repack-drop-filtered.sh
+++ b/t/t7706-repack-drop-filtered.sh
@@ -146,4 +146,40 @@ test_expect_success '--drop-filtered removes the promisor blob locally' '
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

