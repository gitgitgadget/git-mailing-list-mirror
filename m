Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CB5C2BE643
	for <git@vger.kernel.org>; Sun,  7 Sep 2025 19:45:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757274344; cv=none; b=GckyT+EPYO6BRpSbXcE7jYr8K+EUojOi6EQQdX5CnQkTC/mbMtzwYgsoDZHvAivLekGQB9ynulcKO2u0Ih+35ZBARA3FfpChXVaXQd6qy8s8fLvAOYpSL0TBGyhajaJ6PMOtePGVnd3KI5pA9tJP8GNyYtVD91R8jbJbmh6hEjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757274344; c=relaxed/simple;
	bh=6RU4Kz0K796lr9gWPCW8yy+u8L6EmkTlXgqcJIEoJ3Q=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=SEIzEyX7CjHfUL4nSE7mgsvvjU41g91P5yyuZzUbULiPz0Qwu9PeMsku/12iBxM2lbBN0hXFkc1WgSRkdGQu7XT66sKOs4NdYDKwjqySlDFGBOnLMlUMwKr1AhPwbaxdnwDpwLvEmfstnSL8HPBXfE0YRBUgfCTUxloEh0rUUcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jBCr7jBR; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jBCr7jBR"
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-4b548745253so56247891cf.0
        for <git@vger.kernel.org>; Sun, 07 Sep 2025 12:45:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757274342; x=1757879142; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E2RLhmwKFG6QLURA67o8rVWAhKoI11M88JdeTBbM36E=;
        b=jBCr7jBRGcTGxcWJ1/v3DkYrqC3qGh0q5mhTAYVMSyOIL0vvTxLoc9iIL7wol8rBeO
         oAfJLNcAae7zGn95kOo/buQQ7lrj0gRDZuFvaJnyVH5M9xy4THCn0/h6jzfmFw/heE1B
         dN8Ggaf13qnXv/hw93HSj0AvfXqgFv3hTRArGQhFuZYVsViPqZV1Cn8xO+AUQSTjwytD
         XH4X9+6iOHM3gT/9bJkH/60ewqtqFaRX04dDPv2g1uJwlYKg7b+Bqh/SFtUreFOBqUOk
         EkiDm6XwLaZc+T4d++LFaEPp/VdQl+a8mWlptl9KrsTMCbRwuR3kGH21fgpUoUdU5bea
         ZelQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757274342; x=1757879142;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=E2RLhmwKFG6QLURA67o8rVWAhKoI11M88JdeTBbM36E=;
        b=pzP1rTAvUmWFkxpUrrXcWRZCC5gicNzz6WnwamhsawdmzxtC/yXDxo0X9ev6J9Km09
         1w4r6++x0qvpvN9qBbZgzVXA+c4jTQVISzAKvfAngj+1Ckes+oyaFiFJbepamww3wmw+
         dFC8uQdcDAAuprwUaItBQv/428Y8Co5wN6kHxAGtcvtQG8ExADlclDKuYiWw6oag9zjJ
         pC45+AsvBaq84iHfjS5SQ6XnZpCsxQipYA0GRFJjA5ifYh+Klk/0j3jgWQ7xuw4qeYJm
         dhTTk5+ltqfvzjASVj1SH1RddhhZsNs1LfATXC+nbR9kjwylfjJTyia58MQtmN+vS57g
         pUQA==
X-Gm-Message-State: AOJu0YwfCxaBu+ZXbkWn47uUUYnIbKvr6K6oE1PW7fVf3gSuzd+yhAIO
	xZvbaw4Go2uo6QCbipoyXb1+ItwgtIG7YzCXFNOO3WsO6OpL/hhxqxC2tfBU92Zx
X-Gm-Gg: ASbGncskM/AJlcCr8n8bJkX2snftfm0w/4BAHoSgKo4z/0gOSLKYjxgXtlTvLrv1f4i
	LTt5oeOegRpEh1BhK0fIRAOjVc68OM9e5OBpINA5b/NoZH8SD4dZMJygxM+DthZS3f9bt7D4oXL
	Y+SU5sOiOwarUIW3FIkh4b8+j7hrhN48v3i0uVvh5bghFCix6MyonxwwI9Bt2fq8Gqs56Rg15HK
	mJA7pADOQv8+4FhvB2RqvaHE7uBF680ns2+xAAA2h+RHUWCEg4xqz/tlvMGgOQqwqlLgNqNMlTR
	daSdp8ZU5WJKcsbSNJRlX1YgTuuAt4GiErL5r3vW0vMDUcR2ylTbl5djFzrztyxcsWDU5fG4s8P
	5UP+wt+QCRrL4Mj2ZiVbvdBgScHXrKFmi4A==
X-Google-Smtp-Source: AGHT+IFSJk6LDHZTD7I23oBGxXDqSiTn7vs06gyxubOJDQW8UjPXOe5S1kTdkJcD3QBdRonsKJRbgw==
X-Received: by 2002:ac8:5d4c:0:b0:4b4:8f9f:746d with SMTP id d75a77b69052e-4b5f8398f8cmr63400791cf.24.1757274342123;
        Sun, 07 Sep 2025 12:45:42 -0700 (PDT)
Received: from [127.0.0.1] ([20.161.28.97])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-7426533bdeasm23210426d6.39.2025.09.07.12.45.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Sep 2025 12:45:41 -0700 (PDT)
Message-Id: <00401e775a110f4713c3f6aa72a54476ec699aa9.1757274320.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2048.git.git.1757274320.gitgitgadget@gmail.com>
References: <pull.2048.git.git.1757274320.gitgitgadget@gmail.com>
From: "Ezekiel Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sun, 07 Sep 2025 19:45:20 +0000
Subject: [PATCH 17/17] xdiff: change the types of dstart, dend, rchg, and
 rindex in xdfile_t
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
Cc: Ezekiel Newren <ezekielnewren@gmail.com>,
    Ezekiel Newren <ezekielnewren@gmail.com>

From: Ezekiel Newren <ezekielnewren@gmail.com>

Signed-off-by: Ezekiel Newren <ezekielnewren@gmail.com>
---
 xdiff/xtypes.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/xdiff/xtypes.h b/xdiff/xtypes.h
index 070674d7c4..08301bf932 100644
--- a/xdiff/xtypes.h
+++ b/xdiff/xtypes.h
@@ -48,9 +48,9 @@ typedef struct s_xrecord {
 typedef struct s_xdfile {
 	xrecord_t *recs;
 	usize nrec;
-	long dstart, dend;
-	char *rchg;
-	long *rindex;
+	i32 dstart, dend;
+	u8 *rchg;
+	usize *rindex;
 	usize nreff;
 } xdfile_t;
 
-- 
gitgitgadget
