Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9199B2D838E
	for <git@vger.kernel.org>; Sat, 28 Mar 2026 20:03:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774728199; cv=none; b=N8K4jZ9p1Nc/G0xLoMFKUpVIhPLXTxdSM2GuaGbrZ13Ms17ICWDf2lTdcP/VUbwJwE0JQ/S0K6mhnXcLp88TsrX2BsgGPjgYtcxYTUsmJAoFnkoySKW2o+tOXdNCOv69jTvECJth3KbAftPyTKzTzTDL+tRG7Ce1wzv5iGzpq8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774728199; c=relaxed/simple;
	bh=2bUsWt6qPnPhN4MRv8qZIbEwKwiMG/yfEwH5JOv9CGQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=L/ytJXXDwrcyYMtCAllMc3/Lm68EZ+aU3rqAkP6AgyH39SVItoGywszbOq1YDEc2hvy0wBXsQoRrq2fiZFUqE/M0RQ/MnMuPcSlOw0uzIx+84Z2dRcL3fMa6+cWzArCqkfGY6a/5ghNGnk591Rj+zfZ8SJl3E7j+cLKsmT88qCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JRLnHqCy; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JRLnHqCy"
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-35d96be7c13so469207a91.0
        for <git@vger.kernel.org>; Sat, 28 Mar 2026 13:03:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774728198; x=1775332998; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o213e6rRmDLtD+xKX1NUgxZXXXfQ/g2G+I/frpJ9atU=;
        b=JRLnHqCyuVcHuSrr7Hn7jY5q26IkjJopSHnbmbeUZEGWygt256ywyvjwYCZqMAQIaR
         xzr3ouKOa5AEyEDfXwC/CIv5xeWBKjI9wBWq0bANNOZpt8sI5+WsEb7u6WbErVq7sXpG
         ZNlhCE8uAlDnDgdaEBMtWqgw/k11Ljf8pot5K114xuYwq32Rv+DyD9Yl2WGcYEpJC9Gs
         g3oVDkTmP0F0RoTCVja87gvYskZAKZCOuqatb1N0KldBUwx7Fg7u2sd2VcMU1DISh2NW
         BHC/obv+ZSs94YN3u9Fue2WtrDy7b47y6nji95PZovmyBl6jFXiVunDyR54S+ctKfigt
         cBzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774728198; x=1775332998;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=o213e6rRmDLtD+xKX1NUgxZXXXfQ/g2G+I/frpJ9atU=;
        b=gpsjBKZndha5Hkf6QnwHwQtt8Tqt3sVl9GEZ7OnUUK9iCJk8PdHcrht++ppBzi8n10
         yUqp7mUQ7w6DTRxmTLTaCBXVgIYDt0Qa+Z5vrpgueRGfVQZsLu7sY8bv2SHDoIJ9RkQp
         AdAmX96o3RSKxGBMfKXRarPCjyiokvhX41iqNsRlG6wQgnfNBnMshLQnLBZ8kHXBFzEE
         iFD6TW4PRZ2UvudBFlAkcE6viR1bkAcV/S4TfFH3qQLnVH2QU+3gIlW1QUQmAd5q4UaI
         +VNCrZuidw451Lp8J+7JmxfJKfT5l1B1DFnJlnJMSWbGIADcDRjIzoDdOuISJsKGBK0K
         yZbA==
X-Gm-Message-State: AOJu0Yx+QNosTKyCP/HeYUgzMVRx3fUhV5qXJBWySEhAeusk+Xanq4u8
	QywaCtzcaNWENjrq+vKBrmJFvg3nBgZ7uWYjW7ZpUOTu/LsmDKk/3bXOkI95mdA3
X-Gm-Gg: ATEYQzxL+f3/t3BAfTy2uQ1Cb+bTioH6FN1zzHBQjCVO71hQv3VpuDV8cBsw4+lr2WL
	W1goTWz2Gbc1iCTHilceIaMDm0tFI+fNzDzIlcSM6LLMZ2IcpQbVXnqnZdy36AKDAftSMzU2FmW
	wC/x+ddOonkVrxZT/xQphdi3C3QYh6Rf/Ztsq+4tI1OVH0thk8QmbgRdsuRIE/tAZquRCGDdbNu
	Z59ka9MQ06kkHgh+K9drg4E2DsxWhFI4/28CoqXZxeZaIRV5LZ541uOdz/CtYxcCV9TIo1VwzCb
	kprEv4w0EcvbhC2wMkOinsJHQyPiFk39JefatzcSYCjN9NoyLMVL9Q01uhS7Zj20u9FRPIae5rw
	C2U3+60pyydZ/xHCnVPChzXv8FWjKL/B0mTMXjw64lQQDZ1/aFnq/gGqVuL9JGfnv/iXVuLWHxr
	CdH8JpbbXZWVsCT8hP2GVmHxROXBNeRmqueO6cxKArkoyVEEzGkVg8RRPLirMaIJauWU4MqII6Y
	qRGpwxLpg==
X-Received: by 2002:a17:90b:3b8b:b0:35b:9e53:e2df with SMTP id 98e67ed59e1d1-35c227baeb3mr8976353a91.2.1774728197523;
        Sat, 28 Mar 2026 13:03:17 -0700 (PDT)
Received: from trieu2-huynh-trieuhpn-ubuntu24.bee-live.svc.cluster.local ([27.122.242.65])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c76917bb31asm2359786a12.23.2026.03.28.13.03.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Mar 2026 13:03:16 -0700 (PDT)
From: Trieu Huynh <vikingtc4@gmail.com>
To: git@vger.kernel.org
Cc: Trieu Huynh <vikingtc4@gmail.com>
Subject: [GSoC PATCH 07/16] t4153: avoid suppressing git's exit code
Date: Sun, 29 Mar 2026 05:02:46 +0900
Message-ID: <20260328200255.247759-8-vikingtc4@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260328200255.247759-1-vikingtc4@gmail.com>
References: <20260328200255.247759-1-vikingtc4@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Update t4153-am-resume-override-opts.sh to redirect git-cmds
output to a temporary file instead of piping it directly to
not hide the exit code of git commands behind pipes, as a crash
in git might go unnoticed.

Signed-off-by: Trieu Huynh <vikingtc4@gmail.com>
---
 t/t4153-am-resume-override-opts.sh | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/t/t4153-am-resume-override-opts.sh b/t/t4153-am-resume-override-opts.sh
index 9bec989a0e..30137aec20 100755
--- a/t/t4153-am-resume-override-opts.sh
+++ b/t/t4153-am-resume-override-opts.sh
@@ -81,7 +81,8 @@ test_expect_success '--signoff overrides --no-signoff' '
 
 	# Applied side1 will be signed off
 	echo "Signed-off-by: $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL>" >expected &&
-	git cat-file commit HEAD^ | grep "Signed-off-by:" >actual &&
+	git cat-file commit HEAD^ >commit_raw &&
+	test_grep "Signed-off-by:" commit_raw >actual &&
 	test_cmp expected actual &&
 
 	# Applied side2 will not be signed off
-- 
2.43.0

