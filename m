Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A654E363C77
	for <git@vger.kernel.org>; Mon, 30 Mar 2026 18:08:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774894120; cv=none; b=Qh9rzEIC33DzBvevWRLVOFRHccocRRKfPrBt6KCFydqo+18+uQ7XZjnkoBfoHtuLxg20tMtuxA9b5KYTRdWOK5PjfXbKIYzhaz5Ljt3Hif5Kq22590tkcDY8JJYHhZFU0SttjlTW3yqTO8qW2YrTqBz1kmGg0g0g6A+cwWrw6AI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774894120; c=relaxed/simple;
	bh=iq4gSBtTmneljIp4TvgxttsXXWdtE4YSwzI4fQepbtM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rKAa8DdzGAa7b3qtyYhXDQo3XZN2zChHWkg1VQQOs+kF/BU0gfoLml1tpJcL6DtBrRoKGe8UTQqkNoJM34vRfeug2/8KDZiQbOU36O46jI5Udbk8aZKhISbZkZPNsdGRqwB6SxM/7p9c/LTepSp3spm3ULs1UZkTEMJchH8y3U4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sithyd.siu.edu.in; spf=pass smtp.mailfrom=sithyd.siu.edu.in; dkim=pass (1024-bit key) header.d=sithyd.siu.edu.in header.i=@sithyd.siu.edu.in header.b=humjeC+O; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sithyd.siu.edu.in
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sithyd.siu.edu.in
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=sithyd.siu.edu.in header.i=@sithyd.siu.edu.in header.b="humjeC+O"
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-35c1d101355so2020627a91.1
        for <git@vger.kernel.org>; Mon, 30 Mar 2026 11:08:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sithyd.siu.edu.in; s=google; t=1774894119; x=1775498919; darn=vger.kernel.org;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=/HQ37PHB5TcOljMyf1ngBNNNTogjtaUQOB36I8Cog5M=;
        b=humjeC+OOAITVQ+h45IgqWNyI4BEbybK/y7fCzsPvDFKqPnI8jnzwzyFjmv4PEFTgx
         TF2aMIsENMKppyRWCrKlvjbyseyolbUxWdWE0/bnXa2inR1VQKabyzjUoHA1hHefIlot
         QeD/79T4iKfLIOZwCSeOEmoGfpoP4dtglV1Go=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774894119; x=1775498919;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/HQ37PHB5TcOljMyf1ngBNNNTogjtaUQOB36I8Cog5M=;
        b=hiUA7aDdvF7dwWw5zC2lUuluq2XdCyPMlKcl6B2fyVSHS0yCy6OXs1ZL2sQwobuxwE
         4q5LqxZmhfEcc6M688k3W9abTTGETDlXmXJ2m1QlnFW89X70aVsyeQV25VWBBZJaT2bF
         NbT/cHxqm4XrPx/oXSdqiEcuaGnCyUlxcTLch7BJzrqyZlGOJN3hre1gMmeiQU6cAhA5
         jHtkUNiSpheommsKTU2Gfjxa3FwFjw4Z1EHL9KTdR5UIP8hjQ0p/J8TozXNkqrQIDQvJ
         Uf9czJE3xs5szyuF6wz/orlL+fzW7LT40Gm/kTG+lJIjIpbdieRkyDm5wnNhwUju2qjL
         FgWA==
X-Gm-Message-State: AOJu0YzNVu5EkfpVcrcqJgrznchIaQKDFQsosCt01a1TeCuBYteT/hdR
	/bMYurxj03ywAgXXZUA6k+vPg2UkOEv5REfIs2thMkbWj2dSE/APzsIfSqclNV9yPsIMgZRHOB8
	gBMBbVNleIjGX5WMOceCMwyBXe7C2nSRmkEGfXiZVk/vVYT8+2QpJgVmZyCY=
X-Gm-Gg: ATEYQzyFyuFdxxJ2kIJdKCHaYxec7JWhFZlvA1415zXlwwFTPKuuwBbVeeyTEW15OkJ
	uvQc8H0/4FhXJVXgxypVz47hyeNB3jTxSmi5MJdp+MK192d2wWA/NPyhjA7kDPLUumGdNun8Iqs
	1toCe/cLDXzzHuoIs0771hCKVW3m3lAWijiSUknqkI/L5ZmVXVWGd8EjAFawKJNGd6Aa/UA98sm
	AJYnSB/AShoB7LqO5jq/K2XgARH0GXctaThI4QntzuebfPGO4tW5LqsG05cT7C9bK6ZcVCU+ddh
	UPxUHaltlayczJAFB2tJw5VAdZkCa2Ah2SicERgPlEyS29o1CT9oyzKo2fRz9kQxiu7SSWc7EW/
	ZvmN8yJlB1nFb6nepRbryZscuWhPN0tQcDwqwKoCuR5wkbegAIzP2/TJTSjPszZNyC8ymn/DAsG
	1fGPutKtWXFGf6xRgcNMfkwUf3rXU7OILt1SsJollJy+n3/+zlTBxC+mE=
X-Received: by 2002:a17:902:da83:b0:2b0:bed1:46db with SMTP id d9443c01a7336-2b0cdd97682mr142473545ad.45.1774894118844;
        Mon, 30 Mar 2026 11:08:38 -0700 (PDT)
Received: from LAPTOP-A2K1CSVQ.localdomain ([103.157.13.18])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b24277e8d3sm85979815ad.55.2026.03.30.11.08.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Mar 2026 11:08:38 -0700 (PDT)
From: Smaran Jaianand <24070721037@sithyd.siu.edu.in>
To: git@vger.kernel.org
Cc: Smaran Jaianand <24070721037@sithyd.siu.edu.in>
Subject: [GSoC PATCH v3] bugreport: revert incorrect usage message change
Date: Mon, 30 Mar 2026 17:41:10 +0000
Message-ID: <20260330174131.456-5-24070721037@sithyd.siu.edu.in>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260330064454.76833-1-24070721037@sithyd.siu.edu.in>
References: <20260330064454.76833-1-24070721037@sithyd.siu.edu.in>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"

Revert the previous change to keep it consistent with documentation.
Based on the feedback, the usage string is intended to represent command syntax rather than provide a description.

Signed-off-by: Smaran Jaianand <24070721037@sithyd.siu.edu.in>
---
 builtin/bugreport.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/builtin/bugreport.c b/builtin/bugreport.c
index 6b1d1accb1..c42b61cc8f 100644
--- a/builtin/bugreport.c
+++ b/builtin/bugreport.c
@@ -56,8 +56,7 @@ static void get_populated_hooks(struct strbuf *hook_info, int nongit)
 }
 
 static const char * const bugreport_usage[] = {
-	N_("git bugreport - create a bug report with diagnostic information\n"
-           "              [(-o | --output-directory) <path>]\n"
+	N_("              [(-o | --output-directory) <path>]\n"
 	   "              [(-s | --suffix) <format> | --no-suffix]\n"
 	   "              [--diagnose[=<mode>]]"),
 	NULL
-- 
2.43.0


-- 
* <https://www.facebook.com/symbiosis.official/>*  
<https://www.instagram.com/symbiosis.official/>  
<https://www.linkedin.com/school/symbiosis-international-university/>  
<https://x.com/symbiosistweets> 
 




**Disclaimer:* This email is 
governed by the Disclaimer Terms of SIU, which may be viewed at 
http://siu.edu.in/disclaimer.php <http://siu.edu.in/disclaimer.php>*


