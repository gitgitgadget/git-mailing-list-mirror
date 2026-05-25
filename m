Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 431D533FE0A
	for <git@vger.kernel.org>; Mon, 25 May 2026 05:36:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779687398; cv=none; b=N4PseF4ygkug0ib0lF1Gp9jhPp28O6958S1eyYtBj5Q26GrQ1hJWkf6EYVu1Qhs4V+oYq9rIwIS7qJkqX3oSPOqWNtv4nXKZdaBqnl9stZZybOhNEwjksR4OCmg4a6fbGLksCFajAK0IinS4uk2DjmIf6WB50cS5qnVtljEXr48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779687398; c=relaxed/simple;
	bh=76L3AvJExX9T7LJj5ugCDhO9+IucqrdYakbOH76n2Zc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=DfbWb/GyNcf1uHE/f7Pm63P5hoxBg+Y/jiSV+bvOp9tmZ2xHrkOnmrlITAf1BXbOzRnjkaLW7eg2VB/5RFSFB747qvsyQz5gHu9m4ROmOjXkpTzQTzpyKKB/aJAzLMiVu8gpeHjxJwYvhYnf2poWKe/gIhJBK4JVapY6HXwh/OU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ESLFWodZ; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ESLFWodZ"
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-8379e010b01so3967467b3a.1
        for <git@vger.kernel.org>; Sun, 24 May 2026 22:36:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779687396; x=1780292196; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9NZ4RKeCTysUajcqo/f3eVvEkHjpqsi2zT2W90ADfCc=;
        b=ESLFWodZ0WvufhdhCSPK9GWatQdoRkhN2kUQGeeblSmpySLlemGpSxBLDq0lVGlh0L
         Z9ISx7LmQJ6hKb+hZOHd2St+FGbo67ZoCdWTay35OaG+vg0pCcX132N2y4RjgsutuL5i
         XYtGhU9V5oPxct+e+dqK8noe5/MNNEGasxEighkwn5INB4ZLAc0rmjglbebifPfaVn61
         BSPOm1YP3wq42lJz6v/lI8gAVUuy1yopjTGXGbQHbURpLR9TomBP8AkruCIPw0ln2p6x
         j9z1YYSAEs0SN7gpwFF8dRNN1mDyVbybzD/4/sSMJ4rcOMcKAk7IqoHxGm5A0GWGlhQi
         vBWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779687396; x=1780292196;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9NZ4RKeCTysUajcqo/f3eVvEkHjpqsi2zT2W90ADfCc=;
        b=PxmOvpGZr0cxoXkWYZqmhoWwKWvyMnhkE8/BwQyALTH5XPBy1ebB85SN9ePcmxXplu
         Mmdo10+fBY4JrAaRKWnTVi01YjRDu9GyFKI9PCiw60a1bV5aSR0ddCMTmzzoJNUco6cm
         CjAn1dts58Cn4scg8FukjAh8b7LZmFPqUT4pNDpfTRVXi5t4ZhzXemViPOAihrMw61Ba
         ISC4GFWnBmuXpRsd4SBvo/GRBP+D5NNf9M3PUUgWi0Ju5vFQd9exXF65XMY+konJvLFG
         zbcduQD12uk58TAjyBJo7bDHBglObuSCzafMUbgs6B0D4cejLcwE/GCsXpWnHHdGPQU0
         VVRg==
X-Gm-Message-State: AOJu0Yy6sB7FaNdxKnDC5F0ywXKyf1qgtA7ww9QmvFEC399kPE+bNOa5
	k9bVPMsVXI/MUqsHfzoLbMjSwakMjEwZzoBdZ5k8MpQM9ggsxcNzvMPHbsZobqFM
X-Gm-Gg: Acq92OEAYEM+0ZoThtRCGDyrSed5b+7RiOQl2IIcirLYqJEbAfZRfGQ8iX/L7oMF1ye
	I1DRKFGrwmrd5MmpeK8UMspIb6FtHG2fQ13niGtMIt988Y90kmBbrfKMt/AdkBXxaYsM//kVi01
	BpJKEzKOBmsSXTNkR/xmGfnr/id4Qp8eE1aXip0rnq9G4tI9nj3wvC73sGdwkQlrOBHD/lkzYRQ
	sNEsgnE/SDqqIISH0VKanAsQ94LtGzlWCjKmxxn/xSQZuNNxa9wB64aL9tqLdVmn9aX6xFTXGPa
	TZVkxtomtuoHLyr6I/bpSjXbN3QHT+woIvbPQ0gkCW94af+QDQ2QwBDukbhTsNyzy9OqbNVYuW/
	ArMXoWtQJ7aU/yFEJUqIj5TheDq3zRIatZzjzy1s+pVDjSF5RGg1yQUYDnrCyRZyoy2k0zCPmzz
	E/D0q/QIihT+/FnGAilQ0J1lGisscFaFDZrfr98JVlmk2qlw+db8ly4K4Krb4vVmzsU8sC8w==
X-Received: by 2002:a05:6a00:3027:b0:82c:ded1:261f with SMTP id d2e1a72fcca58-8415f66d998mr12061707b3a.27.1779687396604;
        Sun, 24 May 2026 22:36:36 -0700 (PDT)
Received: from localhost.localdomain ([159.26.103.39])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84164b0427bsm9305036b3a.22.2026.05.24.22.36.35
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 24 May 2026 22:36:36 -0700 (PDT)
From: Amogh <amoghdambal1@gmail.com>
To: git@vger.kernel.org
Cc: Amogh <amoghdambal1@gmail.com>
Subject: [PATCH] test-lib: fix typo in test summary message
Date: Sun, 24 May 2026 22:36:33 -0700
Message-Id: <20260525053633.73153-1-amoghdambal1@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There's a small typo ("passin", should be "passing") in the
summary/description message for t0000-basic. Even though this isn't a
user-facing string it should improve the developer experience + reduce
confusion when working on the codebase.
---
 t/t0000-basic.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t0000-basic.sh b/t/t0000-basic.sh
index 2b63e1c86c..9f6991a9ab 100755
--- a/t/t0000-basic.sh
+++ b/t/t0000-basic.sh
@@ -141,7 +141,7 @@ test_expect_success 'subtest: a passing TODO test' '
 	EOF
 '
 
-test_expect_success 'subtest: 2 TODO tests, one passin' '
+test_expect_success 'subtest: 2 TODO tests, one passing' '
 	write_and_run_sub_test_lib_test_err partially-passing-todos <<-\EOF &&
 	test_expect_failure "pretend we have a known breakage" "false"
 	test_expect_success "pretend we have a passing test" "true"
-- 
2.39.5 (Apple Git-154)

