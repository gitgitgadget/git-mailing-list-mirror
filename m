Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7DC53AE718
	for <git@vger.kernel.org>; Wed, 12 Aug 2026 08:03:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786521808; cv=none; b=qkPii9PsOcnPXoyTomnsLI+x4REKwKFh8KaohkcgNkVJ7GCyoqb0p8LdnCmJZmaMNjeqktZLqz6M4hXaX/1SlnvAznUecfP0cLeFTU88CnjG9zUmKipx+zTykLwrDEBaMvwYSo7v6+dlRJhXEypVsqDPqCrfjOTdWSlKCqrvffE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786521808; c=relaxed/simple;
	bh=hmSbXH2EWUKB9j1xDAwuEwUIYytbLmXsmJidgaGXjgs=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=PfKFy52t3WxanJIryQ41S7AL8RO1ZoWmvoK+MfGPbo2zOewegCSoT0RwjA0VwQ2NY5yF5xt3veupwW5qlSjgNFC+NnuyL+kp/syd75OjR/8ldsMDLPjxbp1qQrDER1uW3guz4QWOeM2JIJVyBn09X7oNnvhi2CcS617ac3KtLic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T6PESeUt; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T6PESeUt"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2ceaf8a1265so7523105ad.2
        for <git@vger.kernel.org>; Wed, 12 Aug 2026 01:03:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786521806; x=1787126606; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=v1F/2hg5z+y7GQEVMdvNrsCJfqGQgTDTAC1VrdddO8g=;
        b=T6PESeUtSgS7tCEPxb1AmRoD0szrWXNUHMdjPOgMwugjdtunwycsjr+bft0rBMBmm5
         yaRrVbjBsLPBE1wPh8pjaLz9hnpsabMmg04akg5RySZIr//Wn2rrcpOBNQ0VpWCbyhve
         iYvDkK8eyGHnzN+pHTOXjTX1tB687Y0rGJIMiJyfYYBDEAyunM2juywJIr7hTnq5192p
         dPAntseEkxGbEt19s/+e4fuTbKRCrNnBxMZiSv0mSDJH1ZJoqVnzjbN3yzGSMIxPuS2y
         jWBcBeQsTrt2z/lgoqas2+1jCFfnyNn72tDX2/NsxgUQ9DXWxYpBx/tFCkfc/UohhHD7
         XD6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786521806; x=1787126606;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=v1F/2hg5z+y7GQEVMdvNrsCJfqGQgTDTAC1VrdddO8g=;
        b=j+4VwKIAdlbmQRQ9Q8H/4/V4gipnX1cCOUJYrEhUKyuEyC34xV9HNx7aW09OWRrQ/E
         6zngclXLmX2eHiM3JvCR7t+DyEBXZy955ll0hiX9nVITAZeKlcoJXIqyRYvh/a+UzNvY
         Nqm+F5+PTe34l+LnkuFeNbdndRds2fXk9RH4v/S7MFiLZ/NX93IdBF6R/lvrMQ+8/AuF
         2I8sERBWic1ATBI1bOEUOLpUFvnZ1Pe7fo+NOsU790vuPxMUULLvgZVcaRoGCWatAFSe
         KmZ8n42f57jg6gewBDUceCcdHLTZed0s3f078foWhtpST7qS1N+sx3oz7x73yJaSIFLB
         bQnw==
X-Gm-Message-State: AOJu0YwU1HmRoHXX4RgCrckFfh+s/RaE1/orC1d7g//HlUjlNm8oUUMW
	tMhu2d1T4/cY4gJIhCkdcEUSNremc84CNo9WCqIeLU7PhCEQNFefpDujDQVormAh
X-Gm-Gg: AR+sD13kjOXkA8X9dRwQzqDJ/2y+k40mM/BlfFfE/A2lvRWxjC4/rJoGRY14aR6jOSV
	P181zsxjxSjrWhc4/yno1vulHkyY7En7JdlMxSf0vQ/cf2ezblUMQJcby8MMSRhM55tbBKdL1hc
	3CDQitb0ImAHDwxkuV7ZCwwCDkL1vwWQtjiK1IZpzOScZCs6SKsiEdse89Gs7zlkUkC/zyyBNMb
	HkrDcGy3z8lflK5UfEj7mBzuoe84g55I6QLUPkhv0MX4BiSwjUhKvV4VF72JxCp7NMj5gKF40Dl
	aIloGh/QqYUP6UT4e47ARidctu8x+mIH4G2mNUSUVuxecNxijN4aHfTmj2soXmaIYuDQc1F6cBw
	p+3CxJjstk4+TXFc4fg4NrCqfmIwj+9TKBbIsa3aYyHKx4qUSwwW6Lgviyw40R6gA2FXWxps6k3
	iyo0P4Lhqbe14v8acIENEJU9L75SimC9eMXtij+4lyR13uzgGhklknDgTBYNbVHg==
X-Received: by 2002:a17:903:1b26:b0:2cf:b68a:2050 with SMTP id d9443c01a7336-2d34560cbc4mr43400735ad.15.1786521806199;
        Wed, 12 Aug 2026 01:03:26 -0700 (PDT)
Received: from [127.0.0.1] ([134.33.71.70])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d350fb0fa4sm2943675ad.9.2026.08.12.01.03.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Aug 2026 01:03:25 -0700 (PDT)
Message-Id: <e653255de19decfe45d4ef8d3277aaf69c44c391.1786521801.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2179.v3.git.1786521801.gitgitgadget@gmail.com>
References: <pull.2179.git.1784069325.gitgitgadget@gmail.com>
	<pull.2179.v3.git.1786521801.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 12 Aug 2026 08:03:09 +0000
Subject: [PATCH v3 01/12] http: die on curl_easy_duphandle failure in
 get_active_slot
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
    Jeff King <peff@peff.net>,
    Johannes Schindelin <johannes.schindelin@gmx.de>,
    Johannes Schindelin <johannes.schindelin@gmx.de>

From: Johannes Schindelin <johannes.schindelin@gmx.de>

get_active_slot() duplicates the default curl handle via
curl_easy_duphandle() to create a per-slot session handle. The
return value is stored directly in slot->curl without checking
for NULL. curl_easy_duphandle() can return NULL when memory
allocation fails internally, and the libcurl documentation
explicitly states this possibility.

When this happens, slot->curl is NULL and the very next operation
(curl_easy_setopt on line 1632 for CURLOPT_COOKIEFILE) passes
NULL as the curl handle, which is undefined behavior in libcurl
and typically crashes.

Every HTTP operation in git goes through get_active_slot(), so
this affects all remote-https, remote-http, and HTTP-based
operations (clone, fetch, push over HTTP, bundle-uri downloads).

Add a NULL check and die() with a clear message. There is no
reasonable recovery from a failed handle duplication: the process
is out of memory and cannot perform any HTTP operation.

Pointed out by Coverity.

Assisted-by: Claude Opus 4.6
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 http.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/http.c b/http.c
index b4e7b8d00b..8f1d6d1f56 100644
--- a/http.c
+++ b/http.c
@@ -1608,6 +1608,8 @@ struct active_request_slot *get_active_slot(void)
 
 	if (!slot->curl) {
 		slot->curl = curl_easy_duphandle(curl_default);
+		if (!slot->curl)
+			die("curl_easy_duphandle failed");
 		curl_session_count++;
 	}
 
-- 
gitgitgadget

