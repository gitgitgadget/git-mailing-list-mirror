Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D59B923183B
	for <git@vger.kernel.org>; Sat, 16 Aug 2025 21:37:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755380276; cv=pass; b=p/6cFAvbaAZ7mABXAw42Lc7wfrPXrOqwqL/l2CZC8RA8Qn+gViBSkjEunV7IhyTgjfOtR1bKOcNahXGMXUlh5MGoKRK7h7eQWjtZpi6BpXQF5eVM9NtmulTQKfN9Xk7Y6Uy3OzDKkaxDCwxO44J+la0h1fxGX8VS88uFetBVzbo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755380276; c=relaxed/simple;
	bh=Akze46ccnF1kQnRFrcmV3EdT6nJyxtXnHTu/Ki3itTU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KjKs27zOPsd+NFRHSF83fR61hatLfFX7/rShb9wY7IQVH0+tucEqVtzQ6fftpoYk1YpFFd/dWHK+127iwxj7DbL5oXUisTdjIaBe4dKGMoDyvTTBzMqOmIsq9jrnZiHutIz4vdAcIxhUTZdLh92UJREMb9rbZZ/UQkhxSQnyA60=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b=XzI08egP; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b="XzI08egP"
ARC-Seal: i=1; a=rsa-sha256; t=1755380259; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=Or+2pC4F14tsoucLIff0lutx8Q+FPsoWgfvRdx0NLp2cQCPS52eyyks2o4oKHrcToMwENuvi5fdfTE3qL/uQSSbdCMnnABgefxZuED+w3kioDyqJ4jYTAOCrjL2pGblgS8027y98cfZLR6Vfgi4mJ5C99JkY3PnStJAfLQ2kpdU=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1755380259; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=9c6YzieIbZrAkHuILCGZMOqYjhxMMwOlEGxKB6XyA8U=; 
	b=WchhbSV+FAPeUlQhuiujKQz7hd1ZbN779kb9q5DWsCd4dhBiaKR4tLclebGuEaiePW9paeD2FPy0UfuCw/qfn1GLIHd2tgd0gAd6PbA3v15cim8vSHEL6SDoYevfyjl1PG8GECXh6eybGwU4StgWTxhwaGtlJ5GB6Wh4HiHytv0=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=adrian.ratiu@collabora.com;
	dmarc=pass header.from=<adrian.ratiu@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1755380259;
	s=zohomail; d=collabora.com; i=adrian.ratiu@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=9c6YzieIbZrAkHuILCGZMOqYjhxMMwOlEGxKB6XyA8U=;
	b=XzI08egPrlWlFYmODjWGeFbAL/2JUEkgMxoIDveP/EX8weBNRf/Ym3e1qDRl3JUQ
	CutFnhIvF76zueNftsUhuZ3NgLNgFmdDBUKug1wrRQp0279D+4NCMcxUn0fevd3VYJd
	v+U/0O59K4T2zGdWu7dvbXWEr4Lgl1Y8ZyrYZMDk=
Received: by mx.zohomail.com with SMTPS id 175538025701336.23330900682629;
	Sat, 16 Aug 2025 14:37:37 -0700 (PDT)
From: Adrian Ratiu <adrian.ratiu@collabora.com>
To: git@vger.kernel.org
Cc: Emily Shaffer <emilyshaffer@google.com>,
	Rodrigo Damazio Bovendorp <rdamazio@google.com>,
	Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>,
	Aaron Schrab <aaron@schrab.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Stefan Beller <sbeller@google.com>,
	Patrick Steinhardt <ps@pks.im>,
	Adrian Ratiu <adrian.ratiu@collabora.com>
Subject: [PATCH 8/9] t: move nested gitdir tests to proper location
Date: Sun, 17 Aug 2025 00:36:41 +0300
Message-ID: <20250816213642.3517822-9-adrian.ratiu@collabora.com>
X-Mailer: git-send-email 2.50.1.679.gbf363a8fbb.dirty
In-Reply-To: <20250816213642.3517822-1-adrian.ratiu@collabora.com>
References: <20250816213642.3517822-1-adrian.ratiu@collabora.com>
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
index 801e90522a..902b2560ca 100755
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
2.50.1.679.gbf363a8fbb.dirty

