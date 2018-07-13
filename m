Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 309251F597
	for <e@80x24.org>; Mon, 16 Jul 2018 13:00:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730873AbeGPN1u (ORCPT <rfc822;e@80x24.org>);
        Mon, 16 Jul 2018 09:27:50 -0400
Received: from mail-pl0-f67.google.com ([209.85.160.67]:43831 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729881AbeGPN1u (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Jul 2018 09:27:50 -0400
Received: by mail-pl0-f67.google.com with SMTP id o7-v6so4850247plk.10
        for <git@vger.kernel.org>; Mon, 16 Jul 2018 06:00:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=tSR1oI0NZ3Q+d54t9YeAFaicFMwnOxW5g80LFqu/Ds8=;
        b=ifsDbAgrERoU81COrXTWg1vOiB5F2Lu/x4Sy2mtYkr8kKq/YDZvStWuNw0bRF/S2cz
         5u5dO/J8EgWxc1JKPl0eXkvNAydO6eu36jegHM0INVibwNm7vvqFhL4bla/rSUFfS/HD
         V6RhGb0hryciJ8nolywkHwxgRHu+1oQPcS1TQVhcQ9CxnfVehKXz8d3P0tGYrwvZ86Aw
         uIS93jlydyi2Ga7P4B1LlYQCaggjV/Ty/N/yymwZEgCp4+s0ZLaLWyq6on4U9oAq7zEo
         FbH0xyjm2dyACiL0Gz0061+amBbl12X3TyaPvXHEK5gJDgbu2JnO8Zvs1oBbR+EoXsMB
         99tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=tSR1oI0NZ3Q+d54t9YeAFaicFMwnOxW5g80LFqu/Ds8=;
        b=nYNH/ecQAQSQ64NemnN9RmD5lfACKFKkU80OJp3R4dc08/5DPOCRF60LFMMlSWXVsb
         WM4J2SLXu5NhyLpqKQRkc3evP1IeSkVAg/wGFfC9plMCK+Ck9yIJAn1i/C8g3Ni70I6Z
         ceBoosYQtYGhXhJrX29tFNXN0mhfzOwiLvevzgL19hFQjRCyLS5W3l2lbPE7iyBMSfib
         zQe/tVk4O+y61TXdoy3SFiQ1FSiFi99+6u6B4PUBuL4dpSK+3MIP7gHKhpZoxC4xZxMT
         Cn2spRH+1GA//kI9dEYtl5i+wd0fl4EXn3LpXL4QIh0AHFHoXenunrsiJcG975s6jWYg
         ZkAQ==
X-Gm-Message-State: AOUpUlFHKnNgEyxuaD0v/cef07GXDI7w/riwtlB5EI9DdE/O07lYpeUi
        JB9yp7n8+urtGq1MuefPfsXs2A==
X-Google-Smtp-Source: AAOMgpdP5aj1m1OOfj/RwTFjUqYD7sHR+Hxw41mgKAgKtvvFhawmF505q0ZvePZ3dMDKLMrLlD7ECQ==
X-Received: by 2002:a17:902:2887:: with SMTP id f7-v6mr15792732plb.150.1531746029323;
        Mon, 16 Jul 2018 06:00:29 -0700 (PDT)
Received: from [127.0.0.1] ([40.112.139.85])
        by smtp.gmail.com with ESMTPSA id 70-v6sm4382423pfz.55.2018.07.16.06.00.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 16 Jul 2018 06:00:28 -0700 (PDT)
Message-Id: <074a9e04c980fabf73d0d042f96fc2c13429f9b5.1531746011.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.10.git.gitgitgadget@gmail.com>
References: <pull.10.git.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 13 Jul 2018 10:38:44 -0400
Subject: [PATCH 10/16] test-reach: test is_descendant_of
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

The is_descendant_of method takes a single commit as its first parameter
and a list of commits as its second parameter. Extend the input of the
'test-tool reach' command to take multiple lines of the form
"X:<committish>" to construct a list of commits. Pass these to
is_descendant_of and create tests that check each result.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 t/helper/test-reach.c |  8 ++++++++
 t/t6600-test-reach.sh | 22 ++++++++++++++++++++++
 2 files changed, 30 insertions(+)

diff --git a/t/helper/test-reach.c b/t/helper/test-reach.c
index 29104d41a..149e8f32c 100644
--- a/t/helper/test-reach.c
+++ b/t/helper/test-reach.c
@@ -9,6 +9,7 @@ int cmd__reach(int ac, const char **av)
 {
 	struct object_id oid_A, oid_B;
 	struct commit *A, *B;
+	struct commit_list *X;
 	struct strbuf buf = STRBUF_INIT;
 	struct repository *r = the_repository;
 
@@ -18,6 +19,7 @@ int cmd__reach(int ac, const char **av)
 		exit(1);
 
 	A = B = NULL;
+	X = NULL;
 
 	while (strbuf_getline(&buf, stdin) != EOF) {
 		struct object_id oid;
@@ -53,6 +55,10 @@ int cmd__reach(int ac, const char **av)
 				B = c;
 				break;
 
+			case 'X':
+				commit_list_insert(c, &X);
+				break;
+
 			default:
 				die("unexpected start of line: %c", buf.buf[0]);
 		}
@@ -63,6 +69,8 @@ int cmd__reach(int ac, const char **av)
 		printf("%s:%d\n", av[1], ref_newer(&oid_A, &oid_B));
 	else if (!strcmp(av[1], "in_merge_bases"))
 		printf("%s(A,B):%d\n", av[1], in_merge_bases(A, B));
+	else if (!strcmp(av[1], "is_descendant_of"))
+		printf("%s(A,X):%d\n", av[1], is_descendant_of(A, X));
 
 	exit(0);
 }
diff --git a/t/t6600-test-reach.sh b/t/t6600-test-reach.sh
index d065f2602..99444e0f7 100755
--- a/t/t6600-test-reach.sh
+++ b/t/t6600-test-reach.sh
@@ -101,4 +101,26 @@ test_expect_success 'in_merge_bases:miss' '
 	test_three_modes in_merge_bases
 '
 
+test_expect_success 'is_descendant_of:hit' '
+	cat >input <<-\EOF &&
+		A:commit-5-7
+		X:commit-4-8
+		X:commit-6-6
+		X:commit-1-1
+	EOF
+	printf "is_descendant_of(A,X):1\n" >expect &&
+	test_three_modes is_descendant_of
+'
+
+test_expect_success 'is_descendant_of:miss' '
+	cat >input <<-\EOF &&
+		A:commit-6-8
+		X:commit-5-9
+		X:commit-4-10
+		X:commit-7-6
+	EOF
+	printf "is_descendant_of(A,X):0\n" >expect &&
+	test_three_modes is_descendant_of
+'
+
 test_done
-- 
gitgitgadget

