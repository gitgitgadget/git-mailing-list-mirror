Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03D1057301
	for <git@vger.kernel.org>; Thu, 11 Jan 2024 20:24:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KPu42hkW"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-40d87df95ddso59337105e9.0
        for <git@vger.kernel.org>; Thu, 11 Jan 2024 12:24:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705004672; x=1705609472; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vk25/eZlxl8u4iPIA5L+Ftvzh5T6CrtWT2SShPD/2p8=;
        b=KPu42hkWqsfLb6KBiZKT0Se9gqgA5sGAvV+ypBzTKAfNIqFb0wqpN0+XUf4fOzyQoQ
         mOwfltsCwuqlVaf5Hp1/UMEnSWIy5NQELp9GzLgHJ8GBB6SZFUNcQ7s48PErU9utvupc
         rOmhTv8xHkDnnYx3seYx79eDdxVMSSyIIKIhuFUwtKevqyfCs55O553Xb6fPAbjNBhFB
         eKEWQknmTI83tKr1iur+m4A0QfIa6723PYLH+16qLoq1FkrhLyHrSmJFP8f2Cuj8EaKH
         /2cfGl64oRV9Vdo7A5Ul26WfcdTHMquscMwvvBZBmPDh1NnCK6Xu9i0ZJ1ban+n1fT5u
         LM9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705004672; x=1705609472;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vk25/eZlxl8u4iPIA5L+Ftvzh5T6CrtWT2SShPD/2p8=;
        b=MLvuUWfhnkX2Ak8PNhFHkBWMXAXoXjaX3WZ0tFdXeRIdrq52I3g2yYBvcM0j0BKlWe
         hp/FeDwGzzS1+tyMS8hPRBi/Bz36Oah+Bh7fCmBflgR1bSNAS1o0ExDFmdceq8CXN3Yb
         QakNt+LEqX5zCrpC0ZYRoSXRPjfnDVvjf/j4fVADsX6GxE0ZFhSoz/WlshwpuaP8rBqw
         /aiOuFeUqebbVynt/aXwIrRW+pYz0Y2d6CFyLUeb9IcVt/417yFdGlH5byIemuh9Xc02
         LUAGl8py5ItF3eaKqiDtS5ikJJTymaZSsbEzao/OR+bIE/cFfuqPAcPVzQPkMOZGi4aE
         yIgw==
X-Gm-Message-State: AOJu0YywvPPmGP6etDAAB0464Q4nqYxvs20RXEkKvSUeTYwUvBlPThL3
	klz00FSJrq0i28BwxRave9Tzb3oKy/g=
X-Google-Smtp-Source: AGHT+IGTlCc0SSrgmllLg/USs189yTaXBmPtmfTDAWzRXkSMaxZ+kRQF1TviTfjP2CwKphQCoNoZAg==
X-Received: by 2002:a05:600c:1c1e:b0:40e:35c3:3720 with SMTP id j30-20020a05600c1c1e00b0040e35c33720mr113487wms.23.1705004672149;
        Thu, 11 Jan 2024 12:24:32 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id q20-20020a05600c46d400b0040e395cd20bsm6972542wmo.7.2024.01.11.12.24.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jan 2024 12:24:31 -0800 (PST)
Message-ID: <714f713ccece4a9dd167b3b73a71c068dbe91f53.1705004670.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1634.v2.git.1705004670.gitgitgadget@gmail.com>
References: <pull.1634.git.1704912750.gitgitgadget@gmail.com>
	<pull.1634.v2.git.1705004670.gitgitgadget@gmail.com>
From: "Justin Tobler via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 11 Jan 2024 20:24:29 +0000
Subject: [PATCH v2 1/2] t1401: remove lockfile creation
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
Cc: Jeff King <peff@peff.net>,
    Patrick Steinhardt <ps@pks.im>,
    Justin Tobler <jltobler@gmail.com>,
    Justin Tobler <jltobler@gmail.com>

From: Justin Tobler <jltobler@gmail.com>

To create error conditions, some tests set up reference locks by
directly creating its lockfile. While this works for the files reference
backend, this approach is incompatible with the reftable backend.
Refactor the test to create a d/f conflict via git-symbolic-ref(1)
instead so that the test is reference backend agnostic.

Signed-off-by: Justin Tobler <jltobler@gmail.com>
---
 t/t1401-symbolic-ref.sh | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/t/t1401-symbolic-ref.sh b/t/t1401-symbolic-ref.sh
index c7745e1bf69..c67e5c134d9 100755
--- a/t/t1401-symbolic-ref.sh
+++ b/t/t1401-symbolic-ref.sh
@@ -106,9 +106,8 @@ test_expect_success LONG_REF 'we can parse long symbolic ref' '
 '
 
 test_expect_success 'symbolic-ref reports failure in exit code' '
-	test_when_finished "rm -f .git/HEAD.lock" &&
-	>.git/HEAD.lock &&
-	test_must_fail git symbolic-ref HEAD refs/heads/whatever
+	# Create d/f conflict to simulate failure.
+	test_must_fail git symbolic-ref refs/heads refs/heads/foo
 '
 
 test_expect_success 'symbolic-ref writes reflog entry' '
-- 
gitgitgadget

