Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A0A251F424
	for <e@80x24.org>; Tue, 24 Apr 2018 20:21:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751129AbeDXUVL (ORCPT <rfc822;e@80x24.org>);
        Tue, 24 Apr 2018 16:21:11 -0400
Received: from mx0a-00153501.pphosted.com ([67.231.148.48]:34136 "EHLO
        mx0a-00153501.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750826AbeDXUVJ (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 24 Apr 2018 16:21:09 -0400
Received: from pps.filterd (m0096528.ppops.net [127.0.0.1])
        by mx0a-00153501.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w3OKHNes025690;
        Tue, 24 Apr 2018 13:21:05 -0700
Authentication-Results: palantir.com;
        spf=softfail smtp.mailfrom=newren@gmail.com
Received: from smtp-transport.yojoe.local (mxw3.palantir.com [66.70.54.23] (may be forged))
        by mx0a-00153501.pphosted.com with ESMTP id 2hg4b7v96t-1;
        Tue, 24 Apr 2018 13:21:05 -0700
Received: from mxw1.palantir.com (new-smtp.yojoe.local [172.19.0.45])
        by smtp-transport.yojoe.local (Postfix) with ESMTP id 8A8E82289FAD;
        Tue, 24 Apr 2018 13:21:05 -0700 (PDT)
Received: from newren2-linux.yojoe.local (unknown [10.100.71.66])
        by smtp.yojoe.local (Postfix) with ESMTP id 7163D2CDE67;
        Tue, 24 Apr 2018 13:21:05 -0700 (PDT)
From:   Elijah Newren <newren@gmail.com>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org, sbeller@google.com, szeder.dev@gmail.com,
        martin.agren@gmail.com, Elijah Newren <newren@gmail.com>
Subject: [PATCH v10 2/2] fixup! t6046: testcases checking whether updates can be skipped in a merge
Date:   Tue, 24 Apr 2018 13:21:00 -0700
Message-Id: <20180424202100.23828-2-newren@gmail.com>
X-Mailer: git-send-email 2.17.0.295.g791b7256b2.dirty
In-Reply-To: <20180424202100.23828-1-newren@gmail.com>
References: <xmqqy3hibms3.fsf@gitster-ct.c.googlers.com>
 <20180424202100.23828-1-newren@gmail.com>
X-Proofpoint-SPF-Result: softfail
X-Proofpoint-SPF-Record: v=spf1 redirect=_spf.google.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-04-24_05:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=4 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1034 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=431 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1711220000 definitions=main-1804240192
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

---
 t/t6046-merge-skip-unneeded-updates.sh | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/t/t6046-merge-skip-unneeded-updates.sh b/t/t6046-merge-skip-unneeded-updates.sh
index 880cd782d7..fcefffcaec 100755
--- a/t/t6046-merge-skip-unneeded-updates.sh
+++ b/t/t6046-merge-skip-unneeded-updates.sh
@@ -41,7 +41,7 @@ test_expect_success '1a-setup: Modify(A)/Modify(B), change on B subset of A' '
 	(
 		cd 1a &&
 
-		test_write_lines 1 2 3 4 5 6 7 8 9 10 >b
+		test_write_lines 1 2 3 4 5 6 7 8 9 10 >b &&
 		git add b &&
 		test_tick &&
 		git commit -m "O" &&
@@ -138,7 +138,7 @@ test_expect_success '2a-setup: Modify(A)/rename(B)' '
 	(
 		cd 2a &&
 
-		test_seq 1 10 >b
+		test_seq 1 10 >b &&
 		git add b &&
 		test_tick &&
 		git commit -m "O" &&
@@ -148,7 +148,7 @@ test_expect_success '2a-setup: Modify(A)/rename(B)' '
 		git branch B &&
 
 		git checkout A &&
-		test_seq 1 11 > b &&
+		test_seq 1 11 >b &&
 		git add b &&
 		test_tick &&
 		git commit -m "A" &&
@@ -229,7 +229,7 @@ test_expect_success '2b-setup: Rename+Mod(A)/Mod(B), B mods subset of A' '
 	(
 		cd 2b &&
 
-		test_write_lines 1 2 3 4 5 6 7 8 9 10 >b
+		test_write_lines 1 2 3 4 5 6 7 8 9 10 >b &&
 		git add b &&
 		test_tick &&
 		git commit -m "O" &&
@@ -337,7 +337,7 @@ test_expect_success '2c-setup: Modify b & add c VS rename b->c' '
 	(
 		cd 2c &&
 
-		test_seq 1 10 >b
+		test_seq 1 10 >b &&
 		git add b &&
 		test_tick &&
 		git commit -m "O" &&
@@ -443,7 +443,7 @@ test_expect_success '3a-setup: bq_1->foo/bq_2 on A, foo/->bar/ on B' '
 		git branch B &&
 
 		git checkout A &&
-		test_seq 1 11 > bq &&
+		test_seq 1 11 >bq &&
 		git add bq &&
 		git mv bq foo/ &&
 		test_tick &&
@@ -542,7 +542,7 @@ test_expect_success '3b-setup: bq_1->foo/bq_2 on A, foo/->bar/ on B' '
 		git commit -m "A" &&
 
 		git checkout B &&
-		test_seq 1 11 > bq &&
+		test_seq 1 11 >bq &&
 		git add bq &&
 		git mv foo/ bar/ &&
 		test_tick &&
@@ -624,7 +624,7 @@ test_expect_success '4a-setup: Change on A, change on B subset of A, dirty mods
 	(
 		cd 4a &&
 
-		test_write_lines 1 2 3 4 5 6 7 8 9 10 >b
+		test_write_lines 1 2 3 4 5 6 7 8 9 10 >b &&
 		git add b &&
 		test_tick &&
 		git commit -m "O" &&
@@ -698,7 +698,7 @@ test_expect_success '4b-setup: Rename+Mod(A)/Mod(B), change on B subset of A, di
 	(
 		cd 4b &&
 
-		test_write_lines 1 2 3 4 5 6 7 8 9 10 >b
+		test_write_lines 1 2 3 4 5 6 7 8 9 10 >b &&
 		git add b &&
 		test_tick &&
 		git commit -m "O" &&
-- 
2.17.0.295.g791b7256b2.dirty

