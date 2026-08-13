Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com [209.85.167.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4013A48423A
	for <git@vger.kernel.org>; Thu, 13 Aug 2026 14:56:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786632974; cv=none; b=LfM2jZHXsSZDozs/7gxazXMVTA46SL8iIDHdQGhckWOd1CdWXQF6mirHO2XDYEJo4zuLNy7qRntPPRGG8dY4nn5zmPJUZbKY6ysGK/gKySlKOKAAj+XTWI65VL6UlbI8oUw1YjHbedGsPExz47NbHwN5zWY2SWPxJfSIL5T+5A8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786632974; c=relaxed/simple;
	bh=tJSCgB6x0jbgExgdCRZ3qo+Hfof6AX9abMAJyj1FDgc=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=lXg+YM30k1UKG1KD3aWDODgGhSj6xcmwuQD1YjC1aPs6zFh3R91z5xqEVHrkDEHbphOIWLQUxKyuLO7bkB69CAE1CviRYp/FNtVk70x2p1D+X9wXHIXxxEWuzxyoQTCLE+n2mmp1MOOnsdMq+3sSvmEg6kKfwEShIq0CncMIvps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QuSE617o; arc=none smtp.client-ip=209.85.167.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QuSE617o"
Received: by mail-oi1-f169.google.com with SMTP id 5614622812f47-4b190cdc9feso1405476b6e.0
        for <git@vger.kernel.org>; Thu, 13 Aug 2026 07:56:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786632966; x=1787237766; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=4dCHkQjg/qVtExucbStgAUbSk9OouMFE3EvSXlZAN90=;
        b=QuSE617oiD4ajHTWRZViN6cfsApfegYez5hNld7JIfL13ZCstJI9AoICNiOVMAe9a+
         Y00e/B4z4JLthCMBc7Utfx5m9iBRobXFpVpw7aD4hONAFhfOlWdv2Ijvcf/Apgwa9cfE
         MDdY/iB0SsHinuf9wpFhO0ev9O6ei18aMaxpbgqJffPW0Z97+yF0eUqCQz6GKbJ8b7v5
         59CIkKBh5dQv3IaemnYg+cOiki55s4+UUZH89ljA2xzrr3uLqpOoVk/jz+DEhYEbRD/W
         uMeX27hoZ/R/iiOfVRg9MsT1hu3yO2JJIfqwaBJltdAfJ/hnO/ebTiVJxNc1GOQuCCzW
         tdWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786632966; x=1787237766;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=4dCHkQjg/qVtExucbStgAUbSk9OouMFE3EvSXlZAN90=;
        b=UetQvm219pcCxGSKIm4kbym8J2EZUVubEkijVWGI7pd/F8H0JzdAgJRzb2/LXBdp4n
         ZGW5+90bW75xxvtjsrzs4rwu879cMoRC1hG48WYJ+zs0CSoVkgAbrgQ7v5zHrl8Wxdqf
         6XXnjHegCdFNnwEeOMqH3glm+7wCPsioXHgN4kT6wLHW5wSrwkSHN4qEMdtHFVWvFiQv
         5A1NnRl6qoE9vG+aM3GF2RpLp7YqaxbKpQth/oTF4TifGGxeHj+IjsWLGlW87H9cbdM6
         8n9FFNGbqnEx4IGd/UhPFSwFuiGZOq0/9qPQNo5xVgokFTmf5EcZ2uTlw7e/iAf2VhrO
         zgtA==
X-Gm-Message-State: AOJu0Ywc0UXM9g1fij27movzTmaAMeKD6mUD1DB5o9BRCiGaMhn0nDHG
	FBTQ1AoPssEsCdSB0HlWHHJ2oLoktptcfKdRXDxGLQ9y+7KkrI9eR8f4v0CFWA==
X-Gm-Gg: AR+sD13b1UpwFNN1B0GQ1xaGLlCdkbfgkwWeo09UuSgX2qKlL5/k/S0mXy1ggKwOmKb
	saKcAT0zMijObQl23cVfaePHQKLiVHH/dK5roGuCH9mM4etwhD1Jr+jyL9AGKZNjZvEomYUrREQ
	bqUscMJapTBDl3tdUGsdHQ8CI2kqrjQEcFu+z1wuEf6HTSvHnzv/imzP3zTJ8yQVhpbJny7BozS
	XywqweqEjIeWlzspnJRlIMq/w8GG0/a0Aq11/gWBz7V2f2+L0JlFlqQT6YaM8pHrUSsOYvD3A19
	Cud97Mmd8VAse72DmQFVVsOUdFLtuaOfmtYKl7lt/MPI47/smxX+k+RsflOvFSknY24T64m7b/t
	qTrkzfCwFacd0BYa7e8kEClNPGbC2ULlE57Y161UB0W5A4PfYFi78GNwYgYsCmeTaIOxc7zFfFy
	h8PJvuaMRCYW/BPc6e2CK78o8vADaARtwqDZ9nP38dPvHVp4BSxFbrrYMcE4FhCXaM
X-Received: by 2002:a05:6808:23d4:b0:4a3:26e5:cc02 with SMTP id 5614622812f47-4b227aaffc9mr4723186b6e.10.1786632966291;
        Thu, 13 Aug 2026 07:56:06 -0700 (PDT)
Received: from [127.0.0.1] ([128.24.160.250])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-4b22ccb96absm1669096b6e.4.2026.08.13.07.56.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Aug 2026 07:56:05 -0700 (PDT)
Message-Id: <4521a41ff6973e87caf4727b37457685d7311b8d.1786632952.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2175.v3.git.1786632952.gitgitgadget@gmail.com>
References: <pull.2175.git.1783615780.gitgitgadget@gmail.com>
	<pull.2175.v3.git.1786632952.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 13 Aug 2026 14:55:46 +0000
Subject: [PATCH v3 08/13] archive-zip: widen `zlib_deflate_raw()`'s maxsize
 local to `size_t`
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
Cc: Patrick Steinhardt <ps@pks.im>,
    Johannes Schindelin <johannes.schindelin@gmx.de>,
    Johannes Schindelin <johannes.schindelin@gmx.de>

From: Johannes Schindelin <johannes.schindelin@gmx.de>

Prep for the upcoming `git_deflate_bound()` widening to `size_t`: the
local that catches its return needs to be `size_t` too, otherwise the
widening would introduce a silent Windows narrowing here. No semantic
effect with the current unsigned-long-returning `git_deflate_bound()`
(`size_t == unsigned long` on this caller's platforms today).

Assisted-by: Opus 4.7
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 archive-zip.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/archive-zip.c b/archive-zip.c
index 97ea8d60d6..a487d4c041 100644
--- a/archive-zip.c
+++ b/archive-zip.c
@@ -206,7 +206,7 @@ static void *zlib_deflate_raw(void *data, unsigned long size,
 			      unsigned long *compressed_size)
 {
 	git_zstream stream;
-	unsigned long maxsize;
+	size_t maxsize;
 	void *buffer;
 	int result;
 
-- 
gitgitgadget

