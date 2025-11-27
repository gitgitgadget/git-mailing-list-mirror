Received: from mail-il1-f174.google.com (mail-il1-f174.google.com [209.85.166.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68AFC2D23A5
	for <git@vger.kernel.org>; Thu, 27 Nov 2025 01:10:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764205855; cv=none; b=Q3cyYUprAQP/MwcwauVP4qQRURnhoINy8Hiv/HgkarCiF72AVj6QViqygbzkizTEYbeIfrGyligpOONuH7jGn5xY0OYtO40DsicqzW3wFFvuVP7SL7Nig6qH518sJxa/VuG40bjBjS2atnUqynjzYwez+w35AYu+pR9Bmfp+naM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764205855; c=relaxed/simple;
	bh=B0fbCTk4IKvyUv6WEJEhuA1v7TtLa2NyC84tYqghVPo=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=gFRaq8tAC3HoCIxfYtfrg/6p9zT+aGutxOoOkK6G1tqgzFmSzz3Fks+H4Mqw7trNTNErzC/wH+Ztp6/k8xjJfg3cyT++nxaVF36V39CTV2JzHFIlJ+mC6XxBySAWtUiU4Ix4Tje6CfGO96DFMAR5c2nm1sEclXWe1ap3t3BswG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GbjqDrgf; arc=none smtp.client-ip=209.85.166.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GbjqDrgf"
Received: by mail-il1-f174.google.com with SMTP id e9e14a558f8ab-4330dfb6ea3so1733875ab.0
        for <git@vger.kernel.org>; Wed, 26 Nov 2025 17:10:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764205853; x=1764810653; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ttxvcmCsHdwhtg3nZ89U9TOtXDzrOwuHd8EFmKd/SNQ=;
        b=GbjqDrgfxzDyp8WPA+lUkBsKMJdMZRdkMGxZM0DpSbNOsetUrue9CsAcEvnM3e13Vo
         BWuHQlyHziyIa9Gd5U966Y+rxwCxBNu6X6AQuRzDEb94KHGzZf8rUsqd7rqctASwXbYX
         5svhgpyK5xjRMzy5gOOq/QWvbAWGCgre2gAVdarV1rK+QyMWB9l65lAnYi2LxM6scphX
         TVdlC4CI1CqvjSqp9RZVilS/txt4sHDrhOd29pN7B9xutWNQCDzho9JTkayKb5xrJloY
         yaQ6FbUY/ueWHinqulzBScqMqt5R6ntMXxqF/pSJ3gCXj/nd+jXIU3SW7J8qZABCEUVO
         vx2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764205853; x=1764810653;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ttxvcmCsHdwhtg3nZ89U9TOtXDzrOwuHd8EFmKd/SNQ=;
        b=pFBDCMbRnv8VXGJpQdLLWcxht2PKHl13Lu3uLfB1tfzopjLORpq0JAHV3dhiQinBv3
         TPuw6loU/QBfCcxhI8c07ndaRWoPkjr88+k2OyeLvESZacVEIUNLl8tplmSuhJslvm5S
         jp/jfTF/dxZ3fqG8kppkxvulq9VGNhgUH0ODwhtsNp8Zp9sxJA7gVcvXkkFzcaTBxZw8
         c3hjcVOeGctC2VYf6fuoHMbpmqno4VHuxgRDLAnitg67W2bCikLvDpm+2g1AUyFTeX3s
         8WxT/TkIGSeqPaP4nQHaLgWJEEGQcBhv0v/G9ZRnjNWCyy2+yipO9kVf0Q3XOKmOzTxi
         kWEQ==
X-Gm-Message-State: AOJu0YzchJswYsoeY2navIQ4oi26zf2NaZLRioEhk+T2LtolsZWzYT7o
	V+eAxF+vhIA18iAmS1yZC6874aojubNfTRiywsPyHOlZXoCaSkapxLu6o29vEw==
X-Gm-Gg: ASbGncva2DgNV1YMQuycSyBhr7HCzidX9ncYTBMQ4c2a/fL41hzFSswUjdVYhNrVBwA
	DHd9tkRs8u9IUSIhwqaa8JqbGEtYB4lK9SU7h9CF+FNyX/m/yBJUOXXRfbuh4J/k7M/63t3SikP
	qeHoKIEboQTr/emLLvOMXKT94xxxYgQL3j4HIdYvjamAyKpzllEseiYb/wLIWkgLKJxxGEIMBpK
	RYSOoaEdSXRDcUBwqm0TyElAn7JgEi+0l+41d/YKSJTZAcdBkNjGH6X8OP011tdSRQBk3k0EiDo
	PdfvOx10PgguYvT4B0uNkHVmLVwMRUp43X8TPoglXo6HDiYsJ4atKH7Hh51nvBtmdrVUPZAoclp
	Pl7Ppzrwl5aOkKFvJZpLaREQGHZRcHTVwA2NwAF8pDEPdZ1H6r3CqAG7QUxhh8QJ8lcxQQc6T/R
	uehkp4ekmPQ3+jzA==
X-Google-Smtp-Source: AGHT+IEuO9WQjM+gPg0VIR2Bl/OQFojDzdcIvxDxewMoDTbCtuwW0ADUF79YWsIaTnsJvvuJiQ5NUg==
X-Received: by 2002:a05:6e02:3f09:b0:433:72cb:cf with SMTP id e9e14a558f8ab-435b9852090mr190264285ab.7.1764205853127;
        Wed, 26 Nov 2025 17:10:53 -0800 (PST)
Received: from [127.0.0.1] ([64.236.141.183])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-5b954b48b6asm8896537173.46.2025.11.26.17.10.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Nov 2025 17:10:52 -0800 (PST)
Message-Id: <218f995c384ad7e97589d56a8ae09b6782666836.1764205835.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2110.git.git.1764205835.gitgitgadget@gmail.com>
References: <pull.2110.git.git.1764205835.gitgitgadget@gmail.com>
From: "Ezekiel Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 27 Nov 2025 01:10:33 +0000
Subject: [PATCH 11/13] github-workflows: unify with rust parameters in make
 and meson
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: Ezekiel Newren <ezekielnewren@gmail.com>,
    Ezekiel Newren <ezekielnewren@gmail.com>

From: Ezekiel Newren <ezekielnewren@gmail.com>

-Drust=enabled -> -Dwith_rust=enabled
WITH_RUST=YesPlease -> WITH_RUST=true

Signed-off-by: Ezekiel Newren <ezekielnewren@gmail.com>
---
 ci/run-build-and-tests.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/ci/run-build-and-tests.sh b/ci/run-build-and-tests.sh
index 8bda62b921..d4f7cbd15f 100755
--- a/ci/run-build-and-tests.sh
+++ b/ci/run-build-and-tests.sh
@@ -8,9 +8,9 @@
 case "$jobname" in
 fedora-breaking-changes-musl|linux-breaking-changes)
 	export WITH_BREAKING_CHANGES=YesPlease
-	export WITH_RUST=YesPlease
+	export WITH_RUST=true
 	MESONFLAGS="$MESONFLAGS -Dbreaking_changes=true"
-	MESONFLAGS="$MESONFLAGS -Drust=enabled"
+	MESONFLAGS="$MESONFLAGS -Dwith_rust=enabled"
 	;;
 linux-TEST-vars)
 	export OPENSSL_SHA1_UNSAFE=YesPlease
-- 
gitgitgadget

