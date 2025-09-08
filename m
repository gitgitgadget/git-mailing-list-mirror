Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7D1130CDBA
	for <git@vger.kernel.org>; Mon,  8 Sep 2025 14:02:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757340178; cv=pass; b=jblvcFwx5ykJUSxF7eJf4Kxe/p1Iv0zsaocsZymV8eu/nlMPPli2flDodRkM5YH6K25BnHGFDMpcMbOodu12MSz4hq0v2SvQp+CH+Imlo5XCEkLJXUu4nMDjg27N9Z/lAAthjBBvULlFSl9t3l15GTk06gVa2zonvd8BlADGRKg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757340178; c=relaxed/simple;
	bh=nII6RzJDz+eZNx0VhmQ/l6p0Fyh2ov4FN/2ej86m6n4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=e9GICLvI06OZNCndVxHm0n28Rrx3kEUUPQuLfehR9J/zMmKJxiPxQEeSFJXPiIX70gAMaX/mDYxb+AGT04riqIIFjizWv8llwcwRS5O+n1ADKOs3FCIgieSJT7Bkn6Gtnw+R5vj+jg8Bn3K5E0hr6sgJWg3hFrWXRiRSQ/mY3WI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b=euek7mae; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b="euek7mae"
ARC-Seal: i=1; a=rsa-sha256; t=1757340156; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=laaisq2EjIkiVBBNN/nIGvi3OwzuOxUI07LzrxNA66F1G0I4zPPsq9moWG7fpfdSSMyNb+y01MMhY2bP4WYtewhG5YAGR0zDR+G4rljzI80iMlUj72J42KrqMaMPvG27zuYfRrAok32eAHdO9j3fPFDg5W5xdUPyTegAjMdVw5A=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1757340156; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=2EbQGB7rWQf1ugXaMoZzmr+FEa0gmFO0OL+YgSVZhLU=; 
	b=OeE6oJXpc40f1o3gS1ayfs9KF/JsbRI3fd5gvmSNTg6rynrcoUNcsPtWQZxDgO5Ym/OARgcuv87xVtAa8YZeDpirfruLOTg00OWVM5FARJA6u8Ejw90fpKKyOIkiXfqTzG7wl0MZncLJM70SQnysLr8rM14nm20+ETY8M+IWkpU=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=adrian.ratiu@collabora.com;
	dmarc=pass header.from=<adrian.ratiu@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1757340155;
	s=zohomail; d=collabora.com; i=adrian.ratiu@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=2EbQGB7rWQf1ugXaMoZzmr+FEa0gmFO0OL+YgSVZhLU=;
	b=euek7maeo0MoTlMgkSwpyJaSLSHNywc0/L5pzRtQUiLrDmYoTdvU65rrFNtC9m3R
	E290pTrDG6o2CstkU40qf21Tj0iS8Xh3TdFeDE2rxhDvRk6/QP12MhbYSYc+l7DYDMz
	XqO7gatRWYjE148EC04Lj4nzooYbZ7WE67VzP9PU=
Received: by mx.zohomail.com with SMTPS id 1757340151626832.811774020888;
	Mon, 8 Sep 2025 07:02:31 -0700 (PDT)
From: Adrian Ratiu <adrian.ratiu@collabora.com>
To: git@vger.kernel.org
Cc: Emily Shaffer <emilyshaffer@google.com>,
	Rodrigo Damazio Bovendorp <rdamazio@google.com>,
	Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>,
	Aaron Schrab <aaron@schrab.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Patrick Steinhardt <ps@pks.im>,
	Josh Steadmon <steadmon@google.com>,
	Ben Knoble <ben.knoble@gmail.com>,
	Adrian Ratiu <adrian.ratiu@collabora.com>
Subject: [PATCH v2 09/10] t7450: move nested gitdir tests to t7425
Date: Mon,  8 Sep 2025 17:01:16 +0300
Message-ID: <20250908140117.262205-10-adrian.ratiu@collabora.com>
X-Mailer: git-send-email 2.51.GIT
In-Reply-To: <20250908140117.262205-1-adrian.ratiu@collabora.com>
References: <20250816213642.3517822-1-adrian.ratiu@collabora.com>
 <20250908140117.262205-1-adrian.ratiu@collabora.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

Now that we are encoding gitdir paths, these tests are not handling
pathological cases anymore, because nested git dirs shouldn't cause
conflicts, so move them from t7450-bad-git-dotfiles.sh to a more
appropriate location where we test mixed gitdir path & encoding use.

Signed-off-by: Adrian Ratiu <adrian.ratiu@collabora.com>
---
 t/t7425-submodule-mixed-gitdir-paths.sh | 54 ++++++++++++++++++++++++
 t/t7450-bad-git-dotfiles.sh             | 56 -------------------------
 2 files changed, 54 insertions(+), 56 deletions(-)

diff --git a/t/t7425-submodule-mixed-gitdir-paths.sh b/t/t7425-submodule-mixed-gitdir-paths.sh
index 31f16d7741..a8c22de070 100755
--- a/t/t7425-submodule-mixed-gitdir-paths.sh
+++ b/t/t7425-submodule-mixed-gitdir-paths.sh
@@ -3,6 +3,7 @@
 test_description='submodules handle mixed legacy and new (encoded) style gitdir paths'
 
 . ./test-lib.sh
+. "$TEST_DIRECTORY"/lib-verify-submodule-gitdir-path.sh
 
 test_expect_success 'setup: allow file protocol' '
 	git config --global protocol.file.allow always
@@ -98,4 +99,57 @@ test_expect_success 'fetch mixed submodule changes and verify updates' '
 	)
 '
 
+test_expect_success 'setup submodules with nested git dirs' '
+	git init nested &&
+	test_commit -C nested nested &&
+	(
+		cd nested &&
+		cat >.gitmodules <<-EOF &&
+		[submodule "hippo"]
+			url = .
+			path = thing1
+		[submodule "hippo/hooks"]
+			url = .
+			path = thing2
+		EOF
+		git clone . thing1 &&
+		git clone . thing2 &&
+		git add .gitmodules thing1 thing2 &&
+		test_tick &&
+		git commit -m nested
+	)
+'
+
+test_expect_success 'git dirs of sibling submodules must not be nested' '
+	git clone --recurse-submodules nested clone_nested &&
+	verify_submodule_gitdir_path clone_nested hippo submodules/hippo &&
+	verify_submodule_gitdir_path clone_nested hippo/hooks submodules/hippo%2fhooks
+'
+
+test_expect_success 'submodule git dir nesting detection must work with parallel cloning' '
+	git clone --recurse-submodules --jobs=2 nested clone_parallel &&
+	verify_submodule_gitdir_path clone_nested hippo submodules/hippo &&
+	verify_submodule_gitdir_path clone_nested hippo/hooks submodules/hippo%2fhooks
+'
+
+test_expect_success 'checkout -f --recurse-submodules must corectly handle nested gitdirs' '
+	git clone nested clone_recursive_checkout &&
+	(
+		cd clone_recursive_checkout &&
+
+		git submodule init &&
+		git submodule update thing1 thing2 &&
+
+		# simulate a malicious nested alternate which git should not follow
+		mkdir -p .git/submodules/hippo/hooks/refs &&
+		mkdir -p .git/submodules/hippo/hooks/objects/info &&
+		echo "../../../../objects" >.git/submodules/hippo/hooks/objects/info/alternates &&
+		echo "ref: refs/heads/master" >.git/submodules/hippo/hooks/HEAD &&
+
+		git checkout -f --recurse-submodules HEAD
+	) &&
+	verify_submodule_gitdir_path clone_nested hippo submodules/hippo &&
+	verify_submodule_gitdir_path clone_nested hippo/hooks submodules/hippo%2fhooks
+'
+
 test_done
diff --git a/t/t7450-bad-git-dotfiles.sh b/t/t7450-bad-git-dotfiles.sh
index 27254300f8..18624fabc4 100755
--- a/t/t7450-bad-git-dotfiles.sh
+++ b/t/t7450-bad-git-dotfiles.sh
@@ -15,7 +15,6 @@ Such as:
 
 . ./test-lib.sh
 . "$TEST_DIRECTORY"/lib-pack.sh
-. "$TEST_DIRECTORY"/lib-verify-submodule-gitdir-path.sh
 
 test_expect_success 'setup' '
 	git config --global protocol.file.allow always
@@ -320,61 +319,6 @@ test_expect_success WINDOWS 'prevent git~1 squatting on Windows' '
 	fi
 '
 
-# TODO: move these nested gitdir tests to another location in a later commit because
-# they are not pathological cases anymore: by encoding the gitdir paths do not conflict.
-test_expect_success 'setup submodules with nested git dirs' '
-	git init nested &&
-	test_commit -C nested nested &&
-	(
-		cd nested &&
-		cat >.gitmodules <<-EOF &&
-		[submodule "hippo"]
-			url = .
-			path = thing1
-		[submodule "hippo/hooks"]
-			url = .
-			path = thing2
-		EOF
-		git clone . thing1 &&
-		git clone . thing2 &&
-		git add .gitmodules thing1 thing2 &&
-		test_tick &&
-		git commit -m nested
-	)
-'
-
-test_expect_success 'git dirs of sibling submodules must not be nested' '
-	git clone --recurse-submodules nested clone_nested &&
-	verify_submodule_gitdir_path clone_nested hippo submodules/hippo &&
-	verify_submodule_gitdir_path clone_nested hippo/hooks submodules/hippo%2fhooks
-'
-
-test_expect_success 'submodule git dir nesting detection must work with parallel cloning' '
-	git clone --recurse-submodules --jobs=2 nested clone_parallel &&
-	verify_submodule_gitdir_path clone_nested hippo submodules/hippo &&
-	verify_submodule_gitdir_path clone_nested hippo/hooks submodules/hippo%2fhooks
-'
-
-test_expect_success 'checkout -f --recurse-submodules must corectly handle nested gitdirs' '
-	git clone nested clone_recursive_checkout &&
-	(
-		cd clone_recursive_checkout &&
-
-		git submodule init &&
-		git submodule update thing1 thing2 &&
-
-		# simulate a malicious nested alternate which git should not follow
-		mkdir -p .git/submodules/hippo/hooks/refs &&
-		mkdir -p .git/submodules/hippo/hooks/objects/info &&
-		echo "../../../../objects" >.git/submodules/hippo/hooks/objects/info/alternates &&
-		echo "ref: refs/heads/master" >.git/submodules/hippo/hooks/HEAD &&
-
-		git checkout -f --recurse-submodules HEAD
-	) &&
-	verify_submodule_gitdir_path clone_nested hippo submodules/hippo &&
-	verify_submodule_gitdir_path clone_nested hippo/hooks submodules/hippo%2fhooks
-'
-
 test_expect_success SYMLINKS,!WINDOWS,!MINGW 'submodule must not checkout into different directory' '
 	test_when_finished "rm -rf sub repo bad-clone" &&
 
-- 
2.51.GIT

