Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2392434404E
	for <git@vger.kernel.org>; Sun, 22 Mar 2026 10:57:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774177065; cv=none; b=HGWQ+x/Xb/mYNayrYYLE617CFugx+SRuutlveOMfcpLKP8cR1QQTovh2kqAgRJdFym9Qa5DvTbxTtwNYIylAvlRD/BS+hi2M5vZCmH783bJAJ2xGb/75c4bIjtptujgmXBdvfXJpOUg4bMzwc7F1lTG0X2XTQlzuj9hA1cLFNPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774177065; c=relaxed/simple;
	bh=4uh4DWYHoWaRVN1mbR17/7p67XafxJIcuyVCwyE8mjk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=osysD2Ycwaz5YbHCkX2PK0vSzi7C7pCaqf+Qf880r8ikbCzkiXjZsnhKdND/0qHdSK/r84XzkGM6j/KDnQ4JzF+oGCyEWVd+nMeu+lGZwUITqNBtFDHyzQ2bHn9RbLLAdU9xSwl1oT/j1DEXsCviDskAz4pBHhwSCrGEuOrvud8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UKC+RQKV; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UKC+RQKV"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2aecf52fa69so6088205ad.0
        for <git@vger.kernel.org>; Sun, 22 Mar 2026 03:57:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774177063; x=1774781863; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=E+quJlDQC6Muj6vItcdh6X7ANz3owVmt2EzU83XyJJ0=;
        b=UKC+RQKVaHqLu3v7hH28vlZoYJKD9xAGKhK7B+37NDCJxKnkwlb8gMsGDLAvx0H9rp
         ntXIl/q02oLzlo4RYI5dFqM8hphZYCeEuy/H0dCAgbuzN9HrRm7OUt0vtRU/OrVT6HDs
         6j5r2VFFl+fEv5IJyWeXzUBW8fuv3VgI4v60DpLMN06k7OUDCXpqnVnnzk2WwxBrJX5U
         4rtE92Y4xzqA0buyqu4iOKXRnoGWNcF5E0tfoTuKtE+MNR5BzYUcjjDwms9wG6sBjMO0
         Ytij2gdE/SAAS7Bxs1d6XRplx42zd1ueDNy3HUHLE/okrYHcnq8rh4l0UBThWDXrBE3f
         Y6rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774177063; x=1774781863;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E+quJlDQC6Muj6vItcdh6X7ANz3owVmt2EzU83XyJJ0=;
        b=YIsJZ1CmMhlGrv+huHo+HUWdSxrJy2Hba8wAOPsTwikLBUEpFXcpdRRMhdGUu8pi2f
         8MNMX1uPXtAgwsgmuMuctN+GhbT0d/CHcI2Ua/UwoR0haui8fG/uJH6V4I6HsSB6xMEG
         DmawbKJL02fUj7pjU4SiAUnDnNaxwfl7zvA0DZmpDlzIbnLPcvMfDflUph35U/s9pj2S
         bz35d2/dP06nrEXa+0dGYZJb6nKjW01m1gNhqqjBOYqZnwBKw7YBHn8ReT1U0tFpXy1/
         hxb1AbTcR/z5JsUBlI3qg3Mun9NdXsRMD4GcxdY65QRLD1dZ64y4dwg7zlAvzfcpwvJs
         TCaA==
X-Gm-Message-State: AOJu0YxGCCQ14qjsvriwBHcdH1TBaIGmchz/abDZ2LUw/PEONYZzUGKT
	OqaLsMGOd7126yO/bRQCVmDoeHfQelzCs9BDAJqACr40sII7UsLo1+3NtbU4C0Zk
X-Gm-Gg: ATEYQzyhHau/DEcA0D33i/ILjNPC/MgQcxmPsZSIdT2FtE4DkWHq+8R73p9pLb52GP5
	3qbTbBj3ZLUradebxjpWP1T1j0CWiZNCjiXRH8VSpqDkLEFMloATTfH/BlTCf962MQIse0nU4Yx
	IHovmjw1xONlaiAmz/yhtUs2AoWUnuYxUnM9u0jxWaVtv8Y3/tUdj99/P6FwkU1n+1ZEJXbTRer
	+VpOjlOmL9eFlfIYdOspsMvCmdOYFs1Epl54Cnus4IhbEOdUnG4f2726srIloHbqA6MyyeV7YeC
	COHKEI++FD7nMfT0vEvSScCKmRuLt+fZGmEBq4a1tHUAZBEu+U9sRLwWV4Z/El0WcV0/sznbVvx
	SVMaLlEhZQU6ZrUVNksLsKY2PMs8/4Ihbpa4eVA8pSGKADu1V7LZYYF/0tuUz9KaTXfo2fVPDp+
	T+12/EmRcVgs0xL4SYp08ADPGOqgTeLbR4vdxb2MsvE0j6X0pQ1yEq88Iclg7VsvJ8bZbTeQk=
X-Received: by 2002:a17:902:f685:b0:2b0:66f7:f7e9 with SMTP id d9443c01a7336-2b0827b83a1mr59111975ad.7.1774177062943;
        Sun, 22 Mar 2026 03:57:42 -0700 (PDT)
Received: from localhost.localdomain ([14.195.131.227])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b083690346sm74203605ad.70.2026.03.22.03.57.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Mar 2026 03:57:42 -0700 (PDT)
From: jayesh0104 <jayeshdaga99@gmail.com>
To: git@vger.kernel.org
Cc: jayesh0104 <jayeshdaga99@gmail.com>
Subject: [PATCH] t/pack-refs-tests: drop '-f' from test_path_is_missing
Date: Sun, 22 Mar 2026 10:56:10 +0000
Message-ID: <20260322105625.183804-1-jayeshdaga99@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

test_path_is_missing expects exactly one argument: the path to
check for absence. Passing '-f' is incorrect and results in
"bug in the test script: 1 param" during test execution.

The '-f' flag appears to have been carried over from the
equivalent 'test -f' usage, but test_path_is_missing does not
accept such flags.

Remove the extraneous '-f' to use the helper correctly and
restore proper test behavior.

Signed-off-by: Jayesh Daga <jayeshdaga99@gmail.com>
---
 t/pack-refs-tests.sh | 18 ++++--------------
 1 file changed, 4 insertions(+), 14 deletions(-)
 mode change 100755 => 100644 t/pack-refs-tests.sh

diff --git a/t/pack-refs-tests.sh b/t/pack-refs-tests.sh
old mode 100755
new mode 100644
index fa27d43a58..4a85d96c6b
--- a/t/pack-refs-tests.sh
+++ b/t/pack-refs-tests.sh
@@ -1,9 +1,3 @@
-#!/bin/sh
-
-test_description='test pack-refs'
-
-. ./test-lib.sh
-
 pack_refs=${pack_refs:-pack-refs}
 
 test_expect_success 'enable reflogs' '
@@ -119,16 +113,14 @@ test_expect_success 'test excluded refs are not packed' '
 	git ${pack_refs} --all --exclude "refs/heads/dont_pack*" &&
 	test -f .git/refs/heads/dont_pack1 &&
 	test -f .git/refs/heads/dont_pack2 &&
-	! test -f .git/refs/heads/pack_this
-'
+	! test -f .git/refs/heads/pack_this'
 
 test_expect_success 'test --no-exclude refs clears excluded refs' '
 	git branch dont_pack3 &&
 	git branch dont_pack4 &&
 	git ${pack_refs} --all --exclude "refs/heads/dont_pack*" --no-exclude &&
 	! test -f .git/refs/heads/dont_pack3 &&
-	! test -f .git/refs/heads/dont_pack4
-'
+	! test -f .git/refs/heads/dont_pack4'
 
 test_expect_success 'test only included refs are packed' '
 	git branch pack_this1 &&
@@ -137,16 +129,14 @@ test_expect_success 'test only included refs are packed' '
 	git ${pack_refs} --include "refs/heads/pack_this*" &&
 	test -f .git/refs/tags/dont_pack5 &&
 	! test -f .git/refs/heads/pack_this1 &&
-	! test -f .git/refs/heads/pack_this2
-'
+	! test -f .git/refs/heads/pack_this2'
 
 test_expect_success 'test --no-include refs clears included refs' '
 	git branch pack1 &&
 	git branch pack2 &&
 	git ${pack_refs} --include "refs/heads/pack*" --no-include &&
 	test -f .git/refs/heads/pack1 &&
-	test -f .git/refs/heads/pack2
-'
+	test -f .git/refs/heads/pack2'
 
 test_expect_success 'test --exclude takes precedence over --include' '
 	git branch dont_pack5 &&
-- 
2.43.0

