Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF9FE1917F1
	for <git@vger.kernel.org>; Wed, 18 Dec 2024 16:57:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734541042; cv=none; b=ElyUsAgimjII5OVlzl+Ye7lybEL27iKXxiW8s65L2qSQb2Ff6XAQ59zPtxHpbiQOfqkl79Te/yGlXvgiBFUvYhWCggFkCwXR4dlgi40FLwj/qkO0FoYRtrbJuMvmFcDhh0MCtTUeHppqhOC2RKBsRQALB3y8pSsQD4q4VMJWsS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734541042; c=relaxed/simple;
	bh=gjCz/FUMEPMOxuyOX+CgbuL26iqu6e3BPF4bjus+OqY=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=kwjQUUYGYSd5XrFmCngU/LdhV+8cuwOPd1BRFfamGFUwzqFsT6gJLOsp0FWODhHH225Q11XVtXsdUj62eAAE2V5+q8/eAur0cihRJWeM/eh71g5xbhaCcPeLevX4AUo31n/EGzL4tNnl44ldVUbU/kVs3k34sM7/fC4cLwd6tSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hvpARXQ+; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hvpARXQ+"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-43625c4a50dso47322195e9.0
        for <git@vger.kernel.org>; Wed, 18 Dec 2024 08:57:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734541039; x=1735145839; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GwJ0H7zL99PUQ3WfelHhB6+qDkUK3ZlLQRmjFTuviOw=;
        b=hvpARXQ+LqSWgKtq4HzBzWwaysH6+CL35USYLgBRcd4HoxOp/X4bSNH10iCOOeDePx
         4pJQx/ddeGlthhixkQZlNueDITjMcJcVY+NROw/rVUDtCGpYVMpE91RynuwslwEW2Mzp
         LsF2U7UPh6k96N4mJx063ijCg6T+wh5SxmnS2yUosn6dYS2NGYExb4hR9Gzptw6AUzG7
         a/P2tybBq1C7MPV7Qd8eXUiekFDM39ojR09/9+sq7hZpja+YhTDaTVorW7xP0bo9HrJg
         ZDhMhdrlIWH+0+a/ugEUM8nx9Ko1O8NzXi5l4psBxD2a1ZzMCgVCw72Ih7oGsYsH4V6/
         RA0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734541039; x=1735145839;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GwJ0H7zL99PUQ3WfelHhB6+qDkUK3ZlLQRmjFTuviOw=;
        b=rpS5YdRlrlyicJDH1xTrIM5zHwhoxviG5Q67OVGg6zZAAijEVkBBIMF8QaEDICdqHK
         6SXkodRS1MoeMHwdFSX00M85dD6rCGhk/7pHR2EbHSmp/Ih54TtmnCXEAEounn6lghp7
         h2Gn+rQWI4jmfOMX7PgvKDnAa2JCCwn2qANoPaZ00E4IhWIr9JXewhR3Qf7/GcK6jbqB
         gQqqjlCSyxtAMP8I77KOmPUalpaJIu7pewuT35IV8IR5c8pzIX70ptAQTR2HyuZQTZOj
         NZAkE0HUS3PJcgwRjK+5XYQ32YQIgfF+VAnxNmpMRFL/IZM+7epNdpqr0jdJ71wtWLjk
         mEng==
X-Gm-Message-State: AOJu0YySLYRTXw9ZggAj4w1E5THr1fDTXoC0xyrJ42YWuy4IEeU16ZT1
	CPV+XCuWrlnaaPEuavo4lJgm0TIdAEIHBy+6JuEryZqSX/lsf5xzxR64Xw==
X-Gm-Gg: ASbGnctnvylxwm7RgJ/9KyXQUaicdyBfBeAz9wyQU9ncplI9HeKHENDji775kys/nH3
	cQYnIB8ELL3wdImvIxIkSsmnXaJuLM1WEPVcNuKonTXfcXi4daU5cOaonHBD3rKa5jKkp8O6cdx
	O+1oVxlbC0GuNWnukEWWiV3XRvB2LzfnGtw6ZXZRkoKN/P9LN4VbznBD7m5mg6mTE9zhGlPPvPD
	A1QSmCaEnUSY6/q1y4j25e/26rX3VKOLm4kgzxHcSGXznxIwrCcY1iZbA==
X-Google-Smtp-Source: AGHT+IHwsNwCZJXlLU1nQnxQjUY3OAnMj0YKoGPXGcp++d3+2u9Me3YuOtwluIjwnVna0w1bkIhRjw==
X-Received: by 2002:a05:6000:4612:b0:385:fd26:f6e0 with SMTP id ffacd0b85a97d-388e4d83b16mr3621501f8f.18.1734541038643;
        Wed, 18 Dec 2024 08:57:18 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-388c8060174sm14361728f8f.96.2024.12.18.08.57.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Dec 2024 08:57:18 -0800 (PST)
Message-Id: <pull.1620.v6.git.git.1734541037465.gitgitgadget@gmail.com>
In-Reply-To: <pull.1620.v5.git.git.1734540395021.gitgitgadget@gmail.com>
References: <pull.1620.v5.git.git.1734540395021.gitgitgadget@gmail.com>
From: "AreaZR via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 18 Dec 2024 16:57:17 +0000
Subject: [PATCH v6] git: use logical-not operator to toggle between 0 and 1
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
Cc: Dragan Simic <dsimic@manjaro.org>,
    Jeff King <peff@peff.net>,
    =?UTF-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
    Phillip Wood <phillip.wood123@gmail.com>,
    AreaZR <gfunni234@gmail.com>,
    Seija Kijin <doremylover123@gmail.com>

From: Seija Kijin <doremylover123@gmail.com>

If it is known that an int is either 1 or 0,
using a logical-not to switch instead of a
modulus makes more sense and is more efficient.

Signed-off-by: Seija Kijin <doremylover123@gmail.com>
---
    git: use logical-not operator to toggle between 0 and 1
    
    If it is known that an int is either 1 or 0, doing an exclusive or to
    switch instead of a modulus makes more sense and is more efficient.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1620%2FAreaZR%2Fbuffer-v6
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1620/AreaZR/buffer-v6
Pull-Request: https://github.com/git/git/pull/1620

Range-diff vs v5:

 1:  5bb2cf10062 ! 1:  0fe9e776177 git: use ^=1 to toggle between 0 and 1
     @@ Metadata
      Author: Seija Kijin <doremylover123@gmail.com>
      
       ## Commit message ##
     -    git: use ^=1 to toggle between 0 and 1
     +    git: use logical-not operator to toggle between 0 and 1
      
          If it is known that an int is either 1 or 0,
     -    doing an exclusive or to switch instead of a
     +    using a logical-not to switch instead of a
          modulus makes more sense and is more efficient.
      
          Signed-off-by: Seija Kijin <doremylover123@gmail.com>
     @@ diff.c: static void mark_color_as_moved(struct diff_options *o,
       
       			if (contiguous && pmb_nr && moved_symbol == l->s)
      -				flipped_block = (flipped_block + 1) % 2;
     -+				flipped_block ^= 1;
     ++				flipped_block = !flipped_block;
       			else
       				flipped_block = 0;
       


 diff.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/diff.c b/diff.c
index 266ddf18e73..48335971a4c 100644
--- a/diff.c
+++ b/diff.c
@@ -1231,7 +1231,7 @@ static void mark_color_as_moved(struct diff_options *o,
 							    &pmb_nr);
 
 			if (contiguous && pmb_nr && moved_symbol == l->s)
-				flipped_block = (flipped_block + 1) % 2;
+				flipped_block = !flipped_block;
 			else
 				flipped_block = 0;
 

base-commit: d882f382b3d939d90cfa58d17b17802338f05d66
-- 
gitgitgadget
