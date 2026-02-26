Received: from mail-dy1-f172.google.com (mail-dy1-f172.google.com [74.125.82.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03DAD25F99F
	for <git@vger.kernel.org>; Thu, 26 Feb 2026 00:27:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772065654; cv=none; b=I2Z9Nmm1avPGw+iub2dU7WzcyfX2YXGVC6+uihy4xE6o3ZJv0JKaXfm/YCEMkEdmsgsgwndlBDXANFiLIJAs+MF34xSRDly4r1apvUny276TZZ5MHqHGLlK+HS70NSBpvaN2sPudU0m5bUHVzy3HR68Nxsq2bRnRYx0pCLuYBck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772065654; c=relaxed/simple;
	bh=4lDNxkT0s0i4xTd5xY3LXQcX+d3MTEmwV7TVliwIZmE=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=e1US6xD6PCGObiOYUJvljY6XHWVq5llLb25we+UQ5KzBHTnIXE31t3jze7ErTG1Y+xUqSA2brE6cO9erEfX2+KZcFDwLE86RZ9NHwjnf71nWcFfWoddQTBf7IPfnh+95WdPH7OA3P/6kcGpTRkRJU7HBjE5joABioC5jc6aTvkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e0DtWGo+; arc=none smtp.client-ip=74.125.82.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e0DtWGo+"
Received: by mail-dy1-f172.google.com with SMTP id 5a478bee46e88-2bdca815fdfso549213eec.1
        for <git@vger.kernel.org>; Wed, 25 Feb 2026 16:27:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772065651; x=1772670451; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xDi8oFw3VzJyuV5g7iQWn5k67xLK5Zswvz7O+MebhCI=;
        b=e0DtWGo+9PicJOs0O8SZT+1An5jS5e5izd85qcvocFa61unRRYHgmTccS5Onmdf4mE
         Dr23GNdccnIw503QScEcfHysiLcevs9zpmZkTxX6td0xkO+dppOJ5EAx0WDR/aasxQSs
         /MBX7JjMeSARW7zasTcTt2uIWJMM1DkIeW2ZCami5gJTVlE731SWQloCMx7j3vAYyoT+
         5sHEa9cxM1WB06ZmqSRJL3V167N/e1r/KyGu4Siq9KFx5IH/0lnddv0hDXIXk6lNmyJh
         p4NPJmOkoLoNuU2DI3YcTuhHDPohYpq1tqcj33QCV5jvNE7wict6iLG/h20OOQzLjyLy
         p7hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772065651; x=1772670451;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=xDi8oFw3VzJyuV5g7iQWn5k67xLK5Zswvz7O+MebhCI=;
        b=fxZkc5MkuKM47nTlqB9Z7T2TllDUY7MyinuDnpgun6G2wGmdGL0Eq/Nk+u25djE1N0
         Bd8t+2gPuSueKA/y0ll7DbJVGh9giGwEDpL3RHG4tvphGB9VFvOnbqR5x5Ss5Hce31ib
         fgNAqHUpRpLM1Z/1RrOzPTDpJI59JSxO9N3udEHtfIVxqDWGziMzezZVRyO3suKn4bMF
         gz7/+h7+v4VdQDmv+5sZWhnbP/yIgmIx9BHuL39xJC7opUGwe10Sz9Lvjabf3BegP+uV
         DiOxLa9+iKFL1herivAIkfgw4WujjvbVm+tblEjMi6rwF/NYsCLLTgVwYN2GfZiQWyWy
         0+kw==
X-Gm-Message-State: AOJu0Yw3OBLSit05J3SNVEEWX+hkWef5mHvKeVSufTCUQvbP+tKQ63l5
	/flqU2KBTtr8kvT4T2Ek8bm3c4LMVt/C9HcyMVdKfbKX9ctp3acxAo7gaoHWNMiE
X-Gm-Gg: ATEYQzyz8xlVi+Mvq4GI/IdkGexcH6uDZ2GpI0aW3P8HJUbw5E/TP8qaSli+1qwM8Dk
	zT+5VVkuIsgpNUypstIouL5W/0ePWeDNh43tnc0OdokSRyBI/kJlJhp6WjWc/SzlXHRkiD6DipZ
	ZizoX/6GFhOzimiuNuyPGB7WvnARIaQUO232dAAGsClOuBn59pmcts7YviHOGzYaY+m/eo5vBX/
	e/8h7MfY6/ftBoYSEm6+gEW3vnb7CqTHabJRziyoaShBtmmB3x2lb05lCC3DtoIogtIWtfhYXpx
	DpD28spbBgPVYWp3qz0bIfeJ7/cN3EtRzMscaaQKwh9wLRZ2EBnyfDazkhwtK3P+88uqtWURbN3
	arf82rWvpa08ColmoLI5sl0a6lTDAu/PvBS6vMnLB4h4NeXobDj1xr2gxoEEFyMOu0xz6+kAbjS
	u3WTDm4u5fPjl4mynyFVkUiIALRg==
X-Received: by 2002:a05:693c:25c7:b0:2ba:a1a5:b5b1 with SMTP id 5a478bee46e88-2bd7b9efc61mr7271306eec.7.1772065651392;
        Wed, 25 Feb 2026 16:27:31 -0800 (PST)
Received: from [127.0.0.1] ([52.159.229.150])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2bdd1f48c77sm603370eec.26.2026.02.25.16.27.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Feb 2026 16:27:30 -0800 (PST)
Message-Id: <d2c5ca09396e020adb717055d82f50de7c1b7431.1772065643.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2147.v7.git.git.1772065643.gitgitgadget@gmail.com>
References: <pull.2147.v6.git.git.1772050636.gitgitgadget@gmail.com>
	<pull.2147.v7.git.git.1772065643.gitgitgadget@gmail.com>
From: "Paul Tarjan via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 26 Feb 2026 00:27:16 +0000
Subject: [PATCH v7 03/10] compat/win32: add pthread_cond_timedwait
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
    Paul Tarjan <github@paulisageek.com>,
    Paul Tarjan <github@paulisageek.com>

From: Paul Tarjan <github@paulisageek.com>

Add a pthread_cond_timedwait() implementation to the Windows pthread
compatibility layer using SleepConditionVariableCS() with a millisecond
timeout computed from the absolute deadline.

This enables callers to use bounded waits on condition variables
instead of blocking indefinitely with pthread_cond_wait().

Signed-off-by: Paul Tarjan <github@paulisageek.com>
---
 compat/win32/pthread.c | 26 ++++++++++++++++++++++++++
 compat/win32/pthread.h |  2 ++
 2 files changed, 28 insertions(+)

diff --git a/compat/win32/pthread.c b/compat/win32/pthread.c
index 7e93146963..538ef92d9d 100644
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
+		timeout_ms = 0;
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

