Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794504871;
	b=I+nt3xmZI+K/rsB/hSG551hiiAcBXOWlH17FCq4F8BU0+kKNcx00LirJagyVXy83QdTk
	 rJB72Qr2eqsCP9bMBIJJU6HrfNDm1iBqSvNhkdc0Iywb+IwIQirjFYMTse17CjUcAa2tz
	 Y4YJTFaAJ8JfRqnxWsaznNEm49AMRmIO4rQ94VTSaHz7Agt6Z2XCJ06j4NNOTAqNrXrbE
	 iHiTjq14ilr8wLo25GHYq06Kfw1UGzhZ2KqEGjylQtiYzpVn88KUnJ1uoE7PNGmGWOPEU
	 ZvM1lvP6tYASOuYEBgDtSuAgKkelhar4MTEuSiE6/YO1eJmBin280evf79xRmT7CpwA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794504871;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
	 X-Developer-Key;
	bh=TCblcexWVONcxClhdh+baJm0qxvOKKdxHR8Ma7eb8JU=;
	b=nRXowTbndM1uhjyqfsKf5rm4OS7BU5J/HtSkeV45I0XAX8zoWlPDZdq/6sRA0jB27LxZ
	 y4iupIl18RhJ87HBh1EbKfpIRaASoRNbs8KcgCbJtvpSSBubF8sDwdNa3XJNQKIoV0AxY
	 4FlMrx+kGqSceFy6BFaJBons6tnovZjDRHBAx3P/vf4vBMcXCVZ0r9ynmZWVfB+qn/60c
	 IDbNVSVMgQrPBU9DPEMqKBu5G5YIhAfgluEGQGcDBKtzYpVDnWrkPiixkh5QYG5mqizRj
	 8uDan2K+BtHXnszGsC3pB+zxGEurOJHPoZWHC+RT2UYQNDgEgLwpQE5pxgmZk4VmXNg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=t1Fgm22f;
	arc=none smtp.remote-ip=209.85.221.44
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CDA7606CFEF
	for <git@vger.kernel.org>; Thu, 12 Nov 2026 17:34:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0CDA7606CFEF
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=t1Fgm22f
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-490c3ae81d3so5430f8f.2
        for <git@vger.kernel.org>; Thu, 12 Nov 2026 09:34:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794504869; x=1795109669; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=TCblcexWVONcxClhdh+baJm0qxvOKKdxHR8Ma7eb8JU=;
        b=t1Fgm22fxOHvwfGD4adjzWsIeCvBWUBba7mIpbjJXuufc85FXr1DLtwk7lZsCnidYF
         oySVur+HPpiHAwUN2GPc1pF0dihB4pVdKIN9pox0dQOOf7Km7NBEVA1j7Im4jDtnaYFv
         /Yk6Me5xxZ9UEUfutDwTyWNFHnOCJsGhHyVusAktRNmooUiNaUfxcPD8K6nnCWPq30hM
         Ck8Twe6yTzRpMnLXPzNRhKfqtpStfT/pHpbFP02yoiURnvJiksFAJ9oXfvbDfmI3Fi59
         VWjMw4KRfvqg0rDeNfDNotFKdyHh1y7HlfZKH012PYCzco6ROL1pINRqS74ttUKS4ZiQ
         nMxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794504869; x=1795109669;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=TCblcexWVONcxClhdh+baJm0qxvOKKdxHR8Ma7eb8JU=;
        b=wwtT9kVqdL6x079BXREBKoB9Im+lw+Fe+49l4UBK6WxH9bm7gipbBF0mfVAoWsInqA
         NptuGNQ5fF5len+EPg10j3NM2XxNj6ZpUokCElEnrDyCKD0UHsa4whmTeOnhVagx4iY7
         zGl4fAFuVlXWXNU7cRmu7rVe2IBGCgY5KaYpf7u1KFQM7Dc+PPI9S/0Xasnqv8cUk47b
         Cgef4O30ACuFf5DJCsn6U/xg7/pC8GxWpEIW3Q2Vvjfdg3Mb0kioI/zRCrVTu9lJo5mp
         w3fEerhQgdyB5jrWapq5CNfNePViQiAEIqczgtPtBqrz0o/lxPtl7fqDp3/46SAa7LVY
         GZHQ==
X-Gm-Message-State: APuU4Z9pL8Jhi3B+AohmFb+9Ou9rKXkXuQhJdaASY9PN4kYXbtO7CgSd
	kEupp8UviS3JH0pq5QS1BswQHV+HJViMDWvnsOvtB4tFV486kCnNbYHeidtu/g==
X-Gm-Gg: AYBFou2guMzvUr5yFRFAWH/SJUQ/H4GpDDgf/Vx9DKxILE1rWvDvbE/2fJ7med6G4S9
	B1CTKvXLrL3tl2XhEpi9F9oZhpKNFiNVEvgpFgVXeogTlYfSAkiEDwKtXJqiP/tAuC41Y/klo5W
	/MrRb5t8REZvjoyjg0XRaySDQsWc21m4tceP9+nn9/TvkB39YVlVMO1nrgxkehXGlD9ZlAbuqgg
	Y5fhJ/M31fRArl2ycuZSCAzuDj5Bt28UJxzbpr805UMI+2y9A+X91q1/H9FAzc4nUnFhoVZlUtE
	c1uSI+0dHKwPgTJSZhY4wYmasbsPjUhNs/LnzoWoaCafD7KG+d4ENYd+TqstONW0reBbpuWaUDE
	Dalf2sfAKoHYw6tak5zUOxqwzENaXVjowwGkCfoKwY/woijNcLeaf8HOS2BqkmKfCmkQDlsOXkN
	LcO10QgLSg+cBdDScphy7cXIwAGNiLeH8sMH7NepOUvvT4omWkI9fG506NcaHSB9tqP9PPXggtL
	foi1Yw6bkDjfuOAFAcmanL6Tb2xY7JTR1X+8K3pN5hxdprOMtjRyTrttAKEsRQ3SiZDfq7slj06
	ZJVys10pjCgbWVaFjzFrl/2hGXKhhrNl+dPSmn1nSXHjGFz/Kz3r8yjUf0izSvZIk1huBA==
X-Received: by 2002:a05:6000:240b:b0:490:7fb3:cb41 with SMTP id ffacd0b85a97d-49c714a2e3bmr119824f8f.24.1794504869380;
        Thu, 12 Nov 2026 09:34:29 -0800 (PST)
Received: from [127.0.0.2] ([2a02:8109:d906:4e00:cb2b:22fd:d791:9595])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-49c604ee47dsm345988f8f.38.2026.11.12.09.34.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2026 09:34:29 -0800 (PST)
From: Karthik Nayak <karthik.188@gmail.com>
Date: Thu, 12 Nov 2026 18:34:14 +0100
Subject: [PATCH v2 14/20] t9300: make the series Y tests self-contained
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261112-kn-fast-import-tests-1-v2-14-b8c3a0ab27e8@gmail.com>
References: <20261112-kn-fast-import-tests-1-v2-0-b8c3a0ab27e8@gmail.com>
In-Reply-To: <20261112-kn-fast-import-tests-1-v2-0-b8c3a0ab27e8@gmail.com>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, gitster@pobox.com
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3225; i=karthik.188@gmail.com;
 h=from:subject:message-id; bh=jAl/3wLYCH2uKs4xTsRhBSVwkom7hBxESC4lilpAI8g=;
 b=owJ4nAHtARL+kA0DAAoBPtWfJI5GjH8ByyZiAGr1+JKSYVwd6W6HKBUWUs4i3q/MlFyzwAPct
 gt/Djo7KJcZRYkBswQAAQoAHRYhBFfOTH9jdXEPy2XGBj7VnySORox/BQJq9fiSAAoJED7VnySO
 Rox/104MAI3HD4pb7ZKl1zawBATFDuxGnKZ+0C2nhEsqQ4bAgQuGwCzkql6CZse2sUE+KHFSOLj
 tFUeXBBv2jgeDh3BRR/J128IsWAkbjY8/olsYHDtOxbUaa7Fjxyc4CetE8dCtX0D4Io58vLHB3W
 V/J6lZrBaSB165UxN+RhleFwKlWnRZz7zHZ98tThl+CKpZDGQHqqQ/0usZJgKOcUfy2X272oW3x
 97RFDnil1J+fE6Db783C4aGZ3/EjEMrvVDV0WZKGq37PqxGEZCnv1kHlwKNwKjFbfKqcl7h9qEB
 8sJ6wS3B0/0TgKFW1/947y9jD8MNtzssfEE+rKvVYlvpAiVgyCtA0ibhcndHmLVgdYI4XjZmgyu
 Rb0jmxG9OeFUjusBMZqKXZx3uIgh20dV5EhUYoe+PjpAhH3hsriA9hY9E3hRJxA8ajVGG71negG
 JsTa7hbCA2mp0w+K9pyQXQJE+wfCMHFImgu0KP53VqOH9zqK8eFlZ3ikQgWJSIYwBnOcpLB+R72
 mA=
X-Developer-Key: i=karthik.188@gmail.com; a=openpgp;
 fpr=57CE4C7F6375710FCB65C6063ED59F248E468C7F

Similar to the previous commits, modify the 'series Y' tests to make
them independent of state from previous tests.

The 'Y: setup' test only fills the OID cache for 'Y: rewrite
submodules', so merge it into that test. Also clean up the
repositories created by the tests.

Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 t/t9300-fast-import.sh | 40 +++++++++++++++++++++++++++-------------
 1 file changed, 27 insertions(+), 13 deletions(-)

diff --git a/t/t9300-fast-import.sh b/t/t9300-fast-import.sh
index 1022299b7d..7b755d8de1 100755
--- a/t/t9300-fast-import.sh
+++ b/t/t9300-fast-import.sh
@@ -4579,27 +4579,35 @@ cat >Y-marks <<\Y_INPUT_END
 :4 ff729f5e62f72c0c3978207d9a80e5f3a65f14d7
 Y_INPUT_END
 
-test_expect_success 'Y: setup' '
-	test_oid_cache <<-EOF
-	Ymain sha1:9afed2f9161ddf416c0a1863b8b0725b00070504
-	Ymain sha256:c0a1010da1df187b2e287654793df01b464bd6f8e3f17fc1481a7dadf84caee3
-	EOF
-'
-
 test_expect_success 'Y: rewrite-submodules-to feature forbidden by default' '
-	echo "feature rewrite-submodules-to=sub:sub2-marks" >input &&
-	test_must_fail git fast-import <input 2>err &&
-	test_grep "feature ${SQ}rewrite-submodules-to${SQ} forbidden in input without --allow-unsafe-features" err
+	test_when_finished "rm -rf repo" &&
+	git init repo &&
+	(
+		cd repo &&
+		echo "feature rewrite-submodules-to=sub:sub2-marks" >input &&
+		test_must_fail git fast-import <input 2>err &&
+		test_grep "feature ${SQ}rewrite-submodules-to${SQ} forbidden in input without --allow-unsafe-features" err
+	)
 '
 
 test_expect_success 'Y: rewrite-submodules-from feature forbidden by default' '
-	echo "feature rewrite-submodules-from=sub:../Y-marks" >input &&
-	test_must_fail git fast-import <input 2>err &&
-	test_grep "feature ${SQ}rewrite-submodules-from${SQ} forbidden in input without --allow-unsafe-features" err
+	test_when_finished "rm -rf repo" &&
+	git init repo &&
+	(
+		cd repo &&
+		echo "feature rewrite-submodules-from=sub:../Y-marks" >input &&
+		test_must_fail git fast-import <input 2>err &&
+		test_grep "feature ${SQ}rewrite-submodules-from${SQ} forbidden in input without --allow-unsafe-features" err
+	)
 '
 
 test_expect_success 'Y: rewrite submodules' '
 	test_when_finished "rm -rf main1" &&
+	test_oid_cache <<-EOF &&
+	Ymain sha1:9afed2f9161ddf416c0a1863b8b0725b00070504
+	Ymain sha256:c0a1010da1df187b2e287654793df01b464bd6f8e3f17fc1481a7dadf84caee3
+	EOF
+
 	git init main1 &&
 	(
 		cd main1 &&
@@ -4619,6 +4627,7 @@ test_expect_success 'Y: reference pending tag or commit' '
 	pending_tag sha256:85edc5eac315bc680677b2fc71622bd77476f057eb8dc8ed6a497803a24f1f46
 	EOF
 
+	test_when_finished "rm -rf reference-pending" &&
 	git init reference-pending &&
 	(
 		cd reference-pending &&
@@ -4656,6 +4665,11 @@ test_expect_success 'Y: reference pending tag or commit' '
 
 test_expect_success 'Y: rewrite submodules via stdin' '
 	test_when_finished "rm -rf main1" &&
+	test_oid_cache <<-EOF &&
+	Ymain sha1:9afed2f9161ddf416c0a1863b8b0725b00070504
+	Ymain sha256:c0a1010da1df187b2e287654793df01b464bd6f8e3f17fc1481a7dadf84caee3
+	EOF
+
 	git init main1 &&
 	(
 		cd main1 &&

-- 
2.56.GIT

