Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36922366DB4
	for <git@vger.kernel.org>; Sun, 26 Apr 2026 14:38:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777214332; cv=none; b=CNhMLw/t/E58QP2egQtPMGcEZatx+ZwIM6h7oIup98LJnKGU7SQmcqHpS6DY4SJKHs3MD5eWIpF+RBqJ5SWv0HOvmHttdDqm9bWK1x8LgV7PfYft+NnAm1SCw8XJuAIJcU/vSJLj2d9wqYiEkeOnIHddhvsqyqKPZXBy++zKtFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777214332; c=relaxed/simple;
	bh=Vzq/wYUQfB1R1pi7ResCdGX0Jro01nt1qIFce+RZSJs=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=rUMPFe6z5M+UsFSB1f9aJX9kQ0opaP4gnzbQQHouYQHNHatevyvTnDIMjb8go+rXE6vn0Sr5kUt7rdPhEE7MHt9/Bq+cMNdafihsxWGHM8v3dgVka5DXLPU08NdXMWG+ndT2ulnsc+DYck1IEbDIlD3kZqS0qau4aI/uJt3DckQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G2FaJrsm; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G2FaJrsm"
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-8eea23d01f7so514597885a.0
        for <git@vger.kernel.org>; Sun, 26 Apr 2026 07:38:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777214330; x=1777819130; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f9xkLvDtJ/wIlCfzzSUfzo3TzfkW5YJwu7ccK6abGW4=;
        b=G2FaJrsmbDYSZ/JsqumKbJ/Usx+8g9JJVmWcCT3WZS7vfMMp6B1CGlujq1fK2hamCV
         sdhUZxyDFddr6y8Y0Nf30TmLVighpKlpuaqIY/HAKHMWgwtoROoQ+NF8mkjJn9ScE9ww
         pilYS7e9iacXe1H6Pgn5VmnGsRX0COwK4QnlkV2LoGJvBnX2oLkzZ3bMwSV1HfgFVbez
         q+OWx3SbNLPF7Rdv0G6FVE0rVv9RrzNM3o6n8WBuHZm4cdIXTbVsJCZu61ZBVAiPgwhL
         h/1s+NxoIxU4zaRegTJuXceHNKutH9MvlIsuVACwyfaVxiQHNCYLka7X/3D0yvNn/8Xx
         P8WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777214330; x=1777819130;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=f9xkLvDtJ/wIlCfzzSUfzo3TzfkW5YJwu7ccK6abGW4=;
        b=n9m/x69047rzYMsrc9KaaSgRm+Ku3s2QFrhCmRocMDmXvppC1NyDUXXyxjlGmcl65I
         95Jx2qyb+RQw19H8SgBXjlvwjBFtt7k/ZtKHWCZAFezuYeNei5HxXIrMcROphgZ6UQtJ
         1S9wnE8cYzZgM+29TSDXbIOfPox57lsVN+CLxXpMQuFR1JCWHKzQykIqCQ59sPIalRKo
         UTDeOCRizYbPVHJ6AR0XM7/Wq3h94xaHKtz5FbZfQR9gvXTkliMQIlWOhRt7d9O2I0Bj
         IuYlV3hOgREK20TtSRTo3ipIYA49U9SXA1cJ06CyuhSby3KbpH3Bwq4+n6G9Cs3a+tTp
         reCg==
X-Gm-Message-State: AOJu0YxedRuy+L4esRj3sP+C2S2NCQebiVTPtoMA8TGw5NncJWskJeVW
	gTPiwawGEkNsXSW3mxi9lTQG+RJOeKy7UNpogwpi2wKlDhNdDo+NBnIG5IeYxqsC
X-Gm-Gg: AeBDievQtEzJFDGxAS4h+qY2HvorRBYDKwcBh/QYcuon3pErzLxwlI5HNd6INBXTYio
	s6ofiJiKHtvGLbnXlxINcvu/lfdFamDkUmZD4dODUzA9He2lXeyNoFJQFSE1Xiw5mnXkRqHg6hJ
	iHv0NGx6jLS8x37Jg6b3GCrrr4kDZ3V3UygCp9SWyPxK6Gbh97oAEsyXUZ2YeQ4Wp6tFWYWvwk6
	rOpzb7pkKEDShOZJVIZB/XCEXKjVlBk6FFvyEq2uHOfuAqvheE8rwLpOrynVlYAxqx7cteheRXy
	Z/KcHpa5n1NE7KPto0HWsHRdyB8bjhnQ6/oU9NBbWmwZNvGeVub/SpED/h4kIp78AyOeAlUvlks
	khLlPO1FFM8Lj5kL5bclZ3sqf9sEpVjCVsv6d8Ru8UCmyysSGijrX0uLqcSkSK0zUBfw3fkjXn2
	D1iZsx7S5nwREphxU+/pMepgbnHnVSAMmvdA==
X-Received: by 2002:a05:620a:26a6:b0:8ea:f802:d947 with SMTP id af79cd13be357-8eaf802ddcemr4451521385a.6.1777214329733;
        Sun, 26 Apr 2026 07:38:49 -0700 (PDT)
Received: from [127.0.0.1] ([20.98.18.66])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8e7d5fe9638sm2405603985a.1.2026.04.26.07.38.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Apr 2026 07:38:49 -0700 (PDT)
Message-Id: <ac4da79eac90aa062fd696f29c61b639030c1d41.1777214316.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2098.v2.git.1777214316.gitgitgadget@gmail.com>
References: <pull.2098.git.1777042877.gitgitgadget@gmail.com>
	<pull.2098.v2.git.1777214316.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sun, 26 Apr 2026 14:38:35 +0000
Subject: [PATCH v2 7/8] status tests: filter `.gitconfig` from status output
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

Since test-lib.sh creates `$HOME/.gitconfig` when
`WITH_BREAKING_CHANGES` is in effect, the file appears in `git
status` output as either untracked (`?? .gitconfig`) or ignored
(`!! .gitconfig` / `! .gitconfig`, depending on porcelain version),
because the `.git/info/exclude` entry causes git to treat it as an
ignored file rather than hiding it entirely.

In t7061 and t7521, which are pervasively affected, introduce a
`filter_gitconfig` helper that strips all status-prefix variants of
`.gitconfig` from the output before comparison. In the remaining
scripts (t7060, t7064, t7508), apply targeted adjustments.

Assisted-by: Claude Opus 4.6
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 t/t7060-wtstatus.sh        |  3 +--
 t/t7061-wtstatus-ignore.sh | 27 +++++++++++++++++++++++++++
 t/t7064-wtstatus-pv2.sh    |  1 +
 t/t7508-status.sh          |  4 ++++
 t/t7521-ignored-mode.sh    |  1 +
 5 files changed, 34 insertions(+), 2 deletions(-)

diff --git a/t/t7060-wtstatus.sh b/t/t7060-wtstatus.sh
index 0f4344c55e..942ddbbf0e 100755
--- a/t/t7060-wtstatus.sh
+++ b/t/t7060-wtstatus.sh
@@ -9,6 +9,7 @@ export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
 test_expect_success setup '
 	git config --global advice.statusuoption false &&
+	echo "/.gitconfig" >>.git/info/exclude &&
 	test_commit A &&
 	test_commit B oneside added &&
 	git checkout A^0 &&
@@ -221,7 +222,6 @@ test_expect_success 'status --branch with detached HEAD' '
 	git status --branch --porcelain >actual &&
 	cat >expected <<-EOF &&
 	## HEAD (no branch)
-	?? .gitconfig
 	?? actual
 	?? expect
 	?? expected
@@ -237,7 +237,6 @@ test_expect_success 'status --porcelain=v1 --branch with detached HEAD' '
 	git status --branch --porcelain=v1 >actual &&
 	cat >expected <<-EOF &&
 	## HEAD (no branch)
-	?? .gitconfig
 	?? actual
 	?? expect
 	?? expected
diff --git a/t/t7061-wtstatus-ignore.sh b/t/t7061-wtstatus-ignore.sh
index 2f9bea9793..14ddaba2f3 100755
--- a/t/t7061-wtstatus-ignore.sh
+++ b/t/t7061-wtstatus-ignore.sh
@@ -18,6 +18,7 @@ test_expect_success 'status untracked directory with --ignored' '
 	: >untracked/ignored &&
 	: >untracked/uncommitted &&
 	git status --porcelain --ignored >actual &&
+	test_filter_gitconfig actual &&
 	test_cmp expected actual
 '
 
@@ -27,6 +28,7 @@ test_expect_success 'same with gitignore starting with BOM' '
 	: >untracked/ignored &&
 	: >untracked/uncommitted &&
 	git status --porcelain --ignored >actual &&
+	test_filter_gitconfig actual &&
 	test_cmp expected actual
 '
 
@@ -40,18 +42,22 @@ test_expect_success 'status untracked files --ignored with pathspec (no match)'
 test_expect_success 'status untracked files --ignored with pathspec (literal match)' '
 	git status --porcelain --ignored -- untracked/ignored >actual &&
 	echo "!! untracked/ignored" >expected &&
+	test_filter_gitconfig actual &&
 	test_cmp expected actual &&
 	git status --porcelain --ignored -- untracked/uncommitted >actual &&
 	echo "?? untracked/uncommitted" >expected &&
+	test_filter_gitconfig actual &&
 	test_cmp expected actual
 '
 
 test_expect_success 'status untracked files --ignored with pathspec (glob match)' '
 	git status --porcelain --ignored -- untracked/i\* >actual &&
 	echo "!! untracked/ignored" >expected &&
+	test_filter_gitconfig actual &&
 	test_cmp expected actual &&
 	git status --porcelain --ignored -- untracked/u\* >actual &&
 	echo "?? untracked/uncommitted" >expected &&
+	test_filter_gitconfig actual &&
 	test_cmp expected actual
 '
 
@@ -65,6 +71,7 @@ EOF
 
 test_expect_success 'status untracked directory with --ignored -u' '
 	git status --porcelain --ignored -u >actual &&
+	test_filter_gitconfig actual &&
 	test_cmp expected actual
 '
 cat >expected <<\EOF
@@ -76,9 +83,11 @@ test_expect_success 'status of untracked directory with --ignored works with or
 	git status --porcelain --ignored >tmp &&
 	grep untracked/ tmp >actual &&
 	rm tmp &&
+	test_filter_gitconfig actual &&
 	test_cmp expected actual &&
 
 	git status --porcelain --ignored untracked/ >actual &&
+	test_filter_gitconfig actual &&
 	test_cmp expected actual
 '
 
@@ -89,6 +98,7 @@ EOF
 
 test_expect_success 'status prefixed untracked sub-directory with --ignored -u' '
 	git status --porcelain --ignored -u untracked/ >actual &&
+	test_filter_gitconfig actual &&
 	test_cmp expected actual
 '
 
@@ -104,6 +114,7 @@ test_expect_success 'status ignored directory with --ignore' '
 	mkdir ignored &&
 	: >ignored/uncommitted &&
 	git status --porcelain --ignored >actual &&
+	test_filter_gitconfig actual &&
 	test_cmp expected actual
 '
 
@@ -116,6 +127,7 @@ EOF
 
 test_expect_success 'status ignored directory with --ignore -u' '
 	git status --porcelain --ignored -u >actual &&
+	test_filter_gitconfig actual &&
 	test_cmp expected actual
 '
 
@@ -130,6 +142,7 @@ test_expect_success 'status empty untracked directory with --ignore' '
 	mkdir untracked-ignored &&
 	mkdir untracked-ignored/test &&
 	git status --porcelain --ignored >actual &&
+	test_filter_gitconfig actual &&
 	test_cmp expected actual
 '
 
@@ -141,6 +154,7 @@ EOF
 
 test_expect_success 'status empty untracked directory with --ignore -u' '
 	git status --porcelain --ignored -u >actual &&
+	test_filter_gitconfig actual &&
 	test_cmp expected actual
 '
 
@@ -155,6 +169,7 @@ test_expect_success 'status untracked directory with ignored files with --ignore
 	: >untracked-ignored/ignored &&
 	: >untracked-ignored/test/ignored &&
 	git status --porcelain --ignored >actual &&
+	test_filter_gitconfig actual &&
 	test_cmp expected actual
 '
 
@@ -168,6 +183,7 @@ EOF
 
 test_expect_success 'status untracked directory with ignored files with --ignore -u' '
 	git status --porcelain --ignored -u >actual &&
+	test_filter_gitconfig actual &&
 	test_cmp expected actual
 '
 
@@ -185,6 +201,7 @@ test_expect_success 'status ignored tracked directory with --ignore' '
 	git commit -m. &&
 	echo "tracked" >.gitignore &&
 	git status --porcelain --ignored >actual &&
+	test_filter_gitconfig actual &&
 	test_cmp expected actual
 '
 
@@ -196,6 +213,7 @@ EOF
 
 test_expect_success 'status ignored tracked directory with --ignore -u' '
 	git status --porcelain --ignored -u >actual &&
+	test_filter_gitconfig actual &&
 	test_cmp expected actual
 '
 
@@ -208,6 +226,7 @@ EOF
 test_expect_success 'status ignored tracked directory and ignored file with --ignore' '
 	echo "committed" >>.gitignore &&
 	git status --porcelain --ignored >actual &&
+	test_filter_gitconfig actual &&
 	test_cmp expected actual
 '
 
@@ -219,6 +238,7 @@ EOF
 
 test_expect_success 'status ignored tracked directory and ignored file with --ignore -u' '
 	git status --porcelain --ignored -u >actual &&
+	test_filter_gitconfig actual &&
 	test_cmp expected actual
 '
 
@@ -233,6 +253,7 @@ test_expect_success 'status ignored tracked directory and uncommitted file with
 	echo "tracked" >.gitignore &&
 	: >tracked/uncommitted &&
 	git status --porcelain --ignored >actual &&
+	test_filter_gitconfig actual &&
 	test_cmp expected actual
 '
 
@@ -245,6 +266,7 @@ EOF
 
 test_expect_success 'status ignored tracked directory and uncommitted file with --ignore -u' '
 	git status --porcelain --ignored -u >actual &&
+	test_filter_gitconfig actual &&
 	test_cmp expected actual
 '
 
@@ -260,6 +282,7 @@ test_expect_success 'status ignored tracked directory with uncommitted file in u
 	mkdir tracked/ignored &&
 	: >tracked/ignored/uncommitted &&
 	git status --porcelain --ignored >actual &&
+	test_filter_gitconfig actual &&
 	test_cmp expected actual
 '
 
@@ -272,6 +295,7 @@ EOF
 
 test_expect_success 'status ignored tracked directory with uncommitted file in untracked subdir with --ignore -u' '
 	git status --porcelain --ignored -u >actual &&
+	test_filter_gitconfig actual &&
 	test_cmp expected actual
 '
 
@@ -287,6 +311,7 @@ test_expect_success 'status ignored tracked directory with uncommitted file in t
 	git add -f tracked/ignored/committed &&
 	git commit -m. &&
 	git status --porcelain --ignored >actual &&
+	test_filter_gitconfig actual &&
 	test_cmp expected actual
 '
 
@@ -299,6 +324,7 @@ EOF
 
 test_expect_success 'status ignored tracked directory with uncommitted file in tracked subdir with --ignore -u' '
 	git status --porcelain --ignored -u >actual &&
+	test_filter_gitconfig actual &&
 	test_cmp expected actual
 '
 
@@ -310,6 +336,7 @@ test_expect_success 'status ignores submodule in excluded directory' '
 	git init tracked/submodule &&
 	test_commit -C tracked/submodule initial &&
 	git status --porcelain --ignored -u tracked/submodule >actual &&
+	test_filter_gitconfig actual &&
 	test_cmp expected actual
 '
 
diff --git a/t/t7064-wtstatus-pv2.sh b/t/t7064-wtstatus-pv2.sh
index 8bbc5ce6d9..be6c931a96 100755
--- a/t/t7064-wtstatus-pv2.sh
+++ b/t/t7064-wtstatus-pv2.sh
@@ -231,6 +231,7 @@ test_expect_success 'ignored files are printed with --ignored' '
 	EOF
 
 	git status --porcelain=v2 --ignored --untracked-files=all >actual &&
+	test_filter_gitconfig actual &&
 	test_cmp expect actual
 '
 
diff --git a/t/t7508-status.sh b/t/t7508-status.sh
index a5e21bf8bf..5f76ec62d8 100755
--- a/t/t7508-status.sh
+++ b/t/t7508-status.sh
@@ -263,6 +263,7 @@ test_expect_success 'status with gitignore' '
 	!! untracked
 	EOF
 	git status -s --ignored >output &&
+	test_filter_gitconfig output &&
 	test_cmp expect output &&
 
 	cat >expect <<\EOF &&
@@ -296,6 +297,7 @@ Ignored files:
 
 EOF
 	git status --ignored >output &&
+	test_filter_gitconfig output &&
 	test_cmp expect output
 '
 
@@ -328,6 +330,7 @@ test_expect_success 'status with gitignore (nothing untracked)' '
 	!! untracked
 	EOF
 	git status -s --ignored >output &&
+	test_filter_gitconfig output &&
 	test_cmp expect output &&
 
 	cat >expect <<\EOF &&
@@ -358,6 +361,7 @@ Ignored files:
 
 EOF
 	git status --ignored >output &&
+	test_filter_gitconfig output &&
 	test_cmp expect output
 '
 
diff --git a/t/t7521-ignored-mode.sh b/t/t7521-ignored-mode.sh
index a88b02b06e..7ea0b0d2f2 100755
--- a/t/t7521-ignored-mode.sh
+++ b/t/t7521-ignored-mode.sh
@@ -30,6 +30,7 @@ test_expect_success 'Verify behavior of status on directories with ignored files
 		dir/ignored/ignored_1.ign dir/ignored/ignored_2.ign &&
 
 	git status --porcelain=v2 --ignored=matching --untracked-files=all >output &&
+	test_filter_gitconfig output &&
 	test_cmp expect output
 '
 
-- 
gitgitgadget

