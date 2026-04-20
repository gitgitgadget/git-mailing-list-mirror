Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 926CC35F182
	for <git@vger.kernel.org>; Mon, 20 Apr 2026 14:03:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776693809; cv=none; b=IPWRVaFsbyB9DZNIID0kytwtqtTxSgSB4SF1r1aR5EFT75SgyTI+Y6Q2bUSjgdaKhuBwvTwStFxfKVvYszVppqMugYsufgLixCR+LmPcVMIosmV/inRpr2VhzaF4v5jkR7WOcbyUpNaZPDXbhyHFQLH+kRtWbA1HXyGeLNpECH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776693809; c=relaxed/simple;
	bh=2sIOwMkLw59eQC1qGqDc50zkrKlyUyI7Gxlzw4VaztI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=VIrA4hDwsCnkAQV0MEhBKq8v8ZAguGlxOfRiGA55Iy+As9uis+1/pKcoHrtpI7ZT5afuI6PnI1pZY5y75nLdV0SGTdBxGEh/4XXfAkNFgyy/3CtZ0MyN31KYyTOWUxHCqfkvbeau0levL56FqmfbUI0pC0YWGwlf1Hdp9dpZL0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sQCTUSiw; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sQCTUSiw"
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-43d6fbd0954so2619113f8f.1
        for <git@vger.kernel.org>; Mon, 20 Apr 2026 07:03:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776693806; x=1777298606; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=sh7ZJ9hIeg1icCwDd9e2lkip5jttaRznYE12xObKSXw=;
        b=sQCTUSiwRjaeS+YV6ZWsNpUOkEOs/etXUSWqhigad+bJ4RT1z9OVePx9W3ovwdFquD
         uhVpadCGJ2wxLYlA6gAdr9uXIbKWGh8p7xU8ztxK9pTy1uGmGGpyvrbONB/Og+PYufop
         hTb8y+9i80hHXZ03Vex3uKXrCCjMtp1L0iL0FOSIgd0QR4ol8sj6bLN9j3A8QJyu9fvX
         EVZQG40y6w2gyRfk0mDrtQddBxnC0+abmHxUjmiSCaqr3vNw0upy4HrFtKdkwLYKOWDi
         2JIuZ6Z2GLlOkKCp5A47zHPjoejDnvcy3rw0sERe0PGy+ZDh4EEmi4T6G+vVlb0DX+EY
         BI4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776693806; x=1777298606;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sh7ZJ9hIeg1icCwDd9e2lkip5jttaRznYE12xObKSXw=;
        b=R/KlhqpuHW8zuVFvXXD5DwTic9Zab/i9eXcguLWdgwaZXWY2JMu8LIDMS5kntM7uHR
         lMFL3TrvmQlDnJZcwl51nu9B2noHiRZ/3V0KCP3I+jntN34JBOMI2xpUImNTt2FId8xV
         jj4UP97306j4iw7IvzhNDVLoEX578uVsjFsNtaLSyUm2aWPfSQzC3xI3RvTjdYPO14o7
         00TXYfyBofOUBRWxdmG5gbXoDCVdCmywr5sLJ++72Cv2dZaAMMb/rezxvNLqF2MhWO+f
         4Mnto/rw4xqv2ZJ3rs8NB5B4e7pKVa3O0MYaxfaX10i4B1ZeSkVgqw/FJ04zz7xLM4XC
         RCcA==
X-Gm-Message-State: AOJu0YxwYPHzF93oNZgRsiRUuRkYk8qXjsuGSRlkzGN/+Sdj0ArALdt5
	yZqautQGGFiYkz8NMXvOMS2HWSIT/2P8taAVUoKxN3/VESaqrWR91X3cGyxc6w==
X-Gm-Gg: AeBDieu8Me8YQ97jEcB3dH+IMdg7Wc+0uyR5Ke78QLLdaDnhvZtva0hSgPvcJAApoXn
	0lenjC+9jSdMVF9GipPNgH0JfCuKwCXDM21SmlAHNkw44EGHoUEdH0HP3aTYuLBB9KDlWACwyc6
	FR9Z3bnD8yDJ/6pGkEtJshxjifHjH4bd5khG0DGM6To7WPmKDO6EgOlzLnscxpOMlRyAM3Wn2/c
	k1BX/v6rpQZMyrNtMy5XNuJohX4oNRDJNdUtAIUT4lIZFHkSJ+0dpa3RdFTE9ScZgKRJgxPhHcE
	2Zl/73aHLKTT2VMwk5160aQ++z6dsabbzPqeoeoqokxyAT8/2wHnAyAUMTSTmIX9ktSCl1Bt21p
	0DjVAiimkhVPv4mZeTVaPSRYWQl1z9g6ku4u6x0hn0wurgk8WNWafI9qBZCcBcukDOqeBG3dPFQ
	FFssbR5PSorKQLYUKBxPOYgV+1Uj+J7vJOFpGOnVE=
X-Received: by 2002:a05:6000:26cf:b0:43d:6787:992f with SMTP id ffacd0b85a97d-43fe3db2d27mr21565139f8f.10.1776693804945;
        Mon, 20 Apr 2026 07:03:24 -0700 (PDT)
Received: from [127.0.0.2] ([2a02:8109:d906:4e00:e8e1:e7a:f864:b8a6])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43fe4e3a381sm32185615f8f.21.2026.04.20.07.03.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Apr 2026 07:03:24 -0700 (PDT)
From: Karthik Nayak <karthik.188@gmail.com>
Date: Mon, 20 Apr 2026 16:03:14 +0200
Subject: [PATCH] refs/files: skip lock files during consistency checks
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260420-refs-fsck-skip-lock-files-v1-1-c2595e206a76@gmail.com>
X-B4-Tracking: v=1; b=H4sIACEy5mkC/yWMQQ6CQAxFr0K6tskwkAl6FeNCSisVAmSqhoRwd
 6ru/kv+exsYZ2WDS7FB5o+azpNDeSqA+vv0YNTOGWKIKdQxYGYxFKMBbdAFx9mX6MiGlOSc2pK
 krhpwf/Grrr/29fZne7dPptc3CPt+AEkt4d99AAAA
X-Change-ID: 20260420-refs-fsck-skip-lock-files-c6f96b1cf438
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=3333; i=karthik.188@gmail.com;
 h=from:subject:message-id; bh=2sIOwMkLw59eQC1qGqDc50zkrKlyUyI7Gxlzw4VaztI=;
 b=owJ4nAHtARL+kA0DAAoBPtWfJI5GjH8ByyZiAGnmMisDvnruVSthIWs5uM4xwcyZciJwdgvEW
 CiEyMOIWKpEO4kBswQAAQoAHRYhBFfOTH9jdXEPy2XGBj7VnySORox/BQJp5jIrAAoJED7VnySO
 Rox/OvcMAIK8CNs7h8t6wuqb8f2Uy7o5W6ahGhZv2mA7TMvAVX3v5hD7sIflycJYNgTySmmTXZb
 XHmqDHaaJY0XVOpVxPmd82pAzLsjPTDw8r7P4OmSyXQtWBJOxxMUPm7yEjgtq11B6rdurV+R8qf
 W2tgP6aOV7tFZbs8/2jHaBmbSVJIxEDQwoU9KTPCR+QP7kNe5wkYjm4+whb9tmmgR3W3g41p7E6
 Badz1AbWF98/VlVsflvYjqVq85tBdcceOTJQkB8KVcv6exbo8r/s9E/o4ORx2V4SwwI2U1PaSY3
 OyVp9bMTXngYR4uedmOr9SGEmjQ6hU6RuvAnABJciouAqG08XnN8rlXZQvx5wxINihazzGD6DnR
 U0II3llTEmJQvl7SBully1+SPVLp44Cb4/DifD6dzI4wxFtQIYpQ3i4B8W73Tb+wCOKzNDBFMrp
 3rsRLKlERBXIAiVJYjvJ8KURKhhIBIz2AR/EZcBjoBbluLVhcS6yiZExi0TokcgOTDCMhiWfWH4
 wY=
X-Developer-Key: i=karthik.188@gmail.com; a=openpgp;
 fpr=57CE4C7F6375710FCB65C6063ED59F248E468C7F

Running consistency checks on the files reference backend involves
iterating over all the existing files in the 'refs/' directory and
running all `files_fsck_ref()` on each of them.

Unfortunately this also includes the '*.lock' files created by the files
backend. While the `files_fsck_refs_name()` check was skipping over such
lock files, all other checks still continue to validate them.

Avoid this situation by moving the check for lock files to a layer above
and skipping all checks when encountering such a file.

Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 refs/files-backend.c     | 22 +++++++++++-----------
 t/t0602-reffiles-fsck.sh | 21 +++++++++++++++++++++
 2 files changed, 32 insertions(+), 11 deletions(-)

diff --git a/refs/files-backend.c b/refs/files-backend.c
index b3b0c25f84..f1bdfbe88e 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -3864,22 +3864,12 @@ static int files_fsck_refs_content(struct ref_store *ref_store,
 static int files_fsck_refs_name(struct ref_store *ref_store UNUSED,
 				struct fsck_options *o,
 				const char *refname,
-				const char *path,
+				const char *path UNUSED,
 				int mode UNUSED)
 {
 	struct strbuf sb = STRBUF_INIT;
-	const char *filename;
 	int ret = 0;
 
-	filename = basename((char *) path);
-
-	/*
-	 * Ignore the files ending with ".lock" as they may be lock files
-	 * However, do not allow bare ".lock" files.
-	 */
-	if (filename[0] != '.' && ends_with(filename, ".lock"))
-		goto cleanup;
-
 	if (is_root_ref(refname))
 		goto cleanup;
 
@@ -3939,6 +3929,7 @@ static int files_fsck_refs_dir(struct ref_store *ref_store,
 	struct strbuf refname = STRBUF_INIT;
 	struct strbuf sb = STRBUF_INIT;
 	struct dir_iterator *iter;
+	const char *filename;
 	int iter_status;
 	int ret = 0;
 
@@ -3962,6 +3953,15 @@ static int files_fsck_refs_dir(struct ref_store *ref_store,
 			strbuf_addf(&refname, "worktrees/%s/", wt->id);
 		strbuf_addf(&refname, "refs/%s", iter->relative_path);
 
+		filename = basename((char *) iter->path.buf);
+
+		/*
+		 * Ignore the files ending with ".lock" as they may be lock files
+		 * However, do not allow bare ".lock" files.
+		 */
+		if (filename[0] != '.' && ends_with(filename, ".lock"))
+			continue;
+
 		if (files_fsck_ref(ref_store, o, refname.buf,
 				   iter->path.buf, iter->st.st_mode) < 0)
 			ret = -1;
diff --git a/t/t0602-reffiles-fsck.sh b/t/t0602-reffiles-fsck.sh
index 3c1f553b81..fc67bee161 100755
--- a/t/t0602-reffiles-fsck.sh
+++ b/t/t0602-reffiles-fsck.sh
@@ -87,6 +87,27 @@ test_expect_success 'ref name should be checked' '
 	)
 '
 
+test_expect_success 'lock files should be ignored' '
+	test_when_finished "rm -rf repo" &&
+	git init repo &&
+	(
+		cd repo &&
+		git commit --allow-empty -m initial &&
+		git checkout -b branch-1 &&
+
+		touch .git/refs/heads/branch-1.lock &&
+		git refs verify 2>err &&
+		test_must_be_empty err &&
+
+		echo "foobar" >.git/refs/heads/branch-2 &&
+		test_must_fail git refs verify 2>err &&
+		cat >expect <<-EOF &&
+		error: refs/heads/branch-2: badRefContent: foobar
+		EOF
+		test_cmp expect err
+	)
+'
+
 test_expect_success 'ref name check should be adapted into fsck messages' '
 	test_when_finished "rm -rf repo" &&
 	git init repo &&



