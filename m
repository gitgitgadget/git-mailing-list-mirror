Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B6E9146D45
	for <git@vger.kernel.org>; Sat, 18 Oct 2025 20:07:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760818047; cv=none; b=DEXaxlYn09MAZeijPW7ch77g8WjE2biRBKTkz+tqxtKTa/n4aEWUb+wQqmG3xqN5oSPImflN9uTOw8Zv0BbePha+NPD9HyHqB7fEpg14KH6WgVuz8+32RYehgpZOYkWI+Uc9Nlo1fQa90+2ip0C7M/1YrIrHVntES1eS/3rl7jw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760818047; c=relaxed/simple;
	bh=eyrA+df9ahAxCYweR1s4GfmDYf0w1KmNF7naJK3siPs=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=bvA0vH8I9Knt9klVGkbxm6Qir7Nx7lYFyXdGzXsW+oupCCMJwFiPtPKYqnj8NYG7DjN+XEtjybCM8eoiFwM9XW2DOAWoe1apHJU9W7B6Vzed2Y8It/Zxkp6vCvfdxSN4hexSLydNfzN7O50ySQQB4d9zDpGZ5jK6EIXmwuppPaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ewXJt7Ll; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ewXJt7Ll"
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-78af743c232so2615948b3a.1
        for <git@vger.kernel.org>; Sat, 18 Oct 2025 13:07:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760818044; x=1761422844; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AsQFNfg+upSmNiEurQZoZiYasTODTx43yZtS1ofCJYc=;
        b=ewXJt7LlLXVBVUkka4rjGkxEyfyBzk/msD71C7gA7/dMjy6eWDzW/TQ7NEaACq3rQc
         /rV5j+dkZ6bO+U27AroRqi9vtcJ6ABxv+ekWkjXcat7IPByhobdcchaVEwY5BqEfN9BW
         EKw/PWP3RKhlfWEmCTO6gP3M0c06eEM5X0HzVWLnRGJ3BznqNR/vbcrbGlsb0QoiKb8B
         Djh4nEs7OY51X3HJVxTAzUaoS30Sn90sjTQnohxhJzDjRuDynDNXf12iBjP2XcUGI1kO
         5mA7pEgeesY9aA5irs1oBRyx3wTEx3zcbFAwZg8eytibqPH0BndhpOjGG+k0nxbkoxXX
         7rsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760818044; x=1761422844;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AsQFNfg+upSmNiEurQZoZiYasTODTx43yZtS1ofCJYc=;
        b=Y99zeffqd/nfSYJEayqmPKNWzYRpjltNsoX8R4lpiy9mksqRTI8Bjh7mg/Era+BArP
         UMUvj8lsf0J54UCVxxD9UN8VL20DAv0TobKHqVZ9VnE0TgQe2OWqWSvxyGW5ui4KL5oR
         Vk1eefyNJdxP8MozBbhl7BRS2L/6VmgqXZXvolSG8EtEgqaO7jUQ6aRlgeYr+gUOpEuI
         kgam6rayP4u3fFr5h/D3KsfgTlJj6Ljawslhcj7mMfZxWV5vl0FKglMrEmNWlgqJyXWL
         ctvtaDZNx9BeidBUBP/hGnsRCCPWVgWZovjdS+aNqmLNtNbBIfmdRW2WUfK0ZIBNj4bA
         w4CA==
X-Gm-Message-State: AOJu0YyD6hjBMrnYrRHC63rNv/ocGKG/J1sPHOL91CmX7ozmBmJ6lGJc
	PM9p4vcVPJ/YwWAfm8vyKNv034V9NUTIO4jB7ZrS706QHGdenKbUgXSRGZk7vQ02
X-Gm-Gg: ASbGncsizYb7dhSqAc5GmXa4EUOeNpVyeRlgXVc0RCJD6RkZUv52jzITcx4UaCNrAMu
	77baWcrbph8uyR/cMwCMiuj4GQTffrwjCLIn0JCqgmaCQT4Q+WnImML26RETnTwFPCyHUT98V64
	6qFbeZcr8hE8lmx3V0gcl/zMCHKJCBtRFgHOyClLbZhOJUkqOOJHF14E8F4fmAlR/I7oa0THWaL
	KheH1ycBZDJO2c56f4JSPF/i3C53jcxa0KjiwlFMw/3pMBnxMlHBOSzFtDXkhkRSbPQrlq6PUTC
	zjvjKTclSgMk6QeGXVExj0bx0ctFc1WGwQtkA+UsdNwCFUfnxwmSqGT2SFgJj7NMRLePPnUMcEJ
	epiKd8xmO/V9jf9v5TEF1yibP6Ui+BFIbf54iJ8FgXIwRoog3zVwV1FSeEPFUSjQSXSiMEsFnFw
	Zqu7mHGLkOTAqtGn/KlcJ44ckK
X-Google-Smtp-Source: AGHT+IHGQhjk+3Opz7wBNoOY/ZYYHY1dyyYH7f40mvz1y2lilFef8vAo+n5D0I5aOLMLzKcY/eSwhA==
X-Received: by 2002:a17:90b:2692:b0:335:228c:6f1f with SMTP id 98e67ed59e1d1-33bcf874769mr11988464a91.12.1760818044245;
        Sat, 18 Oct 2025 13:07:24 -0700 (PDT)
Received: from [127.0.0.1] ([172.184.211.85])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b6a779d704dsm3213422a12.24.2025.10.18.13.07.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Oct 2025 13:07:23 -0700 (PDT)
Message-Id: <8f3d5f7ec12d788eec99b962fed1c8d62e17c148.1760818039.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1987.git.1760818039.gitgitgadget@gmail.com>
References: <pull.1987.git.1760818039.gitgitgadget@gmail.com>
From: "Claus Schneider(Eficode) via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sat, 18 Oct 2025 20:07:17 +0000
Subject: [PATCH 3/5] tests: add new t2206-add-submodule-ignored.sh to test
 ignore=all scenario
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
    Brandon Williams <bmwill@google.com>,
    Claus Schneider <claus.schneider@eficode.com>,
    "Claus Schneider(Eficode)" <claus.schneider@eficode.com>

From: "Claus Schneider(Eficode)" <claus.schneider@eficode.com>

The tests verify that the submodule behavior is intact and updating the
config with ignore=all also behaves as intended with configuration in
.gitmodules and configuration given on the command line.

Testfile is added to meson.build for execution.

Signed-off-by: Claus Schneider(Eficode) <claus.schneider@eficode.com>
---
 t/meson.build                    |   1 +
 t/t2206-add-submodule-ignored.sh | 134 +++++++++++++++++++++++++++++++
 2 files changed, 135 insertions(+)
 create mode 100755 t/t2206-add-submodule-ignored.sh

diff --git a/t/meson.build b/t/meson.build
index bbeba1a8d5..1a6fb7edb2 100644
--- a/t/meson.build
+++ b/t/meson.build
@@ -281,6 +281,7 @@ integration_tests = [
   't2203-add-intent.sh',
   't2204-add-ignored.sh',
   't2205-add-worktree-config.sh',
+  't2206-add-submodule-ignored.sh',
   't2300-cd-to-toplevel.sh',
   't2400-worktree-add.sh',
   't2401-worktree-prune.sh',
diff --git a/t/t2206-add-submodule-ignored.sh b/t/t2206-add-submodule-ignored.sh
new file mode 100755
index 0000000000..77f7b0ebbc
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
+	GIT_TRACE=1 git add sub | grep "Skipping submodule due to ignore=all: sub" &&
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

