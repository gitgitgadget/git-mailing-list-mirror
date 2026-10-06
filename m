Received: from mail-dy1-f174.google.com (mail-dy1-f174.google.com [74.125.82.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F07FC3B7749
	for <git@vger.kernel.org>; Tue,  6 Oct 2026 10:15:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791281717; cv=none; b=Tia+9F/P/Ld1WGWcY9+kd7zyY6pMcdHlFxMEoaNEp5A54xhJLvR4ngSDpiFeXcrDOcK7R97OZRMPYYMTAQEcf6+cbFrxwveAplVuh9K/TtQHyv59uZLAbuSesI8bJ4wJIsRiLlPI+qHDeV2Lo2WMm3CSe2nUl6wz0Lg3+KMGTnw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791281717; c=relaxed/simple;
	bh=coBWLVyDEpntSd7q2+dPmTltSD0twopzcP2Or3Ov0BQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CW/t9otjDP/hErj71WoSivpeFNCohJFaqS9rODMB9SbTxldJMhlsA60ANoRpnmv4PPtkLY6EzFpgMG0zk7Gns2jd4+4+zSCukcpBfb8Uc7fPKNFpneowV+vFwr/h8YIvcfqTF0HvW/a4q69RERQgBxnJEOR5lVwV21BffIaUAdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bSsLIYoo; arc=none smtp.client-ip=74.125.82.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bSsLIYoo"
Received: by mail-dy1-f174.google.com with SMTP id 5a478bee46e88-35127e848feso686902eec.0
        for <git@vger.kernel.org>; Tue, 06 Oct 2026 03:15:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791281715; x=1791886515; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=GHviLt8aH4t89coZSGaJW483KQ+3NX5nzJhZTN11Sg4=;
        b=bSsLIYooJgez3Bl8CPEHOELd3V4RKwp64IGv050v/un95IiTnJuBhnxHkPM656KBhF
         vcal9ls2nCME32UkAxm5TnK9kw0iSE0d/NJmmVqpaWRAyDKJz3TO+UOm/7pK+9UdU6jg
         HkHVzQeZy6CINj8zbASwp1aKeWhC6/9cV7VVY12BTWzoYZRS5rfMTjNildbUoVh9hPQ2
         oUNo8jK5Wo3fxNlR1Ger4sJteKeNMNUxOFgfFHxOeTbf4YWuK8vxd+qEWRxLiZfPKhBe
         CZ8DLRZtTG4RzJAWI6XvIwHovswWvJbi/Ybfm/rrJ+aGhrEApjvo0lg93ykNKPXllaCj
         M0tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791281715; x=1791886515;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=GHviLt8aH4t89coZSGaJW483KQ+3NX5nzJhZTN11Sg4=;
        b=O86WIF1uSZRwqWcQF5YcYSGpCmt6xBnZyA35301/u4ctuuEpXrm3KDA7HIZUfwj2+O
         lB10UsXCLrCMaJmDUyw1wBGWttca0QHvo4bY7eN61xqJwDrlLMmihdwb7yM+cK6mjUTI
         dtwzOvgilcqcNZzIvmicVMfG40JmUtYXtRXj+72LPNpZoynIIPLec4Yng/ivQfi3Bl5j
         BrEKDB4OfYKqIivoSQC7Oh0dSl1HX9uZ5aUjSOF4CbTf8kb6zCDAdb8+OH0OGlaW33cS
         bdOBakD8RDO6x61tMVYeOYlJanZjx8XO083gV3V3ezXxsM1ahNUgUBpcIuQ6NO4LLetC
         Bdug==
X-Gm-Message-State: AFq9FYJj48LgrLnKe5wQM56uO5Tnm4LVHrPdSXVsAgNugKClLLx+rJl4
	0S46xp0FMB+tSf8l0dhx09Jz9ggLStVfCd6ixK1wrWCjg2HfO5nWMU98BKnu9Y1f
X-Gm-Gg: AYBFou1vSl9di3SYAp2tuacLZC+WKetT04bDjG5XlnCfARCzkflFXs9ijSOfqykXOem
	8ogTWg4FOtAIZJh2bGUYYCg1+rHTHWKnLpRe4TP2th7yH6x3O02e/konyg3F9c8rxpwcTzAgIO9
	uRdTgFULcag0bRMnfkzds4Rxh639wkLy6rUk87F7lpkojkCu6AaiC5QcZSnVvcVBf+PkJ70ds8A
	PzVQ53DBShlzM/M0sP242QlbRtfEA9e0KcxGRyVOWeFOBPbZFmPXZ2T0ENvwxy6yLRr/RkyR8hw
	JOoe8tsg0PTmc30jOlKF8dgHTTjP5AWuiPe7lszatXTaOk+FcNtSV5nJnryUosRyVY1470a4s/w
	v8cz/JkRbKYUplq3StZCohigIZrrhFI4ALeDtAD/LGqGqhGVYu6wK/KF7gJQNcYRjOWKrvc+cBo
	txZuNUDv82VA/7tGakNXZZC6HCrpueawJZD5yRHUzMLwshTIIzT3O6NHQXyW4SLtAYuBuPfhNrX
	pirbg==
X-Received: by 2002:a05:7301:d183:b0:33b:ddd9:c2a1 with SMTP id 5a478bee46e88-3514df9e706mr1168892eec.20.1791281714943;
        Tue, 06 Oct 2026 03:15:14 -0700 (PDT)
Received: from archlinux ([2409:40f4:2009:2018:2cc2:70c5:c30d:149c])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-351469fa189sm7292964eec.6.2026.10.06.03.15.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Oct 2026 03:15:14 -0700 (PDT)
Sender: Dilshad <hello.dilshad.in@gmail.com>
From: Muhammed Dilshad A <dilsheddilu123@gmail.com>
To: git@vger.kernel.org
Cc: Muhammed Dilshad A <dilsheddilu123@gmail.com>
Subject: [PATCH] t0450: use test_path_is_file and test_path_is_missing
Date: Tue,  6 Oct 2026 15:44:58 +0530
Message-ID: <20261006101458.604775-1-dilsheddilu123@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace raw 'test -f' and '! test -f' assertions with the test helper
functions 'test_path_is_file' and 'test_path_is_missing' to provide
diagnostic output when an assertion fails.

Signed-off-by: Muhammed Dilshad A <dilsheddilu123@gmail.com>
---
 t/t0450-txt-doc-vs-help.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/t/t0450-txt-doc-vs-help.sh b/t/t0450-txt-doc-vs-help.sh
index 55c0fb3cb7..a2da2b0192 100755
--- a/t/t0450-txt-doc-vs-help.sh
+++ b/t/t0450-txt-doc-vs-help.sh
@@ -116,13 +116,13 @@ do
 	if grep -q "^$builtin$" "$TEST_DIRECTORY"/t0450/adoc-missing
 	then
 		test_expect_success "$builtin appropriately marked as not having .adoc" '
-			! test -f "$adoc"
+			test_path_is_missing "$adoc"
 		'
 	else
 		test_set_prereq "$preq"
 
 		test_expect_success "$builtin appropriately marked as having .adoc" '
-			test -f "$adoc"
+			test_path_is_file "$adoc"
 		'
 	fi
 
-- 
2.55.0

