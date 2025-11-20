Received: from mail-il1-f173.google.com (mail-il1-f173.google.com [209.85.166.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E124F30EF74
	for <git@vger.kernel.org>; Thu, 20 Nov 2025 21:43:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763675022; cv=none; b=m/kt9+6UVlgl/9ZmS0p4IvSHNgZo0MfTDQw9KmiRXN7hcsCXtI/IGCvx1LVyY3HyzEhr4eF5Kap1T5/Ra7saTKEEmp1VD1r6J6O+Q8R5WB8Z8/LWAIyoKoegFg1A5Xhb5IECubkGvVB+T2ql8WOUw6o2yaTkwixLluMcWa6wmcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763675022; c=relaxed/simple;
	bh=sf48/xMwZc2b4hJFD9BXLv7A4OLmC9VUXrJV/nuQg5w=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=QKqqEudI7Ve6RR7XYJTk3640sPX4xzyTiAecYH473aRKEwklvvDIYWmK52i51a2wiayqk75KS0O0a6krUsKiBd+AI+M4kWtmDth+bEeAsb9g4KJPOnI2qNhDHDLDpZuhbuAJ7671ptLUN4722wahlNgTGX+h6ucjg62pmNBAo1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MKDbHSMY; arc=none smtp.client-ip=209.85.166.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MKDbHSMY"
Received: by mail-il1-f173.google.com with SMTP id e9e14a558f8ab-434709e7cc9so6750575ab.1
        for <git@vger.kernel.org>; Thu, 20 Nov 2025 13:43:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763675019; x=1764279819; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QcZ0ZpRoC2qfNAx1vsgVgnUBmkT8KVkolkvGfmSzPQA=;
        b=MKDbHSMYKa1Lv0OfGhZfJzimvIYF2RrxNguOn8U1D02oZprodf7g1T9ol0DeUrnQPj
         h6hUnP24F6n7UrsfaFJWTx0SNLilk8WTCkDmZnwySPSeidSlQzR7Z3TCj0a5HXtzWFnt
         s5o3ZhHGrGpWQTti887s+bKbMwH4cHKkauFQelF1BITye2taYsEi+nng/OBm8d0mTRjg
         A7KUCs+AhTKFCV5D1CCCrH9GrPsMUthi+FqkSaCQ8Vtem0I79hWECpcfh8XTzyrrXA7S
         Nr83mFXbwgjf69voPKkm5goO3RzBX/WUr59qzOyONiqpzeVclR9SAKZCmpiW9G4VKuZk
         Y2CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763675019; x=1764279819;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=QcZ0ZpRoC2qfNAx1vsgVgnUBmkT8KVkolkvGfmSzPQA=;
        b=LgJ/NGZjMYAxorjsTCE8UojDAyg8a8y0KDfMasOTtV5AchnXbcpxeXRBNVW/SAANVT
         RllklTXAMAaeNeU1m5AC2zLwr9aHhfbVVE6Rv22C6PQNjM/30S+E+zB5S3mIgiCL9K3D
         sLxHKp65nGc5uzTnZ5ZNANHA91mTBiKoYF1R6FY2596bd9IC5+s11GJXxGvd2ww3OOQI
         3NfwN4IgqjNHpcCTdhHFCpjZrT2GOqn/W/GOoKWZYMfOcYSc48xuxMB1a8dxobcmLHHI
         fr4pzyHnlQ/GaEhanBL5pLx6Cch2pZVCsenLyRzHUaTj1gGPAf7c9P8swGvH8gfea7wj
         1w9g==
X-Gm-Message-State: AOJu0Yx65gukRoAah783SRZHjFBSTJOFcmbTV3jwZree7Sjbf7r8Jsh8
	CIBGR+1RLii067P/5gMua0qoxxG1gw/6OaiIVKbqztqR3OOAT2T3ZRh7DTbekQ==
X-Gm-Gg: ASbGncvEdyi7q79IuRqHGR5tq1WCzoohca468pOQBnXFJ0ON+z89T2D/6RuPnuz6iA/
	nOpBXox3jL3y5L+ZKk5rl9mSEXxXNfw8uPQi7fCXHeY4aKidpq5VwIoJsoo4aSIbKetJEktJmhX
	vNC5uji93F0cm+6kaKijL7QnZvwnOIYAcjm4atlnyKTNHpB1VfXCdAq0/b5J/YagJt38diApp9x
	IDV6s0CpJmEakYjnLPKdYCMmjQxq3jTuEbvSS7VJyiMZ+3Yb/5xjV6LYyhbj7Hq+7V8X9hxnvb3
	n3zSisaRXAWqhapspyqW9KNoZp319Q7oKTeQ1JDEzWOz1NAxg5MbiaarkwLZAsszJmIewte6a6T
	1TyyC+P/JPbDX1Ilg1603y+SRfS5vHJNLxU1hTv1seRPlJexSd8Rp0nPoYyPrvTEHEoF4caQfC5
	CkQvFkYmIbda2H1A==
X-Google-Smtp-Source: AGHT+IEKyooquMUDD+e52wXHtZYP/HwGt0xOcUQCH1VbdsspYx7uhAA/d0ONZWwHBOq/iK4Nd/NMEA==
X-Received: by 2002:a05:6e02:3e92:b0:433:5e33:d41d with SMTP id e9e14a558f8ab-435b8e7a0dcmr1836775ab.30.1763675019408;
        Thu, 20 Nov 2025 13:43:39 -0800 (PST)
Received: from [127.0.0.1] ([52.154.130.211])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-949385ada00sm129841039f.3.2025.11.20.13.43.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Nov 2025 13:43:38 -0800 (PST)
Message-Id: <pull.2103.v3.git.git.1763675016637.gitgitgadget@gmail.com>
In-Reply-To: <pull.2103.v2.git.git.1763480546981.gitgitgadget@gmail.com>
References: <pull.2103.v2.git.git.1763480546981.gitgitgadget@gmail.com>
From: "AZero13 via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 20 Nov 2025 21:43:36 +0000
Subject: [PATCH v3] win32: pthread_cond_init should return a value
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

This value is not checked, but it must return to match POSIX

Signed-off-by: Greg Funni <gfunni234@gmail.com>
---
    win32: pthread_cond_init should return a value
    
    This value is not checked, but it must return to match POSIX

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-2103%2FAZero13%2Fpthread-v3
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-2103/AZero13/pthread-v3
Pull-Request: https://github.com/git/git/pull/2103

Range-diff vs v2:

 1:  a2d9ec97f1 ! 1:  19ce5aca70 win32: pthread_cond_wait should return a value
     @@ Metadata
      Author: Greg Funni <gfunni234@gmail.com>
      
       ## Commit message ##
     -    win32: pthread_cond_wait should return a value
     +    win32: pthread_cond_init should return a value
      
          This value is not checked, but it must return to match POSIX
      


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

base-commit: 5e6e4854e086ba0025bc7dc11e6b475c92a2f556
-- 
gitgitgadget
