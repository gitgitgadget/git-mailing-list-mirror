Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A45276025
	for <git@vger.kernel.org>; Sat,  1 Feb 2025 07:13:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738394002; cv=none; b=VUcEr4N8JWPNUaI/ZTyXeFCajKTe/ZbubpD42cFF1mfkVKccYrg+L7qf7an24kl9ykYeD2xt+mnpVnFcuVLptceFmqZ4LkMEcDDRQ3D8ds2a3+Vgp8A1RD7c07vWLu5vcdjVa3q1lUkGihMWTn2sXFAEDzJh2AjsuikZ0csdJKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738394002; c=relaxed/simple;
	bh=vwvMfh1I295Rrr7ywuYHGUPfYukMk0oTxMUHfHCJ/fE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MkO9giKnPdSYptUOxG9g6Tp01FRR1rXT4H1CD+o3QBc4nIJw6BL8cApjrz6yNIar/4GXubwVxtt+7WgCw315p7YM18z3aGJNJiQSVYl2XhBmnB2jokJpr+dYx3kZfWtIeRoHYA1yY+7P5Qu6s13/TVTPoV+s+WJNM/1H74HbCro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GDZApgV/; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GDZApgV/"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-21680814d42so45871335ad.2
        for <git@vger.kernel.org>; Fri, 31 Jan 2025 23:13:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738393999; x=1738998799; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Z2Q6wk4j/UnqZBpNzVC1HnUIZZEsrB7SwZEzcALJHd4=;
        b=GDZApgV/AydufwQNtfIMblNSsb1wnHSgaL61aV0kOzB+psbgDs8BoBNZRBM1Dmp88G
         U4zaZxTyDfbD91qpKCJi6kRm1r94euFq9Rt3QozNHi/Lar36jPA/+hBh3vKOi9gfJ1zB
         3vjc857EAw00ztAOKUgZAVQO2jOREg87Wjdtogm0pbrC2syUhytUM0GgBqZysMXVhKSW
         jbIt2Cw/JiZceWNfo0MqgujPXNMVtB07lGKm7iicDBee+yW84mvLtwqrBaYiZcaDaRRF
         379QKaNJ2vVlmMc2QOnmN5aiywBoubVT4DZtWZHLeduXHTc9Zvb7U1/JPbEcQyAC/Be/
         jIiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738393999; x=1738998799;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Z2Q6wk4j/UnqZBpNzVC1HnUIZZEsrB7SwZEzcALJHd4=;
        b=ObtIts8txQmAQ5UOzgRo7GrKE3ZXm7meqNMRKlyGCSIi8/agEy8ROkI+J1cS9irVWA
         SYLk66hrJkeNHDHrMY1itVRbW+F66opBBBMmPDGWPLoCyyycb48g2kg8LcfwSA6KA4oc
         acWqL8zb3Nh4195TAKyq9xd/VeUhodIAqlafc5QiRc1WK6gbcISindOA4LcML2tGjmSU
         SDEUFzQD9/bljr+bphv7LcZnUSb+ySryxdSO2qE9aBzhC7FeMDUAahqcRkuUG2O6l6B0
         cqgLO5rEa3wsOpoeW3y4QYaKwLHkrOaLv/nqzZAb3cDP4EE4XE+7s/nTuLvEAcDkR4o4
         qQew==
X-Gm-Message-State: AOJu0Yy4PQ3U7oxcao7BceUdBa3fCU5ZYwzSnyemkccuoMr/gy8rGGIW
	HuAVkaca/qxG+4YrAnQC/0cXnsXAilSxzh67wH9uB7wmq74wEUfrq1kcYA==
X-Gm-Gg: ASbGncuvjit7BHFBDV6aTKmTtQdSauLSnWPgWtMdQQUsINsqM9QSDvJkfR0PgcORMz7
	r+zgABfpcQEUKEyfo7lmeURDNa5lcWPvBGj//WBAO8KorQaGX72IJh9sov/J0AKFhcDXOgaPCs/
	Z3XpaAfH9z12ajgfU9gfaFQh4yfQfsvv6ruqthofSldbbbxsL5drVQRssr5CBO3XN3zr+/HvwPl
	ICIAxwCCljNNYrjOKK5bNuWZjxZT1e+RSQi8+dT8mI/ujqMW0TXbXtR70g2bzFhudVW+ZvUkWEB
	JLSDU1LQNEaqq2E/6UaLLW4YeuUZKW6zCHM=
X-Google-Smtp-Source: AGHT+IF+o0lmCBWrgDJjKHIKsaNY4o/WeBK8jL5vuWE5q2BEtnabPEqJNUoIDdNufZsbzzJ7+pUSmA==
X-Received: by 2002:a05:6a20:c88b:b0:1e1:aba4:20ab with SMTP id adf61e73a8af0-1ed7a5b66ecmr20068091637.5.1738393999457;
        Fri, 31 Jan 2025 23:13:19 -0800 (PST)
Received: from fedora-insp13.domain.name ([2401:4900:1c54:d058:2960:c25e:6cd7:90a3])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-72fe69ba401sm4380758b3a.88.2025.01.31.23.13.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jan 2025 23:13:19 -0800 (PST)
From: ambar chakravartty <amch9605@gmail.com>
To: git@vger.kernel.org
Cc: ambar chakravartty <chakravarttyambar@gmail.com>,
	ambar chakravartty <amch9605@gmail.com>
Subject: [PATCH 1/1] t5401: prefer test_path_is_* helper function
Date: Sat,  1 Feb 2025 12:42:10 +0530
Message-ID: <20250201071210.30509-1-amch9605@gmail.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: ambar chakravartty <chakravarttyambar@gmail.com>

    test -f does not provide a nice error message when we hit test
    failures, so use test_path_is_file instead

Signed-off-by: ambar chakravartty <amch9605@gmail.com>
---
 t/t5401-update-hooks.sh | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/t/t5401-update-hooks.sh b/t/t5401-update-hooks.sh
index 723d1e17ec..17a46fd3ba 100755
--- a/t/t5401-update-hooks.sh
+++ b/t/t5401-update-hooks.sh
@@ -64,14 +64,14 @@ test_expect_success 'updated as expected' '
 '
 
 test_expect_success 'hooks ran' '
-	test -f victim.git/pre-receive.args &&
-	test -f victim.git/pre-receive.stdin &&
-	test -f victim.git/update.args &&
-	test -f victim.git/update.stdin &&
-	test -f victim.git/post-receive.args &&
-	test -f victim.git/post-receive.stdin &&
-	test -f victim.git/post-update.args &&
-	test -f victim.git/post-update.stdin
+	test_path_is_file victim.git/pre-receive.args &&
+	test_path_is_file victim.git/pre-receive.stdin &&
+	test_path_is_file victim.git/update.args &&
+	test_path_is_file victim.git/update.stdin &&
+	test_path_is_file victim.git/post-receive.args &&
+	test_path_is_file victim.git/post-receive.stdin &&
+	test_path_is_file victim.git/post-update.args &&
+	test_path_is_file victim.git/post-update.stdin
 '
 
 test_expect_success 'pre-receive hook input' '
-- 
2.48.1

