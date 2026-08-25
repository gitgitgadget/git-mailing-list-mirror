Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C88C831E835
	for <git@vger.kernel.org>; Tue, 25 Aug 2026 18:00:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787680810; cv=none; b=TPo6vS9YNqRhJwffj+twaWzejsYoPynHCyLzYu3artd1+PL4qvmgqAn9hrJZEgM6CK6bbX8ARny9HgRidcRi8E7rqiUP5iJ2T9fQA7V25Sk6aWeHyBGuTDcx9vORNsa655WagD0U/bIF78DeJdHFT4ezz/6DsSvOBeHwq3ivS/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787680810; c=relaxed/simple;
	bh=yV7l20l9/dnYNIl1a/0RtkF4cUYJr7YIQ2AzGJJ07PM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hlZIJpCt/sLAROQf06n41CNbuaKMfR+RWaxnVcetQx9wR1cayDBRChMokB/vccX2MvBhGlR1bz807FrcTIe9CsV69XlIKOeYRmlonOv2eaHo75DNbMkGPu8VKJmy1D9L3AeuvGOC1oCVcsPQu/GxKbPyZ9eE6/FgrTFfJNyC7uQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Rc6vA1UG; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rc6vA1UG"
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-384930ca5e2so165158a91.3
        for <git@vger.kernel.org>; Tue, 25 Aug 2026 11:00:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787680808; x=1788285608; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=vvhrmKIjkQsYbygUFpk95u1jBXKNzz7+Fi8NIVbg1yQ=;
        b=Rc6vA1UGfAfltxSe92jVN7LrN9+TS4v4ZlOeaJ9QR9tRNND6ikN50/VbfmIW9MEmLB
         9UaT0Bz5AfkstdYcV9HUd4sBWynQM/PRaBXgcQrPSernjJpm6wmILqUxMliG4vpbGx8n
         HEYOaTG9kziE1KmWHyVEXRfqouDwSKXuQdfz/hjYgyVqyqhSCSczu1LvrOwlbygC8lCU
         u8d7Agoh+m5cURcWDb7/hkjwrvaDny7Lx5yhwJtpqRdFr86C/kxozbQEpByYiv5BHmF0
         wCcspd8jvAmNMzweP+6W5POkGoLDdOo+s2H6pmPQ7CjamBK1gsjxfh2CyqALal9rXdqw
         RoBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787680808; x=1788285608;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=vvhrmKIjkQsYbygUFpk95u1jBXKNzz7+Fi8NIVbg1yQ=;
        b=ky6G8wv4uH004jrda7zjw8q0Ydxdv2EPT7EfEbl7QLaQHWpdizeDTScqc1Rwrpo7ZP
         oBbIJzttgMIp9eALf6Ab0HRkdbsfkHAgkiQvAP1JipoH42HMXKImfaPYS0dr4mFKR5Lh
         9wqzlDQ3aJ3Ij9YYqX2mr25d+vhJ2mLZBCvFlFsfD3joMsnZ+T8u3Owryt0W0j70FHAs
         jWLWnf2Zoq3wln3c7+6dsEM/3K1rvPBFyW6M/VX8LWeQDJlZa95PZIRfp6o4/if7f29x
         0DF7RIY4sGjXCmUHE2yPNPZ8w7z4RI4iVrXPBLJyY/Ij0B2PRt1dUEh6fuCSufhfLTbX
         u47g==
X-Gm-Message-State: AFuF++nKOotxaU9nAFRFbYu/pnCOzkdMqD1dyuzHpIgMpaElKrOtMPtT
	r2ljMDpjFljvCueA0zwOIXXSGkrnGURMwedu39k1b5PHfqNeYZ6hYzNk
X-Gm-Gg: AR+sD11QqepPwLciavpGiLG1jOPDqk1pM+DZ8DDN9+p+ozqU8lzJ/ANK0z5Wgw/9Sft
	4ErUYH7vmj3BMRTQ96ilKDnYdnxawp26yQTKAcFXZIDyUKEIBxJR3JOFTbHNpgpXIzg0wRtwT12
	IEi79uxQknjbo/hEERIdi1GiTykijAXGx58jDaSr2r9OjW6nL/A9ak5/07aCs1V0lErqiGvIWBX
	wG3Bk6UdAi/ZXoM8OrfIL9nH9godeoF4luOJEaSvuJwzbaI6cNXwIP1u+bd8HH9+hms8t2tdJ7m
	lMSwYgOYjYF5fWuV9fR/Grjt2oERXuTZqWrWr5r4V3D+wHkp+5oGfifiLWylGCMB+nB3UlUx00i
	oDk7nb0RoZGHjuTiLdNEs07xKKKSl+ZgjUXR8VUlOtNFS4pY1YSHGp2lnwX6dBXH3htQfofBU1A
	ciVKnoXOQLN1TzaM6eoVnUr6mxZ66mrMzhwhbIBfGi+FPkexDaHxtEKjglbjXvVzDnJglri+icC
	auVFWWHl+1ROGnIidhAoBuAOzGmnFFm7nsgiJBMsJ6SRwVeP8oYCMow1rHYuQtXJGjyz3Y=
X-Received: by 2002:a17:90b:448c:b0:38f:5801:dc0e with SMTP id 98e67ed59e1d1-3966d8a71b5mr1595589a91.15.1787680807968;
        Tue, 25 Aug 2026 11:00:07 -0700 (PDT)
Received: from jayatheerth ([2405:201:c005:b959:7d42:d207:de10:1218])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-141a8e118fasm954417c88.0.2026.08.25.11.00.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Aug 2026 11:00:07 -0700 (PDT)
From: K Jayatheerth <jayatheerthkulkarni2005@gmail.com>
To: jayatheerthkulkarni2005@gmail.com
Cc: git@vger.kernel.org,
	jltobler@gmail.com,
	lucasseikioshiro@gmail.com,
	gitster@pobox.com
Subject: [GSoC Patch v5 6/7] repo: add path.git-prefix
Date: Tue, 25 Aug 2026 23:28:17 +0530
Message-ID: <20260825175818.645579-7-jayatheerthkulkarni2005@gmail.com>
X-Mailer: git-send-email 2.55.GIT
In-Reply-To: <20260825175818.645579-1-jayatheerthkulkarni2005@gmail.com>
References: <20260716012138.6714-1-jayatheerthkulkarni2005@gmail.com>
 <20260825175818.645579-1-jayatheerthkulkarni2005@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Scripts sometimes need the path from the repository's working tree root
to the current working directory. While this information can be derived
through existing Git commands, `git repo info` does not currently expose
it as a scriptable key.

Introduce the `path.git-prefix` key to `git repo info`. The key returns
the path from the working tree root to the current working directory,
returning the empty string when invoked from the working tree root.

Mentored-by: Justin Tobler <jltobler@gmail.com>
Mentored-by: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
Signed-off-by: K Jayatheerth <jayatheerthkulkarni2005@gmail.com>
---
 Documentation/git-repo.adoc |  5 +++++
 builtin/repo.c              | 11 +++++++++++
 t/t1900-repo-info.sh        | 23 +++++++++++++++++++++++
 3 files changed, 39 insertions(+)

diff --git a/Documentation/git-repo.adoc b/Documentation/git-repo.adoc
index 868ab0ed9f..fb5aceae8f 100644
--- a/Documentation/git-repo.adoc
+++ b/Documentation/git-repo.adoc
@@ -113,6 +113,11 @@ values that they return:
 	The path to the Git repository's common directory relative to
 	the current working directory.
 
+`path.git-prefix`::
+	The path from the root of the working tree to the current working
+	directory. Returns the empty string when the current working directory
+	is the root of the working tree.
+
 `path.gitdir.absolute`::
 	The canonical absolute path to the Git repository directory (the `.git` directory).
 
diff --git a/builtin/repo.c b/builtin/repo.c
index 779240109d..c0f99b6869 100644
--- a/builtin/repo.c
+++ b/builtin/repo.c
@@ -100,6 +100,16 @@ static int get_path_commondir_relative(struct repository *repo, struct strbuf *b
 	return 0;
 }
 
+static int get_path_git_prefix(struct repository *repo, struct strbuf *buf)
+{
+	/*
+	 * repo->prefix is NULL when the current working directory is
+	 * the worktree root.
+	 */
+	strbuf_addstr(buf, repo->prefix ? repo->prefix : "");
+	return 0;
+}
+
 static int get_path_gitdir_absolute(struct repository *repo, struct strbuf *buf)
 {
 	const char *git_dir = repo_get_git_dir(repo);
@@ -250,6 +260,7 @@ static const struct repo_info_field repo_info_field[] = {
 	{ "object.format", get_object_format },
 	{ "path.commondir.absolute", get_path_commondir_absolute },
 	{ "path.commondir.relative", get_path_commondir_relative },
+	{ "path.git-prefix", get_path_git_prefix },
 	{ "path.gitdir.absolute", get_path_gitdir_absolute },
 	{ "path.gitdir.relative", get_path_gitdir_relative },
 	{ "path.grafts.absolute", get_path_grafts_absolute },
diff --git a/t/t1900-repo-info.sh b/t/t1900-repo-info.sh
index adc4a92487..b689445b7a 100755
--- a/t/t1900-repo-info.sh
+++ b/t/t1900-repo-info.sh
@@ -215,6 +215,29 @@ test_repo_info_path 'commondir with only GIT_DIR' 'commondir' \
 	'.git' \
 	'GIT_DIR="../.git" && export GIT_DIR'
 
+test_expect_success 'path.git-prefix at repository root' '
+	test_when_finished "rm -rf repo" &&
+	git init repo &&
+	(
+		cd repo &&
+		echo "path.git-prefix=" >expect &&
+		git repo info path.git-prefix >actual &&
+		test_cmp expect actual
+	)
+'
+
+test_expect_success 'path.git-prefix in subdirectory' '
+	test_when_finished "rm -rf repo" &&
+	git init repo &&
+	mkdir -p repo/sub/dir &&
+	(
+		cd repo/sub/dir &&
+		echo "path.git-prefix=sub/dir/" >expect &&
+		git repo info path.git-prefix >actual &&
+		test_cmp expect actual
+	)
+'
+
 test_repo_info_path 'gitdir standard' 'gitdir' '.git'
 
 test_repo_info_path 'gitdir with explicit GIT_DIR' 'gitdir' \
-- 
2.55.GIT

