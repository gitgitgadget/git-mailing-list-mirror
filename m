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
	by dcvr.yhbt.net (Postfix) with ESMTP id 543FD1F461
	for <e@80x24.org>; Tue, 20 Aug 2019 07:19:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729374AbfHTHTA (ORCPT <rfc822;e@80x24.org>);
        Tue, 20 Aug 2019 03:19:00 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:43713 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729047AbfHTHTA (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Aug 2019 03:19:00 -0400
Received: by mail-io1-f67.google.com with SMTP id 18so10041609ioe.10
        for <git@vger.kernel.org>; Tue, 20 Aug 2019 00:18:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=gxFfx/GtskVA+8qxu2cO2SZogZyMuZZHPSx3Y+yQlTw=;
        b=lclcKbU01o+fEaBAUKdZ1yTaGfVRkAfIqOhMuadj/eerO+hGvDwSGIUxg9f4A/y7Yn
         heDtZPqAIy+Qop1fnL+kB97e0zL4lloJWJiX7iCH4QjVjcelPLv4t82XCJn46CXanjUO
         qGM1dKmfaCNbD/wFAG0Pw+h9kWaPi0JHHgcqe2oNNrrosaldPrZGVB58LObWX7qtcubO
         xS8//N2yl1xDy1I1DYUsEJP8Anuum2rcRrxp/uqKP3Lo5nvFhNzJB/CCkncaF8uXRN6v
         gnFR6cdyISr95GTOV6WXzZ+hPqpH7A3qYbGmqhdr0IUqGaYcQe9xWl9B8f/iweSQSMQl
         WYZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=gxFfx/GtskVA+8qxu2cO2SZogZyMuZZHPSx3Y+yQlTw=;
        b=ZqWZI6/k85m/8/RfYU6x5rugD41GxgpSCUEu9Isxtof54S2eQnQidv2MjLgZMigOj3
         VKaTcngUyz0Y8c30Wsb8q16gyaXTpnXEeynckKRagH1o8iBqXZrYmW4fu/cXURUhJlW5
         68M5u2FIfIA//O9CRF6BiBjlXyjFx1d/F+Opu+PrpdKbcV+RRu9n/D15PkMsfYPV3VWf
         HnpJ5iMWKxpR3q7w3z6eFpn20TxQQKbpV3Tr1a1Yrz9/ogAurCu3cycmSS5i83FF0xnX
         cuDvXSUY+RVV9WvOQfpp9dodycD3o7sokJjzbkK4Y5rBXXFG37tt1phiytI3tBdU4RuV
         c2Sw==
X-Gm-Message-State: APjAAAWn5WWPZaeJ1kvLFvPP45PvR9AIvBgNUAEh8J06UoSw1z1omQCH
        ORkJbaHf6eaoRI/yh54wSz4U1NT0
X-Google-Smtp-Source: APXvYqwZBIw7gtnUNitYUNbBBq8lmYMKuEFo2AV7E+vxOQimTnJrpvPr1qQvTqpsbiwK3uFNEmRdCg==
X-Received: by 2002:a6b:f711:: with SMTP id k17mr20319956iog.273.1566285538432;
        Tue, 20 Aug 2019 00:18:58 -0700 (PDT)
Received: from archbookpro.localdomain (CPE18593399858a-CM185933998587.cpe.net.cable.rogers.com. [174.112.89.95])
        by smtp.gmail.com with ESMTPSA id t20sm9568942ioc.68.2019.08.20.00.18.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Aug 2019 00:18:58 -0700 (PDT)
Date:   Tue, 20 Aug 2019 03:18:56 -0400
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v3 05/13] t4014: remove spaces after redirect operators
Message-ID: <6f1371275e3ce9ea5b1da1b183a4ccb71b103c5b.1566285151.git.liu.denton@gmail.com>
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

For shell scripts, the usual convention is for there to be no space
after redirection operators, (e.g. `>file`, not `> file`). Remove these
spaces wherever they appear.

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 t/t4014-format-patch.sh | 62 ++++++++++++++++++++---------------------
 1 file changed, 31 insertions(+), 31 deletions(-)

diff --git a/t/t4014-format-patch.sh b/t/t4014-format-patch.sh
index a7b440b003..075affb1e5 100755
--- a/t/t4014-format-patch.sh
+++ b/t/t4014-format-patch.sh
@@ -126,8 +126,8 @@ test_expect_success 'extra headers' '
 " &&
 	git config --add format.headers "Cc: S E Cipient <scipient@example.com>
 " &&
-	git format-patch --stdout master..side > patch2 &&
-	sed -e "/^\$/q" patch2 > hdrs2 &&
+	git format-patch --stdout master..side >patch2 &&
+	sed -e "/^\$/q" patch2 >hdrs2 &&
 	grep "^To: R E Cipient <rcipient@example.com>\$" hdrs2 &&
 	grep "^Cc: S E Cipient <scipient@example.com>\$" hdrs2
 '
@@ -136,7 +136,7 @@ test_expect_success 'extra headers without newlines' '
 	git config --replace-all format.headers "To: R E Cipient <rcipient@example.com>" &&
 	git config --add format.headers "Cc: S E Cipient <scipient@example.com>" &&
 	git format-patch --stdout master..side >patch3 &&
-	sed -e "/^\$/q" patch3 > hdrs3 &&
+	sed -e "/^\$/q" patch3 >hdrs3 &&
 	grep "^To: R E Cipient <rcipient@example.com>\$" hdrs3 &&
 	grep "^Cc: S E Cipient <scipient@example.com>\$" hdrs3
 '
@@ -144,8 +144,8 @@ test_expect_success 'extra headers without newlines' '
 test_expect_success 'extra headers with multiple To:s' '
 	git config --replace-all format.headers "To: R E Cipient <rcipient@example.com>" &&
 	git config --add format.headers "To: S E Cipient <scipient@example.com>" &&
-	git format-patch --stdout master..side > patch4 &&
-	sed -e "/^\$/q" patch4 > hdrs4 &&
+	git format-patch --stdout master..side >patch4 &&
+	sed -e "/^\$/q" patch4 >hdrs4 &&
 	grep "^To: R E Cipient <rcipient@example.com>,\$" hdrs4 &&
 	grep "^ *S E Cipient <scipient@example.com>\$" hdrs4
 '
@@ -318,7 +318,7 @@ test_expect_success 'reroll count (-v)' '
 check_threading () {
 	expect="$1" &&
 	shift &&
-	(git format-patch --stdout "$@"; echo $? > status.out) |
+	(git format-patch --stdout "$@"; echo $? >status.out) |
 	# Prints everything between the Message-ID and In-Reply-To,
 	# and replaces all Message-ID-lookalikes by a sequence number
 	perl -ne '
@@ -333,12 +333,12 @@ check_threading () {
 			print;
 		}
 		print "---\n" if /^From /i;
-	' > actual &&
+	' >actual &&
 	test 0 = "$(cat status.out)" &&
 	test_cmp "$expect" actual
 }
 
-cat >> expect.no-threading <<EOF
+cat >>expect.no-threading <<EOF
 ---
 ---
 ---
@@ -349,7 +349,7 @@ test_expect_success 'no threading' '
 	check_threading expect.no-threading master
 '
 
-cat > expect.thread <<EOF
+cat >expect.thread <<EOF
 ---
 Message-Id: <0>
 ---
@@ -366,7 +366,7 @@ test_expect_success 'thread' '
 	check_threading expect.thread --thread master
 '
 
-cat > expect.in-reply-to <<EOF
+cat >expect.in-reply-to <<EOF
 ---
 Message-Id: <0>
 In-Reply-To: <1>
@@ -386,7 +386,7 @@ test_expect_success 'thread in-reply-to' '
 		--thread master
 '
 
-cat > expect.cover-letter <<EOF
+cat >expect.cover-letter <<EOF
 ---
 Message-Id: <0>
 ---
@@ -407,7 +407,7 @@ test_expect_success 'thread cover-letter' '
 	check_threading expect.cover-letter --cover-letter --thread master
 '
 
-cat > expect.cl-irt <<EOF
+cat >expect.cl-irt <<EOF
 ---
 Message-Id: <0>
 In-Reply-To: <1>
@@ -439,7 +439,7 @@ test_expect_success 'thread explicit shallow' '
 		--in-reply-to="<test.message>" --thread=shallow master
 '
 
-cat > expect.deep <<EOF
+cat >expect.deep <<EOF
 ---
 Message-Id: <0>
 ---
@@ -457,7 +457,7 @@ test_expect_success 'thread deep' '
 	check_threading expect.deep --thread=deep master
 '
 
-cat > expect.deep-irt <<EOF
+cat >expect.deep-irt <<EOF
 ---
 Message-Id: <0>
 In-Reply-To: <1>
@@ -480,7 +480,7 @@ test_expect_success 'thread deep in-reply-to' '
 		--in-reply-to="<test.message>" master
 '
 
-cat > expect.deep-cl <<EOF
+cat >expect.deep-cl <<EOF
 ---
 Message-Id: <0>
 ---
@@ -504,7 +504,7 @@ test_expect_success 'thread deep cover-letter' '
 	check_threading expect.deep-cl --cover-letter --thread=deep master
 '
 
-cat > expect.deep-cl-irt <<EOF
+cat >expect.deep-cl-irt <<EOF
 ---
 Message-Id: <0>
 In-Reply-To: <1>
@@ -584,7 +584,7 @@ test_expect_success 'cover-letter inherits diff options' '
 	grep "file => foo .* 0 *\$" 0000-cover-letter.patch
 '
 
-cat > expect << EOF
+cat >expect <<EOF
   This is an excessively long subject line for a message due to the
     habit some projects have of not having a short, one-line subject at
     the start of the commit message, but rather sticking a whole
@@ -596,11 +596,11 @@ EOF
 
 test_expect_success 'shortlog of cover-letter wraps overly-long onelines' '
 	git format-patch --cover-letter -2 &&
-	sed -e "1,/A U Thor/d" -e "/^\$/q" < 0000-cover-letter.patch > output &&
+	sed -e "1,/A U Thor/d" -e "/^\$/q" <0000-cover-letter.patch >output &&
 	test_cmp expect output
 '
 
-cat > expect << EOF
+cat >expect <<EOF
 index $before..$after 100644
 --- a/file
 +++ b/file
@@ -620,7 +620,7 @@ test_expect_success 'format-patch respects -U' '
 	test_cmp expect output
 '
 
-cat > expect << EOF
+cat >expect <<EOF
 
 diff --git a/file b/file
 index $before..$after 100644
@@ -635,7 +635,7 @@ EOF
 
 test_expect_success 'format-patch -p suppresses stat' '
 	git format-patch -p -2 &&
-	sed -e "1,/^\$/d" -e "/^+5/q" < 0001-This-is-an-excessively-long-subject-line-for-a-messa.patch > output &&
+	sed -e "1,/^\$/d" -e "/^+5/q" <0001-This-is-an-excessively-long-subject-line-for-a-messa.patch >output &&
 	test_cmp expect output
 '
 
@@ -689,7 +689,7 @@ test_expect_success 'format-patch from a subdirectory (3)' '
 '
 
 test_expect_success 'format-patch --in-reply-to' '
-	git format-patch -1 --stdout --in-reply-to "baz@foo.bar" > patch8 &&
+	git format-patch -1 --stdout --in-reply-to "baz@foo.bar" >patch8 &&
 	grep "^In-Reply-To: <baz@foo.bar>" patch8 &&
 	grep "^References: <baz@foo.bar>" patch8
 '
@@ -780,21 +780,21 @@ test_expect_success 'format-patch with multiple notes refs' '
 	! grep "this is note 2" out
 '
 
-echo "fatal: --name-only does not make sense" > expect.name-only
-echo "fatal: --name-status does not make sense" > expect.name-status
-echo "fatal: --check does not make sense" > expect.check
+echo "fatal: --name-only does not make sense" >expect.name-only
+echo "fatal: --name-status does not make sense" >expect.name-status
+echo "fatal: --check does not make sense" >expect.check
 
 test_expect_success 'options no longer allowed for format-patch' '
-	test_must_fail git format-patch --name-only 2> output &&
+	test_must_fail git format-patch --name-only 2>output &&
 	test_i18ncmp expect.name-only output &&
-	test_must_fail git format-patch --name-status 2> output &&
+	test_must_fail git format-patch --name-status 2>output &&
 	test_i18ncmp expect.name-status output &&
-	test_must_fail git format-patch --check 2> output &&
+	test_must_fail git format-patch --check 2>output &&
 	test_i18ncmp expect.check output
 '
 
 test_expect_success 'format-patch --numstat should produce a patch' '
-	git format-patch --numstat --stdout master..side > output &&
+	git format-patch --numstat --stdout master..side >output &&
 	test 5 = $(grep "^diff --git a/" output | wc -l)
 '
 
@@ -1610,14 +1610,14 @@ test_expect_success 'format-patch --base' '
 	echo "base-commit: $(git rev-parse HEAD~3)" >>expect &&
 	echo "prerequisite-patch-id: $(git show --patch HEAD~2 | git patch-id --stable | awk "{print \$1}")" >>expect &&
 	echo "prerequisite-patch-id: $(git show --patch HEAD~1 | git patch-id --stable | awk "{print \$1}")" >>expect &&
-	signature >> expect &&
+	signature >>expect &&
 	test_cmp expect actual1 &&
 	test_cmp expect actual2 &&
 	echo >fail &&
 	echo "base-commit: $(git rev-parse HEAD~3)" >>fail &&
 	echo "prerequisite-patch-id: $(git show --patch HEAD~2 | git patch-id --unstable | awk "{print \$1}")" >>fail &&
 	echo "prerequisite-patch-id: $(git show --patch HEAD~1 | git patch-id --unstable | awk "{print \$1}")" >>fail &&
-	signature >> fail &&
+	signature >>fail &&
 	! test_cmp fail actual1 &&
 	! test_cmp fail actual2
 '
-- 
2.23.0.248.g3a9dd8fb08

