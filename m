Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09FA413A3F7
	for <git@vger.kernel.org>; Wed, 28 May 2025 13:02:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748437355; cv=none; b=ZSBiNHoeFRusDeobkuEEecoymMPwPZwxSdOfTVX4ERFtrj5f3WfO04CIj9ZZ2rcMi/HMZ+9ePZV+y1xxW5c7MyrmhsVsQqP00BYhPn8rKeGf+ISmrjC00jAzsfTJwgddA8I4dKWQf35c/OGkOkJYlsf/pwADVjVRCiZR+8nTOtY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748437355; c=relaxed/simple;
	bh=PFjja31+3r8hLWHWUHXahGuKlgZf+m/ke+f4wn3EWLg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bf35if9BRL5DfiroCQHp3pbHejE2oGEDx+TcQbRoBFR6GmT5Rflapoy8tErjLiYEP8A8xwyxHXgZdoKZbq9VrAOV86KppBq/taB/x28mFbYX2uMhrvnCiL3NLhzz0fpO2/rEw7Pw7JkUCZ9XvzfYPn//WS9d0i7LcN/DoIp37ms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pspdfkit.com; spf=pass smtp.mailfrom=pspdfkit.com; dkim=pass (1024-bit key) header.d=pspdfkit.com header.i=@pspdfkit.com header.b=gyozlAN/; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pspdfkit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pspdfkit.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pspdfkit.com header.i=@pspdfkit.com header.b="gyozlAN/"
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-7cadd46ea9aso557058985a.1
        for <git@vger.kernel.org>; Wed, 28 May 2025 06:02:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pspdfkit.com; s=google; t=1748437352; x=1749042152; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VfZ2BFsl0vgSAyp1jQj9oCdA6cGW8/yaiTX1bziu5KY=;
        b=gyozlAN/nWvc4S9ARAPk5o0ulvuYBugj7Krfz3Lv7Rvc2DSfGC7rlYdhNwVNnO66VX
         a1C//aIXnPPOtjuY2KJIrIbFtlOzzH36sEuzAnmgs4kl4mLdYL6aw2NN10pvuD9P3gRI
         bAvSIN8zFCziS9dNOzLPQyINQCCd7Cy1MqNhw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748437352; x=1749042152;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VfZ2BFsl0vgSAyp1jQj9oCdA6cGW8/yaiTX1bziu5KY=;
        b=aEr88nC7v3uMDfJMtUv4sNiTJMpzsvJxmwHGwUubWUNfD93hTmGOA1CCCoA1sGkkJx
         cMsuS8B+NIlptz5RKEKluomy6S/E3+iXfEeRU5ryVTDPvijz/PEE9j6AESvq60SnI29T
         Wu8WyeP+72SuGz35t9NcbcGYjLMf4bpbbSOBuBhze3z1ddzkc/Xphnv4otHa7OPdTVUv
         EPowIxLU0c5jsRYxmlaBrtK8J5//reuBgRdWum0/8qa4DvRoiwxCoW6aKiYbCQ0p3Xj5
         DjA2LrK8YsYYKq2aN1GDrUvcEtxk4dip73yyKTJZ5JOtNgItHtyyX+2m81MCQq46AdFe
         Fe6Q==
X-Gm-Message-State: AOJu0Yxj2ekpab1lgWf7mX4W9zJCGjHgbE99SPjXtSylZfmghpYVBa1h
	8mRLX9k+xdqJR4852bftkFqgyNMbSN+KeZzrXnPeeSQxf6TVhSP8S3xx25JLrHEvt2xYZRzRZ8N
	4Pcg55O/tbA+C0MwK1oKC0RMK2q9jHEwCw0VxPwMEgqiUHPMEFayvdmeC3LgKKg0vYLLAstXuzc
	TfZw4COUF0RXX30surkOt49rGRfPhTrpX7V7652RM=
X-Gm-Gg: ASbGncus4YyzmN7VShGs9pql4HWiEKE+uEJ2Rz4Co5iyaK29difBMaKCTTTS66uIY0S
	AGiV+zJQBjfb/zOG69aJwRLHZ622azHY0XoJ9OlO65LNwZnAt72up55vEKAsOzj+UZctxLmS8pi
	YgqfHF/5yHRhAk9WK1d53KGE54OyIKM3XdWOwaUkwViK3qcY+oXU6xoEImMHgxJIxZ6ydRZ+HaV
	ELgaS4HSUfq49Af5NwaIA9ughaOv8PH9u14jxKfTyjinBYhzkz/pu/DF3bB85GgrA+JgDN3jXQf
	qt8EJ1LoOVCdJWDkX5D3EW0qD8wdk91/Ui5temKazsY1MhhVCUvW/MMWTi79KX5wp0IAAJMCMrl
	I9ICvxQlIWoKn9v4v7Qp/stxj6zQz+zYjkScYySs=
X-Google-Smtp-Source: AGHT+IF9exBwtUvnm9UoXZAzpbmPjG0kameOsss6W6tJ5/vpIuNZSw5ZqbosmICg6ORnSZYJCG6FFg==
X-Received: by 2002:a05:620a:2849:b0:7c5:57b1:1fd1 with SMTP id af79cd13be357-7ceecc447fdmr2571489985a.47.1748437346595;
        Wed, 28 May 2025 06:02:26 -0700 (PDT)
Received: from localhost.localdomain (syn-024-208-163-239.res.spectrum.com. [24.208.163.239])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7d06801f3d8sm54269585a.14.2025.05.28.06.02.25
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 28 May 2025 06:02:26 -0700 (PDT)
From: Patrik Weiskircher <patrik@pspdfkit.com>
To: git@vger.kernel.org
Cc: apenwarr@gmail.com,
	Patrik Weiskircher <patrik@pspdfkit.com>
Subject: [PATCH 2/2] contrib/subtree: Add tests for -S/--gpg-sign
Date: Wed, 28 May 2025 09:01:16 -0400
Message-ID: <20250528130116.21534-3-patrik@pspdfkit.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250528130116.21534-1-patrik@pspdfkit.com>
References: <20250528130116.21534-1-patrik@pspdfkit.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Make sure it works correctly.

Signed-off-by: Patrik Weiskircher <patrik@pspdfkit.com>
---
 contrib/subtree/t/t7900-subtree.sh | 113 +++++++++++++++++++++++++++++
 1 file changed, 113 insertions(+)

diff --git a/contrib/subtree/t/t7900-subtree.sh b/contrib/subtree/t/t7900-subtree.sh
index 3c6103f6d2..3edbb33af4 100755
--- a/contrib/subtree/t/t7900-subtree.sh
+++ b/contrib/subtree/t/t7900-subtree.sh
@@ -11,6 +11,7 @@ and push subcommands of git subtree.
 
 TEST_DIRECTORY=$(pwd)/../../../t
 . "$TEST_DIRECTORY"/test-lib.sh
+. "$TEST_DIRECTORY"/lib-gpg.sh
 
 # Use our own wrapper around test-lib.sh's test_create_repo, in order
 # to set log.date=relative.  `git subtree` parses the output of `git
@@ -1563,4 +1564,116 @@ test_expect_success 'subtree descendant check' '
 	)
 '
 
+test_expect_success GPG 'add subproj with GPG signing using -S flag' '
+	subtree_test_create_repo "$test_count" &&
+	subtree_test_create_repo "$test_count/sub proj" &&
+	test_create_commit "$test_count" main1 &&
+	test_create_commit "$test_count/sub proj" sub1 &&
+	(
+		cd "$test_count" &&
+		git fetch ./"sub proj" HEAD &&
+		git subtree add --prefix="sub dir" -S FETCH_HEAD &&
+		git verify-commit HEAD &&
+		test "$(last_commit_subject)" = "Add '\''sub dir/'\'' from commit '\''$(git rev-parse FETCH_HEAD)'\''"
+	)
+'
+
+test_expect_success GPG 'add subproj with GPG signing using --gpg-sign flag' '
+	subtree_test_create_repo "$test_count" &&
+	subtree_test_create_repo "$test_count/sub proj" &&
+	test_create_commit "$test_count" main1 &&
+	test_create_commit "$test_count/sub proj" sub1 &&
+	(
+		cd "$test_count" &&
+		git fetch ./"sub proj" HEAD &&
+		git subtree add --prefix="sub dir" --gpg-sign FETCH_HEAD &&
+		git verify-commit HEAD &&
+		test "$(last_commit_subject)" = "Add '\''sub dir/'\'' from commit '\''$(git rev-parse FETCH_HEAD)'\''"
+	)
+'
+
+test_expect_success GPG 'add subproj with GPG signing using specific key ID' '
+	subtree_test_create_repo "$test_count" &&
+	subtree_test_create_repo "$test_count/sub proj" &&
+	test_create_commit "$test_count" main1 &&
+	test_create_commit "$test_count/sub proj" sub1 &&
+	(
+		cd "$test_count" &&
+		git fetch ./"sub proj" HEAD &&
+		git subtree add --prefix="sub dir" -S"$GIT_COMMITTER_EMAIL" FETCH_HEAD &&
+		git verify-commit HEAD &&
+		test "$(last_commit_subject)" = "Add '\''sub dir/'\'' from commit '\''$(git rev-parse FETCH_HEAD)'\''"
+	)
+'
+
+test_expect_success GPG 'merge with GPG signing' '
+	subtree_test_create_repo "$test_count" &&
+	subtree_test_create_repo "$test_count/sub proj" &&
+	test_create_commit "$test_count" main1 &&
+	test_create_commit "$test_count/sub proj" sub1 &&
+	(
+		cd "$test_count" &&
+		git fetch ./"sub proj" HEAD &&
+		git subtree add --prefix="sub dir" FETCH_HEAD
+	) &&
+	test_create_commit "$test_count/sub proj" sub2 &&
+	(
+		cd "$test_count" &&
+		git fetch ./"sub proj" HEAD &&
+		git subtree merge --prefix="sub dir" -S FETCH_HEAD &&
+		git verify-commit HEAD
+	)
+'
+
+test_expect_success GPG 'split with GPG signing and --rejoin' '
+	subtree_test_create_repo "$test_count" &&
+	subtree_test_create_repo "$test_count/sub proj" &&
+	test_create_commit "$test_count" main1 &&
+	test_create_commit "$test_count/sub proj" sub1 &&
+	(
+		cd "$test_count" &&
+		git fetch ./"sub proj" HEAD &&
+		git subtree add --prefix="sub dir" FETCH_HEAD
+	) &&
+	test_create_commit "$test_count" "sub dir/main-sub1" &&
+	(
+		cd "$test_count" &&
+		git subtree split --prefix="sub dir" --rejoin -S &&
+		git verify-commit HEAD
+	)
+'
+
+test_expect_success GPG 'add with --squash and GPG signing' '
+	subtree_test_create_repo "$test_count" &&
+	subtree_test_create_repo "$test_count/sub proj" &&
+	test_create_commit "$test_count" main1 &&
+	test_create_commit "$test_count/sub proj" sub1 &&
+	(
+		cd "$test_count" &&
+		git fetch ./"sub proj" HEAD &&
+		git subtree add --prefix="sub dir" --squash -S FETCH_HEAD &&
+		git verify-commit HEAD &&
+		# With --squash, the commit subject should reference the squash commit (first parent of merge)
+		squash_commit=$(git rev-parse HEAD^2) &&
+		test "$(last_commit_subject)" = "Merge commit '\''$squash_commit'\'' as '\''sub dir'\''"
+	)
+'
+
+test_expect_success GPG 'pull with GPG signing' '
+	subtree_test_create_repo "$test_count" &&
+	subtree_test_create_repo "$test_count/sub proj" &&
+	test_create_commit "$test_count" main1 &&
+	test_create_commit "$test_count/sub proj" sub1 &&
+	(
+		cd "$test_count" &&
+		git subtree add --prefix="sub dir" ./"sub proj" HEAD
+	) &&
+	test_create_commit "$test_count/sub proj" sub2 &&
+	(
+		cd "$test_count" &&
+		git subtree pull --prefix="sub dir" -S ./"sub proj" HEAD &&
+		git verify-commit HEAD
+	)
+'
+
 test_done
-- 
2.49.0

