Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CDEC38D686
	for <git@vger.kernel.org>; Fri, 11 Sep 2026 14:47:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789138054; cv=none; b=jz6NYEYuamWJLIUrvMnEatp/oQhCZLEvgm7bodTQFEgjpf5ZA9KrIetwcob/magVvYn9evJG8iF85FEGE9nMLaZ7edlZ3mhuGTU6VV3MSFygs3sDdwuXOKJln8bLnIqaY7yK6Aor83KWyEfllOJLR+PGPoi+UzRDqOdYJiVXwdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789138054; c=relaxed/simple;
	bh=1fvPf/9Iz4QRNLbohxu361A+gFT8Gf83DPJihifYoP0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HPfShD/7PAtYpORJVulSpIWZZ0eOAIyi/VKxFQzV5/l92iCzXhlQqHCrjohGdNGNecbTMQLxPK6pMnmCas+K0uEEVPLl9g6GejrpuujP4C1kiETWUrMSkSKlIyiArFvZBbCa4chtBAqE4Z7YeILMH4JLxyEes+sfwMUMHXdtI8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q3EKS+Cn; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q3EKS+Cn"
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-3990fe066ebso817633a91.1
        for <git@vger.kernel.org>; Fri, 11 Sep 2026 07:47:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789138051; x=1789742851; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=KeBx8LqHD1BjzMNzcUV8817n/nkNE42BbeOxlLDGVPY=;
        b=Q3EKS+CnZ5Y+EPzzFEW6N2T9Kh8yUitnCyED4H0q8iEWvU9GCe9Rn8I9vB8wRRrrrd
         iiRIkwIT5ppciEtEbzbmxS6ZYFtxJG5i0Yub4sJDXFXthq3YamufckjrOccsFMSYV8L5
         DikVQKAKyhkve1fVD71Qe0NSqIDpBY49ZH11ApJxOtpJ06OH0qdlI+OY7n0gKNtI2EmN
         QxRsuq6tNbGZXJButRbPV1T9dJqTRQuqRHUbWVfPYZsHZSQxCuFm6LKuGjQCR6Zq0oXc
         AVypigpmrymnXD++zoEu6dyR3rukf2X/9DcdF3jvkusezh3cPU4w2TtFAPZpZpYpUKbq
         k9/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789138051; x=1789742851;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=KeBx8LqHD1BjzMNzcUV8817n/nkNE42BbeOxlLDGVPY=;
        b=BtYrxxh4xysZuiD/IW7L6+9AKhg8fG6BWnaQgyS2+8UWobNTaKmw4psz15iOk5Er9Z
         1N3xC4ZChdemIAVuXlT2fSnwXKV4vin4R1baLnJj0AG76Y9kShzEJPN2yCtd+u4HIcqs
         elQ87fnaNnyKLDL341AHM5cb6dG+4bITreEUUp880v+QnfhxxvlWiNBtRmSpsTeii0On
         D3OUveoYcR2GKrkcdiMajN1aUsOpWTkgN2NSpvBDOLBLA2k/Gc/Pu2w3BynL3Sc4BbSZ
         K2scNiaF8zEbfvsR8qw6pQ+p37uD8Q2JdRC+gGTE449Aau64Ou/S/APlVb9zJU76dipD
         xCHA==
X-Gm-Message-State: AFuF++nYl8vG4Fhap6W8oK/w/Y673VROzSKnG1X4cKtYNDtSapd3dWTs
	T+QGvKTK3m1x/FTZwl7OAIaEzfREEyp6LodK2TtyYWLnuv3pe60S0QE8JE3TNel/
X-Gm-Gg: AYBFou3m+IXlzgjxrIsVWhhRRKy0Lz4zcPS6RP7hVYSNNwTBbTkgrWZumaILfYV/Bv5
	NFA06uHWm2nKfR8B3fBgO3X4CtD8l3kZc08jG1tUf9sTkEJ/XoqRz7+5k4/XNVZlYcCGMGitbZR
	VfdRxHuUhb6p23EpV/7TO9jFHQhgulYKX/yUA2JJEhD3peROl64lZWEOz+zKj40EePMjui0BHTJ
	yJXaReiSwmCP+djk+u/k7p7lIJcFAA9oJn5dTCTN5BHeOKta8AR93piOezaCFmOXdnXlOjRv+Vw
	hE28XjV6g1i/0UCqdkBcNIFAGhOu3ra8IH64LwdkCKLKRRdLxjN2E4qaoNtYgByu3E9H/3dGhep
	MiU9/VzHpPzPlUKTfJwENulkAqNXBbMhk2DXkAnMdX2YSaNKBHbYkOraLBNhUInM0nXamURKq4w
	jiCOQFZwJmS5UplSPAOmMVCaz2jKXPExYKk0MGyX9Ef2++iB4hFetHyoE5KlhSjfC0cu/Rmn0bY
	96vXO9LSeDigo/l2a5diKzrfne+bqBQCQoVGQ22rVD0vBZ3YCGsLobrJKoP2P4JnKkPohq4x6AV
	LqjqQw==
X-Received: by 2002:a17:90b:440c:b0:39b:57c6:e280 with SMTP id 98e67ed59e1d1-39d9bd65a3bmr7370383a91.7.1789138051413;
        Fri, 11 Sep 2026 07:47:31 -0700 (PDT)
Received: from jayatheerth ([2405:201:c005:b959:7d42:d207:de10:1218])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-14365b759d0sm7843335c88.7.2026.09.11.07.47.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Sep 2026 07:47:31 -0700 (PDT)
From: K Jayatheerth <jayatheerthkulkarni2005@gmail.com>
To: jayatheerthkulkarni2005@gmail.com
Cc: git@vger.kernel.org,
	jltobler@gmail.com,
	lucasseikioshiro@gmail.com,
	gitster@pobox.com
Subject: [GSoC Patch v6 4/7] repo: add path.index with absolute and relative suffixes
Date: Fri, 11 Sep 2026 20:15:16 +0530
Message-ID: <20260911144519.1011780-5-jayatheerthkulkarni2005@gmail.com>
X-Mailer: git-send-email 2.55.GIT
In-Reply-To: <20260911144519.1011780-1-jayatheerthkulkarni2005@gmail.com>
References: <20260716012138.6714-1-jayatheerthkulkarni2005@gmail.com>
 <20260911144519.1011780-1-jayatheerthkulkarni2005@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The repository index is a fundamental component used by Git and related
tooling to track the working tree state. Scripts that interact with the
index currently retrieve its location by invoking
`git rev-parse --git-path index`.

Introduce `path.index.absolute` and `path.index.relative` keys to
`git repo info`. This exposes the index file location as a scriptable
config-like key using standard format rules, allowing scripts to
retrieve it through the same interface as other repository path
information.

Mentored-by: Justin Tobler <jltobler@gmail.com>
Mentored-by: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
Signed-off-by: K Jayatheerth <jayatheerthkulkarni2005@gmail.com>
---
 Documentation/git-repo.adoc | 12 ++++++++++++
 builtin/repo.c              | 24 ++++++++++++++++++++++++
 t/t1900-repo-info.sh        | 23 +++++++++++++++++++++++
 3 files changed, 59 insertions(+)

diff --git a/Documentation/git-repo.adoc b/Documentation/git-repo.adoc
index 20836cf8f6..08ef47750c 100644
--- a/Documentation/git-repo.adoc
+++ b/Documentation/git-repo.adoc
@@ -128,6 +128,18 @@ values that they return:
 	The path to the repository's hooks directory relative to the current
 	working directory. Respects the `core.hooksPath` configuration.
 
+`path.index.absolute`::
+	The canonical absolute path to the repository's current index file.
+	Respects the `GIT_INDEX_FILE` environment override. Returns the
+	configured index path even if the repository is bare or the file does
+	not exist.
+
+`path.index.relative`::
+	The path to the repository's current index file relative to the current
+	working directory. Respects the `GIT_INDEX_FILE` environment override.
+	Returns the configured index path even if the repository is bare or the
+	file does not exist.
+
 `path.superproject-root.absolute`::
 	The canonical absolute path to the working tree root of the superproject
 	if the current repository is an initialized submodule. Outputs an empty
diff --git a/builtin/repo.c b/builtin/repo.c
index 01666dc17c..9f1858a127 100644
--- a/builtin/repo.c
+++ b/builtin/repo.c
@@ -142,6 +142,28 @@ static int get_path_hooks_relative(struct repository *repo, struct strbuf *buf)
 	return 0;
 }
 
+static int get_path_index_absolute(struct repository *repo, struct strbuf *buf)
+{
+	const char *index_file = repo_get_index_file(repo);
+
+	if (!index_file)
+		return error(_("unable to get index file"));
+
+	format_path(buf, index_file, "", PATH_FORMAT_CANONICAL);
+	return 0;
+}
+
+static int get_path_index_relative(struct repository *repo, struct strbuf *buf)
+{
+	const char *index_file = repo_get_index_file(repo);
+
+	if (!index_file)
+		return error(_("unable to get index file"));
+
+	format_path(buf, index_file, repo->prefix, PATH_FORMAT_RELATIVE);
+	return 0;
+}
+
 static int get_path_superproject_absolute(struct repository *repo, struct strbuf *buf)
 {
 	struct strbuf superproject = STRBUF_INIT;
@@ -210,6 +232,8 @@ static const struct repo_info_field repo_info_field[] = {
 	{ "path.gitdir.relative", get_path_gitdir_relative },
 	{ "path.hooks.absolute", get_path_hooks_absolute },
 	{ "path.hooks.relative", get_path_hooks_relative },
+	{ "path.index.absolute", get_path_index_absolute },
+	{ "path.index.relative", get_path_index_relative },
 	{ "path.superproject-root.absolute", get_path_superproject_absolute },
 	{ "path.superproject-root.relative", get_path_superproject_relative },
 	{ "path.toplevel.absolute", get_path_toplevel_absolute },
diff --git a/t/t1900-repo-info.sh b/t/t1900-repo-info.sh
index 2e7b3867bd..80e025e040 100755
--- a/t/t1900-repo-info.sh
+++ b/t/t1900-repo-info.sh
@@ -237,6 +237,29 @@ then
 		'git config core.hooksPath /dev/null'
 fi
 
+test_repo_info_path 'index standard' 'index' '.git/index'
+
+test_repo_info_path 'index with GIT_INDEX_FILE override' 'index' \
+	'custom-index-file' \
+	'GIT_INDEX_FILE="$ROOT/custom-index-file" && export GIT_INDEX_FILE'
+
+test_expect_success 'path.index in a bare repository returns default index location' '
+	test_when_finished "rm -rf bare.git" &&
+	git init --bare bare.git &&
+	(
+		cd bare.git &&
+		ROOT="$(test-tool path-utils real_path .)" &&
+
+		echo "path.index.absolute=$ROOT/index" >expect.abs &&
+		git repo info path.index.absolute >actual.abs &&
+		test_cmp expect.abs actual.abs &&
+
+		echo "path.index.relative=index" >expect.rel &&
+		git repo info path.index.relative >actual.rel &&
+		test_cmp expect.rel actual.rel
+	)
+'
+
 test_expect_success 'path.superproject-root absolute and relative' '
 	test_when_finished "rm -rf sub super" &&
 	git init sub &&
-- 
2.55.GIT

