Received: from mail-il1-f177.google.com (mail-il1-f177.google.com [209.85.166.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 115B92FABF5
	for <git@vger.kernel.org>; Tue, 18 Nov 2025 00:59:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763427597; cv=none; b=om8Zw6zykkm3NnfYm2fcT7OXzDFT0jUTordqQdcCu9GYPOU2FfOx+3Dlju3PpGjKfRkOD2la/mhLt31lLThEbx4sJ0OI/8ADOUaVJ3qFwfizoPvRFsbMHVCqlMJTUfVieGKS51WFpeM2DHIRQEAr9VQQWhUu33AP0wA3xGCk2cg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763427597; c=relaxed/simple;
	bh=B/YrhnZRihyCQ9LBFtydMsCxGxTaNQG4tr/BDJ5i7sE=;
	h=Message-Id:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=Iq6ToZDtfgV/Hlz+b/Kns+zyJe0yhjKa9MXyXN0qhqJYdJGcZ0xa+STWZEngtcY4YqxF84q9W2p9QSfBBLRc9bb4YFBxcBMyc7IUpttO1nY1jFDvOIUt0ydrt5sOGq4fsWW6FYzrhKaa1ByDc1o+WBNmymPEs22wXc/9LpAnnmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Cpxmk8JX; arc=none smtp.client-ip=209.85.166.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Cpxmk8JX"
Received: by mail-il1-f177.google.com with SMTP id e9e14a558f8ab-43379251ff9so26673635ab.1
        for <git@vger.kernel.org>; Mon, 17 Nov 2025 16:59:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763427594; x=1764032394; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=cYCQej9/us+rkMYw1S3NjXzyNVXQGv7neflCeXUlKFA=;
        b=Cpxmk8JX5mHcw6ufNIcS2LMWR2/6TeFQYEUsBIp8MSHlXS4KVR1so2SzotNKTLUeY8
         gZMbLpHxbtESxGOfD4XUnWTRLb6Nu+S0fgoVylsW6APZMZBA/Bw1udJMZ2DQQl2DEBEt
         WAHXhNM7XBs8dfKwIlVDvwA8kOsDsHeUMKzEUmc81sp4aM5a2qrcIKwZCJ2jNzXjkOGD
         RtTK/c+Pji+WMhmBu2+X//osPf17zdTcmU5NwdwN3HfUnEamw9GJNAbF5r5/NNAV3WUi
         hP1PYPs2XETFlvwNvy24nwNhOqUNkXtjrkjuCUwDasIs0fiuJ57tmlZYuiy3BhzSrlLG
         Zwmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763427594; x=1764032394;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cYCQej9/us+rkMYw1S3NjXzyNVXQGv7neflCeXUlKFA=;
        b=F9g/KYfmKm46oWH19683EK2avg7aPi/RLcFzguNWzsOwKFxSEba+OnoROWmcQI3OOx
         Y/vPZ8aOv61tIvXu50+WuvcDQ+SX1QZnObdbfejsQ+FKdFyVqaBetsVqAQZbOQUOxCAq
         c3KuApNAaDn+XDN6uLXK3dePPYwEIVjlvUEHRfj5+csdBDTDxUvPQ68LS4EZqmCITuS9
         jCDJ9oetIsjYqIPgXFHWTAeVj4dGrIXo9YMGEYPuegx7VnOan0gg64fJk9+BxUTU/Old
         JZlk/JTAM6fGo8QOF3EHxvMQqgZ1koMJjQXr9SYgD6LD/MYZ97QYx6AKFDJDdrj0w4XA
         9T3w==
X-Gm-Message-State: AOJu0YwTPcGHR10tnDTMA6jiE62cOtxrWzYOsI8hV2jURyO6ufAGbevD
	NpWQTpzUmX8/asEScVKLUKxRggY44UJXbxlvlmpIwsum9eMKxM/8giQWST0i4w==
X-Gm-Gg: ASbGncuLoVOfP9nJFxR/ZxfIMTzYfhSz3DbLNCoJtitXVt2bQ+KnbiwqQWi7mWAp/qP
	1U9w9F8m1F30AYjsmOTZ1mjxBrMOxeG7AwtmQDHa+tq5KrdldCpUKby34s4BEo+VZpaiMlN3Xob
	ErTssaOr0HUsAgwqAmoy9985nMn3XHpfzNmkY252Mg24CyUUJw6akWSu78F3wCRdrtcr/ch1/29
	uROkmHIzBKOhFERIQNMP1j4G8S0uBVNkLkJMOgvT4CUwzUKN2QvmXN7FWTJaXmzSiNImomiS4TQ
	Hcj9fd/f2neGD+7dJk2OnllwoifDGkRplLQ3ZXPncZkAY/vdIpDupqt51lc9eux7EizVY3OJS76
	ffS4ifbkuwb8TIJxpahpTSgi7dQzVEuyCR73TQyJSnCSK/E/JqXj8f++UF4omrJY/3bQX3AyCMl
	srDTkSNQOaN69vHA==
X-Google-Smtp-Source: AGHT+IHgxLN68aDzbEZhHqJLdv0WCdQJIoVES6crLMj5cBYZ86wjtCBMg8EuEs8gqJZbPGeeaDD2DQ==
X-Received: by 2002:a05:6e02:1f0c:b0:433:43fb:37dd with SMTP id e9e14a558f8ab-43592dc0509mr18242735ab.5.1763427594625;
        Mon, 17 Nov 2025 16:59:54 -0800 (PST)
Received: from [127.0.0.1] ([135.232.200.32])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-434838c45b2sm78355035ab.16.2025.11.17.16.59.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Nov 2025 16:59:53 -0800 (PST)
Message-Id: <pull.2104.git.git.1763427591884.gitgitgadget@gmail.com>
From: "AZero13 via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 18 Nov 2025 00:59:51 +0000
Subject: [PATCH] win32: return error if SleepConditionVariableCS fails
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
Cc: AZero13 <gfunni234@gmail.com>,
    AZero13 <gfunni234@gmail.com>

From: AZero13 <gfunni234@gmail.com>

If it fails, return an error.

Signed-off-by: Greg Funni <gfunni234@gmail.com>
---
    win32: return error if SleepConditionVariableCS fails
    
    If it fails, return an error.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-2104%2FAZero13%2Fsleep-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-2104/AZero13/sleep-v1
Pull-Request: https://github.com/git/git/pull/2104

 compat/win32/pthread.c | 7 +++++++
 compat/win32/pthread.h | 3 ++-
 2 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/compat/win32/pthread.c b/compat/win32/pthread.c
index 58980a529c..7e93146963 100644
--- a/compat/win32/pthread.c
+++ b/compat/win32/pthread.c
@@ -59,3 +59,10 @@ pthread_t pthread_self(void)
 	t.tid = GetCurrentThreadId();
 	return t;
 }
+
+int pthread_cond_wait(pthread_cond_t *cond, pthread_mutex_t *mutex)
+{
+	if (SleepConditionVariableCS(cond, mutex, INFINITE) == 0)
+		return err_win_to_posix(GetLastError());
+	return 0;
+}
diff --git a/compat/win32/pthread.h b/compat/win32/pthread.h
index e2b5c4f64c..859e1d9021 100644
--- a/compat/win32/pthread.h
+++ b/compat/win32/pthread.h
@@ -36,7 +36,6 @@ typedef int pthread_mutexattr_t;
 
 #define pthread_cond_init(a,b) InitializeConditionVariable((a))
 #define pthread_cond_destroy(a) do {} while (0)
-#define pthread_cond_wait(a,b) return_0(SleepConditionVariableCS((a), (b), INFINITE))
 #define pthread_cond_signal WakeConditionVariable
 #define pthread_cond_broadcast WakeAllConditionVariable
 
@@ -64,6 +63,8 @@ int win32_pthread_join(pthread_t *thread, void **value_ptr);
 #define pthread_equal(t1, t2) ((t1).tid == (t2).tid)
 pthread_t pthread_self(void);
 
+int pthread_cond_wait(pthread_cond_t *cond, pthread_mutex_t *mutex);
+
 static inline void NORETURN pthread_exit(void *ret)
 {
 	_endthreadex((unsigned)(uintptr_t)ret);

base-commit: 9a2fb147f2c61d0cab52c883e7e26f5b7948e3ed
-- 
gitgitgadget
