Received: from mail-dy1-f173.google.com (mail-dy1-f173.google.com [74.125.82.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCDB3312837
	for <git@vger.kernel.org>; Thu,  5 Mar 2026 06:55:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772693724; cv=none; b=DkMf/Lhqbu/oeSrtNWFmxqqtz+0ZMUKQUEvCxVBRlnZkZ2gkHYGbmDPa1DwIf3uEBWd3PQRVY58zdnQR/BYXLbyb4DNUCDdPm6Niv6A9g5qRwLR157Bt+d+mnrpzg+OdJB88ctE/2JQs+KoSrfYi3JLdsWi47Tki/MESSQ2zR20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772693724; c=relaxed/simple;
	bh=JQJPUnNlc88YOZjc+woeZHt0OERzy3a3Bt1KoYQ4zbU=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=U7xpO9F3jnreakJCit8EGXddaOrUPsuMw1tGz3t4pI/MCAGqgSKtXPrkc1KhKelN9o28bwmVuSbcbjYbuoT9i+HaKqwJOmy/o9HG/OGUN7P2ViismT3K/iZ67npqW2cWDO4PmRs6YE3g2NShKXgB4zkG/pbw6nj0tALfTf8bBjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j7wYnSd7; arc=none smtp.client-ip=74.125.82.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j7wYnSd7"
Received: by mail-dy1-f173.google.com with SMTP id 5a478bee46e88-2ba895adfeaso6820162eec.0
        for <git@vger.kernel.org>; Wed, 04 Mar 2026 22:55:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772693722; x=1773298522; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=utSML8XDRWikFjEf8OTnGhOa1Cm1oF1YFZw6B0GetW0=;
        b=j7wYnSd7iatjZUoxjpWIuUq0nSQKlUJTFIZTDu33xLyYrKHypmtG0whq5gnlinJqVr
         li2ZN8vaxTDIDBSofJIoxJwBqiFSm/pDYncCKeAiz10Zn8ppisAzFS1VcpDyh2v8DP6w
         IRMfp/3AV62iReK79FMRcI2cccDUu2R1PqEe7Uals5w2w6BaJdqBNBbw+MUZu6ZFFap9
         RYPC65x9wqYK7IcVLi6rqrPDswbbIJDBsTLivz8QnnCVsRii+bjRfja+6xvEilLS1IbC
         Ekkl9b5jDV5ctXewG61XudgVe0B5CzyV19MCDNSTAQAI809H5O73DjTv9wobA9pT0cXH
         4xzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772693722; x=1773298522;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=utSML8XDRWikFjEf8OTnGhOa1Cm1oF1YFZw6B0GetW0=;
        b=WV/C4T8IODC6ybxfLEKhKVpRNxjKwGK+tLlyD429WFHcUKJBb9i400syNJ0mDPFv9j
         XHK+7eNb9jf+CyN39JmEI4I4qqTuyNt4LuBPt3laViHDKeNzU+ll1ovKEf/iobKnQMTD
         4pUjJWm0PD95me0oYz2mxnJ0YDqIeU7pM2cKGx8HQZUKkcKvT1a8MUOWo2cOho6MW1lK
         1IthusIjCPN6ycCdEeLzxNaGwaYlKmiDUtfp0Efl2Z+iHxcNKvA79BpDjR6s6B9CT88m
         6IDT2uPP4KWWcW4tJfZ98Pkzcq9LFnmK7EszvxZxI5tFAOwS/IZ9ps0Ii3U7oNnMMt6C
         dwrQ==
X-Gm-Message-State: AOJu0Yy9QAqdoKDmOlu8XqcJHT5xkgr1fTPh/9GjLM9mexKFnjtpNh92
	FmGUGHzwsMUprDZ11gaT/5zJ3EHyaJoT4PH/zCUNAG+mLtd2fTrjxPmjQeq97A==
X-Gm-Gg: ATEYQzzfjjjJLrMEGTkqpiOtoHoZ4/Eo7zbYcXpRnavjccbLWldVuIPXzoy2hVB2jwt
	3OEvSVyYuNFlNxjFwxv9o/vsi2pKHnaWswnjCeiW0UYLcO7/N/hGTM7/e+tg19zqgym1GukDy3F
	IE3g7YcKG8X/qSPz/KqzDIZB8/bCUF+WIpkqmkPrXiHu5hzP+SsKOSesxDgQov+e0bXa/1V9dgY
	MQYEu3araCXYNiU9/x2s88BVcUOLd39iNBHDOveJLtd+zcdZNm+LK7rT7aSsUTzoVTelTTgMtRm
	hgxZ2qCLkzRQ/++wRTwtBJq5wz6O2chUoKWZkK4gBFi10Mm9W7VX794SjE0HsxYBAqJsQDxWtn+
	/qGqBiuaIQG8j6FJ3S2dnH7TM5PZMUQoolV2Or3sfbM73in7PtLzIvngOcvdlXT6FXzvbgtD145
	qA2Knj0IR9UD48YKLNZ+9FnzDeBQ==
X-Received: by 2002:a05:7300:ef97:b0:2be:19f3:5a03 with SMTP id 5a478bee46e88-2be30fdc2d9mr1939850eec.17.1772693722253;
        Wed, 04 Mar 2026 22:55:22 -0800 (PST)
Received: from [127.0.0.1] ([52.190.182.112])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2be381d5ae9sm1653869eec.26.2026.03.04.22.55.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2026 22:55:21 -0800 (PST)
Message-Id: <44a063074dadc27110e2dd3481756c8c324ed956.1772693712.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2147.v11.git.git.1772693712.gitgitgadget@gmail.com>
References: <pull.2147.v10.git.git.1772673378.gitgitgadget@gmail.com>
	<pull.2147.v11.git.git.1772693712.gitgitgadget@gmail.com>
From: "Paul Tarjan via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 05 Mar 2026 06:55:03 +0000
Subject: [PATCH v11 03/12] compat/win32: add pthread_cond_timedwait
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

