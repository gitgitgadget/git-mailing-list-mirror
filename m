Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F55B2989BC
	for <git@vger.kernel.org>; Fri, 23 May 2025 17:21:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748020922; cv=none; b=OM/Srrz19wYGv2JwbqXEzRR/qsNVpizdQ3d++J0OB8FCNtQ14Z6iYrtqxxelGrZXxpkqKOLSmaU3csHIxHmdzGvAOpThzlX3Q+dJ1T6WQs9EnAFPtbJiDvITTlNq3ziXV4sw6bzGtxO4mvHIvYV12USUr09s6FTxUMmqFGHoPfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748020922; c=relaxed/simple;
	bh=nNsiuax9Or/KA6n6pQ4VafhQllLQhTvntukvk14+hug=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=n4/5gbnuNY8qiMavU1M+t5bVXUM47Y1o30jiv+CLd36yM0djb0MOui1+lpYZC4H6aY8PWPiXxb0WSnte1euztfwdHfcZt0Bum0VjyF5IE9sJDWGmY/jXdqnr21/KgUEOAZ2GcbC/9Hz/8m5wFWE7xPnXZ2yNS4q8/q9hW+rmXQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=mJEbSSDd; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="mJEbSSDd"
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-4769bbc21b0so708901cf.2
        for <git@vger.kernel.org>; Fri, 23 May 2025 10:21:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1748020918; x=1748625718; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9RqEPC5XJW71psdV5PQVnRQ4KamRTuI/BYA2HQZJ9DA=;
        b=mJEbSSDdjPmnrL9BlNW5O7ouUvi6w7j7PlUy5P0ihcx9tRCN6zaYqGh67QP1gY1K/B
         rddz16+f3i0zb8qNUs/Ch0apDlhm3JTIx2nDNaRaQdr3SD1Xps3c0JJHENLImkEakPdL
         fHgc4negl6mpT0cgFPiSddb1qTdiRIpOVdwQs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748020918; x=1748625718;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9RqEPC5XJW71psdV5PQVnRQ4KamRTuI/BYA2HQZJ9DA=;
        b=W+x9qqhYy0DIVxyHVMX39VZ5eKDT55cFKdmeIBPEKD49mgHQa74/D9dxBXrDMzeH45
         J9BEehMyQBiTEq9T4tiU7d9gxriotKi879ewAwG0+fYlh7AjNUAopDKq+dnDp7knpeGP
         5X4vvVRvBlPhQYKFlWhbtDLapq33rc13MQj6u+lgnNNtBaR3TB499z3bFJhKxSM39EH2
         b3Q9bVx1q+2NSM9asMQ+AxGnXhQYG6xrr3YqT4s8saiVyw06dDcBflKWNSt/DAxf9Qec
         64sOoM2n9JIEucSxCShpbAu9OVhEmXGHmdcEo4sa50ufk9yXHtx89WBemaiFaynPmcYG
         6zKg==
X-Gm-Message-State: AOJu0YxHnpYMtEr+7MMYQdlDX10vFX8joqCfQ3lMMMABbA2hDl0VNSYy
	1nDSidArHnen2gD4qTP//J1Kn/NdDM573yNXfYm/SwwIgn1Aqndgf74Lwc6MHPhqf4nZ9iQE5ez
	yMwxppQ==
X-Gm-Gg: ASbGncuxDXMLKDzDn9IRdisryhpiyVrORWssojZUJck4R63wby4YnfSAgoNiC3OSVpa
	bVBdKl3NPTDldlekxNl8zTkzIoJkVFGNU3j4uFYHY9AXHG6N3ct/Qn649JRe2qKsJ90kRnL0gEg
	sU56DpuHO5fDLn82XczJcESCmLueglG4k+QQKPqi7Ce5rMVR+eMelrENkQBLOh3AyU+I8b6my3g
	T+dx1ENbDKgwv7HnayWQOsc7MEsQ4r4nTl0rTsBaGV9bO3WU4lyBKZyaOwHfzBsghS3D2Esk9pn
	moULmv2dB0zvz66K0pIfnkM1xSNKSQKkVkpGq6SVWbtX92VJEdNTObk8ROjCldJtgtsxpJM=
X-Google-Smtp-Source: AGHT+IEr8IaytUX2aM+SLRr5lsFv55KC95TRjwtjZtAxhOzRqqreRz/iAn3LBCxzEcsuIP56Ayz5tA==
X-Received: by 2002:a05:622a:1e0b:b0:494:a31b:c3ac with SMTP id d75a77b69052e-49f46650909mr181371cf.1.1748020917852;
        Fri, 23 May 2025 10:21:57 -0700 (PDT)
Received: from redacted ([2600:4040:9ce0:6400:e585:dc50:f5e1:64e7])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-494ae3cd517sm116219891cf.10.2025.05.23.10.21.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 May 2025 10:21:57 -0700 (PDT)
From: Mark Mentovai <mark@chromium.org>
To: Git Development <git@vger.kernel.org>
Cc: Junio C Hamano <gitster@pobox.com>,
	Chandra Pratap <chandrapratap3519@gmail.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
Subject: [PATCH v2 2/2] apply: set file mode when --reverse creates a deleted file
Date: Fri, 23 May 2025 13:21:54 -0400
Message-ID: <20250523172154.93810-3-mark@chromium.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250523172154.93810-1-mark@chromium.org>
References: <20250522220235.8650-1-mark@chromium.org>
 <20250523172154.93810-1-mark@chromium.org>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit 01aff0a (apply: correctly reverse patch's pre- and post-image
mode bits, 2023-12-26) revised reverse_patches() to maintain the desired
property that when only one of patch::old_mode and patch::new_mode is
set, the mode will be carried in old_mode. That property is generally
correct, with one notable exception: when creating a file, only new_mode
will be set. Since reversing a deletion results in a creation, new_mode
must be set in that case.

Omitting handling for this case means that reversing a patch that
removes an executable file will not result in the executable permission
being set on the re-created file. Existing test coverage for file modes
focuses only on mode changes of existing files.

Swap old_mode and new_mode in reverse_patches() for what's represented
in the patch as a file deletion, as it is transformed into a file
creation under reversal. This causes git apply --reverse to set the
executable permission properly when re-creating a deleted executable
file.

Add tests ensuring that git apply sets file modes correctly on file
creation, both in the forward and reverse directions.

Signed-off-by: Mark Mentovai <mark@chromium.org>
---
 apply.c                   |   2 +-
 t/t4129-apply-samemode.sh | 152 +++++++++++++++++++++++++++++++++++++-
 2 files changed, 151 insertions(+), 3 deletions(-)

diff --git a/apply.c b/apply.c
index f274a3794877..bd4571f89358 100644
--- a/apply.c
+++ b/apply.c
@@ -2219,7 +2219,7 @@ static void reverse_patches(struct patch *p)
 		struct fragment *frag = p->fragments;
 
 		SWAP(p->new_name, p->old_name);
-		if (p->new_mode)
+		if (p->new_mode || p->is_delete)
 			SWAP(p->new_mode, p->old_mode);
 		SWAP(p->is_new, p->is_delete);
 		SWAP(p->lines_added, p->lines_deleted);
diff --git a/t/t4129-apply-samemode.sh b/t/t4129-apply-samemode.sh
index 082e56db651e..4b64b7213f76 100755
--- a/t/t4129-apply-samemode.sh
+++ b/t/t4129-apply-samemode.sh
@@ -102,14 +102,18 @@ test_expect_success POSIXPERM 'do not use core.sharedRepository for working tree
 	)
 '
 
+test_file_mode_common() {
+	test -n "$1" && test_grep "^10$1 " "$2" || test_must_be_empty "$2"
+}
+
 test_file_mode_staged () {
 	git ls-files --stage -- "$2" >ls-files-output &&
-	test_grep "^10$1 " ls-files-output
+	test_file_mode_common "$1" ls-files-output
 }
 
 test_file_mode_HEAD () {
 	git ls-tree HEAD -- "$2" >ls-tree-output &&
-	test_grep "^10$1 " ls-tree-output
+	test_file_mode_common "$1" ls-tree-output
 }
 
 test_expect_success 'git apply respects core.fileMode' '
@@ -180,6 +184,150 @@ test_expect_success 'git apply warns about incorrect file modes' '
 	test_file_mode_HEAD 0755 mode_test
 '
 
+test_expect_success 'setup: git apply [--reverse] restores file modes (change_x_to_notx)' '
+	test_config core.fileMode false &&
+
+	touch change_x_to_notx &&
+	git add --chmod=+x change_x_to_notx &&
+	test_file_mode_staged 0755 change_x_to_notx &&
+	test_tick && git commit -m "add change_x_to_notx as executable" &&
+	test_file_mode_HEAD 0755 change_x_to_notx &&
+
+	git add --chmod=-x change_x_to_notx &&
+	test_file_mode_staged 0644 change_x_to_notx &&
+	test_tick && git commit -m "make change_x_to_notx not executable" &&
+	test_file_mode_HEAD 0644 change_x_to_notx &&
+
+	git rm change_x_to_notx &&
+	test_file_mode_staged "" change_x_to_notx &&
+	test_tick && git commit -m "remove change_x_to_notx" &&
+	test_file_mode_HEAD "" change_x_to_notx &&
+
+	git format-patch -o patches -3 &&
+	mv patches/0001-* change_x_to_notx-0001-create-0755.patch &&
+	mv patches/0002-* change_x_to_notx-0002-chmod-0644.patch &&
+	mv patches/0003-* change_x_to_notx-0003-delete.patch &&
+
+	test_grep "^new file mode 100755$" change_x_to_notx-0001-create-0755.patch &&
+	test_grep "^old mode 100755$" change_x_to_notx-0002-chmod-0644.patch &&
+	test_grep "^new mode 100644$" change_x_to_notx-0002-chmod-0644.patch &&
+	test_grep "^deleted file mode 100644$" change_x_to_notx-0003-delete.patch
+'
+
+test_expect_success 'git apply restores file modes (change_x_to_notx)' '
+	test_config core.fileMode false &&
+
+	git apply --index change_x_to_notx-0001-create-0755.patch &&
+	test_file_mode_staged 0755 change_x_to_notx &&
+	test_tick && git commit -m "redo: add change_x_to_notx as executable" &&
+	test_file_mode_HEAD 0755 change_x_to_notx &&
+
+	git apply --index change_x_to_notx-0002-chmod-0644.patch 2>err &&
+	test_grep ! "has type 100.*, expected 100.*" err &&
+	test_file_mode_staged 0644 change_x_to_notx &&
+	test_tick && git commit -m "redo: make change_x_to_notx not executable" &&
+	test_file_mode_HEAD 0644 change_x_to_notx &&
+
+	git apply --index change_x_to_notx-0003-delete.patch 2>err &&
+	test_grep ! "has type 100.*, expected 100.*" err &&
+	test_file_mode_staged "" change_x_to_notx &&
+	test_tick && git commit -m "redo: remove change_notx_to_x" &&
+	test_file_mode_HEAD "" change_x_to_notx
+'
+
+test_expect_success 'git apply --reverse restores file modes (change_x_to_notx)' '
+	test_config core.fileMode false &&
+
+	git apply --index --reverse change_x_to_notx-0003-delete.patch &&
+	test_file_mode_staged 0644 change_x_to_notx &&
+	test_tick && git commit -m "undo: remove change_x_to_notx" &&
+	test_file_mode_HEAD 0644 change_x_to_notx &&
+
+	git apply --index --reverse change_x_to_notx-0002-chmod-0644.patch 2>err &&
+	test_grep ! "has type 100.*, expected 100.*" err &&
+	test_file_mode_staged 0755 change_x_to_notx &&
+	test_tick && git commit -m "undo: make change_x_to_notx not executable" &&
+	test_file_mode_HEAD 0755 change_x_to_notx &&
+
+	git apply --index --reverse change_x_to_notx-0001-create-0755.patch 2>err &&
+	test_grep ! "has type 100.*, expected 100.*" err &&
+	test_file_mode_staged "" change_x_to_notx &&
+	test_tick && git commit -m "undo: add change_x_to_notx as executable" &&
+	test_file_mode_HEAD "" change_x_to_notx
+'
+
+test_expect_success 'setup: git apply [--reverse] restores file modes (change_notx_to_x)' '
+	test_config core.fileMode false &&
+
+	touch change_notx_to_x &&
+	git add --chmod=-x change_notx_to_x &&
+	test_file_mode_staged 0644 change_notx_to_x &&
+	test_tick && git commit -m "add change_notx_to_x as not executable" &&
+	test_file_mode_HEAD 0644 change_notx_to_x &&
+
+	git add --chmod=+x change_notx_to_x &&
+	test_file_mode_staged 0755 change_notx_to_x &&
+	test_tick && git commit -m "make change_notx_to_x executable" &&
+	test_file_mode_HEAD 0755 change_notx_to_x &&
+
+	git rm change_notx_to_x &&
+	test_file_mode_staged "" change_notx_to_x &&
+	test_tick && git commit -m "remove change_notx_to_x" &&
+	test_file_mode_HEAD "" change_notx_to_x &&
+
+	git format-patch -o patches -3 &&
+	mv patches/0001-* change_notx_to_x-0001-create-0644.patch &&
+	mv patches/0002-* change_notx_to_x-0002-chmod-0755.patch &&
+	mv patches/0003-* change_notx_to_x-0003-delete.patch &&
+
+	test_grep "^new file mode 100644$" change_notx_to_x-0001-create-0644.patch &&
+	test_grep "^old mode 100644$" change_notx_to_x-0002-chmod-0755.patch &&
+	test_grep "^new mode 100755$" change_notx_to_x-0002-chmod-0755.patch &&
+	test_grep "^deleted file mode 100755$" change_notx_to_x-0003-delete.patch
+'
+
+test_expect_success 'git apply restores file modes (change_notx_to_x)' '
+	test_config core.fileMode false &&
+
+	git apply --index change_notx_to_x-0001-create-0644.patch &&
+	test_file_mode_staged 0644 change_notx_to_x &&
+	test_tick && git commit -m "redo: add change_notx_to_x as not executable" &&
+	test_file_mode_HEAD 0644 change_notx_to_x &&
+
+	git apply --index change_notx_to_x-0002-chmod-0755.patch 2>err &&
+	test_grep ! "has type 100.*, expected 100.*" err &&
+	test_file_mode_staged 0755 change_notx_to_x &&
+	test_tick && git commit -m "redo: make change_notx_to_x executable" &&
+	test_file_mode_HEAD 0755 change_notx_to_x &&
+
+	git apply --index change_notx_to_x-0003-delete.patch &&
+	test_grep ! "has type 100.*, expected 100.*" err &&
+	test_file_mode_staged "" change_notx_to_x &&
+	test_tick && git commit -m "undo: remove change_notx_to_x" &&
+	test_file_mode_HEAD "" change_notx_to_x
+'
+
+test_expect_success 'git apply --reverse restores file modes (change_notx_to_x)' '
+	test_config core.fileMode false &&
+
+	git apply --index --reverse change_notx_to_x-0003-delete.patch &&
+	test_file_mode_staged 0755 change_notx_to_x &&
+	test_tick && git commit -m "undo: remove change_notx_to_x" &&
+	test_file_mode_HEAD 0755 change_notx_to_x &&
+
+	git apply --index --reverse change_notx_to_x-0002-chmod-0755.patch 2>err &&
+	test_grep ! "has type 100.*, expected 100.*" err &&
+	test_file_mode_staged 0644 change_notx_to_x &&
+	test_tick && git commit -m "undo: make change_notx_to_x executable" &&
+	test_file_mode_HEAD 0644 change_notx_to_x &&
+
+	git apply --index --reverse change_notx_to_x-0001-create-0644.patch 2>err &&
+	test_grep ! "has type 100.*, expected 100.*" err &&
+	test_file_mode_staged "" change_notx_to_x &&
+	test_tick && git commit -m "undo: add change_notx_to_x as not executable" &&
+	test_file_mode_HEAD "" change_notx_to_x
+'
+
 test_expect_success POSIXPERM 'patch mode for new file is canonicalized' '
 	cat >patch <<-\EOF &&
 	diff --git a/non-canon b/non-canon
-- 
2.49.0

