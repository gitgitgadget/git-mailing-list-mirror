Received: from mail-oo1-f50.google.com (mail-oo1-f50.google.com [209.85.161.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A8DC1F0E49
	for <git@vger.kernel.org>; Fri, 31 Jan 2025 17:43:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738345436; cv=none; b=KLaPXe/PK22EjYCkEVuRYSOvHQCfeuCZex9NWzgq87wRw7yGHrTG/XrwudKehhN3TQbrmZFATDRNB6SnhLXIH/+I0/tmseiMtQbiL0bbpJfdqo7US428ZiXAR4+c/Z98cYN5E0NlPzmnid03q5Hrg/ojZN4NZ2RV1sWymuqXDUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738345436; c=relaxed/simple;
	bh=kR2Zx4zHzSV5+OoHv3fLo8fx+HvvWCjpQ/O9GTQ3P/Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NvtBbXC3SQUrRjqD14ErSOitatp4YR7gbQqgD/txhx1uidT0m26hnBqlAjtHsXcGvJ+1xk5ueaRTfdVlUpSb3Cfj9O2QBotdjx/XGklB+kWcOC3VZJl0y6mT7rCC0cb/wphLMtdPpwdNPQLaLDy+6e2AZRhjeOvdUX/OwTrl9E4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ICPB12ll; arc=none smtp.client-ip=209.85.161.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ICPB12ll"
Received: by mail-oo1-f50.google.com with SMTP id 006d021491bc7-5fa22d0b88fso1335192eaf.1
        for <git@vger.kernel.org>; Fri, 31 Jan 2025 09:43:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738345433; x=1738950233; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=V7WTOZbmigzoHllTmZ+HBxdAgxAmqMz+z8aXc0SuVeo=;
        b=ICPB12ll+svlRgcKhqSwZTjIuygQjIKXX2Ylmd/Dw9BCV6U96sxaRI38UK21ZOgFll
         PGpPDWDaAkpZu9KIwVoQ7AyCvbeiTU8rYb/XTifHzlC3djACRM4ei2PYtPV0LPK4NRsU
         CKMFmpfjSYLI4jqY0lNm5p3z5AEsrcskLGfwBul2sCd/7hduxVDg4z52nJC8u/qx9je0
         AO67Az28DiOwYe4ygGbjB6gqtodQ6SZbMm9tW+OJMxFIuu7EZrEp6leiHAvVawQ5Kf+C
         ODltY9fRPm7lSMbH/t2hX3YUjJJI9kyJX94mneTEWvBKPIC3ikrHDBzp9sY1qqdjcqts
         BEgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738345433; x=1738950233;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=V7WTOZbmigzoHllTmZ+HBxdAgxAmqMz+z8aXc0SuVeo=;
        b=A0J1pOjZr6oMka0bzfg26AwmUQ3JdNfTDGsNJyU+EAAz5HxVt3BmYU203AWRa9dKK3
         xQE5PSxKU1KgkzAWM09jlyrSx+ugH3s9ReSRbMT/834TEf516CXbNW2/ScDftn9zUzgO
         FPKnAoCwT63UEdlIy6iQmtpicHUFTVkCW5+rzYlQFcWR1rMeAJVF/YHNODqTgM2Im7Ym
         nDy+BSKU2MKXALkciVGmRUtCrBUHfPUyepatILOf/5xiHg5S8Xd7i0rnlIWx3dfFnwdz
         6Pe7v+Vs3wMcG9JrsbCoa/JAgmVucsXN5PRrd8uNpOG7YvNiAP1Bm5P/4KD5mVQFjSBP
         6jqw==
X-Gm-Message-State: AOJu0YwfuuEBFvmCT62X8spcax3MZ9mnPMPP7cOvrB7ChmZeBr7vb2L0
	nWrvMhrAIxiwv2EC/r5gyC71MO6bieDpFc0VT38b6T9vNFnceVRYp7EpYA==
X-Gm-Gg: ASbGncvAdm8Npa09Ml+XYaRKDzes8xcKUdFAce7RiNVUym6RWuqwgLFMYa4if1fXm/R
	iaDj5xbXs0vvvAYYzKIjA+UZxvSV6SaVHP8WhzkT/tgw2TWZrHwO0lR0u+FCSJkcZOOzvjas9ls
	WchgQ90OUzh3Ks4WgRYhb0fH/Iqr6ZfBQHjiuDDjwYAUnInMiYSvWx5Wp2xXjBiNxav/N9g6NEO
	HzF/mzaMcoPn8bXAWDPMX9uUD1mQswqalxbZTcWg8eED2oSK6JQzOOWoJxP7MZueZV2DHhP37Ll
	FyohJ0wZvs62bX7Ojv/P3zQ=
X-Google-Smtp-Source: AGHT+IE7kR6r4HLSpWJH0CdNeraZ/3T4eS+Ej/8YLJ2pNVBEAsrf5T+OfXp8lR3F+3BUoKnGUxVgbg==
X-Received: by 2002:a05:6820:2294:b0:5f8:b916:2516 with SMTP id 006d021491bc7-5fc00135c96mr7708096eaf.0.1738345432871;
        Fri, 31 Jan 2025 09:43:52 -0800 (PST)
Received: from denethor.localdomain ([136.50.74.45])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-5fc104f6cf0sm980494eaf.22.2025.01.31.09.43.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jan 2025 09:43:52 -0800 (PST)
From: Justin Tobler <jltobler@gmail.com>
To: git@vger.kernel.org
Cc: toon@iotcl.com,
	Justin Tobler <jltobler@gmail.com>
Subject: [PATCH] ci: fix base commit fallback for check-whitespace and check-style
Date: Fri, 31 Jan 2025 11:39:38 -0600
Message-ID: <20250131173938.3592899-1-jltobler@gmail.com>
X-Mailer: git-send-email 2.48.1.157.g3b0d05c4a7
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The check-whitespace and check-style CI scripts require a base commit.
In GitLab CI, the base commit can be provided by several different
predefined CI variables depending on the type of pipeline being
performed.

In 30c4f7e350 (check-whitespace: detect if no base_commit is provided,
2024-07-23), the GitLab check-whitespace CI job was modified to support
CI_MERGE_REQUEST_DIFF_BASE_SHA as a fallback base commit if
CI_MERGE_REQUEST_TARGET_BRANCH_SHA was not provided. The same fallback
strategy was also implemented for the GitLab check-style CI job in
bce7e52d4e (ci: run style check on GitHub and GitLab, 2024-07-23).

The base commit fallback is implemented using shell parameter expansion
where, if the first variable is unset, the second variable is used as
fallback. In GitLab CI, these variables can be set but null. This has
the unintended effect of selecting an empty first variable which results
in CI jobs providing an invalid base commit and failing.

Fix the issue by defaulting to the fallback variable if the first is
unset or null.

Signed-off-by: Justin Tobler <jltobler@gmail.com>
---
Successful GitLab CI check-whitespace and check-style runs:
  - https://gitlab.com/gitlab-org/git/-/jobs/9011117606
  - https://gitlab.com/gitlab-org/git/-/jobs/9011117607
---
 .gitlab-ci.yml | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index 9254e01583..273a8bad39 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -183,7 +183,7 @@ check-whitespace:
   # be defined in all pipelines.
   script:
     - |
-      R=${CI_MERGE_REQUEST_TARGET_BRANCH_SHA-${CI_MERGE_REQUEST_DIFF_BASE_SHA:?}} || exit
+      R=${CI_MERGE_REQUEST_TARGET_BRANCH_SHA:-${CI_MERGE_REQUEST_DIFF_BASE_SHA:?}} || exit
       ./ci/check-whitespace.sh "$R"
   rules:
     - if: $CI_PIPELINE_SOURCE == 'merge_request_event'
@@ -203,7 +203,7 @@ check-style:
   # be defined in all pipelines.
   script:
     - |
-      R=${CI_MERGE_REQUEST_TARGET_BRANCH_SHA-${CI_MERGE_REQUEST_DIFF_BASE_SHA:?}} || exit
+      R=${CI_MERGE_REQUEST_TARGET_BRANCH_SHA:-${CI_MERGE_REQUEST_DIFF_BASE_SHA:?}} || exit
       ./ci/run-style-check.sh "$R"
   rules:
     - if: $CI_PIPELINE_SOURCE == 'merge_request_event'

base-commit: 3b0d05c4a79d0e441283680a864529b02dca5f08
-- 
2.48.1.157.g3b0d05c4a7

