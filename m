Received: from mail-pj2-f43.google.com (mail-pj2-f43.google.com [74.125.227.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F4C2340401
	for <git@vger.kernel.org>; Mon, 28 Sep 2026 15:51:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790610700; cv=none; b=bNoobSAAl8gA0Pog8nTLygM6tbmNog12l1NCadcTVQYx7IWr9aqva44UKUVUJWfAiM2js7AEvDsTFIla1q83Km06nhh4azkcAxV7qoO6vDrrde5zpSGCI2b/BeTzaNwMcswWj95sac9a5N/h+nWhe7qzFe/vzogH4mNgOKaHTwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790610700; c=relaxed/simple;
	bh=X6DsDpdMgpQdnvp6b2gFXYTT7wiCP0ab1usS8Lby5mc=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=OGGBzlsKjXWdRz8LjbISrX1qOSeY/dMOzWkr7Mxyq2fSm6ZfE4fELFeHlAZq2au7hnOoSYPB3fucNGUm8+O5RuftyQqEYal/g0NNCLzlzZux6VB7c3OydwwX0kK+n8HDHpzXaWcirkqnVUbdzX3osNa9EAKIlNhqIjkdzXtHja0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bBpDcsFD; arc=none smtp.client-ip=74.125.227.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bBpDcsFD"
Received: by mail-pj2-f43.google.com with SMTP id d9443c01a7336-2e2bfc2540cso1493495ad.3
        for <git@vger.kernel.org>; Mon, 28 Sep 2026 08:51:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790610697; x=1791215497; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=C4c5AdPLlFhdPhjq+rLHaGrWnb5IrYxRqlSbF68ljU0=;
        b=bBpDcsFDTZDrFUiOKsQlGHOxQD0YkdbiYlx8gR90yiuz09evOj095uT8CmseSRZ/jl
         S+543d4P5SyIQ6J1zc7YBBmcP9hkbExZz/AOVL7AbWV6BstLsceutBwZAs8NNQTMDx3h
         Q1osNYc9g9uLQNmReixPtztoYpNzwQ44HDYy3qaY2lcyP/n887rO5JBU6ny+mLm/oLJY
         +D6mGx7WVMZU5LJnN3OndJ1oBmTZY9cUTUGXssspW3+GnS3ZPSJBG97WyyVFMIi2bFRj
         HkbvG+H7g8P/ZLvCxUlG1kVX8lfgnLRofNpZGeRtvOOZsEPFGD1nXMQ+C0FA4MHdo7nT
         f/tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790610697; x=1791215497;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=C4c5AdPLlFhdPhjq+rLHaGrWnb5IrYxRqlSbF68ljU0=;
        b=yUPOUQyYUKY9jBH27JQWQwNevg37muWw+2gZsrQs4zgBZbTbffno1SeYaKGiur65+f
         pMwMnJ23xBXF1GwNeH0VQ3bWs39/N4j07uXI0gVqpA5vEQe8KnwTFHf1MNNZJUxIUTvW
         /NfdanrwPafUEYQfjgL+TmhuadRDZRPBOSG1Kz3Q7pKPkWcy6qFcdV7gFANBLTCFhf8c
         NZ8zVJfEEXqfDPGBAytiLwLxJ8bYbTzfKfMKtvT6Y7A+ACyHl5M7Znu1bv6rAx+Si5t2
         F1TKjZ0EdFuR7ecP7LFVJE5ZX8QBkPmpWFhdlByEU3Q2A6Nh3BGEtFsAIu4o4VJBE72D
         YPEQ==
X-Gm-Message-State: AFq9FYL2DekwFXS4kq3qv8Gns6HASlfkf3uruKIUwWbdr4WgVG/lMfrg
	BZPzduM1jEZdqIwazX8m2XJhrlk/XxopKLyk+zxfWmDUo90/QW7G0Ha7v6OW8eKT
X-Gm-Gg: AYBFou3jnTDAtWjveMA6hjnrruklPz7WvmBvq4LrV1ERkOOs5o7KkDPIijsyw+HHfZo
	pnOUHNT2wlpUPevR+Yn+Uf9YWfeMX+RqjIP11P5t5u55+z3ZVq4L23FdVoUp0i7oZ4nsdWz9wGY
	dXgshZbuSlxS5HBk1zT9HeU3Pwe46aEwb4xihOiDjIarMi0IkLdii0Av97TrVEOsM4eP4fc6b/m
	UcsQtdXZxB/ITN0J2rKprUopx58oicczhWF3PbnO4mC2P1tO0jafyHfoLcxsfSvcBTnFJ8Jt6lR
	v/FD1Kra96N3fTnBup6BBNuZwYDGqKZsfSLGWcJQLaDk3w9pa7KRWAB94rhm8KAFuBjtlBpiDWl
	SvYd93nbzCKIPDxjI/LdWCSwO5+h8lyq/hz9VtLN8uOBAxv2VCgcSk79EF05sFKtf+U6qn3XT/H
	NDQ2+8HUtwfMuCFg+lRLPJaVuRDNyBtRn4+sFcU06WdTcwrJvTNZpe7MCMUkRQyr5kJGot/qFH/
	g==
X-Received: by 2002:a17:903:245:b0:2dd:8e7d:90f7 with SMTP id d9443c01a7336-2df7da6101cmr101299855ad.9.1790610697246;
        Mon, 28 Sep 2026 08:51:37 -0700 (PDT)
Received: from [127.0.0.1] ([134.33.102.121])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2df913e032bsm44830115ad.27.2026.09.28.08.51.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2026 08:51:36 -0700 (PDT)
Message-Id: <2f3077b60a7777b8d4c21551f9a8d02034a49cee.1790610691.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2240.git.1790610691.gitgitgadget@gmail.com>
References: <pull.2240.git.1790610691.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 28 Sep 2026 15:51:30 +0000
Subject: [PATCH 3/4] pthread: provide `pthread_once()` shims for Windows and
 for NO_PTHREADS
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

I am about to introduce logic that needs to perform some initialization
once, and once only, even if called concurrently.

This is a perfect job for `pthread_once()`, but Git's source code
currently lacks a Win32 shim. So let's add one!

Also provide a trivial shim for `NO_PTHREAD` builds.

Assisted-by: GPT-6 Sol
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 compat/win32/pthread.c | 16 ++++++++++++++++
 compat/win32/pthread.h |  5 +++++
 thread-utils.h         | 16 ++++++++++++++++
 3 files changed, 37 insertions(+)

diff --git a/compat/win32/pthread.c b/compat/win32/pthread.c
index 398caa9602..5af95edd3b 100644
--- a/compat/win32/pthread.c
+++ b/compat/win32/pthread.c
@@ -60,6 +60,22 @@ pthread_t pthread_self(void)
 	return t;
 }
 
+static BOOL CALLBACK win32_pthread_once(PINIT_ONCE once UNUSED,
+					PVOID parameter,
+					PVOID *context UNUSED)
+{
+	(*(void (**)(void))parameter)();
+	return TRUE;
+}
+
+int pthread_once(pthread_once_t *once_control, void (*init_routine)(void))
+{
+	if (!InitOnceExecuteOnce(once_control, win32_pthread_once,
+				 &init_routine, NULL))
+		return err_win_to_posix(GetLastError());
+	return 0;
+}
+
 int pthread_cond_wait(pthread_cond_t *cond, pthread_mutex_t *mutex)
 {
 	if (SleepConditionVariableCS(cond, mutex, INFINITE) == 0)
diff --git a/compat/win32/pthread.h b/compat/win32/pthread.h
index d80df8d12a..79a6bd9680 100644
--- a/compat/win32/pthread.h
+++ b/compat/win32/pthread.h
@@ -26,6 +26,11 @@ static inline int return_0(int i UNUSED) {
 #define pthread_mutex_lock EnterCriticalSection
 #define pthread_mutex_unlock LeaveCriticalSection
 
+typedef INIT_ONCE pthread_once_t;
+#define PTHREAD_ONCE_INIT INIT_ONCE_STATIC_INIT
+
+int pthread_once(pthread_once_t *once_control, void (*init_routine)(void));
+
 typedef int pthread_mutexattr_t;
 #define pthread_mutexattr_init(a) (*(a) = 0)
 #define pthread_mutexattr_destroy(a) do {} while (0)
diff --git a/thread-utils.h b/thread-utils.h
index 4961487ed9..98b574eff4 100644
--- a/thread-utils.h
+++ b/thread-utils.h
@@ -19,6 +19,22 @@
 #define pthread_mutex_t int
 #define pthread_cond_t int
 #define pthread_key_t int
+#define pthread_once_t int
+#undef PTHREAD_ONCE_INIT
+#define PTHREAD_ONCE_INIT 0
+
+static inline int dummy_pthread_once(pthread_once_t *once_control,
+				      void (*init_routine)(void))
+{
+	if (!*once_control) {
+		init_routine();
+		*once_control = 1;
+	}
+	return 0;
+}
+
+#define pthread_once(once_control, init_routine) \
+	dummy_pthread_once((once_control), (init_routine))
 
 #define pthread_mutex_init(mutex, attr) dummy_pthread_init(mutex)
 #define pthread_mutex_lock(mutex)
-- 
gitgitgadget

