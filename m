Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48E7337646A
	for <git@vger.kernel.org>; Thu, 26 Mar 2026 14:11:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774534294; cv=none; b=H6WdjfzDDPHEKxMG/GTSYWz1SKN1P3k9xqDqoIgfvTGSjJawke8LTEbhn0cVknV3YtzgtuNGVquxL2c8yCg4R47SKkdTtbOxATZu8FHLmLDwAEVV0GSzvKjGnfusKDlcUQGLb+e/fILjpG8yKFH0ub/HgkBt3FgNd233Jmfu1Tk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774534294; c=relaxed/simple;
	bh=19MIFEAOmgn2d7iGZO8AWPRO+jkPjje/jaXCq4qHmjA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ALKIbPW0vTCnJW6qSfbThkTZhNAGzMaorCxBkV1KqZ9FIoWRAoUtmlS4l0Ci19UGmHsktcP7DH9ZsSs1oJCl0GTpsjqtCT20mLLuGlzNrCWD57UDtEwfcDBZbxSnYF8jhuIzNarCcpQYRglRNuOugICIJYnnDL4vR3odWNh06jI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pCBun3Nc; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pCBun3Nc"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2aae4816912so6821965ad.2
        for <git@vger.kernel.org>; Thu, 26 Mar 2026 07:11:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774534285; x=1775139085; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=IBkwaPycZDKGf5tYTp1EezdBf1GBDEvmbiMXQ5FXMpA=;
        b=pCBun3NcVaOQOz2cLKwz/Sb3ojQpqXWLV9UQDhvYSc2eldyOlvig7oiCOy9Jtosr67
         4fpi0EUpVvi5Gavq0xjTT4eAEKoOvz6QaCYeaKlk5FSnZbYHca20tPrMU+a0GKpZvmpn
         942ouOxKxz+/jSgD0LhBkRmRbM+Faee3CSfUBo3WZMq/WwW2mReK6v9dS3bPf9ft+JSe
         vvkI+cPUfUG3sCViJHxhhYPXL9dN/k77viDPbsFhyc0WEapXjZrjOseN9w78uuT2De15
         wWzDP/q5JsoCo+xPnQR4JVzrbAfNNZYEN1Wr3GcDSJbyZtO3OsK3cMrMja69LkivJWwu
         0Gnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774534285; x=1775139085;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IBkwaPycZDKGf5tYTp1EezdBf1GBDEvmbiMXQ5FXMpA=;
        b=e83iM85kP6sx70MNixGt/+6z9c3Az9+J1pnLBCxLxC17NwYvMlMMoUJ45JrWhsITl9
         g9yPZHhbtdRvt5tl165+DpOv0+lWKT7GzMj9O841u8m4VImh0xIK1ETT6N0pMuQc1LSs
         UBmPr+A++iFGFUjJsutx6cc0RPF4ferlgGIIo+TYl014Kvlt4fWAzpv1j34ZwBR3Y4yQ
         OyUqpHlCr7vGLFkRkygG46KBz3mwx6fHwOqmLfuCLElUNmyz8BG6XUTzGDkhe+Sevbv0
         J7+tI4oXr+AtjdB5lMAGqGOutjbNfbPlwfctKWZm062qozX0fqQZTniLS2z2W3lQi148
         ioCg==
X-Gm-Message-State: AOJu0Ywb+ofyui3PYRLoNRKTQYppvsA5+FBTrlyztXC8oo+SYg10KjpP
	PxCkL+tAsXFMfX98PjfysyP5yiUjyWbsblIJ1XLXAVBFnWz6tlKeOScxNWM8PrPX
X-Gm-Gg: ATEYQzygoHkiRDVLhkYcOh0qysfMckHvLXFcwkKMJUQpv6keMUMZt6hcrVITqB4Drwb
	1h900XngN1wwYU5dqg9l6IuOw/nVAGOGmUm3FzLkpSJacIX/Sv5qn1OAwKwLZMNRCUrzk4BjhGx
	2C5+sV3BtE9YpbrMYSQkDsiCTyuWTekeZAu3SJnxY/DsuwJLFwNrGvIoLhS6Z29EosOxPi8ormS
	/E+BhFhsyXmcHDqKp8RCH//chuIzuuDBPZJg9kiS7IlE4fW53Xw7CvvUVIadN1rxl1eoxsNx+tb
	BdVeVLHYwVvM6xcZY0iefu4LuArclBafn5/ffUOhhTTrq5S7KsYCskWUlXqF+j06oRwZeb8flTv
	wF2YsxCfrns9i9JbXXa/ePWztVo+3KdtQjNyJZYdufhXpUCiBMusdqI6mrs/9BBAOGMtFBsZ+v2
	1Ll3HgECG/130Y573H81cPKI7TRqV8m47ExbNAeN2ND5AWMVDv+Nmso3/kr4Z741tHivXYVZeIj
	hlw8lqiWWPaYZuIwOrt
X-Received: by 2002:a17:903:3c28:b0:2b0:6d2d:f1da with SMTP id d9443c01a7336-2b0b0b1dba8mr87712195ad.50.1774534285102;
        Thu, 26 Mar 2026 07:11:25 -0700 (PDT)
Received: from trieu2-huynh-trieuhpn-ubuntu24.bee-live.svc.cluster.local ([27.122.242.65])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b0bc881fe7sm34657845ad.48.2026.03.26.07.11.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Mar 2026 07:11:24 -0700 (PDT)
From: Trieu Huynh <vikingtc4@gmail.com>
To: git@vger.kernel.org
Cc: Trieu Huynh <vikingtc4@gmail.com>
Subject: [GSoC PATCH] t8003: avoid suppressing git's exit code
Date: Thu, 26 Mar 2026 23:11:18 +0900
Message-ID: <20260326141118.146155-1-vikingtc4@gmail.com>
X-Mailer: git-send-email 2.53.0.719.g41688c1a23
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Update t8003-blame-corner-cases.sh to redirect git-blame output
to a temporary file instead of piping it directly to not hide
the exit code of git commands behind pipes, as a crash in git
might go unnoticed.

Signed-off-by: Trieu Huynh <vikingtc4@gmail.com>
---
 t/t8003-blame-corner-cases.sh | 42 +++++++++++++++++++++++------------
 1 file changed, 28 insertions(+), 14 deletions(-)

diff --git a/t/t8003-blame-corner-cases.sh b/t/t8003-blame-corner-cases.sh
index 731265541a..f753e26e82 100755
--- a/t/t8003-blame-corner-cases.sh
+++ b/t/t8003-blame-corner-cases.sh
@@ -50,67 +50,78 @@ test_expect_success setup '
 
 test_expect_success 'straight copy without -C' '
 
-	git blame uno | grep Second
+	git blame uno >actual &&
+	grep Second actual
 
 '
 
 test_expect_success 'straight move without -C' '
 
-	git blame dos | grep Initial
+	git blame dos >actual &&
+	grep Initial actual
 
 '
 
 test_expect_success 'straight copy with -C' '
 
-	git blame -C1 uno | grep Second
+	git blame -C1 uno >actual &&
+	grep Second actual
 
 '
 
 test_expect_success 'straight move with -C' '
 
-	git blame -C1 dos | grep Initial
+	git blame -C1 dos >actual &&
+	grep Initial actual
 
 '
 
 test_expect_success 'straight copy with -C -C' '
 
-	git blame -C -C1 uno | grep Initial
+	git blame -C -C1 uno >actual &&
+	grep Initial actual
 
 '
 
 test_expect_success 'straight move with -C -C' '
 
-	git blame -C -C1 dos | grep Initial
+	git blame -C -C1 dos >actual &&
+	grep Initial actual
 
 '
 
 test_expect_success 'append without -C' '
 
-	git blame -L2 tres | grep Second
+	git blame -L2 tres >actual &&
+	grep Second actual
 
 '
 
 test_expect_success 'append with -C' '
 
-	git blame -L2 -C1 tres | grep Second
+	git blame -L2 -C1 tres >actual &&
+	grep Second actual
 
 '
 
 test_expect_success 'append with -C -C' '
 
-	git blame -L2 -C -C1 tres | grep Second
+	git blame -L2 -C -C1 tres >actual &&
+	grep Second actual
 
 '
 
 test_expect_success 'append with -C -C -C' '
 
-	git blame -L2 -C -C -C1 tres | grep Initial
+	git blame -L2 -C -C -C1 tres >actual &&
+	grep Initial actual
 
 '
 
 test_expect_success 'blame wholesale copy' '
 
-	git blame -f -C -C1 HEAD^ -- cow | sed -e "$pick_fc" >current &&
+	git blame -f -C -C1 HEAD^ -- cow >actual &&
+	sed -e "$pick_fc" actual >current &&
 	cat >expected <<-\EOF &&
 	mouse-Initial
 	mouse-Second
@@ -122,7 +133,8 @@ test_expect_success 'blame wholesale copy' '
 
 test_expect_success 'blame wholesale copy and more' '
 
-	git blame -f -C -C1 HEAD -- cow | sed -e "$pick_fc" >current &&
+	git blame -f -C -C1 HEAD -- cow >actual &&
+	sed -e "$pick_fc" actual >current &&
 	cat >expected <<-\EOF &&
 	mouse-Initial
 	mouse-Second
@@ -144,7 +156,8 @@ test_expect_success 'blame wholesale copy and more in the index' '
 	EOF
 	git add horse &&
 	test_when_finished "git rm -f horse" &&
-	git blame -f -C -C1 -- horse | sed -e "$pick_fc" >current &&
+	git blame -f -C -C1 -- horse >actual &&
+	sed -e "$pick_fc" actual >current &&
 	cat >expected <<-\EOF &&
 	mouse-Initial
 	mouse-Second
@@ -168,7 +181,8 @@ test_expect_success 'blame during cherry-pick with file rename conflict' '
 	(git cherry-pick HEAD@{1} || test $? -eq 1) &&
 	git show HEAD@{1}:rodent > rodent &&
 	git add rodent &&
-	git blame -f -C -C1 rodent | sed -e "$pick_fc" >current &&
+	git blame -f -C -C1 rodent >actual &&
+	sed -e "$pick_fc" actual >current &&
 	cat >expected <<-\EOF &&
 	mouse-Initial
 	mouse-Second
-- 
2.53.0.719.g41688c1a23

