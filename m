Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 853DD2EB5BB
	for <git@vger.kernel.org>; Tue, 15 Jul 2025 13:53:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752587597; cv=none; b=cvZorTgJvCRb6l5mBY2b6kgrkUWrxXDT7t8fLLZ+T0n0D/vUzOXPFmOmZ/QwQDKByqpp1k0/k4yfRP54XIyNlrqBcbbBmuNVh13fQCv0a2aph5njKuvpp+kCMkJ7Rd7nMnJnvL8/6cW4gkfUOhnoq08+lHTKWn0lmRQts3jGD1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752587597; c=relaxed/simple;
	bh=gPmqIGUo4U4wyOXYaMkwsg5oKq9UaAtOnKmCxXnHIg8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HZCARgeiunT2I105dZRV9c4foJKobThoRulUjKvWvUyOlVzVDFHF8hrvHlYMSavDM7ZmNVWREYbjXmyoG623VYXOLt8kUqgDzd7Vpjlfj8lte82L0sgMCol0ZEctEWszpnMzs3ygTFpcc4nXNf98fPt9t2zYLbwQ/TdM8kXS4o8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QqYGsNUD; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QqYGsNUD"
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-3a51481a598so2798459f8f.3
        for <git@vger.kernel.org>; Tue, 15 Jul 2025 06:53:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752587594; x=1753192394; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=KhEQ4V8uoDws6tCkxlbwcINhCePrVBQISiUlPc3ULFI=;
        b=QqYGsNUDxAgRNsI7b46meE4cs7OJaAlXFoCbd15XXt5AJB4M3wzS9bMQND/RwXxKWg
         eG1g7+UzE5j+6AkxbtqOO2Jeu1dWyJp6pMS4KvFJnC2qkm8wSxn9ZWcqxmbI0jDU2yC/
         K0Q0rV9g/wGTYuU6tl4rxz3pDk5SCEwz25ogDna6IJbsY82lOATkinwIafqoV2AcqPvU
         EoM9TwMKXLcGv2RSAoSD0D3jSoMBo//tQnQH5EQD4AuXhXYolEe0LPJVzCMT7hL9889W
         dIA6kPs6Ok9gRaCWNnUN6J1IcZHWOw8sVfjboanmkb46Ra2Drv02+kOC58Ds3fTiMlqK
         EjuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752587594; x=1753192394;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KhEQ4V8uoDws6tCkxlbwcINhCePrVBQISiUlPc3ULFI=;
        b=Ktr2qpk7WNSWAscXIDf5oAmX/U1NS+/tbk0NpSQJ64aUuRwz8CFIiII/euK9N8EZ7W
         c5Iak/WnXDoau9eVDEq1HVq6no7IfUl2O7Kruak9kfPe7Z0QHYsGbMw02vAgUbxk3kYL
         Ar8CDs5jiGi9LY9RDwd2XhqxMs9HuBvBW9Jy65bpv4y3ke5PEC9jBxv5mins6YgbGNLE
         OW1twPmp31Ofd98gQP3niV0I/Mb4yahRgxmaIj/M77PBnD++bQd86GKYZZzQBh2dF07i
         QnQJlvQ65lKU27JGu7RG67ImobY6LKov/s1PIWANeM3r0DAe4T4dNROYUHY40DwlZaBW
         M0lQ==
X-Gm-Message-State: AOJu0Yx1S3eOUwf5GlTBpxo05hsIKdcM1GwTYqeS4Upnx4CyZCc2EGVb
	EXLJf4flW6/LGazeK7obBHA3bMI6Ga0JCG+0nFBA9L9h3Ns2AbYAGtgzPmuyVg==
X-Gm-Gg: ASbGncsjr554Tf+E3tB3GzRHj0Q8N8UNMvhOnC5c/C5tvL6qV0Kd355R9/BbICgUi5I
	ZlCe5KdmMrj5+DNf+SR70Kyb90B4de8uteBwyNprNNMXKBhSFcSA9e6a1AROti8mM21lyMKMc/u
	dJhjXMfji/1GzE3kxYnsg2zpAAXbHpHxu3OitTJtxIowJJORACm+mIEhW7YGkCnLUuWM3I2NOGd
	nLviN92RcydvRizmtQtf741I9KFHCDmsFL4Bfa1rghUZXNsVTtWrRoPSENeNm9iONfwApOjOP4F
	i5RUQWNMMsSTiXZhzEayFkwm4GIJ9R8Z2b7YVXRYPF6SIHYTHafeTIlRTkS6Az2fbgOJP5lFE2d
	f3NSti3OuQpdlVhW+0u2yZAEpA+W6YhGHlD9fBUJ93TVk
X-Google-Smtp-Source: AGHT+IGrBu/nstPhXZc1kk3fQb4mMVxmJFuQCQ0Q77jK6VfGhwnYfHnqJpopzlKczyXlAvr+TP7pDw==
X-Received: by 2002:a05:6000:2207:b0:3a5:8a68:b81b with SMTP id ffacd0b85a97d-3b5f2e26cc0mr12015632f8f.44.1752587593689;
        Tue, 15 Jul 2025 06:53:13 -0700 (PDT)
Received: from localhost.localdomain ([2a0a:ef40:7a5:4701:8cee:45ed:2bd5:e17c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b5e8dc3a54sm15421112f8f.39.2025.07.15.06.53.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Jul 2025 06:53:13 -0700 (PDT)
From: Phillip Wood <phillip.wood123@gmail.com>
To: git@vger.kernel.org
Cc: =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
	"Brian M . Carlson" <sandals@crustytoothpaste.net>,
	Elijah Newren <newren@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Phillip Wood <phillip.wood123@gmail.com>
Subject: [PATCH v2 2/3] git-compat-util: convert string predicates to return bool
Date: Tue, 15 Jul 2025 14:52:51 +0100
Message-ID: <0b2402e11cc8a6b096139f796ea280d0ba56b418.1752587571.git.phillip.wood@dunelm.org.uk>
X-Mailer: git-send-email 2.49.0.897.gfad3eb7d210
In-Reply-To: <cover.1752587571.git.phillip.wood@dunelm.org.uk>
References: <cover.1752499610.git.phillip.wood@dunelm.org.uk> <cover.1752587571.git.phillip.wood@dunelm.org.uk>
Reply-To: Phillip Wood <phillip.wood@dunelm.org.uk>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Phillip Wood <phillip.wood@dunelm.org.uk>

Since 8277dbe987 (git-compat-util: convert skip_{prefix,suffix}{,_mem}
to bool, 2023-12-16) a number of our string predicates have been
returning bool instead of int. Now that we've declared that experiment
a success, let's convert the return type of the case-independent
skip_iprefix() and skip_iprefix_mem() functions to match the return
type of their case-dependent equivalents. Returning bool instead of
int makes it clear that these functions are predicates.

Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
 git-compat-util.h | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/git-compat-util.h b/git-compat-util.h
index 5bd69ec0403..9408f463e31 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -897,35 +897,35 @@ static inline size_t xsize_t(off_t len)
  * is done via tolower(), so it is strictly ASCII (no multi-byte characters or
  * locale-specific conversions).
  */
-static inline int skip_iprefix(const char *str, const char *prefix,
+static inline bool skip_iprefix(const char *str, const char *prefix,
 			       const char **out)
 {
 	do {
 		if (!*prefix) {
 			*out = str;
-			return 1;
+			return true;
 		}
 	} while (tolower(*str++) == tolower(*prefix++));
-	return 0;
+	return false;
 }
 
 /*
  * Like skip_prefix_mem, but compare case-insensitively. Note that the
  * comparison is done via tolower(), so it is strictly ASCII (no multi-byte
  * characters or locale-specific conversions).
  */
-static inline int skip_iprefix_mem(const char *buf, size_t len,
+static inline bool skip_iprefix_mem(const char *buf, size_t len,
 				   const char *prefix,
 				   const char **out, size_t *outlen)
 {
 	do {
 		if (!*prefix) {
 			*out = buf;
 			*outlen = len;
-			return 1;
+			return true;
 		}
 	} while (len-- > 0 && tolower(*buf++) == tolower(*prefix++));
-	return 0;
+	return false;
 }
 
 static inline int strtoul_ui(char const *s, int base, unsigned int *result)
-- 
2.49.0.897.gfad3eb7d210

