Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07F3A32E137
	for <git@vger.kernel.org>; Fri, 13 Mar 2026 13:39:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773409177; cv=none; b=ZMmVwOq+stENy5gx9sepqGAoL9QUrIXGpgs/NaRftp+PHfi4/gnYIxrxhry7kv6eCfF6bImPhz3DKxpdfRuU2fc6QI3kzjHnJ4MZ9h5Qn6YtsnyPtb5eq/PagvLRtJKkSCK6QbMwSSdzMX4rZe8MLSTa9Sva6svvfGivH/vQMqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773409177; c=relaxed/simple;
	bh=1ye0M7jy2GqNtgx9jg08vk2zsOEBLJ6Dwt9XzS8+SJ0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PgJyfrvT8HWYMEkgvQTQ4/rvfvYAt/hfiEp76N5xGMUBKW/95D7dQBRNlDc9x3nj3nGxigvbAex2OhKVHlQ9rFfcQJQBPGELOxLNIIdgrsQ6MW+0yp1gov2y4VxAos0v3i/+oUoNluFFO3YTsXNebDLpdza9bG9/k5IRJyRcwtQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kE3+BsFz; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kE3+BsFz"
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-829781b2b01so1474032b3a.2
        for <git@vger.kernel.org>; Fri, 13 Mar 2026 06:39:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773409175; x=1774013975; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Ngz8VvOSsajozeAmVbPtHTBA6R7Ie45SRRI/oudwuAA=;
        b=kE3+BsFzXPTnbcxZV9UB+7zBWQpuRLG1wariNItCBqMaV+ia0srxwkd6nnydWaOCe5
         Qh6c3SIM2eu3L++/XOts1XbETmtdY6eLz/m0WBbPz6gkbbuvG/RGf6jZCHcMcsGOSsxK
         ASckPFx/VJo0EQgGnhk0EQxl5xk/PgASvcbo+OkVr2TR3C4f8BVOaHgA9ljxhuRWgahT
         Or2RxaxJSmCOaTk/hf6GkkMjwnggC3jfSIbawvOLOCun9TNsnO55lHLaqaJg8XzJHJqf
         CaAgunIk+e/LRlCGWM06zy1+kQCjXkM5dkn3f3gIVdnSvGjjKjQWJNxXsNPD1M+8pUO6
         8Beg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773409175; x=1774013975;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ngz8VvOSsajozeAmVbPtHTBA6R7Ie45SRRI/oudwuAA=;
        b=k91XwH8aOrp4EgwDfPtlO/jSDGx82wc/nQdBz+l6/RKtm/r+mYQiYz+JFwTWDksNko
         dtJFg/XxFzsNPXS8bE9figWzmmxNdwh/nqArg+aMqtbhTGzJLzy+0VwaRiry29tu2VfQ
         Jcq8EoAHQzRCHbBkJz46Mi8S+yr+JezwJ3LGSR+tSsJSezh16/y8PO1nrps3UM9kYtjl
         jojqg24IkswgVAQy3X7lGQvgnvd0dpudadNik8qBSYqhjhb1ErWp1dXYdgMTdZC3yLiG
         2pDl6+yRYTjt/aVKuye3lo11xkcrS4QJnm3G8PcozrsMd8SwXPwN29r+HhsCI6R/Dc1c
         TsuQ==
X-Gm-Message-State: AOJu0Yyr1Uz0svzKE+LSCUQf6TVi7h22vY6keRVPN+inznVjqO4C77Za
	JzN1DevYKRXCf/cUbjYyr2FsJVRMyXHzA0oLGODkg7mcW8o2MpuCViXmKM7/HdUD
X-Gm-Gg: ATEYQzxm7WhEu/GTdBjqjbAtj47quDi/VX7/1W0GF7nB9aFl6UBTE2hS0YimAQC3pgC
	EdJqSqptXjN4uQU2VGTnewQQawhI+d3ull8PtllJzj1bKYOtqZkSRaB89HN+auRBSbbJC/isOpT
	JkCMLz93XxVCgOQJlpQyUIaP4a8U2iZoMRU/ROPaRF46xoG5aBYWbS7AXX0XgnF8Ml6E/XgrJaY
	XwIFryS+ULU9tORCPrZKsRx1Lm6rqCOCILdeGf8bLiFjaZfvhnloHD7IAF+oVZbW4kGGZJFWTdQ
	iIzqrHIIUBooXV6qDEEiyyJ+LiSvOm8GDp7dovffB/d0VDRg63u4dS+x3w8wXP22voUGnJoFE6n
	u/Veo7HDx2ZiZqep02FkYC9z6gYUZvhLaDHHU6Kcw7TSHCf8p8RJ/TJMU/nOTy1eQKZieHZjw19
	bK95HNCE+obWQVIDWE3t9b6Y2P7atH1Q==
X-Received: by 2002:a05:6a00:908e:b0:824:3bd9:aac6 with SMTP id d2e1a72fcca58-82a1970830emr3014550b3a.16.1773409174841;
        Fri, 13 Mar 2026 06:39:34 -0700 (PDT)
Received: from divineocn ([45.127.227.82])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82a0725bfd0sm7552946b3a.14.2026.03.13.06.39.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Mar 2026 06:39:34 -0700 (PDT)
From: aum2357 <ahambrahmasmi2357@gmail.com>
To: git@vger.kernel.org
Cc: aum2357 <ahambrahmasmi2357@gmail.com>
Subject: [PATCH] Signed-off-by: aum2357 <ahambrahmasmi2357@gmail.com>
Date: Fri, 13 Mar 2026 19:09:37 +0530
Message-ID: <20260313133937.562603-1-ahambrahmasmi2357@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

diff: use conventional comparison order

Replace `0 <= addremove_explicit` with `addremove_explicit >= 0`
to follow the common coding style where variables appear on the
left side of comparisons.
---
 builtin/add.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/add.c b/builtin/add.c
index 0ee21692c2..ad0d6047af 100644
--- a/builtin/add.c
+++ b/builtin/add.c
@@ -432,7 +432,7 @@ int cmd_add(int argc,
 	argc--;
 	argv++;
 
-	if (0 <= addremove_explicit)
+	if ( addremove_explicit >= 0 )
 		addremove = addremove_explicit;
 	else if (take_worktree_changes && ADDREMOVE_DEFAULT)
 		addremove = 0; /* "-u" was given but not "-A" */
-- 
2.53.0

