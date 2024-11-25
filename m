Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 025C441C92
	for <git@vger.kernel.org>; Mon, 25 Nov 2024 17:58:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732557525; cv=none; b=ERvaHVC8dbgQBrfh3qvi2edH+cLo2nG9ioxXdLZnIXpItfWtXt+gb2ySSsJH7q4AqJxQu8rz8DAcNo+Fq/G5DnrJYslyzYMdV/xcrjfc5D1zD8LxC7AGl5dNfXujs72MwIp76t1gMY17CMhdUAZ0X1Q8wRgudnBONnUyUt6gYRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732557525; c=relaxed/simple;
	bh=8RvXtbMqI3vqZ0+AAh68RgWc7LjIQmwmzSfOTH4ZpyA=;
	h=Message-Id:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=q9qZ7GGQWE9oZwvCqBo2ltAfw16DJRcc7MDOEZtB0xXFCJfqTAZVOoCY1+hdRW5tl3udp0ylygYxUK1bs9qoR8XgHls0IGu0yff3WQHTotiHXNCVLkoSAaLF/yvUG+8EANlI1M+bz28PUzmxI/n8AQN6BGi75rxW7BQOH+Zwg14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ONbPy0U3; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ONbPy0U3"
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-aa53ebdf3caso290477466b.2
        for <git@vger.kernel.org>; Mon, 25 Nov 2024 09:58:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732557522; x=1733162322; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=sMUN+eShpzNLHZSMq9uCXEcJrewESrUmgVpYlwb45Kg=;
        b=ONbPy0U3FNov/aYg7+qd+ilD4CumnMGiT8vRIfITyHFCleQ75V40TMg/rc3e8wXXeA
         1QYyakE2qOrZ45awk5kq6eAstrjEpJGN+Hl9xSowpP7vefSu/3l2cu8pjtzEddqcqwR2
         UOujdUNmzhU7xcvzTC9CtdK6eT0r9yGJllMr1ZG1pWUYlK4+G/wb96j34z3dtZMIWdRA
         drHH3sAnd5e3CfS/CKlTv1V/UaV8Y+93ggiAjAuySqNiTL9TetTq14vIM5UD6aT+ZVxo
         5Gl1gfKqY2nX9YunI+OdA/sKcm7tc2wFQbhtKYZo3PO5rdElE7zU7gOnCwLwp6XlXK8G
         6CzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732557522; x=1733162322;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sMUN+eShpzNLHZSMq9uCXEcJrewESrUmgVpYlwb45Kg=;
        b=jWdK8pkPZ8txPAitjx32ZUqfdbfL1rsZCEgolX8VKyXeXJRJd31hF6sziqxZSXSpEy
         8GSgstTdT25gQbeILXGCgvHiv6xw+VgM+kJuNWyLleQ26U9Mxr1GR3/kabJQdqtVrNlS
         ZxRXi2QK7p2ZAgNTI/J4tIrBkYSFo8D3wg3a+qgqex7rG9qWEH2RoTj1NZY9d2i0HOL/
         MvkFQNlsTpiruLQD1GN3Hl3Vsd7m8Hr9Bglw9oP4WlGW7Ek7AeCreUjg/m4ZpG4MskCL
         9JEgezzB2OnR1lRiBstpNFdRWP6xPgXOi0NebNCdEEe4ahBe1tM0kr4yxMBKqDsusHyk
         c3uw==
X-Gm-Message-State: AOJu0YxQIckfi+JWw+F/Ud8ifNUxGJZghIXFaV3cnKNWK5VYkYBXws4c
	NcDa6WTi9sscCuX7LcyKInIWeAZjVzMFzqsEJxiagXXPcnUhCrN0Bl89KQ==
X-Gm-Gg: ASbGncs8qwNH0RMIB/NS3J6gu6MFvNx5aMKuQIJ8B+q59p4oMR+K/l3T/WBbImSRtoz
	BYlg+zwuA6XemBQM/ifTBLrfyDKFZ0smVfi0tczR1vaojq8jKhaEUajs2QnC16ni4ntee1Ropsv
	ayCSE7iVVv1zce3iGrLcZoT1LfMh7FIuxY06/SZD1LkRXM8LyuULv994FJxgPXI5k2ZAps9nf2D
	SkktscXc1h5pZnGc2QASEnH8nVGHyU0Txd4fHPqN78S7+nasek=
X-Google-Smtp-Source: AGHT+IF+dq3jROGbbrqqQJ7u7eKLFaGo+ArMtllzmyPpuX2VW1jxboEGDgFK6k3TtNvVYCklmtkRyg==
X-Received: by 2002:a17:907:77c5:b0:aa5:11fa:626d with SMTP id a640c23a62f3a-aa511fa6426mr959094166b.3.1732557521595;
        Mon, 25 Nov 2024 09:58:41 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa50b2f0ebfsm491123666b.52.2024.11.25.09.58.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Nov 2024 09:58:41 -0800 (PST)
Message-Id: <pull.1831.git.1732557520428.gitgitgadget@gmail.com>
From: "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 25 Nov 2024 17:58:40 +0000
Subject: [PATCH] fast-import: disallow "." and ".." path components
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
Cc: Elijah Newren <newren@gmail.com>,
    Elijah Newren <newren@gmail.com>

From: Elijah Newren <newren@gmail.com>

If a user specified e.g.
   M 100644 :1 ../some-file
then fast-import previously would happily create a git history where
there is a tree in the top-level directory named "..", and with a file
inside that directory named "some-file".  The top-level ".." directory
causes problems.  While git checkout will die with errors and fsck will
report hasDotdot problems, the user is going to have problems trying to
remove the problematic file.  Simply avoid creating this bad history in
the first place.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
    fast-import: disallow "." and ".." path components

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1831%2Fnewren%2Fdisallow-dotdot-fast-import-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1831/newren/disallow-dotdot-fast-import-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1831

 builtin/fast-import.c  |  3 +++
 t/t9300-fast-import.sh | 20 ++++++++++++++++++++
 2 files changed, 23 insertions(+)

diff --git a/builtin/fast-import.c b/builtin/fast-import.c
index 76d5c20f141..e0e0ca3657a 100644
--- a/builtin/fast-import.c
+++ b/builtin/fast-import.c
@@ -1466,6 +1466,9 @@ static int tree_content_set(
 		root->tree = t = grow_tree_content(t, t->entry_count);
 	e = new_tree_entry();
 	e->name = to_atom(p, n);
+	if (!strcmp(e->name->str_dat, ".") || !strcmp(e->name->str_dat, "..")) {
+		die("path %s contains invalid component", p);
+	}
 	e->versions[0].mode = 0;
 	oidclr(&e->versions[0].oid, the_repository->hash_algo);
 	t->entries[t->entry_count++] = e;
diff --git a/t/t9300-fast-import.sh b/t/t9300-fast-import.sh
index 6224f54d4d2..caf3dc003a0 100755
--- a/t/t9300-fast-import.sh
+++ b/t/t9300-fast-import.sh
@@ -522,6 +522,26 @@ test_expect_success 'B: fail on invalid committer (5)' '
 	test_must_fail git fast-import <input
 '
 
+test_expect_success 'B: fail on invalid file path' '
+	cat >input <<-INPUT_END &&
+	blob
+	mark :1
+	data <<EOF
+	File contents
+	EOF
+
+	commit refs/heads/badpath
+	committer Name <email> $GIT_COMMITTER_DATE
+	data <<COMMIT
+	Commit Message
+	COMMIT
+	M 100644 :1 ../invalid-path
+	INPUT_END
+
+	test_when_finished "git update-ref -d refs/heads/badpath" &&
+	test_must_fail git fast-import <input
+'
+
 ###
 ### series C
 ###

base-commit: 04eaff62f286226f501dd21f069e0e257aee11a6
-- 
gitgitgadget
