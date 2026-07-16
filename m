Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 162451A6824
	for <git@vger.kernel.org>; Thu, 16 Jul 2026 01:26:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784165176; cv=none; b=PJCc8GYzZmcc7udbRb0CdmmQRdRUZKuymBLR5NSG/Ei/kF6riG+2LQ4GjsPByUn+zF6jgOSjtffANsK8QXV42pMA+Hv7U5tHbS1qbgjuDQeC1EVkC6HfRwh9RvhWwZDB7dpE1DxrkHuNIxm0az7M6/Xxlk9GNt3IVjfzzH+Kfh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784165176; c=relaxed/simple;
	bh=I7vO3Ne4kXN2XZOxsLCBS6MHBpCnE6+8Vx9im4BNZTY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZM/wbG0gCQ61pJvwABwyyKg4j9s7lLKtiSscP9P3t4ybmdMOqmDi3xlgo6YIZjX8HmtxOOG+nfkJxTDriBJiRHaueZekrds0hyslnxSpgcdh0XKdjTZMXQcNRGpikTAi6z4abq+Fsqh0JVo/kXIja/A2vEjSxSP78XjbTbG/BIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qBS2T92Z; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qBS2T92Z"
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-38511175ad3so5070021a91.2
        for <git@vger.kernel.org>; Wed, 15 Jul 2026 18:26:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784165174; x=1784769974; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+wbpnJXzmU6wneD1pJdG0DAs5Db0sojcNnK2txEQsCc=;
        b=qBS2T92ZODkmA/Ms9NzUv63IMooqU5IYW6T4n1Pq1f9MdTMMNtVCMi2DuaRswJT5kJ
         k4aBdIZjD6P1jXYDCIb9wf9UWHZD/a/Cslj7qEoNR9KILcp/WYyMq6WfewMVLId+2N+g
         6KJYJccJsGJCkReygH2GI8GznJj1SUN6UNZlYwSdf44HMNE3XK/1nNXrb/4capHq53mV
         NXLUXLNQXGg/W/+eqa0g1Iy4ZQ5wNJqgN5VeMTAtrWZn8Oc7ucIUreAtPsl0yiDPEcik
         Vg7WZ2Hzingu4vV5HtZbjXthmT0q+ENQBBrwTJR7KJ8Wkl5bxx8HS0GLDT3Zr1BF8cHU
         pKTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784165174; x=1784769974;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=+wbpnJXzmU6wneD1pJdG0DAs5Db0sojcNnK2txEQsCc=;
        b=Dxb69rQ0p+wVX8up+P+UDeVMNHt9mE4NdV7mCZMHv1wdLwuRWhyqxwviX68OXHiFvE
         dQSO8PKzUkL9D7ymWtV45vbKnPpLfS0qzcoz3er4i1Uv4URSByB7wjy8g6XIKEskxkHe
         xu9p/jqJmA6m996FBiFE9rJyVHeMioHzJyqnhiV9ymgfstti4+thb4cIJ4JBQU0gMJxR
         zGNqIuNz03GY9J6j4cVccRiwGT8G8haOqunUNqCJEq7ZKvdSzSyaBB0pBQsuggFsa74K
         Ypa6K1rXlLD0jHiHuOPce9COFXJYXGYNGnWINHCSK64M1j9+nI7hRhRxoL7RVg4EZ//H
         cVqw==
X-Gm-Message-State: AOJu0Yy+qinuXKplBJ2lvdoAXbb2ThSYcPGbPHY04pVkkfuAxdP/lhey
	b8cF+jtSDuB79sL/k23XlI1vqFIT2Wwsem/Qx1EFcda71I/lfWltDrLUyVPoTQ==
X-Gm-Gg: AfdE7cnavdaOd6uVocnUmXjThrqi5W5wfHFzqdKBwBud8bmpJDTjzcss98PJpaGn97I
	kZChVn1M5D0dATLNYAiEdd8sVxaRa7k7L6pMUwyjvElaiaL6w4rF7MSefKWSHnW3soQG0BEbdUm
	1ipJJ3OvnQCDkDBE2gXlPrWh9wgLWXI2vo+ojqHsUnUrYrswYYa73B6G5jx5VUBO8ObUWl9VslX
	DuOGURwUTTqdhl6WvIzZ2uQpZe2gBJTlBuWWb3U82PARUGL8mBEr2fHLh2hVtShncJgD8+s09On
	00ikXEWMZEIHmGpXF3Cxn/BlAswn/us60i8+zSXKwyrm+m3l/1pRUrxLsdyWN6lfxJh8QasHVZ2
	/FiDXDbSKsLJgl4QXp0kBcne80BuTkifwqiOEWoKYYCVNDauqg8U7uCn8jKyP2PS+7cpuEQU1oe
	u8hmRohkA/IWXpidK+s7rlhzU/esI21UrgiKmiAmrTX77uzM921SHMrySORuE6bG3Sv6MEn1YCT
	VBSdOTL88Ft
X-Received: by 2002:a17:90a:f947:b0:38d:ecfe:41aa with SMTP id 98e67ed59e1d1-38e1b015ed4mr6997802a91.43.1784165174371;
        Wed, 15 Jul 2026 18:26:14 -0700 (PDT)
Received: from jayatheerth ([2405:201:c005:b959:7d42:d207:de10:1218])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3140e6e9edfsm5377490eec.28.2026.07.15.18.26.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jul 2026 18:26:13 -0700 (PDT)
From: K Jayatheerth <jayatheerthkulkarni2005@gmail.com>
To: git@vger.kernel.org
Cc: jltobler@gmail.com,
	lucasseikioshiro@gmail.com,
	K Jayatheerth <jayatheerthkulkarni2005@gmail.com>
Subject: [GSoC Patch 7/7] repo: add path.git-prefix path key validation
Date: Thu, 16 Jul 2026 06:51:38 +0530
Message-ID: <20260716012138.6714-8-jayatheerthkulkarni2005@gmail.com>
X-Mailer: git-send-email 2.55.GIT
In-Reply-To: <20260716012138.6714-1-jayatheerthkulkarni2005@gmail.com>
References: <20260716012138.6714-1-jayatheerthkulkarni2005@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Scripts and command-line prompt integrations frequently need to know their
relative depth inside a repository working tree layout. Currently, this
is retrieved using `git rev-parse --show-prefix`.

Introduce the `path.git-prefix` key to `git repo info`. This mirrors the
prefix location tracking framework as a standalone key, returning the
exact relative path offset complete with a trailing slash, or an empty
string if run directly at the repository working tree root.

Mentored-by: Justin Tobler <jltobler@gmail.com>
Mentored-by: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
Signed-off-by: K Jayatheerth <jayatheerthkulkarni2005@gmail.com>
---
 Documentation/git-repo.adoc |  5 +++++
 builtin/repo.c              | 12 ++++++++++++
 t/t1900-repo-info.sh        | 19 +++++++++++++++++++
 3 files changed, 36 insertions(+)

diff --git a/Documentation/git-repo.adoc b/Documentation/git-repo.adoc
index 6c962620ec..5ba2ab1612 100644
--- a/Documentation/git-repo.adoc
+++ b/Documentation/git-repo.adoc
@@ -113,6 +113,11 @@ values that they return:
 	The path to the Git repository's common directory relative to
 	the current working directory.
 
+`path.git-prefix`::
+	The relative path from the top-level directory of the working tree to
+	the current working directory (including a trailing slash). Outputs an
+	empty string if executed at the root of the working tree.
+
 `path.gitdir.absolute`::
 	The canonical absolute path to the Git repository directory (the `.git` directory).
 
diff --git a/builtin/repo.c b/builtin/repo.c
index a97ad71649..00d5064281 100644
--- a/builtin/repo.c
+++ b/builtin/repo.c
@@ -1,3 +1,4 @@
+#include "compat/posix.h"
 #define USE_THE_REPOSITORY_VARIABLE
 
 #include "builtin.h"
@@ -100,6 +101,16 @@ static int get_path_commondir_relative(struct repository *repo, struct strbuf *b
 	return 0;
 }
 
+static int get_path_git_prefix(struct repository *repo UNUSED, struct strbuf *buf)
+{
+	/*
+	 * startup_info->prefix is NULL if we are at the working tree root.
+	 * We add an empty string to ensure the buffer is cleanly initialized.
+	 */
+	strbuf_addstr(buf, startup_info->prefix ? startup_info->prefix : "");
+	return 0;
+}
+
 static int get_path_gitdir_absolute(struct repository *repo, struct strbuf *buf)
 {
 	const char *git_dir = repo_get_git_dir(repo);
@@ -278,6 +289,7 @@ static const struct repo_info_field repo_info_field[] = {
 	{ "object.format", get_object_format },
 	{ "path.commondir.absolute", get_path_commondir_absolute },
 	{ "path.commondir.relative", get_path_commondir_relative },
+	{ "path.git-prefix", get_path_git_prefix },
 	{ "path.gitdir.absolute", get_path_gitdir_absolute },
 	{ "path.gitdir.relative", get_path_gitdir_relative },
 	{ "path.grafts.absolute", get_path_grafts_absolute },
diff --git a/t/t1900-repo-info.sh b/t/t1900-repo-info.sh
index 6c47989df7..3e5e42f6d3 100755
--- a/t/t1900-repo-info.sh
+++ b/t/t1900-repo-info.sh
@@ -207,6 +207,25 @@ test_repo_info_path 'commondir with only GIT_DIR' 'commondir' \
 	'.git' \
 	'GIT_DIR="../.git" && export GIT_DIR'
 
+test_expect_success 'path.git-prefix at root and in a subdirectory' '
+	test_when_finished "rm -rf repo" &&
+	git init repo &&
+	(
+		cd repo &&
+
+		echo "path.git-prefix=" >expect.root &&
+		git repo info path.git-prefix >actual.root &&
+		test_cmp expect.root actual.root &&
+
+		mkdir -p sub/dir &&
+		cd sub/dir &&
+
+		echo "path.git-prefix=sub/dir/" >expect.sub &&
+		git repo info path.git-prefix >actual.sub &&
+		test_cmp expect.sub actual.sub
+	)
+'
+
 test_repo_info_path 'gitdir standard' 'gitdir' '.git'
 
 test_repo_info_path 'gitdir with explicit GIT_DIR' 'gitdir' \
-- 
2.55.GIT

