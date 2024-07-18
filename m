Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B00C144D28
	for <git@vger.kernel.org>; Thu, 18 Jul 2024 19:55:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721332554; cv=none; b=fDXfK2iKmkvtPZzEa+SbfXqdy3NrTfRGEKrya8RWFOv+dQlt9Iyn/AZYRs3LexGd9Awl8VbLrZtT9JcLNwpi49XDkeVflwswPXS41PwSuFmKMfRVCMmOriBNnaz5YTh+xdJOlHp289FVLUv+ye3XUl/6Hgz0sRcTqtzikhVKEIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721332554; c=relaxed/simple;
	bh=lescR3G70Vw4KeNxEz4uGRz+9G7NhoALFzbIldAUyQ0=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=m2jAMh+ZfWzH/IdU3rWlXxhSrmtPyVutjDtID1gS3Q9qg7wcpCnaiW0i8YNP/a1DRk81sBMgL+p+lbpWxtUOdz0hqGNPnuXa3Jtdzyiztporay9dveAZIfs7SVP+A5OADQtzC+r2KVgoLznT2y0DxI4Uy/uiMPUjGzIKyva1Vgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=STSma1Sl; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="STSma1Sl"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-426717a2d12so4715855e9.0
        for <git@vger.kernel.org>; Thu, 18 Jul 2024 12:55:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721332550; x=1721937350; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CWRq4v+BNYFQ8GqQO3d79v9l/tDeROjQFjgs4Ku4+KQ=;
        b=STSma1Sl3v7ZNlWYfwL2JfqFQCKp1bq87E61YjdvIzYt+LERmzQg9NZhvk31OhrnX1
         EZ26opU9IJRtaOPHgjcey0xNKUq5VrfemBkSc9Bk7J+/JtbRrxoK/lEcH5GhkW0hUPMh
         5YkqnW1UR27sUJPm8fw8bLUuX7pTCf6lt/KqPc1yTWxsTHx8g4+QhuX4hfHovHaADCf5
         VWjTh37iZ6j2THwndfqdRKebl5covGPidM3S8SRAoNwgRJcVO8pXFIoWUlyyP/beuWUy
         Zkow9V9b+DYj+HLToGl6UuQ6LUcjRUFO8JF/yyTKSPcXoFJVlBmMIkjJhdVX4HKKYlc9
         hs2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721332550; x=1721937350;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CWRq4v+BNYFQ8GqQO3d79v9l/tDeROjQFjgs4Ku4+KQ=;
        b=IaFmf07Hwpusm29yL9BRbqfsGyHcJgWlEefVTD3/yJfZ+A0myZG7o3CLyAvwphVkWL
         7Mw/CC8S9kDhqgxDJIvvCJL0Qe1b5KsHdHmL3huhDY4BfXCCsb+yvoIJLn6aqRQ/1h66
         q0tGVGnITZfV6TFwMEsGEjEZOs0rwXrHfhtw2VF+Q56+ydX6yVOYtgiM7a6kfRcCNC+b
         41HcmxObOqU/ffBq3uzXxlLRhIF/GpET7Lt7vNC5EiaKX9+efOMWFuky8WotcIRT7VI7
         MI9uQIXrYPeGtaGyMVfdtAA5DGS7Z1qrKucA990tjdOSU24QxEjTaE2I8a0Ozo7+MOKn
         55Ag==
X-Gm-Message-State: AOJu0YwQd5T8BWKNtogVDMv1FPpEZAEecvGvdx8JB4zliHWyBeZjMcD4
	pgoig7vfnA1G5SwLWz3+CSTbx8uVAgdJRA2wFc1FlECmpBHd8o3LCENkHQ==
X-Google-Smtp-Source: AGHT+IExI44iMUsbKV5eLIuuVGz9u5uulY/EJ+Pt0PQZD/l1q3XDl6zzoasL0YiARzMIW1UG2Vdqpg==
X-Received: by 2002:a05:600c:4751:b0:426:5cc7:82f with SMTP id 5b1f17b1804b1-427d2b527demr14755515e9.13.1721332549706;
        Thu, 18 Jul 2024 12:55:49 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-427d2a7257esm26035645e9.28.2024.07.18.12.55.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jul 2024 12:55:48 -0700 (PDT)
Message-Id: <9b8e2012c9107f99e19c541113ae6a405e38a92f.1721332546.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1764.git.1721332546.gitgitgadget@gmail.com>
References: <pull.1764.git.1721332546.gitgitgadget@gmail.com>
From: "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 18 Jul 2024 19:55:45 +0000
Subject: [PATCH 1/2] t5319: add failing test case for repack/expire
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: gitster@pobox.com,
    me@ttayllorr.com,
    Derrick Stolee <stolee@gmail.com>,
    Derrick Stolee <stolee@gmail.com>

From: Derrick Stolee <stolee@gmail.com>

Git 2.45.0 included the change b7d6f23a171 (midx-write.c: use
`--stdin-packs` when repacking, 2024-04-01) which caused the 'git
multi-pack-index repack' command to use 'git pack-objects --stdin-packs'
instead of listing the objects to repack. While this change was
motivated by efficient cross-process communication and the ability to
improve delta compression, it breaks a fundamental function of the
'incremental-repack' task that is enabled by default in Scalar clones or
Git repositories that run 'git maintenance start'.

The 'incremental-repack' task performs a two-step process of the
'expire' and 'repack' subcommands of the 'git multi-pack-index' builtin.
The 'expire' command removes any pack-files listed in the
multi-pack-index but without any referenced objects. The 'repack' task
then finds a batch of pack-files to repack and sends their objects to
'git pack-objects'. Both the pack-files chosen for the batch and the
objects chosen to repack are based on the ones that the multi-pack-index
references. Objects that appear in a pack-file but have a duplicate copy
in a newer pack-file are not considered in this case. Since the
multi-pack-index references only the newest copy of an object, this
allows the next 'incremental-repack' task to remove the pack-files in
the next 'expire' task. This delay is intentional due to how Windows
handles may block deletion of files with open read handles.

However, the mentioned commit changed this behavior to divorce the set
of objects referenced by the multi-pack-index and instead use a set of
"included" and "excluded" pack-files in the 'git pack-objects' builtin.
When a pack-file is selected as "included", only the objects it contains
but are not in any "excluded" pack-files are considered for repacking.
This has led to client repositories failing to remove old pack-files as
they still have some referenced objects. This grows over time until the
point that Git is trying to repack the same pack-files over and over.

For now, create a test case that demonstrates the expected behavior, but
also fails in its final line. The setup here it attempting to recreate a
typical situation for a repository that uses a blobless partial clone.
There would be a large initial pack-file from the clone that is never
selected in the 'repack' batch. There are other pack-files that have a
combination of new objects from incremental fetches and possibly blobs
that are not connected to those incremental fetches; these blobs could
be filled in from commands like 'git checkout' or 'git blame'. The
pack-files also have some overlap on purpose so test-1 has some
duplicates in test-2 and test-2 has some duplicates in test-3.

At the end of the test, the test-2 pack-file still exists though it
should have been expired. This test will pass when reverting the
offending commit.

Signed-off-by: Derrick Stolee <stolee@gmail.com>
---
 t/t5319-multi-pack-index.sh | 55 +++++++++++++++++++++++++++++++++++++
 1 file changed, 55 insertions(+)

diff --git a/t/t5319-multi-pack-index.sh b/t/t5319-multi-pack-index.sh
index dd09134db03..327376233c5 100755
--- a/t/t5319-multi-pack-index.sh
+++ b/t/t5319-multi-pack-index.sh
@@ -1004,6 +1004,61 @@ test_expect_success 'repack --batch-size=<large> repacks everything' '
 	)
 '
 
+test_expect_failure 'repack/expire loop' '
+	git init repack-expire &&
+	test_when_finished "rm -fr repack-expire" &&
+	(
+		cd repack-expire &&
+
+		test_commit_bulk 5 &&
+
+		# Create three overlapping pack-files
+		git rev-list --objects HEAD~3 >in-1 &&
+		git rev-list --objects HEAD~4..HEAD~2 >in-2 &&
+		git rev-list --objects HEAD~3..HEAD >in-3 &&
+
+		# Create disconnected blobs
+		obj1=$(git hash-object -w in-1) &&
+		obj2=$(git hash-object -w in-2) &&
+		obj3=$(git hash-object -w in-3) &&
+
+		echo $obj2 >>in-2 &&
+		echo $obj3 >>in-3 &&
+
+		for i in $(test_seq 3)
+		do
+			git pack-objects .git/objects/pack/test-$i <in-$i \
+				|| return 1
+		done &&
+
+		rm -fr .git/objects/pack/pack-* &&
+		git multi-pack-index write &&
+
+		for i in $(test_seq 3)
+		do
+			for file in $(ls .git/objects/pack/test-$i*)
+			do
+				test-tool chmtime =+$((3600*$i-25000)) $file || return 1
+			done || return 1
+		done &&
+
+		pack1=$(ls .git/objects/pack/test-1-*.pack) &&
+		pack2=$(ls .git/objects/pack/test-2-*.pack) &&
+		pack3=$(ls .git/objects/pack/test-3-*.pack) &&
+
+		# Prevent test-1 from being rewritten.
+		touch "${pack1%.pack}.keep" &&
+
+		# This repack-expire loop should repack all non-kept packs
+		# into a new pack and then delete the old packs.
+		git multi-pack-index repack &&
+		git multi-pack-index expire &&
+
+		test_path_is_missing $pack3 &&
+		test_path_is_missing $pack2
+	)
+'
+
 test_expect_success 'load reverse index when missing .idx, .pack' '
 	git init repo &&
 	test_when_finished "rm -fr repo" &&
-- 
gitgitgadget

