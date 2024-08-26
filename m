Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD87117D8A6
	for <git@vger.kernel.org>; Mon, 26 Aug 2024 18:08:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724695738; cv=none; b=IKsvQGyVKkkAcWZeWK4NeiPWhRWzjLJVWkN5OJGHAcHAMQy+tEzWnJZS6ladkY5Gr/6qK9Pp7Tufjszlg6BFMZ6u/5+PXP9aeVzr7PukAsRND7a9Oftwsm/+6hG3l8vepOWloPE/WTEyJxnwnAyESJ5p34BUVf0zSkYgmXCvKMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724695738; c=relaxed/simple;
	bh=ljtMrmYhGE7tZEFkVFmBtuAZigp02QZuSRWoHbFwzro=;
	h=Message-Id:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=Nrx2dn4ediUbzMO/adYat/3C//DIbDpgDeAWqd/oLJSmeh4xBE3b3M4d+0C440f+Q/L+tzMH1x7jUKQWktpNxHsGjyQXNLAqLiSpm73RARCLUTnxXfdZL6S/EwetuUxemLBTvbrPGm3IeEg/PyllyVXLovSLqfgSenPlS36oRgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gxKk2XnD; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gxKk2XnD"
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-5befe420fc2so5644652a12.3
        for <git@vger.kernel.org>; Mon, 26 Aug 2024 11:08:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724695735; x=1725300535; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=SiluT7GMLtpwTEEj86Ypeqx42sK0VjrxhelP7pcwXTQ=;
        b=gxKk2XnDV775A0htkElB5B6C4etvE/JSwT0Dmw6FabCWZWpqzBQrFMGe00QSsSLim+
         6tqb0b8iBSS9i5bf35+VQl3DA71Hwyp4kYVuKjjfg96nif4f5oijhSlQWX2hE+zraPFi
         AICIK3Ig19UEvL483b+SJcQvSy6wOQNMI9llTQpnOl7NPz/yh1TyMy5vExyt8LhoUGO2
         gj+HwTgoZKcbWS/I94DECyHRV2+OcepwXB42YuHUa7f6wFgBrfoRxF9fJMh1qg+Redwe
         r8WpuvmmarTmEj8xIlmEf7Vu9l4oUWf9sisIxmDKsRNstfgHGnOANiUO3jKsQwJ6bdkn
         DCFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724695735; x=1725300535;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SiluT7GMLtpwTEEj86Ypeqx42sK0VjrxhelP7pcwXTQ=;
        b=XfV1LlW+Q3h5m29+MrwrVIZ00CcEVVlAfYlVpzseZLkhU6MiTN5nnAiwTc+l9cVH55
         kVqsQZwyhADmlUckzSgmbJEYPsaINBLKO6geDD1derP+9eqSRr+0K7xjLgJH+DxhFQL6
         XtHJDNtN0+FYjlmqRF4W5qRZa1ThYlFrUd9YtFUnIU5UEtSKDl1v0gDAOXPmvOQpJtkv
         N5881PGiESl9/CPJ36z86HTKyR6sZA5H9bEPx/UlVFVTk1TioK9cU/pbFqfpnu027B5R
         r4xMt5Pt0IX/TF3Y/xmsOdLBTF8q0xWA4DQVxF9uvfEKQk33ShEwF7pD+4kwrqI8elzt
         YEuA==
X-Gm-Message-State: AOJu0YyBq/auOZiquZBLnist6l59J6ku3Vn1u9ThiJVh9kPg3+nU6rld
	5zICQJ4z3hiaP6yxolJnqDTKq1qSAv3HOiniz5P0yvmrrkXy1N00+OImLA==
X-Google-Smtp-Source: AGHT+IGdmapBGaE3BQ8/cJGmzfe2yTlRWDFVfkeEXX6GP11ETiQY+mYmKKXz/k9MBl9ujTOUSKf95g==
X-Received: by 2002:a17:907:7250:b0:a7d:48e3:4117 with SMTP id a640c23a62f3a-a86a54df9ddmr717392466b.68.1724695733949;
        Mon, 26 Aug 2024 11:08:53 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a86e5954a88sm2564566b.224.2024.08.26.11.08.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Aug 2024 11:08:53 -0700 (PDT)
Message-Id: <pull.1770.git.git.1724695732305.gitgitgadget@gmail.com>
From: "Kevin Lyles via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 26 Aug 2024 18:08:52 +0000
Subject: [PATCH] Mark `cat-file` sparse-index compatible
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
Cc: Kevin Lyles <klyles+github@epic.com>,
    Kevin Lyles <klyles+github@epic.com>

From: Kevin Lyles <klyles+github@epic.com>

`cat-file` will expand a sparse index to a full index when needed, but
is currently marked as needing a full index (or rather, not marked as
not needing a full index). This results in much slower `cat-file`
operations when working within the sparse index, since we expand the
index whether it's needed or not.

Mark `cat-file` as not needing a full index, so that you only pay the
cost of expanding the sparse index to a full index when you request a
file outside of the sparse index.

Add tests to ensure both that:
- `cat-file` returns the correct file contents whether or not the file
  is in the sparse index
- `cat-file` warns about expanding to the full index any time you
  request something outside of the sparse index

Signed-off-by: Kevin Lyles <klyles+github@epic.com>
---
    Mark cat-file sparse-index compatible
    
    Please note that this is my first contribution to git. I've tried to
    follow the instructions about how to correctly submit a patch (I'm using
    GitGitGadget as getting Outlook to do plain text e-mail correctly seems
    impossible), but please let me know if I've missed something.
    
    I've worded the commit message itself as though I'm definitely correct
    about how cat-file behaves, since I assume we want the final commit
    message to be definite. However, this change felt a little too easy and
    I can't help but feel that I might have missed something. So, even
    though this is just one commit, I'm also including this cover letter
    going into more detail about the parts that don't need to be part of the
    commit history.
    
    My motivation for making this change is purely performance. We have a
    large repository that we enable the sparse index for, and I am
    developing a pre-commit hook that (among other things) uses git cat-file
    to get the staged contents of certain files. Without this change,
    getting the contents of a single small file from the index can take
    upwards of 10 seconds due to the index expansion. After this change, it
    only takes ~0.3 seconds unless the file is outside of the sparse index.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1770%2Fklylesatepic%2Fkl%2Fmark-cat-file-sparse-index-compatible-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1770/klylesatepic/kl/mark-cat-file-sparse-index-compatible-v1
Pull-Request: https://github.com/git/git/pull/1770

 builtin/cat-file.c                       |  3 +
 t/t1092-sparse-checkout-compatibility.sh | 71 ++++++++++++++++++++++--
 2 files changed, 69 insertions(+), 5 deletions(-)

diff --git a/builtin/cat-file.c b/builtin/cat-file.c
index 18fe58d6b8b..1afdfb5cbae 100644
--- a/builtin/cat-file.c
+++ b/builtin/cat-file.c
@@ -1047,6 +1047,9 @@ int cmd_cat_file(int argc, const char **argv, const char *prefix)
 	if (batch.buffer_output < 0)
 		batch.buffer_output = batch.all_objects;
 
+	prepare_repo_settings(the_repository);
+	the_repository->settings.command_requires_full_index = 0;
+
 	/* Return early if we're in batch mode? */
 	if (batch.enabled) {
 		if (opt_cw)
diff --git a/t/t1092-sparse-checkout-compatibility.sh b/t/t1092-sparse-checkout-compatibility.sh
index a2c0e1b4dcc..0f36246ae84 100755
--- a/t/t1092-sparse-checkout-compatibility.sh
+++ b/t/t1092-sparse-checkout-compatibility.sh
@@ -179,22 +179,26 @@ init_repos_as_submodules () {
 }
 
 run_on_sparse () {
+	tee run_on_sparse-checkout run_on_sparse-index &&
+
 	(
 		cd sparse-checkout &&
 		GIT_PROGRESS_DELAY=100000 "$@" >../sparse-checkout-out 2>../sparse-checkout-err
-	) &&
+	) <run_on_sparse-checkout &&
 	(
 		cd sparse-index &&
 		GIT_PROGRESS_DELAY=100000 "$@" >../sparse-index-out 2>../sparse-index-err
-	)
+	) <run_on_sparse-index
 }
 
 run_on_all () {
+	tee run_on_all-full run_on_all-sparse &&
+
 	(
 		cd full-checkout &&
 		GIT_PROGRESS_DELAY=100000 "$@" >../full-checkout-out 2>../full-checkout-err
-	) &&
-	run_on_sparse "$@"
+	) <run_on_all-full &&
+	run_on_sparse "$@" <run_on_all-sparse
 }
 
 test_all_match () {
@@ -221,7 +225,7 @@ test_sparse_unstaged () {
 	done
 }
 
-# Usage: test_sprase_checkout_set "<c1> ... <cN>" "<s1> ... <sM>"
+# Usage: test_sparse_checkout_set "<c1> ... <cN>" "<s1> ... <sM>"
 # Verifies that "git sparse-checkout set <c1> ... <cN>" succeeds and
 # leaves the sparse index in a state where <s1> ... <sM> are sparse
 # directories (and <c1> ... <cN> are not).
@@ -2345,4 +2349,61 @@ test_expect_success 'advice.sparseIndexExpanded' '
 	grep "The sparse index is expanding to a full index" err
 '
 
+test_expect_success 'cat-file -p' '
+	init_repos &&
+	echo "new content" >>full-checkout/deep/a &&
+	echo "new content" >>sparse-checkout/deep/a &&
+	echo "new content" >>sparse-index/deep/a &&
+	run_on_all git add deep/a &&
+
+	test_all_match git cat-file -p HEAD:deep/a &&
+	ensure_not_expanded cat-file -p HEAD:deep/a &&
+	test_all_match git cat-file -p HEAD:folder1/a &&
+	ensure_not_expanded cat-file -p HEAD:folder1/a &&
+
+	test_all_match git cat-file -p :deep/a &&
+	ensure_not_expanded cat-file -p :deep/a &&
+	run_on_all git cat-file -p :folder1/a &&
+	test_cmp full-checkout-out sparse-checkout-out &&
+	test_cmp full-checkout-out sparse-index-out &&
+	test_cmp full-checkout-err sparse-checkout-err &&
+	ensure_expanded cat-file -p :folder1/a'
+
+test_expect_success 'cat-file --batch' '
+	init_repos &&
+	echo "new content" >>full-checkout/deep/a &&
+	echo "new content" >>sparse-checkout/deep/a &&
+	echo "new content" >>sparse-index/deep/a &&
+	run_on_all git add deep/a &&
+
+	cat <<-\EOF | test_all_match git cat-file --batch &&
+	HEAD:deep/a
+	:deep/a
+	EOF
+	cat <<-\EOF | ensure_not_expanded cat-file --batch &&
+	HEAD:deep/a
+	:deep/a
+	EOF
+
+	echo "HEAD:folder1/a" | test_all_match git cat-file --batch &&
+	echo "HEAD:folder1/a" | ensure_not_expanded cat-file --batch &&
+
+	echo ":folder1/a" | run_on_all git cat-file --batch &&
+	test_cmp full-checkout-out sparse-checkout-out &&
+	test_cmp full-checkout-out sparse-index-out &&
+	test_cmp full-checkout-err sparse-checkout-err &&
+	echo ":folder1/a" | ensure_expanded cat-file --batch &&
+
+	cat <<-\EOF | run_on_all git cat-file --batch &&
+	:deep/a
+	:folder1/a
+	EOF
+	test_cmp full-checkout-out sparse-checkout-out &&
+	test_cmp full-checkout-out sparse-index-out &&
+	test_cmp full-checkout-err sparse-checkout-err &&
+	cat <<-\EOF | ensure_expanded cat-file --batch
+	:deep/a
+	:folder1/a
+	EOF'
+
 test_done

base-commit: 80ccd8a2602820fdf896a8e8894305225f86f61d
-- 
gitgitgadget
