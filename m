Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D601F288C2D
	for <git@vger.kernel.org>; Sun,  6 Jul 2025 21:41:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751838101; cv=none; b=uRw1J8o+syaqvWOReHVQqvkFKwyjk3O1NFAZ55mUwX/jASOVfU3vp7q/AVPeX8FkVb+3dcBsgH4Ap7v//RnFr32xT4JfeOU0ARvfWF+oUi29hjBz9YwN707YwOhX2wa2GDLwGydhGPxCWlEeyYK4ayG0uePYO43gAEMhU2a6V9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751838101; c=relaxed/simple;
	bh=OUqIraMhV/ovaQYEA5cJq1iqg9loAhW41Ir/U058j/U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aWNehUhPZVUnQCCfjh9YqweWpQLKej//SH9GT6OInstMM2rsrDgVk4/De3qiE2/qDEKzuj0Oa3EEBPLPBT2QWU+MH+00XoqlhCs20boH8AKrxOxaV2PJlgPu8Md08gGqNAP4IO2IBxNN/zlT+fFqPitT0n3xAkTAcEMCFyK54DE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lOm84H6+; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lOm84H6+"
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-74ad4533ac5so2694022b3a.0
        for <git@vger.kernel.org>; Sun, 06 Jul 2025 14:41:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751838097; x=1752442897; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vlZymSS9r3W5Rr7srxoF1qARUYC22vbSIPL6X0s6HMs=;
        b=lOm84H6+wXyXiljFEj22Zd3eND7oi791BDub4uVFFezxvHFxnJ9ObLew5GGIUBIXgr
         Rb8JOipzpLRiYZ2OVo9+pIDtxvoOrAUGgqrvaN3aQZNMDRhJdSwo8EB8prQCfPYOhrvs
         X8vPvni/O0huX7wLhxaBMgZI7kcsmg6oCgrLsEcYEUjYSVQt/1PZfHzEl7/3zvA912HQ
         A1WQbDopyAEvFJ3pA3+l5GZK23XE/M257dQ7osDZFpLgMlFKiirdC7JMAQiV8wFsMcn7
         rdFENopkR0UA9RXedJJjadbeMYjaOj6yioLhNvJIpwKIr6nbmDOdkbNNA9DdjGqKSrcY
         zUGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751838097; x=1752442897;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vlZymSS9r3W5Rr7srxoF1qARUYC22vbSIPL6X0s6HMs=;
        b=gpYQ0oM6jUXkByJST2mx1t6/X2pyTR1qWkARQs7S9EnXDvn5KdS4/P9NJxWUoIsO2S
         kq3hp5sIKqP0T6WuBC8OgrnOyOeQIZGylrqIcEJ6KC0G/1erwD8EDK5Adp1FI1A8wGl7
         KzP72bLPyuH3SrN6f3IAMVamKQpwSyGZX6+v9+8J3WurnvUPj/B3azyU9f7NwG7WDtrZ
         mmlc656mTIRKKlBKe9a85pUC3/LXaPjVDY2nFItJFWrGR06cOOGhfiuNvv9IE4pWFwqu
         wRA+9rTzWGquUzdaLkrzDWonwWFMkGGyQTWAw5TGv6PzIbHV6XOySBTGiw3rxnTI+ykw
         UrTg==
X-Gm-Message-State: AOJu0YxO8ss87HrmraCoshK6yC+9fpQBvzMbyYsmva0Hb/QssI1won2H
	YGF8p7FHNfj9Q28szCe/43U7fY2A93Y68ZZdLkWISccKMcdxJm2DimNKrmlYsd0oZUs=
X-Gm-Gg: ASbGncsNY38MaVH1I5SQIK3MN5eCRddrP5z9slLwmtFm5nxKfMJ0BGgxB40Pc1EspLg
	3PjV/OQ2zN6zUuUMmXYGdD1gcKbfYIIkKSnMPQSNwZvS/cvzgK+jVl7FG/LES8PI+hBoH/ktDr+
	2GdCdlIFMAk6fev+o+HusNIfbgcDdlSZBlxnCSu3m0KUEU+aDfRrJ1PHl72KIWciHh8/+67apIp
	uaTv3du579gE2M6LYmdn5o6rKMFDyxrua1WzjMC1iVmUQX+sJe78Xtwhd+IoJHfO2f48KIxu+O+
	1gFymhHIKM6hfGhLvYX5r999YIzP4e81BtGTvKQHweznS6eGPDH7X6s0f7Bl2fdLXpli3hjIGTU
	CkGnCTCPZGm0=
X-Google-Smtp-Source: AGHT+IFvSERr0+PCtYAfRvNjl+F4evT+tCzZ6WywJPH7Q3GQxWemvm4yW2f6+pwH27LzsBouCAvK/w==
X-Received: by 2002:a05:6a20:549d:b0:1f3:3547:f21b with SMTP id adf61e73a8af0-225ad6c1d25mr16512718637.5.1751838096892;
        Sun, 06 Jul 2025 14:41:36 -0700 (PDT)
Received: from archlinux.plaksha.edu.in ([202.164.41.66])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b38ee60c55csm7363968a12.43.2025.07.06.14.41.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Jul 2025 14:41:36 -0700 (PDT)
From: Usman Akinyemi <usmanakinyemi202@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im,
	chriscool@tuxfamily.org,
	christian.couder@gmail.com,
	gitster@pobox.com,
	me@ttaylorr.com,
	usmanakinyemi202@gmail.com
Subject: [PATCH v2 7/7] t/t1517: move verify-tag -h test to t1517
Date: Mon,  7 Jul 2025 03:11:08 +0530
Message-ID: <20250706214108.714499-8-usmanakinyemi202@gmail.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250706214108.714499-1-usmanakinyemi202@gmail.com>
References: <20250706214108.714499-1-usmanakinyemi202@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The test 'verify-tag does not crash with -h' checks that
the command exits cleanly with usage information, both inside and
outside of a repository.

Move this test from "t/t7030-verify-tag.sh" to
"t1517-outside-repo.sh" since it better fits with tests that check
command behavior outside a repository.

Suggested-by: Patrick Steinhardt <ps@pks.im>
Signed-off-by: Usman Akinyemi <usmanakinyemi202@gmail.com>
---
 t/t1517-outside-repo.sh | 7 +++++++
 t/t7030-verify-tag.sh   | 7 -------
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/t/t1517-outside-repo.sh b/t/t1517-outside-repo.sh
index 42381ef7eb..0755757d86 100755
--- a/t/t1517-outside-repo.sh
+++ b/t/t1517-outside-repo.sh
@@ -156,4 +156,11 @@ test_expect_success 'verify-commit does not crash with -h' '
 	test_grep "[Uu]sage: git verify-commit " usage
 '
 
+test_expect_success 'verify-tag does not crash with -h' '
+	test_expect_code 129 git verify-tag -h >usage &&
+	test_grep "[Uu]sage: git verify-tag " usage &&
+	test_expect_code 129 nongit git verify-tag -h >usage &&
+	test_grep "[Uu]sage: git verify-tag " usage
+'
+
 test_done
diff --git a/t/t7030-verify-tag.sh b/t/t7030-verify-tag.sh
index 2c147072c1..6f526c37c2 100755
--- a/t/t7030-verify-tag.sh
+++ b/t/t7030-verify-tag.sh
@@ -7,13 +7,6 @@ export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 . ./test-lib.sh
 . "$TEST_DIRECTORY/lib-gpg.sh"
 
-test_expect_success GPG 'verify-tag does not crash with -h' '
-	test_expect_code 129 git verify-tag -h >usage &&
-	test_grep "[Uu]sage: git verify-tag " usage &&
-	test_expect_code 129 nongit git verify-tag -h >usage &&
-	test_grep "[Uu]sage: git verify-tag " usage
-'
-
 test_expect_success GPG 'create signed tags' '
 	echo 1 >file && git add file &&
 	test_tick && git commit -m initial &&
-- 
2.50.0

