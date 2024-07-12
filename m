Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D1E913F439
	for <git@vger.kernel.org>; Fri, 12 Jul 2024 14:24:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720794267; cv=none; b=HiOQm5R4T2UJOzWOYbOHx0y3o9qKUK9fx0ObB62f0Anzxpn6jMYhCj8T/Vhq5JGEj1DPAW9huZxL8klWPO9ep1Q9WyURFL/MlAWDm8nxT51BbaaGcFiMZ8zBDOYY9ppXR7U9JN4LDgpoPcwlFLRhcHC0ok2RtDZ59vg7zutLvv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720794267; c=relaxed/simple;
	bh=qnYqJWqW1fCYpRSEGSe6iXjxJVLUVY53aNp6lotcwBU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pSUgBM3uDNx7jDY8KI6/5XvzhkPUJcveJ5j9RhMkcRzS+qwqsiHDbJFWUd2riut5jKnCy2QckdgwJAg07+UCE5Z3ojwip2YvIaWHe+r1eTQGNrscUNfp+szPy5rFv4ZLay9UwaevoimJl/585o7noE6SelgLJahhvSibJ2ytSiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TBU7BXEg; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TBU7BXEg"
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-76b3c938153so38883a12.1
        for <git@vger.kernel.org>; Fri, 12 Jul 2024 07:24:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720794265; x=1721399065; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=eTb3qamtsEe/8vFq+xODLPl1dIllwPMMzQd3DxZNPHc=;
        b=TBU7BXEgsxsMMdGvR6gqspx3pOHvH4CEwts+PTGHrH+63qUmobNysHNNfiMu3Q9+mr
         vwPSpEy3zKp6Iyuzxtv4rKM2r2RwkqWKa9yz+3HScswY2naA+7LmpgsP486KvdOQ2Dhp
         Pi5bgVayj9PonGDe2tcYXRYW9IFBrd6mLOsUn2mVhCpcYSDSeuq6h2Rn1CtduzmFFaxJ
         RYDgXUwYlh2Na/sDIN6lkro52oxdC2qxp8DF4BsV7u7Shkym+Q4Cfj1osPFjvLm+3WI3
         QaxNS5FPtnkvjLR+gaAKaWgsSpm2sM+Vy/xV3k86ljDBxSS+JyhJ2i0jGBEOYQffm6PH
         bEMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720794265; x=1721399065;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eTb3qamtsEe/8vFq+xODLPl1dIllwPMMzQd3DxZNPHc=;
        b=IqZ+NAKFIP444NzPxAoangityDIFPU3N/XM5RRoXndQ0I5ojOqpa28ubsJ7YbeeMPi
         Yun/tw1U7x3yLTuuGMiCgEhR9mAdWDHkOPgLNV5g9fQ/68VgTLXvrZaqW0a9bfMNhVbd
         0NR915GVOjCUYhpO/r/Po3mJBDNYTiADGyOhPMkeVrC1Sw8eYps+rzeOVsqLgixZV5Un
         ujtEL0UQy0pQUkxmDMsmG5eDoVDiKX5Zkq8iCOBzUk/b4/Cj4JyLN7xPwfwGfnY8f2OM
         lWLpQi99SLerN974qGXUQSe/V9Z4lrYc87vDewLyuo0MMzCVnSI2i8b0UC6wjKoPW6u/
         3E1Q==
X-Gm-Message-State: AOJu0YyXGqtoY1HciTPAz4L0rOCRErIEAZxdyxdJgx/qOXNPWrSI/XGe
	71DXE4TGFZDcKYR1z0EmPzp9KGkAj9dl459/uf69Z/DThaeT1x5j+Urea0z6
X-Google-Smtp-Source: AGHT+IHaV/vHYf8DcEA0QQov6oLChC2DUSt7teRh6idprod7wsgRkAoOD3F1fo8gJgZR51GBiuke1A==
X-Received: by 2002:a05:6a20:12c9:b0:1c3:c1d0:227 with SMTP id adf61e73a8af0-1c3c1d00351mr1630219637.8.1720794265187;
        Fri, 12 Jul 2024 07:24:25 -0700 (PDT)
Received: from TTPL-LNV-0102.. ([49.248.29.250])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70b43898c73sm7537188b3a.30.2024.07.12.07.24.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jul 2024 07:24:24 -0700 (PDT)
From: Abhijeet Sonar <abhijeet.nkt@gmail.com>
To: git@vger.kernel.org
Cc: Abhijeet Sonar <abhijeet.nkt@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	"brian m. carlson" <sandals@crustytoothpaste.net>
Subject: [PATCH] show-index: fix uninitialized hash function
Date: Fri, 12 Jul 2024 19:53:26 +0530
Message-ID: <20240712142326.266533-1-abhijeet.nkt@gmail.com>
X-Mailer: git-send-email 2.45.2.827.g557ae147e6
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

As stated in the docs, show-index should use SHA1 as the default hash algorithm
when run outsize of a repository.  However, 'the_hash_algo' is currently left
uninitialized if we are not in a repository and no explicit hash funciton is
specified, causing a crash.  Fix it by falling back to SHA1 when it is found
uninitialized.

Signed-off-by: Abhijeet Sonar <abhijeet.nkt@gmail.com>
---
 builtin/show-index.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/builtin/show-index.c b/builtin/show-index.c
index 540dc3dad1..bb6d9e3c40 100644
--- a/builtin/show-index.c
+++ b/builtin/show-index.c
@@ -35,6 +35,9 @@ int cmd_show_index(int argc, const char **argv, const char *prefix)
 		repo_set_hash_algo(the_repository, hash_algo);
 	}
 
+	if (!the_hash_algo)
+		repo_set_hash_algo(the_repository, GIT_HASH_SHA1);
+
 	hashsz = the_hash_algo->rawsz;
 
 	if (fread(top_index, 2 * 4, 1, stdin) != 1)
-- 
2.45.2.827.g557ae147e6

