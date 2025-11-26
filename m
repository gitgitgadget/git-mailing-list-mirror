Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47AFE322A00
	for <git@vger.kernel.org>; Wed, 26 Nov 2025 12:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764160232; cv=none; b=H2BtR9dWXmQEaZ0ye7oEqR9vfxq0dVIfoeNJvj2i/9aIu0y8YW7htUxTJSmrfnxxNDonEC/ghYnnpzpIlzHMYI1wjnElUZoc0xNVMYukezZd2qkuUOwhT13joX8JIAW2a+9tyg+dmTX+bc/EXF3evRCCGYy/2uNI6zGfi5yVBDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764160232; c=relaxed/simple;
	bh=z1KRbQZHe7rwsr2tMkLXHZ/R+vhH3lNvsdQDYMSwgGQ=;
	h=Message-Id:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=Cu4CH1jTDqeW1e3URjRrtaFEz49OJPWqihEbruJIuqLNXQrS+Plc8zPRdluGp6Bl2CwihQev5R43mZsBbpdgqqn3MZqAs5WDfErqcotpB4PsddN+ZzZ2VfdUktgrIJFf7zivFDql4dmKVpLcfX3p5IKPJT0B5iOND5Ax27XZCUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SWL3MzBD; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SWL3MzBD"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2956d816c10so77502285ad.1
        for <git@vger.kernel.org>; Wed, 26 Nov 2025 04:30:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764160230; x=1764765030; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=tD+qtPoif0qdviPTdVqiwyzMZ8OInoXUdSBbGZdW4pw=;
        b=SWL3MzBDFZNI8pc4e+wqDmBBQZMRJG/hW6ySirDxQm80oQR8S3pTI72SzKR6SEny6P
         NBgEa7qgBJASSJYt0gpCxhvlNzsS/IAqTvSxuxJQ1tajsfrcZu2x+GLKeQZSXweaP8z2
         PmhYtsbSLh4VY2cVpgHy0W/KIdhaE5AxX5PZM0OzJDkF7g51qqZ92Yhqnf1BwIFKzcLL
         nsLXXDZdEjypQTsg9KirUETERxP556sdPU99e4ecNKZofQAleMs3duSWRHoujnn2RSqx
         JIzjVOIwC7FYofxtDZ5qo+TzryUeWs2If4AWbo+tr/PIAh/GTHBJZYSj2W3vCxuUIJas
         eL+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764160230; x=1764765030;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tD+qtPoif0qdviPTdVqiwyzMZ8OInoXUdSBbGZdW4pw=;
        b=T5ZVbwJeYQEsqYPiHHiT8cVR5co3V1slmMjM3p5hQ4GxuUKVZaDvSY4AUUbZ/T8kVu
         TRrspYkVChJXAFBBcMzoma6IvaPhf95RnoPzGAfGqHCfY0zRyvJsf/1gXCPLHCDHHjQn
         xQe7MZxYXmBFc3vmlGYIdiigJyMJYIutzLwxbOhmbLH1BW90A7Q5irZdZLQqjHuu9VTX
         D5zI1ZiIa6il0cFL7dUuo6gZcH7/O4iBwZGxhs4BrKJqnmGE55DPeRP0J7IFw3YVIyx4
         5gXi+JE7PpkR6BZfULKiCauo/rpMhVCeROEbIav/3x4gER5DCRnftBJpNx68QeYZO+6F
         tOIA==
X-Gm-Message-State: AOJu0YzIngNXRdyqGJcSek8qBk+82YF1KFbYnX6bA6VAqWBi0DMPV8mk
	qmZSjXWTHbBoDe/nrtUt883pi7h6WhXuwSW5Vw/LreKSO3EGi17pjKndHk0Ylg==
X-Gm-Gg: ASbGncu+TURU40eMv/AUMakC8rpT3VZ+ZKf1lovjHFCXHTLJcWvcCsGMDlpfSmn7vK7
	b5ZxMDMxHTdXrf1BVvNQeM0oj1pjnnWwMGnSeTV08UccmvJlI0os60XvL1v2FVrWAjQIUcfaZRb
	Lf4Eplv67exqNJcod3uzR+swCQ7ar87nmo6Gu/msqBStDwV7t8KSVXiK+8wNTT0stbzFXFkoxc/
	yrqu135yFi1reVgoPVSxH1Pm6ZRS6yeI4mjjIYglqS0CeKYLkHg6Vytc9AHSavcHaumcvRH8KMf
	FwYhxVkeYwoVosNzckQ7RWGnnzeeAd5DMW5K8IgFIm67UQLB5PDtTjl75KrvjVkFXDIHPHZRz7o
	v/j0ItXbafjtJY/VsRbmcW0jhLP5pdjKwCSo2Geenmrmtfn5xy5xKA82EjbS6FlG9z+u4dlZmEv
	ykGNPQqPAYkKxGwss=
X-Google-Smtp-Source: AGHT+IFsra0wysnFA0+pktfVrzsAg/XZeVXXgxtkUFvPLR9sS7cENA4yXNj/7mUmsePHnlr0Vqwgzg==
X-Received: by 2002:a17:903:1ae3:b0:265:47:a7bd with SMTP id d9443c01a7336-29b6be8c881mr210346355ad.4.1764160229938;
        Wed, 26 Nov 2025 04:30:29 -0800 (PST)
Received: from [127.0.0.1] ([172.182.195.178])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29b5b1077e9sm201235205ad.15.2025.11.26.04.30.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Nov 2025 04:30:28 -0800 (PST)
Message-Id: <pull.2008.git.1764160227.gitgitgadget@gmail.com>
From: "Vaidas Pilkauskas via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 26 Nov 2025 12:30:24 +0000
Subject: [PATCH 0/3] http: add support for HTTP 429 rate limit retries
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
Cc: Vaidas Pilkauskas <vaidas.pilkauskas@shopify.com>

This patch series adds support for handling HTTP 429 (Too Many Requests)
responses in Git's HTTP client with automatic retry logic.

Git hosting services can implement rate limiting to protect their
infrastructure. When these limits are reached, servers respond with HTTP 429
status codes, potentially including a Retry-After header to indicate when
the client should retry. Currently, Git treats these responses as fatal
errors, forcing users to manually retry their operations.

This series implements automatic retry support with three new configuration
options:

 * http.maxRetries: Controls the maximum number of retry attempts (default:
   0, opt-in behavior)

 * http.retryAfter: Provides a fallback delay when the server doesn't
   include a Retry-After header (default: -1, fail if no header)

 * http.maxRetryTime: Sets an upper limit on any single retry delay
   (default: 300 seconds) to prevent indefinite blocking

The implementation includes:

Patch 1: Core HTTP 429 retry logic with support for RFC-compliant
Retry-After headers (both delay-seconds and HTTP-date formats),
comprehensive configuration options, and fail-fast behavior for excessive
delays. Includes extensive test coverage.

Patch 2: Fixes a pre-existing memory leak in show_http_message() that became
more visible with the new retry logic.

Patch 3: Adds trace2 instrumentation to enable monitoring and debugging of
retry operations in production environments.

The retry behavior is disabled by default (maxRetries = 0), requiring
explicit opt-in, ensuring backward compatibility while providing a robust
solution for environments that need rate limit handling.

There was a previous attempt to add retry support [1], which was not merged.
It had support for 50x status codes. Should they be supported here too?

[1] https://lore.kernel.org/git/20201012184806.166251-3-smcallis@google.com/

Vaidas Pilkauskas (3): http: add support for HTTP 429 rate limit retries
remote-curl: fix memory leak in show_http_message() http: add trace2 logging
for retry operations

Documentation/config/http.adoc | 24 ++ http-push.c | 8 + http-walker.c | 5 +
http.c | 171 ++++++++++++- http.h | 2 + remote-curl.c | 18 +- t/meson.build
| 1 + t/t5584-http-429-retry.sh | 429 +++++++++++++++++++++++++++++++++ 8
files changed, 650 insertions(+), 8 deletions(-) create mode 100755
t/t5584-http-429-retry.sh

-- 2.50.1

Vaidas Pilkauskas (3):
  http: add support for HTTP 429 rate limit retries
  remote-curl: fix memory leak in show_http_message()
  http: add trace2 logging for retry operations

 Documentation/config/http.adoc |  24 ++
 http-push.c                    |   8 +
 http-walker.c                  |   5 +
 http.c                         | 171 ++++++++++++-
 http.h                         |   2 +
 remote-curl.c                  |  18 +-
 t/meson.build                  |   1 +
 t/t5584-http-429-retry.sh      | 429 +++++++++++++++++++++++++++++++++
 8 files changed, 650 insertions(+), 8 deletions(-)
 create mode 100755 t/t5584-http-429-retry.sh


base-commit: 6ab38b7e9cc7adafc304f3204616a4debd49c6e9
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-2008%2Fvaidas-shopify%2Fretry-after-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-2008/vaidas-shopify/retry-after-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/2008
-- 
gitgitgadget
