Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABA5F3B9D8D
	for <git@vger.kernel.org>; Wed,  8 Jul 2026 02:59:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783479591; cv=none; b=YQGws7SOzdJm6cH+AJGfuG90EC2IJLd9sBaar7ccSN0NZvvqLRHXC0mg2t6tkW5ifkybVI8dR3kirgkM4HdyXFWegqR4zwO/Mgp6rdB72+lUviYkszjZGgSDSQWzKJKqukRaYWrSLRJ67DrJn2F/koFWbqZdTiX8EWdtIIhd5lI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783479591; c=relaxed/simple;
	bh=lk3l5F0V0m+m8jocwlpUe6oRrevf5tedAQbswHdbw6o=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=kTIoBMakVM9lajZf2CPbkVcw0Uw8WiOZCYT78uOfRUgujGDHjx9VPP/x5e65VAiRXDUMq0mFQHx7bzJ446j/jcNtEpmW2V74fPQFWiKLW3x1EA2/7kCMdAydbeS7mYEvmNN8RAAIVwv0dcJzqgC1Z3ktdlpJcMm6nCLjGX1MBP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mjTqviTL; arc=none smtp.client-ip=209.85.210.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mjTqviTL"
Received: by mail-ot1-f46.google.com with SMTP id 46e09a7af769-7e9ecb1e13bso91062a34.2
        for <git@vger.kernel.org>; Tue, 07 Jul 2026 19:59:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783479589; x=1784084389; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=ztQAjFKpLP78aWMDcTBqswmAuM6rRpZe3usl3uEC4T4=;
        b=mjTqviTL4N5JM8Ii7c3QHHIMKCWG65F3WyD1w628BNtyO+If3/bBHVDSsMAyw/xyd9
         mSECl9kFf57XY/uoc9j2PLXz/swpz9Zyy0verFz+GBWi9Z9a4CvFkstpAJqGfdyavhnB
         vu3dUAjuv8VmpH9TVevJ02A0lPwWRp/sFQbqayAbpw4n2XEnpGxv/Evlcyae2LcBzCob
         1CRRzUJphNNbmYu/mZYpM+Ui1QgS85QbARDtTkcYPNgEq/y7p94dIFd7f/OzZfzESob8
         zyIDZ6yQqcxGXhWR9dIFnUqvJM4uDI82phfRDkOT1GZL3jmQC1EHi5R28yn4sIDiu3tb
         uHsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783479589; x=1784084389;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ztQAjFKpLP78aWMDcTBqswmAuM6rRpZe3usl3uEC4T4=;
        b=qb5il5br7yjflGfOW1l6V3JE3GgNkV1t6fLVSLC98/q3KJHNOrmSKDFE1/edy5k9am
         OWgFsKyIPus0pZEZrJ73nqsml+5uOsIMocH2xb7++Hkk3dAnb+3LwRsgOTyu4qxOQSY8
         V+/kwy3lnu1LfDtownPyjt52eaOu2AJwNm4FZiWI3tkI1hTh6QIPRP+2ArWZ3KW0q6Oh
         GtNxwjiSk3HdFTjn8G43v00D9WE0qsHm+p5XTVb50LauTTS+iqURQ51EC9m6Q1EUHYMi
         q+l7+t8DfWtcxFvxaxon2gAfhGzhA5KQG1Vxapi6s6+UVBnDN7mtmZ8QXbutDTHslWPY
         Ot3w==
X-Gm-Message-State: AOJu0YwiGKfrcYOgRqaxlON+xqaEbvEIt1nQp8aNDlDus6AeQQXyry9G
	Acbgg6TRm5sHenxjSBzR+luQjtRDufM/zaAwLBs0OsFq94Z6669R7jcIDb9/4gEe
X-Gm-Gg: AfdE7clYXCbSs7OPL6LG1s4HLic9Mqv+lIOzcRfCZwl0XirWYip6tYrFYtqDPrK8aYf
	DT9FFMLJvH1gKjPxUBZ5V05t1/Kkje1wTG8DpvuNwoQ2rF5VGCGZmevfEhUWs2pYBhYROApatnK
	b7fD4mBZ0JAogdidPmoIKo61GOGMUGELi/u7/IrfTYvhW3VzfwprJhanWKBQPyo2+qFpPH7uelf
	nmRQ/4wssyGpJQC7Ybk4ZIhE+lQ+MifQTVMwfT4McyQ0xHQQrVinAvUGl4MqnyaGM4uOu5LUrEj
	/arpM2cCbQZeb/uYLNRcZctuOtU4bDQBJhgt/W4l0ecnnfoveD3WLbODcW7C/vR6VzekxEVQ+5n
	rdCmtqXzbw/Y8pf8snCrr62VP4Y94oxfHx/a8/Uvk9woOQDlUOpfRXNOyyTrTQ9K3YN2sU3HexP
	TCxxgHB3VaCl/sQEZoJQ==
X-Received: by 2002:a05:6830:6a97:b0:7e9:cddb:142a with SMTP id 46e09a7af769-7ebcfe5d840mr437871a34.7.1783479588737;
        Tue, 07 Jul 2026 19:59:48 -0700 (PDT)
Received: from [127.0.0.1] ([172.202.102.208])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7ebcb2b79c9sm863416a34.22.2026.07.07.19.59.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2026 19:59:48 -0700 (PDT)
Message-Id: <efd34c17157b3183cdc851c8b17e7967b6c85506.1783479584.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2171.git.1783479584.gitgitgadget@gmail.com>
References: <pull.2171.git.1783479584.gitgitgadget@gmail.com>
From: "Michael Montalbo via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 08 Jul 2026 02:59:42 +0000
Subject: [PATCH 2/3] t/lib-httpd: make http-429 first-request check atomic
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

There is no accompanying regression test. The check and the set are
adjacent commands with no external step in between to synchronize on, so
the overlap cannot be forced deterministically, only reproduced
probabilistically; the fix is preventive.

Signed-off-by: Michael Montalbo <mmontalbo@gmail.com>
---
 t/lib-httpd/http-429.sh | 21 ++++++++++-----------
 1 file changed, 10 insertions(+), 11 deletions(-)

diff --git a/t/lib-httpd/http-429.sh b/t/lib-httpd/http-429.sh
index c97b16145b..d9bbedf1ad 100644
--- a/t/lib-httpd/http-429.sh
+++ b/t/lib-httpd/http-429.sh
@@ -26,14 +26,17 @@ repo_path="${remaining#*/}"  # Get rest (repo path)
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
+# Apache can run this CGI for concurrent requests, so the script decides
+# whether this is the first call with a single atomic "mkdir": it succeeds for
+# exactly one of any racing requests and fails for the rest. "permanent"
+# always rate-limits and records no state.
+if test "$retry_after" != permanent && ! mkdir "$state" 2>/dev/null
 then
 	# Already returned 429 once, forward to git-http-backend
 	# Set PATH_INFO to just the repo path (without retry-after value)
@@ -52,9 +55,6 @@ then
 	exec "$GIT_EXEC_PATH/git-http-backend"
 fi
 
-# Mark that we've returned 429
-touch "$state_file"
-
 # Output HTTP 429 response
 printf "Status: 429 Too Many Requests\r\n"
 
@@ -67,8 +67,7 @@ case "$retry_after" in
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

