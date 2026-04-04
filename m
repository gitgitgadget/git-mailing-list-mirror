Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55D73344D99
	for <git@vger.kernel.org>; Sat,  4 Apr 2026 19:50:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775332213; cv=none; b=h8pELtm1fRrhIXdd1ZoW7Rdyp9IK/HMYg9rlblAHTNq1rYA6N+gvBF0N2W2ZCZwAXFdKMjtir28RR8jGzEbewOidUEDc8yin8KbdVbDQfiAItfhs2n2LHjX1ZyXZEnXN2yFzylWvaeYe3ru9d6HVAHUMTcSuP8LIT+sRlUs2l6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775332213; c=relaxed/simple;
	bh=kQ9Avs4yY2K1gcMg4XJfpdio13fVqPse/J+5ReUjnwE=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=VuaDpLi+oyT3rPoNi2yK+CuNhBapg9VhKGuYX9Sl0f+Avlp/7cQsgtkvzFopVzVdV1M1YR+xxZt00axNZsXgm5xvrtMp1ZETRvHAJTIzGpxYE5ycO41l/P6gEU0GtZGJ0ea+joNR9nWhqycZDd94a4GfcsIS2A/C1FiIuje65FU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IU4QS5+h; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IU4QS5+h"
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-50d87610513so412411cf.3
        for <git@vger.kernel.org>; Sat, 04 Apr 2026 12:50:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775332210; x=1775937010; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OACAOTDQZSPNNnO+8JALVeaBLvs5HbU36kTdS4r622M=;
        b=IU4QS5+hPP6YqqBwlPzuqT9drXlVJ4VcIX3qseQo2z03LeuVnuouzuGkKBM5MikFCQ
         hU0hEguX4RFNIWIvc2vOe1xVH6le0qbmdJgQzVy8lR6EZhRxOBioj2tc7BkXE0wXnQ2N
         IfDK7hws57j9aI6jNAg6q1XdR5ijM2qVcztx2wDgj/Hkos2QXMLp8ivjuezg1LZ2pwMZ
         hh/O3GwmCwTPB+PIa0bCjfnSZHqxUArs+yoYpBor/+mrZHaJHET7iTcxs52T9F9hwvXd
         yU5HlpI9+Rkzf0TPuMl8gQVeBdIUosPkjSBcp1ggh9gmHA5d2Hx5Lh8GW45R7F0s7UnL
         ld+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775332210; x=1775937010;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=OACAOTDQZSPNNnO+8JALVeaBLvs5HbU36kTdS4r622M=;
        b=BOqEOwu0md2r7k3DrSRooG7Ad5aAAyGYWB6nEMTwdmVtf/7nB0KSrCqq4kxaaZDuWJ
         Ukcp23TsR6hHVGXrplhLWXEUpKAK0N/vwfcyMkHPeoSkmlCPDXHA0fmiUrKkwAY/JKOE
         LGN35gPVpp7nO0+s3YHmO5VSsRYImJ5Cbw5CEt1hGHZJL+LqSLRj7mEtduOail2JLPcS
         gqiinOlILybkNCTOp5Ljf20AVifnA2dAomAb24OirQJ6+uG07iegNybOXDJUPGseGy6R
         Ux8Nu+I4zhchUxbBI+wla3Cecn6hDRZg/SvGtVxJJNrrXLnW3pKipJ0zPQPbCqGpP2Pn
         W3ZA==
X-Gm-Message-State: AOJu0YwlBDXlj8LYJxIB8gY1wkUcxI1xn0JtyEZT1yGkA8/5vZHfpxb1
	KXqefi5BViCrZNeFSYSpvGPfSOpYMX1++SvJR7JLNn86cO/+xOHY7sBeNdd+kA==
X-Gm-Gg: AeBDiev08PmOCIZ8A8ALPMW2siaRIwZ2nf7OgAmmQxsZGpzUPlV30WcZx7i7rSn/FJB
	AJKlumaUYoxVM0qLtJbckp5Nf1WNpkv/fY8BQV8LZ8PJTZ8FTKn+yQ5DH5pUoBhbvZfiP2r5kwR
	OjLaU9KrcOqlqGM+dmGqzZHh+DisM0NPswMDfZY3VbOrF4QDDU6mGe9H58HBeBvmsvkhAbOnNab
	hBQpwP58LV2u5uhgoRMHt5lf3/UomVsjKjMUK6X0++RpxRlR1VIkXtJs86KrA6P051LJmnDDf9s
	Shw/pL6wlHlDLNpu2gEy3B9eLB7/ur/DQfw6odn06cjmqli5dgs56mbGmtQdueVZ7kXcnqJoOLC
	AcoN7IV49R1qUlK7LL731pbCfn3+kqAVRDAEgAEhKmey8BkrVS4k5TJ102a5/lcH7dypfsI9Vzo
	S7drP9uGKDI6gvaO0Ijy0rqigHaIQ=
X-Received: by 2002:a05:622a:17c9:b0:509:379b:d4d with SMTP id d75a77b69052e-50d62b32330mr131015791cf.16.1775332210587;
        Sat, 04 Apr 2026 12:50:10 -0700 (PDT)
Received: from [127.0.0.1] ([57.151.121.197])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-50d64752857sm45689311cf.21.2026.04.04.12.50.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Apr 2026 12:50:10 -0700 (PDT)
Message-Id: <6932658411309228d2d670d9b6c2e4be4f17f985.1775332197.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2076.v2.git.1775332197.gitgitgadget@gmail.com>
References: <pull.2076.git.1775140403.gitgitgadget@gmail.com>
	<pull.2076.v2.git.1775332197.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sat, 04 Apr 2026 19:49:50 +0000
Subject: [PATCH v2 10/17] t5505: export `GIT_DIR` after `git init --bare`
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
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
    Johannes Schindelin <johannes.schindelin@gmx.de>

From: Johannes Schindelin <johannes.schindelin@gmx.de>

To prepare for `safe.bareRepository` defaulting to `explicit` (see
8d1a7448206e), export `GIT_DIR=.` right after `git init --bare &&` so
subsequent commands access the bare repo explicitly.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 t/t5505-remote.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/t/t5505-remote.sh b/t/t5505-remote.sh
index e592c0bcde..6d3d8510ca 100755
--- a/t/t5505-remote.sh
+++ b/t/t5505-remote.sh
@@ -561,7 +561,7 @@ test_expect_success 'add --mirror && prune' '
 	mkdir mirror &&
 	(
 		cd mirror &&
-		git init --bare &&
+		git init --bare && GIT_DIR=. && export GIT_DIR &&
 		git remote add --mirror -f origin ../one
 	) &&
 	(
@@ -583,7 +583,7 @@ test_expect_success 'add --mirror setting HEAD' '
 	mkdir headmirror &&
 	(
 		cd headmirror &&
-		git init --bare -b notmain &&
+		git init --bare -b notmain && GIT_DIR=. && export GIT_DIR &&
 		git remote add --mirror -f origin ../one &&
 		test "$(git symbolic-ref HEAD)" = "refs/heads/main"
 	)
-- 
gitgitgadget

