Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D37757304
	for <git@vger.kernel.org>; Thu, 11 Jan 2024 20:24:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mAAvw/QE"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-40e586a62f7so25353365e9.2
        for <git@vger.kernel.org>; Thu, 11 Jan 2024 12:24:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705004674; x=1705609474; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D9vmFsAbf2tGEgXK5XRtlPnSYwJuGcsi2DCZKBbDduE=;
        b=mAAvw/QE8OADn/D3CW8HDx9VGAH1Uk3aWqH04tYCamfMN3wFU3+dtUsxX9j9sFISFx
         ItjU5JXh0K2VDuhlLQMCi75TALHdIaC6NJ4HnShn2WdHFKm9QyYMIS7Np/TiiwmksN5x
         +Ktjn8QJdpnkD8yJVfmgxWcENsL730f33QxD+SVWCAnCkFmyQ6t7N+Fg+svKF1TAWNfB
         iP+ZNbbQmocjd31tmFsvS1oND/lGBOskRdX0mQTVjRXcCcPLjZhs7ijB8wHF5Q8ED9kF
         fA58bKHJhn89S5GSCBC5u4RGWZwIFqZNQgWnGKknAGrV31xuPGJPnKgHvoESUp5P6hvY
         MUrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705004674; x=1705609474;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=D9vmFsAbf2tGEgXK5XRtlPnSYwJuGcsi2DCZKBbDduE=;
        b=dHEGWjURfTZJAdZRVC62aU+BOW4Ecf9uq+uwI8jKGGZANSsWu2vkcnkdJB6v7i+zRU
         a5EuX5+LufVZlHm2G4mKSt5RVKihlYAKLUNXWZAkdq7KinzFnjtsFotBNshBH2vIsCyc
         kOtKcqZsoS0aZwm6Cz3hCspOjW+R9DhzkKdrKnmKI6AkdBPpjA5AhzGwmzEQvoBKrz4j
         VdbdT/h/5vaDPnCGihIuHEN38nDKaUPth20pCaeawtkAwTfiEImIxu9ZhwXjqRHSU8ni
         ZP0yXalBIC4zoP9fIixxblxMG7Ivqsig/q8L+NK3vO3FQZLLDvc30ZB2x2C0ZD3GZGEU
         PlaA==
X-Gm-Message-State: AOJu0Yw+Msc4KnGExFtYl/hfQwxyhd3m9Hb9owCCMFrCryvoffG0tyhz
	mZzc0t6cO8ouaMmzstD0aqK+H3DGyxE=
X-Google-Smtp-Source: AGHT+IFqCvtk2ywF3WPwAZXav53a8c69QTwP5OTdhrLWfOkCSl2/sqbOw9AV1zX+/BQy1XfWB1gqDw==
X-Received: by 2002:a05:600c:4686:b0:40e:3511:2c39 with SMTP id p6-20020a05600c468600b0040e35112c39mr245555wmo.172.1705004673668;
        Thu, 11 Jan 2024 12:24:33 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id m26-20020a7bca5a000000b0040e54381a85sm3056983wml.26.2024.01.11.12.24.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jan 2024 12:24:32 -0800 (PST)
Message-ID: <f953a668c6a7e0a57adcee77ceee2d578970065e.1705004670.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1634.v2.git.1705004670.gitgitgadget@gmail.com>
References: <pull.1634.git.1704912750.gitgitgadget@gmail.com>
	<pull.1634.v2.git.1705004670.gitgitgadget@gmail.com>
From: "Justin Tobler via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 11 Jan 2024 20:24:30 +0000
Subject: [PATCH v2 2/2] t5541: remove lockfile creation
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
Refactor the test to create a d/f conflict via git-update-ref(1) instead
so that the test is reference backend agnostic.

Signed-off-by: Justin Tobler <jltobler@gmail.com>
---
 t/t5541-http-push-smart.sh | 18 +++++-------------
 1 file changed, 5 insertions(+), 13 deletions(-)

diff --git a/t/t5541-http-push-smart.sh b/t/t5541-http-push-smart.sh
index df758e187df..9a8bed6c32b 100755
--- a/t/t5541-http-push-smart.sh
+++ b/t/t5541-http-push-smart.sh
@@ -232,8 +232,9 @@ test_expect_success 'push --atomic fails on server-side errors' '
 	test_config -C "$d" http.receivepack true &&
 	up="$HTTPD_URL"/smart/atomic-branches.git &&
 
-	# break ref updates for other on the remote site
-	mkdir "$d/refs/heads/other.lock" &&
+	# Create d/f conflict to break ref updates for other on the remote site.
+	git -C "$d" update-ref -d refs/heads/other &&
+	git -C "$d" update-ref refs/heads/other/conflict HEAD &&
 
 	# add the new commit to other
 	git branch -f other collateral &&
@@ -241,18 +242,9 @@ test_expect_success 'push --atomic fails on server-side errors' '
 	# --atomic should cause entire push to be rejected
 	test_must_fail git push --atomic "$up" atomic other 2>output  &&
 
-	# the new branch should not have been created upstream
-	test_must_fail git -C "$d" show-ref --verify refs/heads/atomic &&
-
-	# upstream should still reflect atomic2, the last thing we pushed
-	# successfully
-	git rev-parse atomic2 >expected &&
-	# ...to other.
-	git -C "$d" rev-parse refs/heads/other >actual &&
-	test_cmp expected actual &&
-
-	# the new branch should not have been created upstream
+	# The atomic and other branches should be created upstream.
 	test_must_fail git -C "$d" show-ref --verify refs/heads/atomic &&
+	test_must_fail git -C "$d" show-ref --verify refs/heads/other &&
 
 	# the failed refs should be indicated to the user
 	grep "^ ! .*rejected.* other -> other .*atomic transaction failed" output &&
-- 
gitgitgadget
