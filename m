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
	by dcvr.yhbt.net (Postfix) with ESMTP id D59701F4C0
	for <e@80x24.org>; Wed, 23 Oct 2019 12:03:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405188AbfJWMDz (ORCPT <rfc822;e@80x24.org>);
        Wed, 23 Oct 2019 08:03:55 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:33367 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731954AbfJWMDy (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Oct 2019 08:03:54 -0400
Received: by mail-pf1-f194.google.com with SMTP id c184so3292534pfb.0
        for <git@vger.kernel.org>; Wed, 23 Oct 2019 05:03:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=nPWh7QlMWSMmxFHZ7OJjCopz5RbVH9kV7e0OwLhMHbM=;
        b=rD3BErUVuvGZZCY25nRcliPbWd4lDCaHXbNGT51Z7Ip4GRdaEBa3M6v8Q9LW4AVPE1
         h9Jx0tAI5+hQvg5Ul5YPAlopPtMzqtz1QzXgmPUFyu6eIq16+B6VMuwZh/DQ2HdNH7XH
         UT9ZU4K/yVGeoEb3hGZDC5dm8y5pVO8IufwRTjeYhd5z6dJwG3yxJ1avrCb0ePpM2ZcX
         tnjc2lOxKA1We9yPH7YaznG85l3tcnnUTe68D1QKDYCC4zzf3stbpkPJoqx2qBPLurRr
         SuCZ8ynTc55EuvakaD6SjPLBxLbkfiBNtak/IfiBhmk1bY+wy+12wiXCLGsyeI4BONmG
         iNHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=nPWh7QlMWSMmxFHZ7OJjCopz5RbVH9kV7e0OwLhMHbM=;
        b=JqeklbsOWvItxCOljFcHnm/1atyyJ6bZ5KAl0Ig0dmigz273X8jksDbShCa0jii1uX
         MX3aAJnGs046RGTr7l+bm7VfmMSE7zy1qiVIlnZzcHXAVHdtS9bxabJwFWW94dwlijyX
         fG1i3IfTis4/oxqHxJm8YGGUCoCBgOV5SVWz4BbdW7KzVaC1rU55VrHNmTG3GikNOz/7
         ZF1BjZcNpXKDmzeheU40eqVl1Y6rJ2HivzcWh9vR0V97yTAwg7xJlzQa3zDTHe1gxFzB
         bcdDOQBxJFoMS6MDbVYRpyJA5h8EnJ/htPojsu7g7QQU2jrvQ3FEGFejmPmhkCllID3u
         pgOg==
X-Gm-Message-State: APjAAAVTlNerEu9MVn5SlEZ1fCsL1TyhaFq/68weYi2anQmd7IJ7uEWp
        HCbG4TEGsJORTgDIhHGmnp3P7UQV
X-Google-Smtp-Source: APXvYqw+ZqFBah28NcT5eOhLPEpxIZI+qcc4hIjbxwSlKpdL5dhSU5nd5p7eJNO5qf5lpIms6Vcyiw==
X-Received: by 2002:a17:90a:cf97:: with SMTP id i23mr11182866pju.77.1571832233389;
        Wed, 23 Oct 2019 05:03:53 -0700 (PDT)
Received: from generichostname ([2601:646:280:1b30:80db:d816:4d15:ae2a])
        by smtp.gmail.com with ESMTPSA id j24sm22770368pff.71.2019.10.23.05.03.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Oct 2019 05:03:52 -0700 (PDT)
Date:   Wed, 23 Oct 2019 05:03:51 -0700
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 2/5] t4108: remove git command upstream of pipe
Message-ID: <9d915748c1953cc2683fa3189c3c98b1e9a1e299.1571832176.git.liu.denton@gmail.com>
References: <cover.1571832176.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1571832176.git.liu.denton@gmail.com>
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
it to print_sanitized_diff().

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 t/t4108-apply-threeway.sh | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/t/t4108-apply-threeway.sh b/t/t4108-apply-threeway.sh
index b109ecbd9f..49739ce8b4 100755
--- a/t/t4108-apply-threeway.sh
+++ b/t/t4108-apply-threeway.sh
@@ -4,11 +4,12 @@ test_description='git apply --3way'
 
 . ./test-lib.sh
 
-sanitize_conflicted_diff () {
+print_sanitized_diff () {
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
+	print_sanitized_diff >expect.diff &&
 
 	# should fail to apply
 	git reset --hard &&
 	git checkout master^0 &&
 	test_must_fail git apply --index --3way P.diff &&
 	git ls-files -s >actual.ls &&
-	git diff HEAD | sanitize_conflicted_diff >actual.diff &&
+	print_sanitized_diff >actual.diff &&
 
 	# The result should resemble the corresponding merge
 	test_cmp expect.ls actual.ls &&
@@ -114,7 +115,7 @@ test_expect_success 'apply -3 with add/add conflict setup' '
 	git checkout adder^0 &&
 	test_must_fail git merge --no-commit another &&
 	git ls-files -s >expect.ls &&
-	git diff HEAD | sanitize_conflicted_diff >expect.diff
+	print_sanitized_diff >expect.diff
 '
 
 test_expect_success 'apply -3 with add/add conflict' '
@@ -124,7 +125,7 @@ test_expect_success 'apply -3 with add/add conflict' '
 	test_must_fail git apply --index --3way P.diff &&
 	# ... and leave conflicts in the index and in the working tree
 	git ls-files -s >actual.ls &&
-	git diff HEAD | sanitize_conflicted_diff >actual.diff &&
+	print_sanitized_diff >actual.diff &&
 
 	# The result should resemble the corresponding merge
 	test_cmp expect.ls actual.ls &&
-- 
2.24.0.rc0.197.g0926ab8072

