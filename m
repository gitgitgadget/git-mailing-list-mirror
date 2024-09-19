Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87B1873440
	for <git@vger.kernel.org>; Thu, 19 Sep 2024 18:34:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726770900; cv=none; b=um25318tvKhrStYsjlWR6KNcX2ehcNfKFd+tdidBOTeqn9n5IkYeh5Oz7W1UzJ4h4sKzC4gjzOjTClT9P4TEFuP3gN+0qbSHqcfGQ3LCwJEJkDEVAQGIdcHPsezXwXOkFo8HnV75E1HQfP1cY4I1p/JeWoSljZe0M3J26iAJZN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726770900; c=relaxed/simple;
	bh=mFMARShHwLuoHNvCbZ18HGYXRpXr7t6DbaCTGtM/AUc=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=rysN9rrzbVa3J/GLLXk+/nQmaSoivgktLvgeBfb0C9lUf5oM2qybNo9gbTwHnGZmkiJNnyV0vsGD4V335fbsj5I+DoO9zFZ8QVt0ObgdWCs0YGxLf656WduTKQX+j4VqAHS4xbbZ7Y3ywzHrOclhmvSm4iHkC4OUWEMpyR6+pbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gyCsvLLk; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gyCsvLLk"
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a8d51a7d6f5so157919166b.2
        for <git@vger.kernel.org>; Thu, 19 Sep 2024 11:34:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726770896; x=1727375696; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ATy7//dqT5/D6IaZN24s+weiJrsaceKdCYIu3DP2RV0=;
        b=gyCsvLLkhoHzY2zHz/4fQzGInCzxhe+OqgIzoVPRE3rU0AnAFSJbnkCHe7fc50aiST
         rUJLI+IJhOkUDVQ0K80g6FzFi/Dm6B8Qk8KW24IBU20MeZhFpa+gZYosfK14R4L6nFMZ
         NtZXJNFlR8EzfM73vNdHwp6I+ekJwTD8gfotZGL2cMzMMQHfqtmH5m4lcJze+B9GUihx
         8EQxxrd6GxgrOMnDpUo2C6zBIrMD61YdNNG3jyCXPjKjUwVRbhBesl86j5Ovs+0ibqIK
         VdhPnu8tkEcHSNH16M2fBi00L1L6jz9PflDpYlZqct4fZN+HRg+rgoa6o4Yb3s6q5qTL
         ThTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726770896; x=1727375696;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ATy7//dqT5/D6IaZN24s+weiJrsaceKdCYIu3DP2RV0=;
        b=aff7vR7WvrLxUVUqxcbO9fbRRQfFZ7sFF5YwFXUkqnZwn/zwWCvPjItjwsuJIAW6Hi
         +vBAv8X3XA5z32780j4JSeJnis3MUs4crp5U1/pmnHwLT7JHmupN3P8q6atssoVGAkje
         ooLNp1QSOBgYXZBuzEDxlc3LiyLgcnj00KXzAE5tjAlKAkda9LPZqFG2VrL5CCIKt0eA
         NwThTaCOK2cYqrynhfRLRb2r6St2+sHPuAYbVOLnX24vAdUMJraUiAVusyHl74x7cMZ4
         17VEkpYIqDohvfVGbaUax6BfBwKDcyWFZd7CJAnJN+jRkezn6JQGKKNfkisToF0BQ0Au
         rnpA==
X-Gm-Message-State: AOJu0YzMYGkx2IDwzxUycVsHZEVEN7mFjIV9c5MAVfvQistpundQCyg4
	osJE7WYe8hvh5REmir/2b5ZSLKD+TweT5CMK4paW2OBThmhgECWrxaQFuA==
X-Google-Smtp-Source: AGHT+IGmjV70CUd17rfFdoHjo9mXyAngiK+kTdEm/qkejatkIcDswe0HqCTjSBaLgM1DNbrljZa5jA==
X-Received: by 2002:a17:907:f163:b0:a8d:6329:d8cc with SMTP id a640c23a62f3a-a90d4ffe173mr13576166b.25.1726770895816;
        Thu, 19 Sep 2024 11:34:55 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9061331938sm745979466b.222.2024.09.19.11.34.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Sep 2024 11:34:55 -0700 (PDT)
Message-Id: <7c8fc79fa8c8daf288cecb068d220ccfa07d7d7f.1726770881.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1794.git.1726770880.gitgitgadget@gmail.com>
References: <pull.1794.git.1726770880.gitgitgadget@gmail.com>
From: "Andrew Kreimer via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 19 Sep 2024 18:34:33 +0000
Subject: [PATCH 13/20] rebase: fix a typo
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
Cc: Andrew Kreimer <algonell@gmail.com>,
    Andrew Kreimer <algonell@gmail.com>

From: Andrew Kreimer <algonell@gmail.com>

Fix a typo in comments.

Signed-off-by: Andrew Kreimer <algonell@gmail.com>
---
 rebase.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/rebase.c b/rebase.c
index 69a1822da34..9d1ae95978e 100644
--- a/rebase.c
+++ b/rebase.c
@@ -11,7 +11,7 @@
  * The callers that care if (any) rebase is requested should say
  *   if (REBASE_TRUE <= rebase_parse_value(string))
  *
- * The callers that want to differenciate an unrecognised value and
+ * The callers that want to differentiate an unrecognised value and
  * false can do so by treating _INVALID and _FALSE differently.
  */
 enum rebase_type rebase_parse_value(const char *value)
-- 
gitgitgadget

