Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5545C242D66
	for <git@vger.kernel.org>; Mon, 30 Jun 2025 08:38:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751272722; cv=none; b=oCpcHdpm7fh8I+XiIvvtHYHUQ98DKgXEVevhxfxbQd2uDfpLrJJTuVn/raAithHMVbrASe4bKb8ueAXPhgmiF9glVlyFeS5pAZTMn1eHWr5qkkqgJN/K9cyWbySdMdqZAwjbtVdWi4gT9/xV7sUabaSSvCFPr99Cz2h5//R1Yzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751272722; c=relaxed/simple;
	bh=BeO9WFmMRqhhu/s9N8eXSCUL1EOqkPDqzJwrJeWZ0/M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=F78DMpraidtplXkn4qURKbeoRTXeAVmLu7JLajt0YR3XFKsJ6hnJENqL1HVbKS5+qFdzd+6BudWyabtQCA3dQv0ZNJHQpeTu90vs/aD6CBQCfMjCnqjtbSOFU0ta8mWJwQUNF1wk5ZZNJYmK60ye1Y78prF9oU6ufD+Z7DYRs2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EeMSoPSm; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EeMSoPSm"
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-60c9d8a16e5so4103297a12.0
        for <git@vger.kernel.org>; Mon, 30 Jun 2025 01:38:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751272717; x=1751877517; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=K1V22kMtCJCpgUiSd4K7Tfo81CPOoYvdSFZsdAfJT9o=;
        b=EeMSoPSmeaW7SxhUMqBIIG4X8anUS1YFrsHLx76LP1BdY5YGeR1dtUbnyTYY5SWYAY
         Cqrg9PjAqUT8Blv0iZS7rBj7iY3IsGmZSKpgS5KKi8iMyd6qrVtZKan18TBEgIMU/FiO
         VwwoZODEfPAxHnecTT6xWhE7erVIKIPEMbePNfXBV8YTgj1j6kPvjTWUvdbhfp2iZOci
         mcBVVjNacpjfuqPGVB3elqCJz+oHAWquP0X3TKe5vbsh6HsHkIRlzEWvOOjYoQy6zU25
         MqWijI6VbUgnRuUOVeuG8wUR2gkDfWCFoJMcyhyhypYndMfJc6VoaIPZG6pIdLuZU5UP
         PPIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751272717; x=1751877517;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=K1V22kMtCJCpgUiSd4K7Tfo81CPOoYvdSFZsdAfJT9o=;
        b=mmAR/PE/06yvK91vKeOtWzAVncy54ddZusaCdLex6PXSi7KtzD6J+F4nnvPhspI3Ou
         dW6/3A0BRbLgTqKOiR/gs5rZn2LO/L3tL3bmdOTovCvApZVS8pfEDHT3na3r9Po/TYva
         hOsLhhdXBb922kpyWe/ofowv6CrHeFJNh7W/pXrUS9AFAGauV3ZJie6m7jzHNxiYl6fX
         7at9WbOTrqsa9p36BjMDTryUGObj5hrK9JWC+FL87nL67FqXaLZIwxa1lqz9Z18SdzmG
         sN22hLK8zana7nkk2L5qDyVwjQJM6OyQS4TqoQVUVt+cmAdht2jfXP1UhEyj6woMpSmY
         3PbQ==
X-Gm-Message-State: AOJu0YwxqWujmD4lHIHNw4cGu2EKdw2R663YiE6c0kz3n1rl1ERC82dO
	W/YZCsQXzw63SlAWjAiviEUJjK54X3BzxkM0wAhAnwgjEun18njJMbHFStGlyGmO
X-Gm-Gg: ASbGncu8kbt+hNTfF+gLF6NKkb2lfR/Pb+2XGcFKyIxaplDBFJTD1mQzxMGL7P283IT
	krFdo5s4QMCnNLWS9CcTiyVP0fZA/XCUPyF681nNlU4Bv2qkoD++cT8gEFQmWVqW4d9XlQNDqDY
	jerN+rwBtAOF7194e5DCRKg1JwBl7tPLU5J7ycOQgMVCbpc4BAQw6DG1V0oZUNQbljdxxfjxR/8
	6OJVabuAtx8t3PxXqhh6DectE8fbMUCF+MTV2eXmRDJIESUu5aZROO++pq3RYaKA9Bgdo35HwQH
	vAfZMdpBoc6R8qwP1T8moIW9DTBNSiFjkrVrVTHnMWfh/A==
X-Google-Smtp-Source: AGHT+IELzX4r6mbBuw08re4iyi+eeUA+XPsXIjaIuP4CXw3Idz27OVxx0kPOegUdOt1fckikDCkYmQ==
X-Received: by 2002:a05:6402:350d:b0:607:5af9:19b6 with SMTP id 4fb4d7f45d1cf-60c88b3ea4fmr10591727a12.15.1751272717295;
        Mon, 30 Jun 2025 01:38:37 -0700 (PDT)
Received: from [127.0.0.2] ([2a02:2455:8268:bc00:cab2:9615:a476:665f])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-60ca83610a1sm3413749a12.12.2025.06.30.01.38.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Jun 2025 01:38:36 -0700 (PDT)
From: Karthik Nayak <karthik.188@gmail.com>
Date: Mon, 30 Jun 2025 10:38:21 +0200
Subject: [PATCH v2 2/3] clang-format: add 'RemoveBracesLLVM' to the main
 config
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250630-525-make-clang-format-more-robust-v2-2-05cbcdbf7817@gmail.com>
References: <20250630-525-make-clang-format-more-robust-v2-0-05cbcdbf7817@gmail.com>
In-Reply-To: <20250630-525-make-clang-format-more-robust-v2-0-05cbcdbf7817@gmail.com>
To: git@vger.kernel.org
Cc: chriscool@tuxfamily.org, jltobler@gmail.com, gitster@pobox.com, 
 Karthik Nayak <karthik.188@gmail.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=2246; i=karthik.188@gmail.com;
 h=from:subject:message-id; bh=BeO9WFmMRqhhu/s9N8eXSCUL1EOqkPDqzJwrJeWZ0/M=;
 b=owJ4nAHtARL+kA0DAAoBPtWfJI5GjH8ByyZiAGhiTQpcQReplbla7/KkisUAhbEmJdKW/RpTt
 t6XHhOMF/lMZIkBswQAAQoAHRYhBFfOTH9jdXEPy2XGBj7VnySORox/BQJoYk0KAAoJED7VnySO
 Rox/0P4L/jm7gk4hS3YNoukuIKEL5r0esmcKseV8JWGg73oLjnU4ZX8pASqNWC2tvoKBD8QgfS9
 vPt7/nK8cmRh2EhoQf4hpr6yhZI/4oUfG0p/2q91BkWHDWbwaPgrAOdzSzlZxgMRhtPM2HQDLaV
 KCkaYLeKpRZuKTcU/xCKC62XjYWjg36WSuair5RPErKPg02M2KfdiBwZ2V98ciWcnlc5eUuCmGK
 jGPbpCyZxFiaFJlkA17dQiWwQT2XeK6E2VF8s8q4dj4Z3DPiWxyRisJ1jr098EbYEZTRw2uYlcp
 2za8x02TvH6qewdmjfAZx9GXsU7vKZQCwD0aPVfak+0utl8S7M24W2vVRX6nJkbvS/75yiEhtl6
 kWIxePnRPUIW5LoRW685Sj47qp/7co3fW7dmz1ksg9J8SoR/t00kAJ3Cde+d2A11CzYEGZwnooH
 ImNf0minnkUgjwe8aY10yTlsIeaCZg67MezGaYLMc8J3gXd0CgUTT176MNScvGgC4wP0YwoGoI5
 ig=
X-Developer-Key: i=karthik.188@gmail.com; a=openpgp;
 fpr=57CE4C7F6375710FCB65C6063ED59F248E468C7F

In 1b8f306612 (ci/style-check: add `RemoveBracesLLVM` in CI job,
2024-07-23) we added 'RemoveBracesLLVM' to the CI job of running the
clang formatter.

This rule checks and warns against using braces on simple
single-statement bodies of statements. Since we haven't had any issues
regarding this rule, we can now move it into the main clang-format
config and remove it from being CI exclusive.

Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 .clang-format         |  6 ++++++
 ci/run-style-check.sh | 18 +-----------------
 2 files changed, 7 insertions(+), 17 deletions(-)

diff --git a/.clang-format b/.clang-format
index 19d6cf4200..dcfd0aad60 100644
--- a/.clang-format
+++ b/.clang-format
@@ -220,3 +220,9 @@ KeepEmptyLinesAtTheStartOfBlocks: false
 
 # Don't sort #include's
 SortIncludes: false
+
+# Remove optional braces of control statements (if, else, for, and while)
+# according to the LLVM coding style. This avoids braces on simple
+# single-statement bodies of statements but keeps braces if one side of
+# if/else if/.../else cascade has multi-statement body.
+RemoveBracesLLVM: true
diff --git a/ci/run-style-check.sh b/ci/run-style-check.sh
index 6cd4b1d934..0832c19df0 100755
--- a/ci/run-style-check.sh
+++ b/ci/run-style-check.sh
@@ -5,21 +5,5 @@
 
 baseCommit=$1
 
-# Remove optional braces of control statements (if, else, for, and while)
-# according to the LLVM coding style. This avoids braces on simple
-# single-statement bodies of statements but keeps braces if one side of
-# if/else if/.../else cascade has multi-statement body.
-#
-# As this rule comes with a warning [1], we want to experiment with it
-# before adding it in-tree. since the CI job for the style check is allowed
-# to fail, appending the rule here allows us to validate its efficacy.
-# While also ensuring that end-users are not affected directly.
-#
-# [1]: https://clang.llvm.org/docs/ClangFormatStyleOptions.html#removebracesllvm
-{
-	cat .clang-format
-	echo "RemoveBracesLLVM: true"
-} >/tmp/clang-format-rules
-
-git clang-format --style=file:/tmp/clang-format-rules \
+git clang-format --style=file:.clang-format \
 	--diff --extensions c,h "$baseCommit"

-- 
2.49.0

