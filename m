Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ECD7C20954
	for <e@80x24.org>; Thu,  7 Dec 2017 17:30:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932259AbdLGRal (ORCPT <rfc822;e@80x24.org>);
        Thu, 7 Dec 2017 12:30:41 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:53508 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1753062AbdLGRak (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Dec 2017 12:30:40 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 93498C1500;
        Thu,  7 Dec 2017 12:30:39 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:date:message-id:in-reply-to:references; s=sasl; bh=8euL
        EbDeHERSbvFfsGxztyHUee8=; b=Y0s7wXk42PicFR5rmB5YKdF6d4k7eh/jpMKT
        ovvsDOsAog+iPL+UyZaJ3HbiT+wj8NpU85UzTeCjPTLrStr8JrG+45QNuMldyiJh
        Gp81vhXUkXXXuMWdF6DSORaWg+7WJhd3tCmtyu5eF7oHESEF9s3g8dyAKmfbOFsd
        13atq1M=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:date:message-id:in-reply-to:references; q=dns; s=sasl; b=
        GllS7DKkimcCvTCsX9JtpSue5HhuVweMdDIMnDC087FekkpLHSM6P4xEJTGhAvNe
        qcVLUuEGyyui7BWvxdjqQg8GCbEho+7HgWC7U+ydhVNd4uBkfiAzsk1zG0ebaMSa
        89dHXNid2/4Il4d4Fz+o15Et/H4F6DZaBI4cBCk7oro=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 887FAC14FF;
        Thu,  7 Dec 2017 12:30:39 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 002B5C14FE;
        Thu,  7 Dec 2017 12:30:38 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Cc:     christian.couder@gmail.com, peff@peff.net, jacob.e.keller@intel.com
Subject: [PATCH v2 6/7] t4045: reindent to make helpers readable
Date:   Thu,  7 Dec 2017 09:30:33 -0800
Message-Id: <20171207173034.12865-3-gitster@pobox.com>
X-Mailer: git-send-email 2.15.1-480-gbc5668f98a
In-Reply-To: <20171207173034.12865-1-gitster@pobox.com>
References: <20171207003517.11729-1-jacob.e.keller@intel.com>
 <20171207173034.12865-1-gitster@pobox.com>
X-Pobox-Relay-ID: 5794F74C-DB74-11E7-87FB-8EF31968708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 t/t4045-diff-relative.sh | 95 +++++++++++++++++++++++++-----------------------
 1 file changed, 50 insertions(+), 45 deletions(-)

diff --git a/t/t4045-diff-relative.sh b/t/t4045-diff-relative.sh
index 3950f5034d..fefd2f3f81 100755
--- a/t/t4045-diff-relative.sh
+++ b/t/t4045-diff-relative.sh
@@ -12,59 +12,64 @@ test_expect_success 'setup' '
 	git commit -m one
 '
 
-check_diff() {
-expect=$1; shift
-cat >expected <<EOF
-diff --git a/$expect b/$expect
-new file mode 100644
-index 0000000..25c05ef
---- /dev/null
-+++ b/$expect
-@@ -0,0 +1 @@
-+other content
-EOF
-test_expect_success "-p $*" "
-	git diff -p $* HEAD^ >actual &&
-	test_cmp expected actual
-"
+check_diff () {
+	expect=$1
+	shift
+	cat >expected <<-EOF
+	diff --git a/$expect b/$expect
+	new file mode 100644
+	index 0000000..25c05ef
+	--- /dev/null
+	+++ b/$expect
+	@@ -0,0 +1 @@
+	+other content
+	EOF
+	test_expect_success "-p $*" "
+		git diff -p $* HEAD^ >actual &&
+		test_cmp expected actual
+	"
 }
 
-check_numstat() {
-expect=$1; shift
-cat >expected <<EOF
-1	0	$expect
-EOF
-test_expect_success "--numstat $*" "
-	echo '1	0	$expect' >expected &&
-	git diff --numstat $* HEAD^ >actual &&
-	test_cmp expected actual
-"
+check_numstat () {
+	expect=$1
+	shift
+	cat >expected <<-EOF
+	1	0	$expect
+	EOF
+	test_expect_success "--numstat $*" "
+		echo '1	0	$expect' >expected &&
+		git diff --numstat $* HEAD^ >actual &&
+		test_cmp expected actual
+	"
 }
 
-check_stat() {
-expect=$1; shift
-cat >expected <<EOF
- $expect | 1 +
- 1 file changed, 1 insertion(+)
-EOF
-test_expect_success "--stat $*" "
-	git diff --stat $* HEAD^ >actual &&
-	test_i18ncmp expected actual
-"
+check_stat () {
+	expect=$1
+	shift
+	cat >expected <<-EOF
+	 $expect | 1 +
+	 1 file changed, 1 insertion(+)
+	EOF
+	test_expect_success "--stat $*" "
+		git diff --stat $* HEAD^ >actual &&
+		test_i18ncmp expected actual
+	"
 }
 
-check_raw() {
-expect=$1; shift
-cat >expected <<EOF
-:000000 100644 0000000000000000000000000000000000000000 25c05ef3639d2d270e7fe765a67668f098092bc5 A	$expect
-EOF
-test_expect_success "--raw $*" "
-	git diff --no-abbrev --raw $* HEAD^ >actual &&
-	test_cmp expected actual
-"
+check_raw () {
+	expect=$1
+	shift
+	cat >expected <<-EOF
+	:000000 100644 0000000000000000000000000000000000000000 25c05ef3639d2d270e7fe765a67668f098092bc5 A	$expect
+	EOF
+	test_expect_success "--raw $*" "
+		git diff --no-abbrev --raw $* HEAD^ >actual &&
+		test_cmp expected actual
+	"
 }
 
-for type in diff numstat stat raw; do
+for type in diff numstat stat raw
+do
 	check_$type file2 --relative=subdir/
 	check_$type file2 --relative=subdir
 	check_$type dir/file2 --relative=sub
-- 
2.15.1-480-gbc5668f98a

