Received: from mail-il1-f180.google.com (mail-il1-f180.google.com [209.85.166.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5501E35E545
	for <git@vger.kernel.org>; Tue, 18 Nov 2025 15:41:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763480520; cv=none; b=iTYtRXNjuUbhSy2H7W1E2PwPGbK6+2l4P46W4qI6qSoWO/wjbu3IBNwFewU1iZw0DVRbgHsl5+oFRCcX42rz1ou6SUKbueHizPBCmqOZXLuQiI6M0daCEwDFsOlTNP7gZzpHpjEvr9/3ZwdWU9pxzAcfiOBr9Gl8fBpgPOzymeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763480520; c=relaxed/simple;
	bh=RDn0jugnFevBVyHmnqKbqNTL82WyAXrbmNxvl1fdZ7k=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=facRMjdXOrZu7jd3XbrakiJYYgKsx9xZp2YHwW8k8inIrFo0n6dDKwr2c54FzGy1NspxsBjSfPxOrIWPUL/tlEXTMKe5Nx940sqedxgAhp8pM9hGcmfyGBgL8aSBK5pdzsnWvwquoYcHVTyzW6iMWoBaxRu+bJk7W5SZYlZ1YRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y3u59lBX; arc=none smtp.client-ip=209.85.166.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y3u59lBX"
Received: by mail-il1-f180.google.com with SMTP id e9e14a558f8ab-434709e7cc9so25182105ab.1
        for <git@vger.kernel.org>; Tue, 18 Nov 2025 07:41:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763480516; x=1764085316; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WY7DrYj5uKfgxHOSX0YEfmrpJTMgP7rEL2xxc2pIGXw=;
        b=Y3u59lBXyH7wgvhAc1I/N/ifziKrpPJ/AnJphSLzxgUSIYTPgBZkIXpCTsIUSks6En
         abR2Y1bBP4L6JFXaWM4ywsA/AhUz5jCzYWb0bt3rqn+UY5hFoopzPg9rSgP9F0EOvkIn
         lAvxzkjC3lmYj1FzIj1TfG9ghqLI/19h87bT1SjoPR4p3rB4kkNWKcxROERqGqKM6I2B
         SPaQ/T1OcCjB+3hgCEGCbuVtXnGvlUdpcpNT2JjC5jdJaYtP1VluWGkLhcUNuEvaZbhx
         5JQQBe2nnwtqGPlZNIC7/fCcX8W6KTqiCgxh+IrEeVrWstvodkJfNPXhqetPaNDjlvJK
         pzeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763480516; x=1764085316;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=WY7DrYj5uKfgxHOSX0YEfmrpJTMgP7rEL2xxc2pIGXw=;
        b=U0huu9dgr7hXEPNbXX4UIAJuFJ2shr4QEN9a4EVo/2b0/bRBaIBIM9Pt9MNTJqMWBs
         gZVJnauGDV5Xy9jMjspfvVQ3TfkxdIfLQt9hyRBm1VUERT/RMRNDljF6dLl4uNGAzYWX
         BWUazZdo7Pir8fbsQLzfDCdtRGm/4XBwyAVVRYmqr4RO8oDZdZyfvel2N1dHB91QyXbp
         MDCkQOZACYuPG+J7glXrW2cytYbsdWogOy0DCP3MSsLhP6osK65V3IWABo8VBG3M1lxs
         hNiyk7mUqavD38iVCXhjBH2KKie7mLUso9zzqktu7qJafip4pnl5sHcEHHD8D62uZ9wo
         nOtw==
X-Gm-Message-State: AOJu0Yypl6O4Zb8jGjYN6d/xt96zLlM8ktiTcKxBnVAwYVdSEmtn6sdL
	eymhn7HpJp+acvRLnmKIWE/0ZGgmQTBiCXagkm7ug3L1cJFXofCWXVe8KAUPkw==
X-Gm-Gg: ASbGncsp1KZlafX7bR/arbLQtM54oiBFPJJXAXB0A9k1dvkJYmd5zZ2EbTX+4Exz9ta
	FMrSJvDaJUHMmd24xbf9C/DsQiYYlPBImGYPj2K14Q+gi99wX5H58qcUuirt7D9Z2pPZSZuHhhB
	HTHD0g3K+MS+TVPiDNw+Vl+9snlsW0v1EZuc2EiFEbLO52C+RhYCRZBK5Lz7+t4tmHZ5hOHwzYx
	lDfjZHG5TIWxMX90xD0055QFuKlyoyxxz7YUWHmHzVFdDvPi1PJBY9w29SgeHUCkK0o+tMEl+MM
	CgHV5pgjQi9zciz4C5v2vepXX9yxZa3Q9agk3URZ9+D5bYIKCM2mpjeRbPNA6XDmxGE8oHT+sdK
	AA4rLi1+Q2dNcyyzEGE9UkhmRtnGSjnQMrBAwa4cdEbmg9MmLuc56VinPepFHqhFLNeg6fvettY
	QQE3nrLmxihReUQQ==
X-Google-Smtp-Source: AGHT+IGjxgNLwXI5ESkLa4SEgHNhFEN3Zn5I6BQtqVJdr4mO3aaI+wgOxZoJeUVBe8UBeVZh5d3eNw==
X-Received: by 2002:a92:ca09:0:b0:434:767d:8a4a with SMTP id e9e14a558f8ab-4348c8fc067mr200269885ab.18.1763480515691;
        Tue, 18 Nov 2025 07:41:55 -0800 (PST)
Received: from [127.0.0.1] ([135.232.201.69])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-434839a4d2asm83255465ab.26.2025.11.18.07.41.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Nov 2025 07:41:54 -0800 (PST)
Message-Id: <pull.2104.v2.git.git.1763480514065.gitgitgadget@gmail.com>
In-Reply-To: <pull.2104.git.git.1763427591884.gitgitgadget@gmail.com>
References: <pull.2104.git.git.1763427591884.gitgitgadget@gmail.com>
From: "AZero13 via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 18 Nov 2025 15:41:54 +0000
Subject: [PATCH v2] win32: return error if SleepConditionVariableCS fails
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
    Greg Funni <gfunni234@gmail.com>

From: Greg Funni <gfunni234@gmail.com>

If it fails, return an error.

Signed-off-by: Greg Funni <gfunni234@gmail.com>
---
    win32: return error if SleepConditionVariableCS fails
    
    If it fails, return an error.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-2104%2FAZero13%2Fsleep-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-2104/AZero13/sleep-v2
Pull-Request: https://github.com/git/git/pull/2104

Range-diff vs v1:

 1:  35384a6aa3 ! 1:  7bdcd55664 win32: return error if SleepConditionVariableCS fails
     @@
       ## Metadata ##
     -Author: AZero13 <gfunni234@gmail.com>
     +Author: Greg Funni <gfunni234@gmail.com>
      
       ## Commit message ##
          win32: return error if SleepConditionVariableCS fails


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
