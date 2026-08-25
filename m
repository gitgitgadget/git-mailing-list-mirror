Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FEB948C8D9
	for <git@vger.kernel.org>; Tue, 25 Aug 2026 17:59:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787680759; cv=none; b=BFwM/7mjq0EQBkn4D2snOkwv32vwcxXS2uASP5nUeDbMr2fGUesGdJqK+bd00Pvh7lYiCOJ/nXZZdj6Ao/FjYpsMyt4FfDU6SM+KNL3W9l0bUWyhSXqHyR0fK+naNDph9n7jIBEs0MRu7AtGXwaqC3G6fHyrTLZiIe8qWOCNvCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787680759; c=relaxed/simple;
	bh=fe7+oKPtpBQ/vCfnOroilLNTMOY+si7QCnmfJ0W5FQQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KWgPvP6q65wrXYCgowbMeGmULtNUENI6cRauiKR0AbNjnyvSuFLFaY1QFPEEWY2EwB1N94jZf6FZyuJWLH2Q+mWJFHwi5DP0g0FfE2P0UzUX3x30DCEWQmIyAWV/LeOdEwEgLzEeXpk8+AIA1x4oxfixCoWpFdlna8M3dpD4WFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e6ZBj9M+; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e6ZBj9M+"
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-39266382df6so142797a91.3
        for <git@vger.kernel.org>; Tue, 25 Aug 2026 10:59:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787680757; x=1788285557; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Ku4QfXZxvsi5Mw/JwJW1bggO/MqZJQzRT8QMxmkn9i4=;
        b=e6ZBj9M+ZLDbflEPjqD1E9B8oETv643XMIrpl3rsGVQOnlZrYueFVuNnSLjPZxqRzL
         6PhLPy3Y3Dg6k5kFQcJWfIzzNMi8S4nddcv8t/UWag9zVCbw3WG5xO9JvgpwSma3SsTz
         dMZiX9WE2Pdnna7M89o1Cn5liStNwjK9gc+iNSXj5/IzPnslJYdmnASJNuRSwb4MVgEf
         RwZy67hvlKkIYxDFHo0WUktrzrcRaSYq/SxTB+iMHSRLifnuOsjflU9hrFH7O/qz+osf
         S5bXtNDURJBExbs29HP5dKi7t5txC9hqNaKauFRrU31h6ynkhmDLraiWgimPpzwj13tw
         yRWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787680757; x=1788285557;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Ku4QfXZxvsi5Mw/JwJW1bggO/MqZJQzRT8QMxmkn9i4=;
        b=Lj1kNKYIomr938MRtxTLFALo5SPD+txf2rSIVinz1Z3btvnoDCZYPEjDOIGp6JiIz5
         JG5YI0hFneNWhi8jALhP1EYyR+/6CdKxrlDSmOTTJLfJOj7djwyXwyOqrm9NknpqMmQy
         nppPohreC3jZhElfm4bLe1D5d/5lvpoxUhfsNMLix5pSBr71Z+w42pSiiyMWf5B0le/A
         SfqnsZUc4B5T/v9XcoNglNbPv8uzOHH1SCbhdQsBUfStWeITSHHdagLP9LR7gHaVRYBP
         +sycWY1/SCoaH2MTPxRF1PEzko2+Q1Grf1SbRDhVRSZvHXMhKsKxTeHYEiaEGyeB0xkg
         fqoQ==
X-Gm-Message-State: AFuF++n4XKGd4INXm9N5eODW12aTjEAUvSWdnL/uySnrDcShhUbX0h+j
	2fnZHB2Z8v1Ek5mQMfBSGlZLlD6fPtnZZrz8weyY1DkQMQ55s/gftOga
X-Gm-Gg: AR+sD105j/BCNBiafuLhwHhNAp+Gy8TbNMClcpp4VCZHPPkLFQbtDuEGX+ZTu7NE1Ah
	Zs2pH+hkcCtw+7mJs2E4Rl1BDhfr+zTIOjD4HkLnVv/Kdxj36jICCJ+ZgKLHU+VFDu36v8XOvda
	3yCd59NqilN1owzZbXJ+a4l1HD6JLJwFvSyyTUUht+aBfXSUzA85xFHiMjy8Pij0aXQJjYA9Vv9
	YugSKv15zWSOu1s1V2Rc5+G4novAS4Lk3AmlbBzVHyauC2fvzySygSlL06iw7sBmRCNNQZnbXSR
	jbDEOADPDKiMYoF1Z6jIpC3lqBE+wc/GkeFjIVlwpZ2fT7pOGG9jBCOMtNuSVr5WLoQclV3cAtO
	M4GNBbQsns9kPSbA1a4zFzGny24HvG2UjZdlqnlmhP3SZmC+p5TSr9wSKJ+DkAe3GSXHyusq79x
	MfT5StiMK/gYULVm+0Vtfq+9O0Jf1F4HBq7QuZTLjA/fG+yN9OCHLqQd9NeSHle7l/JUThO2kN0
	6L7RJnGVk4VvJ8wC+zPydorm5R99/uiOyFpZo0OXKRZwLprKtaAVjDlzIv3BQREWOlh3dI=
X-Received: by 2002:a17:90b:1845:b0:395:4e0d:bc60 with SMTP id 98e67ed59e1d1-3966d85dd8dmr1724474a91.9.1787680757264;
        Tue, 25 Aug 2026 10:59:17 -0700 (PDT)
Received: from jayatheerth ([2405:201:c005:b959:7d42:d207:de10:1218])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-141a8e118fasm954417c88.0.2026.08.25.10.59.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Aug 2026 10:59:16 -0700 (PDT)
From: K Jayatheerth <jayatheerthkulkarni2005@gmail.com>
To: jayatheerthkulkarni2005@gmail.com
Cc: git@vger.kernel.org,
	jltobler@gmail.com,
	lucasseikioshiro@gmail.com,
	gitster@pobox.com
Subject: [GSoC Patch v5 1/7] repo: add path.toplevel with absolute and relative suffix formatting
Date: Tue, 25 Aug 2026 23:28:12 +0530
Message-ID: <20260825175818.645579-2-jayatheerthkulkarni2005@gmail.com>
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

Scripts frequently need to find the root directory of a repository's
working tree. Currently, this requires using `git rev-parse --show-toplevel`
or inferring it from other repository information.

Introduce `path.toplevel.absolute` and `path.toplevel.relative` keys
to `git repo info`. This allows scripts to retrieve the top-level
working tree path in a predictable, strictly formatted manner without
relying on `rev-parse`.

If requested in a bare repository where no working tree exists, the
command returns an empty string.

Mentored-by: Justin Tobler <jltobler@gmail.com>
Mentored-by: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
Signed-off-by: K Jayatheerth <jayatheerthkulkarni2005@gmail.com>
---
 Documentation/git-repo.adoc | 10 ++++++++++
 builtin/repo.c              | 24 ++++++++++++++++++++++++
 t/t1900-repo-info.sh        | 35 +++++++++++++++++++++++++++++++++++
 3 files changed, 69 insertions(+)

diff --git a/Documentation/git-repo.adoc b/Documentation/git-repo.adoc
index ed7d80c690..e34abe5fea 100644
--- a/Documentation/git-repo.adoc
+++ b/Documentation/git-repo.adoc
@@ -119,6 +119,16 @@ values that they return:
 `path.gitdir.relative`::
 	The path to the Git repository directory relative to the current working directory.
 
+`path.toplevel.absolute`::
+	The canonical absolute path to the top-level directory of the
+	repository's working tree. Outputs an empty string if the repository
+	is bare.
+
+`path.toplevel.relative`::
+	The path to the top-level directory of the repository's working
+	tree relative to the current working directory. Outputs an empty
+	string if the repository is bare.
+
 `references.format`::
 	The reference storage format. The valid values are:
 +
diff --git a/builtin/repo.c b/builtin/repo.c
index 84e012f83f..c31e9cfa70 100644
--- a/builtin/repo.c
+++ b/builtin/repo.c
@@ -121,6 +121,28 @@ static int get_path_gitdir_relative(struct repository *repo, struct strbuf *buf)
 	return 0;
 }
 
+static int get_path_toplevel_absolute(struct repository *repo, struct strbuf *buf)
+{
+	const char *work_tree = repo_get_work_tree(repo);
+
+	if (!work_tree)
+		return 0;
+
+	format_path(buf, work_tree, "", PATH_FORMAT_CANONICAL);
+	return 0;
+}
+
+static int get_path_toplevel_relative(struct repository *repo, struct strbuf *buf)
+{
+	const char *work_tree = repo_get_work_tree(repo);
+
+	if (!work_tree)
+		return 0;
+
+	format_path(buf, work_tree, repo->prefix, PATH_FORMAT_RELATIVE);
+	return 0;
+}
+
 static int get_references_format(struct repository *repo, struct strbuf *buf)
 {
 	strbuf_addstr(buf,
@@ -137,6 +159,8 @@ static const struct repo_info_field repo_info_field[] = {
 	{ "path.commondir.relative", get_path_commondir_relative },
 	{ "path.gitdir.absolute", get_path_gitdir_absolute },
 	{ "path.gitdir.relative", get_path_gitdir_relative },
+	{ "path.toplevel.absolute", get_path_toplevel_absolute },
+	{ "path.toplevel.relative", get_path_toplevel_relative },
 	{ "references.format", get_references_format },
 };
 
diff --git a/t/t1900-repo-info.sh b/t/t1900-repo-info.sh
index c85d390f43..9417d1ab65 100755
--- a/t/t1900-repo-info.sh
+++ b/t/t1900-repo-info.sh
@@ -213,4 +213,39 @@ test_repo_info_path 'gitdir with explicit GIT_DIR' 'gitdir' \
 	'.git' \
 	'GIT_DIR="../.git" && export GIT_DIR'
 
+test_expect_success 'path.toplevel absolute and relative' '
+	test_when_finished "rm -rf repo" &&
+	git init repo &&
+	(
+		mkdir -p repo/sub &&
+		cd repo/sub &&
+
+		ROOT="$(test-tool path-utils real_path ..)" &&
+
+		echo "path.toplevel.absolute=$ROOT" >expect.abs &&
+		git repo info path.toplevel.absolute >actual.abs &&
+		test_cmp expect.abs actual.abs &&
+
+		echo "path.toplevel.relative=../" >expect.rel &&
+		git repo info path.toplevel.relative >actual.rel &&
+		test_cmp expect.rel actual.rel
+	)
+'
+
+test_expect_success 'path.toplevel absolute and relative in a bare repository' '
+	test_when_finished "rm -rf bare.git" &&
+	git init --bare bare.git &&
+	(
+		cd bare.git &&
+
+		echo "path.toplevel.absolute=" >expect.abs &&
+		git repo info path.toplevel.absolute >actual.abs &&
+		test_cmp expect.abs actual.abs &&
+
+		echo "path.toplevel.relative=" >expect.rel &&
+		git repo info path.toplevel.relative >actual.rel &&
+		test_cmp expect.rel actual.rel
+	)
+'
+
 test_done
-- 
2.55.GIT

