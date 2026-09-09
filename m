Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4C0E3C8700
	for <git@vger.kernel.org>; Wed,  9 Sep 2026 19:50:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788983421; cv=none; b=N48OIG938hXgm5xBQEJ6l0GjjRwzpUeP/dv47EXiz+RXwE2mLdNM+uFQhLa7oynbDS5I+BNT4U6fPJSbODfQ9g8x6/CuVHoYQPWprGZXStrNNSvDakRUtcGm1+d9p+NhK1Nqjj3s262GTAb60/V2SYomKgTceen2FdPqSrzoRqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788983421; c=relaxed/simple;
	bh=m15MVrvkfkSr9hDlu+qaQOZ26aKnlTi/YmRxVPsO9eM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BJkmprvU13td1ZfmRmFsq03cOTu5TKpPdaCjWZBGyi1Hov8v7ZogNJ/yaSMVqPQNSy1dXxGQ+A4nU6L2SG1b4aX8NlvnRs0QbR/ppYDaC7YT1D94w5eApW8S7DPRPG6v/qnhUo/wYPqV0hEIn/tn3jqP+AjVDWTHprjNjAGPNEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lUNrrCyy; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lUNrrCyy"
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-c259e5c22ffso733368766b.1
        for <git@vger.kernel.org>; Wed, 09 Sep 2026 12:50:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788983418; x=1789588218; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=MvL0LsvJAmji1axKthKIBjbornPrey8veLX4vbU2tS4=;
        b=lUNrrCyya6mo5uvKALglSjd44zYH0gYBOVSWPO6fIKR14UBHut1/fOJzNECJlj/ITo
         3pDBBKXiwSkDVgESpfSZgQZG4rVptIPkKuQUYeVnaHAolC0k1r0A4NXJWXBe3uemgZMr
         OLzPPfPHYo2aqkAat6gwCVTcrmdbRqmjJovnVo7+HI7TMAo90GiEkdEjQqXj+mtoSJOT
         uCtzgZZbrHYHyGaLjov5YVzX8V7A8j3QUWoamDNpqx+g3BcMymXhHTfYAjXVPPAreKY6
         dLNYrnKZ9azvbImzY1R7wDt6zbyz1ZjXoUCsKD59ipY4OyEmlIKPltP4UmeySOo66EOQ
         lUxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788983418; x=1789588218;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=MvL0LsvJAmji1axKthKIBjbornPrey8veLX4vbU2tS4=;
        b=d9SI6EcY/Zy/2kEQdY3ehsD0hJmBdqFV0+yNVYyJh6LEBUgPbmgys3Og6WNVnaYJyo
         rgGggCyr+DBWJQ1ZcchquSN4qAgdMJIdjgTg6DlrPwHCWQzOPtzqjeI8hHsDpvg3sLGi
         n/Y6gwft34i9KZXPGl1G6VkOrdHIUONeo/9dd0r5bVIHdTigmB2kEyKmku+6ZFyA0g4y
         tM377f82+cwGG8zkUE6XVuyB4zG3WljrvLDdTsGpewscuN++sHxXdZNNQ/MRbQpHBH7J
         JvWp6ExdW6h0U4esUk614IMe3qV3ztvtF7MD9cCWuAhVUpK8hXTP3cPJQJhgaMxOg5cX
         6jdw==
X-Gm-Message-State: AFuF++mvYwyXairrWvmKm+pd74nsbyu1a6+fm2tk/yGx35XttQOO/XUe
	XIcmkjFHt4lOyvfvmmtA5+ocn8tZBKdhzMS6tsQ8vcFbLXdvxRzvmjtNspUZIw==
X-Gm-Gg: AYBFou18cM3GkGPk0lLEH4DRrjCER2vh0KQRXP8eHSMifGccYaDIseIAT19cWfidHKV
	KjpMVPK129ivmL4Q5o/Bn3nU33DaG+xCKp1vRr5UxCj3LZ6YJPqpHuImiyoraBer0DZ4oSCUHgI
	pxq9pxe2C5mi4v8fPvjUaVGrnYiO+u6w7/KUd9D8usS1mo7QuYa5pk8QmH/DYQ+jQpDYkSinX0f
	zIj2ImQUs6LTpi92v0kPnf0KZpcSBeAZL//VfYl5TjysxFdvtcxpP+89Nwl08T48vNLjMQWCa4w
	tKljgEZu49ez5mSEjnUsRjpHeGcsE47IN8mTdoIrlViAA0s8kKJYpvhqoHTtfnVakca21JLiWRZ
	GzRQMXOIf37xNjBhD8M4Gh4wMp3paTpuI841zUW9QJ1FRXE8ktjuTVTEqiE6H/A5Hq7G6okXA3C
	42dUm2I1q3HO5CA/gON4pMPJoTaiKPwUXdEI7teqDIdZQwzcsdD6pMZkpq7sfmQ/cA68g1L9/Su
	MgHsStqo/z23vegMA5nPq3/w8Dt
X-Received: by 2002:a17:907:728f:b0:c29:4311:e23c with SMTP id a640c23a62f3a-c294311eb0emr127989866b.28.1788983415541;
        Wed, 09 Sep 2026 12:50:15 -0700 (PDT)
Received: from localhost (78-131-17-112.pool.digikabel.hu. [78.131.17.112])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c260d03635csm818943766b.7.2026.09.09.12.50.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2026 12:50:14 -0700 (PDT)
From: =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To: git@vger.kernel.org
Cc: =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH 1/4] Makefile: remove XDIFF_OBJS initialization
Date: Wed,  9 Sep 2026 21:50:03 +0200
Message-ID: <20260909195006.2179119-2-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.55.0.1193.g1b994e35de
In-Reply-To: <20260909195006.2179119-1-szeder.dev@gmail.com>
References: <20260909195006.2179119-1-szeder.dev@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Object files under 'xlib/' used to be listed in the XDIFF_OBJS
Makefile variable so we could build a static library from them.  This
static library was removed in cf680cdb95 (make: delete XDIFF_LIB, add
xdiff to LIB_OBJS, 2025-10-02), along with filling XDIFF_OBJS with
object files.

But the initial empty initalization of XDIFF_OBJS remained, so remove
it now.

Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
---
 Makefile | 1 -
 1 file changed, 1 deletion(-)

diff --git a/Makefile b/Makefile
index d4b775953d..7d9ac15c74 100644
--- a/Makefile
+++ b/Makefile
@@ -695,7 +695,6 @@ BUILTIN_OBJS =
 BUILT_INS =
 COMPAT_CFLAGS =
 COMPAT_OBJS =
-XDIFF_OBJS =
 GENERATED_H =
 EXTRA_CPPFLAGS =
 FUZZ_OBJS =
-- 
2.55.0.1193.g1b994e35de

