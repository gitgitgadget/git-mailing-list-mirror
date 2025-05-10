Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 689601EB1AF
	for <git@vger.kernel.org>; Sat, 10 May 2025 13:46:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746884798; cv=none; b=AoKhUmJxpqf4QpqpAMaq/hrOoodtqGXmclqUmTeKV/vLifdlEpzFqjoaZomfHe2CAn6Z5Z4Q1u3OFf1nmfPUbVF5A8+vJ7neikfSiFixrGDBQ41hq21g5EMMfb7CyGBujts2SzgmWb9MBVfmgZ4Sb5dCal9LTJs1KuyJZwyu9lI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746884798; c=relaxed/simple;
	bh=lA1oDHN5fQkIQl/PFb0RSRBLONdccirloQQrifk09vM=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=dlkWkUIgi990OHZpbc7YQ/RB/r7Xh37eB5d6gntGEQhWpC7k/xSp+X9BZ+PlR+dJ67FrDVYr5BUivi0W/+NFx+WKC5dTDnFtQqOuFaQxLERQr2AqQGmtM44gIGfuRLWpXeYpSu1brGE6KWhN9zYYNOUvNK88u1tFp0URb/JFhKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ecl8lV/t; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ecl8lV/t"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-43cf848528aso24982615e9.2
        for <git@vger.kernel.org>; Sat, 10 May 2025 06:46:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746884794; x=1747489594; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ScfJAKUZiJRm2fuyLS6SHpMPEPh5xeAziim9oCMULcM=;
        b=ecl8lV/tY/JrXyvUWxHYKaB/kmS0YiT8UDtbCWYRkqgg0XR3Odm4jZ83HMlnscpsvU
         1YRx/K+3yyeAVg17bcZuy4QvBQBmRnRIWuj2CmGGWrfsK19QBxfZMP8hjLR+KkpG6EKx
         K8ihWHjeqQBjzjTrlLaQAtywLeOSuVARr/9f5znABpYr2FxcEVeSml/AB4BeLTecBG8o
         geE4TwCOl7WBi9kpEjDGR51eBjGCEK1ljbfHcySx6BAHzNhStpLQKakeK0me61UNNm28
         V2JDiet2dR85fRn/eU64D/kLbC2Rj73L0B04gJMuEFqUrz/7X7r6qaVDjNvKqTwnaL0Z
         /vWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746884794; x=1747489594;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ScfJAKUZiJRm2fuyLS6SHpMPEPh5xeAziim9oCMULcM=;
        b=Mc/eeAuy+E4MqXY14YtOdDroBDbpW+dLMLIYyAgfLujHZil57c8C/SfYJTnAyc4GpV
         fTDCxs/Vt1fCrB5+aYecrU8Ob1bgsUkvuB+tHuNJjIblSmoOc5IYBxvi2LKAS5akL0a+
         ORg+3p1lYEw25XORt/S1YxV8lnkrsaRq4StFCnYfbpIb21DHtFzZTf7e8HLEhfEAJzSB
         L0JuFhdixVRmFLqew0PW7SDUXiDMK9Td/bWbupKJQvJ7+Hl6czertWGX4KI7qAcP7+nd
         UbwjtHz7iZ0BXGCHR74F6JTG+PFg0ECnuQjICLesrucED8XjV25cgnMMSiVZDgrF2ebc
         qqqg==
X-Gm-Message-State: AOJu0Yzl770vfwsF8767HDTGOYyt83jqHP0Jm9yaGMPykbyd8pG/yYNi
	y6WivT1kUVbBZqayiv6KMyJzPLKdQZ91+gaovK+Nww8PpFw5eObEldunKw==
X-Gm-Gg: ASbGnctDhkmjNsyMpg/HwIQBZKUC2AhCSrJlOmM9f6NttFjWbru0PXJ9sv6iY7wlNoG
	XCYU5PQoahzRKaQwcwDkHB70bJtwmRuOE0KiXDXuv0rGltycVoe/cvZS2KMob1Tn1tP/3rhZopE
	6Tb3huzKfWPWDv9NedLdjb5ugNig1ZOMsSUGCkUiOJpeQCdxhwYRB8QFtoosuHQnI+yAdbD4RzF
	hknJb1FW53yy/0SYw1WhS7LPnkF6QU+ilZCUZhwfmcp1hPa5jL96Fa+LuFaux67siiNFrl4+xUJ
	MpnEKnbu7T/3UJub60TBLW4iePkD5aj/BiVbLXJeTDANWpFJbXWI
X-Google-Smtp-Source: AGHT+IEq66ug44YgckD8C/WcAX31zJIwRqEdOw5AsPGqsz6gM9ndpWa3lTK2XFzA2X3wvh86J9ccEw==
X-Received: by 2002:a05:600c:1e1c:b0:442:cd13:f15d with SMTP id 5b1f17b1804b1-442d6de50b0mr63463715e9.29.1746884793796;
        Sat, 10 May 2025 06:46:33 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-442d6bf96bfsm62507115e9.6.2025.05.10.06.46.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 May 2025 06:46:32 -0700 (PDT)
Message-Id: <75424cb8e1ccae4f2ce8c4f796b8217552895d09.1746884789.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1915.v2.git.1746884789.gitgitgadget@gmail.com>
References: <pull.1915.git.1746436719.gitgitgadget@gmail.com>
	<pull.1915.v2.git.1746884789.gitgitgadget@gmail.com>
From: "Leon Michalak via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sat, 10 May 2025 13:46:27 +0000
Subject: [PATCH v2 2/4] test: refactor to use "test_config"
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
Cc: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
    Eric Sunshine <sunshine@sunshineco.com>,
    Christian Couder <christian.couder@gmail.com>,
    Phillip Wood <phillip.wood123@gmail.com>,
    Leon Michalak <leonmichalak6@gmail.com>,
    Leon Michalak <leonmichalak6@gmail.com>

From: Leon Michalak <leonmichalak6@gmail.com>

Refactor to use the modern "test_config" test utility instead of manual
"git config" as the former provides clean up on test completion.

This is a prerequisite to the commits that follow which add to this test
file.

Signed-off-by: Leon Michalak <leonmichalak6@gmail.com>
---
 t/t4055-diff-context.sh | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/t/t4055-diff-context.sh b/t/t4055-diff-context.sh
index c66f966a3ab3..1384a8195705 100755
--- a/t/t4055-diff-context.sh
+++ b/t/t4055-diff-context.sh
@@ -47,43 +47,43 @@ test_expect_success 'the default number of context lines is 3' '
 test_expect_success 'diff.context honored by "log"' '
 	git log -1 -p >output &&
 	test_grep ! firstline output &&
-	git config diff.context 8 &&
+	test_config diff.context 8 &&
 	git log -1 -p >output &&
 	test_grep "^ firstline" output
 '
 
 test_expect_success 'The -U option overrides diff.context' '
-	git config diff.context 8 &&
+	test_config diff.context 8 &&
 	git log -U4 -1 >output &&
 	test_grep ! "^ firstline" output
 '
 
 test_expect_success 'diff.context honored by "diff"' '
-	git config diff.context 8 &&
+	test_config diff.context 8 &&
 	git diff >output &&
 	test_grep "^ firstline" output
 '
 
 test_expect_success 'plumbing not affected' '
-	git config diff.context 8 &&
+	test_config diff.context 8 &&
 	git diff-files -p >output &&
 	test_grep ! "^ firstline" output
 '
 
 test_expect_success 'non-integer config parsing' '
-	git config diff.context no &&
+	test_config diff.context no &&
 	test_must_fail git diff 2>output &&
 	test_grep "bad numeric config value" output
 '
 
 test_expect_success 'negative integer config parsing' '
-	git config diff.context -1 &&
+	test_config diff.context -1 &&
 	test_must_fail git diff 2>output &&
 	test_grep "bad config variable" output
 '
 
 test_expect_success '-U0 is valid, so is diff.context=0' '
-	git config diff.context 0 &&
+	test_config diff.context 0 &&
 	git diff >output &&
 	test_grep "^-ADDED" output &&
 	test_grep "^+MODIFIED" output
-- 
gitgitgadget

