Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8F423B7B79
	for <git@vger.kernel.org>; Fri, 13 Mar 2026 16:19:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773418754; cv=none; b=j5iZwc98Ej92m1r0KEi2N8jlfDw+iWhBDpTTwRREs+ieM960IQtN56m6dphaMygnsvdmrYgsjKRXZOIJQ6anifTlcAmHXWbGSQjmUHY2w69TDIpiPLxK4+tOJkQaabSlRcN6UO99zHYfiSu5fVE2L4yY5PGzgmxgMzZ0Ro7oTGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773418754; c=relaxed/simple;
	bh=+ixPbwo4zTDqO/vdKdw3m9DoFA8/mZLtHnfGzR8xMeE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ohXqe9wZzQiouQRiDiskmzUFL5UQqjLeUk2wONXn077NxIvwxEp+M2MkNgVYRBd4JSUu6MY2Cl6AkLyK8aThxfcPX6enLaxVqw2wLvtaH/rz8CCTrFGrIvSwUtCeZ9vWukukl5dpVRId4xuByGiuxRQ7hAc7VrRpGHkh9FJ2IyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Nx5WDqCI; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Nx5WDqCI"
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-35a17791284so1267306a91.2
        for <git@vger.kernel.org>; Fri, 13 Mar 2026 09:19:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773418751; x=1774023551; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Ft5N5D7ycWvkafwuMBtcjGou+4Cudot/UvRd3fAWBfA=;
        b=Nx5WDqCIg9X77CttPKDSAvpDSCsAzOpojLpsc4BMU2zmekk2qYMtJ+d3R1a5AaG1th
         CHBKj5paU5B+DpP2uAWYoxM/ilc+G9C8NnERb3PZp+Ks7/YoIvWtaYieIbMRpPtWsmRJ
         /WQsY5SoamwFmKapJohMHisnULmwNA7wyBm7X2c1gbfY/Fb9PmQsPUAZ2PE+PGp/NxS4
         dSgRZDy2o19CgWKaQ/pdNfTgxZNl4dMyv04vJwIOIUm7S0M4/PiwkLhjengt1AeXeGOf
         eIx1ljZI/m2w1y5Nc27f6laDZgx8PHtzvOb/xinf8K/mDUGdD4oNPEBD6ObbI1jiIPrt
         QgHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773418751; x=1774023551;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ft5N5D7ycWvkafwuMBtcjGou+4Cudot/UvRd3fAWBfA=;
        b=AeW10H5AWZU+is5gJ9mK55ukAaElJoZ5jBxHlTne3vb02gh+7xeOC6ZN+WoBfLg/H4
         N2jytthPv3zH/R5kfoepCK2ztSC6LWXUF/R1cluzQAF0LDfmGbXsLTGjuN2GwPstMrA0
         SHswldOgpDT+ALTsRaYRyxPmUWsYq940wh/3iTwxAy63TZBSYB+wkt7QKl9aeUD2PsZ2
         Ivq0wrmCfj48gpB0hM07ysZj00V28nL5fapW/EhiLxu23y7fZe4c2eYx/bgBorfFVDqd
         2DIUaZ6m9cmdUK5MyvnY0o0aARqHODd/L57fBZJJz/vZ/VHXvIwQOaa52PMPigsju8X1
         trDg==
X-Gm-Message-State: AOJu0YyKp+RZpUfQ5xkRoOm+9Tu/V1qyB2yGPUWqUQgyaiLIjAvnDvgH
	E1Y8uZAiNEZl7HIdA590i9f5/TvvNfm25WnxaY0II8b+9NEHYcTNjmASJmxe0zw0
X-Gm-Gg: ATEYQzzc+FL5vzwy9zxgkdZ7NbGzp2QFSHxBEjMvolVhdW+5glsp7qUD/rImYp6MTpt
	ssSWle8a8yWeENA+sQx57fDxH0qwkwfjy/NorgwdSr7c/hKAj0ljNXduTvy/KKi9UisZRmQqXe8
	feTa1/53c00g5IeBxsp/LZmC+yhQJiFthOykOg/cq0JnUzWB41zqIrx46KnjPd/eURMZmkmHlUf
	EW00FQoXNsxanx7mFNTbxpPHzFLRF7Z/3sOivEb2y0NEoUpqMfll7wXjiwWSsHM51zMO8GnhkFh
	72W9rmoXB3753xjV5KTD5bTt89LxPKXuB8gQhi/xIoQn9BQtB20hVY4zqiwtUepEjlvrCdbmxHh
	ava1IaU3LAhMqDjuGIAPOjrGzAB5epZrbvGfF1cRiVL4C58iOU/Go4G2JDc2UVrPdqcsr/ul0JS
	JlfMLJO2Hk811eRN5IOLDYGlJMEUEX4LwLt8Ditc9LwgR4QPDa91MtH8L3dMbdLvHCCVFQjGerI
	xU8
X-Received: by 2002:a17:90b:3c8d:b0:359:8749:cf93 with SMTP id 98e67ed59e1d1-35a21e1cb62mr3762402a91.1.1773418750766;
        Fri, 13 Mar 2026 09:19:10 -0700 (PDT)
Received: from localhost.localdomain ([2401:4900:1cd6:7137:9d5b:f334:52e7:a47])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35a02fc845asm8932162a91.11.2026.03.13.09.19.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Mar 2026 09:19:10 -0700 (PDT)
From: Ritesh Singh Jadoun <riteshjd75@gmail.com>
To: git@vger.kernel.org
Cc: Ritesh Singh Jadoun <riteshjd75@gmail.com>
Subject: [PATCH] Modernize pack-refs-tests.sh with git's standard command like test_path_is_file, etc
Date: Fri, 13 Mar 2026 21:48:08 +0530
Message-ID: <20260313161808.1242-1-riteshjd75@gmail.com>
X-Mailer: git-send-email 2.46.0.windows.1
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

---
 t/pack-refs-tests.sh | 28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/t/pack-refs-tests.sh b/t/pack-refs-tests.sh
index 2fdaccb6c7..dca0c77ca1 100644
--- a/t/pack-refs-tests.sh
+++ b/t/pack-refs-tests.sh
@@ -61,13 +61,13 @@ test_expect_success 'see if a branch still exists after git ${pack_refs} --prune
 test_expect_success 'see if git ${pack_refs} --prune remove ref files' '
 	git branch f &&
 	git ${pack_refs} --all --prune &&
-	! test -f .git/refs/heads/f
+	! test_path_is_file .git/refs/heads/f
 '
 
 test_expect_success 'see if git ${pack_refs} --prune removes empty dirs' '
 	git branch r/s/t &&
 	git ${pack_refs} --all --prune &&
-	! test -e .git/refs/heads/r
+	! test_path_exists .git/refs/heads/r
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
+	! test_path_is_file .git/refs/heads/pack_this'
 
 test_expect_success 'test --no-exclude refs clears excluded refs' '
 	git branch dont_pack3 &&
 	git branch dont_pack4 &&
 	git ${pack_refs} --all --exclude "refs/heads/dont_pack*" --no-exclude &&
-	! test -f .git/refs/heads/dont_pack3 &&
-	! test -f .git/refs/heads/dont_pack4'
+	! test_path_is_file .git/refs/heads/dont_pack3 &&
+	! test_path_is_file .git/refs/heads/dont_pack4'
 
 test_expect_success 'test only included refs are packed' '
 	git branch pack_this1 &&
 	git branch pack_this2 &&
 	git tag dont_pack5 &&
 	git ${pack_refs} --include "refs/heads/pack_this*" &&
-	test -f .git/refs/tags/dont_pack5 &&
-	! test -f .git/refs/heads/pack_this1 &&
-	! test -f .git/refs/heads/pack_this2'
+	test_path_is_file .git/refs/tags/dont_pack5 &&
+	! test_path_is_file .git/refs/heads/pack_this1 &&
+	! test_path_is_file .git/refs/heads/pack_this2'
 
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
+	! test_path_is_file .git/refs/heads/q
 '
 
 test_expect_success 'pack, prune and repack' '
-- 
2.46.0.windows.1

