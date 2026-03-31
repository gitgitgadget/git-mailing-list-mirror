Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A9A838737F
	for <git@vger.kernel.org>; Tue, 31 Mar 2026 06:19:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774937971; cv=none; b=aZfS2aRFgVkb7G9VVBWUrnWot1QBxSAWZ74QKKn4npGHMWjQjf1iUdptDGujxkr/vnwYKy2DEXz2JWBvXjYBVD03LFI0CSsOf6AlbWi02DltByizLnbGT4IwsOSp8L1JAiKeG9WGfK6a7EvBUzSpOSHyfEIkdBsKQ9Fx0eePHuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774937971; c=relaxed/simple;
	bh=JQJPUnNlc88YOZjc+woeZHt0OERzy3a3Bt1KoYQ4zbU=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=IEhmw1vjCons/mTvRCNnBU1/J5DK54MQB4ShbaHK3LrVLpSsAcP2uI/rVhSZ8TSyasX6zV8cg7vCE2hDY1pOJK3WfnZoqqyn4i1kbBM0P6jspchVb9kDKtH7Zf1UE7QW2XmVddkVSTskw+GQswoek7jev1PrIIow53/eib2a4Gg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RpE0q6+h; arc=none smtp.client-ip=209.85.210.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RpE0q6+h"
Received: by mail-ot1-f52.google.com with SMTP id 46e09a7af769-7d91f82d819so5266248a34.1
        for <git@vger.kernel.org>; Mon, 30 Mar 2026 23:19:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774937968; x=1775542768; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=utSML8XDRWikFjEf8OTnGhOa1Cm1oF1YFZw6B0GetW0=;
        b=RpE0q6+h7u39vrqa1p+ZEXFpfy2ckPwN5pZtwHNYH2NdWebBOUjruEIS4D0Sj1oesC
         vTO2UfUheJ30B8rp4rKyFnCXJbQWqB4kAgcbL4G1jUJ7XI+uoPiGFo4qyOgNlsDHPbLo
         w98dJStKwg/P1NEZ8o4JKB5Dzn3TlloGbl/e81FBmWYO2PjeHA2AHrwn/oNVQAPcfVqp
         2QhMwfZ8nvGOSFu8RaQtBR3obXCX4CTcrlsEKaBknqsKS6E76SIH9gKa2o1VOj247xQF
         OqnV1NMozZUAk/n6qnKt9XNIJ5XwHd840XBZ3QtUhsg1WSfevjs5UTiZqRJC7ZfOc5W+
         30gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774937968; x=1775542768;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=utSML8XDRWikFjEf8OTnGhOa1Cm1oF1YFZw6B0GetW0=;
        b=ISn+6fEb5ZWsSFXGDjnK+Sp5dtfPiQV2tuRU8Aq4419HMRhFczScdJHQHURHh38lo+
         +Ung87UkIlEJ0d9x5+gpVX9+7A8n5mbChP0sIgfUk7qWg26p+DElahUYp/JFJdBvVJLh
         VA4D7PM3V2ZkzrXKJ54kbkcNw3lZq4XJL0Xr9nyUsjEpV+USQSmgyjPC7oHDGtshKLTX
         UW/3jjsB28BAvhJyV6cYUSprSRhM9qcWFKr98n3Ufs2ylLE8fPgWd+OwtPlIRyvIbTar
         una9muRxgr8rLClDGKPMy1n+4x89xIT0VUKIIIJdaNRFYOQ3RFMOKg6AooF4fM7ZZYmk
         tRSQ==
X-Gm-Message-State: AOJu0YynZZnznZVenUcLfDfm/MuUkLB7byQEa9VlzWfghLPUeWoAtbbO
	Zr/EHBE6DuATNTVR4SCk1tSDD7zOILhx2/IRI4TE+u3bngxcc//q5rLMgqElIVOY
X-Gm-Gg: ATEYQzy4apEHx17iguSYDZJ9QlrZgsO4EPP9MPeEeQTGRs3IZY8AuzHNEIPDVHecFxg
	F/MJhGH1p8sJT2rOY0iGpfCt1LLEE4/R2bu6Dc34e2ydvNuMuBzNaRlqYBakRCYvU95C78OGOxh
	BfthLadx8mlNKrIMfcQKORGBIuYHMkHUZXNkpwoPcESz7boYtZ0MOJv4rjy2B8IwYyKH6GfazW1
	XPOyj6RS9qsP1v6xkCePrfRvgGxQVZEg0ZWIpByiCWWezjLOK5RI3NHMMlgRB4SQQvOkr4kryiz
	VbzLVhfGUg1gr9nQFemUBFkpNjg2NwwkfcNt+i71M0Bp0UMnKoXMl6LZXlyNN7VMcul1g8Zf/WG
	kULOUp6+EyBheCw94j9mTIaYDgQecGlYQhweNwPTmOC5BTwHlL0phIQdED4+RRa5k8XXaf7Op6N
	2Y72BO7mUaGu9j72UH6MlytuszL5U=
X-Received: by 2002:a05:6830:4492:b0:7d7:f031:37bf with SMTP id 46e09a7af769-7d9faed1c08mr9429355a34.19.1774937968615;
        Mon, 30 Mar 2026 23:19:28 -0700 (PDT)
Received: from [127.0.0.1] ([52.165.251.162])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7da3356d8c5sm1956878a34.14.2026.03.30.23.19.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Mar 2026 23:19:28 -0700 (PDT)
Message-Id: <44a063074dadc27110e2dd3481756c8c324ed956.1774937958.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2147.v12.git.git.1774937958.gitgitgadget@gmail.com>
References: <pull.2147.v11.git.git.1772693712.gitgitgadget@gmail.com>
	<pull.2147.v12.git.git.1774937958.gitgitgadget@gmail.com>
From: "Paul Tarjan via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 31 Mar 2026 06:19:08 +0000
Subject: [PATCH v12 03/13] compat/win32: add pthread_cond_timedwait
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
Cc: Patrick Steinhardt <ps@pks.im>,
    Paul Tarjan <paul@paultarjan.com>,
    Paul Tarjan <github@paulisageek.com>,
    Paul Tarjan <github@paulisageek.com>

From: Paul Tarjan <github@paulisageek.com>

Add a pthread_cond_timedwait() implementation to the Windows pthread
compatibility layer using SleepConditionVariableCS() with a millisecond
timeout computed from the absolute deadline.

Signed-off-by: Paul Tarjan <github@paulisageek.com>
---
 compat/win32/pthread.c | 26 ++++++++++++++++++++++++++
 compat/win32/pthread.h |  2 ++
 2 files changed, 28 insertions(+)

diff --git a/compat/win32/pthread.c b/compat/win32/pthread.c
index 7e93146963..398caa9602 100644
--- a/compat/win32/pthread.c
+++ b/compat/win32/pthread.c
@@ -66,3 +66,29 @@ int pthread_cond_wait(pthread_cond_t *cond, pthread_mutex_t *mutex)
 		return err_win_to_posix(GetLastError());
 	return 0;
 }
+
+int pthread_cond_timedwait(pthread_cond_t *cond, pthread_mutex_t *mutex,
+			   const struct timespec *abstime)
+{
+	struct timeval now;
+	long long now_ms, deadline_ms;
+	DWORD timeout_ms;
+
+	gettimeofday(&now, NULL);
+	now_ms = (long long)now.tv_sec * 1000 + now.tv_usec / 1000;
+	deadline_ms = (long long)abstime->tv_sec * 1000 +
+		      abstime->tv_nsec / 1000000;
+
+	if (deadline_ms <= now_ms)
+		return ETIMEDOUT;
+	else
+		timeout_ms = (DWORD)(deadline_ms - now_ms);
+
+	if (SleepConditionVariableCS(cond, mutex, timeout_ms) == 0) {
+		DWORD err = GetLastError();
+		if (err == ERROR_TIMEOUT)
+			return ETIMEDOUT;
+		return err_win_to_posix(err);
+	}
+	return 0;
+}
diff --git a/compat/win32/pthread.h b/compat/win32/pthread.h
index ccacc5a53b..d80df8d12a 100644
--- a/compat/win32/pthread.h
+++ b/compat/win32/pthread.h
@@ -64,6 +64,8 @@ int win32_pthread_join(pthread_t *thread, void **value_ptr);
 pthread_t pthread_self(void);
 
 int pthread_cond_wait(pthread_cond_t *cond, pthread_mutex_t *mutex);
+int pthread_cond_timedwait(pthread_cond_t *cond, pthread_mutex_t *mutex,
+			   const struct timespec *abstime);
 
 static inline void NORETURN pthread_exit(void *ret)
 {
-- 
gitgitgadget

