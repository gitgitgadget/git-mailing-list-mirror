Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19C7A14BF92
	for <git@vger.kernel.org>; Sun, 15 Mar 2026 08:11:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773562265; cv=none; b=KtrdaYdTW+HUqgKpkSeOFHPepfAs9DdhJBBp33H/KF6uWgNLuB6ix0MHLpyAvYXaJGZRbSyHMs/Jnor0TF15pwzZPq7xpPwYQe+17DCw+55GWn2L7fZoAc13Z7eJCLIVh1l3ZqijbGaLfu2BtdZm0h22wQBk0oAFja94qepgHy8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773562265; c=relaxed/simple;
	bh=MymvLHYobwdXrmraRsMncmKWPt+rU8XxGBbOP/BPRUE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=F8A2QRRdV3MSZN751EgyARckcYKo0HWwo46GlmHNGnGAIt/Jm0Eh+Py57+ZIW8F58lu7uby7SvPj6skO5mZSJv4u4nbk7+uSiqSaGgLGQ5c+9R5QEUzJcIAohJ8VSmJN+73R5jDa2y8OA2utu81x2Rw3yDI50zUU1DhK07hcrP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hq7Az2Ci; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hq7Az2Ci"
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-c73c990a96dso1286522a12.0
        for <git@vger.kernel.org>; Sun, 15 Mar 2026 01:11:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773562263; x=1774167063; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6iANwMsVCXVPQU5EQ5zr4XzFkN3sfoea4uuAabTCikk=;
        b=hq7Az2CiM/zH1Ot/hlVWnR3chYHN4YctZHW6k82Lq8v3QskNbho0a8koF8VWcngzgX
         eNarVpigh3UFa5ussq/XWvy2bzXWM149uixkEoZCAQ/CpQiIkEszfwDm0+PUMl6ynMTC
         FO6fsqJSaq5y4HLww7XlVxkz4aOFewQ6m8jqzlnia19KGZxosF+ro3mq+jDHHV3/OCTj
         +zmqNo+/ZNMMuzDKQAFzrY6AiSoFTn/th9rOA8TJy8rupAke/Vl/63G1dglfrqyMnNOG
         yh+zUnYnxCXxBsHz39Q7qLQ+jsNMCfG+3sXo1+ccG4FoJ6jQvIhn0bZOLbaP/X3XcKDO
         bnRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773562263; x=1774167063;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6iANwMsVCXVPQU5EQ5zr4XzFkN3sfoea4uuAabTCikk=;
        b=J5H/yGgvRHxlJ02sHjd3VECSaTRmi0rxOpKyzIbTHGxjR3Tkmy2V9U360kAkThVF6z
         7hqbgTHA3jeJAaI2DLHC4ri2NYcBSNv0HjMtupNoh31z4p2WnhsrBmXBOEoIO/uYRUd/
         OwmRlZZw4DOrv5t0KdAZti9enSUsOBJDZTjN8sun6+pQ45lNDxUqj7kcCET/SHfet3D7
         6oRygYyGt00MQzn8sWrky9HCXzjOKfru2BE+UYBl4/kyl2tru6p7YtkR+QDLCDlO/gC/
         sFJAm6ZOC0ne6EYL/qk6sbccCY3lJHEhKdtOLioNCY6VNX+yS2VtzEr9aWPugMeUhjal
         rX2Q==
X-Gm-Message-State: AOJu0YxxfhBYZ3NjAzlbeJ+Cyph8uU5SJVcpXyg6RbOP+YhR01wHEatb
	xpxqeFa2Xb4EKfCUzxpOC8iwTO3coDqBQO0ub3ioH6z89niaJFUHyKvcm+GahdHg
X-Gm-Gg: ATEYQzwqAEv9rxAb+URYNiM2qg9hXu9SdPas7xTII9H9s0YGv/nMd4QQJKr1P5ioP+n
	VA+2X8sox4dMMSIXHd9nbViH2J88EZKDJ6Lug8GOgt+4XAiq4sOzNiEZ/HXYOLY8ZQz+I/1IHZX
	Q+PC2svqqDTofARd/so9LiR+F9kIbcPZTE7gwZv8zg2bZDUitzA/vBOmXHVqwRu1VGi2OeTn6ZR
	5Lq7dJNtjQy/VeBWTvJlFOoVE5JxWSjIQxUJiB6Y35lmL8hUwVctGcnj3BGCCRtRW4aG2tU19ID
	IRTxOMR6CY8Vd1ACp0+vOdclR46w2yZjlJGZFml1tbM2/s4zA/bhRBeKpsD6UA7rHlMpeCwOZDZ
	WHPTzY1+hy3YLTOwZYLLy6RHbvIB3MW3gHbJeJUsYKiEuPj35bD8i+OKuJW8oAFSYz4FWOsiyLZ
	js9qr6blPi7AdveKkika/rmlWOwxFZUKgViro+oP8rzG3kPnP/0WEcTUJ+D+V8XgGyG43VYnq26
	TE+hrRpduaTvRb6
X-Received: by 2002:a17:902:f70a:b0:2ae:3bb2:a8cb with SMTP id d9443c01a7336-2aecac49127mr93880535ad.40.1773562263297;
        Sun, 15 Mar 2026 01:11:03 -0700 (PDT)
Received: from localhost.localdomain ([2401:4900:1cd6:3841:bc6b:8052:ee17:538d])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2aece81cde8sm73436125ad.70.2026.03.15.01.11.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Mar 2026 01:11:02 -0700 (PDT)
From: Ritesh Singh Jadoun <riteshjd75@gmail.com>
To: git@vger.kernel.org
Cc: gitster@pobox.com,
	Ritesh Singh Jadoun <riteshjd75@gmail.com>
Subject: [PATCH v2] t/pack-refs-tests: use test_path_is_missing
Date: Sun, 15 Mar 2026 13:40:32 +0530
Message-ID: <20260315081032.497-1-riteshjd75@gmail.com>
X-Mailer: git-send-email 2.46.0.windows.1
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The pack-refs tests previously used raw 'test -f' and 'test -e' checks
with negation. Update them to use Git's standard helper function
test_path_is_missing for consistency and clearer failure reporting.

As suggested in review, replaced the negated 'test_path_exists' with
test_path_is_missing to better reflect the expected absence of paths.

Signed-off-by: Ritesh Singh Jadoun <riteshjd75@gmail.com>
---
 t/pack-refs-tests.sh | 28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/t/pack-refs-tests.sh b/t/pack-refs-tests.sh
index 2fdaccb6c7..d76b087b09 100644
--- a/t/pack-refs-tests.sh
+++ b/t/pack-refs-tests.sh
@@ -61,13 +61,13 @@ test_expect_success 'see if a branch still exists after git ${pack_refs} --prune
 test_expect_success 'see if git ${pack_refs} --prune remove ref files' '
 	git branch f &&
 	git ${pack_refs} --all --prune &&
-	! test -f .git/refs/heads/f
+	test_path_is_missing .git/refs/heads/f
 '
 
 test_expect_success 'see if git ${pack_refs} --prune removes empty dirs' '
 	git branch r/s/t &&
 	git ${pack_refs} --all --prune &&
-	! test -e .git/refs/heads/r
+	test_path_is_missing .git/refs/heads/r
 '
 
 test_expect_success 'git branch g should work when git branch g/h has been deleted' '
@@ -111,43 +111,43 @@ test_expect_success 'test excluded refs are not packed' '
 	git branch dont_pack2 &&
 	git branch pack_this &&
 	git ${pack_refs} --all --exclude "refs/heads/dont_pack*" &&
-	test -f .git/refs/heads/dont_pack1 &&
-	test -f .git/refs/heads/dont_pack2 &&
-	! test -f .git/refs/heads/pack_this'
+	test_path_is_file .git/refs/heads/dont_pack1 &&
+	test_path_is_file .git/refs/heads/dont_pack2 &&
+	test_path_is_missing .git/refs/heads/pack_this'
 
 test_expect_success 'test --no-exclude refs clears excluded refs' '
 	git branch dont_pack3 &&
 	git branch dont_pack4 &&
 	git ${pack_refs} --all --exclude "refs/heads/dont_pack*" --no-exclude &&
-	! test -f .git/refs/heads/dont_pack3 &&
-	! test -f .git/refs/heads/dont_pack4'
+	test_path_is_missing .git/refs/heads/dont_pack3 &&
+	test_path_is_missing .git/refs/heads/dont_pack4'
 
 test_expect_success 'test only included refs are packed' '
 	git branch pack_this1 &&
 	git branch pack_this2 &&
 	git tag dont_pack5 &&
 	git ${pack_refs} --include "refs/heads/pack_this*" &&
-	test -f .git/refs/tags/dont_pack5 &&
-	! test -f .git/refs/heads/pack_this1 &&
-	! test -f .git/refs/heads/pack_this2'
+	test_path_is_file .git/refs/tags/dont_pack5 &&
+	test_path_is_missing .git/refs/heads/pack_this1 &&
+	test_path_is_missing .git/refs/heads/pack_this2'
 
 test_expect_success 'test --no-include refs clears included refs' '
 	git branch pack1 &&
 	git branch pack2 &&
 	git ${pack_refs} --include "refs/heads/pack*" --no-include &&
-	test -f .git/refs/heads/pack1 &&
-	test -f .git/refs/heads/pack2'
+	test_path_is_file .git/refs/heads/pack1 &&
+	test_path_is_file .git/refs/heads/pack2'
 
 test_expect_success 'test --exclude takes precedence over --include' '
 	git branch dont_pack5 &&
 	git ${pack_refs} --include "refs/heads/pack*" --exclude "refs/heads/pack*" &&
-	test -f .git/refs/heads/dont_pack5'
+	test_path_is_file .git/refs/heads/dont_pack5'
 
 test_expect_success 'see if up-to-date packed refs are preserved' '
 	git branch q &&
 	git ${pack_refs} --all --prune &&
 	git update-ref refs/heads/q refs/heads/q &&
-	! test -f .git/refs/heads/q
+	test_path_is_missing .git/refs/heads/q
 '
 
 test_expect_success 'pack, prune and repack' '
-- 
2.46.0.windows.1

