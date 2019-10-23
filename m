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
	by dcvr.yhbt.net (Postfix) with ESMTP id BFF991F4C0
	for <e@80x24.org>; Wed, 23 Oct 2019 23:32:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408045AbfJWXcg (ORCPT <rfc822;e@80x24.org>);
        Wed, 23 Oct 2019 19:32:36 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:43965 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2408036AbfJWXcg (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Oct 2019 19:32:36 -0400
Received: by mail-pg1-f193.google.com with SMTP id l24so8110536pgh.10
        for <git@vger.kernel.org>; Wed, 23 Oct 2019 16:32:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=2/nXqdMV8csPSlFhj2q6znfLQ3y9pzAG2dcfAuHj8qg=;
        b=WV5S6QxDUpDvWQxZPEu0Mi+/2y7GJHAIr6DCyLwYFdTnubmDuAZVFYuf/dDFCpQtah
         hACG4yIm2pa/WzYODcDtEDDj7OfiN+ajPwSMj/A1pGd9ma9wAszDgf0/6x0+MDxnmsvy
         VIR4+Ks+G+mAfYg2UJOba3UuGPqcbyDY70LsUTkONli1LqVheG0FrvNEktup03GnDJns
         KEncFktAP2XBImZ+tQ5Gf6Y8a5E6uikUcTNsrhkmPTAtDdvAQULuIMLBPz5rNhvUqJb2
         RpinFxFocRlFwXW+j/CKhZ90ts2C/QbKMrKiZG9RF0Y7kqWhdYzXi8FpOW/CPzT5Grrs
         eL5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=2/nXqdMV8csPSlFhj2q6znfLQ3y9pzAG2dcfAuHj8qg=;
        b=qdEzC8j/i/Zs+ifBX4GGQ79X4jOUWAtH4iUrlhh3/hpPSJL0HLez2zEhujXf8uJu1q
         BN4Gr+RPGw/rZjM0J6JWwVQtysjWnxHRg1VErxwmb1VppddHBI9uPo7s7StEphxVyMKZ
         cCizAxrDhydaiVXkJ59ImMJefDTKDx2Gq4nugsUnk7Vzx/PL7JhnzVnZiqPjsWGIVun5
         lBa467kUcMD9jpoGxEQXLbd63uDki56rRo7wYp/Nw7wt2I0OQBcY4V1xM2GUpaLAfvHe
         ACTo3NvF6NX0kRsK4J6700UM76GXPhXk161occuag8HKwUHoipRcLatitWCO7HQC0N1N
         Zt7A==
X-Gm-Message-State: APjAAAUKVyEjtqtCG5qIirKYOgVVH/vdXcgq5f/QN7IUfzL/mgFjt1DZ
        lCuZLz+aMHMi0n0cRdeTtM1DOxo8
X-Google-Smtp-Source: APXvYqyXv0TVjnrKHetrWgFUwqYEnDT/tyifaARlpYQ9WnklVfSkAKurUO9o7OPDQGrzC0S8EJBlaQ==
X-Received: by 2002:a62:1517:: with SMTP id 23mr698930pfv.236.1571873553793;
        Wed, 23 Oct 2019 16:32:33 -0700 (PDT)
Received: from generichostname ([204.14.239.55])
        by smtp.gmail.com with ESMTPSA id c1sm235568pjc.23.2019.10.23.16.32.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Oct 2019 16:32:33 -0700 (PDT)
Date:   Wed, 23 Oct 2019 16:32:31 -0700
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v2 2/5] t4108: remove git command upstream of pipe
Message-ID: <fd1b770c0cd466acec8bfd2b0f202cfef758a0e1.1571873435.git.liu.denton@gmail.com>
References: <cover.1571832176.git.liu.denton@gmail.com>
 <cover.1571873435.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1571873435.git.liu.denton@gmail.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Before, the output of `git diff HEAD` would always be piped to
sanitize_conflicted_diff(). However, since the Git command was upstream
of the pipe, in case the Git command fails, the return code would be
lost. Rewrite into separate statements so that the return code is no
longer lost.

Since only the command `git diff HEAD` was being piped to
sanitize_conflicted_diff(), move the command into the function and rename
it to print_sanitized_conflicted_diff().

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 t/t4108-apply-threeway.sh | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/t/t4108-apply-threeway.sh b/t/t4108-apply-threeway.sh
index b109ecbd9f..3c0ddacddf 100755
--- a/t/t4108-apply-threeway.sh
+++ b/t/t4108-apply-threeway.sh
@@ -4,11 +4,12 @@ test_description='git apply --3way'
 
 . ./test-lib.sh
 
-sanitize_conflicted_diff () {
+print_sanitized_conflicted_diff () {
+	git diff HEAD >diff.raw &&
 	sed -e '
 		/^index /d
 		s/^\(+[<>][<>][<>][<>]*\) .*/\1/
-	'
+	' diff.raw
 }
 
 test_expect_success setup '
@@ -54,14 +55,14 @@ test_expect_success 'apply with --3way' '
 	git checkout master^0 &&
 	test_must_fail git merge --no-commit side &&
 	git ls-files -s >expect.ls &&
-	git diff HEAD | sanitize_conflicted_diff >expect.diff &&
+	print_sanitized_conflicted_diff >expect.diff &&
 
 	# should fail to apply
 	git reset --hard &&
 	git checkout master^0 &&
 	test_must_fail git apply --index --3way P.diff &&
 	git ls-files -s >actual.ls &&
-	git diff HEAD | sanitize_conflicted_diff >actual.diff &&
+	print_sanitized_conflicted_diff >actual.diff &&
 
 	# The result should resemble the corresponding merge
 	test_cmp expect.ls actual.ls &&
@@ -114,7 +115,7 @@ test_expect_success 'apply -3 with add/add conflict setup' '
 	git checkout adder^0 &&
 	test_must_fail git merge --no-commit another &&
 	git ls-files -s >expect.ls &&
-	git diff HEAD | sanitize_conflicted_diff >expect.diff
+	print_sanitized_conflicted_diff >expect.diff
 '
 
 test_expect_success 'apply -3 with add/add conflict' '
@@ -124,7 +125,7 @@ test_expect_success 'apply -3 with add/add conflict' '
 	test_must_fail git apply --index --3way P.diff &&
 	# ... and leave conflicts in the index and in the working tree
 	git ls-files -s >actual.ls &&
-	git diff HEAD | sanitize_conflicted_diff >actual.diff &&
+	print_sanitized_conflicted_diff >actual.diff &&
 
 	# The result should resemble the corresponding merge
 	test_cmp expect.ls actual.ls &&
-- 
2.24.0.rc0.197.g0926ab8072

