Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8E5A313E32
	for <git@vger.kernel.org>; Wed, 24 Dec 2025 10:38:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766572726; cv=none; b=BlTM50CsJpd8opEB3Y8idrtNkFx49478xzjTRcheBED9XN9kac+ODdWGkHwlrdB7UTpQ0qFw1Jra9X64izJatQo78Vn3jMqv4F44gv6ACmpUyAkkC+SP84lCrdpJZPcVWxZhHRg03NDcFkOBTuvUUjDAMX9PJWY15XbRlyu8rGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766572726; c=relaxed/simple;
	bh=AjcIJguNRDGwbcKor1Nun026sfv+tB7ADGL0TVgjTCo=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=DhJD/Ddl9a1bGFvdjhxjoT2S21Dw3Ew+bsWokrzRwPldpO2yLa9E2KhtJeO4iewidjiAESN9u5zxaBH9YskjLQfG94XuGKn+imRtBJmO1kSGwtRTG8LoVhA3jMn+dDvFfrEU2eSz2SDCQqtboCGbA39KOdnLyHHkQ11rG5+gktQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L9w+uG/C; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L9w+uG/C"
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-4eda6c385c0so44863811cf.3
        for <git@vger.kernel.org>; Wed, 24 Dec 2025 02:38:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766572723; x=1767177523; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9V9dXP1fRmJd6WfKY67avG2LEnisbGdMa//eiMhVOTQ=;
        b=L9w+uG/Cn/9jImxd71EM4tFBfxfhMv1UX8AP/9vcfKuhIXJ+FvX04x0Gdjz29hDCtD
         TaJDvAXp4dkOS41uCzdUXkAbw7/C+jpaffz0kKZXs8jDfFGLNkt4Kqk1nk8OqAlWzSzp
         P7pjHen3YvxS7SdGuumibd8hpTB76YXeYCfCkTNy/mO+TAqnINYajV6eMuZCXM0EoOo/
         XqBFKHts7nH28EX5vlrtrDwsctq+aOytf/ulsy9BbxMA1iapEwlIZbFYPCQr3llykI4w
         A26XNozigbRggoKSAa2/M/ynsGqXO6aLzOpm28P9ESGTZZWoReQw7Cb3HLc/K3UeQSmR
         4oHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766572723; x=1767177523;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=9V9dXP1fRmJd6WfKY67avG2LEnisbGdMa//eiMhVOTQ=;
        b=LK/qi5tOG/07aNvB8p/0hsBoUJwd3CefQuf4tIhFlQVb7lQoa2xCJtrZ+NkKjASiNc
         uHpcE5VGakkaDmFd67SG4E8Jq/F8Na8AYAta9w1bdV51NsTmvaMeHVZ+YEETxjXEIm1h
         9oIPciuWQOjiZ1ITpOklq8T5h6YMk861O5fwDjBVmB1DRgdLP+FhlLYQAvz5W22Qgh1o
         Vl67zbOvgmDOjdGTNf1/eK/dvb83nzcvndjMYXVvxKKHISNJYsXRGNVMN98GFqxuZkra
         3Q8ZuLMeF6YM1VqgPXkir6kxrhDUxrvVFQPBsU1tN7gGx71cnmm/Y/ifFR1yq/uyLU5s
         8uQg==
X-Gm-Message-State: AOJu0YxZ3dlHCA+IAm4RRfmGwmVnbQ+qn8vX+W7HZm3dahTaWFsEHGhu
	1X4bOkDtsTyvC9BeVIV52fZYtlpFKe2qSVhqiC1dHiTopi4gro4QeknfRFnNxGLQ
X-Gm-Gg: AY/fxX5oFBHQDIiZz8Nd4TlrNhuUEag8kO5ykZYL0xbFswlPqktWxq+YrvhWq8D8pwV
	fIOcyvBUJc7BnIPLxszy73kswAkzqhz051HMd3nQz1kP99kube6qGBUPg0Po4hBMgHEYX++hgWm
	N0Wcz3kyUbguk+Y2Oy/60turGs0BSDEgtax7jFod/OoJwaySIUKaA2tzIhgqHnbs5uJiT+JfpxX
	R6OcUUysp9RKQ7VKSI3cHf5iMX0/ky/mxhR3YvTewucM8+bMl0CA1eg6VrvkFU8jB/K9/DowIgL
	er5PqWGdKXv+51DmbIAAlGwYprHJkcZSDHoyjQ2keQ8KBvQtj+O2u67Kt44lZJYMVEM+hXod0FI
	biunvShWwEpyarDHdSdWhhYZnGwQtZCBEkzzrdno4qmIQcZGRn2FYhHabkuY9+BzUJcKBKGXxMZ
	I/wLLntSpRSTNg
X-Google-Smtp-Source: AGHT+IGDL+jwd9V67TUwiNuPpXNMYzd7/OsE+Rz6dBng9ltD/unYg7QWM+0YzHzV0ycgq+9TpBVclA==
X-Received: by 2002:a05:622a:2515:b0:4f0:2f0c:e91d with SMTP id d75a77b69052e-4f4abddbf29mr253672611cf.73.1766572723327;
        Wed, 24 Dec 2025 02:38:43 -0800 (PST)
Received: from [127.0.0.1] ([64.236.153.98])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4f4ac54adb9sm116830901cf.10.2025.12.24.02.38.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Dec 2025 02:38:42 -0800 (PST)
Message-Id: <441678939f30ba6cc07e7e8d4a41c72d0fd7427f.1766572715.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2138.v5.git.git.1766572715.gitgitgadget@gmail.com>
References: <pull.2138.v4.git.git.1766571587.gitgitgadget@gmail.com>
	<pull.2138.v5.git.git.1766572715.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 24 Dec 2025 10:38:35 +0000
Subject: [PATCH v5 5/5] Add warning for malformed statusGoalBranch config
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
Cc: Harald Nordgren <haraldnordgren@gmail.com>,
    Harald Nordgren <haraldnordgren@gmail.com>

From: Harald Nordgren <haraldnordgren@gmail.com>

Warn when repo.settings.statusGoalBranch has invalid format
and skip the goal branch comparison. Also update test to
compare full checkout output instead of grepping.

Signed-off-by: Harald Nordgren <haraldnordgren@gmail.com>
---
 t/t6040-tracking-info.sh | 49 +++++++++++++++++++++++++++++-----------
 1 file changed, 36 insertions(+), 13 deletions(-)

diff --git a/t/t6040-tracking-info.sh b/t/t6040-tracking-info.sh
index 00dadc03e7..598dd89483 100755
--- a/t/t6040-tracking-info.sh
+++ b/t/t6040-tracking-info.sh
@@ -310,7 +310,7 @@ test_expect_success 'status shows ahead of both tracked branch and origin/main'
 		cd test &&
 		git checkout work >/dev/null &&
 		git config repo.settings.statusGoalBranch origin/main &&
-		git status --long -b | head -5
+		git status --long -b
 	) >actual &&
 	cat >expect <<-\EOF &&
 On branch work
@@ -318,6 +318,8 @@ Your branch is ahead of '\''origin/feature'\'' by 2 commits.
   (use "git push" to publish your local commits)
 
 Ahead of '\''origin/main'\'' by 3 commits.
+
+nothing to commit, working tree clean
 EOF
 	test_cmp expect actual
 '
@@ -327,11 +329,13 @@ test_expect_success 'checkout shows ahead of both tracked branch and origin/main
 		cd test &&
 		git checkout main >/dev/null &&
 		git config repo.settings.statusGoalBranch origin/main &&
-		git checkout work 2>&1 | grep -E "(Switched|Your branch|Ahead of)" | head -3
+		git checkout work 2>&1
 	) >actual &&
 	cat >expect <<-\EOF &&
 Switched to branch '\''work'\''
 Your branch is ahead of '\''origin/feature'\'' by 2 commits.
+  (use "git push" to publish your local commits)
+
 Ahead of '\''origin/main'\'' by 3 commits.
 EOF
 	test_cmp expect actual
@@ -367,7 +371,7 @@ test_expect_success 'status shows ahead of tracked and diverged from origin/main
 		cd test &&
 		git checkout work2 >/dev/null &&
 		git config repo.settings.statusGoalBranch origin/main &&
-		git status --long -b | head -5
+		git status --long -b
 	) >actual &&
 	cat >expect <<-\EOF &&
 On branch work2
@@ -375,6 +379,8 @@ Your branch is ahead of '\''origin/oldfeature'\'' by 1 commit.
   (use "git push" to publish your local commits)
 
 Diverged from '\''origin/main'\'' by 3 commits.
+
+nothing to commit, working tree clean
 EOF
 	test_cmp expect actual
 '
@@ -397,7 +403,7 @@ test_expect_success 'status shows diverged from tracked and behind origin/main'
 		cd test &&
 		git checkout work2b >/dev/null &&
 		git config repo.settings.statusGoalBranch origin/main &&
-		git status --long -b | head -6
+		git status --long -b
 	) >actual &&
 	cat >expect <<-\EOF &&
 On branch work2b
@@ -406,6 +412,8 @@ and have 1 and 1 different commits each, respectively.
   (use "git pull" if you want to integrate the remote branch with yours)
 
 Behind '\''origin/main'\'' by 1 commit.
+
+nothing to commit, working tree clean
 EOF
 	test_cmp expect actual
 '
@@ -430,7 +438,7 @@ test_expect_success 'status shows behind tracked and ahead of origin/main' '
 		cd test &&
 		git checkout work3 >/dev/null &&
 		git config repo.settings.statusGoalBranch origin/main &&
-		git status --long -b | head -5
+		git status --long -b
 	) >actual &&
 	cat >expect <<-\EOF &&
 On branch work3
@@ -438,6 +446,8 @@ Your branch is behind '\''origin/feature3'\'' by 2 commits, and can be fast-forw
   (use "git pull" to update your local branch)
 
 Ahead of '\''origin/main'\'' by 1 commit.
+
+nothing to commit, working tree clean
 EOF
 	test_cmp expect actual
 '
@@ -456,7 +466,7 @@ test_expect_success 'status prefers upstream remote over origin for comparison'
 		cd test &&
 		git checkout work >/dev/null &&
 		git config repo.settings.statusGoalBranch upstream/main &&
-		git status --long -b | head -5
+		git status --long -b
 	) >actual &&
 	cat >expect <<-\EOF &&
 On branch work
@@ -464,6 +474,8 @@ Your branch is ahead of '\''origin/feature'\'' by 2 commits.
   (use "git push" to publish your local commits)
 
 Diverged from '\''upstream/main'\'' by 5 commits.
+
+nothing to commit, working tree clean
 EOF
 	test_cmp expect actual
 '
@@ -484,13 +496,15 @@ test_expect_success 'status shows up to date with tracked but diverged from defa
 		cd test &&
 		git checkout synced_feature >/dev/null &&
 		git config repo.settings.statusGoalBranch upstream/main &&
-		git status --long -b | head -4
+		git status --long -b
 	) >actual &&
 	cat >expect <<-\EOF &&
 On branch synced_feature
 Your branch is up to date with '\''origin/feature'\''.
 
 Diverged from '\''upstream/main'\'' by 3 commits.
+
+nothing to commit, working tree clean
 EOF
 	test_cmp expect actual
 '
@@ -512,13 +526,15 @@ test_expect_success 'status shows up to date with tracked but diverged from orig
 		cd test &&
 		git checkout synced_feature2 >/dev/null &&
 		git config repo.settings.statusGoalBranch origin/main &&
-		git status --long -b | head -4
+		git status --long -b
 	) >actual &&
 	cat >expect <<-\EOF &&
 On branch synced_feature2
 Your branch is up to date with '\''origin/feature'\''.
 
 Diverged from '\''origin/main'\'' by 5 commits.
+
+nothing to commit, working tree clean
 EOF
 	test_cmp expect actual
 '
@@ -536,13 +552,15 @@ test_expect_success 'status shows up to date with tracked but shows default bran
 		cd test &&
 		git checkout synced_feature3 >/dev/null &&
 		git config repo.settings.statusGoalBranch origin/main &&
-		git status --long -b | head -4
+		git status --long -b
 	) >actual &&
 	cat >expect <<-\EOF &&
 On branch synced_feature3
 Your branch is up to date with '\''origin/feature'\''.
 
 Diverged from '\''origin/main'\'' by 5 commits.
+
+nothing to commit, working tree clean
 EOF
 	test_cmp expect actual
 '
@@ -552,12 +570,13 @@ test_expect_success 'status with repo.settings.statusGoalBranch unset shows no d
 		cd test &&
 		git checkout synced_feature3 >/dev/null &&
 		git config --unset repo.settings.statusGoalBranch 2>/dev/null || true &&
-		git status --long -b | head -3
+		git status --long -b
 	) >actual &&
 	cat >expect <<-\EOF &&
 On branch synced_feature3
 Your branch is up to date with '\''origin/feature'\''.
 
+nothing to commit, working tree clean
 EOF
 	test_cmp expect actual
 '
@@ -567,13 +586,15 @@ test_expect_success 'status with repo.settings.statusGoalBranch set uses configu
 		cd test &&
 		git checkout synced_feature3 >/dev/null &&
 		git config repo.settings.statusGoalBranch origin/main &&
-		git status --long -b | head -4
+		git status --long -b
 	) >actual &&
 	cat >expect <<-\EOF &&
 On branch synced_feature3
 Your branch is up to date with '\''origin/feature'\''.
 
 Diverged from '\''origin/main'\'' by 5 commits.
+
+nothing to commit, working tree clean
 EOF
 	test_cmp expect actual
 '
@@ -583,13 +604,14 @@ test_expect_success 'status with repo.settings.statusGoalBranch set to different
 		cd test &&
 		git checkout work >/dev/null &&
 		git config repo.settings.statusGoalBranch origin/feature &&
-		git status --long -b | head -4
+		git status --long -b
 	) >actual &&
 	cat >expect <<-\EOF &&
 On branch work
 Your branch is ahead of '\''origin/feature'\'' by 2 commits.
   (use "git push" to publish your local commits)
 
+nothing to commit, working tree clean
 EOF
 	test_cmp expect actual
 '
@@ -599,12 +621,13 @@ test_expect_success 'status with repo.settings.statusGoalBranch set to non-exist
 		cd test &&
 		git checkout synced_feature3 >/dev/null &&
 		git config repo.settings.statusGoalBranch origin/nonexistent &&
-		git status --long -b | head -3
+		git status --long -b
 	) >actual &&
 	cat >expect <<-\EOF &&
 On branch synced_feature3
 Your branch is up to date with '\''origin/feature'\''.
 
+nothing to commit, working tree clean
 EOF
 	test_cmp expect actual
 '
-- 
gitgitgadget
