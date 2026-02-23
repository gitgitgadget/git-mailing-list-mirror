Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4C66221726
	for <git@vger.kernel.org>; Mon, 23 Feb 2026 19:43:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771875818; cv=none; b=ENGNUIzg0WUAqRwYVeMp2LBa5uaHEZrWMl2WWHwo1Cul6c6Jvfs904n1XTVQ3b4bOzwBwOoSNSdWVjL2PJtkIfN7euqOC1WNWNTkRNrNGw2QqyW/GtLhOn5H5WH5GFJJBT3VeHbkmFANUYXtvfls07gMNlPLFZ0O4ubuvqm7taM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771875818; c=relaxed/simple;
	bh=9OkTPPLqfG5Ki8Nw8MMA4y2GC8evNVfyo7LHaiIN1pA=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=JlODwL/5tTBuXtcWG3aFLwGDSkeMoag9RXiNUR1122PdGs0rq2DdUR2qh44EXOBEyQTh/UeSndwe2UDfIqVr9ywU0XqsCdIAd72r7b9u6GbsIFaIVkGFxgbraXjD1oZL2TJ1chUbk2GlZUt3qDGZXJBaYWJBRm5HHCjzRRxTxHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FPtYbw6B; arc=none smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FPtYbw6B"
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-8946e0884afso79148096d6.1
        for <git@vger.kernel.org>; Mon, 23 Feb 2026 11:43:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771875815; x=1772480615; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s3cyJrMJSIZrDx2UiYIPsu3tJVr02ZUWZC2ppILeW48=;
        b=FPtYbw6Bvs9TKQF9LLAzLf+hamQW4L/U8yFCxDCAXzp4t88z45s/NuNgaaEZNCwZq0
         lPruxv8mvmz62rhMbK/z4944BuANCE44aAtcs32hRR33vsH0BmQNPa/P9uQ/eqEcr9t9
         Y1wIEqNMCBGJ6nR2x+Yw+oERuZPpbLfgBRBd3LjMWvjkI7P59TpEhDGiZcM2eaJYDnyD
         W7M4/vr7JhKNFEi8x26vSo42IKe2czTxuhPr344r6uLpQnwG8HOv7b6Lii48rmlZCnXh
         igpb7zVFlm0stmCb+aX60+jL0JIeIVv8Tr3veGpHCvh9X/r6PAtdZqY22Mzrz0m5WfJ1
         M2Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771875815; x=1772480615;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=s3cyJrMJSIZrDx2UiYIPsu3tJVr02ZUWZC2ppILeW48=;
        b=xIeyRzLUuH8wdzETqqQmlkKceQ5+f/++wkrqsxh74nOqVRWpGoVJ0ngghnxwQ2N63a
         K2vGfVddT39QXKNgV1yqKb3OLSn1tVHGkRBV9zKETgzubDAYaI1CO7baOPUPfIoMEYhr
         xrJClP2FwMVJ5P810ZsU2kYKnNrRPaIVkRODY1POgNIPa+BHD2w+uguSAJYU9v6nJagH
         AL9qE4pt6mEzjzFjJxb2Fat8Iecmk5s57JYZ1Tpcujpg+cxD35Bg97VwrYbgjosmvIkc
         Ghyz+R5Vol0Rp3leasn+X6FgBe/9SZqamP2xzDi6Dx1FQAi8QKLO6+baj0KoDzgwlAdj
         9vvw==
X-Gm-Message-State: AOJu0Yy6vnPo/SoI+Amlmax/wVxS0l1s2fr94ioQ/yPUWZ9a3bim327J
	wHoAyVzbLL4OSEAU3jam9sJas+4g9raUcbEt9spftn1YxY0uJPj3vXbiNJkJ6g==
X-Gm-Gg: AZuq6aJzhhQM6honVdk4rJmHPPTrdygtyQCUy5rvgaUrMCSEfOJ0HfFukO6d6w4NmKF
	0xK6T2CnvWhzPhjPhc3NxeAAA6hbtZwrh7owqaIr8Z8pVJ2EjVjnHijKQXCivR9fyHMPBqkSbkv
	XuQS0wApUabz6BJ0vyluSoJnJeHM4cA3Z3ZHMsZukiIs3S6Fwl9ArJjylBAJiBB921Cu5LUf4Dd
	6P5/apkDcVnoRuBUI1rNkK5mrdSRCqD4MN8Z1yMfnRdtw/MmodNLUMjh157jv1PLFxvsbY+yk3P
	IIL0/IBBSiHJyHEOO0X4GdcQJ68to3a/2c5Dd2uc8kyj8IJc6Q1mH4qKPgHL04ZZaMNj6XPmqtr
	8cbv/4EOVt5yFoJ0ydm+3h5tf6R5/e4IARNioD/lbDbjS0n8rt2R15NpJo13hnly1nzz46agNdl
	/hvRSiSu3y66pvCZ8P5HGqAxvvULo=
X-Received: by 2002:ac8:5cd2:0:b0:4ed:bad6:9fa9 with SMTP id d75a77b69052e-5070bba0e2amr139585311cf.6.1771875814420;
        Mon, 23 Feb 2026 11:43:34 -0800 (PST)
Received: from [127.0.0.1] ([135.232.224.163])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5072afdef0bsm8424131cf.16.2026.02.23.11.43.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Feb 2026 11:43:33 -0800 (PST)
Message-Id: <pull.2208.v3.git.git.1771875812.gitgitgadget@gmail.com>
In-Reply-To: <pull.2208.v2.git.git.1771856469.gitgitgadget@gmail.com>
References: <pull.2208.v2.git.git.1771856469.gitgitgadget@gmail.com>
From: "eslam reda via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 23 Feb 2026 19:43:27 +0000
Subject: [PATCH v3 0/5] repo: extend info path reporting and structure statistics
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
Cc: Karthik Nayak <karthik.188@gmail.com>,
    Justin Tobler <jltobler@gmail.com>,
    Ayush Chandekar <ayu.chandekar@gmail.com>,
    Siddharth Asthana <siddharthasthana31@gmail.com>,
    Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>,
    eslam reda <eslam.reda.div@gmail.com>


This series improves git repo info and git repo structure with a
================================================================

cleanly split commit history and explicit documentation/tests.

For git repo info, this series:

 * introduces explicit command context plumbing (instead of ad-hoc global
   reliance in this codepath),
 * adds category-key expansion (for example, requesting layout expands to
   layout.* keys),
 * adds path-oriented keys (path.*) that expose repository locations,
 * adds --path-format=(absolute|relative) to control path rendering.

For git repo structure, this series adds richer metrics:

 * maximum inflated object size (overall + per type),
 * maximum on-disk object size (overall + per type),
 * maximum commit parent count,
 * maximum tree entry count,
 * maximum blob path length and path depth,
 * maximum annotated tag chain depth,
 * aggregate keyvalue/nul totals (references.count, objects.count,
   objects.inflated_size, objects.disk_size).

Tests and documentation are updated accordingly.

----------------------------------------------------------------------------


Why this change
===============

The intent is to make git repo more script-friendly and more useful for
repository diagnostics:

 * repo info becomes easier to query programmatically (category keys,
   explicit path formatting).
 * repo structure becomes more actionable by exposing outlier-focused
   metrics (maxima), not only totals.
 * keyvalue/nul output now includes aggregate totals so scripts do not need
   to recompute them externally.

----------------------------------------------------------------------------


Commit structure (v2 rewrite)
=============================

This iteration rewrites history into smaller logical steps (no
“fix-on-fix”):

 1. repo: teach info context and category keys
 2. repo: add path keys to repo info
 3. repo: add --path-format for info path output
 4. repo: add structure max object size metrics
 5. repo: add structure topology and path-depth metrics
 6. repo: add aggregate structure totals to keyvalue output
 7. t1900: cover repo info path keys and path-format
 8. t1901: extend structure metric coverage and portability
 9. docs: describe repo info path keys and structure metrics

All commits are signed off using real-name identity.

----------------------------------------------------------------------------


Changes since v1
================

 * Rewrote series into smaller logical commits.
 * Folded fixes into proper history (no trailing fix-up patches).
 * Unified author/sign-off identity to real name.
 * Addressed portability concerns raised in review:
   * hash-algorithm-sensitive expectations are handled robustly,
   * BSD/macOS wc whitespace behavior is handled in tests.
 * Improved test robustness around keyvalue/nul expectations.
 * Expanded docs to explicitly describe new keys/metrics and behavior.
 * Revalidated in Docker with focused and full test runs.

----------------------------------------------------------------------------


Validation
==========

Focused:

 * t1900-repo.sh
 * GIT_TEST_DEFAULT_REF_FORMAT=reftable t/t1901-repo-structure.sh

Full:

 * make -C t -j4 test in clean Docker environment
 * Result: failed 0

----------------------------------------------------------------------------

Eslam reda ragheb (5):
  repo: teach info context and category keys
  repo: add path keys to repo info
  repo: add --path-format for info path output
  t1900: cover repo info path keys and path-format
  docs: describe repo info path keys

 Documentation/git-repo.adoc |  60 ++++++++-
 builtin/repo.c              | 244 +++++++++++++++++++++++++++++++++---
 t/t1900-repo.sh             | 196 +++++++++++++++++++++++++++++
 3 files changed, 480 insertions(+), 20 deletions(-)


base-commit: 7c02d39fc2ed2702223c7674f73150d9a7e61ba4
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-2208%2Feslam-reda-div%2Fgsoc-contribute-v3
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-2208/eslam-reda-div/gsoc-contribute-v3
Pull-Request: https://github.com/git/git/pull/2208

Range-diff vs v2:

  1:  99c8058298 =  1:  e9ea572e52 repo: teach info context and category keys
  2:  6d5b9ff075 =  2:  348e361fe7 repo: add path keys to repo info
  3:  5c438d045b =  3:  93585ad079 repo: add --path-format for info path output
  4:  504d9cf7a0 <  -:  ---------- repo: add structure max object size metrics
  5:  4b502925c9 <  -:  ---------- repo: add structure topology and path-depth metrics
  6:  1751181950 <  -:  ---------- repo: add aggregate structure totals to keyvalue output
  7:  fd18f28db0 =  4:  6ea263fee9 t1900: cover repo info path keys and path-format
  8:  0525ed4cd9 <  -:  ---------- t1901: extend structure metric coverage and portability
  9:  f17c0f03e5 !  5:  a2a6768042 docs: describe repo info path keys and structure metrics
     @@ Metadata
      Author: Eslam reda ragheb <eslam.reda.div@gmail.com>
      
       ## Commit message ##
     -    docs: describe repo info path keys and structure metrics
     +    docs: describe repo info path keys
      
     -    Document the newly added repo info capabilities, including
     -    category keys and path-oriented key definitions.
     -
     -    Also describe --path-format behavior for path outputs.
     -
     -    Update git repo structure documentation to cover newly reported
     -    maxima and aggregate keyvalue/nul fields.
     -
     -    This keeps command behavior and output keys fully specified for
     -    users and scripts.
     +    Document repo info category keys, path.* keys, and
     +    --path-format behavior.
      
          Signed-off-by: Eslam reda ragheb <eslam.reda.div@gmail.com>
      
     @@ Documentation/git-repo.adoc: supported:
       `structure [--format=(table|keyvalue|nul) | -z]`::
       	Retrieve statistics about the current repository structure. The
       	following kinds of information are reported:
     -@@ Documentation/git-repo.adoc: supported:
     - * Reachable object counts categorized by type
     - * Total inflated size of reachable objects by type
     - * Total disk size of reachable objects by type
     -+* Largest inflated reachable object size by type
     -+* Largest disk size of a reachable object by type
     -+* Largest parent count among reachable commits
     -+* Largest entry count among reachable trees
     -+* Longest and deepest path among reachable blobs
     -+* Deepest annotated tag chain
     - +
     - The output format can be chosen through the flag `--format`. Three formats are
     - supported:
     -@@ Documentation/git-repo.adoc: supported:
     - `keyvalue`:::
     - 	Each line of output contains a key-value pair for a repository stat.
     - 	The '=' character is used to delimit between the key and the value.
     -+	Both aggregate metrics and per-type metrics are included.
     - 	Values containing "unusual" characters are quoted as explained for the
     - 	configuration variable `core.quotePath` (see linkgit:git-config[1]).
     - 
      @@ Documentation/git-repo.adoc: supported:
       
       INFO KEYS

-- 
gitgitgadget
