Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 504392D8DA4
	for <git@vger.kernel.org>; Wed, 25 Jun 2025 16:43:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750869831; cv=none; b=jFG3DafYKBAHsLOLT5nHc2hJjeTAhXWkkYLyAoeGF70b+Ivu9DrzMxRKC/TtwOEcE2JbEdaBG3lfNBpFLnRFQDuWTTqgtzWxGjahlr5Xq/vaIjUjAcPSbFMAHNc8HZDHLm6SJJ/nEYXBciJV83wQpZNbN5QTmDB2LqNbeUBN06o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750869831; c=relaxed/simple;
	bh=BeO9WFmMRqhhu/s9N8eXSCUL1EOqkPDqzJwrJeWZ0/M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gc/bPi2wLQCCFRucM/53T6/IrtRxJc8PFPRAEfDmNFbqtl6lt2BJmhipOl/ZM+6AUQZkyB1uWZpQj2f2EDAY4yWhkB1HKM0XjVEfK+4S6H17eDFGEaNt36kcn86Lkt1eK8QQk07OaBapCn/3aNdPXLJnao1O3Rumr3QWOCPFHY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HGAmCupy; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HGAmCupy"
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-60c5b7cae8bso43665a12.1
        for <git@vger.kernel.org>; Wed, 25 Jun 2025 09:43:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750869828; x=1751474628; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=K1V22kMtCJCpgUiSd4K7Tfo81CPOoYvdSFZsdAfJT9o=;
        b=HGAmCupyORAoxB43Fj7OaNtvJMEDYiZDK/Ig6wCKjiCiR4mdGV5IcYPpo2gxvMQ6Mz
         ZZu+fVGqW7bLIN7ozUfBasa2C6ju6S4hDbcJ1PQN8Sh7X2dBnLqMCYZ7Q6s6WvAK2/G/
         xGvTrUAzcScFhP+tSaDkcKq0IQf6n+SxbTM7ceJ3Im2rTGr6T3fCMaIGb2NF1y/4TnpR
         mQWk6qmqiyHV4zuwi0i4lT/ShpKUv8SEy8voeI6P8czmSVMo0tLkNKLMdbAI13ppZ+rN
         WSkIXOMk1mitQeDXG2B8L3F0RgEM7MlbrJMSsZyqBikWAw0YbAcY3OKAIqSbMtsJMDNJ
         MCXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750869828; x=1751474628;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=K1V22kMtCJCpgUiSd4K7Tfo81CPOoYvdSFZsdAfJT9o=;
        b=ZTeccdN+Bajdm9PrgPlmVUqEoQKJXiuOEBXStpFgr/dbSKbX0Unjr3nHtsVX2YO03d
         Cgvr7lQaINu6md4QTrqRyE/8F2EYeGWPZFkZ8qOcUydFVcP/IjxNc5UH0ZofcAHtOJgZ
         utQ1szAJoLxv+LyDHWkZBQdz+OSGxMDNGX5C1C48QKJs86f7NGpOCd36PfaKRCd7qb9p
         H0yP/VKZ7CWtl9Xj5x/3/bE9w4r+YqqomAHyXfuHyo7pq2ueLQd7NGOmKdu1FyPAG7lx
         sPXa4cyuFh3J31qi2ZaXyPbDzz5nZyjQ4P+T8kTSrkQ6NMbGTEMhkiJWyqMpQIrwJfbG
         TlVA==
X-Gm-Message-State: AOJu0YzyX5iLPF8OCzOslsMTVclNvoFYYxPJ37yJW3QUxQREk5qQA+/k
	NoVnzVIdzh5VJ31Wb7Q/jGgaZGbMClNwawwlaBA2JYqJKW6/ZqclF9IL
X-Gm-Gg: ASbGncvEoROAo0ZnckTkqDWUVDIkXujPGKUExqDuZvOtV9hmT+8bUWV87TPbbBcsJTd
	aX01jTcRunaSee4lG/UQ//25Xx0m9hU2wU/LV3k8RhlRGtnAwHE4Q6IuxMpDV23q/JsCsvjra5y
	3yxEJ8pqZmm6PiGWBAvXWkf5ylFbGxy/DYQoEq3YrSZQl1Hgu5TPBSEwr+OydJnUUHmGdb1fn0s
	zLLS5BvFaU9JOWX9xud7Y5pAnrzMfnOk/ATmjA+6qwXE6GqfBfHzaK9jzZPgSYXqw/cLUw5mt5X
	pkM+2odSyZ6iVo9eRP8MHafmsMvu/xJgLFi4RewjiANuxg==
X-Google-Smtp-Source: AGHT+IFaLtcTyMjhJefs8oXaX9+qJpgH64W7pXODBRhLvswLGw+E/0pr4SRA8kz5D2egjygf96cgkA==
X-Received: by 2002:a05:6402:1ece:b0:607:16b1:7489 with SMTP id 4fb4d7f45d1cf-60c4dd008e6mr3341325a12.20.1750869827625;
        Wed, 25 Jun 2025 09:43:47 -0700 (PDT)
Received: from [127.0.0.2] ([2a02:2455:8268:bc00:b5f1:56b2:13d2:a5cf])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-60c2f1b8e14sm2661774a12.35.2025.06.25.09.43.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Jun 2025 09:43:47 -0700 (PDT)
From: Karthik Nayak <karthik.188@gmail.com>
Date: Wed, 25 Jun 2025 18:43:28 +0200
Subject: [PATCH 3/4] clang-format: add 'RemoveBracesLLVM' to the main
 config
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250625-525-make-clang-format-more-robust-v1-3-67a49ecc2fd5@gmail.com>
References: <20250625-525-make-clang-format-more-robust-v1-0-67a49ecc2fd5@gmail.com>
In-Reply-To: <20250625-525-make-clang-format-more-robust-v1-0-67a49ecc2fd5@gmail.com>
To: git@vger.kernel.org
Cc: Christian Couder <chriscool@tuxfamily.org>, 
 Karthik Nayak <karthik.188@gmail.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=2246; i=karthik.188@gmail.com;
 h=from:subject:message-id; bh=BeO9WFmMRqhhu/s9N8eXSCUL1EOqkPDqzJwrJeWZ0/M=;
 b=owJ4nAHtARL+kA0DAAoBPtWfJI5GjH8ByyZiAGhcJ0D4ZxdLFqIJKgHg+AuJLJriA2hTcYTpB
 bmD0q7RMARmTYkBswQAAQoAHRYhBFfOTH9jdXEPy2XGBj7VnySORox/BQJoXCdAAAoJED7VnySO
 Rox/M9cL/24jY2EPO2RfiO5QtloaNdij1mQoUuuikgsUN3J5nQdNj3iGR2Q00DWGx3iSF3a/8HE
 0eh4UxDM4YEhAw454S5rbCxV1IzQmrAcAmKzaWUa1ikUnL05/k/NltF8DWhsRvzIR0akxp6dQ6U
 zDt6C8xwV+gWIPTwLNmZ05/AhDmhMwVWpD6XtsFWJ5rWyAry5N4cRjgUoIKQCV733xdFtmBaHha
 wG7ATBcVUmsrgonS+GLKRp9/S86Hx2JWhFNulE24u1leQ/+YLbt5zozLQmQ2eAkOI8JAny/cfjJ
 GGJDCyeoWTJnu9GO4/s24oVr0yU469/gYCqGrEnzSyW9QWFt29xymPnZc7M7OOXcw/PtfWx2unq
 BLq7oDC0OlbFFSOJBC9hbTBTeZNhJyFIcIJcWZPbuqP+Tb4IdSltj2E1Jndl8IqIACQyB22A2VA
 CktsIG/4jQzydbsjS7CpZlInEouApCwgpJoAAyTdDofKyFZls5M4cGv6EGy9SkJ3oHVl4Abrxn0
 k4=
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

