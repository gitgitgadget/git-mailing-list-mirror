Received: from mail-dy1-f175.google.com (mail-dy1-f175.google.com [74.125.82.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 026D81531C8
	for <git@vger.kernel.org>; Sun,  3 May 2026 10:14:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777803247; cv=none; b=KddI92yRtNUBkWV1rBV0WxOei2lXeoNq76aCqak/zkHMeXy8L4pXoSMQkvNihL1DnY6QYNJmkRZ5P5Aq7xgcGaDklcVBwsk5eB+g3/B3wzJ1aJyOqGwUjjFGR+Wsn0NDozgUbwudnL6NGEGsv1uz2Ru2j+qwFStZ7ruiyCZY0dQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777803247; c=relaxed/simple;
	bh=xByqb/PGoCvIatWRM+pxzJopR4anduwg9At5QMXgNDM=;
	h=Message-Id:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=XgSYk2JqbOtSCY29aRg6g/f3K9TmlR6/mVOzWjey2+VWUHEeIfgpYuagPxdlyCgdZVF2lvcArhqOdAOweqSA1QaaLjwRKpYm3Ryui0lD6YG86avukbxt6auZ2OJde4QovHWIfshXIMo6lkWoCfbVY8OCQ7s8M3JVMQE2yn8DAXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FyPQYx1D; arc=none smtp.client-ip=74.125.82.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FyPQYx1D"
Received: by mail-dy1-f175.google.com with SMTP id 5a478bee46e88-2ef2a1cc06dso2377759eec.0
        for <git@vger.kernel.org>; Sun, 03 May 2026 03:14:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777803245; x=1778408045; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=bbmoeJ2MxCrHok2wbMES4PdrQTXpv6MNsiCCUF/b4/A=;
        b=FyPQYx1DFLCiQ+j9RaWVStXaHcCtHkC058LXGCWQGLD9SofHosRkajsvPSAgUYiR15
         DSW7br8i1yLI6IQMnB4n64WrlMtbioT8gMiErRTsIDk6ttSqT7X5QZ/zcdben/rKrrDn
         KNhfDD2j1tFqcaNQanKEgL2MM6ItpjrixNymFi6BY+2/f4vIJ124FcQjbp87sUl78xKK
         5Dw3K35cOMI0ZZ1fd4IC79GwnVrjTEwgQ8gqmK3ifDGgUVNxfByyD8VzF9w5ffHTj2X1
         DqK+FlTEayP59SrZQBPN1yeWdXzNA+mlDTzSLo9bhZzDwjA2RkXUtQpjyl1d16Dl2gKh
         ImXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777803245; x=1778408045;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bbmoeJ2MxCrHok2wbMES4PdrQTXpv6MNsiCCUF/b4/A=;
        b=Kj3WNGaniRaxKDcR+B8slB5x3MkzbeHEzhgRj26BZWYO2lJnO4Iymo2vxWkSuNnnkH
         XtQscwXP0mGyt3aswwVANi8bEkobq9dW+AtqEzbBqNAi3UjGt6RjG8VWxcR7aa/ZJxuY
         AE1VlFeQLUpNZJf9zk/vQlf3zBD+5Aw5OmqRrnNfCxOUzUzk0Rl9nbDl1xVXly/E4iwG
         7ZN868L12hHz8ivGEO6reHA5ZpNJcV54mz2qyPXlUV/CMLR8qYG2L49miYE66oyDAX59
         6WBinexl9lrgdqMKAXMeTack5qE2MabCm59jVcaFZkqQ8TEtR2pIYWphYpEaqqh8yfFN
         0aTg==
X-Gm-Message-State: AOJu0YyChsSNbTOfYL6i259QyctrTe+uvNHkYj5MIrDr9ymDLW++GKKE
	L6A15/3RltzlTmloIb6u0AyvLC7UqAdHsbwiMuBe/XRIfrU7fnHLTf2yG7GePA==
X-Gm-Gg: AeBDiev9Hscq0Y2eAwjNnfBKsc/HBIfCL7EwAynHV/LtaG7ds/JuGHDEXs7vR3FuxF3
	iDmCCeKxH33TCqLclTXwEWMUzkMxBarmjRzpf7iS9bc9vW+oasZWRXVRGNe73eH840hYQ8BKfBR
	z60ERkRe8OPVGWMkRQA8AeWKW9hbyqwjak97EbhCesWVizSe7b/nzr6ZLUVIMaQR9egRJyXLlIp
	Cygo3z657HuJ44XK8Afl7vOgQEDl4MqUDyUh96/KwXCLtJfJQlzMzoN/C+3nbHkcSgB342yHQN9
	pXvwq3bykda9WQUqMFDWWclMuQuwYRiVOAt5GOO6+sO4FAxBVKinZ2VQ7pDYXccUBlgTZ87wbkK
	4uaa/tIh9wOW3Lxwqul/EyGVIqkamBiuA66uiRxlYU2IkRc7Bf9n/fJEfGQW9MruJu0joHm1DTv
	VhqhDDi0g5EiKMgUP2Nq3X9o1mKy3Vxwnhk8bpZhM=
X-Received: by 2002:a05:693c:2b0d:b0:2c7:2c0b:f33b with SMTP id 5a478bee46e88-2efb9e84999mr2710045eec.20.1777803244338;
        Sun, 03 May 2026 03:14:04 -0700 (PDT)
Received: from [127.0.0.1] ([172.184.174.149])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2ee38e71b61sm11591167eec.12.2026.05.03.03.14.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 May 2026 03:14:03 -0700 (PDT)
Message-Id: <pull.2287.git.git.1777803242592.gitgitgadget@gmail.com>
From: "Saagar Jha via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sun, 03 May 2026 10:14:02 +0000
Subject: [PATCH] submodule-config: fix reading submodule.fetchJobs
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
Cc: Saagar Jha <saagar@saagarjha.com>,
    Saagar Jha <saagar@saagarjha.com>

From: Saagar Jha <saagar@saagarjha.com>

Signed-off-by: Saagar Jha <saagar@saagarjha.com>
---
    submodule-config: fix reading submodule.fetchJobs

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-2287%2Fsaagarjha%2Fmaint-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-2287/saagarjha/maint-v1
Pull-Request: https://github.com/git/git/pull/2287

 submodule-config.c          |  2 +-
 t/t7406-submodule-update.sh | 10 ++++++++++
 2 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/submodule-config.c b/submodule-config.c
index 1f19fe2077..57b190678e 100644
--- a/submodule-config.c
+++ b/submodule-config.c
@@ -1037,5 +1037,5 @@ static int gitmodules_update_clone_config(const char *var, const char *value,
 
 void update_clone_config_from_gitmodules(int *max_jobs)
 {
-	config_from_gitmodules(gitmodules_update_clone_config, the_repository, &max_jobs);
+	config_from_gitmodules(gitmodules_update_clone_config, the_repository, max_jobs);
 }
diff --git a/t/t7406-submodule-update.sh b/t/t7406-submodule-update.sh
index 3adab12091..234a021fb3 100755
--- a/t/t7406-submodule-update.sh
+++ b/t/t7406-submodule-update.sh
@@ -1055,6 +1055,16 @@ test_expect_success 'submodule update can be run in parallel' '
 	)
 '
 
+test_expect_success 'submodule update honors fetch jobs config from .gitmodules' '
+	test_when_finished "rm -rf super3" &&
+	git clone cloned super3 &&
+	(cd super3 &&
+	 git config -f .gitmodules submodule.fetchJobs 67 &&
+	 GIT_TRACE="$(pwd)/trace.out" git submodule update --init &&
+	 grep "67 tasks" trace.out
+	)
+'
+
 test_expect_success 'git clone passes the parallel jobs config on to submodules' '
 	test_when_finished "rm -rf super4" &&
 	GIT_TRACE=$(pwd)/trace.out git clone --recurse-submodules --jobs 7 . super4 &&

base-commit: 67ad42147a7acc2af6074753ebd03d904476118f
-- 
gitgitgadget
