Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A66012F7445
	for <git@vger.kernel.org>; Tue, 18 Nov 2025 01:00:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763427604; cv=none; b=O8VH/ccFutX4e0PT+3NJMTrGxA5AqVmhTeHo0C5yJME508tv3cGZ2+NX6L0lma/2HpBEEsQe4MQfNfnuEyivOiQ4pL8EAXeGRJcdbNohCqmc7P1hCFOve2x9Oj4Xz5g8CwS3DjF84hkJ5ayzYg8cEk4O0/zYIun7uRtbPzOHbSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763427604; c=relaxed/simple;
	bh=ZyDcfshb6WUxjx37Xjw5NY9OAktTwefq88xWgul8/Ag=;
	h=Message-Id:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=FagCDS4L7RHAq922hWMgoCGVlxr4cv8BQIvXSKW3GCIAFkp8ir8JqE9Y165W0PeXC8WK921YCNrHM277P+IKfR6Quljyj3LpQDWvvxUgh5tIEzTMdaS5yP7lepDhSwJ1c4fGU+/eXsePrF/lwRjbDMz0ZH4MRFIpoE6RltJdgQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QugUOu71; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QugUOu71"
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-4b109c6b9fcso41434511cf.3
        for <git@vger.kernel.org>; Mon, 17 Nov 2025 17:00:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763427600; x=1764032400; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=9pnnRJW+U0qakLP4wDo5V8u7swjEdnqsJ0xP+9G1DUE=;
        b=QugUOu71RRCFoTNvlh0IWoXE1lbttoGyCaXE8WmWJiSgGSxNHUoQSt5gW5qWZydKJ0
         uoFVVB8s+GksjCzu8QI22vjC0UXDCh7lDUoNd11axcdLQu5O1QpLlWdb4AbyZVufhUQv
         PHbRjfW7JIJORlkX9rbcaVR2XlVhI/4RfuxD5p7TtWz/D+EfsEJNM3OIsmMV+2Lg/chS
         bfJ5Dt98jz5ZoJgF6NYIyURKFOVS2wFrQewXzzvszOk263EM4j3COSUrY/qWiPU9idV3
         Q/yDx7vbAb1rmxg0V/JeIiiKYXCTducWma6xVJJjlPKDUPxmQuWVwkAg9Ce/dZdIyBEx
         2rLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763427600; x=1764032400;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9pnnRJW+U0qakLP4wDo5V8u7swjEdnqsJ0xP+9G1DUE=;
        b=jR3XoPeyXyOKjWjNfa1be9IEatUSBkkBYcj7GtJGSK7Kh+PBLpi91avHCrtIV69Uf8
         Jc99OR1Po5DAjYE9sOE5yoEdI/kJ9bWma4xVfCLbHyfBIc0uwyCqaQSV/zP87XN35NA4
         oxQ+AHKR/m7OwuXNmmloYG0SlkNwr0KV6vkoPKgcQe/p0caRetJVJTSKdYqcFATYM8Hx
         pMMPFI2Mg35mW9GhgFUnhohDSzqzXxXmOcD+kzAuiK3vVRR10x0S3VvaewD+vtUiCCB1
         fuS8XmgeTIlozOIIo3lVN67XW3PvF5d+OM8dqv6d5GCsU0QsIv3gpgNm22ouM3td9nWx
         BDdA==
X-Gm-Message-State: AOJu0YyZ/qqDrVl37w7kCH9+vgVsWQYZwqX12zA28mS/788YgkQ4ST0t
	jg671zGs3eLJtF+6AvJeRWjT9cOvzP404KA+M4bEGsDuwgo7zdKq7AvKvrWBzNlg
X-Gm-Gg: ASbGncuh0aZUZ7M5wWHzozumBFrPQ3Kr9fCeQ/Ttgb51TpKNGpPfLppnxgvZHdLA30g
	Xe7DfEMnxw0ct3rBZk2aeKhnytG66rQlb0SJ2RIvnS06vb5Wz6D7T32TI0TZEZQ2SbpSlCh37fh
	ueRLx/Rmc+ZGTqobIdQXmzV/JcjfTeoviNKVp3jXLW6KvhkX7Tvlg1894pyVlSEz8yPxk4fuiDR
	dw6j1hJTC/bfIbkdLGVeR7pfjSFpPDKJuAlop26sP9LI5w0axSHD9qQUxFANT0svG2stULkaFm4
	uKYCU4R6fqRnOd7X1zYgw1Chd9CnFg9tBkx2q6vf7WSwQI/yquzuXDzZC05ifC52zop8HlnuuR+
	iOGEIeKGCIJ7u1MAE8lh7b9rAqc8xKj01311VD6phLZ91ySOdl3nqtPmQjs9dZmuZyuXxUKkS4q
	zeQq/uOZNUZg==
X-Google-Smtp-Source: AGHT+IFan6GMdVa4ZvCkPOayl5pPTT6/K8TPy+Hi7zmm7VI1uTV3R7VS4xwxR3NubtdkHLfJWOJsCg==
X-Received: by 2002:a05:622a:50a:b0:4ee:1b36:b5b4 with SMTP id d75a77b69052e-4ee1b36b8bamr75290151cf.15.1763427600082;
        Mon, 17 Nov 2025 17:00:00 -0800 (PST)
Received: from [127.0.0.1] ([4.246.135.5])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4ede87e6db1sm92644611cf.20.2025.11.17.16.59.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Nov 2025 16:59:59 -0800 (PST)
Message-Id: <pull.2103.git.git.1763427599300.gitgitgadget@gmail.com>
From: "AZero13 via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 18 Nov 2025 00:59:59 +0000
Subject: [PATCH] win32: pthread_cond_wait should return a value
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

This value is not checked, but it must return to match POSIX

Signed-off-by: Greg Funni <gfunni234@gmail.com>
---
    win32: pthread_cond_wait should return a value
    
    This value is not checked, but it must return to match POSIX

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-2103%2FAZero13%2Fpthread-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-2103/AZero13/pthread-v1
Pull-Request: https://github.com/git/git/pull/2103

 compat/win32/pthread.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/compat/win32/pthread.h b/compat/win32/pthread.h
index e2b5c4f64c..000604cdf6 100644
--- a/compat/win32/pthread.h
+++ b/compat/win32/pthread.h
@@ -34,7 +34,7 @@ typedef int pthread_mutexattr_t;
 
 #define pthread_cond_t CONDITION_VARIABLE
 
-#define pthread_cond_init(a,b) InitializeConditionVariable((a))
+#define pthread_cond_init(a,b) return_0((InitializeConditionVariable((a)), 0))
 #define pthread_cond_destroy(a) do {} while (0)
 #define pthread_cond_wait(a,b) return_0(SleepConditionVariableCS((a), (b), INFINITE))
 #define pthread_cond_signal WakeConditionVariable

base-commit: 9a2fb147f2c61d0cab52c883e7e26f5b7948e3ed
-- 
gitgitgadget
