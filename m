Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 287DA21CFF6
	for <git@vger.kernel.org>; Thu,  5 Mar 2026 01:16:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772673389; cv=none; b=Vfm3uyF9/3E4psi9FuylBVE8r00vbvpXNNRWfznPwNjZj7So05ePZU4LqzcPEnVzpyTVtJOmj5NlpWb665oW1DBbQev2ob81ylhPh7Mq4KJuIoIW98w+slpclCYyPZ8RpMZfbKtwV/RyWVFh+RChApOcDoOIlZBEpsism5zAM7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772673389; c=relaxed/simple;
	bh=JQJPUnNlc88YOZjc+woeZHt0OERzy3a3Bt1KoYQ4zbU=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=gfcPn0WOkTT7SJiLHFendDnX3qF9k+oZdHgdICtSnxHq7KdQ3GQlL6ICa+WxXI4nv1yeFg/QBzncp8i1V8w0h5/88HaNhkIenPGpYYBCbsOyMaLfOzSJSjyrA3mDc37sEjrOjs1HOlIPagF8NOUUsYJIKumeo8+cJXyUQGrSbk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QvJ3sbAY; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QvJ3sbAY"
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-8cbb6d5f780so754828385a.1
        for <git@vger.kernel.org>; Wed, 04 Mar 2026 17:16:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772673387; x=1773278187; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=utSML8XDRWikFjEf8OTnGhOa1Cm1oF1YFZw6B0GetW0=;
        b=QvJ3sbAYP5ay0IVF6O9qIfn0ECsMRR2er1ct98YrEmm3iZFfEgcYIrJjHkTE8cqzfN
         zlzzPW4XGB1DfAo3Ck4SQxoosjI/k/1KOJTOpyUVZKwACHxW+CLeBFOYxlaiCInBMV4Z
         pcnZYLtBBrb1LPMYq+vrlt9Nkey1PmhsXM7bdZ5PJ6y1t08vyjCzRxl+a5MhglPSIEYj
         GO5Ci3khToR0/V9GL+U/cVNb8r+0qRcTg/LksvUX/2wzwHXNqrXoFEy/KIOU50hpXry3
         W68qwNLG2isOHFWX6pXPQevSHeTuPbfsp4UAlDoHs/uyrrw84oWvnzYbaifiJplyJzVk
         6Ygw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772673387; x=1773278187;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=utSML8XDRWikFjEf8OTnGhOa1Cm1oF1YFZw6B0GetW0=;
        b=ULe17NjS3nDsQu8A3nAM2sDS64MxwF2CfvrgHzucHTCoV7LgD2xK9n4NJvoeU7/W9S
         pBxMjKFbVmRq/6RMzTTtgDsInyBYc5P/5WJhbtuie5irV831jFtcKPnWKM92jtdAnSZr
         tcdoTDMXEfrjTVAY1KGRc8r77ow+NAhYACSPY/Fq4oZ5+2tn3ajwHhPiSJnlGf5qjZQ0
         7OPb9fZbwTR5vt017uE/A0K+DYB8FNJAF7oAZQfniDcFsXrJuNaF/nTA+HxQBLneoi64
         8DBYCbS5Lg2a7wWgBLRnJIXvO8kSPZMVX8WdcNfkXOqYZabmrRcTSYdUO5cIAIafW9n1
         ZdTQ==
X-Gm-Message-State: AOJu0YyxJhVkggKkgv9eLWxFvRQRF7TXm+o+T05oSu30GggGJsJ6nM7X
	vel3zAwPC2OAUF9208wkFvphOnSLOoHjEwNiZYsaHDgyCxmfVJFE4yqAxpW5KqGg
X-Gm-Gg: ATEYQzzj90k67GwsnAGNB7cCQdhBQ1fqN2i5d2zvaQ1Svrna0cSCaXwcdZI+E7vZWTM
	t2UW7Qs7dGYK8K+97AWfgwOscLTAiOpe6ajZ9AQzqUrnjHTC4Mhr84w30AIlew+p/KWfiwLkQvS
	q0Kly4KI1ibD0Q4XCqLQLb+UOlTD01ZZfq8gsvdWZKBuK3F2Uhr1CXKQgFyPmF73hPdF8M9BnzL
	orPS6TI7weoNst2/u43C0ymk+aYcqFlFSUI0DQkji5uhft1hoUGOnV/vB8ibFvW/0hDBf9ITgAm
	9nvK/uX6uR/8yFihhPsE6iYheCzFEGrWNyoKP+QPS12yuk1robCisQlVGw+qhCi/A10nKxykdub
	zx9SeSOU+NE/vZtL7jJInELQq+nrVd0X+vVqmqPc1LoDC5hOq0SfY7sXZ11baHqYwFcskFHFahU
	21e4AufZQDhUx5kdsLYHlCWbY=
X-Received: by 2002:a05:620a:1912:b0:8c6:f411:5eec with SMTP id af79cd13be357-8cd5af817a2mr546851785a.38.1772673386649;
        Wed, 04 Mar 2026 17:16:26 -0800 (PST)
Received: from [127.0.0.1] ([51.8.152.229])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-507451cda0asm183533731cf.24.2026.03.04.17.16.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2026 17:16:25 -0800 (PST)
Message-Id: <44a063074dadc27110e2dd3481756c8c324ed956.1772673378.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2147.v10.git.git.1772673378.gitgitgadget@gmail.com>
References: <pull.2147.v9.git.git.1772671920.gitgitgadget@gmail.com>
	<pull.2147.v10.git.git.1772673378.gitgitgadget@gmail.com>
From: "Paul Tarjan via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 05 Mar 2026 01:16:09 +0000
Subject: [PATCH v10 03/12] compat/win32: add pthread_cond_timedwait
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

