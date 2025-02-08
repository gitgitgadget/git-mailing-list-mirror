Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79BF5A23
	for <git@vger.kernel.org>; Sat,  8 Feb 2025 16:57:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739033866; cv=none; b=n29NVPuutxDHUyTAW2sCsrmVM/Qh8+eHGjf8ZK11n7hDixSOOSKOd6aSI+f3ZfBY5BPy9GOHOQeZo7RswAP0iSKvIEIYN1MHppli0AMrtAKHYPpdrIR4TJNWWSJYGuJXipZoo9w4aVkd518Ovf5m8X/LVmUjcudr9I+z1eLVCVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739033866; c=relaxed/simple;
	bh=r6AeLjOAC7NqFAe2lFE3jaTXysfPlUnlVHmP2x0u7kg=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=GYoIuFmVcPnMrUcvx6Qliv2LuKmeSmmffkkkWEYCqrRR6PUo465wEAVR+KCUszjp5JnjbCACPjn/3Cp6JlMxGMleUc9AmkA4WwuMmjOeQqvXI0UmkuVvfp3X6wO5RtpkWH84Cgwws74FPPnZWA01v+OYLOn9j52NE+vuH3XGg04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bv6r/RJ7; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bv6r/RJ7"
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-2fa286ea7e8so2420607a91.2
        for <git@vger.kernel.org>; Sat, 08 Feb 2025 08:57:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739033863; x=1739638663; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=oJZ5WF/S1w+T59TKU5ISCjd4yuP9/czJcm3r5svc8Oc=;
        b=bv6r/RJ7S/kKX8fYZCnxPxoJWmw/06XjqWWFpFExh7okmSf6OmiJlFOI7OZxfB8PcJ
         zKmguh8TB+2rvX0Iqc8pLVVKqMqQ/vONFDtJdSX0ZPSe18kmMRiQ1+jPRMfeyow1XjKZ
         /uiPO2T1gDARKr/g9TlT6xFXSXzIzPmS3eJU3bQnt4CKXUGOd4wcl9jiC6YZSJtV7L6w
         qiva9MKBS1K33ElOnWWlV93ta+i/ivJy95TK0pUzoQczmMbaPyoPmejHWUtJqgOXDaej
         hns+7dc6OlrHxCryZNLj9SC72MTdzsKSnKAYc3wRtJDNnABI3q0dpMbAboS/hmAXlbOn
         WUXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739033863; x=1739638663;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oJZ5WF/S1w+T59TKU5ISCjd4yuP9/czJcm3r5svc8Oc=;
        b=f35gE62yE1ARm6HCeDKhXhxp0V7gXVIjC6x3ScMKlv3dZaPGpF5fTEdiBPykKWF3KK
         AJtywp1Wtq7IOgB8s/Pl1g7FSP+SLl8QChjpNBH2mEsqarGcNUWIOyrEp9cRDB8KN3E7
         Rr8KSbSjViUYDYv1rBqohgN19rryo3FkrlLobHUebUmF6xz+TZQi0WRo1KmIeYvbwe9E
         GoJY0SXi6aw1r8hCu9hRkt50nl+a2lKd8RHdeHz65VjaaizipbvtBWiBO1HPfQpmTUHo
         TFhHSDPAWsWYpZy3GTvoXdNKE3/blH3EmTNO/GLOdsEFJguOaLDqVRuxJIL5pblskfoO
         C9pg==
X-Gm-Message-State: AOJu0Yxsg0odVw6ByhCGx+r4kQZu22G0rlhhuFG+3lhAUt9LpooLM4rb
	zFPLzVd+3Cf2ehTBbW16tBQjgFB5GCCnCc4Yv8yRUxDCk3ejPLxUdNwS+Q==
X-Gm-Gg: ASbGnctihPbNwnDO4VsDiu14N6QpKxg6aqzhCbbAZs7sqsBK/NoVgdc35NLMJZFJx2G
	7+7sAr8rMllCCPm9DrV5KQA/asCLiJlK+eB9Mxd0zgsyqeyg30SM4twxpdmN6kG5l35jZNPb1Kx
	uyLzZQcOFnB+igkUho8XDSIvS3VYHcYnyjY6LaS5NDbXI9tIyUGa6/P37BfU6sUChcPPJH9ub1L
	JEsxpZ4fcQZphXUO5LitQmSS8ggA/WE5Q/fAQSTCdPwA5sdnTjP8feRIBKUd4r5YycN+QfVZYxn
	PuNGIfM8W7XFcoSW0GffuB5BzX4qlWG0WqEW
X-Google-Smtp-Source: AGHT+IE4mdTpjCg/4vtUeqZKbjnzrY8Zn7rqjGI9iPKBNbDe1n0pXou/UMyHZ7/wKDNtpRTzgm6hkg==
X-Received: by 2002:a05:6a00:815:b0:71e:21:d2d8 with SMTP id d2e1a72fcca58-7305d4508d6mr12284582b3a.7.1739033862846;
        Sat, 08 Feb 2025 08:57:42 -0800 (PST)
Received: from localhost.localdomain ([189.62.150.56])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73048a9d903sm4933129b3a.13.2025.02.08.08.57.40
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Feb 2025 08:57:42 -0800 (PST)
From: Lucas Oshiro <lucasseikioshiro@gmail.com>
To: git@vger.kernel.org
Subject: [GSoC][PATCH] t7603: replace test -f by test_path_is_file
Date: Sat,  8 Feb 2025 13:57:31 -0300
Message-ID: <20250208165731.78804-1-lucasseikioshiro@gmail.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

`test_path_is_file` provides a better output when asserting whether a
file exists. Replace the occurrences of `test -f` in 7603 by it,
facilitating the trace of possible test fails.

Signed-off-by: Lucas Oshiro <lucasseikioshiro@gmail.com>
---
 t/t7603-merge-reduce-heads.sh | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/t/t7603-merge-reduce-heads.sh b/t/t7603-merge-reduce-heads.sh
index 4887ca705b..1f8c3b7ccb 100755
--- a/t/t7603-merge-reduce-heads.sh
+++ b/t/t7603-merge-reduce-heads.sh
@@ -52,12 +52,12 @@ test_expect_success 'merge c1 with c2, c3, c4, c5' '
 	test "$(git rev-parse c3)" = "$(git rev-parse HEAD^3)" &&
 	test "$(git rev-parse c5)" = "$(git rev-parse HEAD^4)" &&
 	git diff --exit-code &&
-	test -f c0.c &&
-	test -f c1.c &&
-	test -f c2.c &&
-	test -f c3.c &&
-	test -f c4.c &&
-	test -f c5.c &&
+	test_path_is_file c0.c &&
+	test_path_is_file c1.c &&
+	test_path_is_file c2.c &&
+	test_path_is_file c3.c &&
+	test_path_is_file c4.c &&
+	test_path_is_file c5.c &&
 	git show --format=%s -s >actual &&
 	! grep c1 actual &&
 	grep c2 actual &&
@@ -75,12 +75,12 @@ test_expect_success 'pull c2, c3, c4, c5 into c1' '
 	test "$(git rev-parse c3)" = "$(git rev-parse HEAD^3)" &&
 	test "$(git rev-parse c5)" = "$(git rev-parse HEAD^4)" &&
 	git diff --exit-code &&
-	test -f c0.c &&
-	test -f c1.c &&
-	test -f c2.c &&
-	test -f c3.c &&
-	test -f c4.c &&
-	test -f c5.c &&
+	test_path_is_file c0.c &&
+	test_path_is_file c1.c &&
+	test_path_is_file c2.c &&
+	test_path_is_file c3.c &&
+	test_path_is_file c4.c &&
+	test_path_is_file c5.c &&
 	git show --format=%s -s >actual &&
 	! grep c1 actual &&
 	grep c2 actual &&
-- 
2.47.1

