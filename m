Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24DB46FC3
	for <git@vger.kernel.org>; Thu, 12 Feb 2026 05:45:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770875140; cv=none; b=mcLUuMvsi2pmwqyWfhtsSjo91vAX+F0KSXSpmyP84BWQwbmnsV8FwM9L/X4DQpUURu/+vXt/HIPH4pLZHErxGdAMHPNrFGTMjPSFtzkuoRN5ZFE6PErghy5bmjCvbhozaQBv9Qyvxi1AN4HU7Ex0wFh/czX7Vu4FQGXTHvfWymo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770875140; c=relaxed/simple;
	bh=sPnpyU+nCurqAZofQKcnwd230X0erYfmJXLcXIB3ASk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=VI8KrGTKJmE6J0MgrLjOcE/4+qpyqmEFE3eXI+x4mMIq6bwxp8UZCH63m8BE1P7R1hgYpNPq8VZtr0WEMjfGoOR+K1bRLhQ5BOEHoCh4wEx5fp+osmu0Ai8vk7W49PIF3bIRwT43xSFh+JO+lybT4cYM/KdUYRprf5fiUTrwp1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hwXKftJd; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hwXKftJd"
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-c6de13d9ebbso1332111a12.3
        for <git@vger.kernel.org>; Wed, 11 Feb 2026 21:45:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770875138; x=1771479938; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=KD/1b2joPaUmsY6saeeZmMlanGh+toRpgIgoVrr/ON4=;
        b=hwXKftJduklilnDMdmjggO1ITaU1k7GnJOtB6eoGbZRuSCiZo07FlZ2LxtP3okbp5j
         MyMgBLkzdjZrl+NZlmD8J2YQPpN7V9fhOl5+rIuh4NzLZnRlGRqqlfogLrwuG9qEkgdM
         f9po75l8hi4G4Q14ouCcjCublg3nCY/uyxqBDBkcKBvYpdkHc69Aq+ibjrBB+z3mDN4E
         GwBM7vnyLT7nqalDk45sp3THsLLisUomopiK1w3ZM7udjvmUiGvdq4/r5Az3YYU/O4uS
         UADshvw7STm3Uo/W+x/OlTjfU+JgoFC14Zg+u4ga6RVErTUVXN0MFqjmnBdiYfS02kx0
         j35w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770875138; x=1771479938;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KD/1b2joPaUmsY6saeeZmMlanGh+toRpgIgoVrr/ON4=;
        b=C9spNgf4uAFeQykNxGxKuAJAGiL1dzwiQYwE2pf4mQ0GR0C38faSdK1AyQqjR9MjlV
         SPxWmuuDD9PuQkdy8byslixvzMnYcAB48WfJ9oUjI7cAlBz32G242la65sqLdT021veV
         /QXbYX3Fi3P8wUoJ05JVgPoVA0JgMq2Bq3jvJaUQuDWWJaKyd3fgAYmmjhbyN6q9i6PT
         rH6jsswEFq7teYf25DccaoKH88TK5AE0Uy92G+LDnghifkRTniEbtjRRj9ocn5m5YawS
         CzAtSfwl5vDCr3HL440Z0DDSvXCwr/ZTF0scf7uL4S+SoB7hMSEnR/EAR2+cDTBOEwDN
         6qEA==
X-Gm-Message-State: AOJu0YymdFAen2yf56dGLJdqY2SlMivHa8Y6NaN9vNUsWy4rxHsMaqF/
	2nD7L5JVGh3z7RaqkvNOLmVWiBgIBzTegfcnBWCFoZJQkwbqG3fvwpQkSUfm
X-Gm-Gg: AZuq6aJdubZiZan3rdryYd16mtGNNn6Wedp5vJoxDIW0kC6PW3qfueA/kgU39rwnE2E
	ZSMR6Nlb9CIdWkv1uIa4NnhaHmQ3fhjlEcEdTFArBuZkej8BIHsHd5P0IXESDgRxYlfguhoDxvX
	L5dEyVxrlGT3LksQhYNPEnjh+pRDhAIbLLd8xG6yk+rNZwpxdP0ucVVvieBtF+quIi3pC8RamW4
	0dajTRmu9xj3xIJxWzT7r8OjxwB4+6j3eICq4Y5m/HN9xj103SOvtmClsBowDG+MBqiFR+JA0NY
	AmawzU6cXQHxeKw1Fu7Ry22JdH0N2JMAPLPTEDZBi1BGn/u0uABwDhTE4S1MBHXGujfdKgZReqm
	DIQuElJK81zZ1NqFGBTcpz4AeeCgiC0ZmgAShTtSw/07znFhn+71+iMkTNPS0sdS8P9OKMHbdkx
	Nm/LaxNRYVsvxr/1Cn7i1rMvlBHgvJUGqX+r3+7aIn8EWOz7/YHHjCI4xjy4gsbyFpagEIpLZjE
	sCtPVUH29Y=
X-Received: by 2002:a05:6a21:33a2:b0:38d:ecd6:60c with SMTP id adf61e73a8af0-394489b386bmr1902588637.77.1770875137906;
        Wed, 11 Feb 2026 21:45:37 -0800 (PST)
Received: from SLB-94V8GY3.dir.slb.com ([152.58.32.239])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c6e1967ca7esm3695905a12.3.2026.02.11.21.45.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Feb 2026 21:45:37 -0800 (PST)
From: Ashwani Kumar Kamal <ashwanikamal.im421@gmail.com>
To: git@vger.kernel.org
Cc: gitster@pobox.com,
	Ashwani Kumar Kamal <ashwanikamal.im421@gmail.com>
Subject: [GSOC PATCH] t9812: modernize test path helpers
Date: Thu, 12 Feb 2026 11:15:30 +0530
Message-Id: <20260212054530.4763-1-ashwanikamal.im421@gmail.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace assertion-style 'test -f' checks with Git's
test_path_is_file() helper for clearer failures and
consistency.

Signed-off-by: Ashwani Kumar Kamal <ashwanikamal.im421@gmail.com>
---
 t/t9812-git-p4-wildcards.sh | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/t/t9812-git-p4-wildcards.sh b/t/t9812-git-p4-wildcards.sh
index 254a7c2446..e91004ee79 100755
--- a/t/t9812-git-p4-wildcards.sh
+++ b/t/t9812-git-p4-wildcards.sh
@@ -30,13 +30,13 @@ test_expect_success 'wildcard files git p4 clone' '
 	test_when_finished cleanup_git &&
 	(
 		cd "$git" &&
-		test -f file-wild#hash &&
+		test_path_is_file file-wild#hash &&
 		if test_have_prereq !MINGW,!CYGWIN
 		then
-			test -f file-wild\*star
+			test_path_is_file file-wild\*star
 		fi &&
-		test -f file-wild@at &&
-		test -f file-wild%percent
+		test_path_is_file file-wild@at &&
+		test_path_is_file file-wild%percent
 	)
 '
 
-- 
2.39.5

