Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3ED091F461
	for <e@80x24.org>; Tue, 20 Aug 2019 07:18:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729326AbfHTHSx (ORCPT <rfc822;e@80x24.org>);
        Tue, 20 Aug 2019 03:18:53 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:38142 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729047AbfHTHSw (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Aug 2019 03:18:52 -0400
Received: by mail-io1-f68.google.com with SMTP id p12so7640661iog.5
        for <git@vger.kernel.org>; Tue, 20 Aug 2019 00:18:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ZMJgUQj6PsL1h4340jQxou3fRQCVPRyij40y0ivGSrs=;
        b=XbJyk9e/4Z+GyaH+j2Z48YQLXT9KPVhrxD9FiXuIRovExcXiHY+5tp9VbdVIYCnzCB
         aomOEYb6Jyg+tMRorkKHN4Sob8mw3LAfk7x5wRgCCR+Kh4KUI+3LjZEaTJLEvBBfS2JH
         ljCZcs/f0Y9RW+dyzb1WdIXwqpOhjJqolIdQtHmdgblS2z79wpYb+FQiU8zR/EFLdvId
         FiVfmmo85/u4mY5D8N5Jg4N+2tS7vk84Zi5R4sD35pQhsOkLyNIIqQdRz0nwAMZ9QP94
         +qhKHOi3RVFYqfyRHkTr0o07KwM46YjJcpIT2j3hHUjeM2Zkr0XSGnNvdLZ8KAGCXTvp
         UVVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ZMJgUQj6PsL1h4340jQxou3fRQCVPRyij40y0ivGSrs=;
        b=cudSOPm7qplFAjJuQBkjQyt4ScQGZy6Bx4IrAzbo8MPWF7n1P4IuGWY4kpYQI4/+PO
         h0/CZwXmAqGdXgaNROSGPrCFPMZDb5kPs4FBaHKEgJ3dsMhc1T32oQ0gydULRh0cEkDQ
         dfqZTyxmO2FXOz8xmB+SisQ3z2o/M5skCtnU3/Slx1Awbww9Na2Kcr2GkKwxTNgxFTI7
         Vw9NDFZnNtNTR5lUXm2Ejg/vvDZ2PLw40WOPa8FvJf6A6QO8WUR5J8WNPcQNezUkIRtV
         lLq+nVk7L0MPlUiDXaNCqDSmZw+TMVRnR5jPxYncysqb5dwIGJmotR1BhJMReKIe1fzK
         qEJQ==
X-Gm-Message-State: APjAAAXxZJWb/NYHg+MJKCE4HAdmhAuEdBffItraIqlb8+5nI2LFeN4i
        X5XXVBAD+pq6qSFJhcfu47JId3+F
X-Google-Smtp-Source: APXvYqwqzFBjZ9xMNIk2dxxPDd2Jpq3zK5Bc17GADDWvqG9VwFMLCweQ/1GNByDQvue/jJ54fvuOFQ==
X-Received: by 2002:a05:6638:a12:: with SMTP id 18mr2098865jan.123.1566285531197;
        Tue, 20 Aug 2019 00:18:51 -0700 (PDT)
Received: from archbookpro.localdomain (CPE18593399858a-CM185933998587.cpe.net.cable.rogers.com. [174.112.89.95])
        by smtp.gmail.com with ESMTPSA id q3sm10954235ios.70.2019.08.20.00.18.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Aug 2019 00:18:50 -0700 (PDT)
Date:   Tue, 20 Aug 2019 03:18:48 -0400
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v3 02/13] t4014: s/expected/expect/
Message-ID: <568b3a03a08faf109220aff47c1fd3e68fde3bfe.1566285151.git.liu.denton@gmail.com>
References: <cover.1566258525.git.liu.denton@gmail.com>
 <cover.1566285151.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1566285151.git.liu.denton@gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

For test cases, the usual convention is to name expected output files
"expect", not "expected". Replace all instances with "expected" with
"expect" except for one case where the "expected" is used as the name
of a test case.

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 t/t4014-format-patch.sh | 106 ++++++++++++++++++++--------------------
 1 file changed, 53 insertions(+), 53 deletions(-)

diff --git a/t/t4014-format-patch.sh b/t/t4014-format-patch.sh
index 3ed3feabfe..62f5680f05 100755
--- a/t/t4014-format-patch.sh
+++ b/t/t4014-format-patch.sh
@@ -1209,32 +1209,32 @@ append_signoff()
 
 test_expect_success 'signoff: commit with no body' '
 	append_signoff </dev/null >actual &&
-	cat <<\EOF | sed "s/EOL$//" >expected &&
+	cat <<\EOF | sed "s/EOL$//" >expect &&
 4:Subject: [PATCH] EOL
 8:
 9:Signed-off-by: C O Mitter <committer@example.com>
 EOF
-	test_cmp expected actual
+	test_cmp expect actual
 '
 
 test_expect_success 'signoff: commit with only subject' '
 	echo subject | append_signoff >actual &&
-	cat >expected <<\EOF &&
+	cat >expect <<\EOF &&
 4:Subject: [PATCH] subject
 8:
 9:Signed-off-by: C O Mitter <committer@example.com>
 EOF
-	test_cmp expected actual
+	test_cmp expect actual
 '
 
 test_expect_success 'signoff: commit with only subject that does not end with NL' '
 	printf subject | append_signoff >actual &&
-	cat >expected <<\EOF &&
+	cat >expect <<\EOF &&
 4:Subject: [PATCH] subject
 8:
 9:Signed-off-by: C O Mitter <committer@example.com>
 EOF
-	test_cmp expected actual
+	test_cmp expect actual
 '
 
 test_expect_success 'signoff: no existing signoffs' '
@@ -1243,24 +1243,24 @@ subject
 
 body
 EOF
-	cat >expected <<\EOF &&
+	cat >expect <<\EOF &&
 4:Subject: [PATCH] subject
 8:
 10:
 11:Signed-off-by: C O Mitter <committer@example.com>
 EOF
-	test_cmp expected actual
+	test_cmp expect actual
 '
 
 test_expect_success 'signoff: no existing signoffs and no trailing NL' '
 	printf "subject\n\nbody" | append_signoff >actual &&
-	cat >expected <<\EOF &&
+	cat >expect <<\EOF &&
 4:Subject: [PATCH] subject
 8:
 10:
 11:Signed-off-by: C O Mitter <committer@example.com>
 EOF
-	test_cmp expected actual
+	test_cmp expect actual
 '
 
 test_expect_success 'signoff: some random signoff' '
@@ -1271,14 +1271,14 @@ body
 
 Signed-off-by: my@house
 EOF
-	cat >expected <<\EOF &&
+	cat >expect <<\EOF &&
 4:Subject: [PATCH] subject
 8:
 10:
 11:Signed-off-by: my@house
 12:Signed-off-by: C O Mitter <committer@example.com>
 EOF
-	test_cmp expected actual
+	test_cmp expect actual
 '
 
 test_expect_success 'signoff: misc conforming footer elements' '
@@ -1292,14 +1292,14 @@ Signed-off-by: my@house
 Tested-by: Some One <someone@example.com>
 Bug: 1234
 EOF
-	cat >expected <<\EOF &&
+	cat >expect <<\EOF &&
 4:Subject: [PATCH] subject
 8:
 10:
 11:Signed-off-by: my@house
 15:Signed-off-by: C O Mitter <committer@example.com>
 EOF
-	test_cmp expected actual
+	test_cmp expect actual
 '
 
 test_expect_success 'signoff: some random signoff-alike' '
@@ -1309,13 +1309,13 @@ subject
 body
 Fooled-by-me: my@house
 EOF
-	cat >expected <<\EOF &&
+	cat >expect <<\EOF &&
 4:Subject: [PATCH] subject
 8:
 11:
 12:Signed-off-by: C O Mitter <committer@example.com>
 EOF
-	test_cmp expected actual
+	test_cmp expect actual
 '
 
 test_expect_success 'signoff: not really a signoff' '
@@ -1324,14 +1324,14 @@ subject
 
 I want to mention about Signed-off-by: here.
 EOF
-	cat >expected <<\EOF &&
+	cat >expect <<\EOF &&
 4:Subject: [PATCH] subject
 8:
 9:I want to mention about Signed-off-by: here.
 10:
 11:Signed-off-by: C O Mitter <committer@example.com>
 EOF
-	test_cmp expected actual
+	test_cmp expect actual
 '
 
 test_expect_success 'signoff: not really a signoff (2)' '
@@ -1341,13 +1341,13 @@ subject
 My unfortunate
 Signed-off-by: example happens to be wrapped here.
 EOF
-	cat >expected <<\EOF &&
+	cat >expect <<\EOF &&
 4:Subject: [PATCH] subject
 8:
 10:Signed-off-by: example happens to be wrapped here.
 11:Signed-off-by: C O Mitter <committer@example.com>
 EOF
-	test_cmp expected actual
+	test_cmp expect actual
 '
 
 test_expect_success 'signoff: valid S-o-b paragraph in the middle' '
@@ -1359,7 +1359,7 @@ Signed-off-by: your@house
 
 A lot of houses.
 EOF
-	cat >expected <<\EOF &&
+	cat >expect <<\EOF &&
 4:Subject: [PATCH] subject
 8:
 9:Signed-off-by: my@house
@@ -1368,7 +1368,7 @@ EOF
 13:
 14:Signed-off-by: C O Mitter <committer@example.com>
 EOF
-	test_cmp expected actual
+	test_cmp expect actual
 '
 
 test_expect_success 'signoff: the same signoff at the end' '
@@ -1379,24 +1379,24 @@ body
 
 Signed-off-by: C O Mitter <committer@example.com>
 EOF
-	cat >expected <<\EOF &&
+	cat >expect <<\EOF &&
 4:Subject: [PATCH] subject
 8:
 10:
 11:Signed-off-by: C O Mitter <committer@example.com>
 EOF
-	test_cmp expected actual
+	test_cmp expect actual
 '
 
 test_expect_success 'signoff: the same signoff at the end, no trailing NL' '
 	printf "subject\n\nSigned-off-by: C O Mitter <committer@example.com>" |
 		append_signoff >actual &&
-	cat >expected <<\EOF &&
+	cat >expect <<\EOF &&
 4:Subject: [PATCH] subject
 8:
 9:Signed-off-by: C O Mitter <committer@example.com>
 EOF
-	test_cmp expected actual
+	test_cmp expect actual
 '
 
 test_expect_success 'signoff: the same signoff NOT at the end' '
@@ -1408,14 +1408,14 @@ body
 Signed-off-by: C O Mitter <committer@example.com>
 Signed-off-by: my@house
 EOF
-	cat >expected <<\EOF &&
+	cat >expect <<\EOF &&
 4:Subject: [PATCH] subject
 8:
 10:
 11:Signed-off-by: C O Mitter <committer@example.com>
 12:Signed-off-by: my@house
 EOF
-	test_cmp expected actual
+	test_cmp expect actual
 '
 
 test_expect_success 'signoff: tolerate garbage in conforming footer' '
@@ -1428,13 +1428,13 @@ Tested-by: my@house
 Some Trash
 Signed-off-by: C O Mitter <committer@example.com>
 EOF
-	cat >expected <<\EOF &&
+	cat >expect <<\EOF &&
 4:Subject: [PATCH] subject
 8:
 10:
 13:Signed-off-by: C O Mitter <committer@example.com>
 EOF
-	test_cmp expected actual
+	test_cmp expect actual
 '
 
 test_expect_success 'signoff: respect trailer config' '
@@ -1444,13 +1444,13 @@ subject
 Myfooter: x
 Some Trash
 EOF
-	cat >expected <<\EOF &&
+	cat >expect <<\EOF &&
 4:Subject: [PATCH] subject
 8:
 11:
 12:Signed-off-by: C O Mitter <committer@example.com>
 EOF
-	test_cmp expected actual &&
+	test_cmp expect actual &&
 
 	test_config trailer.Myfooter.ifexists add &&
 	append_signoff <<\EOF >actual &&
@@ -1459,12 +1459,12 @@ subject
 Myfooter: x
 Some Trash
 EOF
-	cat >expected <<\EOF &&
+	cat >expect <<\EOF &&
 4:Subject: [PATCH] subject
 8:
 11:Signed-off-by: C O Mitter <committer@example.com>
 EOF
-	test_cmp expected actual
+	test_cmp expect actual
 '
 
 test_expect_success 'signoff: footer begins with non-signoff without @ sign' '
@@ -1479,13 +1479,13 @@ Change-id: Ideadbeef
 Signed-off-by: C O Mitter <committer@example.com>
 Bug: 1234
 EOF
-	cat >expected <<\EOF &&
+	cat >expect <<\EOF &&
 4:Subject: [PATCH] subject
 8:
 10:
 14:Signed-off-by: C O Mitter <committer@example.com>
 EOF
-	test_cmp expected actual
+	test_cmp expect actual
 '
 
 test_expect_success 'format patch ignores color.ui' '
@@ -1604,13 +1604,13 @@ test_expect_success 'format-patch --base' '
 	git checkout patchid &&
 	git format-patch --stdout --base=HEAD~3 -1 | tail -n 7 >actual1 &&
 	git format-patch --stdout --base=HEAD~3 HEAD~.. | tail -n 7 >actual2 &&
-	echo >expected &&
-	echo "base-commit: $(git rev-parse HEAD~3)" >>expected &&
-	echo "prerequisite-patch-id: $(git show --patch HEAD~2 | git patch-id --stable | awk "{print \$1}")" >>expected &&
-	echo "prerequisite-patch-id: $(git show --patch HEAD~1 | git patch-id --stable | awk "{print \$1}")" >>expected &&
-	signature >> expected &&
-	test_cmp expected actual1 &&
-	test_cmp expected actual2 &&
+	echo >expect &&
+	echo "base-commit: $(git rev-parse HEAD~3)" >>expect &&
+	echo "prerequisite-patch-id: $(git show --patch HEAD~2 | git patch-id --stable | awk "{print \$1}")" >>expect &&
+	echo "prerequisite-patch-id: $(git show --patch HEAD~1 | git patch-id --stable | awk "{print \$1}")" >>expect &&
+	signature >> expect &&
+	test_cmp expect actual1 &&
+	test_cmp expect actual2 &&
 	echo >fail &&
 	echo "base-commit: $(git rev-parse HEAD~3)" >>fail &&
 	echo "prerequisite-patch-id: $(git show --patch HEAD~2 | git patch-id --unstable | awk "{print \$1}")" >>fail &&
@@ -1625,8 +1625,8 @@ test_expect_success 'format-patch --base errors out when base commit is in revis
 	test_must_fail git format-patch --base=HEAD~1 -2 &&
 	git format-patch --stdout --base=HEAD~2 -2 >patch &&
 	grep "^base-commit:" patch >actual &&
-	echo "base-commit: $(git rev-parse HEAD~2)" >expected &&
-	test_cmp expected actual
+	echo "base-commit: $(git rev-parse HEAD~2)" >expect &&
+	test_cmp expect actual
 '
 
 test_expect_success 'format-patch --base errors out when base commit is not ancestor of revision list' '
@@ -1652,8 +1652,8 @@ test_expect_success 'format-patch --base errors out when base commit is not ance
 	test_must_fail git format-patch --base=$(cat commit-id-Z) -3 &&
 	git format-patch --stdout --base=$(cat commit-id-base) -3 >patch &&
 	grep "^base-commit:" patch >actual &&
-	echo "base-commit: $(cat commit-id-base)" >expected &&
-	test_cmp expected actual
+	echo "base-commit: $(cat commit-id-base)" >expect &&
+	test_cmp expect actual
 '
 
 test_expect_success 'format-patch --base=auto' '
@@ -1664,8 +1664,8 @@ test_expect_success 'format-patch --base=auto' '
 	test_commit N2 &&
 	git format-patch --stdout --base=auto -2 >patch &&
 	grep "^base-commit:" patch >actual &&
-	echo "base-commit: $(git rev-parse upstream)" >expected &&
-	test_cmp expected actual
+	echo "base-commit: $(git rev-parse upstream)" >expect &&
+	test_cmp expect actual
 '
 
 test_expect_success 'format-patch errors out when history involves criss-cross' '
@@ -1701,8 +1701,8 @@ test_expect_success 'format-patch format.useAutoBaseoption' '
 	git config format.useAutoBase true &&
 	git format-patch --stdout -1 >patch &&
 	grep "^base-commit:" patch >actual &&
-	echo "base-commit: $(git rev-parse upstream)" >expected &&
-	test_cmp expected actual
+	echo "base-commit: $(git rev-parse upstream)" >expect &&
+	test_cmp expect actual
 '
 
 test_expect_success 'format-patch --base overrides format.useAutoBase' '
@@ -1710,8 +1710,8 @@ test_expect_success 'format-patch --base overrides format.useAutoBase' '
 	git config format.useAutoBase true &&
 	git format-patch --stdout --base=HEAD~1 -1 >patch &&
 	grep "^base-commit:" patch >actual &&
-	echo "base-commit: $(git rev-parse HEAD~1)" >expected &&
-	test_cmp expected actual
+	echo "base-commit: $(git rev-parse HEAD~1)" >expect &&
+	test_cmp expect actual
 '
 
 test_expect_success 'format-patch --base with --attach' '
-- 
2.23.0.248.g3a9dd8fb08

