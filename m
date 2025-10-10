Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D916C27FB25
	for <git@vger.kernel.org>; Fri, 10 Oct 2025 23:34:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760139242; cv=none; b=KADkvhOcuCdzTJ4W8UcZMilZDzDckBXDFD3E293D8IUjg8Uvsn9WsDvc0TisFwge9CiG1anYsEYxS6lqKJeUYcO5YbajLTShb+HgzTT0EBc/Vr+wLRH0KhUzAc96HBf3RHwZeQkNVHq61oRjKFYUir3Ppk/x76/+fXbM2zLwczw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760139242; c=relaxed/simple;
	bh=NBFwnZ6lKqlcWZPTz7PZVgf4TA1b+oG+eomBgktIEKE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=g8fCSUkmYjWLNV8R5BolVK+Gm4a4Xd7/i3yZRE4WYPS2EHa7iK2YTainPth9GFlmty8aT9E/cIDXz/7m8lJLTAKLJ2WyQcMSd1SnwHD+uZwa7pg7SuqWUNaLhT5lqrf/4E3uY51U0YOjzvCHjNjI3jNcv2UE0UKWDH4FfhQ01PU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YYpcBCAs; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YYpcBCAs"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-46e33b260b9so22671345e9.2
        for <git@vger.kernel.org>; Fri, 10 Oct 2025 16:34:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760139239; x=1760744039; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=a1xA83Yb3oeVEOm8svbxrIh8hDf826ozseOj/YaUSGc=;
        b=YYpcBCAsllM4G4QUtNFFFSp0dkz0kIcs6jNU0GRBEPt67UchLx5GcwbBgVU12tgq3a
         cnXpcIG2Pm1PYIKwDxUACZbck9W8vx0RxZfcYc4LUq3JquWw90H79wgxVEo/WFrSIc/e
         GdFcNzjutCbucUV/KquHhLqUnm5SHsv45xq0cmPBsvTcOr8zcB5spTCuu3n6muYq9bHd
         KdGATZ3jn3PjNkSz42KlRyOGAjRz+qrpV5IN/Qjr6seRFcTPGbeiM+Dsf1Jrs6ZKTH7b
         KbLdO6FiDbypqJl5snXclRNUBOdut4B10E7zDULdjE/zkbLRvirSBK3RLqeLOIalTI1g
         iyXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760139239; x=1760744039;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=a1xA83Yb3oeVEOm8svbxrIh8hDf826ozseOj/YaUSGc=;
        b=QuKBUI5SwOpj1GiHFp1yk1qKRk/lnu7QfExBmSG2Hd7EftaCrubf+vhEiG8Nfbdenq
         OazXi2Kyyp6BaiAo3hX2jrERTD3Doy3sCJ/B8RF1ImL6WwMW9LA56imQ14PwLvtS7Wqz
         n33ZeAUX8AIE2WSDHssZCxcHNYKDZoYXJmhxymuPBza8iLTgAhP0l8HWMikNP5AjacQI
         xbKufxRKXV84Ki9kxNL9wswe81a+Bj30lo6LfCeORBVaNuhr6Xgp91XzTiCwr8NM0Zw0
         3AwYIvTfRXTOCKBH6bzm0A8off+bgylJ//NKrUz1t3apwBovWrPNWbJWSi8FCcdnzgC6
         Svpw==
X-Gm-Message-State: AOJu0YyxXp4CqRmw7ozHmiAL6TJ4iSv6xEyM2d3vOArJKHkzwhrqTUQp
	1iO9/AAq0QbSLYuAy02zXAPQqfWEfWH1342uqdtCln2r8U1V5qxPd8NaD9faQEN1v67un9Ig
X-Gm-Gg: ASbGnctr5b9Awp3+e4o+7Tg1ZII9ooT6LT7EUjFX1++KDQlAHJZxK9mBKoFoeApQ7aQ
	zaf3oMwmNLYNpJegCJ1GIC0fpe3VG73NKAidhCIexly0ks/UMzujIymcnhwl2CBXhWZ5TSsj+iS
	MepfA6NrW+SpPekok6pa5qwHa/GVcAl3Y9C3nieGTcXOFMgWAJkOvo+gSya03F1uG2V+G+OaPnv
	3/BAvf3oohmG1BFOIxwrtKmYwRuwcnnZ1JFuaweFsZI8CQ4mnElXtsDULGCPWDbdNELJlwBRy/2
	E+48kipO5IEK3wgq5mdTxhUDlnAjdZO+NJSrlQMo1xV6vwWym2WY9QuJKAD04ClUJfgIibL3NZm
	1Gd6BCQofPfjKLb2w12xLKP3fiJQL/8Cb9WGyJ+Mp3oOqEIibr+K87DNUXVsc1j/89l150ZD+Pf
	a+XuGVkSEYKRNTY0SDsBQW
X-Google-Smtp-Source: AGHT+IG3xLvakLwv9EgjiYZsZ7EN7nCIHhBPwrKnGlHCtMnv6OZfyvuitagSgqZ2g8WBbaMrwbCWqQ==
X-Received: by 2002:a05:600d:41f3:b0:45b:7be1:be1f with SMTP id 5b1f17b1804b1-46fa9b092ddmr96438575e9.32.1760139238716;
        Fri, 10 Oct 2025 16:33:58 -0700 (PDT)
Received: from localhost.localdomain ([105.113.65.55])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-426ce5cfe74sm6079009f8f.35.2025.10.10.16.33.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Oct 2025 16:33:29 -0700 (PDT)
From: Okhuomon Ajayi <okhuomonajayi54@gmail.com>
To: git@vger.kernel.org
Cc: Okhuomon Ajayi <okhuomonajayi54@gmail.com>
Subject: [PATCH] [Outreachy] commit.c: remove leftover comment
Date: Sat, 11 Oct 2025 00:33:03 +0100
Message-ID: <20251010233303.783212-1-okhuomonajayi54@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Signed-off-by: Okhuomon Ajayi <okhuomonajayi54@gmail.com>
---
 commit.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/commit.c b/commit.c
index 16d91b2bfc..af20ca7c3d 100644
--- a/commit.c
+++ b/commit.c
@@ -475,10 +475,9 @@ int parse_commit_buffer(struct repository *r, struct commit *item, const void *b
 	if (item->object.parsed)
 		return 0;
 	/*
-	 * Presumably this is leftover from an earlier failed parse;
-	 * clear it out in preparation for us re-parsing (we'll hit the
-	 * same error, but that's good, since it lets our caller know
-	 * the result cannot be trusted.
+	 * Reset the parent list before re-parsing to ensure a clear
+	 * commit state. This avoids carrying over data from a previous
+	 * incomplete or invalid parse.
 	 */
 	free_commit_list(item->parents);
 	item->parents = NULL;
-- 
2.43.0

