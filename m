Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE73B2E8897
	for <git@vger.kernel.org>; Wed, 25 Feb 2026 20:17:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772050644; cv=none; b=Ba1mV+/sbT91H+LMPrnf9jcW/QM4RN6eYOAb2VbDxS04rM9hRbCDN+WLWQDltrQ9RHkEN/R7zyk3fEDyMsGepu08Kh8YngkOUABNv9KU51rQOWVFHFLmtNM4NcgxyHNXSP29Nago0D8bxCJBYo2ugN0iJzL1coWDM2+bimrm+tI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772050644; c=relaxed/simple;
	bh=4lDNxkT0s0i4xTd5xY3LXQcX+d3MTEmwV7TVliwIZmE=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=BD7yjJY9azQsTiYAT/qM681FC8RU1AdQDi48rntMm9DAolmz4MVqKEyk04PN/bZ/bnsPGSiVRDa4hWXbD6Ior16QSuwdow2M5VaI1qsJpHY2fxImhZPJQ4VS0az6rmRhUKPnwuJnT8OBckvxPuy3DJOF3U+nTUtM3XA3nifvhUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ncl/4vtz; arc=none smtp.client-ip=209.85.219.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ncl/4vtz"
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-899a5db525cso1103576d6.3
        for <git@vger.kernel.org>; Wed, 25 Feb 2026 12:17:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772050642; x=1772655442; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xDi8oFw3VzJyuV5g7iQWn5k67xLK5Zswvz7O+MebhCI=;
        b=ncl/4vtz5Tfi5wlWzmZeoCR/aPt3j3AeAsM0XwS9fhL+GmHwt1zZN0A6QA1SLhF3in
         aKEidtc+jNguOo+5wWA+7EklDjgIV0jb5Q06TWUIvdkeHlUUjklkkvhh15Ud/3pJXjQd
         4x+2YwEAHQ5ZASp6mGFh5uFh+z4y6WYYL0k3CRQy3D9jOW9/DRSAJAe656MHr/J7XpV+
         hJ5j7KMJJeILepjDkPoZ+zrHkAHNcsSq2Se8fynWo3SYByPPfIYw6iYnxz/4twj/GgpG
         Jf2NGuNe+ngnz7ONF0ADlywZmIBGAA4HiKq306btwb5TpzXJIHCFPWlVDt7+oGjsfidn
         LjYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772050642; x=1772655442;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=xDi8oFw3VzJyuV5g7iQWn5k67xLK5Zswvz7O+MebhCI=;
        b=dNXvrJI8FqgpueUQnQPG98ifEbBsd7HlNMtEhaduPgDExendtUQ2Jft+g+Z9xfcsE2
         Y6w5TQl46CYE6B0GkFv/b43SzQKPvirlKZ5J5KfNWQWdGFRkTAzqEmx79Xpl1WKsGAGd
         QJaP3Ab++p2PKTnVwX+jfTLJuul3u900OkqiPnxE7YuxoyW5mNMJQ/Hqaq3lEFHp3H1Y
         Gd+fqh8emhkasDmFTuxC8XNh3aBLJePFTQK0I+4oGKUUAS0Y0Tu32K01uA7NHXV7kmRH
         JuPXYuZJk724TOgXbHm0A1LmIsFvTC16XDcxEXqWqikkhkfajHH1fitcv6AmYc6KZyLo
         Ns7Q==
X-Gm-Message-State: AOJu0YxqDEIg6DBqY2QSYKdATvl1ut0D0mPq8qlWK8t52fsuGcwBCjYt
	RiaXHpAdeLBeRRPf8TJSTmNDCux2KObJ9yEkljrS7klzoB0eTgZAytC2oo7f+A==
X-Gm-Gg: ATEYQzwEm4K7W8D3mcnjSS2jwBT3ChfY2bLl7PFH1dTQZX0ijJx5Ey0eT+a7rQks+Zk
	u0r+aFVl/C3B8843QZWqXro1F5Pqcj+fp4T5IOoXdqk9tRhm8iTJ9EUU9WRKRGqtNXzVtUIUbX6
	Lc3lDgf4X0kABg92rhmyTivHgbaJf3MvZWP7wIUSERJN8gkjgaa17FSBL45Z8/P6wcuHgrY361K
	F6HmJi4NRLIbUwuYgrpXP8RzJBlPPuSO931JQ20K9AFJDdh6WwcgJ3F3FbKtQLy0A6+DOYs5Gvk
	q0M+td7CZf7YK6QS0ch/4zO4TUcMMX/YPgr2H3SBiAliynVtcYmzcpeiVZ9VUKgfO56ilUoSxoA
	ZGDDRwa7kDJIPid6SUhd16Ucv0VFVkcW2g0qwjGeJlkMKm/Iqcx5OZE487zsCWhWXME7Gf1WbBK
	BF+XNigFRmbQvEXZlbZbQSwbXMwQ==
X-Received: by 2002:ad4:5be8:0:b0:899:bc1c:e599 with SMTP id 6a1803df08f44-899bc1ced04mr38960216d6.48.1772050642010;
        Wed, 25 Feb 2026 12:17:22 -0800 (PST)
Received: from [127.0.0.1] ([135.119.235.86])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8cbbf72d3casm13273685a.42.2026.02.25.12.17.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Feb 2026 12:17:21 -0800 (PST)
Message-Id: <d2c5ca09396e020adb717055d82f50de7c1b7431.1772050636.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2147.v6.git.git.1772050636.gitgitgadget@gmail.com>
References: <pull.2147.v5.git.git.1771896704209.gitgitgadget@gmail.com>
	<pull.2147.v6.git.git.1772050636.gitgitgadget@gmail.com>
From: "Paul Tarjan via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 25 Feb 2026 20:17:09 +0000
Subject: [PATCH v6 03/10] compat/win32: add pthread_cond_timedwait
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

