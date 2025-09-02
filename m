Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A473A2E62CB
	for <git@vger.kernel.org>; Tue,  2 Sep 2025 07:05:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756796744; cv=none; b=cFTMzUcM/fZxbF5o+gte7LsVXIRuh7u7QcbSBua6Kg972vra8Jb7FQcFDQJU3dFEkLyJ73kbOjSTmZR0R03BsGK3+HuuM9PKUjz6i0SY3jKPHFg1EuJJmdMvHdeNAEukruhUy07sFlsSc5fdOD5z/EQyQ/UU6Qd6IiaZpl6Hi8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756796744; c=relaxed/simple;
	bh=pwOb9lmrFE8qa0UNao99t6QlWfiSZHmMC2/xDECdNGU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nxGFOFKRlEfHrvxq1B0w8l5JHQnGl6TIWCiOgDWQC2xEkrjUp6DxynxyAcpf74ArPe66hmYv1yKS2IG2eZkGwvY6jURl1dKLDRaLGHefrj1/yrdEmZLOYlqfVE0xMqugzt2EJvXHNfXksgnzL2o02gUm/NijS/0b+FTJLqCcT28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Msvkuazn; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Msvkuazn"
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-afcb7ace3baso282833866b.3
        for <git@vger.kernel.org>; Tue, 02 Sep 2025 00:05:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756796740; x=1757401540; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0lEd8/pkmnE0QGhd8DeI+UIBikW61rz2ZLJEGmEot0s=;
        b=MsvkuaznzDdStlbI8IyVh3jJc1B3Kdmfh3A6QCqugjnSdJpg7MQvRJ3YQcpqHYttI+
         SRLDjHYnC5Lh1KwNW7zdLdesgjIsFV1VnTv6WANMB1Xh7xGOM3vskGKtJOoin25JdNNa
         ZBQndu72YfRl5U/L6EzfT4lNYRQB1fXalUgZfc92U03sO8R1Igt0dKbxvv0xI98zMGpE
         Vsd17EPs2x1dWBoweILGbd3GNFFkHXoejDnX3q1hw8Dv9QV1jps/5MjpxBPrDA623Dvd
         CXAY1OozXXO6H3nmuJhdqhvz0pDE2Td3NiODEqzPyfQfVXDVI5KNg7ssuGiN+W5EKiiL
         ONmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756796740; x=1757401540;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0lEd8/pkmnE0QGhd8DeI+UIBikW61rz2ZLJEGmEot0s=;
        b=d9wwrbgOLPCDmUSmOv1UtVJXjz5q3qBYpKaOc11KvC69NaSdmxthyXvaPrnq+5lxuW
         BM7HypUDonHPngnzCnm7UP/O+xORBpbGqwJV8sUCbe/VQ41X6T0CAQXVOoblH8tRSCdo
         41cOSW7X7hLuA6ynffi27yYp7eT1P0WD4hYpa7OCSOyCKefBfapj+CQmODyWIRMwUYws
         bhbu9oc7KnqaKqtnPjm/BpfCNFQmQyB+vP76rJhlJZPPQbIGOwxL8ksk6lMMKtdtj+6r
         qhDNyxX/zxL3DL2mIXtyfotovOH4Bg4ovwK1nn+ICj5LVHLeL6xHulGOG5mQ9PqdggAe
         SLaQ==
X-Gm-Message-State: AOJu0YzLp0E4Nbh4sKQHhJJbB90hBOi+8LJkxaNqlGu9aNkcu9/Mc1Tf
	XPuui2znVEXSjv0hFm0Y8nMhtbPvclPGBoTIUEUwI4rhhab7VM1QFsyGAP8rLA==
X-Gm-Gg: ASbGncunV9CZVUdR+KEQIq6Ji1znmqzfaCaF33XBbiN7SOHD0bptyUcw94OU7p3jvcZ
	eQvwDT4VcrPcF+kAWYKVttC0fxEnNG6Zn+yKcS65umS1SuDPHsXEhI/Od9KQB8Wvze5QwBVooRv
	1j4k8d4JIhcNqkQBjSHIAKbeG6LXQALAaEpcoLyWDgviBO5FQ2fx0dUOqTAC97JMaC4V3SEuiuy
	NLaEAhGoWFq9Du7WXeb7CYoeoAT/l0+gU5ValRJvJTTTF76pvErPUFPH1hlOXJwhMFRUp0jCght
	eaP5r6A8RrE1hY5Tz7D58UoaKUPbPAqjUs8TZ8GFloFEjBtefBjDNZDCOi+QnMzTNqeGu9qwLiv
	FdCaYXdEWlijc/2B1kiqhTSxi+ZGubgLg4LMtS/E=
X-Google-Smtp-Source: AGHT+IEj7X2pSEMy4hgNzEL+p9+qy6m2+XiwiYMlToNE8i9YIaFMSLv0FHwGq8tEbB+1t32K4MQQhQ==
X-Received: by 2002:a17:907:971e:b0:b04:4429:898a with SMTP id a640c23a62f3a-b0444298eccmr351788166b.56.1756796739611;
        Tue, 02 Sep 2025 00:05:39 -0700 (PDT)
Received: from [127.0.0.2] ([2a02:2455:8268:bc00:39c9:1f0d:23f0:502f])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aff9918dbd2sm821575866b.103.2025.09.02.00.05.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Sep 2025 00:05:39 -0700 (PDT)
From: Karthik Nayak <karthik.188@gmail.com>
Date: Tue, 02 Sep 2025 09:05:25 +0200
Subject: [PATCH v2 5/5] refs/reftable: add fsck check for incorrect update
 index
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250902-228-reftable-introduce-consistency-checks-v2-5-4f96b3834779@gmail.com>
References: <20250902-228-reftable-introduce-consistency-checks-v2-0-4f96b3834779@gmail.com>
In-Reply-To: <20250902-228-reftable-introduce-consistency-checks-v2-0-4f96b3834779@gmail.com>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, jltobler@gmail.com, 
 shejialuo@gmail.com
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=6539; i=karthik.188@gmail.com;
 h=from:subject:message-id; bh=pwOb9lmrFE8qa0UNao99t6QlWfiSZHmMC2/xDECdNGU=;
 b=owJ4nAHtARL+kA0DAAoBPtWfJI5GjH8ByyZiAGi2lz4vgMolkcickgFKLrcCoqQjdABwFe+t+
 8Sm3n7DwXgwQ4kBswQAAQoAHRYhBFfOTH9jdXEPy2XGBj7VnySORox/BQJotpc+AAoJED7VnySO
 Rox/zKQMAJTAVc8DCSYEZqr6oC5Qg6kM3KPhzJdxVGufNMsUML3D/eI9u2AwRQ8t55h2dbLF3D6
 MQew7q/2JTVmpzeI6uaPXc09MBf9D0kVirIR9BWsO06Sm5qXpb0kTKUUKId9bqL5aQBD0R7yJvu
 dToLrLOhIwICTqcN3EyCjYyTXoI8yk1wFFYL8HMrdFC/kqb8ARbZQgyoC6MurEOPeJPcYprrMDY
 TUug6G/2JHsftlxjxvfPqI5GNiEnpvB8bqiLyngtGGMjQHynOHfilDAnX2T4n0WWT4SqWm8jvKD
 w9v0kQ1QmWxHVp663Sd6yG2X35QnPwIYdtLXuWH/0M30bLwbZn46+pIg3d6yrcMAWtZ58+MHC2D
 T38YIrIXLPKbutAxwO1/VH9uBvULlIG5AyKAjVvZOBrPZV/lA4KtTwTN0G4vOFKABKB00tvMopU
 4m+RPIPShAmJwGYgjFdb1YPyHwGZIdEXeDT44lNBWqVTjKqwMkm04JecmhmKTDrXXH5bEH2PHo6
 WI=
X-Developer-Key: i=karthik.188@gmail.com; a=openpgp;
 fpr=57CE4C7F6375710FCB65C6063ED59F248E468C7F

Introduce a fsck check for the reftable backend, which checks if the
tables in 'tables.list' contain sequential update index. The tables in
the reftable backend should contain sequential update index. This fsck
check ensures that.

We must note that the reftable backend itself doesn't check to ensure
this and it also doesn't check to ensure that the index in the table
name matches the index in the header or the table. The latter is not
implemented in this fsck check either and will be added in a future
patch where we add fsck checks for internals of a table.

Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 Documentation/fsck-msgids.adoc |  3 ++
 fsck.h                         |  1 +
 refs/reftable-backend.c        |  3 ++
 reftable/fsck.c                | 15 ++++++++--
 reftable/reftable-fsck.h       |  2 ++
 t/t0614-reftable-fsck.sh       | 62 ++++++++++++++++++++++++++++++++++++++++++
 6 files changed, 84 insertions(+), 2 deletions(-)

diff --git a/Documentation/fsck-msgids.adoc b/Documentation/fsck-msgids.adoc
index 1432b1de06..982d51876c 100644
--- a/Documentation/fsck-msgids.adoc
+++ b/Documentation/fsck-msgids.adoc
@@ -47,6 +47,9 @@
 `badReftableTableName`::
 	(ERROR) A reftable table has an invalid name.
 
+`badReftableUpdateIndex`::
+	(ERROR) Incorrect update index found for table.
+
 `badTagName`::
 	(INFO) A tag has an invalid format.
 
diff --git a/fsck.h b/fsck.h
index 33432bae79..60e9b84183 100644
--- a/fsck.h
+++ b/fsck.h
@@ -37,6 +37,7 @@ enum fsck_msg_type {
 	FUNC(BAD_REFTABLE_STACK_COUNT, ERROR)                      \
 	FUNC(BAD_REFTABLE_STACK_LIST_NEWLINE, ERROR)               \
 	FUNC(BAD_REFTABLE_TABLE_NAME, ERROR)                       \
+	FUNC(BAD_REFTABLE_UPDATE_INDEX, ERROR)                     \
 	FUNC(BAD_REF_CONTENT, ERROR)                               \
 	FUNC(BAD_REF_FILETYPE, ERROR)                              \
 	FUNC(BAD_REF_NAME, ERROR)                                  \
diff --git a/refs/reftable-backend.c b/refs/reftable-backend.c
index 7331513b19..519ade24b8 100644
--- a/refs/reftable-backend.c
+++ b/refs/reftable-backend.c
@@ -2701,6 +2701,9 @@ static int reftable_fsck_error_handler(struct reftable_fsck_info *info,
 	case REFTABLE_FSCK_ERROR_STACK_LIST_MISSING_NEWLINE:
 		msg_id = FSCK_MSG_BAD_REFTABLE_STACK_LIST_NEWLINE;
 		break;
+	case REFTABLE_FSCK_ERROR_UPDATE_INDEX:
+		msg_id = FSCK_MSG_BAD_REFTABLE_UPDATE_INDEX;
+		break;
 	default:
 		BUG("unknown fsck error: %d", info->error);
 	}
diff --git a/reftable/fsck.c b/reftable/fsck.c
index 9a7f22c56b..5c6d842ac1 100644
--- a/reftable/fsck.c
+++ b/reftable/fsck.c
@@ -53,9 +53,8 @@ int reftable_fsck_check(struct reftable_stack *stack,
 			reftable_fsck_verbose_fn verbose_fn,
 			void *cb_data)
 {
-
+	uint64_t min, max, prev_max = 0;
 	char **names = NULL;
-	uint64_t min, max;
 	int err = 0;
 
 	if (stack == NULL)
@@ -87,10 +86,22 @@ int reftable_fsck_check(struct reftable_stack *stack,
 			continue;
 		}
 
+		if (min != (prev_max + 1) || max < min) {
+			struct reftable_fsck_info info = {
+				.error = REFTABLE_FSCK_ERROR_UPDATE_INDEX,
+				.path = names[i],
+				.msg = "incorrect update index in table name"
+			};
+
+			err = report_fn(&info, cb_data);
+		}
+
 		if (strcmp(tail, ".ref")) {
 			info.msg = "invalid reftable table extension";
 			err = report_fn(&info, cb_data);
 		}
+
+		prev_max = max;
 	}
 
 	verbose_fn("Checking trailing newline in stack list", cb_data);
diff --git a/reftable/reftable-fsck.h b/reftable/reftable-fsck.h
index 17df661da8..0ab20a99b6 100644
--- a/reftable/reftable-fsck.h
+++ b/reftable/reftable-fsck.h
@@ -10,6 +10,8 @@ enum reftable_fsck_error {
 	REFTABLE_FSCK_ERROR_STACK_COUNT = -2,
 	/* Newline missing at the end of the stack list */
 	REFTABLE_FSCK_ERROR_STACK_LIST_MISSING_NEWLINE = -3,
+	/* Incorrect update index for table */
+	REFTABLE_FSCK_ERROR_UPDATE_INDEX = -4,
 };
 
 /* Represents an individual error encountered during the FSCK checks. */
diff --git a/t/t0614-reftable-fsck.sh b/t/t0614-reftable-fsck.sh
index 3b119eae62..1f37691b2e 100755
--- a/t/t0614-reftable-fsck.sh
+++ b/t/t0614-reftable-fsck.sh
@@ -96,4 +96,66 @@ test_expect_success 'stack list must contain trailing newline' '
 	)
 '
 
+test_expect_success 'table update index should be sequential between tables' '
+	test_when_finished "rm -rf repo" &&
+	git init repo &&
+	(
+		cd repo &&
+		git commit --allow-empty -m initial &&
+
+		# Lock the existing table to disable auto-compaction
+		CUR_TABLE=$(cat .git/reftable/tables.list | tail -n1) &&
+		touch .git/reftable/${CUR_TABLE}.lock &&
+		git update-ref refs/heads/sample @ &&
+		rm .git/reftable/${CUR_TABLE}.lock &&
+
+		git refs verify 2>err &&
+		test_must_be_empty err &&
+
+		TABLE_NAME=$(cat .git/reftable/tables.list | tail -n1) &&
+		NEW_TABLE_NAME=$(echo ${TABLE_NAME} | sed "s/0003/0009/g") &&
+
+		sed "2s/.*/${NEW_TABLE_NAME}/" .git/reftable/tables.list >.git/reftable/tables.list.tmp &&
+		mv .git/reftable/tables.list.tmp .git/reftable/tables.list &&
+		mv .git/reftable/${TABLE_NAME} .git/reftable/${NEW_TABLE_NAME} &&
+
+		test_must_fail git refs verify 2>err &&
+		cat >expect <<-EOF &&
+		error: ${NEW_TABLE_NAME}: badReftableUpdateIndex: incorrect update index in table name
+		EOF
+		test_cmp expect err
+	)
+'
+
+test_expect_success 'table update index should be sequential within a table' '
+	test_when_finished "rm -rf repo" &&
+	git init repo &&
+	(
+		cd repo &&
+		git commit --allow-empty -m initial &&
+
+		# Lock the existing table to disable auto-compaction
+		CUR_TABLE=$(cat .git/reftable/tables.list | tail -n1) &&
+		touch .git/reftable/${CUR_TABLE}.lock &&
+		git update-ref refs/heads/sample @ &&
+		rm .git/reftable/${CUR_TABLE}.lock &&
+
+		git refs verify 2>err &&
+		test_must_be_empty err &&
+
+		TABLE_NAME=$(cat .git/reftable/tables.list | tail -n1) &&
+		NEW_TABLE_NAME=$(echo ${TABLE_NAME} | sed "s/\(.*\)0003/\10002/") &&
+
+		sed "2s/.*/${NEW_TABLE_NAME}/" .git/reftable/tables.list >.git/reftable/tables.list.tmp &&
+		mv .git/reftable/tables.list.tmp .git/reftable/tables.list &&
+		mv .git/reftable/${TABLE_NAME} .git/reftable/${NEW_TABLE_NAME} &&
+
+		test_must_fail git refs verify 2>err &&
+		cat >expect <<-EOF &&
+		error: ${NEW_TABLE_NAME}: badReftableUpdateIndex: incorrect update index in table name
+		EOF
+		test_cmp expect err
+	)
+'
+
 test_done

-- 
2.50.1

