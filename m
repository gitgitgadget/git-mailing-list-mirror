Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DB7328D85D
	for <git@vger.kernel.org>; Thu, 19 Jun 2025 22:58:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750373895; cv=none; b=qV4WPeX5dvpXAPl/4icO6aRYYc/cBm5K2U8ky5xAlnGgAEboiQ4D2dtn195vyHSW7BUgjtgpoC1WUv9JyJ9C+RbY+o8XJ0rWLbwWm0wBB5vnY3hfJ+abHLR2K24KrjQkZ+6mk6JIVfcwuDw8+xTlVr4mi5IR9I8AtLQW2dtnO0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750373895; c=relaxed/simple;
	bh=1/L4hj0l4pmaC8QkIy1rqCZMQQlJjisS9BJV4D5JYw8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kD0+ps4PezSHVbRMdKyqsfF6SVYuCQY8NP1pVfV++Am56QuHH1VLMcqZwi65OL6KN0bdUok9lYQh/yGWt3X/sSvmxN0nl9XgnW9FLtV3uHu5N7qYifTM7KyU/1KK4q1Df6ox+GkMvZTTboFz5gYZW0BQjBJ/K6RlJFeravaHU04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c7ng5IJT; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c7ng5IJT"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2363497cc4dso9676085ad.1
        for <git@vger.kernel.org>; Thu, 19 Jun 2025 15:58:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750373893; x=1750978693; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=88XX7WF6VSzi8HUpwuEtVpL+8BKwxIr6g2j9JZlYkBg=;
        b=c7ng5IJTZSsy9Ysmu061MP+oSWMhV4pbP8FohUkpAcsAacGmNSpCbkeFCN+pnQnTRL
         94SH3wPB1Fm9zAIMDmINdPMtHX8lNAx4he6Cr3RMI3rFzvsPXL5r5iaPPOqtKVSNkaBo
         iO2djSvcB7Ue6eoSvvM+8cTug7ZfHEy+XjyMIU6RY8YCoyINj3XO0PrN6PlyQ5kRy8EJ
         yOtdHuKqZUp0Ys+gTd+IvrcEEtuXqcBh9d6IPiYiT5Ol0ApdahHMoWFZ/rcDVXcByocV
         Rm9ViFCyMAdQ7D2q7OE8npU8f4mjft0+vcE0ruCr/kBYY1bjMaw2L5ZV/qvjWzHjWZDu
         c/KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750373893; x=1750978693;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=88XX7WF6VSzi8HUpwuEtVpL+8BKwxIr6g2j9JZlYkBg=;
        b=B9wdx0AqSOktsYS99mFYxLmZ7s7XsKIpMlVp+oX0Xe7Em2PQav+csVoJK+zTM4nJ6Z
         UW6EEKYHAAyPUtFYyve6MVrg3BhC95OxwRJ+Eu4LUjWs9pSx+Dv8hg+wXDCBKjIGC+zh
         QnxynvVkXb3/g1FCXdjNdZdrrs0anz5B7r8VFMYjZpAsx4AEU8DguYz7u15z9mVgsNQG
         4fTm5LDbVa1cN52mYOwEabKMtMCnC4O2+KYBAYVRMDsMrCAI/v32ExWf4CLTo7yXtbfz
         6J0F9+bf1Ndn9GAldl15Ddbuq6NvU7EnWwegYvvq+x5iYm9ZuksrrUAdCm6BdXE4EK4K
         AoLQ==
X-Gm-Message-State: AOJu0YwTvGJksmpOr9fqprYxhB3QP3Ye+1VvA9FCrT4wy47NqUqTU//+
	3LN8Avft6xkIKN+VrTOF4eV1g0us5f71YxWs4pC6uFrM6elxYhUY4MxjLNsQ2g==
X-Gm-Gg: ASbGncv3AYKOeOejHj5KXT5aQjlTtMsFwjwWCSynpRMTg+bsy5hLP7OlfUpwx4RTow9
	P3DZmpdjVDu9TRCWXqlpSzrnmV5MNi8dqHKLN8q8NygN17vRQ0TucYfNrTgjgj5ZH24S3zTjvYQ
	3zWAbnmif8sAgp/uCn1dN3zPKuDaLtzXmSlAoEYKwZwIXkkYQ/DrFcp1Hfd7TwBst1jlqiJaqIm
	DVhvOjNZONxrjkvfEmfViqa7gZt+q559guSlL1uVuH+mtcovk8gz8GHEcWqDxn9O7aa0W1xZU6g
	vSp/buP6CbgbyTQiJgZrUO0xLmZQ4+6mKNDoC6tMIMAe9iTBVRbxXEBKwENfhYz/x3gf/QQAR9p
	6lCgvsMMGpbbbH44Lzvn8O5eNh+VH
X-Google-Smtp-Source: AGHT+IEachQrbTsQEznpSOhFv4ATjsCZomWCTGDwUgcHE9OoS5FQordJB7TGPISp6rRhTb8bSGCIOw==
X-Received: by 2002:a17:903:440f:b0:224:1af1:87f4 with SMTP id d9443c01a7336-237d98ae681mr7001225ad.22.1750373892925;
        Thu, 19 Jun 2025 15:58:12 -0700 (PDT)
Received: from localhost.localdomain ([179.100.18.48])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-237d8695440sm3470515ad.185.2025.06.19.15.58.10
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 19 Jun 2025 15:58:12 -0700 (PDT)
From: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im,
	karthik.188@gmail.com,
	ben.knoble@gmail.com,
	gitster@pobox.com,
	Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
Subject: [GSoC RFC PATCH v2 4/7] repo-info: add the --allow-empty flag
Date: Thu, 19 Jun 2025 19:57:48 -0300
Message-Id: <20250619225751.99699-5-lucasseikioshiro@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250619225751.99699-1-lucasseikioshiro@gmail.com>
References: <20250610152117.14826-1-lucasseikioshiro@gmail.com>
 <20250619225751.99699-1-lucasseikioshiro@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a flag --allow-empty, which will force the output data to be empty
when no field is requested.

Mentored-by: Karthik Nayak <karthik.188@gmail.com>
Mentored-by Patrick Steinhardt <ps@pks.im>
Signed-off-by: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
---
 builtin/repo-info.c  | 3 +++
 t/t1900-repo-info.sh | 5 +++--
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/builtin/repo-info.c b/builtin/repo-info.c
index cd7c110f47..6499be0eae 100644
--- a/builtin/repo-info.c
+++ b/builtin/repo-info.c
@@ -68,9 +68,12 @@ int cmd_repo_info(int argc,
 	};
 	struct repo_info repo_info;
 	char *format = NULL;
+	int allow_empty = 0;
 	struct option options[] = {
 		OPT_STRING(0, "format", &format, N_("format"),
 			   N_("output format")),
+		OPT_BOOL(0, "allow-empty", &allow_empty,
+			 "when set, it will use an empty set of fields if no field is requested"),
 		OPT_END()
 	};
 
diff --git a/t/t1900-repo-info.sh b/t/t1900-repo-info.sh
index 998c835795..db4a6aad17 100755
--- a/t/t1900-repo-info.sh
+++ b/t/t1900-repo-info.sh
@@ -15,11 +15,12 @@ test_lazy_prereq PERLJSON '
 '
 
 test_expect_success PERLJSON 'json: returns empty output with allow-empty' '
-	git repo-info --format=json >output &&
+	git repo-info --allow-empty --format=json >output &&
 	test_line_count = 2 output
 '
+
 test_expect_success 'plaintext: returns empty output with allow-empty' '
-	git repo-info --format=plaintext >output &&
+	git repo-info --allow-empty --format=plaintext >output &&
 	test_line_count = 0 output
 '
 
-- 
2.39.5 (Apple Git-154)

