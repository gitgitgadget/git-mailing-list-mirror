Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 606CE305E00
	for <git@vger.kernel.org>; Mon,  1 Dec 2025 16:50:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764607857; cv=none; b=O5JvqKgFJWQ2+bhlFDwLQUx7uWheTZi7+FVUvunayfbLk4SlkN3V6ntQ5RimEUpajy8Qh0ooZVGXxMkBucCZdeozjKrmipJAm2UjIor9GW5HeWWWoWJ76FseU+54itYBPFoe9iBTv0QGwO7Pn1567+t8fnbHY/zep25Bzsz5J2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764607857; c=relaxed/simple;
	bh=nUXSr8W5pUpDZE2Mm34Lu3pPn8iojULub80vW5tV0G8=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=c1vb3uZIf6rh/xAA9OMAZ6FE94XiIOESaykkkT1RTRlv3erXIwaPIYyE8SvEQczDSjr0nMjxvh6lmslItqpxm30osQpJV++qN4gEZYGeVwRPoCjGYRCpqZbfhkE5qmWs4fCdqViB+aURbBA7T6eq0Z0Plw+kVeehQKJKgkI+1Qg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X7VriTR+; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X7VriTR+"
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-7b9a98b751eso3131197b3a.1
        for <git@vger.kernel.org>; Mon, 01 Dec 2025 08:50:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764607854; x=1765212654; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oqZy2Yw7miqx1pTF6YfEi2mMtPUXUSI5g/qqNybqexg=;
        b=X7VriTR+i03V46pWAU+8v+0MmA99K1ut6gJWiC+NkyjGUg9NH5Tmb/x94WMxyxS3up
         Ghx0kryiR65WWoC0XNZSUxg1NBl7iQdbS3m3FL6vcINDea8mI6LduIlD52nP/y59lswe
         x3UUYdlV1W8oQsRt5BkuMKDMq8xCTNGzp7lL+4rN9QgTbV06ieCgjFCMFKDBGbfGUF0a
         b9w7iaNZUam92AFQZ1tq5wyTA1JgLiWNR9f9ehnIR6ZtNZ9fX2fl6xQwJz1Os1KEAZMM
         eu3LpmdWaiAfhJgNmXPDXVW73CzkDrPu3eQuMvnUqrvSUMJRQ+i53dZ6nicdoOXTXWGh
         s62w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764607854; x=1765212654;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=oqZy2Yw7miqx1pTF6YfEi2mMtPUXUSI5g/qqNybqexg=;
        b=J6O6ZZniicMdmbey0PHPNYx5ELJHqFoeBEezDH8zRnymcDu/zvJC8rZSLF+E1PQT4p
         G8BsoQ/LG7NjwQVDU/l9pBlxqLM6aLx9aMwYfbV2kLq2Kwe2F2f6T4POdAxcncOJTIvt
         Lp65Yv1lOYk+sbp/RPz4nWin6ytNsH2/kC04j8uKoKM8b3hvA22+/ktuvr7Fh5zcxoYk
         jyNrxZLe5UbKskBspxkwjSPc+kbQ4UKKwjpLhz3urcJ7u/QYvcbvEUnBRQkSQXRpSjob
         C+dd2LNqOz2huezuWYXTzDCJQG7sLCMcLk9JfN72i/RmdwsOFoZrkElpwLkZNK/quqxw
         Yb2w==
X-Gm-Message-State: AOJu0Yy1t22Gi8aCrgz9wLMftbys/SjBxBO4StZgOHe7zmPqr4zzj+P2
	zL0yHuuSVfLCtK39RmjVS/Nbbn43YW0uStHSLZkUQBfr0zwL1Okhc0GgIBB3+/1X
X-Gm-Gg: ASbGnctHT3hWNId2AylzsINl4Y1x7FyWyZFU9GYEXkc5SKpsVPed7+Cn2aPZqzXk70W
	vh1hchkwgN9VpTnu+b8Ww5bDv/Y2uHSV85vcu4WIwbeAXo4o6I17LcKsxavKWCqh/6LY1w/jsHO
	eVqPFjL67xD7g9FZXI6B8y+Vn+wNfwg61A7ehawUl2QU/PR5ijNwiTHk3PNoy6KBcV/+3c79zFK
	HmgogruZ8AeYHFZMjUUX44R5NDGSeFTc4gdu0RSyJ0Y51u372ZOT6WGNmTLNKQQ5IZJVjiSVBEe
	/VuG+hryarnS/2b8quhvVmRFbZpzl2Bacy6wmXQcEX0XoNCa0kIZoX3HQ0XwToJhf1h8oskYiHE
	DKB0zyriVtU0NhnXtgMEA9CLyZkgJ2mUu44ZVNZnxQxLUa8N8kyeoMXatjuBK7BICCVwM1v63e+
	vZHcbFuyVIR8u1Pw==
X-Google-Smtp-Source: AGHT+IE57UwpxI3GDt1rxY/JZufMCwoS2GyLWUiMpvkVcZZdxaEDikRdAP8seMwj+egqz+FD4HFbQw==
X-Received: by 2002:a05:6a20:244f:b0:343:72ff:af80 with SMTP id adf61e73a8af0-3637e0d4931mr29004824637.58.1764607853737;
        Mon, 01 Dec 2025 08:50:53 -0800 (PST)
Received: from [127.0.0.1] ([20.168.106.240])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-be508bfd8ffsm12571368a12.17.2025.12.01.08.50.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Dec 2025 08:50:52 -0800 (PST)
Message-Id: <8783db6153875deb52aaa354da189ae611de1057.1764607847.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2010.v2.git.1764607847.gitgitgadget@gmail.com>
References: <pull.2010.git.1764195516.gitgitgadget@gmail.com>
	<pull.2010.v2.git.1764607847.gitgitgadget@gmail.com>
From: "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 01 Dec 2025 16:50:45 +0000
Subject: [PATCH v2 3/5] scalar: remove stale config values
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
Cc: gitster@pobox.com,
    ps@pks.im,
    atthewhughes934@gmail.com,
    johannes.schindelin@gmx.de,
    Derrick Stolee <stolee@gmail.com>,
    Derrick Stolee <stolee@gmail.com>

From: Derrick Stolee <stolee@gmail.com>

These config values were added in the original Scalar contribution,
d0feac4e8c (scalar: 'register' sets recommended config and starts
maintenance, 2021-12-03), but were never fully checked for validity in
the upstream Git project. At the time, Scalar was only intended for the
contrib/ directory so did not have as rigorous of an investigation.

Each config option has its own justification for removal:

* core.preloadIndex: This value is true by default, now. Removing this
  causes some changes required to the tests that checked this config
  value. Use gui.gcwarning=false instead.

* core.fscache: This config does not exist in the core Git project, but
  is instead a config option for a Git for Windows feature.

* core.multiPackIndex: This config value is now enabled by default, so
  does not need to be called out specifically. It was originally
  included to make sure the background maintenance that created
  multi-pack-indexes would result in the expected performance
  improvements.

* credential.validate: This option is not something specific to Git but
  instead an older version of Git Credential Manager for Windows. That
  software was replaced several years ago by the cross-platform Git
  Credential Manger so this option is no longer needed to help users who
  were on that older software.

* pack.useSparse=true: This value is now Git's default as of de3a864114
  (config: set pack.useSparse=true by default, 2020-03-20) so we don't
  need it set by Scalar.

Signed-off-by: Derrick Stolee <stolee@gmail.com>
---
 scalar.c          |  5 -----
 t/t9210-scalar.sh | 20 ++++++++++----------
 2 files changed, 10 insertions(+), 15 deletions(-)

diff --git a/scalar.c b/scalar.c
index 1cb8ce3723..5fef9a4104 100644
--- a/scalar.c
+++ b/scalar.c
@@ -135,9 +135,6 @@ static int set_recommended_config(int reconfigure)
 	struct scalar_config config[] = {
 		/* Required */
 		{ "am.keepCR", "true", 1 },
-		{ "core.FSCache", "true", 1 },
-		{ "core.multiPackIndex", "true", 1 },
-		{ "core.preloadIndex", "true", 1 },
 #ifndef WIN32
 		{ "core.untrackedCache", "true", 1 },
 #else
@@ -157,7 +154,6 @@ static int set_recommended_config(int reconfigure)
 #endif
 		{ "core.logAllRefUpdates", "true", 1 },
 		{ "credential.https://dev.azure.com.useHttpPath", "true", 1 },
-		{ "credential.validate", "false", 1 }, /* GCM4W-only */
 		{ "gc.auto", "0", 1 },
 		{ "gui.GCWarning", "false", 1 },
 		{ "index.skipHash", "true", 1 },
@@ -166,7 +162,6 @@ static int set_recommended_config(int reconfigure)
 		{ "merge.stat", "false", 1 },
 		{ "merge.renames", "true", 1 },
 		{ "pack.useBitmaps", "false", 1 },
-		{ "pack.useSparse", "true", 1 },
 		{ "receive.autoGC", "false", 1 },
 		{ "feature.manyFiles", "false", 1 },
 		{ "feature.experimental", "false", 1 },
diff --git a/t/t9210-scalar.sh b/t/t9210-scalar.sh
index 923c243c13..009437a5f3 100755
--- a/t/t9210-scalar.sh
+++ b/t/t9210-scalar.sh
@@ -202,15 +202,15 @@ test_expect_success 'scalar clone --no-... opts' '
 test_expect_success 'scalar reconfigure' '
 	git init one/src &&
 	scalar register one &&
-	git -C one/src config core.preloadIndex false &&
+	git -C one/src config unset gui.gcwarning &&
 	scalar reconfigure one &&
-	test true = "$(git -C one/src config core.preloadIndex)" &&
-	git -C one/src config core.preloadIndex false &&
+	test false = "$(git -C one/src config gui.gcwarning)" &&
+	git -C one/src config unset gui.gcwarning &&
 	rm one/src/cron.txt &&
 	GIT_TRACE2_EVENT="$(pwd)/reconfigure" scalar reconfigure -a &&
 	test_path_is_file one/src/cron.txt &&
-	test true = "$(git -C one/src config core.preloadIndex)" &&
-	test_grep "preloadIndex = true # set by scalar" one/src/.git/config &&
+	test false = "$(git -C one/src config gui.gcwarning)" &&
+	test_grep "GCWarning = false # set by scalar" one/src/.git/config &&
 	test_grep "excludeDecoration = refs/prefetch/\* # set by scalar" one/src/.git/config &&
 
 	test_subcommand git maintenance start <reconfigure &&
@@ -234,14 +234,14 @@ test_expect_success 'scalar reconfigure --all with includeIf.onbranch' '
 		git init $num/src &&
 		scalar register $num/src &&
 		git -C $num/src config includeif."onbranch:foo".path something &&
-		git -C $num/src config core.preloadIndex false || return 1
+		git -C $num/src config unset gui.gcwarning || return 1
 	done &&
 
 	scalar reconfigure --all &&
 
 	for num in $repos
 	do
-		test true = "$(git -C $num/src config core.preloadIndex)" || return 1
+		test false = "$(git -C $num/src config gui.gcwarning)" || return 1
 	done
 '
 
@@ -256,7 +256,7 @@ test_expect_success 'scalar reconfigure --all with detached HEADs' '
 		rm -rf $num/src &&
 		git init $num/src &&
 		scalar register $num/src &&
-		git -C $num/src config core.preloadIndex false &&
+		git -C $num/src config unset gui.gcwarning &&
 		test_commit -C $num/src initial &&
 		git -C $num/src switch --detach HEAD || return 1
 	done &&
@@ -265,7 +265,7 @@ test_expect_success 'scalar reconfigure --all with detached HEADs' '
 
 	for num in $repos
 	do
-		test true = "$(git -C $num/src config core.preloadIndex)" || return 1
+		test false = "$(git -C $num/src config gui.gcwarning)" || return 1
 	done
 '
 
@@ -297,7 +297,7 @@ test_expect_success 'scalar supports -c/-C' '
 	git init sub &&
 	scalar -C sub -c status.aheadBehind=bogus register &&
 	test -z "$(git -C sub config --local status.aheadBehind)" &&
-	test true = "$(git -C sub config core.preloadIndex)"
+	test false = "$(git -C sub config gui.gcwarning)"
 '
 
 test_expect_success '`scalar [...] <dir>` errors out when dir is missing' '
-- 
gitgitgadget

