Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFE8C1C9ED3
	for <git@vger.kernel.org>; Thu, 10 Oct 2024 15:12:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728573166; cv=none; b=bydrMy5fNTMxnTF6tLaQuQ3K1K3mMpHqW+0xCh6RcTWMnPYDM7GG2qZwRkp6/nyWSqm8UOJs1fFo5tphIaVzu4OFNFNoEtURS0Dy7vY+XgRLHPDYyIdKyFMZDLFRR/vBvgomE5gOH23tyN9p5DjE5G4DQufa/eTBIyCWimLMM9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728573166; c=relaxed/simple;
	bh=4TmdziUh0DoRS89W3MX1grp4qHGLeFNLnMno7qZyi7s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=G/ALestBQTsDhB0aqU2A0z7LDivZqy2Qaj8sTFn3HT1JjVKNw+HM0aEd75S4WQtg2I12H0fuGCv614HsbarqOEEMguggQBcdvvjNHNl1D/B1r6KTS/6yUnGChLr4DUJN6SYhGRyebwizi+JCRpgLnNe44LT7UZ4YsVeeh41X5Kg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZqCO3MrT; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZqCO3MrT"
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a993302fa02so166685166b.0
        for <git@vger.kernel.org>; Thu, 10 Oct 2024 08:12:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728573163; x=1729177963; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=FYuFuI4E69up1MIORj9j1Av8v7/8417ieXXO7m3Piog=;
        b=ZqCO3MrTQoG2Wor3CKXHnZPGfKI8xkMXq/ssrIJPwKWn2GmOAlJNiBViW0wKGA//2C
         yXNuWIRA4x+udZg2KJtf4gumtCwNIsA8TQ44o0kyzYpbmNtAA/3nN2Q/eSuEF8dgt8MQ
         Kkx0uM5icFYnbOBhFw60zsOunAVtf+O7PWT3RQswZY1UvjL+/HugTuxbDSZZPoS8y0WD
         LmPn859ZlrS1Lnf+Y0HV9zRtlkjiF0w3VvF5FYqA5SQZJFSz0Jl3ULTAj8hyeTWnoHnR
         FXnNRsyh/oLK/t4iSQyxSytc68iL37YtXsA7rB5xIrWTmkdKX0pR7JjzJ8o3QadGpoU9
         KqlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728573163; x=1729177963;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FYuFuI4E69up1MIORj9j1Av8v7/8417ieXXO7m3Piog=;
        b=DC23cbstDuUMWveXh+7i5FRdLTuZPX8vaVMHpgBJX8HWLqhlI73enh+Edqkm14KyB8
         313TF2gffx0srp9LCa38PPFYS7BiV924B5Z9cHhNOw4dAQcjA1Mw/l5yTrAV5sm4m8V5
         JipVjwfCLPi9FNAv/mjsRAC1ewAk8eAb/4Tn1k0WRfIiSSirJQ8bZ+Zj9EfJejnNnzzN
         6AM9pgM66qFODn52/FTh7kVT1ACkzIGIM8YK0r9eygZd4NISRmmqlenvCyxKdN70bLrK
         JdW/KbxLp8IZ+G5ZTi+gt/cdEBAOnOwnL/k6G3G8lgunmKtnPN8S9dYmRkxiDgSUm67C
         WlYQ==
X-Gm-Message-State: AOJu0YyefI4gMrgG8qyx4+XcuGtbdyft5wUY7Fspemmt6kPZ2AYCaEVQ
	hkZJcWtmsztN2Wy/4/ylc7QgrsXKwebM/O0PX4RvR4JhfdYkemq5QA9Gzy9senE=
X-Google-Smtp-Source: AGHT+IHIKnDAQoEhhv1XMzi5cJW/Z/KBQTdaECmvHjL50ZBW5inlgW4jJ9ibLvyn0FTCWw7O2P+kvQ==
X-Received: by 2002:a17:907:d869:b0:a99:45c5:339 with SMTP id a640c23a62f3a-a998d2193c2mr585219566b.32.1728573162424;
        Thu, 10 Oct 2024 08:12:42 -0700 (PDT)
Received: from ip-172-26-2-149.eu-west-1.compute.internal ([2a05:d018:458:cf00:674c:b768:6d8:37d1])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a99a80ef8c1sm100840266b.195.2024.10.10.08.12.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Oct 2024 08:12:42 -0700 (PDT)
From: Andrew Kreimer <algonell@gmail.com>
To: git@vger.kernel.org
Cc: Andrew Kreimer <algonell@gmail.com>
Subject: [PATCH v2 0/7] Fix typos
Date: Thu, 10 Oct 2024 18:11:18 +0300
Message-ID: <20241010151223.311719-1-algonell@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

v2:
  - Fix grammar.

v1:
  - https://lore.kernel.org/all/20241009114940.520486-1-algonell@gmail.com/

Interdiff against v1:
diff --git a/compat/regex/regexec.c b/compat/regex/regexec.c
index 15ab2d1d40..2eeec82f40 100644
--- a/compat/regex/regexec.c
+++ b/compat/regex/regexec.c
@@ -292,7 +292,7 @@ compat_symbol (libc, __compat_regexec, regexec, GLIBC_2_0);
    concerned.
 
    If REGS is not NULL, and BUFP->no_sub is not set, the offsets of the match
-   and all groups is stored in REGS.  (For the "_2" variants, the offsets are
+   and all groups are stored in REGS.  (For the "_2" variants, the offsets are
    computed relative to the concatenation, not relative to the individual
    strings.)
 
-- 
2.43.0

