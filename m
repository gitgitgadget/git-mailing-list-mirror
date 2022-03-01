Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA944C433EF
	for <git@archiver.kernel.org>; Tue,  1 Mar 2022 19:49:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237468AbiCATue (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 1 Mar 2022 14:50:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237531AbiCATuU (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Mar 2022 14:50:20 -0500
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6421F47383
        for <git@vger.kernel.org>; Tue,  1 Mar 2022 11:49:08 -0800 (PST)
Received: by mail-wm1-x32b.google.com with SMTP id c192so8122510wma.4
        for <git@vger.kernel.org>; Tue, 01 Mar 2022 11:49:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=T5VYTv7sYDSw8wi0GKaTWAzxizpRswtApNTiRs5+WQs=;
        b=HqSUlxodt1r3Gep3SASDTJPXML3nJQcCY4FonAoE8nQMn16+0QIdru5frQQkk9G4Lg
         GWmPS4/1UBbp8oNgx8rygNPLt9cNbN4cu7OsfRBLPBH1Iw7FGdixYreqtq2OhbNT8fmW
         9gu9hELpjC7VzB/omZgoDbhD/qcqp8iggVF261qpWR6PUii7H3Nh6LZ+IOYrup2JP/Yi
         UvD1kOnXgbROfGduoCVtraMeSqsMYINWP0W/otCTIhugtQIxT3hg0HBRJebhwu7qdw8R
         CSRwHCKz8k7N4WK755GwNkioVHBU35uPLI3gXq4bnQJgC5ED+Cfk/IjZluLVNQtYJCXr
         zxbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:mime-version:content-transfer-encoding:fcc:to:cc;
        bh=T5VYTv7sYDSw8wi0GKaTWAzxizpRswtApNTiRs5+WQs=;
        b=tS50nvQy4etA7mod/SZ4zCp7PE78Z9zbddvCyIUBh838pFqRLGmQhyOFGMU9VJuVVI
         MqNmfNsAl+or4C5/AMHZZK0y816SXWnsAxoUAADHuIno5f6ITMhgk3DRPGxNwGd5Ybgx
         UVc4QVDxTpUnpxLtBOBOMvH/VOQrqRnF8TMohJLoW/CHGhcn+g/XIwb2d9tYEYSmMffj
         1UcH/qwH3cJ1z0FUxAzf5YLPuCMVzMeKliVtgdT/+ChEHJHItdHWNomcS6OMEuVuKqzy
         iWQo5DkaTvbZIzoF5++6mF32TGPAh/+aU/wf/rAm1x5hKpkJUiGKIWgSyy6ZS9jMnISS
         i20Q==
X-Gm-Message-State: AOAM532nvqWQL5DTi+VtLNNK+B623rRGnL4sQuZ+hRI80CshXwvl79qQ
        eX8hPSQfb1/Kh2CbO/Y2FDdunetyRK0=
X-Google-Smtp-Source: ABdhPJz7IP3889bvIr3wKSt/rjhy2NPpcTppeaKq9eLuBG8PBjW+FhUFksabWml270N+phMHRd9Rag==
X-Received: by 2002:a05:600c:1d08:b0:381:6eda:67d1 with SMTP id l8-20020a05600c1d0800b003816eda67d1mr7801993wms.88.1646164116281;
        Tue, 01 Mar 2022 11:48:36 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id i20-20020a05600c355400b0038164ef5418sm3741647wmq.32.2022.03.01.11.48.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Mar 2022 11:48:35 -0800 (PST)
Message-Id: <562341b76b30ff3cdc01cea4cda550a7b8165bdd.1646164112.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1163.v3.git.1646164112.gitgitgadget@gmail.com>
References: <pull.1163.v2.git.1646056423.gitgitgadget@gmail.com>
        <pull.1163.v3.git.1646164112.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 01 Mar 2022 19:48:30 +0000
Subject: [PATCH v3 3/5] commit-graph: fix ordering bug in generation numbers
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
To:     git@vger.kernel.org
Cc:     me@ttaylorr.com, gitster@pobox.com, abhishekkumar8222@gmail.com,
        avarab@gmail.com, Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <derrickstolee@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <derrickstolee@github.com>

When computing the generation numbers for a commit-graph, we compute
the corrected commit dates and then check if their offsets from the
actual dates is too large to fit in the 32-bit Generation Data chunk.
However, there is a problem with this approach: if we have parsed the
generation data from the previous commit-graph, then we continue the
loop because the corrected commit date is already computed. This causes
an under-count in the number of overflow values.

It is incorrect to add an increment to num_generation_data_overflows
next to this 'continue' statement, because we might start
double-counting commits that are computed because of the depth-first
search walk from a commit with an earlier OID.

Instead, iterate over the full commit list at the end, checking the
offsets to see how many grow beyond the maximum value.

Create a new t5328-commit-graph-64-bit-time.sh test script to handle
special cases of testing 64-bit timestampes. This helps demonstrate this
bug in more cases. It still won't hit all potential cases until the next
change, which reenables reading generation numbers. Use the skip_all
trick from 0a2bfccb9c8 (t0051: use "skip_all" under !MINGW in
single-test file, 2022-02-04) to make the output clean when run on a
32-bit system.

Hepled-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
Signed-off-by: Derrick Stolee <derrickstolee@github.com>
---
 commit-graph.c                     | 10 +++++---
 t/t5318-commit-graph.sh            |  4 +--
 t/t5328-commit-graph-64bit-time.sh | 39 ++++++++++++++++++++++++++++++
 3 files changed, 48 insertions(+), 5 deletions(-)
 create mode 100755 t/t5328-commit-graph-64bit-time.sh

diff --git a/commit-graph.c b/commit-graph.c
index 265c010122e..a19bd96c2ee 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -1556,12 +1556,16 @@ static void compute_generation_numbers(struct write_commit_graph_context *ctx)
 				if (current->date && current->date > max_corrected_commit_date)
 					max_corrected_commit_date = current->date - 1;
 				commit_graph_data_at(current)->generation = max_corrected_commit_date + 1;
-
-				if (commit_graph_data_at(current)->generation - current->date > GENERATION_NUMBER_V2_OFFSET_MAX)
-					ctx->num_generation_data_overflows++;
 			}
 		}
 	}
+
+	for (i = 0; i < ctx->commits.nr; i++) {
+		struct commit *c = ctx->commits.list[i];
+		timestamp_t offset = commit_graph_data_at(c)->generation - c->date;
+		if (offset > GENERATION_NUMBER_V2_OFFSET_MAX)
+			ctx->num_generation_data_overflows++;
+	}
 	stop_progress(&ctx->progress);
 }
 
diff --git a/t/t5318-commit-graph.sh b/t/t5318-commit-graph.sh
index 9e2b5884dae..0ed7e9de8e6 100755
--- a/t/t5318-commit-graph.sh
+++ b/t/t5318-commit-graph.sh
@@ -425,10 +425,10 @@ test_expect_success 'warn on improper hash version' '
 	)
 '
 
-test_expect_success 'lower layers have overflow chunk' '
+test_expect_success TIME_IS_64BIT,TIME_T_IS_64BIT 'lower layers have overflow chunk' '
 	cd "$TRASH_DIRECTORY/full" &&
 	UNIX_EPOCH_ZERO="@0 +0000" &&
-	FUTURE_DATE="@2147483646 +0000" &&
+	FUTURE_DATE="@4147483646 +0000" &&
 	rm -f .git/objects/info/commit-graph &&
 	test_commit --date "$FUTURE_DATE" future-1 &&
 	test_commit --date "$UNIX_EPOCH_ZERO" old-1 &&
diff --git a/t/t5328-commit-graph-64bit-time.sh b/t/t5328-commit-graph-64bit-time.sh
new file mode 100755
index 00000000000..28114bcaf47
--- /dev/null
+++ b/t/t5328-commit-graph-64bit-time.sh
@@ -0,0 +1,39 @@
+#!/bin/sh
+
+test_description='commit graph with 64-bit timestamps'
+. ./test-lib.sh
+
+if ! test_have_prereq TIME_IS_64BIT || ! test_have_prereq TIME_T_IS_64BIT
+then
+	skip_all='skipping 64-bit timestamp tests'
+	test_done
+fi
+
+. "$TEST_DIRECTORY"/lib-commit-graph.sh
+
+UNIX_EPOCH_ZERO="@0 +0000"
+FUTURE_DATE="@4147483646 +0000"
+
+GIT_TEST_COMMIT_GRAPH_CHANGED_PATHS=0
+
+test_expect_success 'lower layers have overflow chunk' '
+	rm -f .git/objects/info/commit-graph &&
+	test_commit --date "$FUTURE_DATE" future-1 &&
+	test_commit --date "$UNIX_EPOCH_ZERO" old-1 &&
+	git commit-graph write --reachable &&
+	test_commit --date "$FUTURE_DATE" future-2 &&
+	test_commit --date "$UNIX_EPOCH_ZERO" old-2 &&
+	git commit-graph write --reachable --split=no-merge &&
+	test_commit extra &&
+	git commit-graph write --reachable --split=no-merge &&
+	git commit-graph write --reachable &&
+	graph_read_expect 5 "generation_data generation_data_overflow" &&
+	mv .git/objects/info/commit-graph commit-graph-upgraded &&
+	git commit-graph write --reachable &&
+	graph_read_expect 5 "generation_data generation_data_overflow" &&
+	test_cmp .git/objects/info/commit-graph commit-graph-upgraded
+'
+
+graph_git_behavior 'overflow' '' HEAD~2 HEAD
+
+test_done
-- 
gitgitgadget

