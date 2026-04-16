Received: from mail-dy1-f177.google.com (mail-dy1-f177.google.com [74.125.82.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E20C3BD64D
	for <git@vger.kernel.org>; Thu, 16 Apr 2026 23:36:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776382604; cv=none; b=buhjw4NpLy188iw34ofiAUP4CuFlF+Mm1YRGWg+XetNHrOaGuv38RVoqa4a7nriE8XB8I5Bi+dkzhEH2Vw/RV+7VTqFWn8wjw1t9ZY6IX0gLNBHKJSSi8sgCax6yu4yl7ZeTAJnfuiSQiSm9rztcZYkVMFPq1yBZseJZ7p9gjIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776382604; c=relaxed/simple;
	bh=gw1zX/yQfLVbyIEuxI8lkhBpp07asJCXcMfQe5JUF7w=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=QQW6Dv99+wKRYoIU3ZtuFjBpSo9gnpT8VjeLTxvUJ4hE8q1oMZdhK5XJT/p0+O6e3a2aQx9JHCjvY8cXaIjOPQ2pD+/GqMmZ6c7ShMxuCcWdu3/zMC9zi4Z9rIzOCHI43gYp78IpmLqF5wj1jUN5M8teRSc0mgg3lqg/7ZlXD1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R4M+QOvS; arc=none smtp.client-ip=74.125.82.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R4M+QOvS"
Received: by mail-dy1-f177.google.com with SMTP id 5a478bee46e88-2de831d2b20so140409eec.1
        for <git@vger.kernel.org>; Thu, 16 Apr 2026 16:36:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776382600; x=1776987400; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZUUPV3hXpnT+U4qwNJBBSUk2Vmu2+uGeXfDsdDof0FQ=;
        b=R4M+QOvSTxzdJxFy0+H0BSUwg/8inHuOiVX2ryNEDeOq7OcKm7dL/5VJ2vfRmW1r5L
         RZ+hYo1HH8geeRb/N6QuchLA3zNWLaS+QWsuyZGGiLDJSWKCt3tVCvXSI4ipQXwP7WS7
         CwAJLaOnEEsz5Jz0BMMJXbUhVwxNryAVtciOSzd05896+O9Fqbh0dA6oIu48A3Md1vjQ
         NGNr7Rb9H4urrHf1oaJEzjluPZ5TVXv1B6r1i8Jody4xkDM31etZfYZ9hVH7G2syRBkj
         py6wKXJAHUVLjusHvWEiKT0c8qGwUgnimBCyzk9/jBoS60FaSIULWDK1Itj3J08nNmtx
         AcFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776382600; x=1776987400;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ZUUPV3hXpnT+U4qwNJBBSUk2Vmu2+uGeXfDsdDof0FQ=;
        b=WWivBfW1mi6TIvP4UcLidK4f0/nEsBuFv9aqsle/44qC5/aFoSWnBl5O8zjJdZKsiE
         M7gm+5MMUwP+iG6odBsSwqRfbDkHGp57F7fpat7mUJlqI0bZFlHEWgTkb38vw8di65sm
         GiHk0lUNRyTxFdM2m+vUooV5OtXy0wBAAFD/DaaPgwAbHtSTwnnFLGR+HpqnPF1SfD/2
         XrfTqIk5vCy2Ukgjfk+LXh19S4qZALF/7TTp34l/UNbSXy4WZYdqi+7M9Tctt2pzxbvC
         ctoeOd5W3cpX6scG5HYLC/3Hwvu3to7ls5lpMBA28RXqJmpK9R6wyYJ7kDanKbjJSJPm
         Grbg==
X-Gm-Message-State: AOJu0YxXe6n3yiGZYGJt81sHUolGyNuh20MjzMDt0BTR9zeWAp/Pr4KJ
	bjTvpwEOEthCishwprst/dNFVjYu8pedXpg/L0SuF8VTHwSc2Rz7XExLdL2OJg==
X-Gm-Gg: AeBDiev80/hj1+Fm2+ivRk3ib6APn4eqkUaXrUrWY3/Nyq3T9GLbo1egG7HGouEORAS
	+vA4AZSKLsGazgkudSVUg57ojLj53aPLSQ1MXlKyZ80+NQcQ8g5w0MpLDpvItzuncBXmxNkiX0s
	3FLK7Db1C6a6zANk+jHsR6IWWwoJPkkZwiho+dKWfphUN2ExvtZfuowWLMgWSspq3uCgbeVBYWO
	7qb3nSvwLSAHgOGMeHMkQzI5OGm0Tt0ftg+qIkg7kjILiPMbE0s8IdQ/6GF5IfeypEOK/cIYDcv
	al2/aPE46s9Jpn8kFKQEqmpowDgbQRF24RYV2AYc12yC7E2n8/3gQT6ByIF0ozjfNd+P2wJHFmT
	MUNlfE2Cl5KaDZmHilA/1+MgPekZnMR2xtrGAz70/X0tla5BLVzu36rJmKaqj3mHvzPxt0vITTW
	YGTt98DsiIGWjBV9H8jMlCuCxGPd88xLG0C6w=
X-Received: by 2002:a05:7300:b58a:b0:2d4:62f0:b2d4 with SMTP id 5a478bee46e88-2e4786461b4mr197358eec.13.1776382595690;
        Thu, 16 Apr 2026 16:36:35 -0700 (PDT)
Received: from [127.0.0.1] ([52.161.51.70])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2e4d5fc3f1bsm196019eec.25.2026.04.16.16.36.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Apr 2026 16:36:35 -0700 (PDT)
Message-Id: <0b7a8230cfd89644b8cd932994362b7d2529b67c.1776382591.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2092.git.1776382591.gitgitgadget@gmail.com>
References: <pull.2092.git.1776382591.gitgitgadget@gmail.com>
From: "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 16 Apr 2026 23:36:27 +0000
Subject: [PATCH 2/6] CodingGuidelines: fix subject-verb agreement
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
Cc: Elijah Newren <newren@gmail.com>,
    Elijah Newren <newren@gmail.com>

From: Elijah Newren <newren@gmail.com>

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 Documentation/CodingGuidelines | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/CodingGuidelines b/Documentation/CodingGuidelines
index 4992e52093..2aafcec40d 100644
--- a/Documentation/CodingGuidelines
+++ b/Documentation/CodingGuidelines
@@ -688,7 +688,7 @@ For C programs:
          walk_dog(dog[1]);
 
    Cases where the array is employed as a whole rather than as its unit parts,
-   the plural forms is preferable. E.g:
+   the plural form is preferable. E.g:
 
          char *dogs[] = ...;
          walk_all_dogs(dogs);
-- 
gitgitgadget

