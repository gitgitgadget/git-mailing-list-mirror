Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B73952FDC59
	for <git@vger.kernel.org>; Tue, 18 Nov 2025 01:00:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763427610; cv=none; b=geNBPyI6y2uMBCx3tiz8r1shdAFmSFON+A6m5WrKhl6iZNm7bCQTidrqJ/LQBvje0wuMohuInpXg/Dr0s8HhdRDkxfntBN1IEZ35KyBi2e2V0mz4Uoko4TgBn5YHMV9HkmV9er1WghMsEXj5ZT0MvO5Wxj0oY08Sb8IfOaPk9eE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763427610; c=relaxed/simple;
	bh=49dm6NF0OU5O5WdM7jUvpBKi76T0ByRi50fOD8n8yyU=;
	h=Message-Id:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=HuXreuNnoxEr9R9nzcwthJZJk5tWp1Z+7z+a4xDbxM91OA/fL24qhd3v7j1GYcjJapSyAWC+ZeBH2ncsIiv3bRuyNFNKAJlN6+65WueugaTDwQFBXheB95XPKGuNTJ4Zb2amlZzmTw7vN0vCCkBMEkt+HYwDYSDYkBc4RwwpzxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PSfO27SD; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PSfO27SD"
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-4eda6a8cc12so47728591cf.0
        for <git@vger.kernel.org>; Mon, 17 Nov 2025 17:00:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763427607; x=1764032407; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=XEwYoPysr194r+aOOg0uhVCQk/p3zvctxm9r7MVUfzc=;
        b=PSfO27SDvc/zJuGZpXnhRmQYA0/t2Epiih/+hBh0DNj5hK03MTUqr9KmD1JgopA8/j
         D5eXariNbLE3sNUMpc60HsEqsxIbiqYkyPKEAZLlXo+gjtRWp2fGExGMD0kQRhNnkTTT
         yzRKQ/5qLZme1F74GKLnrwqkFMVu0ySZaL4hHP7h4iNICFg5IjcblsVWJFfAvrTLBz3a
         KqefDg79ijZZiUpINTkC5rQixc8c3NfpUZZty7Q6ufcSwnNpcE2LLk/g0Le87ArokEMS
         KGA7m6vj50+FzzLJW/9LPqopN+x/nArpOJ4vtQwe45oyB36dx+F5LNXc5s4iBg5tbkuF
         xi9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763427607; x=1764032407;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XEwYoPysr194r+aOOg0uhVCQk/p3zvctxm9r7MVUfzc=;
        b=vE0yhBR3D93kO5OQepNgM4ujnG9rNT2bbsBIoFjx2CVqxLjQBZ9QSgf/rfrLO7m7/i
         rjb0PfwpAwf4KMeGFetq1lUxGxxhdQkUUU6exiRNFhWLAHSHi5V6l0v9k0zl3tu2ML3e
         Q6WJuCDzy/80sj/UkGllAZn52JNTXDSl5V2m6uP8L/2qV8KPEEpKSIToYKk4rVMrAjyR
         5Xk8epL60xmKufRAEuTmMq0Ak0fJf45hFpgxWrzlOkdEwAm19clcqO3fYGos2DE+sJPD
         kMy7qOmXcfVEIFXAoMbR9D97TU1hh5qKqsl/u5+hc2P8HNtYA78kw/EqroHzKrxHGMKp
         7Afg==
X-Gm-Message-State: AOJu0YxjlU6D9DghMSqeWM86BGhfYRogNg27RceQh3DsV6ipOEbamQGd
	1k+ThAn3k4rGRY2Vc6ysesBs4fAy9a7bQFe3fXsuutqdRsZi7rdVly4uVXU25w==
X-Gm-Gg: ASbGnctwPkVlTA+IPcaHzf70zIbItY8Mc4q38g4V+0Ok29PtMLwQOeS61VZJkfPqMWO
	ZhJRNBMN+zWjVsbY5CxHAKfN537EqFbMZllBxpBhWZw1tWze4I5EhS6NLSm0ud2Oz2qD902Edfu
	qpTHe34FDxhkrh3p9N571MU7CMH5wKDHAhX0Nta1z3NxUyyr3JKKKkqtVHNJLMotjx5r/MbRPJZ
	C2FJ7HsuEMHbW5fii0zSdntU9+AoINKSoN9ZIceFWltUhdxDKwsUQdBZfhttzi6FJHaH2GZfYAR
	+UQuKz1kL6Lj7xwtg4MpAXXwoy4GroL4wldY/p54xRWKd4ujijRG3FP1cYvgYxLSqhGaGKqWiq0
	92uk6Qav7u9Dl+DQ/FiGzF4g8J0TG0Z1pFmM9TPFmvLrChbcw4ndlFONDsIdmrdwPaGJ/7RbqSQ
	3YMS2J+5hUBHd/
X-Google-Smtp-Source: AGHT+IFc7gn/sh5XLc+LMudWkGjc0K88sVuYRi716aclRB3itoDqllTAcm/QGBsgeQKTWxFbH7mhgg==
X-Received: by 2002:a05:620a:28cd:b0:8a2:bff5:40d9 with SMTP id af79cd13be357-8b2c3144e55mr1745879085a.16.1763427606961;
        Mon, 17 Nov 2025 17:00:06 -0800 (PST)
Received: from [127.0.0.1] ([20.161.68.243])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8b2e870beafsm480745585a.1.2025.11.17.17.00.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Nov 2025 17:00:06 -0800 (PST)
Message-Id: <pull.2102.git.git.1763427606138.gitgitgadget@gmail.com>
From: "AZero13 via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 18 Nov 2025 01:00:06 +0000
Subject: [PATCH] win32: remove handling for impossible cases in
 win32_pthread_join
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

WAIT_FAILED is the only real possible error here.

Signed-off-by: Greg Funni <gfunni234@gmail.com>
---
    win32: remove handling for impossible cases in win32_pthread_join
    
    WAIT_FAILED is the only real possible error here.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-2102%2FAZero13%2Fpatch-1-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-2102/AZero13/patch-1-v1
Pull-Request: https://github.com/git/git/pull/2102

 compat/win32/pthread.c | 20 +++++++-------------
 1 file changed, 7 insertions(+), 13 deletions(-)

diff --git a/compat/win32/pthread.c b/compat/win32/pthread.c
index 58980a529c..54c43b4146 100644
--- a/compat/win32/pthread.c
+++ b/compat/win32/pthread.c
@@ -37,20 +37,14 @@ int pthread_create(pthread_t *thread, const void *attr UNUSED,
 
 int win32_pthread_join(pthread_t *thread, void **value_ptr)
 {
-	DWORD result = WaitForSingleObject(thread->handle, INFINITE);
-	switch (result) {
-	case WAIT_OBJECT_0:
-		if (value_ptr)
-			*value_ptr = thread->arg;
-		CloseHandle(thread->handle);
-		return 0;
-	case WAIT_ABANDONED:
-		CloseHandle(thread->handle);
-		return EINVAL;
-	default:
-		/* the wait failed, so do not detach */
+	if (WaitForSingleObjectEx(thread->handle, INFINITE, FALSE) == WAIT_FAILED)
 		return err_win_to_posix(GetLastError());
-	}
+
+	if (value_ptr)
+		*value_ptr = thread->arg;
+
+	CloseHandle(thread->handle);
+	return 0;
 }
 
 pthread_t pthread_self(void)

base-commit: 9a2fb147f2c61d0cab52c883e7e26f5b7948e3ed
-- 
gitgitgadget
