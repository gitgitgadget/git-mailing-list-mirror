Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 556E6156EB
	for <git@vger.kernel.org>; Wed, 18 Oct 2023 12:46:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TR6NQ9xR"
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DECA998
	for <git@vger.kernel.org>; Wed, 18 Oct 2023 05:46:25 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id a640c23a62f3a-9bdf5829000so779427566b.0
        for <git@vger.kernel.org>; Wed, 18 Oct 2023 05:46:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697633184; x=1698237984; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8NyiINglnXqXgfyAC/7e0ZTqFVw1E/00+nZ8OCRJyqc=;
        b=TR6NQ9xR9yO7yU3VpGcogrB685uvshvB9UEFJJX7UgkU/jMM4ZU8jJ6+4EFoArIuP+
         i7htYgxS++lYdg9JtufcosW4XJb7M8j9NSfPxK2cBYHygN33Jo680EwVP3r4wmABEj2a
         h+er90g5ZoYwvoFlz9DFsNmy0KtA7CTYkO1bWSgwoDQXhXRJjpISpRFcg7KnSjCm2ZfG
         NlJASFaMmOTiPpoE0VdWjsyeAVoi1gOnSlmIfZK+Xd2OcOFWdU9fTj4d7TsNPBnWhaI8
         hXy0NNh1WOJ1tvlxARHgv6nPjD9gfIH5i4ZOzTuWUzJ0eO68+yR5OD9VyYtCjHOCushw
         JiNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697633184; x=1698237984;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8NyiINglnXqXgfyAC/7e0ZTqFVw1E/00+nZ8OCRJyqc=;
        b=HlveFPVjEyjGhlXMykYY3mXM5NHrwE6rkJhVe5m+0tZEiGXvskdMMj0NTPZayPD1lE
         FHBaWBrF+72TkR0Rv23DVKu1bNaLngekY1FZeBHMRTRpNCPJCoFOLc5S4NTv+wcTXHOX
         /aUpxfBm2D9Ah/S6Q7RiY9agY1Yv2XzK8UX0IHo/2X7KPz1LSD8qnhdC/JThRqmdyMpE
         THroeUYOavoRMWcgRo2hNWJo1PJEpFYuOfT2VrCfArUuvWUi974FleQK561TDv/t3fGN
         sbbgC5nMAKnxMIa3zipQDMTI3Sw1NKrmJ+ds4pZmSsG6zkM5Mqf3H60cTizC6GAqDv16
         hpzA==
X-Gm-Message-State: AOJu0YwlfEDQyf0kgrboYiMhF/h6ry8GXIdqvcJ6hNsSWtfINCnt6N4J
	03rMJ+ZzdLcjEvqwPQmiqOVZwDxMIZylfr0=
X-Google-Smtp-Source: AGHT+IGTQCaPcFxFecJT3h1Jbf1HtXEID6Vbl8CKD6abtLww02QJYVdQfHE4NvfAFeLMBV1sBI+oYA==
X-Received: by 2002:a17:907:eab:b0:9b2:abda:2543 with SMTP id ho43-20020a1709070eab00b009b2abda2543mr4829918ejc.65.1697633183860;
        Wed, 18 Oct 2023 05:46:23 -0700 (PDT)
Received: from dorcaslitunya-virtual-machine.localdomain ([105.163.0.137])
        by smtp.gmail.com with ESMTPSA id g19-20020a170906395300b009b2cc87b8c3sm1606862eje.52.2023.10.18.05.46.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Oct 2023 05:46:23 -0700 (PDT)
From: Dorcas AnonoLitunya <anonolitunya@gmail.com>
To: christian.couder@gmail.com
Cc: anonolitunya@gmail.com,
	git@vger.kernel.org,
	gitster@pobox.com
Subject: [Outreachy] [PATCH v2] t/t7601: use "test_path_is_file"etc. instead of "test -f"
Date: Wed, 18 Oct 2023 15:45:12 +0300
Message-ID: <20231018124538.68549-2-anonolitunya@gmail.com>
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
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Some tests in t7601 use "test -f" and "test ! -f" to see if a path
exists or is missing.

Use test_path_is_file and test_path_is_missing helper functions to
clarify these tests a bit better. This especially matters for the
"missing" case because "test ! -f F" will be happy if "F" exists as a
directory, but the intent of the test is that "F" should not exist, even
as a directory. The updated code expresses this better.

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

