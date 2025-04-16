Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82DE81F7580
	for <git@vger.kernel.org>; Wed, 16 Apr 2025 14:59:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744815594; cv=none; b=jS5jnx4bVcZGt9dqJUr4b/rnLrxOBhHB3czONe6kCEhkI4vCJHtlQUM4JIhDMu3b4Hpe6UqUC/nmsMTyyYEsfA9nAXm1RvwKSwbpq4SMYxFNFdwQM8l+i2JTunxjfmudnXjKZiUB7dosMVuK63kSY20M9C/4HyNlKa2vjfCiuwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744815594; c=relaxed/simple;
	bh=/0klJRLsP+bbV3eZIa6eGJB24jPKTeUDUfHNYFv11P4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=t1aPToE/KqfcszxuFqx9BwqGWwKlwM22EM99NpbaQQ+5xD763NfjTkxOGo2KtGWVl1VKZ6efDf6kZOHJ6kMoxCZnqRzcHY0hMInDprw+YJmRD5W02GsRciVR3THAp+IIysVmyAgZbBEkFTkhE/KCdKd/q8yCUeCytidKy1l+0K4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iAaEIg7h; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iAaEIg7h"
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-5e614da8615so1813220a12.1
        for <git@vger.kernel.org>; Wed, 16 Apr 2025 07:59:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744815590; x=1745420390; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2eCumyfS5qyJPMVkSUHi6iDpG6ii7dvjzxiG//pWgRc=;
        b=iAaEIg7hGdRRbO7MCzDx8TcKxIvYobutSh/TXNBDTDqQTeeQkrejrMlAyX0p+Ct1Ht
         gEVPCiExHROfGvGY0K62fRa5RIRUsrxJmOPjz9fhkKl4gB++w488fBLj3UlOO93giSDs
         Xkv7biJcYUqWKIBmaPzHCfEQhhqH8Hs1zGyumPvPgurqWd7rxk3/9i544g0MqVLABZX2
         LIcj5DkRJi2foLru9dH/gpJhXlHtd2C1ZdNm87R6zdpbGMNpXEnyjdShAaSibZgCRSOr
         ZA9SkxWtAlR7+pGC/yNg4poFWfOoL9bTL/l8sd5tVA2tStCVcxivaVI/a1pz5/KU+9E3
         kbFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744815590; x=1745420390;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2eCumyfS5qyJPMVkSUHi6iDpG6ii7dvjzxiG//pWgRc=;
        b=CKHS/sfYePj0/92bqNfujIEiKCle4csLBfXvbnwGJj6HLGYvxu0vV/l3f3Tk3Qr/3h
         lBwUBp25FMGkyxGYOMLAdx7pPl7+bL4F16Nh1wM4roUNgzK7eJcZ5uWdAnSrgQqPQE87
         X4ErXdLVY6JaHFP7bJC7k8cOPh1Kg+dD150tGHf101W2Am/G0+Bcs1W++7PRKdM5MOHq
         jLV/4bCNeY0+vK57CHxbRycvmw0gHR3hioEzG9Xpyy6wOGipTyspFKcCb+WGDOh6LEtn
         62nLGjJ8tzle7ruO+B1zxT6ep0xwEbROBDXaXVEk3eGeZphMUt22QDK1Wsr7xV1PxM0f
         iM3g==
X-Gm-Message-State: AOJu0Yy6S3I+TjIjMxc6ZZum3QR4h9BaBUNggWPA1Dn/HILF94Vdy8cS
	PdDCdjyvMd3qfD7ydWr1K2JLTGGu3dbgZ1ZWhcsyEyP1TQn5VM+bN8p+zMXMYyRW
X-Gm-Gg: ASbGncuSG1Ix5XG480551gjgferSO30C0D5xmz3/N7NjFck4ZjpQfFvt6p3baCwJdqj
	M6gYU6S/ZVCRV0USE29YNrKP4Cm/imfZvKUfDl+5fhpJdsQenaYvzgxmYbTGW8ApFRp6xxw1PXm
	42df6zsoEtvqLyYWn53cHHGflVCBSka3iRh7Sdgz+TUXY7zaD3eSIXoVbMz2UGs4XYkm+jsDtRg
	N5Y06/qgaw6JV9FBVDHt4lmZT0G5DiiQ7QT43ULsQdEF29lBuN+469yoP4hzIKjt4CqZnJZl0HU
	R5+TdGCdE2YTnJcN4tM6emMZ6bX2x31UjvPuN2esZpUQ5DAUCRmLPT29KnNe/PcVV/jdmdsBeoq
	lBRW+Y8F+7d97BN9xYjNiLQBG3QHWtgT8s6FHzhMaTWnE8r6gNiGjZr03mkiJru2loDU1udL50A
	K5A8Q1wBL2oL6YyaNp+E8=
X-Google-Smtp-Source: AGHT+IH7cR7FKLqWwtmuZCI0OgCNvgABPoOYMVrZXsnAhproJo0h9q5gEMI8qkXET0VYHDuijn/zhg==
X-Received: by 2002:a05:6402:2546:b0:5ee:498:7898 with SMTP id 4fb4d7f45d1cf-5f4b878fe60mr1892430a12.17.1744815590152;
        Wed, 16 Apr 2025 07:59:50 -0700 (PDT)
Received: from Anthonys-MBP.homenet.telecomitalia.it.homenet.telecomitalia.it (host-79-1-195-126.business.telecomitalia.it. [79.1.195.126])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5f36ee54ff7sm8599711a12.15.2025.04.16.07.59.49
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 16 Apr 2025 07:59:49 -0700 (PDT)
From: Anthony Wang <anthonywang513@gmail.com>
X-Google-Original-From: Anthony Wang <anthonywang03@icloud.com>
To: git@vger.kernel.org
Cc: gitster@pobox.com,
	anthonywang03@icloud.com,
	anthonywang513@gmail.com,
	christian.couder@gmail.com,
	karthik.188@gmail.com,
	ps@pks.im,
	shejialuo@gmail.com,
	shyamthakkar001@gmail.com
Subject: [GSoC] [PATCH v7 1/1] t9811: be more precise to check importing of tags
Date: Wed, 16 Apr 2025 16:59:39 +0200
Message-Id: <20250416145939.24207-2-anthonywang03@icloud.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250416145939.24207-1-anthonywang03@icloud.com>
References: <20250405103718.25160-1-anthonywang03@icloud.com>
 <20250416145939.24207-1-anthonywang03@icloud.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The tests use grep to search the output of `git tag` for tagnames they 
expect to exist, which can incorrectly pass if an unxpected tag
has the expected tag as its substring. We fix this by using `git 
show-ref --verify` instead.

Additionally, we add a negative test to verify that a possible
uninteded tag does not show up in the imported repository.

This change also fixes an additional problem, where piping the
output of `git tag` caused the exit codes to be lost.

Signed-off-by: Anthony Wang <anthonywang513@gmail.com>
---
 t/t9811-git-p4-label-import.sh | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/t/t9811-git-p4-label-import.sh b/t/t9811-git-p4-label-import.sh
index 5ac5383fb7..39856629c0 100755
--- a/t/t9811-git-p4-label-import.sh
+++ b/t/t9811-git-p4-label-import.sh
@@ -95,9 +95,9 @@ test_expect_success 'two labels on the same changelist' '
 		cd "$git" &&
 		git p4 sync --import-labels &&
 
-		git tag | grep TAG_F1 &&
-		git tag | grep -q TAG_F1_1 &&
-		git tag | grep -q TAG_F1_2 &&
+		git show-ref --verify refs/tags/TAG_F1_1 &&
+		git show-ref --verify refs/tags/TAG_F1_2 &&
+		test_must_fail git show-ref --verify refs/tags/TAG_F1_ONLY &&
 
 		cd main &&
 
@@ -207,8 +207,7 @@ test_expect_success 'use git config to enable import/export of tags' '
 		git tag CFG_A_GIT_TAG &&
 		git p4 rebase --verbose &&
 		git p4 submit --verbose &&
-		git tag &&
-		git tag | grep TAG_F1_1
+		git show-ref --verify refs/tags/TAG_F1_1 &&
 	) &&
 	(
 		cd "$cli" &&
-- 
2.39.5 (Apple Git-154)

