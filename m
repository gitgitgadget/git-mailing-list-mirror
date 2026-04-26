Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D519345CA1
	for <git@vger.kernel.org>; Sun, 26 Apr 2026 14:38:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777214331; cv=none; b=suZBKwbA98LIKlFwpE8ZqRpp3b4pEt2Cj62A9ltDITUkabfmSajEEuiZOsCNiRUJwhOMESE+0QohNi7TmUc5ryV4y+ruLl1ZjeoAWI4bD8CXb+CKh2yxFA0iAvgkgrOQWJdhhFpkoHEMdGUWH97ZDCtwIYJOsDG/fI4tXTgjyN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777214331; c=relaxed/simple;
	bh=/B5F6YEAxViVCwp70ftgUHuCDG+sVdMpnFV71M7VN5g=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=On3zDcYsaXCRq4UbqBjeqFxYjCwSzg9/Ds+dQOTWP2Y2nnIvjLNmhoM+6Jvj5M0m39hOIQqcMOzL99A/41Ft2LzJb2VPqmMsCIXbaPw2VC2tbNG8qdeLGPWh7GjJSN/DZZb+pIk1Fv4Bg3JSjXfBI15n0fq2ariL1hsf+wTXgbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bCty8mwq; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bCty8mwq"
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-50e5eb0fabaso78136121cf.0
        for <git@vger.kernel.org>; Sun, 26 Apr 2026 07:38:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777214329; x=1777819129; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ksimFm5/sBzDDY3KWT6CUGP20U3+49cPNwrlfoIeBbI=;
        b=bCty8mwqpKGD0AlN9X+y9r1B83oRunJmKsIlRfD4IZ5J2AA6tjoAVtBZpp9h5i4kAF
         bsluSjZKL/O0rumyTixDQQ9hNF2MHmizUwOBfzDBq9MedYHB7xyDQ59Kj86q4ohF2lt1
         Wji4ld8h8UPS9VPgOfSjoRikXP2zcl2iAIgiA+vblTiHs98TVVPF5eVBbHVMP2pOzENZ
         UbNoZ9iwNbMOMPzyovakKVYs58bmDGyw4O+3r72F/V3PiFvO7LTwDQ0WY+kt2qeZwCHX
         pVMf3cI+T3GI7TdGaFFauDAH6xn3vcI3RBkqoEFg+NSyZR1kXSiyrdNt730v0KuyjzDO
         bmgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777214329; x=1777819129;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ksimFm5/sBzDDY3KWT6CUGP20U3+49cPNwrlfoIeBbI=;
        b=hI0mIBVBFiC4jjILHdtGD83161GyXowydI6a5eoyEUpk/qjEyMj3RtnZCMeUzs9N0j
         6GOUsUGDmpINTv+owIJfoRdCrpi0M3mwckj+mAwsUOUUI1zEh2xVJa+jC3PDndZmT7dE
         PZigZ4RRohgXSinurqzcMQVSDg0yLqSk2tQyRB/QEjIWV4pY2DcYyxKSYxYkYUWgmp0V
         Evq/I3yi57+0sZou9/1uo069TFVyeaRK0de08YKcxZOXn818mDKQl8GhEaCG/3ibnwQt
         wXSrO1DExXoWoAj6LBfB2DcFxvFR5eFrSflbnntVV5xdAayPgh9evLKU9vnI0iDX0F58
         Wprw==
X-Gm-Message-State: AOJu0YzIby24hmM+IfvoGpvjCUBKvsujT4Io0wVX1ckNzZFpMs5Nk76s
	svfh2LVNh430UHjBSgAy5/cJR9qzkLeopPHC/8YT5IgUUA4w5Hwm16/p1S6Mntve
X-Gm-Gg: AeBDieu7rABFKCdgGxGJq9OdkvhQB5GLAembW8miUANXX0Zonf4+biIn8SmxQreIsDp
	XMImNM8H5yYOOD5z2DHJPeWjeQeFytpPY5PY2ENKHgmcocTme4mC05rPeO05Ylpqu/Ui+KxVzv9
	uBrHVPtn3yU314MfLk+EbdFomOvLV9AlReU85AFDMeJpiz3PuptpBk0IV77whRq6F7TdFbDYhE0
	zj4WLkmIfHRUGjeXTtcn4T9Onz4OuK0gjFItFAp98txaQhLpHOt/NS2R/DLfUCVAWJbgm6ENn5P
	2vp+F8jluXyecrb7XuZXUtRsppXJWnfL5CtVOPsJMV2+gCMkXT8tWX88FW45DHsh7Ot0PwlA3Xu
	1mKSuTaH6sg5j+DtaSs9m3QFRIj55bTdiAvdzH66ozl8ilqGSWOGeLwSW6sFHJDKn6YR4Y49J36
	NV+B6pch7/FgeMJS/wvNSiwOFGqjp1SBzD+5BYrjHCS8Qv
X-Received: by 2002:ac8:5aca:0:b0:50e:6302:340b with SMTP id d75a77b69052e-50e630248e4mr406481041cf.53.1777214328588;
        Sun, 26 Apr 2026 07:38:48 -0700 (PDT)
Received: from [127.0.0.1] ([20.98.18.66])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8b02ae5eaf1sm240780836d6.30.2026.04.26.07.38.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Apr 2026 07:38:48 -0700 (PDT)
Message-Id: <556db0eabe69f968b9d5f9922ab55d12271cd4d4.1777214316.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2098.v2.git.1777214316.gitgitgadget@gmail.com>
References: <pull.2098.git.1777042877.gitgitgadget@gmail.com>
	<pull.2098.v2.git.1777214316.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sun, 26 Apr 2026 14:38:34 +0000
Subject: [PATCH v2 6/8] ls-files tests: filter `.gitconfig` from `--others`
 output
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
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
    Johannes Schindelin <johannes.schindelin@gmx.de>

From: Johannes Schindelin <johannes.schindelin@gmx.de>

The global `safe.bareRepository=all` setting in test-lib.sh is
written to `$HOME/.gitconfig`, which unfortunately lives inside the
test repository's working tree. The `.git/info/exclude` entry added
alongside it handles most commands, but `git ls-files --others`
without `--exclude-standard` does not consult `info/exclude` at
all, so the file appears in the output.

Ideally, each test that accesses a bare repository would simply
specify `--git-dir` or `GIT_DIR` explicitly, which would require no
global config and produce no side effects in the working tree. As
that approach was not taken, filter `.gitconfig` from the output
before comparing against expected results. In t7104, the test
already uses `--exclude-standard`, so it suffices to switch from
the bare `git ls-files -o` to `git ls-files -o --exclude-standard`
which respects the `info/exclude` entry; the other tests
deliberately omit `--exclude-standard` because their purpose is to
verify unfiltered `--others` output.

Assisted-by: Claude Opus 4.6
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 t/t3000-ls-files-others.sh                         | 4 ++++
 t/t3001-ls-files-others-exclude.sh                 | 3 +++
 t/t3002-ls-files-dashpath.sh                       | 2 ++
 t/t3009-ls-files-others-nonsubmodule.sh            | 1 +
 t/t3011-common-prefixes-and-directory-traversal.sh | 3 ++-
 t/t7104-reset-hard.sh                              | 2 +-
 t/test-lib-functions.sh                            | 8 ++++++++
 7 files changed, 21 insertions(+), 2 deletions(-)

diff --git a/t/t3000-ls-files-others.sh b/t/t3000-ls-files-others.sh
index b41e7f0daa..b4f0fbfc55 100755
--- a/t/t3000-ls-files-others.sh
+++ b/t/t3000-ls-files-others.sh
@@ -53,16 +53,19 @@ test_expect_success 'setup: expected output' '
 
 test_expect_success 'ls-files --others' '
 	git ls-files --others >output &&
+	test_filter_gitconfig output &&
 	test_cmp expected1 output
 '
 
 test_expect_success 'ls-files --others --directory' '
 	git ls-files --others --directory >output &&
+	test_filter_gitconfig output &&
 	test_cmp expected2 output
 '
 
 test_expect_success '--no-empty-directory hides empty directory' '
 	git ls-files --others --directory --no-empty-directory >output &&
+	test_filter_gitconfig output &&
 	test_cmp expected3 output
 '
 
@@ -70,6 +73,7 @@ test_expect_success 'ls-files --others handles non-submodule .git' '
 	mkdir not-a-submodule &&
 	echo foo >not-a-submodule/.git &&
 	git ls-files -o >output &&
+	test_filter_gitconfig output &&
 	test_cmp expected1 output
 '
 
diff --git a/t/t3001-ls-files-others-exclude.sh b/t/t3001-ls-files-others-exclude.sh
index 4b67646285..202fb8d9ea 100755
--- a/t/t3001-ls-files-others-exclude.sh
+++ b/t/t3001-ls-files-others-exclude.sh
@@ -72,6 +72,7 @@ test_expect_success 'git ls-files --others with various exclude options.' '
        --exclude-per-directory=.gitignore \
        --exclude-from=.git/ignore \
 	>output &&
+	test_filter_gitconfig output &&
 	test_cmp expect output
 '
 
@@ -84,6 +85,7 @@ test_expect_success 'git ls-files --others with \r\n line endings.' '
        --exclude-per-directory=.gitignore \
        --exclude-from=.git/ignore \
 	>output &&
+	test_filter_gitconfig output &&
 	test_cmp expect output
 '
 
@@ -99,6 +101,7 @@ test_expect_success 'git ls-files --others with various exclude options.' '
        --exclude-per-directory=.gitignore \
        --exclude-from=.git/ignore \
 	>output &&
+	test_filter_gitconfig output &&
 	test_cmp expect output
 '
 
diff --git a/t/t3002-ls-files-dashpath.sh b/t/t3002-ls-files-dashpath.sh
index 31462cb441..6acaadbd67 100755
--- a/t/t3002-ls-files-dashpath.sh
+++ b/t/t3002-ls-files-dashpath.sh
@@ -24,6 +24,7 @@ test_expect_success 'setup' '
 test_expect_success 'git ls-files without path restriction.' '
 	test_when_finished "rm -f expect" &&
 	git ls-files --others >output &&
+	test_filter_gitconfig output &&
 	cat >expect <<-\EOF &&
 	--
 	-foo
@@ -63,6 +64,7 @@ test_expect_success 'git ls-files with path restriction with -- --.' '
 test_expect_success 'git ls-files with no path restriction.' '
 	test_when_finished "rm -f expect" &&
 	git ls-files --others -- >output &&
+	test_filter_gitconfig output &&
 	cat >expect <<-\EOF &&
 	--
 	-foo
diff --git a/t/t3009-ls-files-others-nonsubmodule.sh b/t/t3009-ls-files-others-nonsubmodule.sh
index 963f3462b7..dc990c277b 100755
--- a/t/t3009-ls-files-others-nonsubmodule.sh
+++ b/t/t3009-ls-files-others-nonsubmodule.sh
@@ -36,6 +36,7 @@ test_expect_success 'setup: directories' '
 
 test_expect_success 'ls-files --others handles untracked git repositories' '
 	git ls-files -o >output &&
+	test_filter_gitconfig output &&
 	cat >expect <<-EOF &&
 	nonrepo-untracked-file/untracked
 	output
diff --git a/t/t3011-common-prefixes-and-directory-traversal.sh b/t/t3011-common-prefixes-and-directory-traversal.sh
index 3da5b2b6e7..455e97954d 100755
--- a/t/t3011-common-prefixes-and-directory-traversal.sh
+++ b/t/t3011-common-prefixes-and-directory-traversal.sh
@@ -26,7 +26,7 @@ test_expect_success 'setup' '
 '
 
 test_expect_success 'git ls-files -o shows the right entries' '
-	cat <<-EOF >expect &&
+	cat >expect <<-EOF &&
 	.gitignore
 	actual
 	an_ignored_dir/ignored
@@ -39,6 +39,7 @@ test_expect_success 'git ls-files -o shows the right entries' '
 	untracked_repo/
 	EOF
 	git ls-files -o >actual &&
+	test_filter_gitconfig actual &&
 	test_cmp expect actual
 '
 
diff --git a/t/t7104-reset-hard.sh b/t/t7104-reset-hard.sh
index 7948ec392b..c23d6e3f52 100755
--- a/t/t7104-reset-hard.sh
+++ b/t/t7104-reset-hard.sh
@@ -21,7 +21,7 @@ test_expect_success setup '
 	rm -f hello &&
 	mkdir -p hello &&
 	>hello/world &&
-	test "$(git ls-files -o)" = hello/world
+	test "$(git ls-files -o --exclude-standard)" = hello/world
 
 '
 
diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
index f3af10fb7e..0505da78e8 100644
--- a/t/test-lib-functions.sh
+++ b/t/test-lib-functions.sh
@@ -2069,3 +2069,11 @@ test_trailing_hash () {
 test_redact_non_printables () {
     tr -d "\n\r" | tr "[\001-\040][\177-\377]" "."
 }
+
+# Remove .gitconfig entries from a file in place.  test-lib.sh may
+# create $HOME/.gitconfig (e.g. to set safe.bareRepository) which
+# can appear in ls-files or status output.
+test_filter_gitconfig () {
+	sed "/\\.gitconfig/d" "$1" >"$1.filtered" &&
+	mv "$1.filtered" "$1"
+}
-- 
gitgitgadget

