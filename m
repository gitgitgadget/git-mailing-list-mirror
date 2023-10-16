Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B44228E22
	for <git@vger.kernel.org>; Mon, 16 Oct 2023 15:21:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Du2wsLFY"
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E35D3EA
	for <git@vger.kernel.org>; Mon, 16 Oct 2023 08:21:39 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id a640c23a62f3a-9b2f73e3af3so714471866b.3
        for <git@vger.kernel.org>; Mon, 16 Oct 2023 08:21:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697469698; x=1698074498; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=vBWhTf6YgDj4Lk8hUuMTLAH3soVsOQzAyyqBcPxSZQI=;
        b=Du2wsLFYOaYuWs2LEDEppp43ikOMXABIFrRRlxsatGFCHZUdFhszhoDHKeNuPc6SaF
         RbYqHISbNnK6HgQfDU2vS8AhuU70/ryGog6RyRb/0dIGjpUICmRVmNygsBk+Be7ZMAkD
         khN6NZqZvIwzn8Q1mVHmtok9cJHgAJSRgviDmtCufoIJIq02+FvFY+Skyr5m83JnSf4/
         VKM4MCbgyt99PsQgtNusrsK265IGGk4lEFFISnxCI2vPU3kJIsJ1B04BafNzU8h2si6D
         6a/X33MzMFuHwxx2XfQEBUbofNMMCaQYxceUjwqDRAYwkjP+wjsev3R07Z6CioXgPo3O
         RXpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697469698; x=1698074498;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vBWhTf6YgDj4Lk8hUuMTLAH3soVsOQzAyyqBcPxSZQI=;
        b=lXuLL17ZqOemhlxREIwb/54BUFnYS7am+DwWYaSID9gVL2dxnFwotxehJGSEA1ZTmg
         t/s0RpFwoqxtEYq27ar4q1CHLzy4FlYxkzIBmsow6+uXdTlhiZ9RDnif9JSK+2oBpUIe
         mRW6GCptLUhPtt6+1U/YQPRPfptQu7dyFaK59zN07axcKk8MCG+xC2rkXBBpZtLfUZ7S
         9CLleT04jnn+n2XTJPypAnzbIjHdgwD37bPOcdHTX8MAnQE2n2+SNGdPPOaZIL3KZPtf
         MmlKzoWWW9PITtNbaIgB1qvLjSxbdQiCHW4peiLXGe2h6GALMOL+FtmEkyPnPULjaT3f
         LIYw==
X-Gm-Message-State: AOJu0YzAuYHIT/pojfu4ZpefOJYJ8aAMVczzEhjs5GWFeREjmLqPdLvT
	RJXujuvsDI6B1TRcns6pFg==
X-Google-Smtp-Source: AGHT+IEZyKUaFuady8YHFB1NGRyMxRkln7XJpuJSAF6IQVsZd0L5orZYRFgyBChPRZFxSKyerVs28g==
X-Received: by 2002:a17:906:30ca:b0:9b2:b7f2:bc7b with SMTP id b10-20020a17090630ca00b009b2b7f2bc7bmr28000556ejb.37.1697469697889;
        Mon, 16 Oct 2023 08:21:37 -0700 (PDT)
Received: from dorcaslitunya-virtual-machine.localdomain ([105.163.1.143])
        by smtp.gmail.com with ESMTPSA id 30-20020a170906009e00b009ae587ce135sm4219609ejc.223.2023.10.16.08.21.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Oct 2023 08:21:37 -0700 (PDT)
From: Dorcas AnonoLitunya <anonolitunya@gmail.com>
To: christian.couder@gmail.com
Cc: anonolitunya@gmail.com,
	git@vger.kernel.org,
	gitster@pobox.com
Subject: [PATCH] t/t7601: Modernize test scripts using functions
Date: Mon, 16 Oct 2023 18:21:00 +0300
Message-ID: <20231016152113.135970-1-anonolitunya@gmail.com>
X-Mailer: git-send-email 2.42.0.345.gaab89be2eb
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

The test script is currently using the command format 'test -f' to
check for existence or absence of files.

Replace it with new helper functions following the format
'test_path_is_file'.

Consequently, the patch also replaces the inverse command '! test -f' or
'test ! -f' with new helper function following the format
'test_path_is_missing'

This adjustment using helper functions makes the code more readable and
easier to understand.

Signed-off-by: Dorcas AnonoLitunya <anonolitunya@gmail.com>
---
 t/t7601-merge-pull-config.sh | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/t/t7601-merge-pull-config.sh b/t/t7601-merge-pull-config.sh
index bd238d89b0..e08767df66 100755
--- a/t/t7601-merge-pull-config.sh
+++ b/t/t7601-merge-pull-config.sh
@@ -349,13 +349,13 @@ test_expect_success 'Cannot rebase with multiple heads' '
 
 test_expect_success 'merge c1 with c2' '
 	git reset --hard c1 &&
-	test -f c0.c &&
-	test -f c1.c &&
-	test ! -f c2.c &&
-	test ! -f c3.c &&
+	test_path_is_file c0.c &&
+	test_path_is_file c1.c &&
+	test_path_is_missing c2.c &&
+	test_path_is_missing c3.c &&
 	git merge c2 &&
-	test -f c1.c &&
-	test -f c2.c
+	test_path_is_file c1.c &&
+	test_path_is_file c2.c
 '
 
 test_expect_success 'fast-forward pull succeeds with "true" in pull.ff' '
@@ -411,8 +411,8 @@ test_expect_success 'merge c1 with c2 (ours in pull.twohead)' '
 	git reset --hard c1 &&
 	git config pull.twohead ours &&
 	git merge c2 &&
-	test -f c1.c &&
-	! test -f c2.c
+	test_path_is_file c1.c &&
+	test_path_is_missing c2.c
 '
 
 test_expect_success 'merge c1 with c2 and c3 (recursive in pull.octopus)' '
@@ -431,10 +431,10 @@ test_expect_success 'merge c1 with c2 and c3 (recursive and octopus in pull.octo
 	test "$(git rev-parse c2)" = "$(git rev-parse HEAD^2)" &&
 	test "$(git rev-parse c3)" = "$(git rev-parse HEAD^3)" &&
 	git diff --exit-code &&
-	test -f c0.c &&
-	test -f c1.c &&
-	test -f c2.c &&
-	test -f c3.c
+	test_path_is_file c0.c &&
+	test_path_is_file c1.c &&
+	test_path_is_file c2.c &&
+	test_path_is_file c3.c
 '
 
 conflict_count()
-- 
2.42.0.345.gaab89be2eb

