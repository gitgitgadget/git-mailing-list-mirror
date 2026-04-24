Received: from mail-oo1-f45.google.com (mail-oo1-f45.google.com [209.85.161.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C25A6280CFB
	for <git@vger.kernel.org>; Fri, 24 Apr 2026 15:01:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777042890; cv=none; b=Y0f7UvACnO65ujKFqBdOUzNlxNPLTgaHCJSRLURFNlMmrCAD0/L6viszVlCSxO33XKiY/wXf9ItsZM+oijEqIrX+X+lE6Eyh0Oz7gleRKJtjPA2Txr1DofbcGHsWtCz2Fjpc4BAB4AatH2iGn60ToJKfaqZOcBfNxG35/jMIqrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777042890; c=relaxed/simple;
	bh=/B5F6YEAxViVCwp70ftgUHuCDG+sVdMpnFV71M7VN5g=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=kcmzlh7QYKSXWCTUMISCyiGPNd7NvGAxzWI9oqOPwptanDEGURjdNopTNAvS3Cb3LIgILMHzrjHK/Rv0GlSBhxxA0w7yBWW7WehRyGMC1Mhn7lD9S/BKVHieVrYwS3R9ahOf7VsVxh3FIp/VCn8UI/+Mq+CmE2VEkW/uOQmDC50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SrWvh442; arc=none smtp.client-ip=209.85.161.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SrWvh442"
Received: by mail-oo1-f45.google.com with SMTP id 006d021491bc7-69626081f41so401324eaf.2
        for <git@vger.kernel.org>; Fri, 24 Apr 2026 08:01:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777042887; x=1777647687; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ksimFm5/sBzDDY3KWT6CUGP20U3+49cPNwrlfoIeBbI=;
        b=SrWvh442+9X0mBash52ZyI0hget92iF+Af2PPZSCRqNG02NWduZ4p6rLceg50kUlxb
         6Q4yo03iW2SWSp8Bh2ohghRt87EFEvjbiv7PMRMu1xlJpg1HRR4UVwX/wEmfiGpNPpL9
         E0DxiaiS+tH8NAg3JuyeAWkXi38rIC/oLLtJ6QDxHnlcVXyjMKjewTkXLACwvNQihM7E
         UQKz/KHfO5SNt0ZLx1NwPHDpuZD/D1zBeWJ7pqI6A4LNGjw2jZj/+tJ2oI4z3ZiXBAvB
         ciMGsXrazAF/OkKra2wXFpciBWoZOE6GDKjvUWLSe7/4bbOszwD4bVbPJxBlwVDkAVR5
         AXtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777042887; x=1777647687;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ksimFm5/sBzDDY3KWT6CUGP20U3+49cPNwrlfoIeBbI=;
        b=MRvhmriYeenFbdnXNGdsQUGrWeBoenrZFe4zryD0JyQUTjOClAkZpoXthQhMJWG8C8
         OvLklkhGjAaeCdGBdatetOfcwx7BR+T/R3JUteXSdxbMccqndxArluaR5RnF3Tk8nrUH
         MQ7y8XarziAf44qg47pywloTbP6rUGGzlIZ/3rXsAeXMmc1I7LB1/K6tn7vhVLJMhTNA
         E6PpqnHDFkAsjtXMrmHnG4wg/SEWVb2Cbfj0jtFfrhqVKmnM7WMxa9dDkWY/euYGP1Q8
         O85VnTwLXt30DznTtd/DEPqITQ+sCW14XZeuTup2FrQgXn7X5boDG6pAtDjHjCenZo7f
         rxiw==
X-Gm-Message-State: AOJu0Yxdva37Pt3RUGtiK4UDxK9cEy8yL8ygh2gZwGEF7lQ/KdSOEE5N
	D9O8bpTbiEiHep/5Uv2KROUrtsvEkBWLK6QUHU6Wj0kT/ww6WK/Y5JyxuXxhKw==
X-Gm-Gg: AeBDieumNOT50Qo5HRT7hudOcIPQ4l+Sv5IVT0cAT+UMAk6+8GMy2krmJPyYB/lwdpQ
	QXMoCIloMucrE5sAZU4S7rp43I3i8Qda6eFN6dB3EH9Ke+7VB0NJVj3+tPyEtVqovqDgGqMM/hF
	5VL5Ldia/Ymcl8oB3RnIaSCOikbe4yF5hlWHIh9e8mv9w8vNChHynBJ23XEeMKKmKDCb2KlFQyC
	6hOAzOC5cjOGGR0c4lKk1xmVE8eWq9GBpxeKiRBFg3hBjvceamZ/HeV51yhzUDrvYufvMmo8tCX
	wUfhoACN/dqf6FXwGWBzUdV3T1FCePWiET8oQt5HZifvquP345C2VTt6a40ruAEisRIfLB+ZrFO
	8nsIUEdvFf8BkyNRPl5/e3WfhafAoNQeC1AyYamuOKlcVU9kfjO4lCRBXaGpPC+YZ3qpupcULRs
	WaH5xGi25y9n9ulbDCygs5jR0172ngRS9I4Ske3A==
X-Received: by 2002:a05:6820:3082:b0:694:9d0f:cb50 with SMTP id 006d021491bc7-6949d0fcd24mr8831241eaf.27.1777042886615;
        Fri, 24 Apr 2026 08:01:26 -0700 (PDT)
Received: from [127.0.0.1] ([48.217.251.133])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-50fc91de051sm55376101cf.2.2026.04.24.08.01.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Apr 2026 08:01:26 -0700 (PDT)
Message-Id: <ef57244778d8f72754801d80a9e7e8ad034cec28.1777042877.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2098.git.1777042877.gitgitgadget@gmail.com>
References: <pull.2098.git.1777042877.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 24 Apr 2026 15:01:15 +0000
Subject: [PATCH 6/8] ls-files tests: filter `.gitconfig` from `--others`
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

