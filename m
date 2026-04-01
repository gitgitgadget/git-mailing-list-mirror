Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A24925524C
	for <git@vger.kernel.org>; Wed,  1 Apr 2026 06:20:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775024439; cv=none; b=SRVZAUYpP5z9VUktsW1sO8ZIbKt/V0DJcwbdB/E8txBUaXfUjfNBzTRhsa7vdPEsiodwo6h6xMEdc7ujIPk8AUTCLfT3Gfy4ht/tbDTjfquFpKepXyGsksJze2667HVxtaJjl7IvRvmtdrJVXZswFKz5uiPH2voCDGIA0CZOcKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775024439; c=relaxed/simple;
	bh=MK2e2WPhtw6V5HSttq2oVJYa9gkybk5iGjFsHL9uzAY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=K7z0PYNIiajRtRm5ig7Mb6wBj8+0FMcDRayTQTJ4bmn7VfTRMhDfk0ZLTBi4ZlQuPYgh2WJi4UncN2yeYPsIqcBm85qfxbgKLVBmE339JAAnkdesm6LtdTFSQ9aVikZBn/g+7H3yC4nSxVihsCRKuoMq+YYQlBQ9sKIOoELt2pA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RrcR1ALy; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RrcR1ALy"
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-c76b6abdb73so916823a12.1
        for <git@vger.kernel.org>; Tue, 31 Mar 2026 23:20:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775024437; x=1775629237; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=IxuVqraGd4koER1bqqqIHpYLbnpLWjM28PV6hlgktj0=;
        b=RrcR1ALyogwalmIr0axiHiESxhuo8Oo4LAawjFiQPa8MzTNBOGVKglOmEooYHq6D+V
         VyqLod8oDwVxRmoSb74mZFAYXKBPXvq7XxxazqDtGKJr7F7OkX8wcwR9HZBRJV4XRaoh
         s8tiYaZxucoIVHdLkjwIKiGNnxIZPuX4BhMPOJFOAMDlN8EZ8lfMXAmAIhWwMYnJkvr8
         R9IZuguAn0zbYYcnhjj5NXpn7eq917ahjZ4ol1LvjrNg4u8Lnsk6oNwRsEYfy5YVnUGa
         TiE6LeD0FBCZaQv28HDGwIl6MF2YNUwbGuSlt04uBzm5M9CGPXt9DYFS8yy/t9jANGat
         NxYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775024437; x=1775629237;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IxuVqraGd4koER1bqqqIHpYLbnpLWjM28PV6hlgktj0=;
        b=Fweij/My9E5qrU2JJmUPRX+KARuD0KxEYpFOR5sczyb8Bixs+fciwzeMewATL/v7Yb
         X9SD97RM602c/1Ja9nigApAcuCAZasXN7oiwO8/YBjZJosDKI5uBqlmaNVps34u27MVf
         aMR6FxkLqdLdWwSKY2HuDRrccK4AidZrdr8zA8IWjrCi8SCaKJtxs6uulfg3C23MCV1b
         leHN4gRF4CEij8K/nbp6cFd71V3i57c/TEY78FA4nG599Okakc+XcOwzOSn/MvTAlPSw
         W4XvLIZv1Wfqk/GyxECcBDkTXbo4cviJ1V8m2pvsIkqlfF6cDLsjrCbFXXSJWaz1mndV
         P/2A==
X-Gm-Message-State: AOJu0Yw3n0Ej65Ceb7W3XukSy5UqLaVsGYEHZn+QHGrs4xbESmgIL8P4
	gk3C9RAdrbaXVGHWVHOKKAbnaBa+UOH9Ewb+TIjEAHbXrlv09zixWpmCYDUApg==
X-Gm-Gg: ATEYQzw1K2m+4bicgPo2GGoShtWpvCyApVkXmpSIl19Bh8Quc4vRh0RaKU/rC4jL2hD
	mZNygoRHMPG2WV71Fsl09HmnPYuqTbBxktKAWj4QYaBSxzerNyB5KQ0rQToMb8FvZH/+HmnX6CU
	1HudjR1PFd+Cnt7u2ce7lAetGsvbG9y/q9Z2j/QQefLWSyCxGmjQ02DMZkfiI5HMgNMtmfpIKQN
	qB2fs7kJETwK0LQ0T6JbVmnWIWSjZbdvsanD5jcdFHVDsIXKj6xEdk2DzipTfuQA145wbaNV2Ye
	mCFetbWTsjofQGRy/pk6CUYCfkvuOV79oe6ve2nqY45HD/R2Bh1i0axZTv9k+g8U2e6BuiWNhNC
	v+x4SstunbymdlDBacIBimbYi5OlBBp8gsYSOY5DEQHEUoLrk1ob75eX3lulSf6XooWRgmAw3F2
	k0VYYQnI1+ISNys28vMfI3CvmWJatfK3ZT2CmkXEnXBQ0tJN3iZ/k9d1kYIuZCjW7K0skrwIlI+
	DEvj2NhGNZ1TXBaYg8Z6rwWdcu03DfjanRL/OoUwEcBR38Dn4MV541gIfdT
X-Received: by 2002:a17:903:f8d:b0:2ae:c358:bb7c with SMTP id d9443c01a7336-2b269c8a1a2mr21475255ad.35.1775024437087;
        Tue, 31 Mar 2026 23:20:37 -0700 (PDT)
Received: from localhost.localdomain ([2401:4900:88f8:9a22:440e:d85d:1382:2089])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b2427b3bfdsm171328815ad.75.2026.03.31.23.20.34
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 31 Mar 2026 23:20:36 -0700 (PDT)
From: Siddharth Shrimali <r.siddharth.shrimali@gmail.com>
To: git@vger.kernel.org
Cc: gitster@pobox.com,
	abdobngad@gmail.com,
	ps@pks.im,
	bence@ferdinandy.com,
	john.a.passaro@gmail.com,
	r.siddharth.shrimali@gmail.com
Subject: [PATCH] t7004: replace wc -l with modern test helpers
Date: Wed,  1 Apr 2026 11:50:29 +0530
Message-ID: <20260401062029.54757-1-r.siddharth.shrimali@gmail.com>
X-Mailer: git-send-email 2.51.2
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Pipelines of the form "test $(git tag | wc -l) -eq 0" suppress git's
exit code. This means a crash or unexpected failure from git tag would
go undetected. Additionally, the use of $(...) creates a subshell for
each check, which adds unnecessary overhead.

Replace these patterns with test_must_be_empty and test_line_count.
These helpers check the output of git directly from a file, ensuring
git's exit code is captured properly via the preceding "&&" chain.
They also provide better diagnostics on failure by printing the
contents of the file when a check does not pass.

Signed-off-by: Siddharth Shrimali <r.siddharth.shrimali@gmail.com>
---
 t/t7004-tag.sh | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/t/t7004-tag.sh b/t/t7004-tag.sh
index ce2ff2a28a..faf7d97fc4 100755
--- a/t/t7004-tag.sh
+++ b/t/t7004-tag.sh
@@ -33,8 +33,10 @@ test_expect_success 'listing all tags in an empty tree should succeed' '
 '
 
 test_expect_success 'listing all tags in an empty tree should output nothing' '
-	test $(git tag -l | wc -l) -eq 0 &&
-	test $(git tag | wc -l) -eq 0
+	git tag -l >actual &&
+	test_must_be_empty actual &&
+	git tag >actual &&
+	test_must_be_empty actual
 '
 
 test_expect_success 'sort tags, ignore case' '
@@ -178,7 +180,8 @@ test_expect_success 'listing tags using a non-matching pattern should succeed' '
 '
 
 test_expect_success 'listing tags using a non-matching pattern should output nothing' '
-	test $(git tag -l xxx | wc -l) -eq 0
+	git tag -l xxx >actual &&
+	test_must_be_empty actual
 '
 
 # special cases for creating tags:
@@ -188,13 +191,15 @@ test_expect_success 'trying to create a tag with the name of one existing should
 '
 
 test_expect_success 'trying to create a tag with a non-valid name should fail' '
-	test $(git tag -l | wc -l) -eq 1 &&
+	git tag -l >actual &&
+	test_line_count = 1 actual &&
 	test_must_fail git tag "" &&
 	test_must_fail git tag .othertag &&
 	test_must_fail git tag "other tag" &&
 	test_must_fail git tag "othertag^" &&
 	test_must_fail git tag "other~tag" &&
-	test $(git tag -l | wc -l) -eq 1
+	git tag -l >actual &&
+	test_line_count = 1 actual
 '
 
 test_expect_success 'creating a tag using HEAD directly should succeed' '
-- 
2.51.2

