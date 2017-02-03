Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8327D1FAF4
	for <e@80x24.org>; Fri,  3 Feb 2017 02:49:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752107AbdBCCtS (ORCPT <rfc822;e@80x24.org>);
        Thu, 2 Feb 2017 21:49:18 -0500
Received: from mail-wm0-f66.google.com ([74.125.82.66]:33823 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751771AbdBCCtR (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Feb 2017 21:49:17 -0500
Received: by mail-wm0-f66.google.com with SMTP id c85so1187153wmi.1
        for <git@vger.kernel.org>; Thu, 02 Feb 2017 18:49:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kRJDCob9S2nGRv62lc7i/X4tVvnj1bv8lR9PY1IUv+4=;
        b=bLy0y6ZIYJbDTcpCmev0sf3C9m2VsRVSbHkN437us4JD5R83rprSr9oJ7DBdBHc4yr
         yhkSeFvdS749DOG5x42GsXjM6I0jo4mkE/uhzu+mzAMXIC8yn1Rm/cLr0Iec+pr+KV1C
         HovkKx5styrbedlUXgjvLOD9jRv+TsxzzlT/CtysPHyVSj8PTpPvNM8ZyDIZufiBgRPt
         jRi9DjksvxUQV29Y6xle5sTQSf/8aQRKDNE0sKb4zlByqX/0sJ8CdkWOKRc+40g6GKiz
         nW10RHF/i/twydFXGG6ZuNK2LlpO1koy03IdO8LuRuLWwrvB/Oo1dlFI+96oWavN7QQD
         Q/SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kRJDCob9S2nGRv62lc7i/X4tVvnj1bv8lR9PY1IUv+4=;
        b=j2zGLy20W1//bG3yq2NZmPtwbX47JZFjYys/81lEbjflzma5uKOZuMuh/EGeuvamLT
         10ut7W8r7zZfq8iVP1/lG3M2fi9/2PaNit+toCqTAFJno4cB7lzM53quSZNVn3y2pjCJ
         /PoLGZXuXKRf1Z9mjSsYiCEh7DTgTs2uy7hVGjIZPnX1MmcRSzlGJ88GW1Z3QA/SuBr0
         ABi/a3X0yO+1n55opiCMh0h0CgfLeVR8EOqTfOAGU1gwhjoaBr9Yv9eNuUjAQHjzCFox
         tp2m/XHbnqippaWKxQLEQFcvMxFiIfJFb7bKMbtAFs2f4ZfqtkrRKX0j0HFEZdSkofbR
         JQ/g==
X-Gm-Message-State: AMke39m6Z/EDfiox2VwHNBdBwfDNSN9ORDbGrb0fx+LDYQe9utqSNG1zEPHsEsp0Jqt7wA==
X-Received: by 10.28.230.194 with SMTP id e63mr466602wmi.25.1486090155673;
        Thu, 02 Feb 2017 18:49:15 -0800 (PST)
Received: from localhost.localdomain (x590d744d.dyn.telefonica.de. [89.13.116.77])
        by smtp.gmail.com with ESMTPSA id k43sm42867464wrc.46.2017.02.02.18.49.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 02 Feb 2017 18:49:15 -0800 (PST)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCHv2 02/21] completion tests: don't add test cruft to the test repository
Date:   Fri,  3 Feb 2017 03:48:10 +0100
Message-Id: <20170203024829.8071-3-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.11.0.555.g967c1bcb3
In-Reply-To: <20170203024829.8071-1-szeder.dev@gmail.com>
References: <20170203024829.8071-1-szeder.dev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

While preparing commits, three tests added newly created files to the
index using 'git add .', which added not only the files in question
but leftover test cruft from previous tests like the files 'expected'
and 'actual' as well.  Luckily, this had no effect on the tests'
correctness.

Add only the files we are actually interested in.

Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
---
 t/t9902-completion.sh | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/t/t9902-completion.sh b/t/t9902-completion.sh
index a34e55f87..f490c1d05 100755
--- a/t/t9902-completion.sh
+++ b/t/t9902-completion.sh
@@ -486,7 +486,7 @@ test_expect_success 'git --help completion' '
 test_expect_success 'setup for ref completion' '
 	echo content >file1 &&
 	echo more >file2 &&
-	git add . &&
+	git add file1 file2 &&
 	git commit -m one &&
 	git branch mybranch &&
 	git tag mytag
@@ -517,7 +517,7 @@ test_expect_success '<ref>: completes paths' '
 
 test_expect_success 'complete tree filename with spaces' '
 	echo content >"name with spaces" &&
-	git add . &&
+	git add "name with spaces" &&
 	git commit -m spaces &&
 	test_completion "git show HEAD:nam" <<-\EOF
 	name with spaces Z
@@ -526,7 +526,7 @@ test_expect_success 'complete tree filename with spaces' '
 
 test_expect_success 'complete tree filename with metacharacters' '
 	echo content >"name with \${meta}" &&
-	git add . &&
+	git add "name with \${meta}" &&
 	git commit -m meta &&
 	test_completion "git show HEAD:nam" <<-\EOF
 	name with ${meta} Z
-- 
2.11.0.555.g967c1bcb3

