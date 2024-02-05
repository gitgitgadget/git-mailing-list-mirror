Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ACA928DD1
	for <git@vger.kernel.org>; Mon,  5 Feb 2024 17:21:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707153711; cv=none; b=UqcghHJpyNIS+VPzzBSkddZp6VbAjVRAmw8K7I+pKq9IlO9+aIPC9D3aXYm5V9C6SPiYJnL4r0lgAKQVVG+4Ji/KCLUFYx6lszlnfEtJbMvP68er69W9/5Ab9VA0GRyeoCJnh+ZBxrIqYCr3ticSI1PgtqyRnHU7bPSCMJ6n8sk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707153711; c=relaxed/simple;
	bh=rjj4nnqJQTDhTzUIu7ktClSHT+0vhXH3QpAjE5EkMFU=;
	h=Message-ID:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=NXduvrcqbXNiLfjgCIoUIJybqh6wTaWeeYWQZiMnO0xtLvlOuCdxavqsnSqbNdHRMPS5JxbjIRD2N5mpoI4CLMgs4diK7D7VZfHEzPYhtXQRcZYUnX/IDiAaENCR8Stffu2hdfXCBU8CxNDtYU/t6MhUs2BQO30Y6HuOWqEmQ6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Fqpb9BgE; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fqpb9BgE"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-40fb804e330so42574465e9.0
        for <git@vger.kernel.org>; Mon, 05 Feb 2024 09:21:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707153707; x=1707758507; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=BAltXQokftvu94m9ceSfETc7NGAuLWFiKK0zeWPJkLc=;
        b=Fqpb9BgE24xDogfaulptvESl4DjU6V/pXSGeobp5hi8JYZ/Ujjtp19JUrr2eNxIXtl
         f+lP/bqTN+fsCcw1BHvPEYY3Kj+fR6WsmWjcme9j9eoKjRAuIuHmtiv4NRDUSnMyj/Qg
         37XLB3gFDxZ6MMSxe5BOaykoa3CWhQspG6nnA6uo6Bujj1BzFIBd80J3RlLm6x9Bz4mu
         ZHQk0DdGLd0Lmz04iqzjaMAfZjWW1JujI3j7OuAtddeZu55CJNiMSR60Q8kFV/9ZgFkK
         XXgVGQSNywWH0ORbbnhaCnXgYB4e3HE6QsYfwYujzN/mDVOueF0cnDdl2XuH5Ijjyml0
         HVBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707153707; x=1707758507;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BAltXQokftvu94m9ceSfETc7NGAuLWFiKK0zeWPJkLc=;
        b=k4O1VVjspBhmhbyAhudLZMJeuogo4jmWctl46800IeS6zIjyOfN/lN42ySHEtXsLJr
         K4zcb1wNvqoylp6r1VKR3oMqtlbWnOuNVA+gJi24lzwaIJ/rMV4NMZsARj0qsPcFgzdo
         MLNyt1IdItYHNhjsDGC0VAX7PGt6Ke73K16eK7p1qXXDRSwR2YE5nhb6hTQjl0yJPrXA
         KaSwkU7SHm1ZFeUo9J8G1TWm2Uw38RsDhqBdjwqwa4fNrJs0w/V8hmn5DzUeboP5ECdb
         vKfr8Yykr2glhhj+u3GGdDvbwTb2Jq0PbYDJ/au2nVBPM6tJlVRWJXiibFEU7ngbJHrZ
         zfSA==
X-Gm-Message-State: AOJu0YwVb08W3mNotqM+yw8hOc8hLMTqr84Wx+fMRILz0YKWE7WNyR5M
	mxJnE4hd9nlHFhsqZRnHgzNODQCYtN8jQiqyW4DjJ0ReaJR1dhxyeFiQpXWj
X-Google-Smtp-Source: AGHT+IFYqP092R4bEg4U2LxozXZneFW8A/gN+nMY6MBcqzUZaAIWJKuClZWHpFl45sj2NizNSQCXGA==
X-Received: by 2002:a05:600c:a39e:b0:40f:dd4a:11f5 with SMTP id hn30-20020a05600ca39e00b0040fdd4a11f5mr306879wmb.34.1707153706657;
        Mon, 05 Feb 2024 09:21:46 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCWXIOKjqOYawa7LrckFUrsVNmy6AD1ijcGhCo+ijCd5lZLaXVe9E8zeeuFDmvwEUIwoWiOUBplEczIug9hGrInhpr7wLBJapW+Apgk=
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id y21-20020a05600c365500b0040ef718cf81sm429935wmq.28.2024.02.05.09.21.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Feb 2024 09:21:46 -0800 (PST)
Message-ID: <pull.1652.git.1707153705840.gitgitgadget@gmail.com>
From: "Chandra Pratap via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 05 Feb 2024 17:21:45 +0000
Subject: [PATCH] commit.c: ensure strchrnul() doesn't scan beyond range
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
Cc: Chandra Pratap <chandrapratap376@gmail.com>,
    Chandra Pratap <chandrapratap3519@gmail.com>

From: Chandra Pratap <chandrapratap3519@gmail.com>

Signed-off-by: Chandra Pratap <chandrapratap3519@gmail.com>
---
    commit.c: ensure strchrnul() doesn't scan beyond range

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1652%2FChand-ra%2Fstrchrnul-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1652/Chand-ra/strchrnul-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1652

 commit.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/commit.c b/commit.c
index ef679a0b939..a65b8e92e94 100644
--- a/commit.c
+++ b/commit.c
@@ -1743,15 +1743,9 @@ const char *find_header_mem(const char *msg, size_t len,
 	int key_len = strlen(key);
 	const char *line = msg;
 
-	/*
-	 * NEEDSWORK: It's possible for strchrnul() to scan beyond the range
-	 * given by len. However, current callers are safe because they compute
-	 * len by scanning a NUL-terminated block of memory starting at msg.
-	 * Nonetheless, it would be better to ensure the function does not look
-	 * at msg beyond the len provided by the caller.
-	 */
 	while (line && line < msg + len) {
 		const char *eol = strchrnul(line, '\n');
+		assert(eol - line <= len);
 
 		if (line == eol)
 			return NULL;

base-commit: a54a84b333adbecf7bc4483c0e36ed5878cac17b
-- 
gitgitgadget
