Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03DB33321D8
	for <git@vger.kernel.org>; Wed,  4 Mar 2026 12:20:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772626802; cv=none; b=YvPrpdfD6OAII+E5amH05BDH8mOEMjSH+AVPfY/ubec4BgAQYulv3zaLTvGeOTmXnC7dcslgnFy7/Zyc9KirNFMkquQ4fY4ZZNb/YOY59wpqagBVSB/s8nJ5IoYw7wWSuFx4u857yjO1pHtv4VsobGoMtondmwC3pPQ8W+V5x2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772626802; c=relaxed/simple;
	bh=RGsTLmt2wobuUzVxDz/NSn0TPDwz5psFXtoqqGYH+Hw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tp3A9UbUHBMWXQNBgyuMv344b6kOky3Ea2NOFhNMMHRa8SMzms+Uv5lgafImTPr1Mle6ARlBiRt53PVyI4HJW52IVAaoIo6iPqlsbGEPvlY4O4Ig+l/+EPNEU7WO8GqKJREnSzYAsf63NT0+1sZg6rWpN2rgXD2FEgTclAjoNoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e9zGYNmC; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e9zGYNmC"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-48372efa020so59737385e9.2
        for <git@vger.kernel.org>; Wed, 04 Mar 2026 04:20:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772626799; x=1773231599; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=XTngy680fvx+CLwgwUVFcRJnFyxMi7V3kfQ3CrM1jXg=;
        b=e9zGYNmC3+A8GhrAcMcCOAxLhSk7u6jjKhf6CcxN7nEsTlbCruWj4faZPCE7S2ws6w
         6fqznGKWnCAT2XY0N/X1G48qV45yXILAY+AdO3CFLop8aYFUlLkyVubfNnSWxyC4kjp7
         PUvCMzSvXyjrPd1+DWmbS8vSjupACJwygGrtBhuIkFGRpeIoS9PKR5/o2UERACpgzGC2
         vJteYyO+Wp5fKbc501cOqb3e9VH4WubQUt/IqoH74DN2HSzXCB2IG+9YcX5sFfZo5cNd
         cCfNETpKGouVetev0hTAJ9n1+OMXXl9IsU1dyhrpHLrJZ6dp/AhOyxmVMU7m157fwQ4y
         sLbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772626799; x=1773231599;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XTngy680fvx+CLwgwUVFcRJnFyxMi7V3kfQ3CrM1jXg=;
        b=bmZRh6QkSteXsG5IRoSEFfJRId3aw68N3oR0RY4jjlAtYOpfblsjp6OERIOmjEqJmm
         1cj7slaTfbXl2y7a3Rv1F1yk/Y7WdlZbgupCd7mNdZ3o55rCYLgr73Dvj7buDzQJamhe
         FjaAr2iyYVRbt0l7NKxEw3uGsa6T7kPhOdxjDZgd4zJrS3nBEzHSB//RygEHofOZiEfQ
         cWOBPZM0Dl8/uFGMftn2A9Wpdnh62AKyQ0+qnquuhGSGuwsTQt9xmnSVxw7BLPL2hT86
         kBU3ZzU2OIcJqD/1zqNXLrG8G+o+ESucab+MB5TVw5h3GpcnKzFzQ+vCmz5EIh0E5G3n
         Il6g==
X-Gm-Message-State: AOJu0YwNUQY14UiNuX/JaYm9KJhNdNfWkrfcq2omtrI3pylQyF11eaFA
	ZfoUOezeVmkMOan2LEcwVL+zr4j/iVll4HrzZJq/3ib4vN5k9KXSCTQ8urjjezI=
X-Gm-Gg: ATEYQzzCCTWldoeadrRf5XfudMeOxd/rxmewIuAE6V7JURJyXTA3YaEqAqB31cKZUAb
	l4FreG7Uvtzgcgny6vG8Vl1OJ3P6dhdPe2w8hClfE7R+pxJokjdZIJtGKJmKJKgMyC4NSN/UkSN
	wuhkXV2StJVwVNu+aHdfUTO3bvFFvHRJwPqziu38iAUPnv87NvmcLqsu8Nxx6hCh//zJQs/SAFY
	gRVe8MlSwtClmd498+dVoQ/LfzwuxTUvv6nkQ2dRI3B1kuXMf3uW6789JQawiUBIBu3eMvrJP2L
	nXVtGOq6ucHi+3/eJH2T7neS1dWVdmg+p3YnhhXkSB64moCxYDlEsUNEphompwg1vu3NjVpRMib
	54INaa5nSL9bH5QHdyyR62jWIjdWUko7x2X8BKzmz4e7bKyTwMoD4yI2/AH7M4umI8OOPRYzmE7
	lemFfu4R0l1BlT2mejhLKi8QLJHNEjpaJQQ85nFTq4k8lxfyTHQgxet5X39ybDvjKz5wVbBBrai
	eMqxMxbEpdTgCUDc/GStu83vO9f88FGQw==
X-Received: by 2002:a05:600c:64ce:b0:47e:e807:a05a with SMTP id 5b1f17b1804b1-485198b32b8mr26436405e9.33.1772626798789;
        Wed, 04 Mar 2026 04:19:58 -0800 (PST)
Received: from Mac.lan (93-35-138-59.ip55.fastwebnet.it. [93.35.138.59])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-439b1b97927sm27892038f8f.28.2026.03.04.04.19.58
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 04 Mar 2026 04:19:58 -0800 (PST)
From: Francesco Paparatto <francescopaparatto@gmail.com>
To: git@vger.kernel.org
Cc: Francesco Paparatto <francescopaparatto@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] t3310: avoid hiding failures from rev-parse in command substitutions
Date: Wed,  4 Mar 2026 13:19:55 +0100
Message-ID: <20260304121955.73794-1-francescopaparatto@gmail.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Running `git` commands inside command substitutions like

    test "$(git rev-parse A)" = "$(git rev-parse B)"

can hide failures from the `git` invocations. Extract the
`rev-parse` calls into variables so failures are not ignored.

Suggested-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Francesco Paparatto <francescopaparatto@gmail.com>
---
 t/t3310-notes-merge-manual-resolve.sh | 54 ++++++++++++++++++---------
 1 file changed, 36 insertions(+), 18 deletions(-)

diff --git a/t/t3310-notes-merge-manual-resolve.sh b/t/t3310-notes-merge-manual-resolve.sh
index f0054b0a39..92a5951331 100755
--- a/t/t3310-notes-merge-manual-resolve.sh
+++ b/t/t3310-notes-merge-manual-resolve.sh
@@ -227,7 +227,8 @@ test_expect_success 'merge z into m (== y) with default ("manual") resolver => C
 	# Verify that current notes tree (pre-merge) has not changed (m == y)
 	verify_notes y &&
 	verify_notes m &&
-	test "$(git rev-parse refs/notes/m)" = "$(cat pre_merge_y)"
+	m=$(git rev-parse refs/notes/m) &&
+	test "$m" = "$(cat pre_merge_y)"
 '
 
 cat <<EOF | sort >expect_notes_z
@@ -375,8 +376,10 @@ EOF
 	git notes merge --commit &&
 	notes_merge_files_gone &&
 	# Merge commit has pre-merge y and pre-merge z as parents
-	test "$(git rev-parse refs/notes/m^1)" = "$(cat pre_merge_y)" &&
-	test "$(git rev-parse refs/notes/m^2)" = "$(cat pre_merge_z)" &&
+	m1=$(git rev-parse refs/notes/m^1) &&
+	m2=$(git rev-parse refs/notes/m^2) &&
+	test "$m1" = "$(cat pre_merge_y)" &&
+	test "$m2" = "$(cat pre_merge_z)" &&
 	# Merge commit mentions the notes refs merged
 	git log -1 --format=%B refs/notes/m > merge_commit_msg &&
 	grep -q refs/notes/m merge_commit_msg &&
@@ -428,14 +431,16 @@ test_expect_success 'redo merge of z into m (== y) with default ("manual") resol
 	# Verify that current notes tree (pre-merge) has not changed (m == y)
 	verify_notes y &&
 	verify_notes m &&
-	test "$(git rev-parse refs/notes/m)" = "$(cat pre_merge_y)"
+	m=$(git rev-parse refs/notes/m) &&
+	test "$m" = "$(cat pre_merge_y)"
 '
 
 test_expect_success 'abort notes merge' '
 	git notes merge --abort &&
 	notes_merge_files_gone &&
 	# m has not moved (still == y)
-	test "$(git rev-parse refs/notes/m)" = "$(cat pre_merge_y)" &&
+	m=$(git rev-parse refs/notes/m) &&
+	test "$m" = "$(cat pre_merge_y)" &&
 	# Verify that other notes refs has not changed (w, x, y and z)
 	verify_notes w &&
 	verify_notes x &&
@@ -460,7 +465,8 @@ test_expect_success 'redo merge of z into m (== y) with default ("manual") resol
 	# Verify that current notes tree (pre-merge) has not changed (m == y)
 	verify_notes y &&
 	verify_notes m &&
-	test "$(git rev-parse refs/notes/m)" = "$(cat pre_merge_y)"
+	m=$(git rev-parse refs/notes/m) &&
+	test "$m" = "$(cat pre_merge_y)"
 '
 
 cat <<EOF | sort >expect_notes_m
@@ -500,8 +506,10 @@ EOF
 	git notes merge --commit &&
 	notes_merge_files_gone &&
 	# Merge commit has pre-merge y and pre-merge z as parents
-	test "$(git rev-parse refs/notes/m^1)" = "$(cat pre_merge_y)" &&
-	test "$(git rev-parse refs/notes/m^2)" = "$(cat pre_merge_z)" &&
+	m1=$(git rev-parse refs/notes/m^1) &&
+	m2=$(git rev-parse refs/notes/m^2) &&
+	test "$m1" = "$(cat pre_merge_y)" &&
+	test "$m2" = "$(cat pre_merge_z)" &&
 	# Merge commit mentions the notes refs merged
 	git log -1 --format=%B refs/notes/m > merge_commit_msg &&
 	grep -q refs/notes/m merge_commit_msg &&
@@ -539,7 +547,8 @@ test_expect_success 'redo merge of z into m (== y) with default ("manual") resol
 	# Verify that current notes tree (pre-merge) has not changed (m == y)
 	verify_notes y &&
 	verify_notes m &&
-	test "$(git rev-parse refs/notes/m)" = "$(cat pre_merge_y)"
+	m=$(git rev-parse refs/notes/m) &&
+	test "$m" = "$(cat pre_merge_y)"
 '
 
 cp expect_notes_w expect_notes_m
@@ -548,7 +557,9 @@ cp expect_log_w expect_log_m
 test_expect_success 'reset notes ref m to somewhere else (w)' '
 	git update-ref refs/notes/m refs/notes/w &&
 	verify_notes m &&
-	test "$(git rev-parse refs/notes/m)" = "$(git rev-parse refs/notes/w)"
+	m=$(git rev-parse refs/notes/m) &&
+	w=$(git rev-parse refs/notes/w) &&
+	test "$m" = "$w"
 '
 
 test_expect_success 'fail to finalize conflicting merge if underlying ref has moved in the meantime (m != NOTES_MERGE_PARTIAL^1)' '
@@ -569,13 +580,17 @@ EOF
 	test_path_is_file .git/NOTES_MERGE_WORKTREE/$commit_sha3 &&
 	test_path_is_file .git/NOTES_MERGE_WORKTREE/$commit_sha4 &&
 	# Refs are unchanged
-	test "$(git rev-parse refs/notes/m)" = "$(git rev-parse refs/notes/w)" &&
-	test "$(git rev-parse refs/notes/y)" = "$(git rev-parse NOTES_MERGE_PARTIAL^1)" &&
-	test "$(git rev-parse refs/notes/m)" != "$(git rev-parse NOTES_MERGE_PARTIAL^1)" &&
+	m=$(git rev-parse refs/notes/m) &&
+	w=$(git rev-parse refs/notes/w) &&
+	y=$(git rev-parse refs/notes/y) &&
+	p1=$(git rev-parse NOTES_MERGE_PARTIAL^1) &&
+	test "$m" = "$w" &&
+	test "$y" = "$p1" &&
+	test "$m" != "$p1" &&
 	# Mention refs/notes/m, and its current and expected value in output
 	test_grep -q "refs/notes/m" output &&
-	test_grep -q "$(git rev-parse refs/notes/m)" output &&
-	test_grep -q "$(git rev-parse NOTES_MERGE_PARTIAL^1)" output &&
+	test_grep -q "$m" output &&
+	test_grep -q "$p1" output &&
 	# Verify that other notes refs has not changed (w, x, y and z)
 	verify_notes w &&
 	verify_notes x &&
@@ -587,7 +602,9 @@ test_expect_success 'resolve situation by aborting the notes merge' '
 	git notes merge --abort &&
 	notes_merge_files_gone &&
 	# m has not moved (still == w)
-	test "$(git rev-parse refs/notes/m)" = "$(git rev-parse refs/notes/w)" &&
+	m=$(git rev-parse refs/notes/m) &&
+	w=$(git rev-parse refs/notes/w) &&
+	test "$m" = "$w" &&
 	# Verify that other notes refs has not changed (w, x, y and z)
 	verify_notes w &&
 	verify_notes x &&
@@ -606,8 +623,9 @@ test_expect_success 'switch cwd before committing notes merge' '
 	test_must_fail git notes merge refs/notes/other &&
 	(
 		cd .git/NOTES_MERGE_WORKTREE &&
-		echo "foo" > $(git rev-parse HEAD) &&
-		echo "bar" >> $(git rev-parse HEAD) &&
+		oid=$(git rev-parse HEAD) &&
+		echo "foo" >"$oid" &&
+		echo "bar" >>"$oid" &&
 		git notes merge --commit
 	) &&
 	git notes show HEAD > actual_notes &&
-- 
2.52.0

