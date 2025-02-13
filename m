Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB40B20D51E
	for <git@vger.kernel.org>; Thu, 13 Feb 2025 09:00:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739437252; cv=none; b=Li1xa3N4rAwlWYP49wwP4FaTqg1c29lwPesn8jVGfnoQfHFJ6Kbiz8vDP/+oZnoub9DxQYReayJBVTD6ggCGZ78sHBAJkA9KI9KGo4zo6fyC+uMSkb5klVbFKFuTWBPG72uY2ddM1rrAl7teos6ILOxv5DMcxezw10iaEycPD1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739437252; c=relaxed/simple;
	bh=Co2P0BDK5XqSiXUbliU1EtQ8ooIGK2U6WJsRshJIUi4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=k2iPv2r8D6bdErjC9CPVLTPcq3uMsM+5azXzjG6s32x4a79V+IARTRNmHNVLJBjXlHZNjmwauCg1HdVvmMHn/Klfv0Yjb0sQcuw5SqrS+J4AGTq6RSyp4tj1gg/uHoYzF+gTc7SSzD2C4mOGtaXkZuq6ruQno+bIMFyzSW+jH5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aeaJ8TEw; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aeaJ8TEw"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-220c8f38febso10468785ad.2
        for <git@vger.kernel.org>; Thu, 13 Feb 2025 01:00:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739437250; x=1740042050; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DVsNbItVyPBub7bKeEmUrgoLe6Kq4gCzG3+uW0+WelQ=;
        b=aeaJ8TEwVY9TaVZTyxOM5H1Co6sz31ttftNXZrijb7WubcqD6HuYQGisro3H9jRaB4
         Nvn2abkiEGpRTTnkflawDqAdNtwDIiVuUtrHywfPo5bpJZPn9dIL3Wev1h33X89dPe6q
         /RSdUgjT+qlJ9H+SSN/emZ3UP0CAdQGWgH/yxtHgNjJ8sX+4Zd/y3vxp9+1AeOnxABhz
         SGcC0Ad452QsEG4Rnk9BE0yl7O9wmUhBUgagoiaPNoIE8sDikLeL1ZKS1l0X7cRBSmtE
         pPeZUDBxON4j/Wd+Oq/xdlflb4LrscU7yT09f1kT33w5S21NPlPY9bC5W+jjq2qODPCW
         0P1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739437250; x=1740042050;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DVsNbItVyPBub7bKeEmUrgoLe6Kq4gCzG3+uW0+WelQ=;
        b=BnY0LBhJ4tbQAMUDI8hv5xFyG9N71wm3Ko+OdJEVDB6vC0c9cvGEI+e6BAg+DRq32S
         ce/yzbfMcItw8azZE7g7hNzLJh6dOq6INmsksu2QWYIS4cp8wajWZ8q94A/70ZmUVpuY
         +om6guz5HZax3nH9mnqpAuZZu9MC8SgiLlNePChManhLSxmC7eZZ3bm53mK8t5f5xwJN
         tyc3NsHbIn63Ibg20l4uxEvZpaKjmqPuPhFdPREdj5RhYmAGQ3ZzutV9XpzA7WwkkIz+
         p4RGBXZ94E7e9XKoJgX1eWfJQPVQvEGQW6B5eGMlX6ZwUDimpyY/GdWOLcgM5TXcjVHi
         RCCw==
X-Gm-Message-State: AOJu0YzomCnfnEBrWtEBhkc4k1DDHnNTYRJsV14pZ5ibX4xb9TGCuhSf
	nhUY52d26Z+Vsr2wuQ3N+QKRRM/XkK3XYvvmTtU5PGmxmHk0jWKh6GHzCQ==
X-Gm-Gg: ASbGncup6AaBa2niGLRbTj6R5uTgkLVyr08vboKy1toz77MHpwtyhcs9LtY7q8LO43n
	DJk8mKm9zeF5t4py2aiwc3x8Fgm/H/R81aYB0eE1tHsL5M7clndxtNhotcnNX77v6VHbAR5vg06
	9WDvcyOBAuVIaWwYxiZM530awDXtRhVwH3+OoBWo4IYo12tL8xRu5KinBEnGesdUpN+p930QyPH
	7M2X8HQS006kV7Qo0JxaEn+3z87eSS+YgiOmft/8Mid7S6xdt2fSLdJ3v3OwklsfTFmHSUnbvau
	u3fLNZ6baljkdw==
X-Google-Smtp-Source: AGHT+IGzJshAdOcnRKLYYFT6tAbGLUPDPxEuaHMeEgb7VI5oMfFp6ZUkW7/Tfgs/sVCWx5f1Hd2S8g==
X-Received: by 2002:a17:903:1cc:b0:21f:658b:8ee8 with SMTP id d9443c01a7336-220bdedc600mr98304395ad.2.1739437249640;
        Thu, 13 Feb 2025 01:00:49 -0800 (PST)
Received: from meet.. ([103.240.170.242])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-220d536733fsm8086265ad.77.2025.02.13.01.00.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Feb 2025 01:00:49 -0800 (PST)
From: Meet Soni <meetsoni3017@gmail.com>
To: git@vger.kernel.org
Cc: Meet Soni <meetsoni3017@gmail.com>,
	Elijah Newren <newren@gmail.com>,
	Derrick Stolee <stolee@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: [RFC PATCH 1/2] merge-recursive: optimize time complexity for process_renames
Date: Thu, 13 Feb 2025 14:30:39 +0530
Message-Id: <20250213090040.16133-2-meetsoni3017@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250213090040.16133-1-meetsoni3017@gmail.com>
References: <20250211194334.20710-1-meetsoni3017@gmail.com>
 <20250213090040.16133-1-meetsoni3017@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Avoid O(n^2) complexity in `process_renames()` when building a sorted
`string_list` by constructing it unsorted and sorting it afterward,
reducing the complexity to O(n log n).

Signed-off-by: Meet Soni <meetsoni3017@gmail.com>
---
 merge-recursive.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/merge-recursive.c b/merge-recursive.c
index 5dfaf32b2c..884ccf99a5 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -2758,23 +2758,22 @@ static int process_renames(struct merge_options *opt,
 	const struct rename *sre;
 
 	/*
-	 * FIXME: As string-list.h notes, it's O(n^2) to build a sorted
-	 * string_list one-by-one, but O(n log n) to build it unsorted and
-	 * then sort it.  Note that as we build the list, we do not need to
-	 * check if the existing destination path is already in the list,
-	 * because the structure of diffcore_rename guarantees we won't
-	 * have duplicates.
+	 * Note that as we build the list, we do not need to check if the
+	 * existing destination path is already in the list, because the
+	 * structure of diffcore_rename guarantees we won't have duplicates.
 	 */
 	for (i = 0; i < a_renames->nr; i++) {
 		sre = a_renames->items[i].util;
-		string_list_insert(&a_by_dst, sre->pair->two->path)->util
+		string_list_append(&a_by_dst, sre->pair->two->path)->util
 			= (void *)sre;
 	}
 	for (i = 0; i < b_renames->nr; i++) {
 		sre = b_renames->items[i].util;
-		string_list_insert(&b_by_dst, sre->pair->two->path)->util
+		string_list_append(&b_by_dst, sre->pair->two->path)->util
 			= (void *)sre;
 	}
+	string_list_sort(&a_by_dst);
+	string_list_sort(&b_by_dst);
 
 	for (i = 0, j = 0; i < a_renames->nr || j < b_renames->nr;) {
 		struct string_list *renames1, *renames2Dst;
-- 
2.34.1

