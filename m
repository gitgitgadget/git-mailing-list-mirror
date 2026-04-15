Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 773F02D9796
	for <git@vger.kernel.org>; Wed, 15 Apr 2026 13:27:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776259668; cv=none; b=d+u5YFbGFabLMto1eCe81ti/Uc0M3FI/TcxszHdEDsV+pEq1KZqABLHriFGgBYy9j8CJD1rT6tFw0yXseDd+Pw+Cw1WQn7aPRXUZivzoN8KwTGaiWH+ABt7kG62C9j4LwvbURbpIg6lj2h0ZviXynIzSi4dPvJIKaS6JuMP5C30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776259668; c=relaxed/simple;
	bh=JQJPUnNlc88YOZjc+woeZHt0OERzy3a3Bt1KoYQ4zbU=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=i6yKPN5OBcpu+8DrlJa4P3vZWGhe6x64gqowpTjOVnudmzrV3bXMS3CelsA9yqSY2xv2e+NqwvUYy0t0zDc78MEgvqVrJBXnW0JuexUHw6GCW2o/caXuE1+ZKqP6ucxH4IhUMzMqsZnrCm4dv6FgQnlcJf63PnXyPiLm1rqG5Oo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LpOtR6Y2; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LpOtR6Y2"
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-50b2b289925so55615541cf.2
        for <git@vger.kernel.org>; Wed, 15 Apr 2026 06:27:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776259666; x=1776864466; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=utSML8XDRWikFjEf8OTnGhOa1Cm1oF1YFZw6B0GetW0=;
        b=LpOtR6Y2fw9aBMtME7j5/l9MeNrWsHElJZttDwGSJTLVOVSwxhQ06Cnrq2a6yDZnCx
         sGWjLtqkgELaG1CkNSvQVPo9LgYOReolf3INTMs4CZWBnZODg4x5aZQtp75P1WaspHJJ
         hHGuak1hFLaOc50Ije5mN+yijYHm1xfC9XzwOmRt/ylhC85hToxvaxFVLJcnB12h6Yk3
         SYDkk8sfl6SxNWHzhvinLCPoxrfowAc4GhhNYry14TGS0cayNgqfn/50n2uhLKTL2fVx
         2ihBECSTShWdTZu5EiyX8UbUYlyZWsFS7FRza4J21sPbR6mgwXZOWVrHpinmpIMupuG5
         wCBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776259666; x=1776864466;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=utSML8XDRWikFjEf8OTnGhOa1Cm1oF1YFZw6B0GetW0=;
        b=XJL6qXBEg8X9MdGWOhXFHU+/QpfIWjSEfL0Fe9Hq83ES0XPfq8pIUNie7deRhNIJD8
         Mf1ahyMVpQcC4d9MwEcTG1rOfefdeWy3IzyRicWaAX9YBniOqb/a7twk5H9TkvJgnDQF
         SHoVc81Bz9ACanqPE3yE9U1yR4zqXLpH7kt3gn9ZBcBQGfNz93pJOnx5+H/AL1W+dWP9
         5t5c8YeCn28tXsXrvSZouOSbFTJF6tm8Ruktv34LuXHEGPjQbvbQ+jxQ1fHxYLFIAdbQ
         xvH95osKd1wuoofzrDzY+Lvks6ZWEFeOYV3XFcuQKN/pRdu1LIgC8/Hr5rrsKG8v758v
         2dkw==
X-Gm-Message-State: AOJu0Yx5LIwFjgdINpOwjtLmdklFW5tu1pzhsKt0WUYW2+uylI4hpngr
	nsm7ZPK5qe/SOnjeaKomgbSXzmrg5jO729aOYmw39UKqGwblTqieKCtW7JGpew==
X-Gm-Gg: AeBDieup6PhkOuCrxjykS7MFcf0SnM6GRxqgG54DO+QoUHbLHjzDtWPfJOuxQ6sBphZ
	39VYKTTr9xuxUVTVlhidMWg9GzM7UYKql6fJD92ecCGbiBFtJRXuhcsJUDAnmwaBovcg6fr1O33
	Kl4+HwZqPf/sFJwcNXMLa+XtSE4HYgSWjjQxDyfyh02hCy57zpl0JvYE0yUmd1aQLn98misnBCJ
	Cpy5vZTiBCNGpxWgNxGrEMa82yzj30H/GloSzTv5fRDzuf7CBJaMbFiPli6Bup5Vowx3Gu7Ho2p
	X+ThiMeQ0CiDMr8584WjQFeWBYexFaIn4dDKjPBXXq3Wu2N/lE1377b5TeSypMXEjSs0CfhUy4l
	ykYLUMH08vEeB8gAGimO7lxAFgvijnjnr+EFjf8vZklZfZD686Plyd7hsvqUuS8BKxXEkYx9YlA
	NCWyswx6ggK3PoIXjOS5XPI+XZ2A==
X-Received: by 2002:a05:622a:7288:b0:50b:3fbe:a0de with SMTP id d75a77b69052e-50dd5b776d0mr230453441cf.32.1776259665883;
        Wed, 15 Apr 2026 06:27:45 -0700 (PDT)
Received: from [127.0.0.1] ([64.236.134.18])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-50e1adbcf10sm12443511cf.10.2026.04.15.06.27.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Apr 2026 06:27:44 -0700 (PDT)
Message-Id: <a0d430c2f46b598f21943cd0ba846f29d6b3c3d6.1776259657.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2147.v15.git.git.1776259657.gitgitgadget@gmail.com>
References: <pull.2147.v14.git.git.1775710775.gitgitgadget@gmail.com>
	<pull.2147.v15.git.git.1776259657.gitgitgadget@gmail.com>
From: "Paul Tarjan via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 15 Apr 2026 13:27:28 +0000
Subject: [PATCH v15 04/13] compat/win32: add pthread_cond_timedwait
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
    Paul Tarjan via GitGitGadget <gitgitgadget@gmail.com>,
    SZEDER =?UTF-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
    Jeff King <peff@peff.net>,
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

