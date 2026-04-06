Received: from mail-dy1-f174.google.com (mail-dy1-f174.google.com [74.125.82.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C01A1393DF5
	for <git@vger.kernel.org>; Mon,  6 Apr 2026 17:55:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775498107; cv=none; b=Qq2UwbW9qCJMHmAWECwUGOYUgKheR2LUr+vrANQMqQmh7duwd9TzCbhdOfHKXtl+IXBJsA0QHkpHnGU6kg7Jx1OD3xhARSfuJsqQ4V4Y3NxPX68CAJf/6LcJGtvVBUwwla91zj9mmwllVFo7miIMvFaS25MaKeRvti36aJEmUsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775498107; c=relaxed/simple;
	bh=JQJPUnNlc88YOZjc+woeZHt0OERzy3a3Bt1KoYQ4zbU=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=sx+Zl1hg1wPQ1YWeZdZM6AOh5dS9sm4pXh3WHejqiA1zi71m4x+MUcjeojGGfJTGxOf/Z/3vd0KT4iAL1qh7M4jd1x49YdFbvunvqErymbjvmm3IVbAI3V6sZHGUEdG6hN23Ec50suyO6Zx7grZmRwy39RjyMSx9i5QwERKJ53w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Fxs1ihXP; arc=none smtp.client-ip=74.125.82.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fxs1ihXP"
Received: by mail-dy1-f174.google.com with SMTP id 5a478bee46e88-2c156c4a9efso4981676eec.1
        for <git@vger.kernel.org>; Mon, 06 Apr 2026 10:55:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775498105; x=1776102905; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=utSML8XDRWikFjEf8OTnGhOa1Cm1oF1YFZw6B0GetW0=;
        b=Fxs1ihXPWUelI632/q5ngpwBRWui102tHtws1OwYsw5p3KZqmxQcmMDfc19/2XpSh9
         Z/Z+Gd3Vd2xyGBRrBVEFx0VdRljjqLUaXPD7MG3Slq8JdirUXM1Uvw6li4P/tnPY7PH/
         FMU84A5r8GSgzdH7HE4FbQDgg02/S8ag7z31elWTZyQCYnQuB3vj+8nPbPevHRpxeuBv
         evZyoe6RwOdQ0vI4CbiSHedk2mq/tUYgmCx4aGuXRN2v0IaAKtUriFk1DXLZ9XmODG66
         H7neyPd+J1Ko7DevXV4NvsrNdr8x//chhfvkEoxu9XVikyEUguS43kv4DwdOk4evztfA
         ui1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775498105; x=1776102905;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=utSML8XDRWikFjEf8OTnGhOa1Cm1oF1YFZw6B0GetW0=;
        b=Z9FhyyQm2beG9Ri42FOJHDYSYN8L3z8d5rtFDvYgzv7XAXcmuVCxaezAbNZdpJnkBc
         FwOIfEakBLkkyMrRdEfzqSb9xpXbEXnqIrZJjCXluNIjp5gSj8Qnk5Jfzi6xXnhYFxTa
         MB+4uxFQF1gl+el+bYZGLRMP4xOageCXytyiMC4Yq2EyBZOUxbJw0CQaShWJZKpqwzQj
         bMZ819oqAbxqMtuaFJDlhc+bada6YjG9EIQF7zY0ovdZ6uFF7S0or9x8H/szWpv24joo
         iqkJ9Xke4cR0qzhG1s6PEp8ZcRTN03/y4WIUHYgGh5CwUbsX0feSA0ZDoImT/gaTFgju
         6waA==
X-Gm-Message-State: AOJu0YzG16uBM31D8LhkUwJXeiPlF7MWjEItUrvqQTAWyrCCPmyWKGo4
	7hsQPiELGlS4cpDXCjO3lWyc1YMD3r+cnMvPAE1s8xBfiEXERv3sp/s211t8rA==
X-Gm-Gg: AeBDietJp9E3WuhsILKibLQ6Ar2ku/tNr95q6bSq49ZwRVHd94E6PLLMnL30JFFjpxd
	81NUOiMPc0YNYnURkNk0ofwCAgq+B45wP3pJ3gA0G+nssyZUmTbbVZWbulZpzbeLcsCJRQUX8Uz
	i/rhCIlLtGP10DKez2Gx9YSPnoHQyH6FlY5E96DcP/5lAs6KNiGXSonzKOo/rM/ORD9sMGyx486
	7oFEttD5FSQy5Z1tMADqVKuo/bc5m1Km0ogrnl3WEMCD1XydtPrLKg/sG6WHt/D4Hy3rNo5+6TG
	r5KP6+jUakDOBwsGDPrRatwzGztFnjviVAXZKDN+avjY9J53lqFufsLEsgcNsF6l5ovb+lrdvlM
	BJmv4EykHC1NgcwugpAlHzeLpPb6VcY6Xq+ykXNbSAmPkxtT18BAKuc0NJXPGmY9CuBS6p4IgNj
	K5ydMhChRDCaurNDIU+Ow4Xgbnbmg=
X-Received: by 2002:a05:693c:3009:b0:2cb:de38:c7b2 with SMTP id 5a478bee46e88-2cbfc461f36mr7076444eec.29.1775498105549;
        Mon, 06 Apr 2026 10:55:05 -0700 (PDT)
Received: from [127.0.0.1] ([57.151.128.242])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2cba5df5c24sm11725048eec.27.2026.04.06.10.55.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Apr 2026 10:55:05 -0700 (PDT)
Message-Id: <427073fc38e6f1e41d4db844758978ce40d061db.1775498098.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2147.v13.git.git.1775498098.gitgitgadget@gmail.com>
References: <pull.2147.v12.git.git.1774937958.gitgitgadget@gmail.com>
	<pull.2147.v13.git.git.1775498098.gitgitgadget@gmail.com>
From: "Paul Tarjan via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 06 Apr 2026 17:54:49 +0000
Subject: [PATCH v13 04/13] compat/win32: add pthread_cond_timedwait
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

