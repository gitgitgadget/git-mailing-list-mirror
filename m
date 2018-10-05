Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.6 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9CFB51F97E
	for <e@80x24.org>; Fri,  5 Oct 2018 21:54:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728733AbeJFEzK (ORCPT <rfc822;e@80x24.org>);
        Sat, 6 Oct 2018 00:55:10 -0400
Received: from mail-ua1-f73.google.com ([209.85.222.73]:34023 "EHLO
        mail-ua1-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725772AbeJFEzJ (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 6 Oct 2018 00:55:09 -0400
Received: by mail-ua1-f73.google.com with SMTP id v26so2362248uap.1
        for <git@vger.kernel.org>; Fri, 05 Oct 2018 14:54:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=uFErK1P5dPVaZtAH5/6dIGc3MoEtrSY6OKkFL3QPg4Y=;
        b=OC8aRjq0ydEvw25HOXcatd5IVDP8P7n1J+2RP1TFZVbk1QTjI9OJ9X0M1OEE8ZKsBb
         YU9CRZ0AWrgc6BZUWoLhAIBGRUHU4Z8nZMZ2Tm5ZIkbf69eUg+Z9LDf80/zoMMnSt0rv
         Fa3sHHf0l9gbJDkwtCo3pAfVK7p8RJOEQC5t1qTJGOi+HBGEVHPA3FQCPPCN9ECHa60V
         K4dD2NpmvdACSvbyh2tzNNxPZD5HQ7vWA9xkYrjOqvnwJFwB2S/XGUIgB0mbx5q10JHt
         1NaMH1lg7/0llgcsRX+z8ygj7BxJQzL10gS+YNGpKcFGcKQoBP2l5WGFIxMk3k5fSR9L
         qKrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=uFErK1P5dPVaZtAH5/6dIGc3MoEtrSY6OKkFL3QPg4Y=;
        b=phKq6zwLnfDx6T40mjY6X66kzdt+0/goExF7Bp00TroL8uP+T1cyOXc0DNqdCrgOie
         2/YytX1nve5BFIs9U9dYqvxnSoLsQKwoOke5xScJIbWZh2yAj41y1qedFDZSp23Wi+4+
         KeudeVjhyWQKvm/7k6b4rZvT74QQmlm67HLr+mRbBTDc7Pax59VZdOon3SjyMP4SrOht
         pcRmzJRQ8gi5klwlVnjkeWjM3Dj57V7pnKvEQ204BLh1XJ6VIbsFY4o/79o3lzrTYWhT
         tYfpCi3wGzzDHmaF/55IbD/yvxIS74JCv3lriMaDsRnqKWVM1Gml/UTEErKYpxNqOA77
         I6bQ==
X-Gm-Message-State: ABuFfogGZyJvl2yWArlOAMrXGrfPsxl8BpIaaBNYCp1J+HJtzOPB4Gs6
        2XdzKfOCP0b6SlBZrjF7n2foau3lzg6FuopueGurnVNInEo9BGTwRpq5HrhuNJiHRgpvXS+UK1T
        tZi+zNDLSHoKkbmsfiNq/sX994+bPybKMYZjtg/N+VQ1Xu/QokzvbI3nMR5A=
X-Google-Smtp-Source: ACcGV61DAHZDjHqiXzsawF+BzvV+e+f2YOhW0vWL0+Nb4d1hM+Yil/pPK2/0LKuPMVtngVmzPof88R3ZBiZf
X-Received: by 2002:a67:4408:: with SMTP id r8mr11657832vsa.16.1538776469702;
 Fri, 05 Oct 2018 14:54:29 -0700 (PDT)
Date:   Fri,  5 Oct 2018 14:54:07 -0700
In-Reply-To: <cover.1538775186.git.matvore@google.com>
Message-Id: <6f639eec9ed57ecd17431b215430541da8ff250b.1538775186.git.matvore@google.com>
Mime-Version: 1.0
References: <cover.1536969438.git.matvore@google.com> <cover.1538775186.git.matvore@google.com>
X-Mailer: git-send-email 2.19.0.605.g01d371f741-goog
Subject: [PATCH v5 7/7] tests: order arguments to git-rev-list properly
From:   Matthew DeVore <matvore@google.com>
To:     git@vger.kernel.org
Cc:     Matthew DeVore <matvore@google.com>, peff@peff.net,
        jonathantanmy@google.com, gitster@pobox.com, jrn@google.com,
        sunshine@sunshineco.com, szeder.dev@gmail.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

It is a common mistake to put positional arguments before flags when
invoking git-rev-list. Order the positional arguments last.

This patch skips git-rev-list invocations which include the --not flag,
since the ordering of flags and positional arguments affects the
behavior. This patch also skips invocations of git-rev-list that occur
in command substitution in which the exit code is discarded, since
fixing those properly will require a more involved cleanup.

Signed-off-by: Matthew DeVore <matvore@google.com>
---
 t/t5616-partial-clone.sh            | 26 +++++++++--------
 t/t5702-protocol-v2.sh              |  4 +--
 t/t6112-rev-list-filters-objects.sh | 43 ++++++++++++++++++-----------
 3 files changed, 44 insertions(+), 29 deletions(-)

diff --git a/t/t5616-partial-clone.sh b/t/t5616-partial-clone.sh
index fc7aeb1ab..6ff614692 100755
--- a/t/t5616-partial-clone.sh
+++ b/t/t5616-partial-clone.sh
@@ -35,7 +35,7 @@ test_expect_success 'setup bare clone for server' '
 test_expect_success 'do partial clone 1' '
 	git clone --no-checkout --filter=blob:none "file://$(pwd)/srv.bare" pc1 &&
 
-	git -C pc1 rev-list HEAD --quiet --objects --missing=print >revs &&
+	git -C pc1 rev-list --quiet --objects --missing=print HEAD >revs &&
 	awk -f print_1.awk revs |
 	sed "s/?//" |
 	sort >observed.oids &&
@@ -48,10 +48,10 @@ test_expect_success 'do partial clone 1' '
 
 # checkout master to force dynamic object fetch of blobs at HEAD.
 test_expect_success 'verify checkout with dynamic object fetch' '
-	git -C pc1 rev-list HEAD --quiet --objects --missing=print >observed &&
+	git -C pc1 rev-list --quiet --objects --missing=print HEAD >observed &&
 	test_line_count = 4 observed &&
 	git -C pc1 checkout master &&
-	git -C pc1 rev-list HEAD --quiet --objects --missing=print >observed &&
+	git -C pc1 rev-list --quiet --objects --missing=print HEAD >observed &&
 	test_line_count = 0 observed
 '
 
@@ -74,7 +74,8 @@ test_expect_success 'push new commits to server' '
 # have the new blobs.
 test_expect_success 'partial fetch inherits filter settings' '
 	git -C pc1 fetch origin &&
-	git -C pc1 rev-list master..origin/master --quiet --objects --missing=print >observed &&
+	git -C pc1 rev-list --quiet --objects --missing=print \
+		master..origin/master >observed &&
 	test_line_count = 5 observed
 '
 
@@ -82,7 +83,8 @@ test_expect_success 'partial fetch inherits filter settings' '
 # we should only get 1 new blob (for the file in origin/master).
 test_expect_success 'verify diff causes dynamic object fetch' '
 	git -C pc1 diff master..origin/master -- file.1.txt &&
-	git -C pc1 rev-list master..origin/master --quiet --objects --missing=print >observed &&
+	git -C pc1 rev-list --quiet --objects --missing=print \
+		 master..origin/master >observed &&
 	test_line_count = 4 observed
 '
 
@@ -91,7 +93,8 @@ test_expect_success 'verify diff causes dynamic object fetch' '
 test_expect_success 'verify blame causes dynamic object fetch' '
 	git -C pc1 blame origin/master -- file.1.txt >observed.blame &&
 	test_cmp expect.blame observed.blame &&
-	git -C pc1 rev-list master..origin/master --quiet --objects --missing=print >observed &&
+	git -C pc1 rev-list --quiet --objects --missing=print \
+		master..origin/master >observed &&
 	test_line_count = 0 observed
 '
 
@@ -111,7 +114,8 @@ test_expect_success 'push new commits to server for file.2.txt' '
 # Verify we have all the new blobs.
 test_expect_success 'override inherited filter-spec using --no-filter' '
 	git -C pc1 fetch --no-filter origin &&
-	git -C pc1 rev-list master..origin/master --quiet --objects --missing=print >observed &&
+	git -C pc1 rev-list --quiet --objects --missing=print \
+		master..origin/master >observed &&
 	test_line_count = 0 observed
 '
 
@@ -133,8 +137,8 @@ test_expect_success 'push new commits to server for file.3.txt' '
 test_expect_success 'manual prefetch of missing objects' '
 	git -C pc1 fetch --filter=blob:none origin &&
 
-	git -C pc1 rev-list master..origin/master --quiet --objects --missing=print \
-		>revs &&
+	git -C pc1 rev-list --quiet --objects --missing=print \
+		 master..origin/master >revs &&
 	awk -f print_1.awk revs |
 	sed "s/?//" |
 	sort >observed.oids &&
@@ -142,8 +146,8 @@ test_expect_success 'manual prefetch of missing objects' '
 	test_line_count = 6 observed.oids &&
 	git -C pc1 fetch-pack --stdin "file://$(pwd)/srv.bare" <observed.oids &&
 
-	git -C pc1 rev-list master..origin/master --quiet --objects --missing=print \
-		>revs &&
+	git -C pc1 rev-list --quiet --objects --missing=print \
+		master..origin/master >revs &&
 	awk -f print_1.awk revs |
 	sed "s/?//" |
 	sort >observed.oids &&
diff --git a/t/t5702-protocol-v2.sh b/t/t5702-protocol-v2.sh
index 54727450b..11a84efff 100755
--- a/t/t5702-protocol-v2.sh
+++ b/t/t5702-protocol-v2.sh
@@ -271,7 +271,7 @@ test_expect_success 'partial clone' '
 	grep "version 2" trace &&
 
 	# Ensure that the old version of the file is missing
-	git -C client rev-list master --quiet --objects --missing=print \
+	git -C client rev-list --quiet --objects --missing=print master \
 		>observed.oids &&
 	grep "$(git -C server rev-parse message1:a.txt)" observed.oids &&
 
@@ -297,7 +297,7 @@ test_expect_success 'partial fetch' '
 	grep "version 2" trace &&
 
 	# Ensure that the old version of the file is missing
-	git -C client rev-list other --quiet --objects --missing=print \
+	git -C client rev-list --quiet --objects --missing=print other \
 		>observed.oids &&
 	grep "$(git -C server rev-parse message1:a.txt)" observed.oids &&
 
diff --git a/t/t6112-rev-list-filters-objects.sh b/t/t6112-rev-list-filters-objects.sh
index b00cf6fa8..53975c572 100755
--- a/t/t6112-rev-list-filters-objects.sh
+++ b/t/t6112-rev-list-filters-objects.sh
@@ -25,7 +25,8 @@ test_expect_success 'verify blob:none omits all 5 blobs' '
 	awk -f print_2.awk ls_files_result |
 	sort >expected &&
 
-	git -C r1 rev-list HEAD --quiet --objects --filter-print-omitted --filter=blob:none >revs &&
+	git -C r1 rev-list --quiet --objects --filter-print-omitted \
+		--filter=blob:none HEAD >revs &&
 	awk -f print_1.awk revs |
 	sed "s/~//" |
 	sort >observed &&
@@ -34,12 +35,12 @@ test_expect_success 'verify blob:none omits all 5 blobs' '
 '
 
 test_expect_success 'verify emitted+omitted == all' '
-	git -C r1 rev-list HEAD --objects >revs &&
+	git -C r1 rev-list --objects HEAD >revs &&
 	awk -f print_1.awk revs |
 	sort >expected &&
 
-	git -C r1 rev-list HEAD --objects --filter-print-omitted --filter=blob:none \
-		>revs &&
+	git -C r1 rev-list --objects --filter-print-omitted --filter=blob:none \
+		HEAD >revs &&
 	awk -f print_1.awk revs |
 	sed "s/~//" |
 	sort >observed &&
@@ -68,7 +69,8 @@ test_expect_success 'verify blob:limit=500 omits all blobs' '
 	awk -f print_2.awk ls_files_result |
 	sort >expected &&
 
-	git -C r2 rev-list HEAD --quiet --objects --filter-print-omitted --filter=blob:limit=500 >revs &&
+	git -C r2 rev-list --quiet --objects --filter-print-omitted \
+		--filter=blob:limit=500 HEAD >revs &&
 	awk -f print_1.awk revs |
 	sed "s/~//" |
 	sort >observed &&
@@ -77,11 +79,12 @@ test_expect_success 'verify blob:limit=500 omits all blobs' '
 '
 
 test_expect_success 'verify emitted+omitted == all' '
-	git -C r2 rev-list HEAD --objects >revs &&
+	git -C r2 rev-list --objects HEAD >revs &&
 	awk -f print_1.awk revs |
 	sort >expected &&
 
-	git -C r2 rev-list HEAD --objects --filter-print-omitted --filter=blob:limit=500 >revs &&
+	git -C r2 rev-list --objects --filter-print-omitted \
+		--filter=blob:limit=500 HEAD >revs &&
 	awk -f print_1.awk revs |
 	sed "s/~//" |
 	sort >observed &&
@@ -94,7 +97,8 @@ test_expect_success 'verify blob:limit=1000' '
 	awk -f print_2.awk ls_files_result |
 	sort >expected &&
 
-	git -C r2 rev-list HEAD --quiet --objects --filter-print-omitted --filter=blob:limit=1000 >revs &&
+	git -C r2 rev-list --quiet --objects --filter-print-omitted \
+		--filter=blob:limit=1000 HEAD >revs &&
 	awk -f print_1.awk revs |
 	sed "s/~//" |
 	sort >observed &&
@@ -107,7 +111,8 @@ test_expect_success 'verify blob:limit=1001' '
 	awk -f print_2.awk ls_files_result |
 	sort >expected &&
 
-	git -C r2 rev-list HEAD --quiet --objects --filter-print-omitted --filter=blob:limit=1001 >revs &&
+	git -C r2 rev-list --quiet --objects --filter-print-omitted \
+		--filter=blob:limit=1001 HEAD >revs &&
 	awk -f print_1.awk revs |
 	sed "s/~//" |
 	sort >observed &&
@@ -120,7 +125,8 @@ test_expect_success 'verify blob:limit=1k' '
 	awk -f print_2.awk ls_files_result |
 	sort >expected &&
 
-	git -C r2 rev-list HEAD --quiet --objects --filter-print-omitted --filter=blob:limit=1k >revs &&
+	git -C r2 rev-list --quiet --objects --filter-print-omitted \
+		--filter=blob:limit=1k HEAD >revs &&
 	awk -f print_1.awk revs |
 	sed "s/~//" |
 	sort >observed &&
@@ -129,7 +135,8 @@ test_expect_success 'verify blob:limit=1k' '
 '
 
 test_expect_success 'verify blob:limit=1m' '
-	git -C r2 rev-list HEAD --quiet --objects --filter-print-omitted --filter=blob:limit=1m >revs &&
+	git -C r2 rev-list --quiet --objects --filter-print-omitted \
+		--filter=blob:limit=1m HEAD >revs &&
 	awk -f print_1.awk revs |
 	sed "s/~//" |
 	sort >observed &&
@@ -162,7 +169,8 @@ test_expect_success 'verify sparse:path=pattern1 omits top-level files' '
 	awk -f print_2.awk ls_files_result |
 	sort >expected &&
 
-	git -C r3 rev-list HEAD --quiet --objects --filter-print-omitted --filter=sparse:path=../pattern1 >revs &&
+	git -C r3 rev-list --quiet --objects --filter-print-omitted \
+		--filter=sparse:path=../pattern1 HEAD >revs &&
 	awk -f print_1.awk revs |
 	sed "s/~//" |
 	sort >observed &&
@@ -175,7 +183,8 @@ test_expect_success 'verify sparse:path=pattern2 omits both sparse2 files' '
 	awk -f print_2.awk ls_files_result |
 	sort >expected &&
 
-	git -C r3 rev-list HEAD --quiet --objects --filter-print-omitted --filter=sparse:path=../pattern2 >revs &&
+	git -C r3 rev-list --quiet --objects --filter-print-omitted \
+		--filter=sparse:path=../pattern2 HEAD >revs &&
 	awk -f print_1.awk revs |
 	sed "s/~//" |
 	sort >observed &&
@@ -200,7 +209,8 @@ test_expect_success 'verify sparse:oid=OID omits top-level files' '
 
 	oid=$(git -C r3 ls-files -s pattern | awk -f print_2.awk) &&
 
-	git -C r3 rev-list HEAD --quiet --objects --filter-print-omitted --filter=sparse:oid=$oid >revs &&
+	git -C r3 rev-list --quiet --objects --filter-print-omitted \
+		--filter=sparse:oid=$oid HEAD >revs &&
 	awk -f print_1.awk revs |
 	sed "s/~//" |
 	sort >observed &&
@@ -213,7 +223,8 @@ test_expect_success 'verify sparse:oid=oid-ish omits top-level files' '
 	awk -f print_2.awk ls_files_result |
 	sort >expected &&
 
-	git -C r3 rev-list HEAD --quiet --objects --filter-print-omitted --filter=sparse:oid=master:pattern >revs &&
+	git -C r3 rev-list --quiet --objects --filter-print-omitted \
+		--filter=sparse:oid=master:pattern HEAD >revs &&
 	awk -f print_1.awk revs |
 	sed "s/~//" |
 	sort >observed &&
@@ -235,7 +246,7 @@ test_expect_success 'rev-list W/ --missing=print' '
 		rm r1/.git/objects/$id
 	done &&
 
-	git -C r1 rev-list --quiet HEAD --missing=print --objects >revs &&
+	git -C r1 rev-list --quiet --missing=print --objects HEAD >revs &&
 	awk -f print_1.awk revs |
 	sed "s/?//" |
 	sort >observed &&
-- 
2.19.0.605.g01d371f741-goog

