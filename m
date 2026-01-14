Received: from mail-dl1-f46.google.com (mail-dl1-f46.google.com [74.125.82.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE2AD37A484
	for <git@vger.kernel.org>; Wed, 14 Jan 2026 07:48:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768376892; cv=none; b=Yeb/EttSCp+MH1B//66SrnWWqx+16AHd9CUoZVUxSIlRgL3Imv/pJYQAzPz76i7eVfX2WwQf12AAadG+eF9j1OuDTZYv/akBkgNxa35iLq/0e9V+NhElNTI5JO0CaDUauJAQ5A1APqjDA8pmfVzx2I93alDBRlqx+uuOKgbjn2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768376892; c=relaxed/simple;
	bh=e7j7yOonKtO2QYWRL3kC/LPZCVbdOMxFUzTbAyopkmg=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=qHT9fiKfeRiFezL3ivTOV3zJuCx3MJpb9wWVhw+GeRonBi2r9ZPeorSLv1y7tV8aeq4BkI/Me+hTvbkLS7K/yc1tkQrqVsW4ZMkn1679lXOAwH3c96YBPXIEZ7OlclWtHf0+sWJLpqTWrcBTZO2D1z82aQK4zk8xI7uEBC+uV9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a0uDFvZZ; arc=none smtp.client-ip=74.125.82.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a0uDFvZZ"
Received: by mail-dl1-f46.google.com with SMTP id a92af1059eb24-12331482b8fso378058c88.1
        for <git@vger.kernel.org>; Tue, 13 Jan 2026 23:48:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768376887; x=1768981687; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YgD33fDpR5xPlUwyF+xKtJyeIWyR4dIiT5eMkoEnZhA=;
        b=a0uDFvZZZIRyM5zgJiYZfhiysqVU/r3gpM3nrDE0JwAbzIHTDr7bsuByDumN/atKYK
         NrMFTxDWnNd+7B3BXLTy6rUpz9VpNPupWHZRPoxV6oO+GNwKGrGWLdyw7JwccNlanLQb
         RS9l9ikKBlgYGUxpCn0kF6tFLRo6aQQ+mLdl5wq3SPBTJ1wS2hhLQABb1vG57DW7S9GD
         3byo/q+W0S2ty4VcmlgrdWUEfkgNKCZQnjQ8/0Gogn7Cp2Rj2/HYSuz6gq21t5eZZ0fK
         GSfiWi8OREmX46LIFaB91hL/4J+i8TK0mmIEM6RL8ZEXA0V/RqRu1HXZKmdgug9X4BNH
         aPzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768376887; x=1768981687;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=YgD33fDpR5xPlUwyF+xKtJyeIWyR4dIiT5eMkoEnZhA=;
        b=a4GE9CxJdyGrVwfQyGVad6QoSB7kMV3ccmKXTFEKEb0ZCoVpIy19tmeDzjhMPGjYUs
         jxNJtdA0jq6IV1TjNNn5+OEh7S70MDSvuZ+OYSNdX8+lU6x/MDCJWhYo0lHtHJt+UZXe
         Umkf2X7GarwegQnAvoBD3MpZE/Lx8LsnVVF/BUHAmt+psVaIv5ZOOMXAT35kSUA+cn5H
         5GAR9wf1v9wtBQQqjU8gwHCdZrsNbfn7diFOFPG5/nDU/zL5tCM0xWvqwHZDrytRAErW
         yMmnXOYHUaraDF0Rrq+nm16OWp/hX5ahn0MfQqE6a095Y+oND2hugbg13vrBjMC/Meok
         elaQ==
X-Gm-Message-State: AOJu0Yz7NNxuJzUbT7DkO6J9iSwU78Tmbw1Da1hHCtpa97e2WG/3KdY6
	T/Qkluom+I2y7Oj1C3QxbM+OJLyC5kaa4wUz8CZBnbv3KPTuRk4bA9kHrYYGDQ==
X-Gm-Gg: AY/fxX7bFyv2/qRbwrMVP/X84RmgSpcF1q0JhoUmU1sD6yweiWg1HvdTzCipDA91jn2
	7e2937+LVlRtPyZNByflsEbbdmUxcTLajfnis8JtRFm4wSaQ05HmJ4pNM+Zo8XZ9/LbZrrDv9Ah
	KODC+GTJ3niB4Khoiux2c31CFNSoAmHahButzjPvN8ot7Re9j6GSBa7s3SeLSFeW3FYzVsOfH9g
	Pnd5dhMSobVtpYrkwm+qnCtkwlja9+labTIWctN8oF0aDZhuQ4AUSWDKGl+7Bq2BWw4dpou6DtQ
	3VLQ0dmNfnY2qrpweY02/djqDXJTqn4USVStx41DIEUMO1LZdKwkHQ4jlubJfhTsBg0GmHjWPMj
	Vv7TpuKqMtaLYQGqrjNInghXvdEROHiVKo6pgDmnT2fl3R/jkyLEUNweUBa8bwlWoE+fBYp3eXO
	bUVwxiLW5l2j25Vw==
X-Received: by 2002:a05:701b:251a:b0:11b:8161:5cfc with SMTP id a92af1059eb24-12337773edamr1426762c88.36.1768376886697;
        Tue, 13 Jan 2026 23:48:06 -0800 (PST)
Received: from [127.0.0.1] ([128.24.160.225])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-121f24984a3sm30752061c88.13.2026.01.13.23.48.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jan 2026 23:48:06 -0800 (PST)
Message-Id: <d7b97e12d37f614ad7979e3147df158109c9d57e.1768376879.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1987.v3.git.1768376879.gitgitgadget@gmail.com>
References: <pull.1987.v2.git.1763057433.gitgitgadget@gmail.com>
	<pull.1987.v3.git.1768376879.gitgitgadget@gmail.com>
From: "Claus Schneider(Eficode) via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 14 Jan 2026 07:47:57 +0000
Subject: [PATCH v3 3/5] tests: t2206-add-submodule-ignored: ignore=all and add
 --force tests
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
Cc: =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason <avarab@gmail.com>,
    Junio C Hamano <gitster@pobox.com>,
    Brandon Williams <bwilliams.eng@gmail.com>,
    Phillip Wood <phillip.wood123@gmail.com>,
    Claus Schneider <claus.schneider@eficode.com>,
    Claus Schneider <claus.schneider@eficode.com>,
    "Claus Schneider(Eficode)" <claus.schneider@eficode.com>

From: "Claus Schneider(Eficode)" <claus.schneider@eficode.com>

The tests verify that the submodule behavior is intact and updating the
config with ignore=all also behaves as intended with configuration in
.gitmodules and configuration given on the command line.

The usage of --force is showcased and tested in the test suite.

The test file is added to meson.build for execution.

Signed-off-by: Claus Schneider(Eficode) <claus.schneider@eficode.com>
---
 t/meson.build                    |   1 +
 t/t2206-add-submodule-ignored.sh | 134 +++++++++++++++++++++++++++++++
 2 files changed, 135 insertions(+)
 create mode 100755 t/t2206-add-submodule-ignored.sh

diff --git a/t/meson.build b/t/meson.build
index a5531df415..a7d3e3e0a2 100644
--- a/t/meson.build
+++ b/t/meson.build
@@ -290,6 +290,7 @@ integration_tests = [
   't2203-add-intent.sh',
   't2204-add-ignored.sh',
   't2205-add-worktree-config.sh',
+  't2206-add-submodule-ignored.sh',
   't2300-cd-to-toplevel.sh',
   't2400-worktree-add.sh',
   't2401-worktree-prune.sh',
diff --git a/t/t2206-add-submodule-ignored.sh b/t/t2206-add-submodule-ignored.sh
new file mode 100755
index 0000000000..e581e87ab2
--- /dev/null
+++ b/t/t2206-add-submodule-ignored.sh
@@ -0,0 +1,134 @@
+#!/bin/sh
+# shellcheck disable=SC2016
+
+# shellcheck disable=SC2034
+test_description='git add respects submodule ignore=all and explicit pathspec'
+
+# This test covers the behavior of "git add", "git status" and "git log" when
+# dealing with submodules that have the ignore=all setting in
+# .gitmodules. It ensures that changes in such submodules are
+# ignored by default, but can be staged with "git add --force".
+
+# shellcheck disable=SC1091
+. ./test-lib.sh
+
+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
+export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
+
+base_path=$(pwd -P)
+
+#1
+test_expect_success 'setup: create origin repos'  '
+	cd "${base_path}" &&
+	git config --global protocol.file.allow always &&
+	git init sub &&
+		pwd &&
+		cd sub &&
+		test_commit sub_file1 &&
+		git tag v1.0 &&
+		test_commit sub_file2 &&
+		git tag v2.0 &&
+		test_commit sub_file3 &&
+		git tag v3.0 &&
+	cd "${base_path}" &&
+	git init main &&
+		cd main &&
+		test_commit first &&
+	cd "${base_path}"
+'
+#2
+# add submodule with default config (ignore=none) and
+# check log that is contains a path entry for the submodule 'sub'
+# change the commit in the submodule and check that 'git status' shows it as modified
+test_expect_success 'main: add submodule with default config'  '
+	cd "${base_path}" &&
+	cd main &&
+	git submodule add ../sub &&
+	git commit -m "add submodule" &&
+	git log --oneline --name-only | grep "^sub$" &&
+	git -C sub reset --hard v2.0 &&
+	git status --porcelain | grep "^ M sub$" &&
+	echo
+'
+#3
+# change the submodule config to ignore=all and check that status and log do not show changes
+test_expect_success 'main: submodule config ignore=all'  '
+	cd "${base_path}" &&
+	cd main &&
+	git config -f .gitmodules submodule.sub.ignore all &&
+	GIT_TRACE=1 git add . &&
+	git commit -m "update submodule config sub.ignore all" &&
+	! git status --porcelain | grep "^.*$" &&
+	! git log --oneline --name-only | grep "^sub$" &&
+	echo
+'
+#4
+# change the commit in the submodule and check that 'git status' does not show it as modified
+# but 'git status --ignore-submodules=none' does show it as modified
+test_expect_success 'sub: change to different sha1 and check status in main'  '
+	cd "${base_path}" &&
+	cd main &&
+	git -C sub reset --hard v1.0 &&
+	! git status --porcelain | grep "^ M sub$" &&
+	git status --ignore-submodules=none --porcelain | grep "^ M sub$" &&
+	echo
+'
+
+#5
+# check that normal 'git add' does not stage the change in the submodule
+test_expect_success 'main: check normal add and status'  '
+	cd "${base_path}" &&
+	cd main &&
+	GIT_TRACE=1 git add . &&
+	! git status --porcelain | grep "^ M sub$" &&
+	echo
+'
+
+#6
+# check that 'git add --force .' does not stage the change in the submodule
+# and that 'git status' does not show it as modified
+test_expect_success 'main: check --force add . and status'  '
+	cd "${base_path}" &&
+	cd main &&
+	GIT_TRACE=1 git add --force . &&
+	! git status --porcelain | grep "^M  sub$" &&
+	echo
+'
+
+#7
+# check that 'git add .' does not stage the change in the submodule
+# and that 'git status' does not show it as modified
+test_expect_success 'main: check _add sub_ and status'  '
+	cd "${base_path}" &&
+	cd main &&
+	GIT_TRACE=1 git add sub 2>&1 | grep "Skipping submodule due to ignore=all: sub" &&
+	! git status --porcelain | grep "^M  sub$" &&
+	echo
+'
+
+#8
+# check that 'git add --force sub' does stage the change in the submodule
+# check that 'git add --force ./sub/' does stage the change in the submodule
+# and that 'git status --porcelain' does show it as modified
+# commit it..
+# check that 'git log --ignore-submodules=none' shows the submodule change
+# in the log
+test_expect_success 'main: check force add sub and ./sub/ and status'  '
+	cd "${base_path}" &&
+	cd main &&
+	echo "Adding with --force should work: git add --force sub" &&
+	GIT_TRACE=1 git add --force sub &&
+	git status --porcelain | grep "^M  sub$" &&
+	git restore --staged sub &&
+	! git status --porcelain | grep "^M  sub$" &&
+	echo "Adding with --force should work: git add --force ./sub/" &&
+	GIT_TRACE=1 git add --force ./sub/ &&
+	git status --porcelain | grep "^M  sub$" &&
+	git commit -m "update submodule pointer" &&
+	! git status --porcelain | grep "^ M sub$" &&
+	git log --ignore-submodules=none --name-only --oneline | grep "^sub$" &&
+	echo
+'
+
+test_done
+exit 0
-- 
gitgitgadget

