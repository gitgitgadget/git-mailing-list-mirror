Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D2733612E7
	for <git@vger.kernel.org>; Sun, 23 Aug 2026 17:19:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787505583; cv=none; b=mI+y2n5TR6KC1GPtLC8LDqUeklj8juVxNJpJuuXS/lYgOYm4V2Gy+i9iA8b8VgNqQrTP71uJ3u/vTEubsnf14O7pwfsiM2knXS9anurYu3lcubWBhVrhvPlODnF0ToNHJeOJh+3wz5G8ncuoWiBBe7o9aCv12AdMeAKbk38jgA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787505583; c=relaxed/simple;
	bh=yveNghQ2aLwfIp8QxDSFNh71DnW/sRKEwcRj1sQXO5c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aXnHjLEB9yUd9+a/0/8eUxc3A7ROVyRErUrEhly6LaUGtEY4IPZy3eS14W1dxRAM6Nv6plfX8Wo8Tfk2tIdzmn3XR7T8wIgljsrn7NZyaKyZ/4S+33J92nsWZjBKnoE5YCku18W8yrSgbLMvpaJwyQPW1N4FIWaNRJQgawYQDkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JeS2uT6O; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JeS2uT6O"
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-38ea87caafeso1798347a91.3
        for <git@vger.kernel.org>; Sun, 23 Aug 2026 10:19:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787505575; x=1788110375; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=vAA64MqdbnqULTAAHmouJPTkyt9mEXyAgIc8V4S4978=;
        b=JeS2uT6Oe1uhq6rFH6g5gAiD1rUICl+WLSSKiE1HrKYZw+OS/y8mo2xiBLWPC7inGk
         YJTxYtSrsyq3CUo6bNT6doVi4qOp5X5dYK0YqqvrALJGLuWSLyRSqydGRuyYm1mXYAR1
         WGvUvv2BZzYg7Tc+2nawJD9pHSTNO2AiGEOE+mBB0rClpD4sRSSui1TJkcGsrCOfo8HQ
         iocsqG3KJaOkq3jruigQLXkN+6M4kihPNClI5Yp2tpAF+YZXXb5I4i5qQ7bm73OBqiUp
         leD4s6YithKpZziJSkHz1J5HWfg0OreWYIiYemUCyrFis4Pn8JD7hMasZZKii1yIlVcc
         GzVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787505575; x=1788110375;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=vAA64MqdbnqULTAAHmouJPTkyt9mEXyAgIc8V4S4978=;
        b=qJdUawm2J+yzXW+oqa0R2RpecMp8lwCc4nmd483XwMAqlr7leEfpVi6NFCFiDpskSX
         ISljCzzyIQJ/ZDOuOj+vUOBAnAMkrxS2/QMswebnZYabHgsGEgwX1F+e0ssjaj1rwP7H
         UjRjtf0PlQGex7MnhRcA0qm878P+3QrlnVtLmqTSgbAYQXEkVrmc97E82GeZ8k7rhdBI
         +okHKDZGk7ngFtvRHv7VvTuutB8pOKzk8q7isXxQ1JtuCY8jbtX9jhi5RxJiqvMGlt2e
         x+iAldes5se5RSdA6ZD1FEgRHgqwN59q7xwGkk7TnYTySvK+nu6WU/o8+SB0izweuEaN
         xRMQ==
X-Gm-Message-State: AFuF++mXK3rewot3SLP0mxprKHjYIAvWEb0MdfX9mzw59zNpvOtFD3IO
	q2E9LSaLzbMHlPLzRwVXis8tWdbvfFk4GLZCBymv7ScZldDGCTDzWAbSHHrTXQ==
X-Gm-Gg: AR+sD11OKlnJ+1hs5vHwCn7yg6a7T/TMctxiHmgWnOUmGWVaa49f8MZsQ7AjFA7Zauj
	sTZkND24jZkaMV2w9LHoVuOV+SIh9H7CEUGxKgQg/GGZ67slGB1s4QM5HNAuZ99TAfSg+fZx4E6
	ubz/2K5KpQ5eL+tu60ipm070zolb8viHLBIN59llg2dklVe9dWugZiJvvKOaXhcNZn01mCNfTFp
	MamHg+/RtyXI9F23J9vuKrz664x6b5irk2OK4PjXJXJuDcrezBoJ3EBfnai0yEisJrKWhWeM+Gc
	d58Ja8fMOgobA1SDUdTVvUF49JxC4LKMajRlX8yI9l001P+RYWw1HzIHNuUMeOatoHlp/uuT/tW
	ZmcM7ua6FTiLWrbvhoSKQQ93rApy2jpL55QWVaDjYx5UXqRhzoIzGORPaWgMLOYpVbl7cT3Ht4b
	DUxe+PmDEUFZ70bIO4RFMugLgw+AB7DsUJ3hbouc/i3op8I+HXv25vOyWahui1HVDuNryLYp5VR
	e90K1bGbTO2fxQ9U2wOhPzZ2wcqHb2BLLZ8nXYOyc4iQHub3II/8axIi2E4I6C7tGhjFyV4vRbV
	7ls9mFfA5WPPQA7EVYIVg27mFfoRLCJKc7TWDjMCVxJihgpV0n7q7ffLgw==
X-Received: by 2002:a17:90b:580f:b0:380:f389:447b with SMTP id 98e67ed59e1d1-395c386d163mr40869683a91.11.1787505574304;
        Sun, 23 Aug 2026 10:19:34 -0700 (PDT)
Received: from localhost (192-184-169-91.fiber.dynamic.sonic.net. [192.184.169.91])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1418619d6ecsm16768714c88.14.2026.08.23.10.19.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Aug 2026 10:19:33 -0700 (PDT)
From: Michael Montalbo <mmontalbo@gmail.com>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <pks@pks.im>
Subject: [RFC PATCH 10/14] diff: gather the diff sources under diff/
Date: Sun, 23 Aug 2026 10:18:54 -0700
Message-ID: <20260823171915.2662373-11-mmontalbo@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260823171915.2662373-1-mmontalbo@gmail.com>
References: <20260823171915.2662373-1-mmontalbo@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Move the 16 diff C sources and 7 headers into diff/ as renames. Repoint
every reference to their old paths to the new ones: the #include lines
across the tree, the Makefile and meson.build build entries.

Signed-off-by: Michael Montalbo <mmontalbo@gmail.com>
---
 .gitorganize                                  | 46 +++++++++----------
 Makefile                                      | 32 ++++++-------
 add-interactive.c                             |  2 +-
 add-patch.c                                   |  2 +-
 apply.c                                       |  4 +-
 archive-zip.c                                 |  4 +-
 bisect.c                                      |  2 +-
 blame.c                                       |  4 +-
 blame.h                                       |  2 +-
 builtin/add.c                                 |  2 +-
 builtin/am.c                                  |  2 +-
 builtin/blame.c                               |  4 +-
 builtin/cat-file.c                            |  4 +-
 builtin/checkout.c                            |  4 +-
 builtin/commit.c                              |  2 +-
 builtin/describe.c                            |  2 +-
 builtin/diff-files.c                          |  4 +-
 builtin/diff-index.c                          |  4 +-
 builtin/diff-pairs.c                          |  4 +-
 builtin/diff-tree.c                           |  2 +-
 builtin/diff.c                                |  6 +--
 builtin/fast-export.c                         |  4 +-
 builtin/last-modified.c                       |  4 +-
 builtin/log.c                                 | 12 ++---
 builtin/merge-file.c                          |  4 +-
 builtin/merge-ours.c                          |  2 +-
 builtin/merge-tree.c                          |  2 +-
 builtin/merge.c                               |  6 +--
 builtin/pack-objects.c                        |  2 +-
 builtin/patch-id.c                            |  2 +-
 builtin/prune.c                               |  2 +-
 builtin/range-diff.c                          |  2 +-
 builtin/rebase.c                              |  2 +-
 builtin/rerere.c                              |  2 +-
 builtin/reset.c                               |  4 +-
 builtin/rev-list.c                            |  2 +-
 builtin/rev-parse.c                           |  2 +-
 builtin/revert.c                              |  2 +-
 builtin/shortlog.c                            |  2 +-
 builtin/stash.c                               |  2 +-
 builtin/submodule--helper.c                   |  4 +-
 builtin/tag.c                                 |  2 +-
 bundle.c                                      |  2 +-
 combine-diff.c => diff/combine-diff.c         |  8 ++--
 diff-lib.c => diff/diff-lib.c                 |  4 +-
 diff-merges.c => diff/diff-merges.c           |  2 +-
 diff-merges.h => diff/diff-merges.h           |  0
 diff-no-index.c => diff/diff-no-index.c       |  4 +-
 diff.c => diff/diff.c                         |  8 ++--
 diff.h => diff/diff.h                         |  0
 diffcore-break.c => diff/diffcore-break.c     |  2 +-
 diffcore-delta.c => diff/diffcore-delta.c     |  2 +-
 diffcore-order.c => diff/diffcore-order.c     |  4 +-
 diffcore-pickaxe.c => diff/diffcore-pickaxe.c |  6 +--
 diffcore-rename.c => diff/diffcore-rename.c   |  4 +-
 diffcore-rotate.c => diff/diffcore-rotate.c   |  4 +-
 diffcore.h => diff/diffcore.h                 |  0
 patch-ids.c => diff/patch-ids.c               |  4 +-
 patch-ids.h => diff/patch-ids.h               |  2 +-
 range-diff.c => diff/range-diff.c             |  8 ++--
 range-diff.h => diff/range-diff.h             |  2 +-
 tree-diff.c => diff/tree-diff.c               |  4 +-
 userdiff.c => diff/userdiff.c                 |  2 +-
 userdiff.h => diff/userdiff.h                 |  0
 xdiff-interface.c => diff/xdiff-interface.c   |  2 +-
 xdiff-interface.h => diff/xdiff-interface.h   |  0
 fmt-merge-msg.c                               |  4 +-
 graph.h                                       |  2 +-
 grep.c                                        |  8 ++--
 grep.h                                        |  2 +-
 http-push.c                                   |  2 +-
 line-log.c                                    |  6 +--
 line-log.h                                    |  2 +-
 line-range.c                                  |  4 +-
 list-objects-filter.c                         |  2 +-
 list-objects.c                                |  2 +-
 log-tree.c                                    |  6 +--
 merge-ll.c                                    |  2 +-
 merge-ort.c                                   |  6 +--
 meson.build                                   | 32 ++++++-------
 notes-merge.c                                 |  6 +--
 odb/commit.c                                  |  2 +-
 pack/bloom.c                                  |  4 +-
 pack/delta-islands.c                          |  2 +-
 pack/pack-bitmap-write.c                      |  2 +-
 pack/pack-bitmap.c                            |  2 +-
 pack/reachable.c                              |  2 +-
 pretty.c                                      |  2 +-
 read-cache.c                                  |  4 +-
 refs/reflog-walk.c                            |  2 +-
 remote.c                                      |  2 +-
 rerere.c                                      |  2 +-
 revision.c                                    |  6 +--
 revision.h                                    |  2 +-
 sequencer.c                                   |  2 +-
 shallow.c                                     |  2 +-
 submodule.c                                   |  4 +-
 t/helper/test-revision-walking.c              |  2 +-
 t/helper/test-userdiff.c                      |  2 +-
 upload-pack.c                                 |  2 +-
 wt-status.c                                   |  4 +-
 101 files changed, 208 insertions(+), 208 deletions(-)
 rename combine-diff.c => diff/combine-diff.c (99%)
 rename diff-lib.c => diff/diff-lib.c (99%)
 rename diff-merges.c => diff/diff-merges.c (99%)
 rename diff-merges.h => diff/diff-merges.h (100%)
 rename diff-no-index.c => diff/diff-no-index.c (99%)
 rename diff.c => diff/diff.c (99%)
 rename diff.h => diff/diff.h (100%)
 rename diffcore-break.c => diff/diffcore-break.c (99%)
 rename diffcore-delta.c => diff/diffcore-delta.c (99%)
 rename diffcore-order.c => diff/diffcore-order.c (97%)
 rename diffcore-pickaxe.c => diff/diffcore-pickaxe.c (98%)
 rename diffcore-rename.c => diff/diffcore-rename.c (99%)
 rename diffcore-rotate.c => diff/diffcore-rotate.c (95%)
 rename diffcore.h => diff/diffcore.h (100%)
 rename patch-ids.c => diff/patch-ids.c (98%)
 rename patch-ids.h => diff/patch-ids.h (98%)
 rename range-diff.c => diff/range-diff.c (99%)
 rename range-diff.h => diff/range-diff.h (98%)
 rename tree-diff.c => diff/tree-diff.c (99%)
 rename userdiff.c => diff/userdiff.c (99%)
 rename userdiff.h => diff/userdiff.h (100%)
 rename xdiff-interface.c => diff/xdiff-interface.c (99%)
 rename xdiff-interface.h => diff/xdiff-interface.h (100%)

diff --git a/.gitorganize b/.gitorganize
index 533d50ed89..160365fbca 100644
--- a/.gitorganize
+++ b/.gitorganize
@@ -62,7 +62,6 @@ color.c component=? role=lib prefix=color includes=setup:1 cochange=diff:21,inde
 color.h component=? role=public prefix=color cochange=diff:18,index:12,revision:12,transport:2,odb:1
 column.c component=? role=lib prefix=column includes=setup:1 cochange=transport:6,setup:5,diff:4,revision:3,index:2
 column.h component=? role=public prefix=column
-combine-diff.c component=diff role=lib prefix=combine-diff includes=odb:5,diff:4,revision:2,convert:1,refs:1 cochange=diff:198,revision:67,index:35,odb:16,transport:16
 commit-reach.c component=revision role=lib prefix=commit-reach includes=revision:3,odb:2,pack:1,refs:1 cochange=revision:38,odb:17,pack:15,transport:9,index:5
 commit-reach.h component=revision role=header prefix=commit-reach includes=odb:2 cochange=revision:32,odb:9,transport:8,pack:3,refs:3
 common-exit.c component=? role=lib prefix=common-main
@@ -91,19 +90,29 @@ decorate.c component=revision role=lib prefix=decorate includes=odb:1,revision:1
 decorate.h component=revision role=header prefix=decorate cochange=revision:4,odb:1
 diagnose.c component=? role=lib prefix=diagnose includes=archive:1,index:1,odb:1,pack:1,setup:1 cochange=index:4,revision:4,odb:3,pack:3,transport:3
 diagnose.h component=? role=public prefix=diagnose cochange=revision:2,refs:1,transport:1
-diff-lib.c component=diff role=lib prefix=diff includes=index:6,odb:3,diff:2,revision:2,refs:1 cochange=diff:150,index:124,revision:47,submodule:18,odb:8
-diff-merges.c component=diff role=lib prefix=diff-merges includes=diff:1,revision:1 cochange=revision:18,diff:17,odb:4,refs:3,index:2
-diff-merges.h component=diff role=header prefix=diff-merges cochange=diff:11,revision:4,merge:1
-diff-no-index.c component=diff role=lib prefix=diff includes=diff:2,index:2,odb:1,revision:1 cochange=diff:76,revision:21,index:19,refs:8,notes:7
-diff.c component=diff role=lib prefix=diff includes=odb:5,diff:4,setup:3,convert:2,index:2 cochange=diff:610,revision:121,index:100,transport:71,setup:69
-diff.h component=diff role=header prefix=diff includes=index:1,odb:1 cochange=diff:471,revision:83,index:29,submodule:18,odb:14
-diffcore-break.c component=diff role=lib prefix=diffcore-break includes=odb:2,diff:1,transport:1 cochange=diff:71,pack:8,revision:7,index:5,merge:3
-diffcore-delta.c component=diff role=lib prefix=diffcore-delta includes=diff:1 cochange=diff:26,revision:7,odb:4,index:2,refs:2
-diffcore-order.c component=diff role=lib prefix=diffcore-order includes=diff:2 cochange=diff:19,index:8,refs:7,revision:7,pack:5
-diffcore-pickaxe.c component=diff role=lib prefix=pickaxe includes=diff:3,odb:1,revision:1 cochange=diff:97,revision:15,notes:3,odb:3,merge:2
-diffcore-rename.c component=diff role=lib prefix=diffcore-rename includes=diff:2,odb:2,transport:1 cochange=diff:188,index:38,revision:37,odb:21,pack:17
-diffcore-rotate.c component=diff role=lib prefix=diff includes=diff:2 cochange=diff:14,revision:5,pack:2,merge:1,refs:1
-diffcore.h component=diff role=header prefix=diff includes=odb:1 cochange=diff:175,revision:11,merge:10,submodule:4,odb:2
+diff/combine-diff.c component=diff role=lib prefix=combine-diff includes=odb:5,diff:4,revision:2,convert:1,refs:1 cochange=diff:198,revision:67,index:35,odb:16,transport:16
+diff/diff-lib.c component=diff role=lib prefix=diff includes=index:6,odb:3,diff:2,revision:2,refs:1 cochange=diff:150,index:124,revision:47,submodule:18,odb:8
+diff/diff-merges.c component=diff role=lib prefix=diff-merges includes=diff:1,revision:1 cochange=revision:18,diff:17,odb:4,refs:3,index:2
+diff/diff-merges.h component=diff role=header prefix=diff-merges cochange=diff:11,revision:4,merge:1
+diff/diff-no-index.c component=diff role=lib prefix=diff includes=diff:2,index:2,odb:1,revision:1 cochange=diff:76,revision:21,index:19,refs:8,notes:7
+diff/diff.c component=diff role=lib prefix=diff includes=odb:5,diff:4,setup:3,convert:2,index:2 cochange=diff:610,revision:121,index:100,transport:71,setup:69
+diff/diff.h component=diff role=header prefix=diff includes=index:1,odb:1 cochange=diff:471,revision:83,index:29,submodule:18,odb:14
+diff/diffcore-break.c component=diff role=lib prefix=diffcore-break includes=odb:2,diff:1,transport:1 cochange=diff:71,pack:8,revision:7,index:5,merge:3
+diff/diffcore-delta.c component=diff role=lib prefix=diffcore-delta includes=diff:1 cochange=diff:26,revision:7,odb:4,index:2,refs:2
+diff/diffcore-order.c component=diff role=lib prefix=diffcore-order includes=diff:2 cochange=diff:19,index:8,refs:7,revision:7,pack:5
+diff/diffcore-pickaxe.c component=diff role=lib prefix=pickaxe includes=diff:3,odb:1,revision:1 cochange=diff:97,revision:15,notes:3,odb:3,merge:2
+diff/diffcore-rename.c component=diff role=lib prefix=diffcore-rename includes=diff:2,odb:2,transport:1 cochange=diff:188,index:38,revision:37,odb:21,pack:17
+diff/diffcore-rotate.c component=diff role=lib prefix=diff includes=diff:2 cochange=diff:14,revision:5,pack:2,merge:1,refs:1
+diff/diffcore.h component=diff role=header prefix=diff includes=odb:1 cochange=diff:175,revision:11,merge:10,submodule:4,odb:2
+diff/patch-ids.c component=diff role=lib prefix=patch-ids includes=diff:2,odb:2 cochange=diff:73,revision:34,index:14,odb:13,refs:12
+diff/patch-ids.h component=diff role=header prefix=patch-ids includes=diff:1 cochange=diff:15,revision:3,index:1
+diff/range-diff.c component=diff role=lib prefix=range-diff includes=diff:4,odb:2,revision:2,setup:2 cochange=diff:49,revision:26,index:9,submodule:8,setup:7
+diff/range-diff.h component=diff role=header prefix=range-diff includes=diff:1 cochange=diff:13,revision:4
+diff/tree-diff.c component=diff role=lib prefix=tree-diff includes=odb:3,diff:2,index:1,setup:1 cochange=diff:115,odb:56,revision:53,index:36,notes:12
+diff/userdiff.c component=diff role=lib prefix=userdiff includes=setup:2,convert:1,diff:1 cochange=diff:41,convert:34,archive:11,index:7,transport:6
+diff/userdiff.h component=diff role=header prefix=diff includes=notes:1 cochange=diff:40,notes:2,archive:1,merge:1,revision:1
+diff/xdiff-interface.c component=diff role=lib prefix=xdiff-interface includes=setup:2,diff:1,odb:1 cochange=diff:73,index:5,merge:3,notes:3,refs:3
+diff/xdiff-interface.h component=diff role=header prefix=xdiff-interface includes=odb:1 cochange=diff:62,index:2,notes:2,merge:1,odb:1
 dir-iterator.c component=index role=lib prefix=dir-iterator includes=index:2 cochange=index:7,refs:1
 dir-iterator.h component=index role=header prefix=dir-iterator cochange=index:7,refs:1
 dir.c component=index role=lib prefix=dir includes=index:7,setup:4,odb:2,convert:1,refs:1 cochange=index:343,diff:61,setup:49,odb:37,convert:29
@@ -321,8 +330,6 @@ parse-options.c component=? role=lib prefix=parse-options cochange=index:14,diff
 parse-options.h component=? role=public prefix=parse-options cochange=diff:7,merge:4,archive:3,index:3,refs:3
 parse.c component=? role=lib prefix=parse cochange=setup:6,index:3,pack:2,convert:1
 parse.h component=? role=public prefix=config cochange=setup:6,index:3,pack:2,convert:1
-patch-ids.c component=diff role=lib prefix=patch-ids includes=diff:2,odb:2 cochange=diff:73,revision:34,index:14,odb:13,refs:12
-patch-ids.h component=diff role=header prefix=patch-ids includes=diff:1 cochange=diff:15,revision:3,index:1
 path-walk.c component=? role=lib prefix=path-walk includes=odb:9,revision:3,index:1,setup:1 cochange=index:2,revision:2,transport:2,odb:1,pack:1
 path-walk.h component=? role=public prefix=path-walk includes=odb:1 cochange=index:2
 path.c component=? role=lib prefix=path includes=setup:2,index:1,odb:1,pack:1,refs:1 cochange=setup:78,refs:29,index:26,transport:15,odb:12
@@ -349,8 +356,6 @@ protocol.c component=transport role=lib prefix=protocol includes=setup:2,transpo
 protocol.h component=transport role=header prefix=protocol cochange=transport:5
 quote.c component=? role=lib prefix=quote cochange=index:15,diff:12,transport:7,odb:6,revision:6
 quote.h component=? role=public prefix=quote cochange=diff:8,transport:6,index:5,odb:5,refs:5
-range-diff.c component=diff role=lib prefix=range-diff includes=diff:4,odb:2,revision:2,setup:2 cochange=diff:49,revision:26,index:9,submodule:8,setup:7
-range-diff.h component=diff role=header prefix=range-diff includes=diff:1 cochange=diff:13,revision:4
 read-cache-ll.h component=index role=header prefix=read-cache includes=index:1,odb:1 cochange=index:8,diff:1,odb:1,revision:1
 read-cache.c component=index role=lib prefix=read-cache includes=index:10,odb:6,setup:4,diff:2,submodule:2 cochange=index:240,odb:81,setup:79,diff:67,pack:46
 read-cache.h component=index role=header prefix=read-cache includes=index:2,odb:1,setup:1 cochange=index:4,setup:4,diff:2
@@ -453,7 +458,6 @@ transport-helper.c component=transport role=lib prefix=transport-helper includes
 transport-internal.h component=transport role=header prefix=transport includes=transport:1 cochange=transport:42,refs:3,odb:1,submodule:1
 transport.c component=transport role=lib prefix=transport includes=transport:12,setup:3,odb:2,refs:2,submodule:1 cochange=transport:482,refs:35,setup:31,submodule:29,revision:21
 transport.h component=transport role=header prefix=transport includes=transport:2,revision:1 cochange=transport:249,submodule:6,odb:4,revision:2,diff:1
-tree-diff.c component=diff role=lib prefix=tree-diff includes=odb:3,diff:2,index:1,setup:1 cochange=diff:115,odb:56,revision:53,index:36,notes:12
 unicode-width.h component=? role=public prefix=unicode
 unix-socket.c component=? role=lib prefix=unix-socket cochange=diff:3,revision:2,setup:1
 unix-socket.h component=? role=public prefix=unix-socket
@@ -468,8 +472,6 @@ url.h component=? role=public prefix=url cochange=transport:9,revision:4,submodu
 urlmatch.c component=? role=lib prefix=urlmatch cochange=diff:3,odb:2,revision:2,setup:2,transport:2
 urlmatch.h component=? role=public prefix=urlmatch includes=setup:1 cochange=transport:1
 usage.c component=? role=lib prefix=usage cochange=index:3,odb:2,diff:1,revision:1,setup:1
-userdiff.c component=diff role=lib prefix=userdiff includes=setup:2,convert:1,diff:1 cochange=diff:41,convert:34,archive:11,index:7,transport:6
-userdiff.h component=diff role=header prefix=diff includes=notes:1 cochange=diff:40,notes:2,archive:1,merge:1,revision:1
 utf8.c component=? role=lib prefix=utf8 cochange=revision:6,index:3,setup:3,transport:2,convert:1
 utf8.h component=? role=public prefix=utf8 cochange=revision:6,index:2,setup:2,transport:2,convert:1
 varint.c component=? role=lib prefix=varint cochange=index:2,transport:1
@@ -490,5 +492,3 @@ ws.c component=convert role=lib prefix=whitespace includes=convert:2 cochange=co
 ws.h component=convert role=header prefix=whitespace cochange=diff:5,convert:2,setup:2
 wt-status.c component=index role=lib prefix=wt-status includes=odb:5,index:4,setup:3,diff:2,refs:2 cochange=index:149,diff:83,transport:55,refs:45,revision:45
 wt-status.h component=index role=header prefix=wt-status includes=index:1,transport:1 cochange=index:89,diff:10,refs:9,revision:4,transport:4
-xdiff-interface.c component=diff role=lib prefix=xdiff-interface includes=setup:2,diff:1,odb:1 cochange=diff:73,index:5,merge:3,notes:3,refs:3
-xdiff-interface.h component=diff role=header prefix=xdiff-interface includes=odb:1 cochange=diff:62,index:2,notes:2,merge:1,odb:1
diff --git a/Makefile b/Makefile
index 85d2a620a7..b96345ba0c 100644
--- a/Makefile
+++ b/Makefile
@@ -1124,7 +1124,7 @@ LIB_OBJS += checkout.o
 LIB_OBJS += pack/chunk-format.o
 LIB_OBJS += color.o
 LIB_OBJS += column.o
-LIB_OBJS += combine-diff.o
+LIB_OBJS += diff/combine-diff.o
 LIB_OBJS += pack/commit-graph.o
 LIB_OBJS += commit-reach.o
 LIB_OBJS += odb/commit.o
@@ -1148,16 +1148,16 @@ LIB_OBJS += decorate.o
 LIB_OBJS += pack/delta-islands.o
 LIB_OBJS += diagnose.o
 LIB_OBJS += pack/diff-delta.o
-LIB_OBJS += diff-merges.o
-LIB_OBJS += diff-lib.o
-LIB_OBJS += diff-no-index.o
-LIB_OBJS += diff.o
-LIB_OBJS += diffcore-break.o
-LIB_OBJS += diffcore-delta.o
-LIB_OBJS += diffcore-order.o
-LIB_OBJS += diffcore-pickaxe.o
-LIB_OBJS += diffcore-rename.o
-LIB_OBJS += diffcore-rotate.o
+LIB_OBJS += diff/diff-merges.o
+LIB_OBJS += diff/diff-lib.o
+LIB_OBJS += diff/diff-no-index.o
+LIB_OBJS += diff/diff.o
+LIB_OBJS += diff/diffcore-break.o
+LIB_OBJS += diff/diffcore-delta.o
+LIB_OBJS += diff/diffcore-order.o
+LIB_OBJS += diff/diffcore-pickaxe.o
+LIB_OBJS += diff/diffcore-rename.o
+LIB_OBJS += diff/diffcore-rotate.o
 LIB_OBJS += dir-iterator.o
 LIB_OBJS += dir.o
 LIB_OBJS += editor.o
@@ -1257,7 +1257,7 @@ LIB_OBJS += parse.o
 LIB_OBJS += parse-options-cb.o
 LIB_OBJS += parse-options.o
 LIB_OBJS += pack/patch-delta.o
-LIB_OBJS += patch-ids.o
+LIB_OBJS += diff/patch-ids.o
 LIB_OBJS += path.o
 LIB_OBJS += path-walk.o
 LIB_OBJS += pathspec.o
@@ -1273,7 +1273,7 @@ LIB_OBJS += protocol-caps.o
 LIB_OBJS += pack/prune-packed.o
 LIB_OBJS += pack/pseudo-merge.o
 LIB_OBJS += quote.o
-LIB_OBJS += range-diff.o
+LIB_OBJS += diff/range-diff.o
 LIB_OBJS += pack/reachable.o
 LIB_OBJS += read-cache.o
 LIB_OBJS += rebase-interactive.o
@@ -1360,7 +1360,7 @@ LIB_OBJS += trace2/tr2_tmr.o
 LIB_OBJS += trailer.o
 LIB_OBJS += transport-helper.o
 LIB_OBJS += transport.o
-LIB_OBJS += tree-diff.o
+LIB_OBJS += diff/tree-diff.o
 LIB_OBJS += odb/tree-walk.o
 LIB_OBJS += odb/tree.o
 LIB_OBJS += unpack-trees.o
@@ -1368,7 +1368,7 @@ LIB_OBJS += upload-pack.o
 LIB_OBJS += url.o
 LIB_OBJS += urlmatch.o
 LIB_OBJS += usage.o
-LIB_OBJS += userdiff.o
+LIB_OBJS += diff/userdiff.o
 LIB_OBJS += utf8.o
 ifdef NO_RUST
 LIB_OBJS += varint.o
@@ -1382,7 +1382,7 @@ LIB_OBJS += wrapper.o
 LIB_OBJS += write-or-die.o
 LIB_OBJS += ws.o
 LIB_OBJS += wt-status.o
-LIB_OBJS += xdiff-interface.o
+LIB_OBJS += diff/xdiff-interface.o
 LIB_OBJS += xdiff/xdiffi.o
 LIB_OBJS += xdiff/xemit.o
 LIB_OBJS += xdiff/xhistogram.o
diff --git a/add-interactive.c b/add-interactive.c
index 67ee53f5cc..f656db231c 100644
--- a/add-interactive.c
+++ b/add-interactive.c
@@ -3,7 +3,7 @@
 #include "git-compat-util.h"
 #include "add-interactive.h"
 #include "color.h"
-#include "diffcore.h"
+#include "diff/diffcore.h"
 #include "gettext.h"
 #include "odb/hash.h"
 #include "hex.h"
diff --git a/add-patch.c b/add-patch.c
index 1b4c53e4ce..c6860310c1 100644
--- a/add-patch.c
+++ b/add-patch.c
@@ -6,7 +6,7 @@
 #include "advice.h"
 #include "odb/commit.h"
 #include "config.h"
-#include "diff.h"
+#include "diff/diff.h"
 #include "editor.h"
 #include "environment.h"
 #include "gettext.h"
diff --git a/apply.c b/apply.c
index dbfb891b4c..b8d97d140d 100644
--- a/apply.c
+++ b/apply.c
@@ -16,12 +16,12 @@
 #include "config.h"
 #include "odb/odb.h"
 #include "pack/delta.h"
-#include "diff.h"
+#include "diff/diff.h"
 #include "dir.h"
 #include "environment.h"
 #include "gettext.h"
 #include "hex.h"
-#include "xdiff-interface.h"
+#include "diff/xdiff-interface.h"
 #include "merge-ll.h"
 #include "lockfile.h"
 #include "name-hash.h"
diff --git a/archive-zip.c b/archive-zip.c
index 53c50ebc44..df1edadd33 100644
--- a/archive-zip.c
+++ b/archive-zip.c
@@ -14,9 +14,9 @@
 #include "odb/odb.h"
 #include "odb/streaming.h"
 #include "strbuf.h"
-#include "userdiff.h"
+#include "diff/userdiff.h"
 #include "write-or-die.h"
-#include "xdiff-interface.h"
+#include "diff/xdiff-interface.h"
 #include "date.h"
 
 static int zip_date;
diff --git a/bisect.c b/bisect.c
index 85c5a12ed2..1f8d81b894 100644
--- a/bisect.c
+++ b/bisect.c
@@ -4,7 +4,7 @@
 #include "git-compat-util.h"
 #include "config.h"
 #include "odb/commit.h"
-#include "diff.h"
+#include "diff/diff.h"
 #include "environment.h"
 #include "gettext.h"
 #include "hex.h"
diff --git a/blame.c b/blame.c
index cd18c09a3c..c736441f18 100644
--- a/blame.c
+++ b/blame.c
@@ -8,8 +8,8 @@
 #include "mergesort.h"
 #include "odb/commit.h"
 #include "convert.h"
-#include "diff.h"
-#include "diffcore.h"
+#include "diff/diff.h"
+#include "diff/diffcore.h"
 #include "gettext.h"
 #include "hex.h"
 #include "path.h"
diff --git a/blame.h b/blame.h
index 97137099e3..30aeae2d4e 100644
--- a/blame.h
+++ b/blame.h
@@ -2,7 +2,7 @@
 #define BLAME_H
 
 #include "odb/oidset.h"
-#include "xdiff-interface.h"
+#include "diff/xdiff-interface.h"
 #include "prio-queue.h"
 
 #define PICKAXE_BLAME_MOVE		01
diff --git a/builtin/add.c b/builtin/add.c
index 5d6dd91f70..dd5e33c7b0 100644
--- a/builtin/add.c
+++ b/builtin/add.c
@@ -20,7 +20,7 @@
 #include "parse-options.h"
 #include "path.h"
 #include "preload-index.h"
-#include "diff.h"
+#include "diff/diff.h"
 #include "read-cache.h"
 #include "revision.h"
 #include "strvec.h"
diff --git a/builtin/am.c b/builtin/am.c
index d7e4e125d2..7bd7fde14b 100644
--- a/builtin/am.c
+++ b/builtin/am.c
@@ -24,7 +24,7 @@
 #include "cache-tree.h"
 #include "refs/refs.h"
 #include "odb/commit.h"
-#include "diff.h"
+#include "diff/diff.h"
 #include "unpack-trees.h"
 #include "branch.h"
 #include "odb/object-name.h"
diff --git a/builtin/blame.c b/builtin/blame.c
index 1662bd487d..cb9f8b4ff0 100644
--- a/builtin/blame.c
+++ b/builtin/blame.c
@@ -14,7 +14,7 @@
 #include "gettext.h"
 #include "hex.h"
 #include "odb/commit.h"
-#include "diff.h"
+#include "diff/diff.h"
 #include "revision.h"
 #include "quote.h"
 #include "string-list.h"
@@ -22,7 +22,7 @@
 #include "parse-options.h"
 #include "prio-queue.h"
 #include "utf8.h"
-#include "userdiff.h"
+#include "diff/userdiff.h"
 #include "line-range.h"
 #include "line-log.h"
 #include "progress.h"
diff --git a/builtin/cat-file.c b/builtin/cat-file.c
index a59aa00cea..4fd1999f80 100644
--- a/builtin/cat-file.c
+++ b/builtin/cat-file.c
@@ -10,14 +10,14 @@
 #include "builtin.h"
 #include "config.h"
 #include "convert.h"
-#include "diff.h"
+#include "diff/diff.h"
 #include "environment.h"
 #include "gettext.h"
 #include "hex.h"
 #include "ident.h"
 #include "list-objects-filter-options.h"
 #include "parse-options.h"
-#include "userdiff.h"
+#include "diff/userdiff.h"
 #include "odb/oid-array.h"
 #include "pack/packfile.h"
 #include "odb/object-file.h"
diff --git a/builtin/checkout.c b/builtin/checkout.c
index 87c1f087b8..c35c3d92d1 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -8,7 +8,7 @@
 #include "checkout.h"
 #include "odb/commit.h"
 #include "config.h"
-#include "diff.h"
+#include "diff/diff.h"
 #include "dir.h"
 #include "environment.h"
 #include "gettext.h"
@@ -40,7 +40,7 @@
 #include "odb/tree-walk.h"
 #include "unpack-trees.h"
 #include "wt-status.h"
-#include "xdiff-interface.h"
+#include "diff/xdiff-interface.h"
 #include "entry.h"
 #include "parallel-checkout.h"
 #include "add-interactive.h"
diff --git a/builtin/commit.c b/builtin/commit.c
index 39271d720e..d2b4ecbd40 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -17,7 +17,7 @@
 #include "dir.h"
 #include "editor.h"
 #include "environment.h"
-#include "diff.h"
+#include "diff/diff.h"
 #include "odb/commit.h"
 #include "add-interactive.h"
 #include "gettext.h"
diff --git a/builtin/describe.c b/builtin/describe.c
index c16a1da092..ff44b55e9e 100644
--- a/builtin/describe.c
+++ b/builtin/describe.c
@@ -14,7 +14,7 @@
 #include "parse-options.h"
 #include "read-cache-ll.h"
 #include "revision.h"
-#include "diff.h"
+#include "diff/diff.h"
 #include "hashmap.h"
 #include "setup.h"
 #include "strvec.h"
diff --git a/builtin/diff-files.c b/builtin/diff-files.c
index c5b7548e55..39eaf9cfce 100644
--- a/builtin/diff-files.c
+++ b/builtin/diff-files.c
@@ -9,8 +9,8 @@
 
 #include "builtin.h"
 #include "config.h"
-#include "diff.h"
-#include "diff-merges.h"
+#include "diff/diff.h"
+#include "diff/diff-merges.h"
 #include "odb/commit.h"
 #include "preload-index.h"
 #include "revision.h"
diff --git a/builtin/diff-index.c b/builtin/diff-index.c
index a23f444348..799f5533ad 100644
--- a/builtin/diff-index.c
+++ b/builtin/diff-index.c
@@ -3,8 +3,8 @@
 
 #include "builtin.h"
 #include "config.h"
-#include "diff.h"
-#include "diff-merges.h"
+#include "diff/diff.h"
+#include "diff/diff-merges.h"
 #include "odb/commit.h"
 #include "preload-index.h"
 #include "revision.h"
diff --git a/builtin/diff-pairs.c b/builtin/diff-pairs.c
index 315fc7357a..e3350b2915 100644
--- a/builtin/diff-pairs.c
+++ b/builtin/diff-pairs.c
@@ -1,7 +1,7 @@
 #include "builtin.h"
 #include "config.h"
-#include "diff.h"
-#include "diffcore.h"
+#include "diff/diff.h"
+#include "diff/diffcore.h"
 #include "gettext.h"
 #include "odb/hash.h"
 #include "hex.h"
diff --git a/builtin/diff-tree.c b/builtin/diff-tree.c
index a3e1e5e020..8f2103013c 100644
--- a/builtin/diff-tree.c
+++ b/builtin/diff-tree.c
@@ -2,7 +2,7 @@
 
 #include "builtin.h"
 #include "config.h"
-#include "diff.h"
+#include "diff/diff.h"
 #include "odb/commit.h"
 #include "gettext.h"
 #include "hex.h"
diff --git a/builtin/diff.c b/builtin/diff.c
index c9ccc7e6c5..774c12cea6 100644
--- a/builtin/diff.c
+++ b/builtin/diff.c
@@ -15,9 +15,9 @@
 #include "odb/commit.h"
 #include "gettext.h"
 #include "odb/tag.h"
-#include "diff.h"
-#include "diff-merges.h"
-#include "diffcore.h"
+#include "diff/diff.h"
+#include "diff/diff-merges.h"
+#include "diff/diffcore.h"
 #include "preload-index.h"
 #include "read-cache-ll.h"
 #include "revision.h"
diff --git a/builtin/fast-export.c b/builtin/fast-export.c
index 4a98f14d39..6683d49660 100644
--- a/builtin/fast-export.c
+++ b/builtin/fast-export.c
@@ -19,8 +19,8 @@
 #include "odb/commit.h"
 #include "odb/object.h"
 #include "odb/tag.h"
-#include "diff.h"
-#include "diffcore.h"
+#include "diff/diff.h"
+#include "diff/diffcore.h"
 #include "log-tree.h"
 #include "revision.h"
 #include "decorate.h"
diff --git a/builtin/last-modified.c b/builtin/last-modified.c
index 83c5d66f36..911441a321 100644
--- a/builtin/last-modified.c
+++ b/builtin/last-modified.c
@@ -5,8 +5,8 @@
 #include "odb/commit-slab.h"
 #include "odb/commit.h"
 #include "config.h"
-#include "diff.h"
-#include "diffcore.h"
+#include "diff/diff.h"
+#include "diff/diffcore.h"
 #include "environment.h"
 #include "ewah/ewok.h"
 #include "hashmap.h"
diff --git a/builtin/log.c b/builtin/log.c
index 7099f5fcc5..a93b97858b 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -20,16 +20,16 @@
 #include "pager.h"
 #include "color.h"
 #include "odb/commit.h"
-#include "diff.h"
-#include "diffcore.h"
-#include "diff-merges.h"
+#include "diff/diff.h"
+#include "diff/diffcore.h"
+#include "diff/diff-merges.h"
 #include "revision.h"
 #include "log-tree.h"
 #include "odb/oid-array.h"
 #include "odb/oidset.h"
 #include "odb/tag.h"
 #include "refs/reflog-walk.h"
-#include "patch-ids.h"
+#include "diff/patch-ids.h"
 #include "path.h"
 #include "shortlog.h"
 #include "remote.h"
@@ -46,10 +46,10 @@
 
 #include "commit-reach.h"
 #include "promisor-remote.h"
-#include "range-diff.h"
+#include "diff/range-diff.h"
 #include "odb/tmp-objdir.h"
 #include "odb/tree.h"
-#include "userdiff.h"
+#include "diff/userdiff.h"
 #include "write-or-die.h"
 
 #define MAIL_DEFAULT_WRAP 72
diff --git a/builtin/merge-file.c b/builtin/merge-file.c
index 22a6862a13..12701b1d81 100644
--- a/builtin/merge-file.c
+++ b/builtin/merge-file.c
@@ -3,7 +3,7 @@
 
 #include "builtin.h"
 #include "abspath.h"
-#include "diff.h"
+#include "diff/diff.h"
 #include "hex.h"
 #include "odb/object-file.h"
 #include "odb/object-name.h"
@@ -12,7 +12,7 @@
 #include "gettext.h"
 #include "setup.h"
 #include "xdiff/xdiff.h"
-#include "xdiff-interface.h"
+#include "diff/xdiff-interface.h"
 #include "parse-options.h"
 
 static const char *const merge_file_usage[] = {
diff --git a/builtin/merge-ours.c b/builtin/merge-ours.c
index 405b2989f7..c33e176c65 100644
--- a/builtin/merge-ours.c
+++ b/builtin/merge-ours.c
@@ -12,7 +12,7 @@
 #include "builtin.h"
 #include "config.h"
 #include "environment.h"
-#include "diff.h"
+#include "diff/diff.h"
 
 static const char builtin_merge_ours_usage[] =
 	"git merge-ours <base>... -- HEAD <remote>...";
diff --git a/builtin/merge-tree.c b/builtin/merge-tree.c
index 27f2944ece..8217938d86 100644
--- a/builtin/merge-tree.c
+++ b/builtin/merge-tree.c
@@ -3,7 +3,7 @@
 #include "builtin.h"
 #include "environment.h"
 #include "odb/tree-walk.h"
-#include "xdiff-interface.h"
+#include "diff/xdiff-interface.h"
 #include "help.h"
 #include "gettext.h"
 #include "hex.h"
diff --git a/builtin/merge.c b/builtin/merge.c
index ad0c984d4b..7ec4554b0b 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -24,12 +24,12 @@
 #include "repository.h"
 #include "run-command.h"
 #include "hook.h"
-#include "diff.h"
-#include "diff-merges.h"
+#include "diff/diff.h"
+#include "diff/diff-merges.h"
 #include "refs/refs.h"
 #include "refs/refspec.h"
 #include "odb/commit.h"
-#include "diffcore.h"
+#include "diff/diffcore.h"
 #include "path.h"
 #include "revision.h"
 #include "unpack-trees.h"
diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 37c379d3d8..17721f13ac 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -15,7 +15,7 @@
 #include "pack/pack-revindex.h"
 #include "csum-file.h"
 #include "odb/tree-walk.h"
-#include "diff.h"
+#include "diff/diff.h"
 #include "revision.h"
 #include "list-objects.h"
 #include "list-objects-filter-options.h"
diff --git a/builtin/patch-id.c b/builtin/patch-id.c
index e2c1375b41..7207279cef 100644
--- a/builtin/patch-id.c
+++ b/builtin/patch-id.c
@@ -2,7 +2,7 @@
 
 #include "builtin.h"
 #include "config.h"
-#include "diff.h"
+#include "diff/diff.h"
 #include "environment.h"
 #include "gettext.h"
 #include "odb/hash.h"
diff --git a/builtin/prune.c b/builtin/prune.c
index ae3505c5e5..0adf0f02d1 100644
--- a/builtin/prune.c
+++ b/builtin/prune.c
@@ -2,7 +2,7 @@
 
 #include "builtin.h"
 #include "odb/commit.h"
-#include "diff.h"
+#include "diff/diff.h"
 #include "dir.h"
 #include "environment.h"
 #include "gettext.h"
diff --git a/builtin/range-diff.c b/builtin/range-diff.c
index 7e37a00d9e..323046c696 100644
--- a/builtin/range-diff.c
+++ b/builtin/range-diff.c
@@ -4,7 +4,7 @@
 #include "gettext.h"
 #include "odb/object-name.h"
 #include "parse-options.h"
-#include "range-diff.h"
+#include "diff/range-diff.h"
 #include "config.h"
 #include "parse.h"
 #include "color.h"
diff --git a/builtin/rebase.c b/builtin/rebase.c
index 983dbb7ce5..8f9fdcc79b 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -25,7 +25,7 @@
 #include "parse-options.h"
 #include "path.h"
 #include "odb/commit.h"
-#include "diff.h"
+#include "diff/diff.h"
 #include "wt-status.h"
 #include "revision.h"
 #include "commit-reach.h"
diff --git a/builtin/rerere.c b/builtin/rerere.c
index a056cb791b..545ffe2715 100644
--- a/builtin/rerere.c
+++ b/builtin/rerere.c
@@ -8,7 +8,7 @@
 #include "strbuf.h"
 #include "string-list.h"
 #include "xdiff/xdiff.h"
-#include "xdiff-interface.h"
+#include "diff/xdiff-interface.h"
 #include "pathspec.h"
 
 static const char * const rerere_usage[] = {
diff --git a/builtin/reset.c b/builtin/reset.c
index c3bfbab7d5..f843bab823 100644
--- a/builtin/reset.c
+++ b/builtin/reset.c
@@ -21,8 +21,8 @@
 #include "odb/object.h"
 #include "pretty.h"
 #include "refs/refs.h"
-#include "diff.h"
-#include "diffcore.h"
+#include "diff/diff.h"
+#include "diff/diffcore.h"
 #include "odb/tree.h"
 #include "branch.h"
 #include "odb/object-name.h"
diff --git a/builtin/rev-list.c b/builtin/rev-list.c
index d6bddda9d4..c0e0769aab 100644
--- a/builtin/rev-list.c
+++ b/builtin/rev-list.c
@@ -4,7 +4,7 @@
 #include "builtin.h"
 #include "config.h"
 #include "odb/commit.h"
-#include "diff.h"
+#include "diff/diff.h"
 #include "environment.h"
 #include "gettext.h"
 #include "hex.h"
diff --git a/builtin/rev-parse.c b/builtin/rev-parse.c
index 2fb682d5a2..b95cdac85e 100644
--- a/builtin/rev-parse.c
+++ b/builtin/rev-parse.c
@@ -22,7 +22,7 @@
 #include "odb/object-name.h"
 #include "parse-options.h"
 #include "path.h"
-#include "diff.h"
+#include "diff/diff.h"
 #include "read-cache-ll.h"
 #include "repo-settings.h"
 #include "repository.h"
diff --git a/builtin/revert.c b/builtin/revert.c
index bedc40f368..a939c590fb 100644
--- a/builtin/revert.c
+++ b/builtin/revert.c
@@ -3,7 +3,7 @@
 #include "git-compat-util.h"
 #include "builtin.h"
 #include "parse-options.h"
-#include "diff.h"
+#include "diff/diff.h"
 #include "environment.h"
 #include "gettext.h"
 #include "revision.h"
diff --git a/builtin/shortlog.c b/builtin/shortlog.c
index cbcf2fb637..59be73a372 100644
--- a/builtin/shortlog.c
+++ b/builtin/shortlog.c
@@ -3,7 +3,7 @@
 #include "builtin.h"
 #include "config.h"
 #include "odb/commit.h"
-#include "diff.h"
+#include "diff/diff.h"
 #include "environment.h"
 #include "gettext.h"
 #include "string-list.h"
diff --git a/builtin/stash.c b/builtin/stash.c
index 62fec2f17f..c5e100746d 100644
--- a/builtin/stash.c
+++ b/builtin/stash.c
@@ -26,7 +26,7 @@
 #include "setup.h"
 #include "sparse-index.h"
 #include "log-tree.h"
-#include "diffcore.h"
+#include "diff/diffcore.h"
 #include "refs/reflog.h"
 #include "refs/reflog-walk.h"
 #include "add-interactive.h"
diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index bf8b20247f..5711a79428 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -24,8 +24,8 @@
 #include "refs/refs.h"
 #include "refs/refspec.h"
 #include "revision.h"
-#include "diffcore.h"
-#include "diff.h"
+#include "diff/diffcore.h"
+#include "diff/diff.h"
 #include "odb/object-file.h"
 #include "odb/object-name.h"
 #include "odb/odb.h"
diff --git a/builtin/tag.c b/builtin/tag.c
index d554ae8f81..c04c2cc207 100644
--- a/builtin/tag.c
+++ b/builtin/tag.c
@@ -23,7 +23,7 @@
 #include "path.h"
 #include "odb/tag.h"
 #include "parse-options.h"
-#include "diff.h"
+#include "diff/diff.h"
 #include "revision.h"
 #include "gpg-interface.h"
 #include "odb/oid-array.h"
diff --git a/bundle.c b/bundle.c
index c64b14a05a..54ec76866b 100644
--- a/bundle.c
+++ b/bundle.c
@@ -11,7 +11,7 @@
 #include "repository.h"
 #include "odb/object.h"
 #include "odb/commit.h"
-#include "diff.h"
+#include "diff/diff.h"
 #include "revision.h"
 #include "list-objects.h"
 #include "run-command.h"
diff --git a/combine-diff.c b/diff/combine-diff.c
similarity index 99%
rename from combine-diff.c
rename to diff/combine-diff.c
index 6f16e9ea38..44f0eb5442 100644
--- a/combine-diff.c
+++ b/diff/combine-diff.c
@@ -5,18 +5,18 @@
 #include "odb/odb.h"
 #include "odb/commit.h"
 #include "convert.h"
-#include "diff.h"
-#include "diffcore.h"
+#include "diff/diff.h"
+#include "diff/diffcore.h"
 #include "environment.h"
 #include "hex.h"
 #include "odb/object-name.h"
 #include "quote.h"
-#include "xdiff-interface.h"
+#include "diff/xdiff-interface.h"
 #include "xdiff/xmacros.h"
 #include "log-tree.h"
 #include "refs/refs.h"
 #include "odb/tree.h"
-#include "userdiff.h"
+#include "diff/userdiff.h"
 #include "odb/oid-array.h"
 #include "revision.h"
 
diff --git a/diff-lib.c b/diff/diff-lib.c
similarity index 99%
rename from diff-lib.c
rename to diff/diff-lib.c
index a5072c5f6d..fb0514dcb0 100644
--- a/diff-lib.c
+++ b/diff/diff-lib.c
@@ -7,8 +7,8 @@
 
 #include "git-compat-util.h"
 #include "odb/commit.h"
-#include "diff.h"
-#include "diffcore.h"
+#include "diff/diff.h"
+#include "diff/diffcore.h"
 #include "gettext.h"
 #include "odb/hash.h"
 #include "hex.h"
diff --git a/diff-merges.c b/diff/diff-merges.c
similarity index 99%
rename from diff-merges.c
rename to diff/diff-merges.c
index 45507588a2..ca3cbf7767 100644
--- a/diff-merges.c
+++ b/diff/diff-merges.c
@@ -1,5 +1,5 @@
 #include "git-compat-util.h"
-#include "diff-merges.h"
+#include "diff/diff-merges.h"
 
 #include "gettext.h"
 #include "revision.h"
diff --git a/diff-merges.h b/diff/diff-merges.h
similarity index 100%
rename from diff-merges.h
rename to diff/diff-merges.h
diff --git a/diff-no-index.c b/diff/diff-no-index.c
similarity index 99%
rename from diff-no-index.c
rename to diff/diff-no-index.c
index 552cd95679..5712e5474d 100644
--- a/diff-no-index.c
+++ b/diff/diff-no-index.c
@@ -10,8 +10,8 @@
 #include "abspath.h"
 #include "color.h"
 #include "odb/commit.h"
-#include "diff.h"
-#include "diffcore.h"
+#include "diff/diff.h"
+#include "diff/diffcore.h"
 #include "gettext.h"
 #include "revision.h"
 #include "parse-options.h"
diff --git a/diff.c b/diff/diff.c
similarity index 99%
rename from diff.c
rename to diff/diff.c
index 91addcdab7..9062f96b7b 100644
--- a/diff.c
+++ b/diff/diff.c
@@ -15,16 +15,16 @@
 #include "tempfile.h"
 #include "revision.h"
 #include "quote.h"
-#include "diff.h"
-#include "diffcore.h"
+#include "diff/diff.h"
+#include "diff/diffcore.h"
 #include "pack/delta.h"
 #include "hex.h"
-#include "xdiff-interface.h"
+#include "diff/xdiff-interface.h"
 #include "color.h"
 #include "run-command.h"
 #include "utf8.h"
 #include "odb/odb.h"
-#include "userdiff.h"
+#include "diff/userdiff.h"
 #include "submodule.h"
 #include "hashmap.h"
 #include "mem-pool.h"
diff --git a/diff.h b/diff/diff.h
similarity index 100%
rename from diff.h
rename to diff/diff.h
diff --git a/diffcore-break.c b/diff/diffcore-break.c
similarity index 99%
rename from diffcore-break.c
rename to diff/diffcore-break.c
index 70860c8abc..c822a0d56d 100644
--- a/diffcore-break.c
+++ b/diff/diffcore-break.c
@@ -5,7 +5,7 @@
 #define USE_THE_REPOSITORY_VARIABLE
 
 #include "git-compat-util.h"
-#include "diffcore.h"
+#include "diff/diffcore.h"
 #include "odb/hash.h"
 #include "odb/object.h"
 #include "promisor-remote.h"
diff --git a/diffcore-delta.c b/diff/diffcore-delta.c
similarity index 99%
rename from diffcore-delta.c
rename to diff/diffcore-delta.c
index 2b7db39983..4291662274 100644
--- a/diffcore-delta.c
+++ b/diff/diffcore-delta.c
@@ -1,5 +1,5 @@
 #include "git-compat-util.h"
-#include "diffcore.h"
+#include "diff/diffcore.h"
 
 /*
  * Idea here is very simple.
diff --git a/diffcore-order.c b/diff/diffcore-order.c
similarity index 97%
rename from diffcore-order.c
rename to diff/diffcore-order.c
index f91ef22471..e6a6a23aca 100644
--- a/diffcore-order.c
+++ b/diff/diffcore-order.c
@@ -4,8 +4,8 @@
 
 #include "git-compat-util.h"
 #include "gettext.h"
-#include "diff.h"
-#include "diffcore.h"
+#include "diff/diff.h"
+#include "diff/diffcore.h"
 #include "wildmatch.h"
 
 static char **order;
diff --git a/diffcore-pickaxe.c b/diff/diffcore-pickaxe.c
similarity index 98%
rename from diffcore-pickaxe.c
rename to diff/diffcore-pickaxe.c
index f7a745fb49..e7289d9a26 100644
--- a/diffcore-pickaxe.c
+++ b/diff/diffcore-pickaxe.c
@@ -6,9 +6,9 @@
 #define DISABLE_SIGN_COMPARE_WARNINGS
 
 #include "git-compat-util.h"
-#include "diff.h"
-#include "diffcore.h"
-#include "xdiff-interface.h"
+#include "diff/diff.h"
+#include "diff/diffcore.h"
+#include "diff/xdiff-interface.h"
 #include "kwset.h"
 #include "odb/oidset.h"
 #include "pretty.h"
diff --git a/diffcore-rename.c b/diff/diffcore-rename.c
similarity index 99%
rename from diffcore-rename.c
rename to diff/diffcore-rename.c
index 68abf77c4d..16746444d8 100644
--- a/diffcore-rename.c
+++ b/diff/diffcore-rename.c
@@ -6,8 +6,8 @@
 #define USE_THE_REPOSITORY_VARIABLE
 
 #include "git-compat-util.h"
-#include "diff.h"
-#include "diffcore.h"
+#include "diff/diff.h"
+#include "diff/diffcore.h"
 #include "odb/object-file.h"
 #include "hashmap.h"
 #include "mem-pool.h"
diff --git a/diffcore-rotate.c b/diff/diffcore-rotate.c
similarity index 95%
rename from diffcore-rotate.c
rename to diff/diffcore-rotate.c
index 67b591261a..a55d954092 100644
--- a/diffcore-rotate.c
+++ b/diff/diffcore-rotate.c
@@ -5,8 +5,8 @@
 
 #include "git-compat-util.h"
 #include "gettext.h"
-#include "diff.h"
-#include "diffcore.h"
+#include "diff/diff.h"
+#include "diff/diffcore.h"
 
 void diffcore_rotate(struct diff_options *opt)
 {
diff --git a/diffcore.h b/diff/diffcore.h
similarity index 100%
rename from diffcore.h
rename to diff/diffcore.h
diff --git a/patch-ids.c b/diff/patch-ids.c
similarity index 98%
rename from patch-ids.c
rename to diff/patch-ids.c
index 946744e7d9..de4e5702ed 100644
--- a/patch-ids.c
+++ b/diff/patch-ids.c
@@ -1,9 +1,9 @@
 #include "git-compat-util.h"
-#include "diff.h"
+#include "diff/diff.h"
 #include "odb/commit.h"
 #include "odb/hash.h"
 #include "hex.h"
-#include "patch-ids.h"
+#include "diff/patch-ids.h"
 
 static int patch_id_defined(struct commit *commit)
 {
diff --git a/patch-ids.h b/diff/patch-ids.h
similarity index 98%
rename from patch-ids.h
rename to diff/patch-ids.h
index 57534ee722..47291160ec 100644
--- a/patch-ids.h
+++ b/diff/patch-ids.h
@@ -1,7 +1,7 @@
 #ifndef PATCH_IDS_H
 #define PATCH_IDS_H
 
-#include "diff.h"
+#include "diff/diff.h"
 #include "hashmap.h"
 
 struct commit;
diff --git a/range-diff.c b/diff/range-diff.c
similarity index 99%
rename from range-diff.c
rename to diff/range-diff.c
index be9f872396..2177b8ba2d 100644
--- a/range-diff.c
+++ b/diff/range-diff.c
@@ -4,20 +4,20 @@
 #include "git-compat-util.h"
 #include "environment.h"
 #include "gettext.h"
-#include "range-diff.h"
+#include "diff/range-diff.h"
 #include "odb/object-name.h"
 #include "string-list.h"
 #include "run-command.h"
 #include "strvec.h"
 #include "hashmap.h"
-#include "xdiff-interface.h"
+#include "diff/xdiff-interface.h"
 #include "linear-assignment.h"
-#include "diffcore.h"
+#include "diff/diffcore.h"
 #include "odb/commit.h"
 #include "pager.h"
 #include "pretty.h"
 #include "repository.h"
-#include "userdiff.h"
+#include "diff/userdiff.h"
 #include "apply.h"
 #include "revision.h"
 
diff --git a/range-diff.h b/diff/range-diff.h
similarity index 98%
rename from range-diff.h
rename to diff/range-diff.h
index 9b70a80009..23aae59192 100644
--- a/range-diff.h
+++ b/diff/range-diff.h
@@ -1,7 +1,7 @@
 #ifndef RANGE_DIFF_H
 #define RANGE_DIFF_H
 
-#include "diff.h"
+#include "diff/diff.h"
 #include "strvec.h"
 
 #define RANGE_DIFF_CREATION_FACTOR_DEFAULT 60
diff --git a/tree-diff.c b/diff/tree-diff.c
similarity index 99%
rename from tree-diff.c
rename to diff/tree-diff.c
index b33c45b696..4b7c90f6db 100644
--- a/tree-diff.c
+++ b/diff/tree-diff.c
@@ -5,8 +5,8 @@
 #define DISABLE_SIGN_COMPARE_WARNINGS
 
 #include "git-compat-util.h"
-#include "diff.h"
-#include "diffcore.h"
+#include "diff/diff.h"
+#include "diff/diffcore.h"
 #include "odb/hash.h"
 #include "odb/tree.h"
 #include "odb/tree-walk.h"
diff --git a/userdiff.c b/diff/userdiff.c
similarity index 99%
rename from userdiff.c
rename to diff/userdiff.c
index 7129bf1482..8993b622c1 100644
--- a/userdiff.c
+++ b/diff/userdiff.c
@@ -3,7 +3,7 @@
 
 #include "git-compat-util.h"
 #include "config.h"
-#include "userdiff.h"
+#include "diff/userdiff.h"
 #include "attr.h"
 #include "strbuf.h"
 #include "environment.h"
diff --git a/userdiff.h b/diff/userdiff.h
similarity index 100%
rename from userdiff.h
rename to diff/userdiff.h
diff --git a/xdiff-interface.c b/diff/xdiff-interface.c
similarity index 99%
rename from xdiff-interface.c
rename to diff/xdiff-interface.c
index af18a34ba0..2c87316caa 100644
--- a/xdiff-interface.c
+++ b/diff/xdiff-interface.c
@@ -7,7 +7,7 @@
 #include "hex.h"
 #include "odb/odb.h"
 #include "strbuf.h"
-#include "xdiff-interface.h"
+#include "diff/xdiff-interface.h"
 #include "xdiff/xtypes.h"
 #include "xdiff/xdiffi.h"
 #include "xdiff/xutils.h"
diff --git a/xdiff-interface.h b/diff/xdiff-interface.h
similarity index 100%
rename from xdiff-interface.h
rename to diff/xdiff-interface.h
diff --git a/fmt-merge-msg.c b/fmt-merge-msg.c
index 7fa8c4cd79..34f769ae9f 100644
--- a/fmt-merge-msg.c
+++ b/fmt-merge-msg.c
@@ -7,8 +7,8 @@
 #include "refs/refs.h"
 #include "odb/object-name.h"
 #include "odb/odb.h"
-#include "diff.h"
-#include "diff-merges.h"
+#include "diff/diff.h"
+#include "diff/diff-merges.h"
 #include "hex.h"
 #include "revision.h"
 #include "odb/tag.h"
diff --git a/graph.h b/graph.h
index 1193711fb8..84a5a4b822 100644
--- a/graph.h
+++ b/graph.h
@@ -1,6 +1,6 @@
 #ifndef GRAPH_H
 #define GRAPH_H
-#include "diff.h"
+#include "diff/diff.h"
 
 /**
  * The graph API is used to draw a text-based representation of the commit
diff --git a/grep.c b/grep.c
index 5041c388b9..88c87ba1c9 100644
--- a/grep.c
+++ b/grep.c
@@ -7,10 +7,10 @@
 #include "hex.h"
 #include "odb/odb.h"
 #include "pretty.h"
-#include "userdiff.h"
-#include "xdiff-interface.h"
-#include "diff.h"
-#include "diffcore.h"
+#include "diff/userdiff.h"
+#include "diff/xdiff-interface.h"
+#include "diff/diff.h"
+#include "diff/diffcore.h"
 #include "quote.h"
 #include "help.h"
 
diff --git a/grep.h b/grep.h
index 13e26a9318..7881f28587 100644
--- a/grep.h
+++ b/grep.h
@@ -24,7 +24,7 @@ typedef int pcre2_general_context;
 #define PCRE2_MATCH_INVALID_UTF 0
 #endif
 #include "thread-utils.h"
-#include "userdiff.h"
+#include "diff/userdiff.h"
 
 struct repository;
 
diff --git a/http-push.c b/http-push.c
index 88a8417ea4..6d38410ccb 100644
--- a/http-push.c
+++ b/http-push.c
@@ -8,7 +8,7 @@
 #include "odb/tag.h"
 #include "odb/blob.h"
 #include "http.h"
-#include "diff.h"
+#include "diff/diff.h"
 #include "revision.h"
 #include "remote.h"
 #include "list-objects.h"
diff --git a/line-log.c b/line-log.c
index 343159d90a..78697cb377 100644
--- a/line-log.c
+++ b/line-log.c
@@ -1,17 +1,17 @@
 #define DISABLE_SIGN_COMPARE_WARNINGS
 
 #include "git-compat-util.h"
-#include "diffcore.h"
+#include "diff/diffcore.h"
 #include "line-range.h"
 #include "hex.h"
 #include "odb/tag.h"
 #include "odb/tree.h"
-#include "diff.h"
+#include "diff/diff.h"
 #include "odb/commit.h"
 #include "decorate.h"
 #include "repository.h"
 #include "revision.h"
-#include "xdiff-interface.h"
+#include "diff/xdiff-interface.h"
 #include "strbuf.h"
 #include "line-log.h"
 #include "setup.h"
diff --git a/line-log.h b/line-log.h
index 99e1755ce3..3a72d84698 100644
--- a/line-log.h
+++ b/line-log.h
@@ -1,7 +1,7 @@
 #ifndef LINE_LOG_H
 #define LINE_LOG_H
 
-#include "diffcore.h" /* struct range, struct range_set */
+#include "diff/diffcore.h" /* struct range, struct range_set */
 
 struct rev_info;
 struct commit;
diff --git a/line-range.c b/line-range.c
index b99f0d9895..1dbf761ecc 100644
--- a/line-range.c
+++ b/line-range.c
@@ -1,7 +1,7 @@
 #include "git-compat-util.h"
 #include "line-range.h"
-#include "xdiff-interface.h"
-#include "userdiff.h"
+#include "diff/xdiff-interface.h"
+#include "diff/userdiff.h"
 
 /*
  * Parse one item in the -L option
diff --git a/list-objects-filter.c b/list-objects-filter.c
index a34e07c061..a011cef0b5 100644
--- a/list-objects-filter.c
+++ b/list-objects-filter.c
@@ -5,7 +5,7 @@
 #include "gettext.h"
 #include "hex.h"
 #include "odb/commit.h"
-#include "diff.h"
+#include "diff/diff.h"
 #include "revision.h"
 #include "list-objects-filter.h"
 #include "list-objects-filter-options.h"
diff --git a/list-objects.c b/list-objects.c
index 1db5ba29b5..6b67f0f927 100644
--- a/list-objects.c
+++ b/list-objects.c
@@ -7,7 +7,7 @@
 #include "hex.h"
 #include "odb/tree.h"
 #include "odb/blob.h"
-#include "diff.h"
+#include "diff/diff.h"
 #include "odb/tree-walk.h"
 #include "revision.h"
 #include "list-objects.h"
diff --git a/log-tree.c b/log-tree.c
index 116bb7ea68..ddeafedb45 100644
--- a/log-tree.c
+++ b/log-tree.c
@@ -5,8 +5,8 @@
 #include "commit-reach.h"
 #include "odb/commit-slab.h"
 #include "config.h"
-#include "diff.h"
-#include "diffcore.h"
+#include "diff/diff.h"
+#include "diff/diffcore.h"
 #include "environment.h"
 #include "hex.h"
 #include "odb/object-name.h"
@@ -28,7 +28,7 @@
 #include "sequencer.h"
 #include "line-log.h"
 #include "help.h"
-#include "range-diff.h"
+#include "diff/range-diff.h"
 #include "strmap.h"
 #include "odb/tree.h"
 #include "wildmatch.h"
diff --git a/merge-ll.c b/merge-ll.c
index ef5287dee8..2aa45bfa90 100644
--- a/merge-ll.c
+++ b/merge-ll.c
@@ -11,7 +11,7 @@
 #include "config.h"
 #include "convert.h"
 #include "attr.h"
-#include "xdiff-interface.h"
+#include "diff/xdiff-interface.h"
 #include "run-command.h"
 #include "merge-ll.h"
 #include "quote.h"
diff --git a/merge-ort.c b/merge-ort.c
index a12bf62a3d..61fb855500 100644
--- a/merge-ort.c
+++ b/merge-ort.c
@@ -27,8 +27,8 @@
 #include "odb/commit.h"
 #include "commit-reach.h"
 #include "config.h"
-#include "diff.h"
-#include "diffcore.h"
+#include "diff/diff.h"
+#include "diff/diffcore.h"
 #include "dir.h"
 #include "environment.h"
 #include "gettext.h"
@@ -51,7 +51,7 @@
 #include "trace2.h"
 #include "odb/tree.h"
 #include "unpack-trees.h"
-#include "xdiff-interface.h"
+#include "diff/xdiff-interface.h"
 
 /*
  * We technically need USE_THE_REPOSITORY_VARIABLE above for DEFAULT_ABBREV,
diff --git a/meson.build b/meson.build
index 238beb0dfd..87060ff883 100644
--- a/meson.build
+++ b/meson.build
@@ -333,7 +333,7 @@ libgit_sources = [
   'pack/chunk-format.c',
   'color.c',
   'column.c',
-  'combine-diff.c',
+  'diff/combine-diff.c',
   'pack/commit-graph.c',
   'commit-reach.c',
   'odb/commit.c',
@@ -353,16 +353,16 @@ libgit_sources = [
   'pack/delta-islands.c',
   'diagnose.c',
   'pack/diff-delta.c',
-  'diff-merges.c',
-  'diff-lib.c',
-  'diff-no-index.c',
-  'diff.c',
-  'diffcore-break.c',
-  'diffcore-delta.c',
-  'diffcore-order.c',
-  'diffcore-pickaxe.c',
-  'diffcore-rename.c',
-  'diffcore-rotate.c',
+  'diff/diff-merges.c',
+  'diff/diff-lib.c',
+  'diff/diff-no-index.c',
+  'diff/diff.c',
+  'diff/diffcore-break.c',
+  'diff/diffcore-delta.c',
+  'diff/diffcore-order.c',
+  'diff/diffcore-pickaxe.c',
+  'diff/diffcore-rename.c',
+  'diff/diffcore-rotate.c',
   'dir-iterator.c',
   'dir.c',
   'editor.c',
@@ -462,7 +462,7 @@ libgit_sources = [
   'parse-options-cb.c',
   'parse-options.c',
   'pack/patch-delta.c',
-  'patch-ids.c',
+  'diff/patch-ids.c',
   'path.c',
   'path-walk.c',
   'pathspec.c',
@@ -478,7 +478,7 @@ libgit_sources = [
   'pack/prune-packed.c',
   'pack/pseudo-merge.c',
   'quote.c',
-  'range-diff.c',
+  'diff/range-diff.c',
   'pack/reachable.c',
   'read-cache.c',
   'rebase-interactive.c',
@@ -565,7 +565,7 @@ libgit_sources = [
   'trailer.c',
   'transport-helper.c',
   'transport.c',
-  'tree-diff.c',
+  'diff/tree-diff.c',
   'odb/tree-walk.c',
   'odb/tree.c',
   'unpack-trees.c',
@@ -573,7 +573,7 @@ libgit_sources = [
   'url.c',
   'urlmatch.c',
   'usage.c',
-  'userdiff.c',
+  'diff/userdiff.c',
   'utf8.c',
   'version.c',
   'versioncmp.c',
@@ -584,7 +584,7 @@ libgit_sources = [
   'write-or-die.c',
   'ws.c',
   'wt-status.c',
-  'xdiff-interface.c',
+  'diff/xdiff-interface.c',
   'xdiff/xdiffi.c',
   'xdiff/xemit.c',
   'xdiff/xhistogram.c',
diff --git a/notes-merge.c b/notes-merge.c
index 72a3b9479c..ff14b7dfcc 100644
--- a/notes-merge.c
+++ b/notes-merge.c
@@ -11,10 +11,10 @@
 #include "odb/odb.h"
 #include "path.h"
 #include "repository.h"
-#include "diff.h"
-#include "diffcore.h"
+#include "diff/diff.h"
+#include "diff/diffcore.h"
 #include "hex.h"
-#include "xdiff-interface.h"
+#include "diff/xdiff-interface.h"
 #include "merge-ll.h"
 #include "dir.h"
 #include "notes.h"
diff --git a/odb/commit.c b/odb/commit.c
index 06daa8c6a0..b78cd28013 100644
--- a/odb/commit.c
+++ b/odb/commit.c
@@ -11,7 +11,7 @@
 #include "odb/object-name.h"
 #include "odb/odb.h"
 #include "utf8.h"
-#include "diff.h"
+#include "diff/diff.h"
 #include "revision.h"
 #include "notes.h"
 #include "odb/alloc.h"
diff --git a/pack/bloom.c b/pack/bloom.c
index 874e011530..3fdbbf3aba 100644
--- a/pack/bloom.c
+++ b/pack/bloom.c
@@ -2,8 +2,8 @@
 
 #include "git-compat-util.h"
 #include "pack/bloom.h"
-#include "diff.h"
-#include "diffcore.h"
+#include "diff/diff.h"
+#include "diff/diffcore.h"
 #include "hashmap.h"
 #include "pack/commit-graph.h"
 #include "odb/commit.h"
diff --git a/pack/delta-islands.c b/pack/delta-islands.c
index 3d015719a5..7c48204384 100644
--- a/pack/delta-islands.c
+++ b/pack/delta-islands.c
@@ -9,7 +9,7 @@
 #include "odb/tree.h"
 #include "pack/pack.h"
 #include "odb/tree-walk.h"
-#include "diff.h"
+#include "diff/diff.h"
 #include "progress.h"
 #include "refs/refs.h"
 #include "khash.h"
diff --git a/pack/pack-bitmap-write.c b/pack/pack-bitmap-write.c
index 6ef5fb4629..22ee370bde 100644
--- a/pack/pack-bitmap-write.c
+++ b/pack/pack-bitmap-write.c
@@ -6,7 +6,7 @@
 #include "hex.h"
 #include "odb/odb.h"
 #include "odb/commit.h"
-#include "diff.h"
+#include "diff/diff.h"
 #include "revision.h"
 #include "progress.h"
 #include "pack/pack.h"
diff --git a/pack/pack-bitmap.c b/pack/pack-bitmap.c
index 80f853f355..3adb5d0563 100644
--- a/pack/pack-bitmap.c
+++ b/pack/pack-bitmap.c
@@ -6,7 +6,7 @@
 #include "hex.h"
 #include "strbuf.h"
 #include "odb/tag.h"
-#include "diff.h"
+#include "diff/diff.h"
 #include "revision.h"
 #include "progress.h"
 #include "list-objects.h"
diff --git a/pack/reachable.c b/pack/reachable.c
index 51c13b552f..7989f7327a 100644
--- a/pack/reachable.c
+++ b/pack/reachable.c
@@ -6,7 +6,7 @@
 #include "refs/refs.h"
 #include "odb/commit.h"
 #include "odb/blob.h"
-#include "diff.h"
+#include "diff/diff.h"
 #include "revision.h"
 #include "pack/reachable.h"
 #include "cache-tree.h"
diff --git a/pretty.c b/pretty.c
index 4575f3fde6..3444617506 100644
--- a/pretty.c
+++ b/pretty.c
@@ -9,7 +9,7 @@
 #include "odb/hash.h"
 #include "hex.h"
 #include "utf8.h"
-#include "diff.h"
+#include "diff/diff.h"
 #include "pager.h"
 #include "revision.h"
 #include "string-list.h"
diff --git a/read-cache.c b/read-cache.c
index 148a93f10e..5bca3fda12 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -10,8 +10,8 @@
 #include "git-compat-util.h"
 #include "config.h"
 #include "date.h"
-#include "diff.h"
-#include "diffcore.h"
+#include "diff/diff.h"
+#include "diff/diffcore.h"
 #include "hex.h"
 #include "tempfile.h"
 #include "lockfile.h"
diff --git a/refs/reflog-walk.c b/refs/reflog-walk.c
index 711b71be66..f9eee9a76f 100644
--- a/refs/reflog-walk.c
+++ b/refs/reflog-walk.c
@@ -3,7 +3,7 @@
 #include "git-compat-util.h"
 #include "odb/commit.h"
 #include "refs/refs.h"
-#include "diff.h"
+#include "diff/diff.h"
 #include "repository.h"
 #include "revision.h"
 #include "string-list.h"
diff --git a/remote.c b/remote.c
index 39e9f58cba..c619009d30 100644
--- a/remote.c
+++ b/remote.c
@@ -16,7 +16,7 @@
 #include "odb/odb.h"
 #include "path.h"
 #include "odb/commit.h"
-#include "diff.h"
+#include "diff/diff.h"
 #include "revision.h"
 #include "dir.h"
 #include "setup.h"
diff --git a/rerere.c b/rerere.c
index 6ff20d0692..3055989a41 100644
--- a/rerere.c
+++ b/rerere.c
@@ -12,7 +12,7 @@
 #include "string-list.h"
 #include "read-cache-ll.h"
 #include "rerere.h"
-#include "xdiff-interface.h"
+#include "diff/xdiff-interface.h"
 #include "dir.h"
 #include "resolve-undo.h"
 #include "merge-ll.h"
diff --git a/revision.c b/revision.c
index f92a6482f1..249a1736fd 100644
--- a/revision.c
+++ b/revision.c
@@ -14,15 +14,15 @@
 #include "odb/blob.h"
 #include "odb/tree.h"
 #include "odb/commit.h"
-#include "diff.h"
-#include "diff-merges.h"
+#include "diff/diff.h"
+#include "diff/diff-merges.h"
 #include "refs/refs.h"
 #include "revision.h"
 #include "repository.h"
 #include "graph.h"
 #include "grep.h"
 #include "refs/reflog-walk.h"
-#include "patch-ids.h"
+#include "diff/patch-ids.h"
 #include "decorate.h"
 #include "string-list.h"
 #include "line-log.h"
diff --git a/revision.h b/revision.h
index e0ff7aa0f2..64d9a47091 100644
--- a/revision.h
+++ b/revision.h
@@ -7,7 +7,7 @@
 #include "odb/object-name.h"
 #include "odb/oidset.h"
 #include "pretty.h"
-#include "diff.h"
+#include "diff/diff.h"
 #include "odb/commit-slab-decl.h"
 #include "decorate.h"
 #include "ident.h"
diff --git a/sequencer.c b/sequencer.c
index d13721ab1f..551e4529c4 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -22,7 +22,7 @@
 #include "hook.h"
 #include "utf8.h"
 #include "cache-tree.h"
-#include "diff.h"
+#include "diff/diff.h"
 #include "path.h"
 #include "revision.h"
 #include "rerere.h"
diff --git a/shallow.c b/shallow.c
index daa6db8e0d..fa16834aff 100644
--- a/shallow.c
+++ b/shallow.c
@@ -12,7 +12,7 @@
 #include "refs/refs.h"
 #include "odb/oid-array.h"
 #include "path.h"
-#include "diff.h"
+#include "diff/diff.h"
 #include "revision.h"
 #include "odb/commit-slab.h"
 #include "list-objects.h"
diff --git a/submodule.c b/submodule.c
index 32af65e6b8..a9137aa180 100644
--- a/submodule.c
+++ b/submodule.c
@@ -8,14 +8,14 @@
 #include "submodule-config.h"
 #include "submodule.h"
 #include "dir.h"
-#include "diff.h"
+#include "diff/diff.h"
 #include "odb/commit.h"
 #include "environment.h"
 #include "gettext.h"
 #include "hex.h"
 #include "revision.h"
 #include "run-command.h"
-#include "diffcore.h"
+#include "diff/diffcore.h"
 #include "refs/refs.h"
 #include "string-list.h"
 #include "odb/oid-array.h"
diff --git a/t/helper/test-revision-walking.c b/t/helper/test-revision-walking.c
index 1b7f569f01..7c66b8566f 100644
--- a/t/helper/test-revision-walking.c
+++ b/t/helper/test-revision-walking.c
@@ -12,7 +12,7 @@
 
 #include "test-tool.h"
 #include "odb/commit.h"
-#include "diff.h"
+#include "diff/diff.h"
 #include "line-log.h"
 #include "odb/object-name.h"
 #include "repository.h"
diff --git a/t/helper/test-userdiff.c b/t/helper/test-userdiff.c
index fc34c589b3..ee829e0868 100644
--- a/t/helper/test-userdiff.c
+++ b/t/helper/test-userdiff.c
@@ -2,7 +2,7 @@
 
 #include "test-tool.h"
 #include "setup.h"
-#include "userdiff.h"
+#include "diff/userdiff.h"
 #include "config.h"
 
 static int driver_cb(struct userdiff_driver *driver,
diff --git a/upload-pack.c b/upload-pack.c
index d145a89c7b..acd381ebf1 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -14,7 +14,7 @@
 #include "odb/oid-array.h"
 #include "odb/object.h"
 #include "odb/commit.h"
-#include "diff.h"
+#include "diff/diff.h"
 #include "revision.h"
 #include "list-objects-filter-options.h"
 #include "run-command.h"
diff --git a/wt-status.c b/wt-status.c
index 708366b973..28a0c72a51 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -7,7 +7,7 @@
 #include "odb/object.h"
 #include "dir.h"
 #include "odb/commit.h"
-#include "diff.h"
+#include "diff/diff.h"
 #include "environment.h"
 #include "gettext.h"
 #include "odb/hash.h"
@@ -15,7 +15,7 @@
 #include "odb/object-name.h"
 #include "path.h"
 #include "revision.h"
-#include "diffcore.h"
+#include "diff/diffcore.h"
 #include "quote.h"
 #include "repository.h"
 #include "run-command.h"
-- 
2.54.0

