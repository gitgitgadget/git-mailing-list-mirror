Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E10718D626
	for <git@vger.kernel.org>; Sun, 16 Mar 2025 06:59:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742108347; cv=none; b=XvrNBCaMu6Lv7Pjeuqgq/yf8F1xtvAUJR4Ixm71XBY9pJ2MaXabub/BuY++81Z6mfWoFR+x4sk0E/Qm6o1MP0ZlmwaRxhQ+r7/qS1L02c/gHsuQEfXdnDs6SVVWYDwuqOKmlE1tsVhvV7gwFODHNNTnRVZ7r5v/4asm81XeXT00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742108347; c=relaxed/simple;
	bh=P0AihyQtwl+k4TA3rt8C/P4D9lb00MM93DtUo8WFoIA=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=QBmIa3XVAekdQMth+qozQsjSGWR+mSKDfMj8xBr2G132NawcVy7+7VtoZafYdtBotH7TLRWRuifNzTekLwDWsipdLae5ISft4nq6I1cq7td1omDJFh/gAZKrgSAaeggct69FaNfgX0It3pxjv9PvHoNu2Wkj3f30KhX/3k7Hik8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eYkzvglk; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eYkzvglk"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4394345e4d5so7205395e9.0
        for <git@vger.kernel.org>; Sat, 15 Mar 2025 23:59:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742108344; x=1742713144; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hllZ1uHsA8dJwFQtBkOFIWs9+0fnyx5kVbDHNJ2Mdtg=;
        b=eYkzvglkrldgTsuJeyNT97IbFjs9mbyq9QKxF1FTPzN6O2OSuCLFnv8U0f0V45xqy1
         UsjjJ63jG72IEdDiv0i1298nTR0HsSbN+LHN9TmGlbic3kdveSiMcyhJg4Xl4HRjuhf+
         3lDU4/dHW8tdt4NhqRweObYCpkWrwk+WVD6Cxob9Ru57mraHf8oYzlLUYN7TPB7ZCZY6
         0SJpX5ETDCKLWhsJ+ExPgPcY4UJCGT7XuqXFWa6uzau5NkTCilDhcFR8ISZwqHTgN6iN
         SMcBKV7tNLpSnBUrsvfAruO4vRytjdG1VkifonnZ/sK2B1MYS4Adqc5rWi7GfoKV/+yn
         9aYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742108344; x=1742713144;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hllZ1uHsA8dJwFQtBkOFIWs9+0fnyx5kVbDHNJ2Mdtg=;
        b=B77xC0oW0jPOG9ur/uFwIJZ2XI5EENLJJ+lrZcvpQbLgDAZ87zNxcr/ZuMIsuEIFtP
         EABI2A91aU58YjHAuJil/QcIKMRUoksHox+cMpDauHB5pnRymWIdttnZr6zYu3vUD1fk
         3LgYtJ7fgPsk4U/5Zyt4j5dq3Aela6BgJsW4IqHDNRDRxbcreCWZmoG1NcTrd4KPihPY
         pQIKJpkCOenP07jviFMwnQ5gKW9U9JL2dewjqmjMa9Elcgn1piOyi92g5V/7dqXZqD9P
         5WPIYCxcIkVza87/0K8wc5R2SBV66N4RatG8y/6RjEzCTfGU7RiJeVEaQNtFCq8FeLuJ
         8Cfg==
X-Gm-Message-State: AOJu0YxVrjedpIlwWsRp/QUem0XjC7IopiAu/g8zA/7MvGG3vzMW/LxV
	rX/HoOWKxqjJr63IfR6djNyGulxMwxnDSbTcRKQMmFHSQKwun8iMTMvt2w==
X-Gm-Gg: ASbGnctL635IqwLfh8X+MB0q4pDxmJTcIojznrA3dmj9ra9uC2dC5fnfBGlsRnggF0y
	wIvu4+9sRx6mKzOQE3r2rQ2wYgm3PcKHsv95IKQ1Rp6t8n5Q/56Z3zXrnfi4L2g/dQXqW+AXxi7
	nlNrHVQfqD0Eq84p5MlLEV7h1trRlRuwg9fnwo+11eITqzN05Ctt77bQp4wLdKNM40cpFfcDBnk
	PXxhrE64u2m32OqYeX2PqdBZMncO9KFzCsfuqc3xdpBUCyNNBRBmWGkUzcFDUtP321Qqu5z7TiB
	QHVd9sQrT7bIUj9f4PvlQ40pdOwH4pQQ+1qViXN7ha10PA==
X-Google-Smtp-Source: AGHT+IFXz7XhBbNRhbpjPBQHm6BLXi5Rhb/LFaSOwxfbAie2QGjdb6PVKM2vV6uxNqZFiVxFf8yjeA==
X-Received: by 2002:a05:600d:1c:b0:43d:79:ae1b with SMTP id 5b1f17b1804b1-43d2018096amr100318325e9.14.1742108343498;
        Sat, 15 Mar 2025 23:59:03 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d200fad64sm69749515e9.25.2025.03.15.23.59.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Mar 2025 23:59:03 -0700 (PDT)
Message-Id: <9f6a1669f39d26db8c9cd5c9db290f8708dce89b.1742108339.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1882.git.1742108339.gitgitgadget@gmail.com>
References: <pull.1882.git.1742108339.gitgitgadget@gmail.com>
From: "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sun, 16 Mar 2025 06:58:57 +0000
Subject: [PATCH 3/5] t7615: be more explicit about diff algorithm used
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
Cc: Elijah Newren <newren@gmail.com>,
    Elijah Newren <newren@gmail.com>

From: Elijah Newren <newren@gmail.com>

t7615 is entirely about testing the differences about different
diff algorithms, but it doesn't specify any diff algorithm when it
is testing myers.  Given that we have discussed potentially switching
defaults (https://lore.kernel.org/git/xmqqed873vgn.fsf@gitster.g/), it
makes sense in tests that are about different diff algorithms to be
explicitly about which one is intended to be used in each test.  Add
that specificity.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 t/t7615-diff-algo-with-mergy-operations.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/t/t7615-diff-algo-with-mergy-operations.sh b/t/t7615-diff-algo-with-mergy-operations.sh
index 3b1aad0167a..ac5863e788c 100755
--- a/t/t7615-diff-algo-with-mergy-operations.sh
+++ b/t/t7615-diff-algo-with-mergy-operations.sh
@@ -26,7 +26,7 @@ GIT_TEST_MERGE_ALGORITHM=recursive
 
 test_expect_success 'merge c2 to c1 with recursive merge strategy fails with the current default myers diff algorithm' '
 	git reset --hard c1 &&
-	test_must_fail git merge -s recursive c2
+	test_must_fail git merge -s recursive -Xdiff-algorithm=myers c2
 '
 
 test_expect_success 'merge c2 to c1 with recursive merge strategy succeeds with -Xdiff-algorithm=histogram' '
@@ -42,7 +42,7 @@ test_expect_success 'merge c2 to c1 with recursive merge strategy succeeds with
 
 test_expect_success 'cherry-pick c2 to c1 with recursive merge strategy fails with the current default myers diff algorithm' '
 	git reset --hard c1 &&
-	test_must_fail git cherry-pick -s recursive c2
+	test_must_fail git cherry-pick -s recursive -Xdiff-algorithm=myers c2
 '
 
 test_expect_success 'cherry-pick c2 to c1 with recursive merge strategy succeeds with -Xdiff-algorithm=histogram' '
-- 
gitgitgadget

