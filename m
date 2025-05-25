Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8D041ADC90
	for <git@vger.kernel.org>; Sun, 25 May 2025 20:27:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748204838; cv=none; b=QS+56Pk2EabtpLWoXTvHp/OHnpOxmQOmN7DpiY4rC19xha4vB61nL8qFrAXoO6L89HaT+J48HIpzRvJxQBl17MXiTlrP7LALakiO1yTQdNpOE9/97/PrFmjlakoK4aWzWjyqq4hW3POetUAxNXL9h+TwdNqcmYoFptA1hVgbLfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748204838; c=relaxed/simple;
	bh=9uFe+wBPRWjJO5GFYe82a6ZS+HHm+mJWbm4BNsNnfdU=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:MIME-Version:
	 Content-Type:To:Cc; b=rFQDY+FpD86T6YIjsfLwTIYobe79Pkm2WBg6HR7c7/26i5vovTLjB36CDGRa1K/aRhDQLUseRQhpIgBL86LGEvXfwjLUGVm6hP8PG+GySCzy0SU8+FDecSr54GhnFpkezJPiF/lO5KiaeNQQhWX9MM94WDUiyd8YRxhxYIMroqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jFrrho+k; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jFrrho+k"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-442eb5d143eso18000825e9.0
        for <git@vger.kernel.org>; Sun, 25 May 2025 13:27:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748204834; x=1748809634; darn=vger.kernel.org;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h16jpqUnafPEm0NNQeleHhQIYDZXyuIYL+GJgfQ7P7Q=;
        b=jFrrho+kVkzacErCzfwFXCuR0gmAKQnBBG/s5372FhnvrayrsKZrCqnz+34xoj2/Oy
         tnR9612k/72W/OF13cSWvrvUgw48ODr74toPqdJxYrzkykTnH4JpAez8sJZUm+3OsYNb
         Hxx6r3NoLXr9/vhed5+AIY8cqLdGustYfu5VE2uzjFdM4DZytE+9B1CaxJL7i88nLi9f
         QJvgv2WiZsv2dRpptXTyedJeNWbJOLpkAWTuijbUBE19uSWyMisEF2Q+kr1tZ/GV28mm
         2iHsj2g8t5N0pMH/UEdaQBn2R5TeLRBJ8+HNh59NtNmTMy663xY4NGofUkrjY6Yik+S7
         VSHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748204834; x=1748809634;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=h16jpqUnafPEm0NNQeleHhQIYDZXyuIYL+GJgfQ7P7Q=;
        b=YgofDyxx8yeRwii0u4tZa41FID0/Lj9ZtYZfDbpbLybCoF+NXhXzGp2wFY1MZimMsZ
         by6RVJVuCcEWRvMthESTjZRZ7F7D2hnVVbXP1Xgpb+/lTBTcdpjR+eRL8dJO47HBCLIn
         FgVS/j5u1sS2UcFpq/DcWRIe5TUNwwQ2dCeoHOumW5bX3urOLQ31OMEa6jZfSE2VcrDx
         4RD6L3+sgnoBNYEPhN1sfE86MnRYVBOpZ2+vyexHJSsZNnHd+TSB8spopKgphm6lmmDQ
         dPPFc9dcvJy61iVKT69rWJyAfM7icrTCjzRMIWtJ1wc3BNWPbsd242rhha02XSZ/aGRC
         +bcw==
X-Gm-Message-State: AOJu0YzdazSKlprMx4oXr6tp9oyiBXEmDgeos285BNEV5SbUM80rbkkx
	fv3Ms3YJG5/E1KmK3Xihyl3bJrb1+pp1vAEat4ww2K9Akj5MgUVQ/aCh6aLRBA==
X-Gm-Gg: ASbGncvwheBtXTXM0aUjKTgp2nlOjdqusg7QmnahVf8uexWKIbZGGjLDGwsvzUGLDRP
	y6On8G6jNS2xI3VmNn07dcVX0NxCXJ1v9zcG1e6XODDBFyA2ZhGYeeYktl5uIdxa4W/25+vikOd
	6QrSkVOS4bQp9rVt7K62vuswx9M8RJph+uIXqSRh6cUzmMSBrAspsMa9WJw98TI8L1LmdNYE3oS
	ZlhhtQwLPK5sKuO1+uSFhE9fWh/U9rrLh2NhQwpN/q+jfwGl7zuYhweVTmlCDLSmXo76XslIeJx
	rtNhFNpY2k+Z9i7xJl4BLs6UrRSBWsJjERX4QlAGYN8yrQo78AsQ
X-Google-Smtp-Source: AGHT+IGZyjyB9Opn6kdLl9f18eMC999aSV8XXwPZWJe4Y5nXRqnEBKzxkE00+NE+y0BOXFQ+YWYCzg==
X-Received: by 2002:a05:600c:8012:b0:43d:45a:8fbb with SMTP id 5b1f17b1804b1-44c92d3516cmr55388045e9.22.1748204834166;
        Sun, 25 May 2025 13:27:14 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-447f3dd94f1sm221006835e9.35.2025.05.25.13.27.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 May 2025 13:27:13 -0700 (PDT)
Message-Id: <038941c5be104536a4b894abb58d014a3fe583de.1748204829.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1927.git.1748204829.gitgitgadget@gmail.com>
References: <pull.1927.git.1748204829.gitgitgadget@gmail.com>
From: "=?UTF-8?q?Jean-No=C3=ABl=20Avila?= via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sun, 25 May 2025 20:27:04 +0000
Subject: [PATCH 4/9] doc: merge-options.adoc remove a misleading double
 negation
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc: Sent
To: git@vger.kernel.org
Cc: =?UTF-8?Q?Jean-No=C3=ABl?= Avila <jn.avila@free.fr>,
    =?UTF-8?q?Jean-No=C3=ABl=20Avila?= <jn.avila@free.fr>

From: =?UTF-8?q?Jean-No=C3=ABl=20Avila?= <jn.avila@free.fr>

Signed-off-by: Jean-Noël Avila <jn.avila@free.fr>
---
 Documentation/merge-options.adoc | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/merge-options.adoc b/Documentation/merge-options.adoc
index 9b3c7d6df4ef..078f4f6157a1 100644
--- a/Documentation/merge-options.adoc
+++ b/Documentation/merge-options.adoc
@@ -203,7 +203,7 @@ endif::git-pull[]
 	used to override this safety when merging histories of two
 	projects that started their lives independently. As that is
 	a very rare occasion, no configuration variable to enable
-	this by default exists and will not be added.
+	this by default exists or will be added.
 ifdef::git-pull[]
 +
 Only useful when merging.
-- 
gitgitgadget

