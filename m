Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6207539EF34
	for <git@vger.kernel.org>; Thu,  9 Jul 2026 16:49:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783615798; cv=none; b=hbxHKPrOJitBwcisER5en4bozdymUBnvq1Qdi5N+hkGmBrnMzGu8oSXTCtxVk3smYxBm3Md0MzoW7Tq02McwORnnATwa9U8wx//jjAiUVGtz+hSkEXC9+S+/TCRpn80dYobkgeTBJU5q/FbkdfvxUhjFpv5P8BlpO+31Nh+5UHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783615798; c=relaxed/simple;
	bh=2sOwCqcRrAPzEpyqVb2L253d74ossFImQrmVFcG9tRU=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=YXB74yaKXbdH+3LC8jp181R4y3gdBU39RAm6fDoHG9f3ky+zJaXCRrC8biCSxBymS5bd3KSerDPSOg5l91v4nU1LEplcgXcG2iPP61xHjunrfgqt0BibNzGd+uRwgUIhdaqBdIUZTXpU7v7X/dIeIdiEiOq05L5FSQlpWHbjCe4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i9jTMVNp; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i9jTMVNp"
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-c96bfabc8d4so23344a12.3
        for <git@vger.kernel.org>; Thu, 09 Jul 2026 09:49:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783615797; x=1784220597; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=0QeFPLjkX+BN2XZOxoLWKjLvEHX3v/R4r47jelAKP7Y=;
        b=i9jTMVNp7zV1SMMUIp9n6kxcrIrwKyZo2akFPJHBKR0j8YsttT4MczrQ696K1+GvjM
         lFBtq97TFYDRX8EUH0SbuOB/L0FB3o/OAZ2fELVQCQOmjxo04LoOZxXPI7sBwDul3dVW
         O4cTHY37grDDqn40Na4UL/JYP5OmfvtRbU9q90Hr8mzhoB43XN2cd0qu//iVj7HNf4gn
         5fQK1IssK0IaYJHAwS5cnywpSBUfoAHLMOthx5NkII12hvRvAkRy+bA4olYHe3iRjK/X
         i/bvK9FKnbR7qNg3cIbnO2Hk+Qt8ffr5FuJyMvmRbWnZSwDBp+YYht4c4+54+fdcRl0Y
         fi/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783615797; x=1784220597;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0QeFPLjkX+BN2XZOxoLWKjLvEHX3v/R4r47jelAKP7Y=;
        b=H3lN6Zj2NTMs9G3VcHlsVLlJ+x9ADPEHTgfLwhf3T2n215f/ah2SAUipR8W3mLbNqG
         5uPwTe5ksNBrrzIr/9qSGeOhwx0k5IUleqfAlvQHT1MHDSHqM+0oxefS1zj8/lLRM4O8
         pYPuRHJEKcm5qPE5QZknD9hpllO/Ly4FkN/OcaXGLfjVh7sS3cnxxnLpIHPEF3xjIJAT
         woYZxlV6o59K8DaF5zsAajwR0ld7H+yXMvR/75fsw0SwV5uFfhLG6UE44gngQozuC5w2
         i6BvbKwAbspK6xXgFjfD8i1hkvPL5MorQl30WbJnyINVN5K7b9fC7PBMjcWQgSzyaiwD
         kWuA==
X-Gm-Message-State: AOJu0Yz84ha3qGIRajKlXW/cFgeY+UwnbUTrESDvFCM2/RHR+gfMdwEF
	Q1Vu4kLjA/HJh4tiXJst5OkQwNarzg35cCtvF8LWqaCV0IPk2477dWS0YmVUdA==
X-Gm-Gg: AfdE7cnVMH1ZbRJszM7LIx+7+QzO1SLw5TwNrCvnwfcKv45t0DhsNfZUYDFmFKIwR+h
	01CBMQAfiNLP/ud2/3o3UmATd4WrTiqjjCm7nRrV0yhg1i2XjYi+Qh22PZliNCnoQtvjUYfQ26b
	FialnocgTmbNQ7M+y9+WKNj9GL+zarkDLkHZ0jSxZRj1XUQNcuNdbApg2flY0BtjUUbH4Mw2joa
	2xEmgB3SMFLGZHbgIcPjeM6HcnwIkh2yy1lrc3yp4Vppl4eCQWoselSn0W9EMCDNUJS61dv1agU
	8MkVR8dat2iC5Qo/+iiy0//Eo77Qqomwyrd1cuH9dRYuQWNmfaxJRxSes7ZqvXLHC/NXlrikmQb
	KUnqp3VGq2EbS1n5arxTGG0j0rzAntumqdedtwV27xw6lotMvHr2/8vnmLHuXBXWwDjmQUW95rQ
	+tpWvGZjzjdqD4T8o=
X-Received: by 2002:a05:6a20:431b:b0:3bf:d354:1352 with SMTP id adf61e73a8af0-3c0bd047ea5mr10079017637.32.1783615796677;
        Thu, 09 Jul 2026 09:49:56 -0700 (PDT)
Received: from [127.0.0.1] ([68.220.59.115])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13b65960d88sm28104677c88.6.2026.07.09.09.49.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2026 09:49:56 -0700 (PDT)
Message-Id: <b89d28c8aa929dcf4efd40ee8174f5a78aac9eff.1783615780.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2175.git.1783615780.gitgitgadget@gmail.com>
References: <pull.2175.git.1783615780.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 09 Jul 2026 16:49:36 +0000
Subject: [PATCH 09/12] diff: widen `deflate_it()`'s bound local from int to
 `size_t`
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
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
    Johannes Schindelin <johannes.schindelin@gmx.de>

From: Johannes Schindelin <johannes.schindelin@gmx.de>

Fixes a pre-existing silent narrowing from `git_deflate_bound()`'s
`unsigned long` return into an `int` local: anything past 2 GiB has
always wrapped negative here and then been re-extended to `size_t`
inside `xmalloc()`. Also prep for the upcoming `git_deflate_bound()`
widening to `size_t`, which would extend the narrowing further if
`bound` stayed `int`.

Assisted-by: Opus 4.7
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 diff.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/diff.c b/diff.c
index 69eb2f76a4..c14f69719b 100644
--- a/diff.c
+++ b/diff.c
@@ -3609,7 +3609,7 @@ static unsigned char *deflate_it(char *data,
 				 unsigned long size,
 				 unsigned long *result_size)
 {
-	int bound;
+	size_t bound;
 	unsigned char *deflated;
 	git_zstream stream;
 	struct repo_config_values *cfg = repo_config_values(the_repository);
-- 
gitgitgadget

