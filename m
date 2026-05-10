Received: from mail-dy1-f169.google.com (mail-dy1-f169.google.com [74.125.82.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9686F13B584
	for <git@vger.kernel.org>; Sun, 10 May 2026 03:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778385027; cv=none; b=J+9VsAFa/ZsybjQsbs1E8VyvO6FyNXslOQQwAAlx1yb7GD2rj/EXwsiWT8w1l31iIfMchrqI1zQcYTYlrN01n9ID+M/mXmtG5+mIXJADq0i5vY7SlNZBN+2OA+0UgK+NtyixSq0qeGvCPTrpqajKd2g2arnrv20sd4M8j0oGUL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778385027; c=relaxed/simple;
	bh=Tp17FRxqVbdPtZipFwydBZRVnTlAp4StTZTrCqzEWCM=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=To7mva9e5AmvN3PzN5Py/Q9vNAfilrB4fV1vEdbQeK26NsB9+p1ilYeUPd4vHLH0O6VgBnXjy2wRyH+szMJYRlKdnYqqu6f25QlJndIKgxVgBxXFT7ch/rLUL9I52hS8z9iuQPVs6I/4kTlXw4lmXm3rl+jwHxiSRIsmhSxI6/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sC3QYQrl; arc=none smtp.client-ip=74.125.82.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sC3QYQrl"
Received: by mail-dy1-f169.google.com with SMTP id 5a478bee46e88-2f3c623322bso5337322eec.0
        for <git@vger.kernel.org>; Sat, 09 May 2026 20:50:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778385025; x=1778989825; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=soOaq0kXQtlTCqgGVPvItGoGXbRurpHVFgNbdCAn5Z0=;
        b=sC3QYQrll0qNMVb4+D78mvRJbWJ27XrpnGxQ0c2sknH7edidSLCL4f9spjEvJdvxht
         m3b8c7rr3fWZdA0NNUOpZpHfaY2nNNJvZsxpwAD0GWf4XMTSb2wetlEg9s/uAhH40qRJ
         WGz9aBS5U1fEDrRi9tkZmpyu73Kl6m1OC4SZmH1SpRpWJ8ZEyoyf8GNXb10/DR2MUDGO
         SyiKS54WhBFBKreGc0A2rQEMR5n0O6bM1By1ruIub1UVbqpWmBl2/VepB1nXpbz4USd4
         EPueqJ1w3xy3tqdYJ515g3P6QEHE28/K3cElv/k75AqqvYESwOGElXQqAbHg4noQxG5h
         nITw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778385025; x=1778989825;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=soOaq0kXQtlTCqgGVPvItGoGXbRurpHVFgNbdCAn5Z0=;
        b=Ub/9yydlTskaE1e7Kv9MZr6HG3vIaeE2JqMNauJb2qG2NL0EHXyn44Ma2CkUPKCXLf
         SKedpi9/7CgHI6tmt9Gi22b4RwNwwH+5JL2gureyqdonmmxhGv+JmHfJ6zeJjeyL22dd
         tU/Wd7GgnK2UgRZC16iKGMagxwBBfwUn5+ArGMEQeevzfnkObCIkdoq5tln/Z1bBzFwy
         wcr2M6kBkDKwBk1nhy+hzhuj+oD/oJg7qPcxt7kq07SRSos/0yQkGHW8OODCHiu/OF7W
         mD17xG/B7TPGV7PY9BoUzzCmM473Kq6sTPmGYEsVJbNU5AukL13lKEvRV1eMXTCLWh6i
         TQnA==
X-Gm-Message-State: AOJu0Yx9CjacAs84Ufv+6tDuwrNoRz0lTgCNOUZuaftu7PPvFGjcK3pa
	XuI8nSZ3N7tFApMpOUEOiKBcGF47Oif24Jyb3ZPgmTBEXaUXbigB6wHBiBzSBA==
X-Gm-Gg: Acq92OGQk7bbRCVKKof7emqdXkRUoNInZgkzZ59tysGpRtjqa/G3nOfCjb/gu5jDQPo
	8fnORGSKFOf74lDNm94vKglKRdBPrGk+PzASsIk3oSvY8vSSI6VrGOI/86dqsVPlY2bRBfoFTpC
	0q21gkOHbv7NDb/3ZvOk9wDgvB3F0LHck9aFThzmjZuRVNWQBEXgw3Dcd9O2e3+Dqqp3JvX3g8v
	tck4iV7XH1jQkHvGR/Ega9ULQ3O+sV3t9glhhBN1pKF8Wa+3mX+wHPxeuziuT3hYGyb5L/n5cvL
	oj8MYK41V57FDG3DfOKqPMUlM06gtzCOVwO2m6kcHcA+lbgU0DDJncsty3XR/VhSh/Iipe7nE5c
	FBx1NlYtqyYNxNbUi0bDhe2KVR7TSXYijMhXTonXc/Ygiy8NHYJgCxmuw+1YgtaIsAnx3Oc5PYz
	p+nGEU/58LR3Hy7cURCshvrIJpln8SJOvmIvdd4Q==
X-Received: by 2002:a05:7300:b919:b0:2e7:120:137b with SMTP id 5a478bee46e88-2f547f6f1a0mr10059164eec.0.1778385024624;
        Sat, 09 May 2026 20:50:24 -0700 (PDT)
Received: from [127.0.0.1] ([128.24.160.230])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2f8859eafcdsm10783758eec.6.2026.05.09.20.50.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 May 2026 20:50:23 -0700 (PDT)
Message-Id: <pull.2287.v4.git.git.1778385022964.gitgitgadget@gmail.com>
In-Reply-To: <pull.2287.v3.git.git.1777816327842.gitgitgadget@gmail.com>
References: <pull.2287.v3.git.git.1777816327842.gitgitgadget@gmail.com>
From: "Saagar Jha via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sun, 10 May 2026 03:50:22 +0000
Subject: [PATCH v4] submodule-config: fix reading submodule.fetchJobs
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

update_clone_config_from_gitmodules() passes &max_jobs to
config_from_gitmodules(), but max_jobs is already a pointer. This causes
the config value to be written to the wrong address and get dropped.

Pass max_jobs directly.

Signed-off-by: Saagar Jha <saagar@saagarjha.com>
---
    submodule-config: fix reading submodule.fetchJobs

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-2287%2Fsaagarjha%2Fmaint-v4
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-2287/saagarjha/maint-v4
Pull-Request: https://github.com/git/git/pull/2287

Range-diff vs v3:

 1:  70fb2ede0f ! 1:  415c17f4bb submodule-config: fix reading submodule.fetchJobs
     @@ t/t7406-submodule-update.sh: test_expect_success 'submodule update can be run in
      +test_expect_success 'submodule update honors fetch jobs config from .gitmodules' '
      +	test_when_finished "rm -rf super3" &&
      +	git clone cloned super3 &&
     -+	(cd super3 &&
     -+	 git config -f .gitmodules submodule.fetchJobs 67 &&
     -+	 GIT_TRACE="$(pwd)/trace.out" git submodule update --init &&
     -+	 grep "67 tasks" trace.out
     -+	)
     ++	git -C super3 config -f .gitmodules submodule.fetchJobs 67 &&
     ++	GIT_TRACE="$(pwd)/trace.out" git -C super3 submodule update --init &&
     ++	test_grep "67 tasks" trace.out
      +'
      +
       test_expect_success 'git clone passes the parallel jobs config on to submodules' '


 submodule-config.c          | 2 +-
 t/t7406-submodule-update.sh | 8 ++++++++
 2 files changed, 9 insertions(+), 1 deletion(-)

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
index 3adab12091..6abb00876a 100755
--- a/t/t7406-submodule-update.sh
+++ b/t/t7406-submodule-update.sh
@@ -1055,6 +1055,14 @@ test_expect_success 'submodule update can be run in parallel' '
 	)
 '
 
+test_expect_success 'submodule update honors fetch jobs config from .gitmodules' '
+	test_when_finished "rm -rf super3" &&
+	git clone cloned super3 &&
+	git -C super3 config -f .gitmodules submodule.fetchJobs 67 &&
+	GIT_TRACE="$(pwd)/trace.out" git -C super3 submodule update --init &&
+	test_grep "67 tasks" trace.out
+'
+
 test_expect_success 'git clone passes the parallel jobs config on to submodules' '
 	test_when_finished "rm -rf super4" &&
 	GIT_TRACE=$(pwd)/trace.out git clone --recurse-submodules --jobs 7 . super4 &&

base-commit: 67ad42147a7acc2af6074753ebd03d904476118f
-- 
gitgitgadget
