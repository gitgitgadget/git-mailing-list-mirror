Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5CDB3749E4
	for <git@vger.kernel.org>; Fri, 10 Jul 2026 17:31:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783704667; cv=none; b=uk8XZJjPbPU9YKCTAJzItku6bF2Glk/HbdLfrzTC+W5TsRYds/ooM9eoDdO6LUGBfXT+dXEjAmuA2ct9H+SEQPjoQOIVsDliiFIS3Nxus6Axr5Ze9cP6b0dwj/qixlLvI7SJOyeBjU/AxvRzoqWNDOfgsnqH7hLutH9Sar8bUMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783704667; c=relaxed/simple;
	bh=Rl/4UupZ59HqmaAbLKRVpGgyEeLRRpmoTJgyXxaECwA=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=Ge3D4V5w3ztk9ubtaJkEyyqJKi3inK8r8GcY4eeAsdHuVFJK6rXfZjUSH9vMyKmTgb15Kd5RP+nxHIFLx8J2VlYonz+kMrFt+YEOuOQfaJLHsd99k00/KaeODlBlNSQmdoDMFt5q+d4Z2aZ3k3p4aKl8YAgI9dhYKIsiFo1oBXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eCFI/prF; arc=none smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eCFI/prF"
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-8efb708b1a0so10813746d6.3
        for <git@vger.kernel.org>; Fri, 10 Jul 2026 10:31:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783704662; x=1784309462; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=j7mMLYFCsBB7AUcbNojo6aqrgE8YRZnk68S0s1QKf5U=;
        b=eCFI/prFgp+159rPnqdaxPjqa+ekbuoljDNFKMD1M8tGClbVI5eL/2kr72Pj1IgjIq
         jMOBr0/2SOGeNEptpKNCmMZlDro0D5dkD9Ay5VCpPh7X3RCIypq2w8rNHGSQV+Jkyd/5
         /bbNglRr3ltjpDkXcefCr8KFg9IRSz7o0ThQWNY5qb+L3YNqmFdm1RHQByhqdIhtVyg8
         63r74dooa3+rBLVmXHnKGmVghV7rtzAoltcmzZx2u7yGesUVPYYbq6eewWETfRM2/hmZ
         a1lReguJ2Q2aXAyonVehUiPruAMuI7WrxmxmYZ0VYgMyj0/m0WchH+0ZeC+bhrpM3nUG
         Kw4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783704662; x=1784309462;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=j7mMLYFCsBB7AUcbNojo6aqrgE8YRZnk68S0s1QKf5U=;
        b=N+7u8qIKbEaE6p6W/FE0ZNUISlAVxHYDU7w2XPOkQ4YKTPFa6+1PBu8uowILXGS6m0
         1Eu2SU9S5KvJUYcR+8qxa6hzIAnOzj6lf1i7ARkSHhpTN7G4gsGY4C0vMPhh9qxgLKSq
         34752GEDDi+7G29/1P+HJUGIvagUh17UuaBk/1HbjXJQ5v4jNDv8xshCNwz2Rk0CmuSo
         gfd+j+mt+kcck5H1U6fbWZGDn/JQa9gU20h5fwiQbYhYXvznJKf0FvF+QH92ZCwrfkdc
         MGInRe7XSOhIhlYLcveOCl5nPapOFy6TGPUS2DA8NJqX4GPV/S0BSqUff13I/7YN7Ty8
         vtfA==
X-Gm-Message-State: AOJu0Yw66He42AGEv9bKnHxDm495cYDS8cAct20EMKnhlhWBlfD16ERF
	sGsqdvZv9gBMK/JY6VwhI2q/bXXicfvemfBGsOm/Su/Zk7xgdTTwCFhEwO3Bnw==
X-Gm-Gg: AfdE7cnJDhXOlEpXbsjlipYTco5LfJOzlF3m0gcHbv++x0wJaPN5bdkclS8VmWhmd7h
	5yb0H7QqS0l5GGhEMhTEE4GZxQqowDgWEEKeQDrIVEtoDNKYazJsGxpD6T89W8GE2mkhvu2AIFx
	HsjqOiQ1JU5dTaD2TsOcIq3k4rC8qq3I44dgdSKNR/+aSuiXbsh4TiDKZCpTzYIdQBZ4rRU4Htm
	pnGy9jszz8nArhSMwlvM09aNW1d5ZFFcFmeNXmpFnwD2KsrGuC89BZlcV1P3I5NycJckLkzMbYp
	9se9UIVkHE+xsq5zXNbHxZgk5Ujo9PbBiVheaww14TlpUTxsia+HPvJFlMGGmOrBKhxxLx1uSAy
	YGHS2H39cYolXa2UAmFMa6VzpXFExN/Qqpx3MnQSNHAfSVr6yziasvZKmdE0WimPH7+kVUNDNCe
	H6v9zDRltE1oIWAbnZ
X-Received: by 2002:ad4:5dc3:0:b0:8f1:440c:7f81 with SMTP id 6a1803df08f44-903fe450e71mr116376d6.4.1783704661500;
        Fri, 10 Jul 2026 10:31:01 -0700 (PDT)
Received: from [127.0.0.1] ([172.208.127.32])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8ffd7c1ec84sm46365876d6.29.2026.07.10.10.31.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jul 2026 10:31:00 -0700 (PDT)
Message-Id: <5f56f32a74b3d900148f02901bcd104927c5e088.1783704657.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2171.v2.git.1783704657.gitgitgadget@gmail.com>
References: <pull.2171.git.1783479584.gitgitgadget@gmail.com>
	<pull.2171.v2.git.1783704657.gitgitgadget@gmail.com>
From: "Michael Montalbo via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 10 Jul 2026 17:30:56 +0000
Subject: [PATCH v2 2/3] t/lib-httpd: make http-429 first-request check atomic
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
Cc: Michael Montalbo <mmontalbo@gmail.com>,
    Michael Montalbo <mmontalbo@gmail.com>

From: Michael Montalbo <mmontalbo@gmail.com>

http-429.sh records "already returned 429 once" with a "test -f"
followed by a "touch" of a shared state file. That check-then-act is not
atomic: Apache can run this CGI for several requests at once, and two of
them can both pass the "test -f" before either "touch"es, so both treat
themselves as the first request. The retry flow that drives this
endpoint is mostly sequential, so this has not been seen to fail, but
the race is latent.

Decide whether this is the first request with a single atomic mkdir,
which fails if the directory already exists, so exactly one of any
concurrent requests is rate-limited and the rest are forwarded.

Skipping state for "permanent" is required for correctness, not just an
optimization. The marker tells a later or concurrent request that a 429
has already been served, so that it forwards to git-http-backend instead
of rate-limiting. Since "permanent" must return 429 to every request,
that marker must never become visible to another such request.

The original did not achieve this by staying stateless: its "touch" of
the marker ran unconditionally, and the "permanent" case removed it
afterward with "rm -f". That create-then-remove leaves a window in which
a concurrent "permanent" request sees the marker and is forwarded. It is
the same class of check-then-act race this patch removes from the
first-request check, latent for the same reason: the flow is mostly
sequential. This version fuses the check and the mark into one atomic
mkdir and, rather than recreate the pattern as mkdir-then-rmdir, skips
the mkdir for "permanent" with a "!= permanent" guard. No marker is ever
created, so there is no window and every "permanent" request
rate-limits.

There is no accompanying regression test. The check and the set are
adjacent commands with no external step in between to synchronize on, so
the overlap cannot be forced deterministically, only reproduced
probabilistically; the fix is preventive.

Signed-off-by: Michael Montalbo <mmontalbo@gmail.com>
---
 t/lib-httpd/http-429.sh | 28 +++++++++++++++++-----------
 1 file changed, 17 insertions(+), 11 deletions(-)

diff --git a/t/lib-httpd/http-429.sh b/t/lib-httpd/http-429.sh
index c97b16145b..9746ec67ae 100644
--- a/t/lib-httpd/http-429.sh
+++ b/t/lib-httpd/http-429.sh
@@ -26,14 +26,24 @@ repo_path="${remaining#*/}"  # Get rest (repo path)
 # The repo name is the first component before any "/"
 repo_name="${repo_path%%/*}"
 
-# Use current directory (HTTPD_ROOT_PATH) for state file
-# Create a safe filename from test_context, retry_after and repo_name
-# This ensures all requests for the same test context share the same state file
+# Use current directory (HTTPD_ROOT_PATH) for state.
+# Create a safe name from test_context, retry_after and repo_name so that all
+# requests for the same test context share the same state.
 safe_name=$(echo "${test_context}-${retry_after}-${repo_name}" | tr '/' '_' | tr -cd 'a-zA-Z0-9_-')
-state_file="http-429-state-${safe_name}"
+state="http-429-state-${safe_name}"
 
-# Check if this is the first call (no state file exists)
-if test -f "$state_file"
+# This endpoint returns 429 to the first request and forwards later ones to
+# git-http-backend, so the retry succeeds. Apache can run this CGI for several
+# requests at once, so a single atomic "mkdir" elects that first request: the
+# one whose mkdir succeeds returns 429 and leaves the directory behind as the
+# "already rate-limited" marker; every later request finds the directory (mkdir
+# fails) and is forwarded.
+#
+# "permanent" is the exception: it must return 429 to every request and never
+# succeed, so it skips the mkdir and records no state. A leftover directory
+# would make its own later requests find the marker and be forwarded, which is
+# exactly what "permanent" must not do.
+if test "$retry_after" != permanent && ! mkdir "$state" 2>/dev/null
 then
 	# Already returned 429 once, forward to git-http-backend
 	# Set PATH_INFO to just the repo path (without retry-after value)
@@ -52,9 +62,6 @@ then
 	exec "$GIT_EXEC_PATH/git-http-backend"
 fi
 
-# Mark that we've returned 429
-touch "$state_file"
-
 # Output HTTP 429 response
 printf "Status: 429 Too Many Requests\r\n"
 
@@ -67,8 +74,7 @@ case "$retry_after" in
 		printf "Retry-After: invalid-format-123abc\r\n"
 		;;
 	permanent)
-		# Always return 429, don't set state file for success
-		rm -f "$state_file"
+		# Always return 429
 		printf "Retry-After: 1\r\n"
 		printf "Content-Type: text/plain\r\n"
 		printf "\r\n"
-- 
gitgitgadget

