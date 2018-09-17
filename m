Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.6 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 574EB1F404
	for <e@80x24.org>; Mon, 17 Sep 2018 22:24:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728654AbeIRDyO (ORCPT <rfc822;e@80x24.org>);
        Mon, 17 Sep 2018 23:54:14 -0400
Received: from mail-qt0-f201.google.com ([209.85.216.201]:53491 "EHLO
        mail-qt0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728088AbeIRDyO (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Sep 2018 23:54:14 -0400
Received: by mail-qt0-f201.google.com with SMTP id d18-v6so15720513qtj.20
        for <git@vger.kernel.org>; Mon, 17 Sep 2018 15:24:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=kHkKxOkRDnZhwOhLV+ZTSHTVZe8VmRvSNdQSZ/SQKGw=;
        b=u95iobnqHf8chrcSK7FJaCak/LSaMT+IVS38JQAvUi76uB5CdWtR0iqX635LQZYoQy
         kB8HDdPpUQ/vFP2lNev8TgPYZ8lzjfhluRkH/DMwaDqoGp0A+/gGjLFDp6MaR5fr+wZL
         x9K4DcnzZ5qB3ZBe0xh/xvlVsscuSiR0J/fr8xVov/dDjumgki2G7uhY8rJhMH5zptTR
         yU8IUX0THPxw9qc9Rbw2lUB6dTjW4NGqmjfpisgNtzhK+RlC6I8KnB2G9sIoygJ/nift
         QN8tige2ogr5/AAMv5aaFmgdBGlDpDWEcXVAxMtYUHRzxBu8V6j07OuC9rm/mFYT4IyB
         8GTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=kHkKxOkRDnZhwOhLV+ZTSHTVZe8VmRvSNdQSZ/SQKGw=;
        b=oA2q9TiOEaQeKln4Zn1Xn2aKyzcTh35AMhPxay2v0Jy66VGKU8/DJzGVXPKcCWrz1l
         hPt/56bEdzPPHSGTyQVScU6y4C7WqT3PrLmrxLtpzX2LYonrLmEQrg7YLdStXoUg+g4b
         FU+PQIt7x4lOTCefvBfgIN9aW/BEIujeOFk+Cfvvz4qSzbOlVQMlFuuD72uws+vExcJF
         5vV5ALUfPHiNDjvKpPlNRe0UmjtvzWBGqC9Q4Dwb0aX8j2FwtijTgUdnfTpYrYt3sENx
         884ZZYWkJyf0JCM16oRxMuwxyaV1AYOVCsVa3wXf+mqx6NjQS95d6XqJIXHrxmPUANhI
         Rv9g==
X-Gm-Message-State: APzg51AR5IzsGRyqx4PHI+OTGKPn3GOKJ/OHnNSn7yPJAnK8ufnO35P5
        9Yb7tMaMHgyK7vjqYDp/DZcvkmRrlyqcd/FPgrH7EntPIDSdu3mLz8pqpBIkn+uau6Qvm5R/QGI
        yP7qB9H7JaOtx+8/nIdC9qM6hcb+8LCfp+rsXd1XBk+3cLK2nQvJE65zHAOA=
X-Google-Smtp-Source: ANB0VdbntZlnXlQFwzN+Dy4DdOIMkzAYuCOHEveC7VxzLhzNrCtGW++9eWXvfjgJub4Czr5NV68HKzgHmfb9
X-Received: by 2002:ac8:592:: with SMTP id a18-v6mr8893355qth.43.1537223094160;
 Mon, 17 Sep 2018 15:24:54 -0700 (PDT)
Date:   Mon, 17 Sep 2018 15:24:18 -0700
In-Reply-To: <cover.1537223021.git.matvore@google.com>
Message-Id: <980e4d6005224771cf9366883f2493ef0a82e8c8.1537223021.git.matvore@google.com>
Mime-Version: 1.0
References: <cover.1536969438.git.matvore@google.com> <cover.1537223021.git.matvore@google.com>
X-Mailer: git-send-email 2.19.0.444.g18242da7ef-goog
Subject: [PATCH v2 2/6] tests: standardize pipe placement
From:   Matthew DeVore <matvore@google.com>
To:     git@vger.kernel.org
Cc:     Matthew DeVore <matvore@google.com>, peff@peff.net,
        jonathantanmy@google.com, gitster@pobox.com, jrn@google.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Instead of using a line-continuation and pipe on the second line, take
advantage of the shell's implicit line continuation after a pipe
character.  So for example, instead of

	some long line \
		| next line

use

	some long line |
	next line

And add a blank line before and after the pipe where it aids readability
(it usually does).

This better matches the coding style documented in
Documentation/CodingGuidelines and used in shell scripts elsewhere in
the tree.

Signed-off-by: Matthew DeVore <matvore@google.com>
---
 t/lib-gpg.sh                           |   9 +-
 t/t1006-cat-file.sh                    |   8 +-
 t/t1300-config.sh                      |   5 +-
 t/t5317-pack-objects-filter-objects.sh | 330 ++++++++++++++-----------
 t/t5500-fetch-pack.sh                  |   5 +-
 t/t5616-partial-clone.sh               |  32 ++-
 t/t6112-rev-list-filters-objects.sh    | 203 ++++++++-------
 7 files changed, 342 insertions(+), 250 deletions(-)

diff --git a/t/lib-gpg.sh b/t/lib-gpg.sh
index 3fe02876c..f1277bef4 100755
--- a/t/lib-gpg.sh
+++ b/t/lib-gpg.sh
@@ -57,9 +57,12 @@ then
 		echo | gpgsm --homedir "${GNUPGHOME}" 2>/dev/null \
 			--passphrase-fd 0 --pinentry-mode loopback \
 			--import "$TEST_DIRECTORY"/lib-gpg/gpgsm_cert.p12 &&
-		gpgsm --homedir "${GNUPGHOME}" 2>/dev/null -K \
-			| grep fingerprint: | cut -d" " -f4 | tr -d '\n' > \
-			${GNUPGHOME}/trustlist.txt &&
+
+		gpgsm --homedir "${GNUPGHOME}" 2>/dev/null -K |
+		grep fingerprint: |
+		cut -d" " -f4 |
+		tr -d '\n' >"${GNUPGHOME}/trustlist.txt" &&
+
 		echo " S relax" >> ${GNUPGHOME}/trustlist.txt &&
 		(gpgconf --kill gpg-agent >/dev/null 2>&1 || : ) &&
 		echo hello | gpgsm --homedir "${GNUPGHOME}" >/dev/null \
diff --git a/t/t1006-cat-file.sh b/t/t1006-cat-file.sh
index 7f19d591f..a0fa926d3 100755
--- a/t/t1006-cat-file.sh
+++ b/t/t1006-cat-file.sh
@@ -218,8 +218,8 @@ test_expect_success "--batch-check for a non-existent hash" '
     test "0000000000000000000000000000000000000042 missing
 0000000000000000000000000000000000000084 missing" = \
     "$( ( echo 0000000000000000000000000000000000000042;
-         echo_without_newline 0000000000000000000000000000000000000084; ) \
-       | git cat-file --batch-check)"
+         echo_without_newline 0000000000000000000000000000000000000084; ) |
+       git cat-file --batch-check)"
 '
 
 test_expect_success "--batch for an existent and a non-existent hash" '
@@ -227,8 +227,8 @@ test_expect_success "--batch for an existent and a non-existent hash" '
 $tag_content
 0000000000000000000000000000000000000000 missing" = \
     "$( ( echo $tag_sha1;
-         echo_without_newline 0000000000000000000000000000000000000000; ) \
-       | git cat-file --batch)"
+         echo_without_newline 0000000000000000000000000000000000000000; ) |
+       git cat-file --batch)"
 '
 
 test_expect_success "--batch-check for an empty line" '
diff --git a/t/t1300-config.sh b/t/t1300-config.sh
index cdf1fed5d..5869d6cb6 100755
--- a/t/t1300-config.sh
+++ b/t/t1300-config.sh
@@ -1770,8 +1770,9 @@ test_expect_success '--show-origin stdin with file include' '
 	cat >expect <<-EOF &&
 		file:$INCLUDE_DIR/stdin.include	include
 	EOF
-	echo "[include]path=\"$INCLUDE_DIR\"/stdin.include" \
-		| git config --show-origin --includes --file - user.stdin >output &&
+	echo "[include]path=\"$INCLUDE_DIR\"/stdin.include" |
+	git config --show-origin --includes --file - user.stdin >output &&
+
 	test_cmp expect output
 '
 
diff --git a/t/t5317-pack-objects-filter-objects.sh b/t/t5317-pack-objects-filter-objects.sh
index 6710c8bc8..ce69148ec 100755
--- a/t/t5317-pack-objects-filter-objects.sh
+++ b/t/t5317-pack-objects-filter-objects.sh
@@ -20,17 +20,20 @@ test_expect_success 'setup r1' '
 '
 
 test_expect_success 'verify blob count in normal packfile' '
-	git -C r1 ls-files -s file.1 file.2 file.3 file.4 file.5 \
-		| awk -f print_2.awk \
-		| sort >expected &&
+	git -C r1 ls-files -s file.1 file.2 file.3 file.4 file.5 |
+	awk -f print_2.awk |
+	sort >expected &&
+
 	git -C r1 pack-objects --rev --stdout >all.pack <<-EOF &&
 	HEAD
 	EOF
 	git -C r1 index-pack ../all.pack &&
-	git -C r1 verify-pack -v ../all.pack \
-		| grep blob \
-		| awk -f print_1.awk \
-		| sort >observed &&
+
+	git -C r1 verify-pack -v ../all.pack |
+	grep blob |
+	awk -f print_1.awk |
+	sort >observed &&
+
 	test_cmp observed expected
 '
 
@@ -39,23 +42,27 @@ test_expect_success 'verify blob:none packfile has no blobs' '
 	HEAD
 	EOF
 	git -C r1 index-pack ../filter.pack &&
-	git -C r1 verify-pack -v ../filter.pack \
-		| grep blob \
-		| awk -f print_1.awk \
-		| sort >observed &&
+
+	git -C r1 verify-pack -v ../filter.pack |
+	grep blob |
+	awk -f print_1.awk |
+	sort >observed &&
+
 	nr=$(wc -l <observed) &&
 	test 0 -eq $nr
 '
 
 test_expect_success 'verify normal and blob:none packfiles have same commits/trees' '
-	git -C r1 verify-pack -v ../all.pack \
-		| grep -E "commit|tree" \
-		| awk -f print_1.awk \
-		| sort >expected &&
-	git -C r1 verify-pack -v ../filter.pack \
-		| grep -E "commit|tree" \
-		| awk -f print_1.awk \
-		| sort >observed &&
+	git -C r1 verify-pack -v ../all.pack |
+	grep -E "commit|tree" |
+	awk -f print_1.awk |
+	sort >expected &&
+
+	git -C r1 verify-pack -v ../filter.pack |
+	grep -E "commit|tree" |
+	awk -f print_1.awk |
+	sort >observed &&
+
 	test_cmp observed expected
 '
 
@@ -75,17 +82,20 @@ test_expect_success 'setup r2' '
 '
 
 test_expect_success 'verify blob count in normal packfile' '
-	git -C r2 ls-files -s large.1000 large.10000 \
-		| awk -f print_2.awk \
-		| sort >expected &&
+	git -C r2 ls-files -s large.1000 large.10000 |
+	awk -f print_2.awk |
+	sort >expected &&
+
 	git -C r2 pack-objects --rev --stdout >all.pack <<-EOF &&
 	HEAD
 	EOF
 	git -C r2 index-pack ../all.pack &&
-	git -C r2 verify-pack -v ../all.pack \
-		| grep blob \
-		| awk -f print_1.awk \
-		| sort >observed &&
+
+	git -C r2 verify-pack -v ../all.pack |
+	grep blob |
+	awk -f print_1.awk |
+	sort >observed &&
+
 	test_cmp observed expected
 '
 
@@ -94,10 +104,12 @@ test_expect_success 'verify blob:limit=500 omits all blobs' '
 	HEAD
 	EOF
 	git -C r2 index-pack ../filter.pack &&
-	git -C r2 verify-pack -v ../filter.pack \
-		| grep blob \
-		| awk -f print_1.awk \
-		| sort >observed &&
+
+	git -C r2 verify-pack -v ../filter.pack |
+	grep blob |
+	awk -f print_1.awk |
+	sort >observed &&
+
 	nr=$(wc -l <observed) &&
 	test 0 -eq $nr
 '
@@ -107,99 +119,118 @@ test_expect_success 'verify blob:limit=1000' '
 	HEAD
 	EOF
 	git -C r2 index-pack ../filter.pack &&
-	git -C r2 verify-pack -v ../filter.pack \
-		| grep blob \
-		| awk -f print_1.awk \
-		| sort >observed &&
+
+	git -C r2 verify-pack -v ../filter.pack |
+	grep blob |
+	awk -f print_1.awk |
+	sort >observed &&
+
 	nr=$(wc -l <observed) &&
 	test 0 -eq $nr
 '
 
 test_expect_success 'verify blob:limit=1001' '
-	git -C r2 ls-files -s large.1000 \
-		| awk -f print_2.awk \
-		| sort >expected &&
+	git -C r2 ls-files -s large.1000 |
+	awk -f print_2.awk |
+	sort >expected &&
+
 	git -C r2 pack-objects --rev --stdout --filter=blob:limit=1001 >filter.pack <<-EOF &&
 	HEAD
 	EOF
 	git -C r2 index-pack ../filter.pack &&
-	git -C r2 verify-pack -v ../filter.pack \
-		| grep blob \
-		| awk -f print_1.awk \
-		| sort >observed &&
+
+	git -C r2 verify-pack -v ../filter.pack |
+	grep blob |
+	awk -f print_1.awk |
+	sort >observed &&
+
 	test_cmp observed expected
 '
 
 test_expect_success 'verify blob:limit=10001' '
-	git -C r2 ls-files -s large.1000 large.10000 \
-		| awk -f print_2.awk \
-		| sort >expected &&
+	git -C r2 ls-files -s large.1000 large.10000 |
+	awk -f print_2.awk |
+	sort >expected &&
+
 	git -C r2 pack-objects --rev --stdout --filter=blob:limit=10001 >filter.pack <<-EOF &&
 	HEAD
 	EOF
 	git -C r2 index-pack ../filter.pack &&
-	git -C r2 verify-pack -v ../filter.pack \
-		| grep blob \
-		| awk -f print_1.awk \
-		| sort >observed &&
+
+	git -C r2 verify-pack -v ../filter.pack |
+	grep blob |
+	awk -f print_1.awk |
+	sort >observed &&
+
 	test_cmp observed expected
 '
 
 test_expect_success 'verify blob:limit=1k' '
-	git -C r2 ls-files -s large.1000 \
-		| awk -f print_2.awk \
-		| sort >expected &&
+	git -C r2 ls-files -s large.1000 |
+	awk -f print_2.awk |
+	sort >expected &&
+
 	git -C r2 pack-objects --rev --stdout --filter=blob:limit=1k >filter.pack <<-EOF &&
 	HEAD
 	EOF
 	git -C r2 index-pack ../filter.pack &&
-	git -C r2 verify-pack -v ../filter.pack \
-		| grep blob \
-		| awk -f print_1.awk \
-		| sort >observed &&
+
+	git -C r2 verify-pack -v ../filter.pack |
+	grep blob |
+	awk -f print_1.awk |
+	sort >observed &&
+
 	test_cmp observed expected
 '
 
 test_expect_success 'verify explicitly specifying oversized blob in input' '
-	git -C r2 ls-files -s large.1000 large.10000 \
-		| awk -f print_2.awk \
-		| sort >expected &&
+	git -C r2 ls-files -s large.1000 large.10000 |
+	awk -f print_2.awk |
+	sort >expected &&
+
 	git -C r2 pack-objects --rev --stdout --filter=blob:limit=1k >filter.pack <<-EOF &&
 	HEAD
 	$(git -C r2 rev-parse HEAD:large.10000)
 	EOF
 	git -C r2 index-pack ../filter.pack &&
-	git -C r2 verify-pack -v ../filter.pack \
-		| grep blob \
-		| awk -f print_1.awk \
-		| sort >observed &&
+
+	git -C r2 verify-pack -v ../filter.pack |
+	grep blob |
+	awk -f print_1.awk |
+	sort >observed &&
+
 	test_cmp observed expected
 '
 
 test_expect_success 'verify blob:limit=1m' '
-	git -C r2 ls-files -s large.1000 large.10000 \
-		| awk -f print_2.awk \
-		| sort >expected &&
+	git -C r2 ls-files -s large.1000 large.10000 |
+	awk -f print_2.awk |
+	sort >expected &&
+
 	git -C r2 pack-objects --rev --stdout --filter=blob:limit=1m >filter.pack <<-EOF &&
 	HEAD
 	EOF
 	git -C r2 index-pack ../filter.pack &&
-	git -C r2 verify-pack -v ../filter.pack \
-		| grep blob \
-		| awk -f print_1.awk \
-		| sort >observed &&
+
+	git -C r2 verify-pack -v ../filter.pack |
+	grep blob |
+	awk -f print_1.awk |
+	sort >observed &&
+
 	test_cmp observed expected
 '
 
 test_expect_success 'verify normal and blob:limit packfiles have same commits/trees' '
-	git -C r2 verify-pack -v ../all.pack \
-		| grep -E "commit|tree" \
-		| awk -f print_1.awk \
-		| sort >expected &&
-	git -C r2 verify-pack -v ../filter.pack \
-		| grep -E "commit|tree" \
-		| awk -f print_1.awk \
-		| sort >observed &&
+	git -C r2 verify-pack -v ../all.pack |
+	grep -E "commit|tree" |
+	awk -f print_1.awk |
+	sort >expected &&
+
+	git -C r2 verify-pack -v ../filter.pack |
+	grep -E "commit|tree" |
+	awk -f print_1.awk |
+	sort >observed &&
+
 	test_cmp observed expected
 '
 
@@ -224,71 +255,84 @@ test_expect_success 'setup r3' '
 '
 
 test_expect_success 'verify blob count in normal packfile' '
-	git -C r3 ls-files -s sparse1 sparse2 dir1/sparse1 dir1/sparse2 \
-		| awk -f print_2.awk \
-		| sort >expected &&
+	git -C r3 ls-files -s sparse1 sparse2 dir1/sparse1 dir1/sparse2 |
+	awk -f print_2.awk |
+	sort >expected &&
+
 	git -C r3 pack-objects --rev --stdout >all.pack <<-EOF &&
 	HEAD
 	EOF
 	git -C r3 index-pack ../all.pack &&
-	git -C r3 verify-pack -v ../all.pack \
-		| grep blob \
-		| awk -f print_1.awk \
-		| sort >observed &&
+
+	git -C r3 verify-pack -v ../all.pack |
+	grep blob |
+	awk -f print_1.awk |
+	sort >observed &&
+
 	test_cmp observed expected
 '
 
 test_expect_success 'verify sparse:path=pattern1' '
-	git -C r3 ls-files -s dir1/sparse1 dir1/sparse2 \
-		| awk -f print_2.awk \
-		| sort >expected &&
+	git -C r3 ls-files -s dir1/sparse1 dir1/sparse2 |
+	awk -f print_2.awk |
+	sort >expected &&
+
 	git -C r3 pack-objects --rev --stdout --filter=sparse:path=../pattern1 >filter.pack <<-EOF &&
 	HEAD
 	EOF
 	git -C r3 index-pack ../filter.pack &&
-	git -C r3 verify-pack -v ../filter.pack \
-		| grep blob \
-		| awk -f print_1.awk \
-		| sort >observed &&
+
+	git -C r3 verify-pack -v ../filter.pack |
+	grep blob |
+	awk -f print_1.awk |
+	sort >observed &&
+
 	test_cmp observed expected
 '
 
 test_expect_success 'verify normal and sparse:path=pattern1 packfiles have same commits/trees' '
-	git -C r3 verify-pack -v ../all.pack \
-		| grep -E "commit|tree" \
-		| awk -f print_1.awk \
-		| sort >expected &&
-	git -C r3 verify-pack -v ../filter.pack \
-		| grep -E "commit|tree" \
-		| awk -f print_1.awk \
-		| sort >observed &&
+	git -C r3 verify-pack -v ../all.pack |
+	grep -E "commit|tree" |
+	awk -f print_1.awk |
+	sort >expected &&
+
+	git -C r3 verify-pack -v ../filter.pack |
+	grep -E "commit|tree" |
+	awk -f print_1.awk |
+	sort >observed &&
+
 	test_cmp observed expected
 '
 
 test_expect_success 'verify sparse:path=pattern2' '
-	git -C r3 ls-files -s sparse1 dir1/sparse1 \
-		| awk -f print_2.awk \
-		| sort >expected &&
+	git -C r3 ls-files -s sparse1 dir1/sparse1 |
+	awk -f print_2.awk |
+	sort >expected &&
+
 	git -C r3 pack-objects --rev --stdout --filter=sparse:path=../pattern2 >filter.pack <<-EOF &&
 	HEAD
 	EOF
 	git -C r3 index-pack ../filter.pack &&
-	git -C r3 verify-pack -v ../filter.pack \
-		| grep blob \
-		| awk -f print_1.awk \
-		| sort >observed &&
+
+	git -C r3 verify-pack -v ../filter.pack |
+	grep blob |
+	awk -f print_1.awk |
+	sort >observed &&
+
 	test_cmp observed expected
 '
 
 test_expect_success 'verify normal and sparse:path=pattern2 packfiles have same commits/trees' '
-	git -C r3 verify-pack -v ../all.pack \
-		| grep -E "commit|tree" \
-		| awk -f print_1.awk \
-		| sort >expected &&
-	git -C r3 verify-pack -v ../filter.pack \
-		| grep -E "commit|tree" \
-		| awk -f print_1.awk \
-		| sort >observed &&
+	git -C r3 verify-pack -v ../all.pack |
+	grep -E "commit|tree" |
+	awk -f print_1.awk |
+	sort >expected &&
+
+	git -C r3 verify-pack -v ../filter.pack |
+	grep -E "commit|tree" |
+	awk -f print_1.awk |
+	sort >observed &&
+
 	test_cmp observed expected
 '
 
@@ -312,48 +356,57 @@ test_expect_success 'setup r4' '
 '
 
 test_expect_success 'verify blob count in normal packfile' '
-	git -C r4 ls-files -s pattern sparse1 sparse2 dir1/sparse1 dir1/sparse2 \
-		| awk -f print_2.awk \
-		| sort >expected &&
+	git -C r4 ls-files -s pattern sparse1 sparse2 dir1/sparse1 dir1/sparse2 |
+	awk -f print_2.awk |
+	sort >expected &&
+
 	git -C r4 pack-objects --rev --stdout >all.pack <<-EOF &&
 	HEAD
 	EOF
 	git -C r4 index-pack ../all.pack &&
-	git -C r4 verify-pack -v ../all.pack \
-		| grep blob \
-		| awk -f print_1.awk \
-		| sort >observed &&
+
+	git -C r4 verify-pack -v ../all.pack |
+	grep blob |
+	awk -f print_1.awk |
+	sort >observed &&
+
 	test_cmp observed expected
 '
 
 test_expect_success 'verify sparse:oid=OID' '
-	git -C r4 ls-files -s dir1/sparse1 dir1/sparse2 \
-		| awk -f print_2.awk \
-		| sort >expected &&
+	git -C r4 ls-files -s dir1/sparse1 dir1/sparse2 |
+	awk -f print_2.awk |
+	sort >expected &&
+
 	oid=$(git -C r4 ls-files -s pattern | awk -f print_2.awk) &&
 	git -C r4 pack-objects --rev --stdout --filter=sparse:oid=$oid >filter.pack <<-EOF &&
 	HEAD
 	EOF
 	git -C r4 index-pack ../filter.pack &&
-	git -C r4 verify-pack -v ../filter.pack \
-		| grep blob \
-		| awk -f print_1.awk \
-		| sort >observed &&
+
+	git -C r4 verify-pack -v ../filter.pack |
+	grep blob |
+	awk -f print_1.awk |
+	sort >observed &&
+
 	test_cmp observed expected
 '
 
 test_expect_success 'verify sparse:oid=oid-ish' '
-	git -C r4 ls-files -s dir1/sparse1 dir1/sparse2 \
-		| awk -f print_2.awk \
-		| sort >expected &&
+	git -C r4 ls-files -s dir1/sparse1 dir1/sparse2 |
+	awk -f print_2.awk |
+	sort >expected &&
+
 	git -C r4 pack-objects --rev --stdout --filter=sparse:oid=master:pattern >filter.pack <<-EOF &&
 	HEAD
 	EOF
 	git -C r4 index-pack ../filter.pack &&
-	git -C r4 verify-pack -v ../filter.pack \
-		| grep blob \
-		| awk -f print_1.awk \
-		| sort >observed &&
+
+	git -C r4 verify-pack -v ../filter.pack |
+	grep blob |
+	awk -f print_1.awk |
+	sort >observed &&
+
 	test_cmp observed expected
 '
 
@@ -361,9 +414,10 @@ test_expect_success 'verify sparse:oid=oid-ish' '
 # This models previously omitted objects that we did not receive.
 
 test_expect_success 'setup r1 - delete loose blobs' '
-	git -C r1 ls-files -s file.1 file.2 file.3 file.4 file.5 \
-		| awk -f print_2.awk \
-		| sort >expected &&
+	git -C r1 ls-files -s file.1 file.2 file.3 file.4 file.5 |
+	awk -f print_2.awk |
+	sort >expected &&
+
 	for id in `cat expected | sed "s|..|&/|"`
 	do
 		rm r1/.git/objects/$id
diff --git a/t/t5500-fetch-pack.sh b/t/t5500-fetch-pack.sh
index 1b5a4a6d3..5ac6f286d 100755
--- a/t/t5500-fetch-pack.sh
+++ b/t/t5500-fetch-pack.sh
@@ -50,8 +50,9 @@ pull_to_client () {
 			case "$heads" in *B*)
 			    git update-ref refs/heads/B "$BTIP";;
 			esac &&
-			git symbolic-ref HEAD refs/heads/$(echo $heads \
-				| sed -e "s/^\(.\).*$/\1/") &&
+
+			git symbolic-ref HEAD refs/heads/$(echo $heads |
+			sed -e "s/^\(.\).*$/\1/") &&
 
 			git fsck --full &&
 
diff --git a/t/t5616-partial-clone.sh b/t/t5616-partial-clone.sh
index bbbe7537d..e4d032c9d 100755
--- a/t/t5616-partial-clone.sh
+++ b/t/t5616-partial-clone.sh
@@ -34,10 +34,12 @@ test_expect_success 'setup bare clone for server' '
 # confirm partial clone was registered in the local config.
 test_expect_success 'do partial clone 1' '
 	git clone --no-checkout --filter=blob:none "file://$(pwd)/srv.bare" pc1 &&
-	git -C pc1 rev-list HEAD --quiet --objects --missing=print \
-		| awk -f print_1.awk \
-		| sed "s/?//" \
-		| sort >observed.oids &&
+
+	git -C pc1 rev-list HEAD --quiet --objects --missing=print |
+	awk -f print_1.awk |
+	sed "s/?//" |
+	sort >observed.oids &&
+
 	test_cmp expect_1.oids observed.oids &&
 	test "$(git -C pc1 config --local core.repositoryformatversion)" = "1" &&
 	test "$(git -C pc1 config --local extensions.partialclone)" = "origin" &&
@@ -130,16 +132,20 @@ test_expect_success 'push new commits to server for file.3.txt' '
 # perhaps combined with a command in dry-run mode.
 test_expect_success 'manual prefetch of missing objects' '
 	git -C pc1 fetch --filter=blob:none origin &&
-	git -C pc1 rev-list master..origin/master --quiet --objects --missing=print \
-		| awk -f print_1.awk \
-		| sed "s/?//" \
-		| sort >observed.oids &&
+
+	git -C pc1 rev-list master..origin/master --quiet --objects --missing=print |
+	awk -f print_1.awk |
+	sed "s/?//" |
+	sort >observed.oids &&
+
 	test_line_count = 6 observed.oids &&
 	git -C pc1 fetch-pack --stdin "file://$(pwd)/srv.bare" <observed.oids &&
-	git -C pc1 rev-list master..origin/master --quiet --objects --missing=print \
-		| awk -f print_1.awk \
-		| sed "s/?//" \
-		| sort >observed.oids &&
+
+	git -C pc1 rev-list master..origin/master --quiet --objects --missing=print |
+	awk -f print_1.awk |
+	sed "s/?//" |
+	sort >observed.oids &&
+
 	test_line_count = 0 observed.oids
 '
 
@@ -194,7 +200,7 @@ test_expect_success 'upon cloning, check that all refs point to objects' '
 
 	# Craft a packfile not including that blob.
 	git -C "$SERVER" rev-parse HEAD |
-		git -C "$SERVER" pack-objects --stdout >incomplete.pack &&
+	git -C "$SERVER" pack-objects --stdout >incomplete.pack &&
 
 	# Replace the existing packfile with the crafted one. The protocol
 	# requires that the packfile be sent in sideband 1, hence the extra
diff --git a/t/t6112-rev-list-filters-objects.sh b/t/t6112-rev-list-filters-objects.sh
index d4ff0b3be..0f6b569e1 100755
--- a/t/t6112-rev-list-filters-objects.sh
+++ b/t/t6112-rev-list-filters-objects.sh
@@ -20,24 +20,28 @@ test_expect_success 'setup r1' '
 '
 
 test_expect_success 'verify blob:none omits all 5 blobs' '
-	git -C r1 ls-files -s file.1 file.2 file.3 file.4 file.5 \
-		| awk -f print_2.awk \
-		| sort >expected &&
-	git -C r1 rev-list HEAD --quiet --objects --filter-print-omitted --filter=blob:none \
-		| awk -f print_1.awk \
-		| sed "s/~//" \
-		| sort >observed &&
+	git -C r1 ls-files -s file.1 file.2 file.3 file.4 file.5 |
+	awk -f print_2.awk |
+	sort >expected &&
+
+	git -C r1 rev-list HEAD --quiet --objects --filter-print-omitted --filter=blob:none |
+	awk -f print_1.awk |
+	sed "s/~//" |
+	sort >observed &&
+
 	test_cmp observed expected
 '
 
 test_expect_success 'verify emitted+omitted == all' '
-	git -C r1 rev-list HEAD --objects \
-		| awk -f print_1.awk \
-		| sort >expected &&
-	git -C r1 rev-list HEAD --objects --filter-print-omitted --filter=blob:none \
-		| awk -f print_1.awk \
-		| sed "s/~//" \
-		| sort >observed &&
+	git -C r1 rev-list HEAD --objects |
+	awk -f print_1.awk |
+	sort >expected &&
+
+	git -C r1 rev-list HEAD --objects --filter-print-omitted --filter=blob:none |
+	awk -f print_1.awk |
+	sed "s/~//" |
+	sort >observed &&
+
 	test_cmp observed expected
 '
 
@@ -58,65 +62,76 @@ test_expect_success 'setup r2' '
 '
 
 test_expect_success 'verify blob:limit=500 omits all blobs' '
-	git -C r2 ls-files -s large.1000 large.10000 \
-		| awk -f print_2.awk \
-		| sort >expected &&
-	git -C r2 rev-list HEAD --quiet --objects --filter-print-omitted --filter=blob:limit=500 \
-		| awk -f print_1.awk \
-		| sed "s/~//" \
-		| sort >observed &&
+	git -C r2 ls-files -s large.1000 large.10000 |
+	awk -f print_2.awk |
+	sort >expected &&
+
+	git -C r2 rev-list HEAD --quiet --objects --filter-print-omitted --filter=blob:limit=500 |
+	awk -f print_1.awk |
+	sed "s/~//" |
+	sort >observed &&
+
 	test_cmp observed expected
 '
 
 test_expect_success 'verify emitted+omitted == all' '
-	git -C r2 rev-list HEAD --objects \
-		| awk -f print_1.awk \
-		| sort >expected &&
-	git -C r2 rev-list HEAD --objects --filter-print-omitted --filter=blob:limit=500 \
-		| awk -f print_1.awk \
-		| sed "s/~//" \
-		| sort >observed &&
+	git -C r2 rev-list HEAD --objects |
+	awk -f print_1.awk |
+	sort >expected &&
+
+	git -C r2 rev-list HEAD --objects --filter-print-omitted --filter=blob:limit=500 |
+	awk -f print_1.awk |
+	sed "s/~//" |
+	sort >observed &&
+
 	test_cmp observed expected
 '
 
 test_expect_success 'verify blob:limit=1000' '
-	git -C r2 ls-files -s large.1000 large.10000 \
-		| awk -f print_2.awk \
-		| sort >expected &&
-	git -C r2 rev-list HEAD --quiet --objects --filter-print-omitted --filter=blob:limit=1000 \
-		| awk -f print_1.awk \
-		| sed "s/~//" \
-		| sort >observed &&
+	git -C r2 ls-files -s large.1000 large.10000 |
+	awk -f print_2.awk |
+	sort >expected &&
+
+	git -C r2 rev-list HEAD --quiet --objects --filter-print-omitted --filter=blob:limit=1000 |
+	awk -f print_1.awk |
+	sed "s/~//" |
+	sort >observed &&
+
 	test_cmp observed expected
 '
 
 test_expect_success 'verify blob:limit=1001' '
-	git -C r2 ls-files -s large.10000 \
-		| awk -f print_2.awk \
-		| sort >expected &&
-	git -C r2 rev-list HEAD --quiet --objects --filter-print-omitted --filter=blob:limit=1001 \
-		| awk -f print_1.awk \
-		| sed "s/~//" \
-		| sort >observed &&
+	git -C r2 ls-files -s large.10000 |
+	awk -f print_2.awk |
+	sort >expected &&
+
+	git -C r2 rev-list HEAD --quiet --objects --filter-print-omitted --filter=blob:limit=1001 |
+	awk -f print_1.awk |
+	sed "s/~//" |
+	sort >observed &&
+
 	test_cmp observed expected
 '
 
 test_expect_success 'verify blob:limit=1k' '
-	git -C r2 ls-files -s large.10000 \
-		| awk -f print_2.awk \
-		| sort >expected &&
-	git -C r2 rev-list HEAD --quiet --objects --filter-print-omitted --filter=blob:limit=1k \
-		| awk -f print_1.awk \
-		| sed "s/~//" \
-		| sort >observed &&
+	git -C r2 ls-files -s large.10000 |
+	awk -f print_2.awk |
+	sort >expected &&
+
+	git -C r2 rev-list HEAD --quiet --objects --filter-print-omitted --filter=blob:limit=1k |
+	awk -f print_1.awk |
+	sed "s/~//" |
+	sort >observed &&
+
 	test_cmp observed expected
 '
 
 test_expect_success 'verify blob:limit=1m' '
-	git -C r2 rev-list HEAD --quiet --objects --filter-print-omitted --filter=blob:limit=1m \
-		| awk -f print_1.awk \
-		| sed "s/~//" \
-		| sort >observed &&
+	git -C r2 rev-list HEAD --quiet --objects --filter-print-omitted --filter=blob:limit=1m |
+	awk -f print_1.awk |
+	sed "s/~//" |
+	sort >observed &&
+
 	test_must_be_empty observed
 '
 
@@ -141,24 +156,28 @@ test_expect_success 'setup r3' '
 '
 
 test_expect_success 'verify sparse:path=pattern1 omits top-level files' '
-	git -C r3 ls-files -s sparse1 sparse2 \
-		| awk -f print_2.awk \
-		| sort >expected &&
-	git -C r3 rev-list HEAD --quiet --objects --filter-print-omitted --filter=sparse:path=../pattern1 \
-		| awk -f print_1.awk \
-		| sed "s/~//" \
-		| sort >observed &&
+	git -C r3 ls-files -s sparse1 sparse2 |
+	awk -f print_2.awk |
+	sort >expected &&
+
+	git -C r3 rev-list HEAD --quiet --objects --filter-print-omitted --filter=sparse:path=../pattern1 |
+	awk -f print_1.awk |
+	sed "s/~//" |
+	sort >observed &&
+
 	test_cmp observed expected
 '
 
 test_expect_success 'verify sparse:path=pattern2 omits both sparse2 files' '
-	git -C r3 ls-files -s sparse2 dir1/sparse2 \
-		| awk -f print_2.awk \
-		| sort >expected &&
-	git -C r3 rev-list HEAD --quiet --objects --filter-print-omitted --filter=sparse:path=../pattern2 \
-		| awk -f print_1.awk \
-		| sed "s/~//" \
-		| sort >observed &&
+	git -C r3 ls-files -s sparse2 dir1/sparse2 |
+	awk -f print_2.awk |
+	sort >expected &&
+
+	git -C r3 rev-list HEAD --quiet --objects --filter-print-omitted --filter=sparse:path=../pattern2 |
+	awk -f print_1.awk |
+	sed "s/~//" |
+	sort >observed &&
+
 	test_cmp observed expected
 '
 
@@ -173,25 +192,30 @@ test_expect_success 'setup r3 part 2' '
 '
 
 test_expect_success 'verify sparse:oid=OID omits top-level files' '
-	git -C r3 ls-files -s pattern sparse1 sparse2 \
-		| awk -f print_2.awk \
-		| sort >expected &&
+	git -C r3 ls-files -s pattern sparse1 sparse2 |
+	awk -f print_2.awk |
+	sort >expected &&
+
 	oid=$(git -C r3 ls-files -s pattern | awk -f print_2.awk) &&
-	git -C r3 rev-list HEAD --quiet --objects --filter-print-omitted --filter=sparse:oid=$oid \
-		| awk -f print_1.awk \
-		| sed "s/~//" \
-		| sort >observed &&
+
+	git -C r3 rev-list HEAD --quiet --objects --filter-print-omitted --filter=sparse:oid=$oid |
+	awk -f print_1.awk |
+	sed "s/~//" |
+	sort >observed &&
+
 	test_cmp observed expected
 '
 
 test_expect_success 'verify sparse:oid=oid-ish omits top-level files' '
-	git -C r3 ls-files -s pattern sparse1 sparse2 \
-		| awk -f print_2.awk \
-		| sort >expected &&
-	git -C r3 rev-list HEAD --quiet --objects --filter-print-omitted --filter=sparse:oid=master:pattern \
-		| awk -f print_1.awk \
-		| sed "s/~//" \
-		| sort >observed &&
+	git -C r3 ls-files -s pattern sparse1 sparse2 |
+	awk -f print_2.awk |
+	sort >expected &&
+
+	git -C r3 rev-list HEAD --quiet --objects --filter-print-omitted --filter=sparse:oid=master:pattern |
+	awk -f print_1.awk |
+	sed "s/~//" |
+	sort >observed &&
+
 	test_cmp observed expected
 '
 
@@ -199,17 +223,20 @@ test_expect_success 'verify sparse:oid=oid-ish omits top-level files' '
 # This models previously omitted objects that we did not receive.
 
 test_expect_success 'rev-list W/ --missing=print' '
-	git -C r1 ls-files -s file.1 file.2 file.3 file.4 file.5 \
-		| awk -f print_2.awk \
-		| sort >expected &&
+	git -C r1 ls-files -s file.1 file.2 file.3 file.4 file.5 |
+	awk -f print_2.awk |
+	sort >expected &&
+
 	for id in `cat expected | sed "s|..|&/|"`
 	do
 		rm r1/.git/objects/$id
 	done &&
-	git -C r1 rev-list --quiet HEAD --missing=print --objects \
-		| awk -f print_1.awk \
-		| sed "s/?//" \
-		| sort >observed &&
+
+	git -C r1 rev-list --quiet HEAD --missing=print --objects |
+	awk -f print_1.awk |
+	sed "s/?//" |
+	sort >observed &&
+
 	test_cmp observed expected
 '
 
-- 
2.19.0.444.g18242da7ef-goog

