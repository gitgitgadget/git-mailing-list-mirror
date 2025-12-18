Received: from mail-oo1-f49.google.com (mail-oo1-f49.google.com [209.85.161.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B68D5357A50
	for <git@vger.kernel.org>; Thu, 18 Dec 2025 15:49:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766072957; cv=none; b=WGSCjv4kcsmfItAk2v40aAf1U33kwWpOnxOy/kGjsB1WJj5xCLDYSI+f0a9zGhw+gvJH/XGfDQpE4IhQATAz+77GFnmAEyBkfEdBn02ElhrxDJIjyZeKFEFljyXITaCb+hIYcTZ7x/Q/qYnfY1YAn2idSn7dHfEM8BoPHlCXzpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766072957; c=relaxed/simple;
	bh=XJ1he3MqMQ5RTyC3hZVsNcVmLXfRwFdh4fIm7+3kXD4=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=adpA/fvXMBEIV+6JylkMHdybt80eS7N5IEFDKGfi2Wmyhncyz5rsDsPjjXvRJ68DpV/V8jQHmrLOCJ7oaZao6/1M54W1J3idKTU/wexnGzph8AIR3woXLiwQfO/i1uYahMCRWWN5sqU2MgzJlTmZceQy+iSMapWKz6WGUwUeipk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mxQOIzs0; arc=none smtp.client-ip=209.85.161.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mxQOIzs0"
Received: by mail-oo1-f49.google.com with SMTP id 006d021491bc7-6575e760f06so247183eaf.0
        for <git@vger.kernel.org>; Thu, 18 Dec 2025 07:49:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766072953; x=1766677753; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1j7qoULymeFi8QCSnvpahsE/ZXn3nyC0RIz7iD+oZhM=;
        b=mxQOIzs0DV519HNtdnAInhNo307PE2vbz/vBoJCbM/2VbBw7G0D2X052sRpYAiokWN
         /jv6BRfIqOjO+vibaNxD9NmiVlzTMsh8FMsfPa4o8YTy0lDLOFmfVdzei21xgOnXmamz
         3fFYY5hRHKgqgNgKhMD6niM1LRLc936qsZN8aR6VzRoVAvlRWr0QxRnJF7e/tY+18p5v
         uEoQVY0FDtefDDJQ+UUrAAdpKpp5SVvXVQSQXp+XuT/QqyeU+nfR+TOgcw3bTrU+evBc
         lBAfMYE8yBTfJJ/IZKSP1i6bE4sFYOvkhcom9AAO6kcj4VSfe1ZDikdBfOatBlC8VDRp
         x1EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766072953; x=1766677753;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=1j7qoULymeFi8QCSnvpahsE/ZXn3nyC0RIz7iD+oZhM=;
        b=Tlytcm9XaXsw8s4Q0Z4imYFgfF0oBxrgiQzTW5WDl178F3t/TeEkmZVhxuKLKaaDlR
         hCJObw1z/PbRhW7lNxQpKLHQZdoavNKM3E+LF9RNJxrTnaxSjmO1Fo8LnFKAWRIcBop6
         vl8FUpaTT2qws/ZGQtpnEFBS/TBwHxw0JPdbL82dvN0K7oLKCh0sMEpfOwJ38NTf3ZZB
         6lU9PSHyNSb+3/R3VObOPmFpYffegwq1WnyiNbmiZmAivJaq0zEY/sqLEfzfiSqh3kT7
         mIbb72XOF/1h9qJWlsuAiJ0fGjduy/1xzf78HJk3pzDHwmAW8B2ZrZc2r+skw8ZXIrIk
         fZYw==
X-Gm-Message-State: AOJu0YzuclpvE9FNHYoAWFnMkhV1Iqt5WVcNjJ8Rh/e0nLJsTbcckSXR
	ABYA3TK452/FiPi74VIxkwyb7OvgG0oJkWlCM6Q6j4svJUyMW/JER2MtJtLqSQ==
X-Gm-Gg: AY/fxX6GfMPmNBePSJ+DApLs5m9Q3JyVXTzTdEdpDO9rZky7InIA8h2V7P9mrarL8PU
	QlKGdNLp8vV7ZuIkGQ1+7pXaqHT4vBDob/OHINKNTugutpYCc9+L1xfAqG8WsCiCSlXaYLbB7I5
	AvWa0Yj0meDjARGVOtn0Pkb0OMHioB95eh0feV+tZzF2WSdP17l66+jExZ491WvxbVdq1ZGjGoR
	t/vddP3OYX6VrYerUmSyyn7c65kFJu+ZjDd5Gn1g9r17KvJLvNnlUMPM5fh+cVk/hFgoR7EVgG+
	RHl7SO+yHy6njTlkiMfxLuVuQlPISfoMGV2jlPI8I68BrBlG0uBtodRaUm6tuT2lfJw0xcKkS9o
	sSNc/RWp/D3PE2JlzB5CX6eVPU8nZcaZ9pDm/VS+/E2AbHQ/3loOYW8fnNAyNvy6J9+sLZLDWV6
	BgClam20TLAHtfqQ==
X-Google-Smtp-Source: AGHT+IGNXf6mh/VsAeFOQk619ZBw/wWlkZ+U0MI/ojjtqZLRUzyHVT54Cs27utYfB+4xC0fFFKdI5A==
X-Received: by 2002:a05:6820:229c:b0:659:9a49:8e53 with SMTP id 006d021491bc7-65b451c5358mr9359633eaf.35.1766072953279;
        Thu, 18 Dec 2025 07:49:13 -0800 (PST)
Received: from [127.0.0.1] ([52.173.163.130])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-65cff2643a3sm1254662eaf.17.2025.12.18.07.49.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Dec 2025 07:49:12 -0800 (PST)
Message-Id: <pull.2132.v2.git.git.1766072952115.gitgitgadget@gmail.com>
In-Reply-To: <pull.2132.git.git.1766071566022.gitgitgadget@gmail.com>
References: <pull.2132.git.git.1766071566022.gitgitgadget@gmail.com>
From: "AZero13 via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 18 Dec 2025 15:49:12 +0000
Subject: [PATCH v2] repository: remove duplicate free of cache->squash_msg
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

Thankfully, it is set to NULL, so no security consequences.
However, this is still a mistake that must be rectified.

Signed-off-by: Greg Funni <gfunni234@gmail.com>
---
    repository: remove duplicate free of cache->squash_msg
    
    Thankfully, it is set to NULL, so no security consequences.
    
    However, this is still a mistake that must be rectified.
    
    Signed-off-by: Greg Funni gfunni234@gmail.com

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-2132%2FAZero13%2Ftwice-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-2132/AZero13/twice-v2
Pull-Request: https://github.com/git/git/pull/2132

Range-diff vs v1:

 1:  35d0606190 ! 1:  ac2abd592d repository: cache->squash_msg is freed twice
     @@ Metadata
      Author: Greg Funni <gfunni234@gmail.com>
      
       ## Commit message ##
     -    repository: cache->squash_msg is freed twice
     +    repository: remove duplicate free of cache->squash_msg
      
          Thankfully, it is set to NULL, so no security consequences.
          However, this is still a mistake that must be rectified.


 repository.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/repository.c b/repository.c
index 863f24411b..c7e75215ac 100644
--- a/repository.c
+++ b/repository.c
@@ -349,7 +349,6 @@ out:
 
 static void repo_clear_path_cache(struct repo_path_cache *cache)
 {
-	FREE_AND_NULL(cache->squash_msg);
 	FREE_AND_NULL(cache->squash_msg);
 	FREE_AND_NULL(cache->merge_msg);
 	FREE_AND_NULL(cache->merge_rr);

base-commit: c4a0c8845e2426375ad257b6c221a3a7d92ecfda
-- 
gitgitgadget
