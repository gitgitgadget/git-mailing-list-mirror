Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCCC7296BCD
	for <git@vger.kernel.org>; Thu, 13 Aug 2026 01:05:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786583144; cv=none; b=DGR/ThI4pq/QAYHTcNupJuS0zI9cdBqJa+TGxzwO5O2p5m1TBIRfHwYfzGQLThQqsgKnOgcn2o+a17/BHxO+ENxel8ixOv8bnUfSRKzCxeS+KrX/4es/+HMB6CTsxGeiVMEYngabzS+Z6+ofMHI9C+pu8BApmqzijf28D7f+Oqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786583144; c=relaxed/simple;
	bh=crxUFOA+Dn+y4G36KdWMIhsrIRlaHTEcgPblBGYHVyI=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=q1Pt1DTvQQ9/1K1l6Mr4HYcwKWSLDEPUktxoXoNL1RqtX0pUj+RrEK7+lsHSfBAGd9dFGSlvhzheUu5WvBlZtMEf5isygyEDIyQuLPLXRyDSkALu9yFE0UwxNjGeDN0S2xuZ+UvMimQ2WfDfVGjiIobmx15FpgnRqkBjyto8F04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nyugBglO; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nyugBglO"
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-52d58d7aad6so6542731cf.2
        for <git@vger.kernel.org>; Wed, 12 Aug 2026 18:05:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786583142; x=1787187942; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=FAZCKzpx7uOoUE9Vohoquj3ULZLbs2zlj4FH4aWskPo=;
        b=nyugBglOG13elvxvmlGuaahXvpbXK7PxTBocSNxm1ep5S2ShmrtQGtoUA8S4ksmPrT
         jYxHusB7N41c3VU7VpOzgkxanZ5ttHwEPp5vgUV9anI2BaBB09yWsMCKW2MGHstBcsZA
         iafPXaKWNP1Y4sRv5PIK/za+41rg9xih6ai0cGYJEkuG7uvTEzFBEZyEAQuxXIDWPtAL
         JPUu1Yz1127Bql+gMVprVPbOo/kXpP/5nGvgA64D//YDo7xrqe70RaE7DNTDOJfoyOhz
         BkfUnyyA2zkbmVsFlwX6MvGV9EkrNksmC6++Doxc/yZ/6aHu/4Db/rtUR2xczn9qeSZm
         CsuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786583142; x=1787187942;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=FAZCKzpx7uOoUE9Vohoquj3ULZLbs2zlj4FH4aWskPo=;
        b=oSCJqBHQ0I+SXRhKXxc2GVD539qInYrLy6ew8Dhr9gZCAyBEgM4rv+W5LDFPHTq2ml
         Nuj/1weJK72pFCuZmGQxgwFP/w0ydjivJP8vuqMS4DN/qF8rrZVAuQcpqQt2Lc+V7b0l
         9gPL83T8WLQ0oYC6tW4a3t3ULtHvYIiwCE2p9PkwSsPJynzpfVp0CpY8EXgQ/CcESIDx
         TguZb4O2IJICUaodFtLS5xHWgvDIpLDFtUhjz0WPCCZH2/bkhyD8mZrbvDrr5IvEWmDA
         7gBbRnjNorB79yRiHECr68IqV3vR0i5+aNUG4aRV8qS4QeJvZ6IZL5Bs5IU8fX+r2Byx
         x9vw==
X-Gm-Message-State: AOJu0YzlStL1uzW/mUto13GmM99smdYcX6tZZJsqx1NLI4Wza2blnC3x
	hXKs9WHHiraX+VhngGzMoIw3sq10pH64lZQ/oQ5tOUFl97YO+tlOLTvF2fTonw==
X-Gm-Gg: AR+sD10ecvGAmmYdzVBjqYFQhbkjuCOVLXtimP2RjO5kb3y0JshzuZjKLd2lcVKjJAy
	5iDvKvqdmYqcC9Mm67dMwM0luWLGp96ZmRnUVKyKbfz7u4AgyWKyZJSIxs1d5NcYunC86HwOxyu
	PSOX0zsor533Fq7ESMHp8udUuMDowolAaAfSN+8mPcTB2j0jz2ZIBBX2p0r3zSvTpyTTuVYzbfj
	ZEVWEYdrVyZJxlL6ECLq5QCVUqMxo8oCs012CSEdHYxmAYVXQF3jsVpAoGYQxlleTCEiq2bcOCm
	Bxbttff5ZnRSc24PHho6ZtVAlieybjG0aGEo5SmFAUi9TMknG4M9PW7Gln2Y+F5fn+Qjk1/t5l/
	i0hsDf9x7QiGaUVrRbQX8ghu9C4FK+be0ZTA++1NduLqqK9FuDGC4uBotVRObbswoXshJlMpxF8
	YEUt9BMrKsSrjvyU/PB3Xzj2pAjRpD2F+vUlVEWgQA1nGEDaKbsKsWA5Hwbp/7mzrbEQ+F
X-Received: by 2002:ac8:574a:0:b0:516:d699:a99b with SMTP id d75a77b69052e-52d73da2a13mr21105261cf.40.1786583141590;
        Wed, 12 Aug 2026 18:05:41 -0700 (PDT)
Received: from [127.0.0.1] ([48.214.53.178])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-52d73fb43fbsm6053811cf.15.2026.08.12.18.05.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Aug 2026 18:05:41 -0700 (PDT)
Message-Id: <8ed22c02a192e10ab46c7df61e92a3669faaf25a.1786583137.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2171.v3.git.1786583137.gitgitgadget@gmail.com>
References: <pull.2171.git.1783479584.gitgitgadget@gmail.com>
	<pull.2171.v3.git.1786583137.gitgitgadget@gmail.com>
From: "Michael Montalbo via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 13 Aug 2026 01:05:35 +0000
Subject: [PATCH v3 2/3] t/lib-httpd: make http-429 first-request check atomic
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
    Michael Montalbo <mmontalbo@gmail.com>,
    Michael Montalbo <mmontalbo@gmail.com>

From: Michael Montalbo <mmontalbo@gmail.com>

http-429.sh returns 429 to the first request for an endpoint and
forwards later ones to git-http-backend so the retry succeeds. It
remembers that it has already answered 429 by checking for a shared
state file with "test -f" and creating it with "touch".

That "check-and-set" is not atomic. Apache runs the CGI for several
requests at once, so two of them can pass the "test -f" before either
"touch"es the file, and both then answer as the first request. The
retry flow is mostly sequential, so this has not been observed to fail,
but the race is latent. Replace the check and the "touch" with a single
atomic "mkdir", which fails if the directory already exists, so exactly
one of the concurrent requests is rate-limited and the rest are
forwarded.

The "permanent" mode needs one extra step, for correctness rather than
tidiness. The marker means "429 already served, now forward", so it must
never be visible to a request that must itself return 429. Since
"permanent" returns 429 to every request, it must leave no marker. The
original did not manage this. It ran the "touch" unconditionally and
removed the file with "rm -f" in the "permanent" case, and that
"create-then-remove" has the same racy window: a concurrent "permanent"
request can see the marker before the "rm -f" and be wrongly forwarded.
Skipping the "mkdir" entirely for "permanent" (the "!= permanent" guard)
leaves no marker at all, so every "permanent" request rate-limits.

There is no regression test. The check and the set are adjacent commands
with nothing in between to synchronize on, so the overlap cannot be
forced deterministically, only reproduced by chance; the fix is
preventive.

Signed-off-by: Michael Montalbo <mmontalbo@gmail.com>
---
 t/lib-httpd/http-429.sh | 30 ++++++++++++++++++------------
 1 file changed, 18 insertions(+), 12 deletions(-)

diff --git a/t/lib-httpd/http-429.sh b/t/lib-httpd/http-429.sh
index c97b16145b..904cdacbd0 100644
--- a/t/lib-httpd/http-429.sh
+++ b/t/lib-httpd/http-429.sh
@@ -3,7 +3,7 @@
 # Script to return HTTP 429 Too Many Requests responses for testing retry logic.
 # Usage: /http_429/<test-context>/<retry-after-value>/<repo-path>
 #
-# The test-context is a unique identifier for each test to isolate state files.
+# The test-context is a unique identifier for each test to isolate state directories.
 # The retry-after-value can be:
 #   - A number (e.g., "1", "2", "100") - sets Retry-After header to that many seconds
 #   - "none" - no Retry-After header
@@ -26,14 +26,24 @@ repo_path="${remaining#*/}"  # Get rest (repo path)
 # The repo name is the first component before any "/"
 repo_name="${repo_path%%/*}"
 
-# Use current directory (HTTPD_ROOT_PATH) for state file
-# Create a safe filename from test_context, retry_after and repo_name
-# This ensures all requests for the same test context share the same state file
+# Store state in the current directory (HTTPD_ROOT_PATH). Build a safe name
+# from test_context, retry_after, and repo_name, so that all requests for one
+# test context share the same state.
 safe_name=$(echo "${test_context}-${retry_after}-${repo_name}" | tr '/' '_' | tr -cd 'a-zA-Z0-9_-')
-state_file="http-429-state-${safe_name}"
+state="http-429-state-${safe_name}"
 
-# Check if this is the first call (no state file exists)
-if test -f "$state_file"
+# This endpoint returns 429 to the first request. It forwards every later
+# request to git-http-backend, so the retry succeeds. Apache can run this CGI
+# for several requests at the same time. A single atomic "mkdir" selects the
+# first request, because only one "mkdir" succeeds. That request returns 429
+# and leaves the directory as the "already rate-limited" marker. Every later
+# "mkdir" fails, so the endpoint forwards those requests.
+#
+# "permanent" is the exception. It must return 429 to every request, so it
+# skips the "mkdir" and records no state. A leftover directory would let a
+# later "permanent" request find the marker. The endpoint would forward that
+# request, which "permanent" must not allow.
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

