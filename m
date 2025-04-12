Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11EB020E03F
	for <git@vger.kernel.org>; Sat, 12 Apr 2025 18:15:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744481740; cv=none; b=rgdqneXC1a+zIDOkU3HiA8qQBq3aisJoAB0nQ+fk2ajZHm0JlTPM5w6QFxdNiQDfZi9uAq8liwX9wpAJPwguqA5AhP3Z7HnG6K1zGX4B2Dn9WlRWruxk800lHUFxVFAFpcrijRVu+CnAGEVQ+LmyMFYt0t2yXNTDGp34EHCyAsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744481740; c=relaxed/simple;
	bh=ZWN2MYGjP1xdqTTsLBMoU2agzEliXWhudqtojn4xsCY=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=HJQop3uL0lxUZrc8kulZRfNW1OZsHWKwkI5oyvnw7ErAxAEolTkOg3bIjEvYLuc9fZN9BFjl592tAlbZFkPhqCluM6o1JHW7q/phClymY6z5jz5z5eY6LOZ7nCBQtUng7iFwb3xFFvAF8N3VYD5IAcjRxY02SsIHhRk0MUM6Nl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KKfHRGTc; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KKfHRGTc"
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-39c31e4c3e5so1896587f8f.0
        for <git@vger.kernel.org>; Sat, 12 Apr 2025 11:15:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744481737; x=1745086537; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MGr/XzAg5R3LfC3ivsucjN1QW7T4+QNbAHtUXfPMwc4=;
        b=KKfHRGTc8wR2b+A3rNtb9imnWr53u52LmxW0NAOCbOiU9Nei+oSHHwo3PbvMP0CWJs
         7ZhVe7A2AObEf6ayvDyy3Uf8yEhRKXkBWM04VGC0tXBn+qNBwO52lhFO1t3Jxlpoxl3U
         rYtSutt99+1ukOhEOrFrIJLXMlGuAOnwzaaOnW3RMbEQBNUABqaO1PQqnDTL28W/H6tc
         bRG3uo5prkemXhoAQGR/KlP+SbqgH0i2ViHnuw1k1CwaGfjiq5EfTufIeohQWlvadMfn
         bV36xN2K1aGHXqjstK/5tZBCwG3PJJY7DnGcY4HU7XA4f3cuVhMh+8/ZTE+K7gDKxhS3
         noog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744481737; x=1745086537;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MGr/XzAg5R3LfC3ivsucjN1QW7T4+QNbAHtUXfPMwc4=;
        b=Y6/JU9Zqo6eLMSAbkdtR2kmW1bow6gGm7C6VL8wLLEJS//lnszxEuPZ3ZFgx3djhWp
         LsRwp63JzclgiJN+5iDzmChz7nlHvGE/vQJwL5B4yIuUplAtOupOugteG4iybKj+zWll
         O5k0HqeEcOqF/z7Trd9fLAXpXnokloH3T1kahQbuv8znDHSLGWn8eXyfv88IjWjJx06M
         QtRQav0qUvvzMv1fZolXNIYXNy9vNDYZNp+FC2f5Ydrv/YnJaREJisATFDtZGGRUSa+a
         UwEH3/55Tjs2D79NTzzpK1BEjpWyd45OKIq47DjccFZDpQu9h5yZIKO/5z73aE28ztUS
         FJrw==
X-Gm-Message-State: AOJu0YwuEdAi0yWNpdQAafN8jIrpqnFY7DgELKs5N2t3Qi9VL1lmyNIC
	UxL6t0NcU07F71THv/KErnnR+JSUKaXmmHH2JzpuREMniOsdFzCysJkOWQ==
X-Gm-Gg: ASbGnctw5pep+3HOXlR6t10zLih6nTCKgnldcEHKZy8VGgY2cURFUA6hnLp4PBYOKoe
	iDFmPdPdDlvrxJoxEbw6Oq2fEv/T8gsLTdujepauC5xjGHDu4grtceFoXmCq9wvuzHHoEwTrtOu
	xXyIVIBr3yH9AnpU5WD2acU2exz/OQGPUvqsZoQvUl+u0PYIWp43sSGC8yQnzvLnhYAxy+wkwhF
	CEnAsfOq+mHc3cpmtpJXPbRhA09jLgouFPNlRfq3YvYFlSJxWYwrIA+igbQFuXEhGep9f9k1m73
	2Qexg3TNw7etTK57dAevbEd0CzRWgEcSmBtxbe070A==
X-Google-Smtp-Source: AGHT+IHfyVwIumCnhbTJ031E0pPry9r1OgGGrQNPOWTWmR6V0ueLZA7fm+ag5cqGbTz93fAPUj7aqw==
X-Received: by 2002:a05:6000:1845:b0:391:3028:c779 with SMTP id ffacd0b85a97d-39eaaebd566mr5852722f8f.45.1744481736752;
        Sat, 12 Apr 2025 11:15:36 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43f235a5d31sm122160035e9.35.2025.04.12.11.15.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Apr 2025 11:15:36 -0700 (PDT)
Message-Id: <41a093d570a5756f730b069980edafbcedf5c8bc.1744481732.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1936.v2.git.git.1744481732.gitgitgadget@gmail.com>
References: <pull.1936.git.git.1743181669.gitgitgadget@gmail.com>
	<pull.1936.v2.git.git.1744481732.gitgitgadget@gmail.com>
From: "Philippe Blain via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sat, 12 Apr 2025 18:15:30 +0000
Subject: [PATCH v2 1/3] p7821: fix test_perf invocation for prereqs
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
Cc: Victoria Dye <vdye@github.com>,
    Neeraj Singh <neerajsi@microsoft.com>,
    Patrick Steinhardt <ps@pks.im>,
    Philippe Blain <levraiphilippeblain@gmail.com>,
    Philippe Blain <levraiphilippeblain@gmail.com>

From: Philippe Blain <levraiphilippeblain@gmail.com>

Since 5dccd9155f (t/perf: add iteration setup mechanism to perf-lib,
2022-04-04), perf tests need to declare their prerequisites with
'--prereq', after the test title. p7821 was forgotten in that commit,
such that running that test on a machine where the PCRE prereq is not
satisfied aborts the test with:

    error: bug in the test script: test_wrapper_ needs 2 positional parameters

Fix this by correcting the two 'test_perf' invocations in that test
suite.

Signed-off-by: Philippe Blain <levraiphilippeblain@gmail.com>
---
 t/perf/p7821-grep-engines-fixed.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/t/perf/p7821-grep-engines-fixed.sh b/t/perf/p7821-grep-engines-fixed.sh
index 61e41b82cff..1d126c7b039 100755
--- a/t/perf/p7821-grep-engines-fixed.sh
+++ b/t/perf/p7821-grep-engines-fixed.sh
@@ -33,13 +33,13 @@ do
 		fi
 		if ! test_have_prereq PERF_GREP_ENGINES_THREADS
 		then
-			test_perf $prereq "$engine grep$GIT_PERF_7821_GREP_OPTS $pattern" "
+			test_perf "$engine grep$GIT_PERF_7821_GREP_OPTS $pattern" --prereq "$prereq" "
 				git -c grep.patternType=$engine grep$GIT_PERF_7821_GREP_OPTS $pattern >'out.$engine' || :
 			"
 		else
 			for threads in $GIT_PERF_GREP_THREADS
 			do
-				test_perf PTHREADS,$prereq "$engine grep$GIT_PERF_7821_GREP_OPTS $pattern with $threads threads" "
+				test_perf "$engine grep$GIT_PERF_7821_GREP_OPTS $pattern with $threads threads" --prereq "PTHREADS,$prereq" "
 					git -c grep.patternType=$engine -c grep.threads=$threads grep$GIT_PERF_7821_GREP_OPTS $pattern >'out.$engine.$threads' || :
 				"
 			done
-- 
gitgitgadget

