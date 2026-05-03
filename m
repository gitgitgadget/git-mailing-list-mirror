Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com [209.85.210.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 979B7351C3F
	for <git@vger.kernel.org>; Sun,  3 May 2026 11:57:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777809436; cv=none; b=CE0M2+Oj2Dl+505ELLOterICGDu2AWUkLlQtohkOFhrsTti6w/OdxfTqJPWBVOk6e+m6hDz++PT7xeuXUQ2RZBuCeL/Z5wTjpl7+lw2w2BPe0wMqNhjUY5E1IBivPj6q37pXhWr6bS5TCICZmbCp6rFYr9celysflUFvXKD/hGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777809436; c=relaxed/simple;
	bh=Bz4mPDVA704tgX28biYjQSJ8nwbzlSMFwTe/s5E1VxQ=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=OUCTRTXyYWEEbgRVZdZLu4EdAUe3LHAmb9dCID4qggSJkTOJjnCfCqbj+Qi0Ci8NqPDreaAw8k1fRGtczYNhkvsYRM/XeW9K+bOUPGNIMK5UNIHOUJzs8fT/R4WvPoqiwH1rIV2o/xecoisSBeZKU/AJ753S6IlFMNIxpJI4VYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZGGBLsyz; arc=none smtp.client-ip=209.85.210.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZGGBLsyz"
Received: by mail-ot1-f53.google.com with SMTP id 46e09a7af769-7d4c383f2fcso3232261a34.0
        for <git@vger.kernel.org>; Sun, 03 May 2026 04:57:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777809434; x=1778414234; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/0gJJyg91MLoBv1XEg+UloSB2M2wRAl+UzHKw0vq6FE=;
        b=ZGGBLsyzAmdhOK5QAZ+1GQT2esHMWZkaErm9wq6AvKfqCQ4nKyxkyGcnbvNYCizCG/
         c5E9BQwjpmVDZyiqH1R90kSmbcnnAYcSzI/QG9c9m1ljWMMOOhoVOJgb8VynRk8NHq6v
         CbRSqK9+pbKebqiL/fT6E9FXVyCk5RscXRPugwuP6uAJ0dVSjmTG+q2HYVeH2sQKs6B6
         CqokN1QWKQ+umHM3LwVmZ9VZEruZ5/AtxK6kKhVBijMO/O82dSr6di/hhrtyN9+q07yd
         PU8q83xBpojPSLEQR+v0kojdWo7N1MSw0jXPAzudEbLmBiI1MS/ePaQTkKMlv20SPkZx
         FyPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777809434; x=1778414234;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/0gJJyg91MLoBv1XEg+UloSB2M2wRAl+UzHKw0vq6FE=;
        b=WMVvDasEbJWfdRmF8LeED4rV73+2l6yXWGg3k2lmWP6bkNuSKOa/iHnvF/7fGFA1WF
         /HdQh3/EvPDA5+WSgP/lLK35txSUx2LC1e2Nyzsx/VGu0FclodXCWM5vmgD1+ERsIbyJ
         GpMFkTzcl1bwGbZ33qzoIAWMk/auAgkhGynKRKbK05IkhqF1GZ0TvtZ1J5xIu48puVGN
         RdzzjaPBGBD/P3pH1Kk7pBDpEUPUhLNVF0Dyc1Lr1eGabwGqZTeDioEIfJbEph91sVXh
         YkH5dgVfdCzQ5bPzgQtgTgxaMO1wT6yCKD0R3KC0mlQPoGMpe62niQylta+DDaBpTsNY
         SqhA==
X-Gm-Message-State: AOJu0YzSR4BKDd1syRlcjqLz/HY0NF/vOxO4w1BMQYHpqUHxZHdcDnY3
	3wA6Xxji/ztlpdNYHQJoQN33Nx5JeohF4ndX6FnkUsuNjQF88x80lxaGmBhahw==
X-Gm-Gg: AeBDiesSuS6/vnjnFhz7655SMj/eW1T7lUHPgRs9QsJAjh7vUElAg40xAfMwhjfea98
	fdiqHBYUm67vxViUy+0KeNAk2WJ0Uivq6St3j8FCfPxusRbf9lc4zQHY/t0fyUxw9jV6x6lT4ZV
	n5+jt1K0W8ZCbG/HNsM/aBjJx33JZb8I6tzMIkYGEkPsUHpUdax1HDEQQ017aqLVSujtGeK1jBn
	mi9waaYOB/jwNoy6yk5elDiGt92M2b36UzpUNxzCSaldk3fRKmo7e8jMMH0ykR2hyMuUKtn+AJD
	EAzdTBAGgbuOZ/odeWUt1m48UepFGwxXurfql7Xbxx/LGH8Uo+3LT7mkS+3r+QTZ/ApklweKcGt
	jRxcflRCE5ebB0l4pzNQJNkXd3zi91KQrdMJYJt8QqlT1JEHDzUlSvutEMEedgWxiBrJcYPf5VI
	xjPRzIdwNkaetTEFFPk+tVw+AXPfY14BAvSwRx
X-Received: by 2002:a05:6830:6484:b0:7de:477c:9799 with SMTP id 46e09a7af769-7dee1395ca0mr3502504a34.15.1777809434005;
        Sun, 03 May 2026 04:57:14 -0700 (PDT)
Received: from [127.0.0.1] ([52.173.181.24])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7deca818490sm5908239a34.10.2026.05.03.04.57.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 May 2026 04:57:12 -0700 (PDT)
Message-Id: <pull.2287.v2.git.git.1777809430925.gitgitgadget@gmail.com>
In-Reply-To: <pull.2287.git.git.1777803242592.gitgitgadget@gmail.com>
References: <pull.2287.git.git.1777803242592.gitgitgadget@gmail.com>
From: "Saagar Jha via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sun, 03 May 2026 11:57:10 +0000
Subject: [PATCH v2] submodule-config: fix reading submodule.fetchJobs
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
Cc: Pablo <pabloosabaterr@gmail.com>,
    Saagar Jha <saagar@saagarjha.com>,
    Saagar Jha <saagar@saagarjha.com>

From: Saagar Jha <saagar@saagarjha.com>

The old code accidentally passed &max_jobs rather than max_jobs into
config_from_gitmodules, which caused the setting to be written to the
wrong place and dropped.

Signed-off-by: Saagar Jha <saagar@saagarjha.com>
---
    submodule-config: fix reading submodule.fetchJobs

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-2287%2Fsaagarjha%2Fmaint-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-2287/saagarjha/maint-v2
Pull-Request: https://github.com/git/git/pull/2287

Range-diff vs v1:

 1:  094c641227 ! 1:  868901f1a6 submodule-config: fix reading submodule.fetchJobs
     @@ Metadata
       ## Commit message ##
          submodule-config: fix reading submodule.fetchJobs
      
     +    The old code accidentally passed &max_jobs rather than max_jobs into
     +    config_from_gitmodules, which caused the setting to be written to the
     +    wrong place and dropped.
     +
          Signed-off-by: Saagar Jha <saagar@saagarjha.com>
      
       ## submodule-config.c ##


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
