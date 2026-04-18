Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C5782F3C0E
	for <git@vger.kernel.org>; Sat, 18 Apr 2026 16:32:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776529966; cv=none; b=aPox+U5XaeBm7UfL99PhRe9fyB99DFwWZB+L96Y64gOT33Em8+GawBlf/6FtLBv0l2qplEE1pguXAs5bB9JBCT79xfxm8K9Rafng1Iltbc9epfmIoyTjVwfelSErMs5doZoFGp2KFRKDZJJ9KQHTbfvYW/ksSiSNOmewrOjTOtg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776529966; c=relaxed/simple;
	bh=yNuLhvo64K4Qaio9E7X88Ymmn4IeupJuOMguacg8w8E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=hExSFu7IepkNn8u8d9OrpYc8Xk1zpOmEcmZPnBr1xs0uQ8iWX3Wc2H4u+mWBVm8AAhwZ/NzT8kfwMJyFzSvgo/4G54E2NqJrlY/BM4TrNnx0X+LsgwqNk1Ta1XsaiFj++AHUkINr/vjsPNvwhqHM1fvR5otbEG8OlSUqenxGXoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kNvlJroS; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kNvlJroS"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-488ab2db91aso23619265e9.3
        for <git@vger.kernel.org>; Sat, 18 Apr 2026 09:32:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776529964; x=1777134764; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=y25CBzT38rsr/+/FHknJn3mM+gCrHLHtBqP2pYRpuLM=;
        b=kNvlJroSvDqohDNzoqu+Yv/KiJTpcDwVv4CwNIhrbtjmKdW9PIH1G6mk0tI9tQITIf
         qhP3GTAzov7jMJryYMdblVEBDsDobtMvDBNfQK/uUcZ3uqnXR5vFFw9HVyy8eDfgTYg0
         pxmZzFlk01nIDXpoTzg7RJ46HLi9EQ58pD6afuUKxlh+LnHAMpbd69vhsj1MNfOU2AND
         1LqnJJL/DLG8zB1rLYf+esCYeQ2ERAz5NgWUnLIX3vLSM6Lz1bu500xyljaGl8NXmvNh
         QJFYDHCkeEWbbrJf0GgH6FDBBXeKG6JmRvWua1dciA1ytJ+M8TC/t8sk6JVHpZjYmwWG
         QF7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776529964; x=1777134764;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y25CBzT38rsr/+/FHknJn3mM+gCrHLHtBqP2pYRpuLM=;
        b=D+ayi0fKPmXPIU7przkDDG4Z2hhcAh41Gg1GpCeimdzQrWqBztlogyrkcPI9N+FnOs
         yri759/PSp859Yw1MiWdf5Lq7XES6GN1YdbbjeVlCJEpxxIs0nGqEOEToCtRPjyWDG8E
         d187XBqdvit+UMbo2haL6DoxSCGaKCyhkSVWKPvmS07JRzydIifEjYpVwKSBvNjxht4i
         Nkapj4D/DO02muSDNeeRLZfgLivP+XaT/yQaTjbsMiD0m8k5yCOiNY6zkBou4QY1irQ9
         A/bN99IvsnUG8Z2TCmkzEU2vYkoekerbGcz4RTwAcyJ0J4tqBUJyIluMuta0qPbJ6JwN
         9FDQ==
X-Gm-Message-State: AOJu0YwdZE2uNo6ZVLHn6DLMFYfQFKrxOqDm1rvKIH12UsvalxIDxu/L
	XscRtjk96bApygdO3HDVaPdmGfGn8/Ojq41JDTFHanzQl+27pKevTKIlBUxWXg==
X-Gm-Gg: AeBDievb5DxcgZboZRm0KUEWKfudd87hClFoiYNnWdLrAlzY02SNP2TRSX3EpURu8GM
	vyR2TmgoTF6b8l7tnNaGwWxgGQvFOgCbW/1XU3SH09KvEnqyMIj/FShhWZKqX3F3j/DSiBu26lk
	1o2HMvhd7ynyUCq9wRaE47TbqN54DGlW+MVOdGboPk9Xrol461szI3M5RFcjBEFUmNQkUTeFmX6
	grl/MLFar55EOzAmsk0yQJAwXAgJ8VlSuvdbNxHo962fRFcu8PFzd46664ixItCRktBGeSVHzsC
	CLIaDcZjimz4wQ5t3Hc1WaDNf6pCBiW8lLhzHG732BqWRLqjS302dMIIvsvWRIZUCM/hFGLUOpm
	MrbqeDKmPzI5Hj4EzHdxfjpfXqvDGnxnDlIDtKWx7pp4SkzudOIUWoAAJqcuyccvr9FkdMNqECO
	6+aRwqFaqmr42Y6uiBLVbh7r3YqtrSC/X7w+MBwEZYwrsBj/PeUqcJaTIysUSTiTViEqegVsczx
	g==
X-Received: by 2002:a05:600c:4fd1:b0:488:78f2:6b0 with SMTP id 5b1f17b1804b1-488fb78ede0mr101915935e9.29.1776529963512;
        Sat, 18 Apr 2026 09:32:43 -0700 (PDT)
Received: from localhost (94-21-146-148.pool.digikabel.hu. [94.21.146.148])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43fe4e4633bsm13834608f8f.26.2026.04.18.09.32.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Apr 2026 09:32:43 -0700 (PDT)
From: =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To: git@vger.kernel.org
Cc: =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH] t6112: avoid tilde expansion
Date: Sat, 18 Apr 2026 18:32:36 +0200
Message-ID: <20260418163236.2382826-1-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.54.0.rc2.650.gc37764ecfc
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

e987df5fe6 (list-objects-filter: implement composite filters,
2019-06-27) introduced a test to "t6112-rev-list-filters-objects.sh"
that checks the output of a Git command with the following commands:

  grep ~$omitted_1 actual &&
  grep ~$omitted_2 actual &&
  grep ~$omitted_3 actual &&

Since the leading tilde in the pattern is not quoted/escaped, it is
subject to tilde expansion.  So if the system has a user whose
username happens to be equal to the content of one of those
"$omitted_*" variables, then "grep" would look for the user's home
directory.  Luckily, those variables contain object hashes, so this is
not very likely.

Furthermore, Bash versions v5.0 and earlier seem to be buggy and don't
handle this particular tilde expansion very well, and either segfault
right away or, in case of v3.2, get stuck in an endless loop and
segfault upon receiving ctrl-c.

Quote those words starting with a tilde to avoid these issues.

Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
---
 t/t6112-rev-list-filters-objects.sh | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/t/t6112-rev-list-filters-objects.sh b/t/t6112-rev-list-filters-objects.sh
index 39211ef989..e0a825bccf 100755
--- a/t/t6112-rev-list-filters-objects.sh
+++ b/t/t6112-rev-list-filters-objects.sh
@@ -623,9 +623,9 @@ test_expect_success 'verify collecting omits in combined: filter' '
 	omitted_2=$(echo a     | git hash-object --stdin) &&
 	omitted_3=$(echo abcde | git hash-object --stdin) &&
 
-	grep ~$omitted_1 actual &&
-	grep ~$omitted_2 actual &&
-	grep ~$omitted_3 actual &&
+	grep "~$omitted_1" actual &&
+	grep "~$omitted_2" actual &&
+	grep "~$omitted_3" actual &&
 	test_line_count = 3 actual
 '
 
-- 
2.54.0.rc2.650.gc37764ecfc

